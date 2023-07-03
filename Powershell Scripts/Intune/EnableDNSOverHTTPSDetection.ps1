$Path = "HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters"
$Name = "EnableAutoDoh"
$Value = 2
$Registry = Get-ItemProperty -Path $Path -Name $Name -ErrorAction "SilentlyContinue" | Select-Object -ExpandProperty $Name
    
    
If ($Registry -eq $Value)
    {
    #Create a tag file just so Intune knows this was installed
    If(-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\EnableDNSOverHTTPSDRNOT"))
        {
        New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\EnableDNSOverHTTPSDRNOT"
        Set-Content -Path "$($env:ProgramData)\CXN\Scripts\EnableDNSOverHTTPSDRNOT\EnableDNSOverHTTPSDRNOT.ps1.tag" -Value "Installed"
        }
    Write-Output "No Remediation Needed"    
    Exit 0
    }
Else
    {
    #Create a tag file just so Intune knows this was installed
    If(-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\EnableDNSOverHTTPSDRNEEDED"))
        {
        New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\EnableDNSOverHTTPSDRNEEDED"
        Set-Content -Path "$($env:ProgramData)\CXN\Scripts\EnableDNSOverHTTPSDRNEEDED\EnableDNSOverHTTPSDRNEEDED.ps1.tag" -Value "Installed"
        }
    Write-Output "Remediation Needed"
    Exit 1
    } 
