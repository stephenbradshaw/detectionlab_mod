#Import active directory module for running AD cmdlets
Import-Module activedirectory


New-ADOrganizationalUnit -Name "Accounting" -Path "DC=windomain,DC=local"
New-ADOrganizationalUnit -Name "Facilities" -Path "DC=windomain,DC=local"
New-ADOrganizationalUnit -Name "Personnel" -Path "DC=windomain,DC=local"
New-ADOrganizationalUnit -Name "IT" -Path "DC=windomain,DC=local"
New-ADOrganizationalUnit -Name "Marketing" -Path "DC=windomain,DC=local"
New-ADOrganizationalUnit -Name "Sales" -Path "DC=windomain,DC=local"
New-ADOrganizationalUnit -Name "Executive" -Path "DC=windomain,DC=local"


