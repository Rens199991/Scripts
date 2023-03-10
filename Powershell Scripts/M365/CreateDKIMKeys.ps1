Install-Module ExchangeOnlineManagement
Import-Module ExchangeOnlineManagement
Connect-Exchangeonline
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
