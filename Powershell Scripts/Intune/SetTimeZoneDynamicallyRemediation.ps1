#Create a tag file just so Intune knows this was installed
If (-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\SetTimeZoneDynamicallyR"))
    {   
    New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\SetTimeZoneDynamicallyR"
    Set-Content -Path "$($env:ProgramData)\CXN\Scripts\SetTimeZoneDynamicallyR\SetTimeZoneDynamicallyR.ps1.tag" -Value "Installed"
    }

#Enable location services so the time zone will be set automatically (even when skipping the privacy page in OOBE) when an administrator signs in
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" -Name "Value" -Type "String" -Value "Allow" -Force
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Overrides\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" -Name "SensorPermissionState" -Type "DWord" -Value 1 -Force
Start-Service -Name "lfsvc" -ErrorAction SilentlyContinue

Start-Sleep -Seconds 10
#Set Regkey to Set Time Zone Dynamically
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\tzautoupdate" -Name "Start" -Type "DWord" -Value 3 -Force
