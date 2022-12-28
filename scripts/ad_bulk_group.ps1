Import-Module activedirectory

$Groups = Import-csv c:\Tools\custom\groups.csv

foreach ($Group in $Groups) {
   $GroupName       = $Group.SamAccountName

    if (Get-ADGroup -F {SamAccountName -eq $GroupName}) {
         Write-Warning "A group with name $GroupName already exists in Active Directory."
    }
    else {

        # create a hashtable for splatting the parameters
        $groupProps = @{
            SamAccountName             = $Group.SamAccountName                   
            Name                       = $Group.Name
            GroupCategory              = $Group.GroupCategory
            GroupScope                 = $Group.GroupScope
            DisplayName                = $Group.DisplayName
            Path                       = $Group.Path      
            Description                = $User.Description
        }

         New-ADGroup @groupProps
       #  Write-Host "The group $Group is created." -ForegroundColor Cyan
   

    }
   
}
