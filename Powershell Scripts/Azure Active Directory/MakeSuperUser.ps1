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


#Global Admin, Super User maken, de ingelogde user waarmee je het script zal runnen zal een super user worden
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