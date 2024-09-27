#Create a tag file just so Intune knows this was installed
If(-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\ChangeHostfile"))
    {
    New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\ChangeHostfile"
    Set-Content -Path "$($env:ProgramData)\CXN\Scripts\ChangeHostfile\ChangeHostfile.ps1.tag" -Value "Installed"
    }

#Begin script, opgepast het Script moet lopen als System User
$DesiredIP = "192.168.2.8"
$Hostname = "DC"
$CheckHostnameOnly = $false

#Adds entry to the hosts file.
$hostsFilePath = "$($Env:WinDir)\system32\Drivers\etc\hosts"
$hostsFile = Get-Content $hostsFilePath

Write-Host "About to add $desiredIP for $Hostname to hosts file" -ForegroundColor Gray

$escapedHostname = [Regex]::Escape($Hostname)
$patternToMatch = If ($CheckHostnameOnly) { ".*\s+$escapedHostname.*" } Else { ".*$DesiredIP\s+$escapedHostname.*" }
If (($hostsFile) -match $patternToMatch)  {
    Write-Host $desiredIP.PadRight(20," ") "$Hostname - not adding; already in hosts file" -ForegroundColor DarkYellow
} 
Else {
    Write-Host $desiredIP.PadRight(20," ") "$Hostname - adding to hosts file... " -ForegroundColor Yellow -NoNewline
    Add-Content -Encoding UTF8  $hostsFilePath ("$DesiredIP".PadRight(20, " ") + "$Hostname")
    Write-Host " done"
}