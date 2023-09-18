#New script to test: https://niklastinner.medium.com/bulk-autopilot-device-renaming-656ba517d94b (only for autopilot Devices)




#Create a tag file just so Intune knows this was installed
if (-not (Test-Path "$($env:ProgramData)\Microsoft\CXN\Scripts\RenameComputerHybridJoin"))
    {
    New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\RenameComputerHybridJoin"
    Set-Content -Path "$($env:ProgramData)\CXN\Scripts\RenameComputerHybridJoin\RenameComputerHybridJoin.ps1.tag" -Value "Installed"
    }

#First we will assign our Blob to a variable, this BLOB must be anonymous readable!
$Blob = "https://hlbcsvcomputer.blob.core.windows.net/hostnames/RenameComputerHybridJoin.csv"

# Initialization
$dest = "$($env:ProgramData)\CXN\Scripts\RenameComputerHybridJoin"
Start-Transcript "$dest\RenameComputerHybridJoin.log" -Append

# Make sure we are already domain-joined
$goodToGo = $true
$details = Get-ComputerInfo
if (-not $details.CsPartOfDomain)
    {
    Write-Host "Not part of a domain."
    $goodToGo = $false
    }

# Make sure we have connectivity
$dcInfo = [ADSI]"LDAP://RootDSE"
if ($null  -eq $dcInfo.dnsHostName)
    {
    Write-Host "No connectivity to the domain."
    $goodToGo = $false
    }

if ($goodToGo)
    {
    # Get the new computer name
    $csvurl = $Blob
    $output = ($env:TEMP + "\RenameComputerHybridJoin.csv")
    Invoke-WebRequest $csvurl -OutFile $output
    $csv = Import-Csv $output

    $serial = Get-WmiObject win32_bios | select-object Serialnumber
    $output = $csv | Where-Object serial -Match $serial.Serialnumber
    if($null -ne $output)
        {
        $newName = $output

        # Set the computer name
        Write-Host "Renaming computer to $($newName.name)"
        Rename-Computer -NewName $newName.name

        # Remove the scheduled task
        Disable-ScheduledTask -TaskName "RenameComputerHybridJoin" -ErrorAction Ignore
        Unregister-ScheduledTask -TaskName "RenameComputerHybridJoin" -Confirm:$false -ErrorAction Ignore
        Write-Host "Scheduled task unregistered."

        # Make sure we reboot if still in ESP/OOBE by reporting a 1641 return code (hard reboot)
        if ($details.CsUserName -match "defaultUser")
            {
            Write-Host "Exiting during ESP/OOBE with return code 1641"
            Stop-Transcript
            Exit 1641
            }
        else 
            {
            Write-Host "Initiating a restart in 10 minutes"
            & shutdown.exe /g /t 600 /f /c "Restarting the computer due to a computer name change.  Save your work."
            Stop-Transcript
            Exit 0
            }
        }
    }
else
    {
    # Check to see if already scheduled
    $existingTask = Get-ScheduledTask -TaskName "RenameComputerHybridJoin" -ErrorAction SilentlyContinue
    if ($null  -ne $existingTask)
        {
        Write-Host "Scheduled task already exists."
        Stop-Transcript
        Exit 0
        }

    # Copy myself to a safe place if not already there
    if (-not (Test-Path "$dest\RenameComputerHybridJoin.ps1"))
        {
        Copy-Item $PSCommandPath "$dest\RenameComputerHybridJoin.PS1"
        }

    # Create the scheduled task action
    $action = New-ScheduledTaskAction -Execute "Powershell.exe" -Argument "-NoProfile" -ExecutionPolicy bypass -WindowStyle Hidden -File "$dest\RenameComputerHybridJoin.ps1"

    # Create the scheduled task trigger
    $timespan = New-Timespan -minutes 5
    $triggers = @()
    $triggers += New-ScheduledTaskTrigger -Daily -At 9am
    $triggers += New-ScheduledTaskTrigger -AtLogOn -RandomDelay $timespan
    $triggers += New-ScheduledTaskTrigger -AtStartup -RandomDelay $timespan
    
    # Register the scheduled task
    Register-ScheduledTask -User SYSTEM -Action $action -Trigger $triggers -TaskName "RenameComputerHybridJoin" -Description "RenameComputerHybridJoin" -Force
    Write-Host "Scheduled task created."
    }

Stop-Transcript
