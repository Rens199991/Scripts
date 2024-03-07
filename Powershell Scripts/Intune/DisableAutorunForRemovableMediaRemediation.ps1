#Create a tag file just so Intune knows this was installed
If(-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\DisableAutorunForRemovableMediaRemediationR"))
    {
    New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\DisableAutorunForRemovableMediaR"
    Set-Content -Path "$($env:ProgramData)\CXN\Scripts\DisableAutorunForRemovableMediaR\DisableAutorunForRemovableMediaR.ps1.tag" -Value "Installed"
    }

#Begin Script
if ((Test-Path -LiteralPath "HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer") -ne $true) 
    {  
    New-Item "HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" -force -ErrorAction SilentlyContinue
    }
    
New-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "NoDriveTypeAutoRun"  -value 4 -type "Dword" -ErrorAction "SilentlyContinue" -Force
