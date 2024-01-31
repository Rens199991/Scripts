$Path = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP"
$Name = "DesktopImagePath"
$ValueWallpaper = "$($env:ProgramData)\CXN\Scripts\SetDesktopBackgroundandLockscreenRemediationR\Wallpaper.jpg"
$ValueLockscreen = "$($env:ProgramData)\CXN\Scripts\SetDesktopBackgroundandLockscreenRemediationR\Lockscreen.jpg"
$Registry = Get-ItemProperty -Path $Path -Name $Name -ErrorAction "SilentlyContinue" | Select-Object -ExpandProperty $Name

if ($Registry -eq $ValueWallpaper)
    {
    #Create a tag file just so Intune knows this was installed
    If(-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\SetDesktopBackgroundandLockscreenRemediationDRNOT"))
        {
        New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\SetDesktopBackgroundandLockscreenRemediationDRNOT"
        Set-Content -Path "$($env:ProgramData)\CXN\Scripts\SetDesktopBackgroundandLockscreenRemediationDRNOT\SetDesktopBackgroundandLockscreenRemediationDRNOT.ps1.tag" -Value "Installed"
        }
    Write-Output "No Remediation needed"
    exit 0
    }
else 
    {
    #Create a tag file just so Intune knows this was installed
    If(-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\SetDesktopBackgroundandLockscreenRemediationDRNeeded"))
        {
        New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\SetDesktopBackgroundandLockscreenRemediationDRNeeded"
        Set-Content -Path "$($env:ProgramData)\CXN\Scripts\SetDesktopBackgroundandLockscreenRemediationDRNeeded\SetDesktopBackgroundandLockscreenRemediationDRNeeded.ps1.tag" -Value "Installed"
        }
    Write-Output "Remediation needed"
    exit 1   
    }