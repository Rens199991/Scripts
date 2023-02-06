#Create a tag file just so Intune knows this was installed
if(-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\CreateShortcutInStartMenu"))
    {
    New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\CreateShortcutInStartMenu"
    Set-Content -Path "$($env:ProgramData)\CXN\Scripts\CreateShortcutInStartMenu\CreateShortcutInStartMenu.ps1.tag" -Value "Installed"
    }

$objShell = New-Object -ComObject ("WScript.Shell")
$objShortCut = $objShell.CreateShortcut("C:\Users\All Users\Microsoft\Windows\Start Menu\Programs" + "\Remote Desktop.lnk")
$objShortCut.TargetPath="C:\Program Files\Remote Desktop\msrdcw.exe"
$objShortCut.Save()