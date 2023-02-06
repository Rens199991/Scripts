$Path = "HKLM:\SYSTEM\CurrentControlSet\Services\tzautoupdate"
$Name = "Start"
$Value = 3
$Registry = Get-ItemProperty -Path $Path -Name $Name -ErrorAction Stop | Select-Object -ExpandProperty $Name

If ($Registry -eq $Value)
    {
    #Create a tag file just so Intune knows this was installed
    If(-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\SetTimeZoneDynamicallyDRNOT"))
        {
        New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\SetTimeZoneDynamicallyDRNOT"
        Set-Content -Path "$($env:ProgramData)\CXN\Scripts\SetTimeZoneDynamicallyDRNOT\SetTimeZoneDynamicallyDRNOT.ps1.tag" -Value "Installed"
        }
    Write-Output "No Remediation Needed"    
    Exit 0
    }
Else
    {
    #Create a tag file just so Intune knows this was installed
    If(-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\SetTimeZoneDynamicallyDRNeeded"))
        {
        New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\SetTimeZoneDynamicallyDRNeeded"
        Set-Content -Path "$($env:ProgramData)\CXN\Scripts\SetTimeZoneDynamicallyDRNeeded\SetTimeZoneDynamicallyDRNeeded.ps1.tag" -Value "Installed"
        }
    Write-Output "Remediation Needed"
    Exit 1
    } 

