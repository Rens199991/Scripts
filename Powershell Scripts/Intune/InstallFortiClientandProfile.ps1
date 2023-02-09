#Install FortiClient VPN
Start-Process Msiexec.exe  -ArgumentList '/i FortiClientVPN.msi REBOOT=ReallySuppress /qn' -Wait

# Install VPN Profiles
if((Test-Path -LiteralPath "HKLM:\SOFTWARE\Fortinet\FortiClient\Sslvpn\Tunnels\VPN Vanhonsebrouck") -ne $true) 
    {  
    New-Item "HKLM:\SOFTWARE\Fortinet\FortiClient\Sslvpn\Tunnels\VPN Vanhonsebrouck" -force -ea SilentlyContinue 
    }

    New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Fortinet\FortiClient\Sslvpn\Tunnels\VPN Vanhonsebrouck' -Name 'Description' -Value 'VPN Vanhonsebrouck' -PropertyType String -Force -ea SilentlyContinue
    New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Fortinet\FortiClient\Sslvpn\Tunnels\VPN Vanhonsebrouck' -Name 'Server' -Value 'vpn.vanhonsebrouck.be:443' -PropertyType String -Force -ea SilentlyContinue
    New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Fortinet\FortiClient\Sslvpn\Tunnels\VPN Vanhonsebrouck' -Name 'promptusername' -Value 1 -PropertyType DWord -Force -ea SilentlyContinue
    New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Fortinet\FortiClient\Sslvpn\Tunnels\VPN Vanhonsebrouck' -Name 'promptcertificate' -Value 0 -PropertyType DWord -Force -ea SilentlyContinue
    New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Fortinet\FortiClient\Sslvpn\Tunnels\VPN Vanhonsebrouck' -Name 'ServerCert' -Value '1' -PropertyType String -Force -ea SilentlyContinue