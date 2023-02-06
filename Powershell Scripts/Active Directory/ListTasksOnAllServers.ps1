$servers = Get-ADComputer -Filter * -SearchBase "OU=ServersGalloo,DC=galloo,DC=com"
$taskfailedserver = @()
$Report = @()
$count = 0 

foreach($s in $servers)
    {
    $i = (($count/$servers.count))*100
    Write-Progress -Activity "in Progress" -Status "$i% Complete:" -PercentComplete $i
    if((Test-netConnection $s.DNSHostName).PingSucceeded)
        {
        Write-Host $s.dnshostname
        #Computer is online
        $computer = $s.Name
        $path = "\\" + $Computer + "\c$\Windows\System32\Tasks"
        $tasks = Get-ChildItem -recurse -Path $path -File
        foreach ($task in $tasks)
            {
            $Details = "" | Select-Object ComputerName, Task, User, Enabled, Application
            $AbsolutePath = $task.directory.fullname + "\" + $task.Name
            $TaskInfo = [xml](Get-Content $AbsolutePath)
            $Details.ComputerName = $Computer
            $Details.Task = $task.name
            $Details.User = $TaskInfo.task.principals.principal.userid
            $Details.Enabled = $TaskInfo.task.settings.enabled
            $Details.Application = $TaskInfo.task.actions.exec.command
            
            $found = $Details | Where-Object {$_.user -ne "S-1-5-18" -and $_.user -ne "S-1-5-19" -and $_.user -ne "S-1-5-20" -and $_.user -ne "SYSTEM" -and $_.user -ne $null -and $_.user -ne 'NT AUTHORITY\SYSTEM'}
            $Report += $found
            }
        }
    else
        {
        $taskfailedserver += $s
        }
    $count ++
        }

$Report  | export-csv tasks.csv -NoClobber -NoTypeInformation
$reportfilter = $report | Where-Object {$_.task -notmatch 'Onedrive' -and $_.task -notmatch 'Optimize Start Menu' -and $_.task -notmatch 'CreateExplorerShellUnelevatedTask' }
$reportfilter  | export-csv tasksfilter.csv -NoClobber -NoTypeInformation