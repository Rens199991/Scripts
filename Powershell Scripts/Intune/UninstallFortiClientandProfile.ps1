#Restart Process using PowerShell 64-bit 
If ($ENV:PROCESSOR_ARCHITEW6432 -eq "AMD64") {
    Try {
        &"$ENV:WINDIR\SysNative\WindowsPowershell\v1.0\PowerShell.exe" -File $PSCOMMANDPATH
    }
    Catch {
        Throw "Failed to start $PSCOMMANDPATH"
    }
    Exit
}

#Stop FortiClient Process
Stop-Process -Name FortiClient -ErrorAction SilentlyContinue

#SUninstall FortiClient, Look for the MSI CODE in Regkey: Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall
Start-Process Msiexec.exe -wait -ArgumentList /'x {32123CA3-C24D-4A99-9347-70049B8E4C23} REBOOT=ReallySuppress /qn'

#SRemove FortiClient VPN Profiles
Remove-Item -LiteralPath "HKLM:\SOFTWARE\Fortinet\FortiClient\Sslvpn\Tunnels\VPN Vanhonsebrouck" -force -ErrorAction SilentlyContinue