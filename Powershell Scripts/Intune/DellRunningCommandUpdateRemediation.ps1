If(-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\DellRunningCommandUpdateR"))
    {
    New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\DellRunningCommandUpdateR"
    Set-Content -Path "$($env:ProgramData)\CXN\Scripts\DellRunningCommandUpdateR\DellRunningCommandUpdateR.ps1.tag" -Value "Installed"
    }

#Begin script
$DCU_folder = "C:\Program Files (x86)\Dell\CommandUpdate"
$DCU_report = "C:\Temp\Dell_report\update.log"
$DCU_exe = "$DCU_folder\dcu-cli.exe"
$DCU_category = "firmware,driver"  # bios,firmware,driver,application,others

Start-Process $DCU_exe -ArgumentList "/applyUpdates -silent -reboot=disable -updateType=$DCU_category -outputlog=$DCU_report" -Wait


