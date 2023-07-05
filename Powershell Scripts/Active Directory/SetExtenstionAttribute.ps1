#Import the Active Directory module
Import-Module ActiveDirectory

#specify the DistinguishedName of the target OU
$ou = "OU=Service Account,OU=Special Accounts,DC=mazars,DC=belgium"


#Retrieve all users in the specified OU
$users = Get-ADUser -Filter * -SearchBase $ou

#Display the list of users
foreach ($user in $users) 
    {
    Write-Output $user.Name
    }

#SetExtenstionAttributer
foreach ($user in $users) 
    {
    Set-ADUser $user -add @{extensionAttribute15 = "NoSync"}
    }

