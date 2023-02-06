#Install FortiClient VPN
Start-Process Msiexec.exe -Wait -ArgumentList '/i FortiClientVPN.msi TRANSFORMS=FortiClientVPN.mst REBOOT=ReallySuppress /qn'

# Install VPN Profiles
if((Test-Path -LiteralPath "HKLM:\SOFTWARE\Fortinet\FortiClient\Sslvpn\Tunnels\VPN Vanhonsebrouck") -ne $true) 
    {  
    New-Item "HKLM:\SOFTWARE\Fortinet\FortiClient\Sslvpn\Tunnels\VPN Vanhonsebrouck" -force -ea SilentlyContinue 
    }

New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Fortinet\FortiClient\Sslvpn\Tunnels\LETSCONFIGMGRVPN' -Name 'Server' -Value 'demovpn.someaddress.com' -PropertyType String -Force -ea SilentlyContinue
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Fortinet\FortiClient\Sslvpn\Tunnels\LETSCONFIGMGRVPN' -Name 'promptusername' -Value 0 -PropertyType DWord -Force -ea SilentlyContinue
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Fortinet\FortiClient\Sslvpn\Tunnels\LETSCONFIGMGRVPN' -Name 'promptcertificate' -Value 0 -PropertyType DWord -Force -ea SilentlyContinue
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Fortinet\FortiClient\Sslvpn\Tunnels\LETSCONFIGMGRVPN' -Name 'ServerCert' -Value '1' -PropertyType String -Force -ea SilentlyContinue
