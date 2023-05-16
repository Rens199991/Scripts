#Create a tag file just so Intune knows this was installed
If(-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\BlockPop3andIMAPforOutlookR"))
    {
    New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\BlockPop3andIMAPforOutlookR"
    Set-Content -Path "$($env:ProgramData)\CXN\Scripts\BlockPop3andIMAPforOutlookR\BlockPop3andIMAPforOutlookR.ps1.tag" -Value "Installed"
    }

#Begin Script
if ((Test-Path -LiteralPath "HKCU:\Software\Microsoft\Office\16.0\Outlook\Options") -ne $true) 
    {  
    New-Item "HKCU:\Software\Microsoft\Office\16.0\Outlook\Options" -force -ErrorAction SilentlyContinue
    }
    
New-ItemProperty -LiteralPath "HKCU:\Software\Microsoft\Office\16.0\Outlook\Options" -Name "DisablePOP3" -Value 1 -PropertyType DWord -Force -ErrorAction SilentlyContinue
New-ItemProperty -LiteralPath "HKCU:\Software\Microsoft\Office\16.0\Outlook\Options" -Name "DisableIMAP" -Value 1 -PropertyType DWord -Force -ErrorAction SilentlyContinue

