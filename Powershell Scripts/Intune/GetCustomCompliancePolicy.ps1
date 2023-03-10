##Which OS
##Check if we are running Win10 or 11
$OSname = Get-WMIObject win32_operatingsystem | Select-Object Caption
if ($OSname -like "*Windows 10*") {
    $OSname = "Windows 10"
}
if ($OSname -like "*Windows 11*") {
    $OSname = "Windows 11"
}

##Which OS Version?
##Check which version number
$OSVersion = (Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion" -Name DisplayVersion).DisplayVersion

if ($OSname -eq "Windows 11") {
##Windows 11
##Scrape the release information to find latest supported versions
$url = "https://learn.microsoft.com/en-us/windows/release-health/windows11-release-information"
$content = (Invoke-WebRequest -Uri $url -UseBasicParsing).content
[regex]$regex = "(?s)<tr class=.*?</tr>"
$tables = $regex.matches($content).groups.value
$tables = $tables.replace("<td>","")
$tables = $tables.replace("</td>","")
$tables = $tables.replace('<td align="left">',"")
$tables = $tables.replace('<tr class="highlight">',"")
$tables = $tables.replace("</tr>","")

##Add each found version for array
$availableversions = @()
foreach ($table in $tables) {
    [array]$toArray = $table.Split("`n") | Where-Object {$_.Trim("")}
    $availableversions += ($toArray[0]).Trim()
}

##We want n-2 (where n is current winver edition) so grab the first two objects, here you can change it from what you want. Be aware Windows 11 has till now just 2 versions
$supportedversions = $availableversions | select-object -first 3

##Check if we are supported
if ($OSVersion -in $supportedversions) {
    $OSsupported = "True"
}
else {
    $OSsupported = "False"
}
}


if ($OSname -eq "Windows 10") {
    ##Windows 10
    ##Scrape the release information to find latest supported versions
    $url = "https://learn.microsoft.com/en-us/windows/release-health/release-information"
    $content = (Invoke-WebRequest -Uri $url -UseBasicParsing).content
    [regex]$regex = "(?s)<tr class=.*?</tr>"
    $tables = $regex.matches($content).groups.value
    $tables = $tables.replace("<td>","")
    $tables = $tables.replace("</td>","")
    $tables = $tables.replace('<td align="left">',"")
    $tables = $tables.replace('<tr class="highlight">',"")
    $tables = $tables.replace("</tr>","")
    
    ##Add each found version for array
    $availableversions = @()
    foreach ($table in $tables) {
        [array]$toArray = $table.Split("`n") | Where-Object {$_.Trim("")}
        $availableversions += ($toArray[0]).Trim()
    }

    ##We want n-2 (where n is current winver edition) so grab the first two objects, here you can change it from what you want
    $supportedversions = $availableversions | select-object -first 3
    
    ##Check if we are supported
    if ($OSVersion -in $supportedversions) {
        $OSsupported = "True"
    }
    else {
        $OSsupported = "False"
    }
    }
$hash = @{ 
    OSsupported = $OSsupported
}
return $hash | ConvertTo-Json -Compress