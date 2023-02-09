#Stop FortiClient Process
Stop-Process -Name FortiClient -ErrorAction SilentlyContinue

#SUninstall FortiClient
Start-Process Msiexec.exe -wait -ArgumentList /'x {7C48C946-7D3E-4FB1-82F0-000DB5D04C6B} REBOOT=ReallySuppress /qn'

#SRemove FortiClient VPN Profiles
Remove-Item -LiteralPath "HKLM:\SOFTWARE\Fortinet\FortiClient\Sslvpn\Tunnels\VPN Vanhonsebrouck" -force -ErrorAction SilentlyContinue