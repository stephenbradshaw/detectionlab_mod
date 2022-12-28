# https://github.com/davidprowe/BadBlood/blob/master/AD_OU_SetACL/Full%20Control%20Permissions.ps1
Import-Module ActiveDirectory
Set-Location AD:

###########################################################################################################
# SetAcl  $for ---- $right ----> $to
###########################################################################################################
Function SetAcl($for, $to, $right, $inheritance)
{
    $forSID = New-Object System.Security.Principal.SecurityIdentifier (Get-ADUser $for).SID
    $objOU = ($to).DistinguishedName
    $objAcl = get-acl $objOU
    # https://docs.microsoft.com/fr-fr/dotnet/api/system.directoryservices.activedirectoryrights?view=dotnet-plat-ext-5.0
    $adRight =  [System.DirectoryServices.ActiveDirectoryRights] $right # https://docs.microsoft.com/fr-fr/dotnet/api/system.directoryservices.activedirectoryrights?view=dotnet-plat-ext-5.0
    $type =  [System.Security.AccessControl.AccessControlType] "Allow" # https://docs.microsoft.com/fr-fr/dotnet/api/system.security.accesscontrol.accesscontroltype?view=dotnet-plat-ext-5.0
    $inheritanceType = [System.DirectoryServices.ActiveDirectorySecurityInheritance] $inheritance # https://docs.microsoft.com/fr-fr/dotnet/api/system.directoryservices.activedirectorysecurityinheritance?view=dotnet-plat-ext-5.0
    $ace = New-Object System.DirectoryServices.ActiveDirectoryAccessRule $forSID,$adRight,$type,$inheritanceType
    $objAcl.AddAccessRule($ace)
    Set-Acl -AclObject $objAcl -path $objOU
}


# genericall-genericwrite-write-on-computer
# https://www.ired.team/offensive-security-experiments/active-directory-kerberos-abuse/abusing-active-directory-acls-aces#genericall-genericwrite-write-on-computer
SetAcl (Get-ADUser $args[0]) (Get-ADComputer $args[1]) "GenericAll" "None"
