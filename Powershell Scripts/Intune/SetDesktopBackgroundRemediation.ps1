#Create a tag file just so Intune knows this was installed
If(-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\SetDesktopBackgroundRemediationR"))
    {
    New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\SetDesktopBackgroundRemediationR"
    Set-Content -Path "$($env:ProgramData)\CXN\Scripts\SetDesktopBackgroundRemediationR\SetDesktopBackgroundRemediationR.ps1.tag" -Value "Installed"
    }   

#Begin Script
$RegKeyPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP"
$DesktopPath = "DesktopImagePath"
$DesktopStatus = "DesktopImageStatus"
$DesktopUrl = "DesktopImageUrl"
$StatusValue = "1"
$url = "https://i.pinimg.com/originals/c2/55/52/c255527d40d8d0669382758af3f4f20f.jpg"
$DesktopImageValue = "$($env:ProgramData)\CXN\Scripts\SetDesktopBackgroundRemediationR\Wallpaper.jpg"
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