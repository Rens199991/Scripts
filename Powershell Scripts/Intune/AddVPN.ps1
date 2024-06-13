#Create a tag file just so Intune knows this was installed
If(-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\AddVPN"))
    {
    New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\AddVPN"
    Set-Content -Path "$($env:ProgramData)\CXN\Scripts\AddVPN\AddVPN.ps1.tag" -Value "Installed"
    }

#Begin script, opgepast het Script moet lopen als the Logged On User
Add-VpnConnection -Name "Logflow-Azure" -ServerAddress 20.76.248.91 -AuthenticationMethod Pap -EncryptionLevel Optional -Force -L2tpPsk "IFFvCORAbP00" -TunnelType L2tp -RememberCredential -SplitTunneling -DnsSuffix "logflow.local"
Add-VpnConnectionRoute -ConnectionName "Logflow-Azure" -DestinationPrefix "10.10.3.0/24"
Add-VpnConnectionRoute -ConnectionName "Logflow-Azure" -DestinationPrefix "10.10.4.0/24"
Add-VpnConnectionRoute -ConnectionName "Logflow-Azure" -DestinationPrefix "10.10.7.0/24"
Add-VpnConnectionRoute -ConnectionName "Logflow-Azure" -DestinationPrefix "10.10.8.0/24"
Add-VpnConnectionRoute -ConnectionName "Logflow-Azure" -DestinationPrefix "10.10.9.0/24"
Add-VpnConnectionRoute -ConnectionName "Logflow-Azure" -DestinationPrefix "10.0.1.0/24"



#Voorbeeld voor VPN met meraki

#Add VPN Connection
Add-VpnConnection -Name "VPN Opsomer & De Lange" -ServerAddress opsomer-cjqkbcdndp.dynamic-m.com -AuthenticationMethod Pap -EncryptionLevel optional -Force -L2tpPsk ZmRTMLcGu-  -TunnelType L2tp -RememberCredential

#Add regkey to ask for VPN Authentication, pc heeft wel reboot nodig om dit te laten werken
New-ItemProperty -Path "HKLM\SYSTEM\CurrentControlSet\Services\PolicyAgent" -Name "AssumeUDPEncapsulationContextOnSendRule" -PropertyType "DWord" -Value 2