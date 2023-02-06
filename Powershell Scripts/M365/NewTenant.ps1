#DEEL 1 Opzetten Tenant
#Connectie Maken en Gegevens opvragen
clear-Host
Get-PSSession | Remove-PSSession
$cred = Get-Credential
Connect-MsolService -Credential $cred
Connect-ExchangeOnline -Credential $cred
Write-Host "`n"
$TenantId = (Get-MSOLCompanyInformation).objectid.guid
$TenantName = (Get-MsolCompanyInformation).Displayname
$addpath = "C:\Users\rens.sergier\Google Drive\Rens\Projects\Powershell Scripts\PowersShell 5 Scripts\addusers.csv"
$Exportpath = "C:\Users\rens.sergier\Downloads\"
Write-Host ""
Write-Host "We werken nu in Tenant" $TenantName "met als TenantID" $TenantId  -ForegroundColor DarkCyan
Write-Host ""
Write-Host "Geverifieërde Domeinen:" -ForegroundColor Green
Get-MsolDomain | Select-Object Name, Status | Format-Table | Out-Host
Write-Host "Aantal Licenties:" -ForegroundColor Green
Get-MsolAccountSku | Sort-Object -Property "ActiveUnits" -Descending | Out-Host
Write-Host "Users en eventuele licenties:" -ForegroundColor Green 
$Allusers = Get-MsolUser
$Tabel = foreach ($User in $AllUsers) 
{
             [pscustomobject]@{
                   UPN = $User.userprincipalname
                   DisplayName = $User.Displayname
                   License = (Get-MsolUser -UserPrincipalName $User.UserPrincipalName).Licenses.AccountSKuId
                   IsLicensed = $User.IsLicensed
                              }
}
$Tabel = $Tabel | Sort-Object UPN | Format-Table
$Tabel | Out-Host


#Displaynaam van Administrator veranderen naar Admin | AlfaSolutions en Emergency Admin maken
$DomeinEmegergencyadmin = (Get-OrganizationConfig).name
$AdminUPN = $cred.UserName
$NewDisplaynameAdmin = "Admin | AlfaSolutions"
$NewDisplaynameEmergencyAdmin = "Emergency Admin | Alfa Solutions"
$UpnEmergencyadmin = "Emergencyadmin@" + $DomeinEmegergencyadmin
Set-MsolUser -UserPrincipalname $AdminUPN -DisplayName $NewDisplaynameAdmin
Write-Host "Wachtwoord voor Emergency Admin, zie hieronder" -ForegroundColor Green
New-MsolUser -UserPrincipalName $UpnEmergencyAdmin -DisplayName $NewDisplaynameEmergencyAdmin -StrongPasswordRequired $True -ForceChangePassword $False | Out-Host
Add-MsolRoleMember -RoleName "Company Administrator" -RoleMemberEmailAddress $UpnEmergencyAdmin 

#Domeinverificatie
$Domeinnaam = Read-Host "Welk Domein wilt u verifiëren?"
New-MsolDomain -Name $Domeinnaam -Authentication Managed 
Get-MsolDomainVerificationDNS -TenantId $TenantID -DomainName $Domeinnaam -Mode DnsTxtRecord | Select-Object Text, Ttl | Format-List
Start-Sleep -Seconds 15
while ((Get-MsolDomain -DomainName $Domeinnaam).Status -eq "Unverified") 
{
    Write-Host "Domein is nog niet geverifieeërd, we proberen het opnieuw" -ForegroundColor Yellow
    Start-Sleep -Seconds 15
    Confirm-MsolDomain -DomainName $Domeinnaam -ErrorAction Silentlycontinue | Out-Host
}
Write-Host "`n"
Write-Host "Domein is geverifieeërd" -ForegroundColor Green| Out-Host
Set-MsolDomain -Name $Domeinnaam -IsDefault

#Organisatieinstellingen bijwerken zodat we onze aanpassingen kunnen doen
#Opgepast, dit kan problemen geven als er meerdere admins zijn die Super user zijn.
#Om dit probleem te verhelpen moet je de aangemaakte tweede admin heel verwijderen en enkel de global admin role geven aan de originele tenant admin, dan dag wachten en dan lukt het wel. 
Enable-OrganizationCustomization
while ((Get-OrganizationConfig).IsDehydrated -eq $true) 
    {
    Write-Host $TenantName "is nog niet klaar om aangepast te worden, we proberen het opnieuw." -ForegroundColor Yellow
    Start-Sleep -Seconds 60
    Enable-OrganizationCustomization
    }
Write-Host $TenantName "is klaar om aangepast te worden" -ForegroundColor Green 


#Alle Users aanmaken in de tenant, opppasen in csv dat alles clear is en geen spaties na UPN!
#Oppassen dat er ook geen spatie is na de comma tussen de 2 licenties
$CreateUsers = read-host "Wilt u beginnen met de Users aan te maken? Typ Ja indien u dit wenst"
if($CreateUsers -eq "Ja") 
{
#continuescript
} 
else
{
    return
} 

$AddCsvUsers = Import-Csv $addpath
$PasswordsArray = @()
foreach ($User in $AddCsvUsers)
{
    if ($User.Type -ne "Shared") 
    {
        try
        {
        $PasswordNewUser = New-MsolUser -UserPrincipalName $User.UserPrincipalName -DisplayName $User.DisplayName -LicenseAssignment ($User.LicenseAssignment -split ',') -UsageLocation "BE" -ForceChangePassword $false -ErrorAction stop
        Write-Host $User.UserPrincipalName "is aangemaakt met als wachtwoord" $PasswordNewUser.Password -ForegroundColor Green
        $PasswordsArray += $PasswordNewUser.Password
        }
    catch
        {
        Write-Host "Niet gelukt om" $User.UserPrincipalName "aan te maken" -ForegroundColor DarkMagenta
        Write-Host $_ -ForegroundColor DarkMagenta
        }  
    }       

}

$PasswordsArray
$Exportcsv = foreach ($User in $AddCsvUsers)
{
        
            if ($User.Alias -eq "") 
                {  
                    [pscustomobject]@{
                        Title = "O365 User"
                        UserName = $User.UserPrincipalName       
                        Description = ""
                        Notes = ""
                        Password = $PasswordsArray[0]
                        ExpiryDate = ""
                                    }
                $PasswordsArray = $PasswordsArray[1..($PasswordsArray.Length-1)]
                }
            else 
                {
                    [pscustomobject]@{
                        Title = "O365 User"
                        UserName = $User.Alias        
                        Description = ""
                        Notes = ""
                        Password = $PasswordsArray[0]
                        ExpiryDate = ""
                                    }  
                $PasswordsArray = $PasswordsArray[1..($PasswordsArray.Length-1)]   
                }
        
}

$Exportcsv | Export-Csv -Path $Exportpath$TenantName"users.csv" -NoTypeInformation

#Aanmaak Shared Mailboxes, rechten toekennen in portaal:
$AddCsvUsers = Import-Csv $addpath
foreach ($User in $AddCsvUsers)
{
    if ($User.Type -eq "Shared") 
    {
    New-Mailbox -Name $User.UserPrincipalName -DisplayName $user.DisplayName -Shared
    Start-Sleep -Seconds 30Ja
    Set-mailbox -Identity $User.UserPrincipalName  -MessageCopyForSendOnBehalfEnabled $True -MessageCopyForSentAsEnabled $True
    }
}

#Global Admin, Super User maken
$AdminUPN = $cred.UserName
$AllO365andAADRoles = (Get-MsolRole | Where-Object{$_.Name -ne "Company Administrator"}).name
$AllExchangeRoles = (Get-ManagementRole | Where-Object {$_.Name -ne "O365SupportViewConfig"}).name
foreach ($role in $AllO365andAADRoles)
{
    Add-MsolRoleMember -RoleName $role -RoleMemberEmailAddress $AdminUPN -ErrorAction Silentlycontinue 
    Write-Host $role "Azure AD Role toegevoegd voor" $AdminUPN -ForegroundColor Yellow
}
#Exchange Admin Roles
foreach($role in $AllExchangeRoles)
    {
        New-RoleGroup -Name "Exchange Super User" -Description "Super User Role for Exchange" -Members $AdminUPN -Roles $AllExchangeRoles -ErrorAction SilentlyContinue
        Write-Host $role "Exchange Role toegevoegd voor" $AdminUPN -ForegroundColor DarkBlue
    }
#Security & Complaince Admin Roles
Connect-IPPSSession -UserPrincipalName $cred.UserName -ErrorAction Stop
Start-Sleep -Seconds 10
$AllSecurityandComplianceRoles = (Get-ManagementRole).Name
    foreach($role in $AllSecurityandComplianceRoles)
        {
        New-RoleGroup -Name "Security and Compliance Super User" -Description "Super User Role for Security and Compliancy" -Members $AdminUPN -Roles $AllSecurityandComplianceRoles -ErrorAction SilentlyContinue
        Write-Host $role "Security and Compliance Role is toegevoegd voor" $AdminUPN -ForegroundColor Cyan
        }

#Mailboxen in het nederlands plaatsen en controle op aliassen
$AantalMailboxen = Read-Host "Hoeveel Mailboxen zijn er in totaal"
$AantalMailboxen = [int]$AantalMailboxen
$AantalMailboxen +=1
Do
{
    foreach ($User in $AddCsvUsers) 
    {
        Set-MailboxRegionalConfiguration -Identity $User.UserPrincipalName -Language nl-be -LocalizeDefaultFolderName
    }

} Until ((Get-ExoMailbox).count -eq $AantalMailboxen) 
Write-Host "Mailboxen zijn aangemaakt en in het Nederlands geplaatst" -ForegroundColor Green




$StartSecureTenant = read-host "Wilt u beginnen met Tenant Secure te maken? Typ Ja indien u dit wenst"
if($StartSecureTenant -eq "Ja")
{
#Continue Script
}
else
{
    return
} 
    
#DEEL 2: Beveiligen Tenant
#Block guest can invite guests, niet mogelijk via powershell
#Corporate Branding Instellen, niet mogelijk via powershell
#Waarschuwinsbeleid, Niet Mogelijk via powershell!
#Indien Business Premium en fixed ip$: Conditional Acces instellen
#Indien Business Premium: Enable Continuous Acces


#Enable Unified Audit Log en Enable Mailbox Logging
Set-AdminAuditLogConfig -UnifiedAuditLogIngestionEnabled $true
Get-Mailbox | Set-Mailbox -AuditEnabled $True


#Block User Consent To Apps and to read others profile in Aad
Set-MsolCompanySettings -UsersPermissionToUserConsentToAppEnabled $False -UsersPermissionToReadOtherUsersEnabled $False
Get-MsolCompanyInformation | Format-List DisplayName,UsersPermissionToUserConsentToAppEnabled,UsersPermissionToReadOtherUsersEnabled

#Anti-Malware:
$DomeinNamenInTenant = (Get-MsolDomain).Name
New-MalwareFilterPolicy -Name "Malware Policy" -EnableInternalSenderNotifications $False -EnableInternalSenderAdminNotifications $false `
-ZapEnabled $true -Action DeleteMessage
New-MalwareFilterRule -Name "Malware Rule" -Enabled $true -MalwareFilterPolicy "Malware Policy" -Priority 0 -RecipientDomainIs $DomeinNamenInTenant
#EnableFileFilter is tijdelijk uitgeschakeld wegens fout (non compatible paramater)

#AntiSpam
Set-HostedOutboundSpamFilterPolicy -Identity Default -RecipientLimitExternalPerHour 200 -RecipientLimitInternalPerHour 1000 -RecipientLimitPerDay 1000 -ActionWhenThresholdReached BlockUser -AutoForwardingMode Off

#Indien ATP:
$ATP = Read-Host "Heeft de klant een Defender For Office licentie? Kies Ja/Nee" 
if ($ATP -eq "Ja") 
{
Connect-IPPSSession -UserPrincipalName $cred.UserName -ErrorAction Stop
#Safelinks
New-SafeLinksPolicy -Name "Defender for Office365 Policy" -IsEnabled $true -DoNotTrackUserClicks $true -DoNotAllowClickThrough $true `
-DeliverMessageAfterScan $true -EnableForInternalSenders $true -ScanUrls $True  <# Nog in Preview, manueel nog te doen -EnableSafeLinksForTeams $True #>
New-SafeLinksRule  -Name "Defender for Office365" -SafeLinksPolicy "Defender for Office365 Policy"`
 -Enabled $true -Priority 0 -RecipientDomainIs $DomeinNamenInTenant 
 
#Safe Attachments
New-SafeAttachmentPolicy -Name "Defender for Office365 Policy" -ActionOnError $False -Enable $True <# Nog in Preview, manueel nog te doen -EnableSafeLinksForTeams $True #>
New-SafeAttachmentRule -Name "Defender for Office365" -SafeAttachmentPolicy "Defender for Office365 Policy" `
-Enabled $true -Priority 0 -RecipientDomainIs $DomeinNamenInTenant    

#AntiPhishing
New-AntiPhishPolicy -Name "Defender for Office365 Policy" -Enabled $True -PhishThresholdLevel 2 -EnableUnauthenticatedSender $True -AuthenticationFailAction Quarantine `
-EnableOrganizationDomainsProtection $true -TargetedDomainProtectionAction Quarantine `
-ENableMailboxIntelligence $true -EnableMailboxIntelligenceProtection $True  -MailboxIntelligenceProtectionAction Quarantine `
-EnableSimilarDomainsSafetyTips $True -EnableSimilarUsersSafetyTips $True -EnableSpoofIntelligence $True -EnableUnusualCharactersSafetyTips $True
New-AntiPhishRule -Name "Defender for Office365" -AntiPhishPolicy "Defender for Office365 Policy"`
-Enabled $True -Priority 0 -RecipientDomainIs $DomeinNamenInTenant
}



$Dkimdomein = Read-Host "Voor welk domein wilt u de DKIM keys genereren?"
New-DkimSigningConfig -DomainName $Dkimdomein -Enabled $false
Start-Sleep -Seconds 10
Get-DkimSigningConfig -Identity $Dkimdomein | Format-List Selector1CNAME, Selector2CNAME

    while ((Get-DkimSigningConfig -Identity $Dkimdomein).Enabled -eq $false) 
        {
            Set-DkimSigningConfig -Identity $Dkimdomein -Enabled $True -ErrorAction Silentlycontinue
            Write-Host "DKIM is nog niet geverifiëerd, we proberen het opnieuw" -ForegroundColor Magenta
            Start-Sleep -Seconds 15
        }
        
Write-Host "Dkim is geverifieeërd" -ForegroundColor Green
Write-Host "Niet Vergeten DNS Records aan te passen (MX, SPF en Cname)" -ForegroundColor Green
Write-Host "WE ZIJN KLAAR!!!!!" -ForegroundColor Green

  


