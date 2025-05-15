#Create a tag file just so Intune knows this was installed
If(-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\CreateShortcutToPublicDesktop"))
    {
    New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\CreateShortcutToPublicDesktop"
    Set-Content -Path "$($env:ProgramData)\CXN\Scripts\CreateShortcutToPublicDesktop\CreateShortcutToPublicDesktop.ps1.tag" -Value "Installed"
    }


#Define the path to the Public Desktop
$publicDesktop = "$env:PUBLIC\Desktop"

#Define the shortcut name and target path
$shortcutName = "MyApp Shortcut.lnk"
$targetPath = "C:\Path\To\Your\Application.exe"  # Change this to your actual target

#Create a WScript.Shell COM object
$WshShell = New-Object -ComObject WScript.Shell

#Create the shortcut
$shortcut = $WshShell.CreateShortcut("$publicDesktop\$shortcutName")
$shortcut.TargetPath = $targetPath
$shortcut.WorkingDirectory = Split-Path $targetPath
$shortcut.Save()

Write-Host "Shortcut created on the Public Desktop."
