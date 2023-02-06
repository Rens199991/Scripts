#Create a tag file just so Intune knows this was installed
If(-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\DisableFastbootRemediationR"))
    {
    New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\DisableFastbootR"
    Set-Content -Path "$($env:ProgramData)\CXN\Scripts\DisableFastbootR\DisableFastbootR.ps1.tag" -Value "Installed"
    }

#Begin Script
if ((Test-Path -LiteralPath "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power") -ne $true) 
    {  
    New-Item "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power" -force -ErrorAction SilentlyContinue
    }
    
New-ItemProperty -LiteralPath 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power' -Name 'HiberbootEnabled' -Value 0 -PropertyType DWord -Force -ErrorAction SilentlyContinue

