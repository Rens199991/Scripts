#Create a tag file just so Intune knows this was installed
If(-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\EnableNumlockStartPCR"))
    {
    New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\EnableNumlockStartPCR"
    Set-Content -Path "$($env:ProgramData)\CXN\Scripts\EnableNumlockStartPCR\EnableNumlockStartPCR.ps1.tag" -Value "Installed"
    }

#Define drive HKU:
New-PSDrive -PSProvider Registry -Name HKU -Root HKEY_USERS

#Begin Scrip
Set-ItemProperty -Path "HKU:\.DEFAULT\Control Panel\Keyboard" -Name "InitialKeyboardIndicators" -Value "2" -Force


