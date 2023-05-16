#Begin Script
if ((Test-Path -LiteralPath "HKCU:\Software\Microsoft\Office\16.0\Outlook\Options") -ne $true) 
    {  
    New-Item "HKCU:\Software\Microsoft\Office\16.0\Outlook\Options" -force -ErrorAction SilentlyContinue
    }
    
New-ItemProperty -LiteralPath "HKCU:\Software\Microsoft\Office\16.0\Outlook\Options" -Name "DisablePOP3" -Value 1 -PropertyType DWord -Force -ErrorAction SilentlyContinue
New-ItemProperty -LiteralPath "HKCU:\Software\Microsoft\Office\16.0\Outlook\Options" -Name "DisableIMAP" -Value 1 -PropertyType DWord -Force -ErrorAction SilentlyContinue

