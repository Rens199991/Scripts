$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\MDM"
New-Item -Path $registryPath
$Name = "AutoEnrollMDM"
$Name2 = "UseAADCredentialType"
$value = "1"
new-ItemProperty -Path $registryPath -Name $name -Value $value -PropertyType DWORD -Force | Out-Null
new-ItemProperty -Path $registryPath -Name $name2 -Value $value -PropertyType DWORD -Force | Out-Null

gpupdate /force



$key = 'SYSTEM\CurrentControlSet\Control\CloudDomainJoin\TenantInfo\*'
$keyinfo = Get-Item "HKLM:\$key"
$url = $keyinfo.name
$url = $url.Split("\")[-1]
$path = "HKLM:\SYSTEM\CurrentControlSet\Control\CloudDomainJoin\TenantInfo\$url"
New-ItemProperty -LiteralPath $path -Name 'MdmEnrollmentUrl' -Value 'https://enrollment.manage.microsoft.com/enrollmentserver/discovery.svc' -PropertyType String -Force -ea SilentlyContinue;
New-ItemProperty -LiteralPath $path  -Name 'MdmTermsOfUseUrl' -Value 'https://portal.manage.microsoft.com/TermsofUse.aspx' -PropertyType String -Force -ea SilentlyContinue;
New-ItemProperty -LiteralPath $path -Name 'MdmComplianceUrl' -Value 'https://portal.manage.microsoft.com/?portalAction=Compliance' -PropertyType String -Force -ea SilentlyContinue;


C:\Windows\system32\deviceenroller.exe /c /AutoEnrollMDM