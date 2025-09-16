#Create a tag file just so Intune knows this was installed
If(-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\AddVPNR"))
    {
    New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\AddVPNR"
    Set-Content -Path "$($env:ProgramData)\CXN\Scripts\AddVPNR\AddVPNR.ps1.tag" -Value "Installed"
    }

#Begin script, opgepast het Script moet lopen als the Logged On User
Add-VpnConnection -Name "Allinox" -ServerAddress allinox-headquarters-wired-rkqbptnwzz.dynamic-m.com  -AuthenticationMethod Pap -EncryptionLevel Optional -Force -L2tpPsk "bcJjoD3Tp-A" -TunnelType L2tp -RememberCredential -SplitTunneling -DnsSuffix "beka-cookware.local"
Add-VpnConnectionRoute -ConnectionName "Allinox" -DestinationPrefix "192.168.0.0/24"




#Create a tag file just so Intune knows this was installed
If(-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\DeleteWindowsUpdateRegkeysR"))
    {
    New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\DeleteWindowsUpdateRegkeysR"
    Set-Content -Path "$($env:ProgramData)\CXN\Scripts\DeleteWindowsUpdateRegkeysR\DeleteWindowsUpdateRegkeysR.ps1.tag" -Value "Installed"
    }

$Regkey = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate"
Remove-Item -Path $Regkey -Recurse -Force

#Add regkey to ask for VPN Authentication, pc heeft wel reboot nodig om dit te laten werken, dit script moeten we runnen in system contect
New-ItemProperty -Path "HKLM\SYSTEM\CurrentControlSet\Services\PolicyAgent" -Name "AssumeUDPEncapsulationContextOnSendRule" -PropertyType "DWord" -Value 2




