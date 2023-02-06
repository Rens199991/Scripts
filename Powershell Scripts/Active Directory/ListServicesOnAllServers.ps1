<#sdgsdg#>
$servers = Get-ADComputer -Filter * -SearchBase "OU=ServersGalloo,DC=galloo,DC=com"
$list = @()
$failedserver = @()
$count = 0 
foreach($s in $servers)
    {
    $i = (($count/$servers.count))*100
    Write-Progress -Activity "in Progress" -Status "$i% Complete:" -PercentComplete $i
    if((Test-netConnection $s.DNSHostName).PingSucceeded)
        {
        Write-Host $s.dnshostname
        $services = Get-CimInstance -Query "select * from win32_service" -ComputerName $s.DNSHostName 
        $list += $services | Where-Object {$_.startname -ne 'LocalSystem' -and $_.startname -ne 'NT AUTHORITY\NetworkService' -and $_.startname -ne 'NT AUTHORITY\LocalService' -and $_.startname -ne $null } 
        }
    else
        {   
        $failedserver += $s
        }
    $count ++
    }

$list | Select-Object name,startname,pscomputername | export-csv service.csv -NoClobber -NoTypeInformation


