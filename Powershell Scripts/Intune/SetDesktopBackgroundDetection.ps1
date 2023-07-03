$Path = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP"
$Name = "DesktopImagePath"
$Value = "$($env:ProgramData)\CXN\Scripts\SetDesktopBackgroundRemediationR\Wallpaper.jpg"
$Registry = Get-ItemProperty -Path $Path -Name $Name -ErrorAction "SilentlyContinue" | Select-Object -ExpandProperty $Name

if ($Registry -eq $Value)
    {
    #Create a tag file just so Intune knows this was installed
    If(-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\SetDesktopBackgroundRemediationDRNOT"))
        {
        New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\SetDesktopBackgroundRemediationDRNOT"
        Set-Content -Path "$($env:ProgramData)\CXN\Scripts\SetDesktopBackgroundRemediationDRNOT\SetDesktopBackgroundRemediationDRNOT.ps1.tag" -Value "Installed"
        }
    Write-Output "No Remediation needed"
    exit 0
    }
else 
    {
    #Create a tag file just so Intune knows this was installed
    If(-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\SetDesktopBackgroundRemediationDRNeeded"))
        {
        New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\SetDesktopBackgroundRemediationDRNeeded"
        Set-Content -Path "$($env:ProgramData)\CXN\Scripts\SetDesktopBackgroundRemediationDRNeeded\SetDesktopBackgroundRemediationDRNeeded.ps1.tag" -Value "Installed"
        }
    Write-Output "Remediation needed"
    exit 1   
    }