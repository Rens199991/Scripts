#Create a tag file just so Intune knows this was installed
If(-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\EnableDNSOverHTTPSR"))
    {
    New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\EnableDNSOverHTTPSR"
    Set-Content -Path "$($env:ProgramData)\CXN\Scripts\EnableDNSOverHTTPSR\EnableDNSOverHTTPSR.ps1.tag" -Value "Installed"
    }


#Begin Script
$Path = "HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters"
$Name = "EnableAutoDoh"
$Type = "DWORD"
$Value = 2
 
New-ItemProperty -Path $Path -Name $Name -Type $Type -Value $Value