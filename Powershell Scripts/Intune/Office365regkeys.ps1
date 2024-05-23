#Office365 Regkeys

New-ItemProperty -Path "HKCU:\software\policies\microsoft\office\16.0\common\general" -Name "shownfirstrunoptin" -PropertyType "DWord" -Value 0

New-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Office\16.0\Outlook\Options\General" -Name "HideNewOutlookToggle" -PropertyType "DWord" -Value 1

New-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Office\16.0\Outlook\Options\General" -Name "DelegateWastebasketStyle" -PropertyType "DWord" -Value 8

New-ItemProperty -Path "HKCU:\Software\Microsoft\Office\16.0\Outlook\Setup" -Name "SetupOutlookMobileWebPageOpened" -PropertyType "DWord" -Value 1

New-ItemProperty -Path "HKCU:\Software\Microsoft\Office\16.0\Common\MailSettings" -Name "disablesignatures" -PropertyType "DWord" -Value 1

New-ItemProperty -Path "HKCU:\Software\Microsoft\Office\16.0\Outlook\Preferences" -Name "DelegateSentItemsStyle" -PropertyType "DWord" -Value 1

New-ItemProperty -Path "HKCU:\Software\Microsoft\Office\16.0\Registration" -Name "AcceptAllEulas" -PropertyType "DWord" -Value 1

