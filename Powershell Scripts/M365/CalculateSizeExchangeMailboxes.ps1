
#Runnen met Exchange Powershell Shell met Exchange Admin
$OutFile = "C:\temp\SharedMailboxreport.txt"
"DisplayName" + "^" + "Alias" + "^" + "SMTP" + "^" + "OU" + "^" + " Job Title" + "^" + "Database" + "^" + "TotalDeletedItemSize" + "^" + "TotalItemSize" + "^" + "Full Access" + "^" + "Send As" + "^" +"Send on Behalf" + "^" +"Delegates"  | Out-File $OutFile -Force
 
#$Mailboxes = Get-Mailbox -RecipientTypeDetails SharedMailbox -ResultSize:Unlimited | Select Identity, Alias, DisplayName, DistinguishedName
$Mailboxes = Get-Mailbox -ResultSize:Unlimited | Select-Object Identity, PrimarySMTPAddress, Alias, DisplayName, DistinguishedName, OrganizationalUnit, Database

$i= 0 

ForEach ($Mailbox in $Mailboxes) {
    $SendAs = Get-ADPermission $Mailbox.DistinguishedName | Where-Object {$_.ExtendedRights -like "Send-As" -and $_.User -notlike "NT AUTHORITY\SELF" -and !$_.IsInherited} | ForEach-Object {($_.User.RawIdentity).split("\")[1]}
	$FullAccess = Get-MailboxPermission $Mailbox.Identity | Where-Object {$_.AccessRights -eq "FullAccess" -and !$_.IsInherited} | ForEach-Object {($_.User.RawIdentity).split("\")[1]}
    
    $SendOnBehalfFound = Get-Mailbox $Mailbox.Identity | ForEach-Object { $_.GrantSendOnBehalfTo }
    $SendOnBehalfNames = $SendOnBehalfFound | ForEach-Object { $_.Name }
    $SendOnBehalString = $SendOnBehalfNames -Join ", "  


    $TotalDeletedItemSize = Get-MailboxStatistics $Mailbox.Identity | Select-Object TotalDeletedItemSize
    $TotalItemSize = Get-MailboxStatistics $Mailbox.Identity | Select-Object TotalItemSize

    $Title = Get-User $Mailbox.Alias | Select-Object Title

    $delegates = get-CalendarProcessing $Mailbox.Alias |Where-Object {$_.resourcedelegates -notlike “”} 
    $delegateNames = $delegates.ResourceDelegates | ForEach-Object { $_.Name } 
    $delegateString = $delegateNames -Join ", " 
 
	$Mailbox.DisplayName + "^" + $Mailbox.Alias + "^" + $Mailbox.PrimarySMTPAddress + '^' + $Mailbox.OrganizationalUnit + "^" + $Title.Title + "^" + $Mailbox.Database + "^" + $TotalDeletedItemSize.TotalDeletedItemSize + "^" + $TotalItemSize.TotalItemSize + "^" + $FullAccess + "^" + $SendAs + "^" + $SendOnBehalString + "^" + $delegateString  | Out-File $OutFile -Append

    Write-host -NoNewline " ,$i"
    $i++
}