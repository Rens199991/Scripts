$IsIPV6EnabledOnAdapter = Get-NetAdapterBinding -ComponentID ms_tcpip6 | Where-Object {$_.Name -eq "Wi-fi" -and $_.Enabled -eq "True"}

If ($null -eq $IsIPV6EnabledOnAdapter)
    {
    #Create a tag file just so Intune knows this was installed
    If(-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\DisableIPV6OnNetworkAdapterDetectionDRNOT"))
        {
        New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\DisableIPV6OnNetworkAdapterDetectionDRNOT"
        Set-Content -Path "$($env:ProgramData)\CXN\Scripts\DisableIPV6OnNetworkAdapterDetectionDRNOT\DisableIPV6OnNetworkAdapterDetectionDRNOT.ps1.tag" -Value "Installed"
        }
    Write-Output "No Remediation Needed"    
    Exit 0
    }
Else
    {
    #Create a tag file just so Intune knows this was installed
    If(-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\DisableIPV6OnNetworkAdapterDetectionDRNeeded"))
        {
        New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\DisableIPV6OnNetworkAdapterDetectionDRNeeded"
        Set-Content -Path "$($env:ProgramData)\CXN\Scripts\DisableIPV6OnNetworkAdapterDetectionDRNeeded\DisableIPV6OnNetworkAdapterDetectionDRNeeded.ps1.tag" -Value "Installed"
        }
    Write-Output "Remediation Needed"
    Exit 1
    } 



