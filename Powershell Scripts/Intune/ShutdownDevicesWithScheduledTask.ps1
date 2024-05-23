#Create a tag file just so Intune knows this was installed
If (-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\ShutdownDevicesWithScheduledTask"))
    {   
    New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\ShutdownDevicesWithScheduledTask"
    Set-Content -Path "$($env:ProgramData)\CXN\Scripts\ShutdownDevicesWithScheduledTask\ShutdownDevicesWithScheduledTask.ps1.tag" -Value "Installed"
    }

#The name of your scheduled task.  
$taskName = "Shutdown Computers"  
  
$User= "NT AUTHORITY\SYSTEM"  
  
#Describe the scheduled task.  
$description = "Shuts computer down daily at 8PM"  
  
#Create a new task action  
$taskAction = New-ScheduledTaskAction -Execute 'shutdown.exe' -Argument '-s -t 300 -c "Je computer zal binnen 5 minuten afsluiten"'  
  
#Create task trigger  
$taskTrigger = New-ScheduledTaskTrigger -Daily -At 8PM  
  
#Register the new PowerShell scheduled task  

Register-ScheduledTask -TaskName $taskName -Action $taskAction -Trigger $taskTrigger -Description $description -User $User