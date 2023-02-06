#Create a tag file just so Intune knows this was installed
If(-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\InstallTeamViewerQuickSupport"))
	{
    New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\InstallTeamViewerQuickSupport"
    Set-Content -Path "$($env:ProgramData)\CXN\Scripts\InstallTeamViewerQuickSupport\InstallTeamViewerQuickSupport.ps1.tag" -Value "Installed"
    }


#Copy TeamviewerQS.exe to ProgramFiles
New-Item -Path "C:\Program Files (x86)\TeamviewerQS" -ItemType Directory
Copy-Item ".\TeamviewerQS.exe" -Destination "C:\Program Files (x86)\TeamviewerQS" -Force


#Create Shorthut to Users Desktop    
$SourceFilePath = "C:\Program Files (x86)\TeamviewerQS\TeamviewerQS.exe"
$new_object2 = New-Object -ComObject WScript.Shell
$destination = $new_object2.SpecialFolders.Item("AllUsersDesktop") + "\TeamviewerQS.lnk"
$ShortcutPath = $destination
$WScriptObj = New-Object -ComObject ("WScript.Shell")
$shortcut = $WscriptObj.CreateShortcut($ShortcutPath)
$shortcut.TargetPath = $SourceFilePath
$shortcut.Save()


#Create Shorthut to Start Menu   
$SourceFilePath = "C:\Program Files (x86)\TeamviewerQS\TeamviewerQS.exe"
$new_object3 = New-Object -ComObject WScript.Shell
$destination = $new_object3.SpecialFolders.Item("AllUsersStartMenu") + "\Programs\TeamviewerQS.lnk"
$ShortcutPath = $destination
$WScriptObj = New-Object -ComObject ("WScript.Shell")
$shortcut = $WscriptObj.CreateShortcut($ShortcutPath)
$shortcut.TargetPath = $SourceFilePath
$shortcut.Save()
