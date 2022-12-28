# https://github.com/davidprowe/BadBlood/blob/master/AD_OU_SetACL/Full%20Control%20Permissions.ps1
Import-Module ActiveDirectory
Set-Location AD:

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

## acl values :
# AccessSystemSecurity
# CreateChild
# Delete
# DeleteChild
# DeleteTree
# ExtendedRight
# GenericAll
# GenericExecute
# GenericRead
# GenericWrite
# ListChildren
# ListObject
# ReadControl
# ReadProperty
# Self
# Synchronize
# WriteDacl
# WriteOwner
# WriteProperty 


# ACL abuse scenarios
# https://sensepost.com/blog/2020/ace-to-rce/
# https://www.ired.team/offensive-security-experiments/active-directory-kerberos-abuse/abusing-active-directory-acls-aces
# https://adsecurity.org/?p=3658

# write owner on group
# https://www.ired.team/offensive-security-experiments/active-directory-kerberos-abuse/abusing-active-directory-acls-aces#writeowner-on-group
SetAcl (Get-ADUser $args[0]) (Get-ADGroup $args[1]) "WriteOwner" "None"