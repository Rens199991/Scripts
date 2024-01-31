#Create a tag file just so Intune knows this was installed
If (-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\SetDesktopBackgroundandLockscreen"))
    {   
    New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\SetDesktopBackgroundandLockscreen"
    Set-Content -Path "$($env:ProgramData)\CXN\Scripts\SetDesktopBackgroundandLockscreen\SetDesktopBackgroundandLockscreen.ps1.tag" -Value "Installed"
    }

#Begin Script to Change wallpaper
$RegKeyPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP"
$DesktopPath = "DesktopImagePath"
$DesktopStatus = "DesktopImageStatus"
$DesktopUrl = "DesktopImageUrl"
$StatusValue = "1"
$url = "https://pim.allinox.be/Allinox/Catalog/General/Allinox_wallpaper.jpg"
$DesktopImageValue = "$($env:ProgramData)\CXN\Scripts\SetDesktopBackgroundandLockscreen\Wallpaper.jpg"
$wc = New-Object System.Net.WebClient
$wc.DownloadFile($url, $DesktopImageValue)

if (-not(Test-Path -Path $RegKeyPath))
    {
    Write-Host "Creating registry path $($RegKeyPath)."
    New-Item -Path $RegKeyPath -Force | Out-Null
    }

New-ItemProperty -Path $RegKeyPath -Name $DesktopStatus -Value $Statusvalue -PropertyType DWORD -Force | Out-Null
New-ItemProperty -Path $RegKeyPath -Name $DesktopPath -Value $DesktopImageValue -PropertyType STRING -Force | Out-Null
New-ItemProperty -Path $RegKeyPath -Name $DesktopUrl -Value $DesktopImageValue -PropertyType STRING -Force | Out-Null


<#Begin Script to change Lockscreen

$RegKeyPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP"
$LockScreenPath = "LockScreenImagePath"
$LockScreenStatus = "LockScreenImageStatus"
$LockScreenUrl = "LockScreenImageUrl"
$StatusValue = "1"
$url = "https://pim.allinox.be/Allinox/Catalog/General/Allinox_wallpaper.jpg"
$LockScreenImageValue = "$($env:ProgramData)\CXN\Scripts\SetDesktopBackgroundandLockscreen\Lockscreen.jpg"
$wc = New-Object System.Net.WebClient
$wc.DownloadFile($url, $LockScreenImageValue)

if (-not(Test-Path -Path $RegKeyPath))
    {
    Write-Host "Creating registry path $($RegKeyPath)."
    New-Item -Path $RegKeyPath -Force | Out-Null
    }

New-ItemProperty -Path $RegKeyPath -Name $LockScreenStatus -Value $StatusValue -PropertyType DWORD -Force
New-ItemProperty -Path $RegKeyPath -Name $LockScreenPath -Value $LockscreenLocalIMG -PropertyType STRING -Force
New-ItemProperty -Path $RegKeyPath -Name $LockScreenUrl -Value $LockscreenLocalIMG -PropertyType STRING -Force

#> 