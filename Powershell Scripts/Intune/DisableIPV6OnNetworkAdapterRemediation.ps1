#Create a tag file just so Intune knows this was installed
If(-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\DisableIPV6OnNetworkAdapterR"))
    {
    New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\DisableIPV6OnNetworkAdapterR"
    Set-Content -Path "$($env:ProgramData)\CXN\Scripts\DisableIPV6OnNetworkAdapterR\DisableIPV6OnNetworkAdapterR.ps1.tag" -Value "Installed"
    }


Disable-NetAdapterBinding -Name “Wi-fi” -ComponentID "ms_tcpip6"
