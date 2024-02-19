<# 
 
.SYNOPSIS
    Test-HybridDevicesInternetConnectivity V3.2 PowerShell script.

.DESCRIPTION
    Test-HybridDevicesInternetConnectivity is a PowerShell script that helps to test the Internet connectivity to the following Microsoft resources under the system context to validate the connection status between the device that needs to be connected to Entra ID as hybrid Azure AD joined device and Microsoft resources that are used during device registration process:

    https://login.microsoftonline.com
    https://device.login.microsoftonline.com
    https://enterpriseregistration.windows.net

.EXAMPLE
    .\Test-DeviceRegConnectivity
    
#>

Function RunPScript([String] $PSScript){
    $GUID=[guid]::NewGuid().Guid
    $Job = Register-ScheduledJob -Name $GUID -ScheduledJobOption (New-ScheduledJobOption -RunElevated) -ScriptBlock ([ScriptBlock]::Create($PSScript)) -ArgumentList ($PSScript) -ErrorAction Stop
    $Task = Register-ScheduledTask -TaskName $GUID -Action (New-ScheduledTaskAction -Execute $Job.PSExecutionPath -Argument $Job.PSExecutionArgs) -Principal (New-ScheduledTaskPrincipal -UserID "NT AUTHORITY\SYSTEM" -LogonType ServiceAccount -RunLevel Highest) -ErrorAction Stop
    $Task | Start-ScheduledTask -AsJob -ErrorAction Stop | Wait-Job | Remove-Job -Force -Confirm:$False
    While (($Task | Get-ScheduledTaskInfo).LastTaskResult -eq 267009) {Start-Sleep -Milliseconds 150}
    $Job1 = Get-Job -Name $GUID -ErrorAction SilentlyContinue | Wait-Job
    $Job1 | Receive-Job -Wait -AutoRemoveJob 
    Unregister-ScheduledJob -Id $Job.Id -Force -Confirm:$False
    Unregister-ScheduledTask -TaskName $GUID -Confirm:$false
}

Function checkProxy{
    # Check Proxy settings
    Write-Host "Checking winHTTP proxy settings..." -ForegroundColor Yellow
    $global:ProxyServer="NoProxy"
    $winHTTP = netsh winhttp show proxy
    $Proxy = $winHTTP | Select-String server
    $global:ProxyServer=$Proxy.ToString().TrimStart("Proxy Server(s) :  ")
    $global:Bypass = $winHTTP | Select-String Bypass
    $global:Bypass=$global:Bypass.ToString().TrimStart("Bypass List     :  ")

    if ($global:ProxyServer -eq "Direct access (no proxy server)."){
        $global:ProxyServer="NoProxy"
        Write-Host "      Access Type : DIRECT"
     
    }

    if ( ($global:ProxyServer -ne "NoProxy") -and (-not($global:ProxyServer.StartsWith("http://")))){
        Write-Host "      Access Type : PROXY"
        Write-Host "Proxy Server List :" $global:ProxyServer
        Write-Host "Proxy Bypass List :" $global:Bypass
        $global:ProxyServer = "http://" + $global:ProxyServer
    }

 
    #CheckwinInet proxy
    Write-Host ''
    Write-Host "Checking winInet proxy settings..." -ForegroundColor Yellow
    $winInet=RunPScript -PSScript "Get-ItemProperty -Path 'Registry::HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings'"
    if($winInet.ProxyEnable){Write-Host "    Proxy Enabled : Yes"; Write-Log -Message "    Proxy Enabled : Yes"}else{Write-Host "    Proxy Enabled : No";Write-Log -Message "    Proxy Enabled : No"}
    $winInetProxy="Proxy Server List : "+$winInet.ProxyServer
    Write-Host $winInetProxy
    $winInetBypass="Proxy Bypass List : "+$winInet.ProxyOverride
    Write-Host $winInetBypass
    $winInetAutoConfigURL="    AutoConfigURL : "+$winInet.AutoConfigURL
    Write-Host $winInetAutoConfigURL

    return $global:ProxyServer
}


Function Test-DevRegConnectivity{
    $ProxyTestFailed=$false
    Write-Host
    Write-Host "Testing Internet Connectivity..." -ForegroundColor Yellow
    $ErrorActionPreference= 'silentlycontinue'
    $global:TestFailed=$false

    $global:ProxyServer = checkProxy
    Write-Host
    Write-Host "Testing Device Registration Endpoints..." -ForegroundColor Yellow
    if ($global:ProxyServer -ne "NoProxy"){
        Write-Host "Testing connection via winHTTP proxy..." -ForegroundColor Yellow
        if ($global:login){
            $PSScript = "(Invoke-WebRequest -uri 'https://login.microsoftonline.com/common/oauth2' -UseBasicParsing).StatusCode"
            $TestResult = RunPScript -PSScript $PSScript
        }else{
            $PSScript = "(Invoke-WebRequest -uri 'https://login.microsoftonline.com/common/oauth2' -UseBasicParsing -Proxy $global:ProxyServer).StatusCode"
            $TestResult = RunPScript -PSScript $PSScript
        }
        if ($TestResult -eq 200){
            Write-Host ''
            Write-Host "Connection to login.microsoftonline.com .............. Succeeded." -ForegroundColor Green
        }else{
            $ProxyTestFailed=$true
        }

        if ($global:device){
            $PSScript = "(Invoke-WebRequest -uri 'https://device.login.microsoftonline.com/common/oauth2' -UseBasicParsing).StatusCode"
            $TestResult = RunPScript -PSScript $PSScript
        }else{
            $PSScript = "(Invoke-WebRequest -uri 'https://device.login.microsoftonline.com/common/oauth2' -UseBasicParsing -Proxy $global:ProxyServer).StatusCode"
            $TestResult = RunPScript -PSScript $PSScript
        }
        if ($TestResult -eq 200){
            Write-Host "Connection to device.login.microsoftonline.com ......  Succeeded." -ForegroundColor Green
        }else{
            $ProxyTestFailed=$true
        }

        if ($global:enterprise){
            $PSScript = "(Invoke-WebRequest -uri 'https://enterpriseregistration.windows.net/microsoft.com/discover?api-version=1.7' -UseBasicParsing -Headers @{'Accept' = 'application/json'; 'ocp-adrs-client-name' = 'dsreg'; 'ocp-adrs-client-version' = '10'}).StatusCode"
            $TestResult = RunPScript -PSScript $PSScript
        }else{
            $PSScript = "(Invoke-WebRequest -uri 'https://enterpriseregistration.windows.net/microsoft.com/discover?api-version=1.7' -UseBasicParsing -Proxy $global:ProxyServer -Headers @{'Accept' = 'application/json'; 'ocp-adrs-client-name' = 'dsreg'; 'ocp-adrs-client-version' = '10'}).StatusCode"
            $TestResult = RunPScript -PSScript $PSScript
        }
        if ($TestResult -eq 200){
            Write-Host "Connection to enterpriseregistration.windows.net ..... Succeeded." -ForegroundColor Green
        }else{
            $ProxyTestFailed=$true
        }
    }
    
    if (($global:ProxyServer -eq "NoProxy") -or ($ProxyTestFailed -eq $true)){
        if($ProxyTestFailed -eq $true){
            Write-host "Connection failed via winHTTP, trying winInet..."
        }else{
            Write-host "Testing connection via winInet..." -ForegroundColor Yellow
        }
        $PSScript = "(Invoke-WebRequest -uri 'https://login.microsoftonline.com/common/oauth2' -UseBasicParsing).StatusCode"
        $TestResult = RunPScript -PSScript $PSScript
        if ($TestResult -eq 200){
            Write-Host ''
            Write-Host "Connection to login.microsoftonline.com .............. Succeeded." -ForegroundColor Green
        }else{
            $global:TestFailed=$true
            Write-Host ''
            Write-Host "Connection to login.microsoftonline.com ................. failed." -ForegroundColor Red
        }
        $PSScript = "(Invoke-WebRequest -uri 'https://device.login.microsoftonline.com/common/oauth2' -UseBasicParsing).StatusCode"
        $TestResult = RunPScript -PSScript $PSScript
        if ($TestResult -eq 200){
            Write-Host "Connection to device.login.microsoftonline.com ......  Succeeded." -ForegroundColor Green
        }else{
            $global:TestFailed=$true
            Write-Host "Connection to device.login.microsoftonline.com .......... failed." -ForegroundColor Red
        }

        $PSScript = "(Invoke-WebRequest -uri 'https://enterpriseregistration.windows.net/microsoft.com/discover?api-version=1.7' -UseBasicParsing -Headers @{'Accept' = 'application/json'; 'ocp-adrs-client-name' = 'dsreg'; 'ocp-adrs-client-version' = '10'}).StatusCode"
        $TestResult = RunPScript -PSScript $PSScript
        if ($TestResult -eq 200){
            Write-Host "Connection to enterpriseregistration.windows.net ..... Succeeded." -ForegroundColor Green
        }else{
            $global:TestFailed=$true
            Write-Host "Connection to enterpriseregistration.windows.net ........ failed." -ForegroundColor Red
        }
    }

    # If test failed
    if ($global:TestFailed){
        Write-Host ''
        Write-Host ''
        Write-Host "Test failed: device is not able to communicate with MS endpoints under system account" -ForegroundColor red
        Write-Host ''
        Write-Host "Recommended actions: " -ForegroundColor Yellow
        Write-Host "- Make sure that the device is able to communicate with the above MS endpoints successfully under the system account." -ForegroundColor Yellow
        Write-Host "- If the organization requires access to the internet via an outbound proxy, it is recommended to implement Web Proxy Auto-Discovery (WPAD)." -ForegroundColor Yellow
        Write-Host "- If you don't use WPAD, you can configure proxy settings with GPO by deploying WinHTTP Proxy Settings on your computers beginning with Windows 10 1709." -ForegroundColor Yellow
        Write-Host "- If the organization requires access to the internet via an authenticated outbound proxy, make sure that Windows 10 computers can successfully authenticate to the outbound proxy using the machine context." -ForegroundColor Yellow
        Write-Host ''
        Write-Host ''
        Write-Host "Script completed successfully." -ForegroundColor Green

        Write-Host ''
    }else{
        Write-Host ''
        Write-Host "Test passed: Device is able to communicate with MS endpoints successfully under system context" -ForegroundColor Green
        Write-Host ''
        Write-Host ''
        Write-Host "Script completed successfully." -ForegroundColor Green
        Write-Host ''
    }
}

Function PSasAdmin{
    $currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
    $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

$global:Bypass=""
$global:login=$false
$global:device=$false
$global:enterprise=$false

Write-Host ''
'====================================================='
Write-Host '        Test Device Registration Connectivity        ' -ForegroundColor Green 
'====================================================='

Add-Content ".\Test-DeviceRegConnectivity.log" -Value "===========================================================================" -ErrorAction SilentlyContinue
if($null -ne $Error[0].Exception.Message){
    if($Error[0].Exception.Message.Contains('denied')){
        Write-Host ''
        Write-Host "Was not able to create log file." -ForegroundColor Yellow
    }else{
        Write-Host ''
        Write-Host "Test-DeviceRegConnectivity log file has been created." -ForegroundColor Yellow
    }
}else{
    Write-Host ''
    Write-Host "Test-DeviceRegConnectivity log file has been created." -ForegroundColor Yellow
}
Add-Content ".\Test-DeviceRegConnectivity.log" -Value "===========================================================================" -ErrorAction SilentlyContinue
Add-Type -AssemblyName System.DirectoryServices.AccountManagement            


if (PSasAdmin){
    # PS running as admin.
    Test-DevRegConnectivity
}else{
    Write-Host ''
    Write-Host "PowerShell is NOT running with elevated privileges" -ForegroundColor Red
    Write-Host ''
    Write-Host "Recommended action: This test needs to be running with elevated privileges" -ForegroundColor Yellow
    Write-Host ''
    Write-Host ''
    Write-Host "Script completed successfully." -ForegroundColor Green

    Write-Host ''
    exit
}

