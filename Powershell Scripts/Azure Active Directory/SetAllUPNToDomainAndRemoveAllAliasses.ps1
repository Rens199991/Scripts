
#Part 1 set All UPN to default onmicrosoft.com
#Connect to your Azure AD tenant
Connect-AzureAD
Connect-ExchangeOnline

#Define the new UPN domain
$newUPNDomain = "Macbeneu.onmicrosoft.com"

#Get a list of users you want to update
$usersToUpdate = Get-AzureADUser -All $true | Where-Object { $_.UserPrincipalName -notlike "*$newUPNDomain" }

#Loop through each user and update their UPN
foreach ($user in $usersToUpdate) 
    {
    $currentUPN = $user.UserPrincipalName
    $newUPN = $user.UserPrincipalName.Split("@")[0] + "@" + $newUPNDomain

    #Set the new UPN for the user
    Set-AzureADUser -ObjectId $user.ObjectId -UserPrincipalName $newUPN

    Write-Host "Updated UPN for $($user.DisplayName) from $currentUPN to $newUPN"
    }




#Part 2 set Remove all e-mail aliassen
#Get all mailboxes
$Mailboxes = Get-Mailbox -ResultSize Unlimited

#Loop through each mailbox
foreach ($Mailbox in $Mailboxes) 
    {

    #Change to the domain that you want to remove
    $Mailbox.EmailAddresses | Where-Object { ($_ -clike "smtp*") -and ($_ -like "*betonadvies.com") } | 

    # Perform operation on each item, Do not change the brackets or the script wil fail!!
    ForEach-Object {
        #Remove the -WhatIf parameter after you tested and are sure to remove the secondary email addresses
        Set-Mailbox $Mailbox.DistinguishedName -EmailAddresses @{remove = $_ } 

        #Write output
        Write-Host "Removing $_ from $Mailbox Mailbox" -ForegroundColor Green
                   }
    }





#Andere Manier
<#
Verwijderen

Connect-MsolService
Connect-ExchangeOnline
Get-EXOMailbox "USERPRINCIPALNAME"  | select -ExpandProperty emailaddresses | Select-String -Pattern "smtp"
Set-Mailbox "USERPRINCIALNAME" -EmailAddresses @{remove="ALIAS"}

Toevoegen

Connect-MsolService
Connect-ExchangeOnline
Get-EXOMailbox "USERPRINCIPALNAME"  | select -ExpandProperty emailaddresses | Select-String -Pattern "smtp"
Set-Mailbox "francis@uny-group.be" -EmailAddresses @{add="test@uny-group.be"}


Handige Site zodat je de code niet manueel moet typen in Powershell: https://www.tachytelic.net/2018/12/add-remove-email-alias-powershell/
Vergeet niet om de admin een super user te maken
#>