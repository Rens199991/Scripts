#Bypass Executionpolicy
Set-ExecutionPolicy Bypass -Force


# AgentInstall.ps1 - v1.0
# Allows to add a managed device in an automated way
# Contact: support@conxion.be

# ---------------------------------------------------------------
# Set the correct managed location ID
$locationID = "393"
# ---------------------------------------------------------------

# If already installed, do not proceed
If (Get-Service 'LTService','LTSvcMon' -ErrorAction SilentlyContinue) { exit }
# If no location specified, do not proceed
if(!$locationID) { exit }

# Get the agent details
$postParam = @{ 
    "LocationID" = $locationID 
    "Hostname" = $($env:computername)
}
$agentDetails = try {
    Invoke-RestMethod -Uri "https://cxnmanaged.azurewebsites.net/api/AgentInstall" -Method POST -Body ($postParam | ConvertTo-Json) -ContentType "application/json"
}
catch [System.Net.WebException]
{
    $_.Exception.Response
}

# If we get an error, do not proceed
if($agentDetails.StatusCode -eq "NotFound") {
    write-output "Error in script: no valid response received."
    exit
}

# Set the install details
$InstallBase = "${env:windir}\Temp\LabTech"
$FullMSIPath = "$InstallBase\$($agentDetails.installer)"

# Check to see if the install directory is present
If ((Test-Path -Path $InstallBase) -eq $False)
{
    # Create the local install directory
    New-Item -ItemType Directory $InstallBase -Force -Confirm:$False
}
# Make sure no other files are present
Remove-Item -Path "$InstallBase\*.*" -Force

# Download the agent
Invoke-WebRequest -Uri $($agentDetails.sourceFile) -OutFile $FullMSIPath -UseBasicParsing

# Check the .Net version
$DotNET = (Get-ChildItem 'HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP' -Recurse | Get-ItemProperty -Name Version, Release -ErrorAction 0 | Where-Object { $_.PSChildName -match '^(?!S)\p{L}'} | Select-Object PSChildName, Version, Release | Select-Object -ExpandProperty Version | Sort-Object Version)[0]
If (-not ($DotNet -like '4.8.*')){
    Write-Output ".NET Framework 4.8 installation needed."
    Start-BitsTransfer -Source 'https://go.microsoft.com/fwlink/?linkid=2088631'  -Destination "$Env:Temp\Net4.8.exe"; & "$Env:Temp\Net4.8.exe" /q /norestart
}

# Install the agent
Start-Process "$FullMSIPath" -ArgumentList $($agentDetails.parameters) -Wait
Start-Sleep 5

# Remove the installer
Remove-Item $FullMSIPath -Force






