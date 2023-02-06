#Create a tag file just so Intune knows this was installed
if (-not (Test-Path "$($env:ProgramData)\Microsoft\CXN\Scripts\RenameComputerAzureJoin"))
    {
    New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\RenameComputerAzureJoin"
    Set-Content -Path "$($env:ProgramData)\CXN\Scripts\RenameComputerAzureJoin\RenameComputerAzureJoin.ps1.tag" -Value "Installed"
    }

#First we will assign our Blob to a variable, this BLOB must be anonymous readable!
$Blob = ""

# Initialization
$dest = "$($env:ProgramData)\CXN\Scripts\RenameComputerAzureJoin"
Start-Transcript "$dest\RenameComputerAzureJoin.log" -Append

# Get the new computer name
$csvurl = $Blob
$output = ($env:TEMP + "\RenameComputerAzureJoin.csv")
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

    #Remove the scheduled task
    Disable-ScheduledTask -TaskName "RenameComputerAzureJoin" -ErrorAction Ignore
    Unregister-ScheduledTask -TaskName "RenameComputerAzureJoin" -Confirm:$false -ErrorAction Ignore
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
else
    {
    # Check to see if already scheduled
    $existingTask = Get-ScheduledTask -TaskName "RenameComputerAzureJoin" -ErrorAction SilentlyContinue
    if ($null  -ne $existingTask)
        {
        Write-Host "Scheduled task already exists."
        Stop-Transcript
        Exit 0
        }

    # Copy myself to a safe place if not already there
    if (-not (Test-Path "$dest\RenameComputerAzureJoin.ps1"))
        {
        Copy-Item $PSCommandPath "$dest\RenameComputerAzureJoin.PS1"
        }

    # Create the scheduled task action
    $action = New-ScheduledTaskAction -Execute "Powershell.exe" -Argument "-NoProfile" -ExecutionPolicy bypass -WindowStyle Hidden -File "$dest\RenameComputerAzureJoin.ps1"

    # Create the scheduled task trigger
    $timespan = New-Timespan -minutes 5
    $triggers = @()
    $triggers += New-ScheduledTaskTrigger -Daily -At 9am
    $triggers += New-ScheduledTaskTrigger -AtLogOn -RandomDelay $timespan
    $triggers += New-ScheduledTaskTrigger -AtStartup -RandomDelay $timespan
    
    # Register the scheduled task
    Register-ScheduledTask -User SYSTEM -Action $action -Trigger $triggers -TaskName "RenameComputerAzureJoin" -Description "RenameComputerAzureJoin" -Force
    Write-Host "Scheduled task created."
}
Stop-Transcript
