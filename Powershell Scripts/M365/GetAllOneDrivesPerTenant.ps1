#TxtFile wordt opgeslaan in Downloads Map
#TenantUrl is de Sharepoint Admin Center Url
$TenantUrl = Read-Host "Enter the SharePoint admin center URL"
$TxtFile = "C:\Users\rsergier\Downloads\OneDriveSites.log"
Connect-SPOService -Url $TenantUrl
Get-SPOSite -IncludePersonalSite $true -Limit all -Filter "Url -like '-my.sharepoint.com/personal/'" | Select-Object -ExpandProperty Url | Out-File $TxtFile -Force
Write-Host "Done! File saved as $($TxtFile)."