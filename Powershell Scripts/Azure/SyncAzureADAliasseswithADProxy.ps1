Connect-MsolService
Connect-ExchangeOnline


$proxyaddresses = Get-Mailbox | Select-Object DisplayName,PrimarySmtpAddress,RecipientTypeDetails,@{Name=“EmailAddresses”;Expression={$_.EmailAddresses |Where-Object {$_ -LIKE “SMTP:*”}}}

foreach($user in $proxyaddresses)
{
    if($user.RecipientTypeDetails -eq "UserMailbox")
    {
        $upn = $user.PrimarySmtpAddress
        $null = $AdUser 
        $AdUser = Get-ADUser -filter { UserPrincipalName -eq $upn } -Properties proxyaddresses
        if($null -ne $AdUser ){
            $user.EmailAddresses
            foreach($mail in $user.EmailAddresses)
            {
                $sam = $AdUser.SamAccountName
                $smtp = [string]$mail
                Set-ADUser -Identity $sam -Add @{Proxyaddresses=$smtp}
            }
        }
    }
}