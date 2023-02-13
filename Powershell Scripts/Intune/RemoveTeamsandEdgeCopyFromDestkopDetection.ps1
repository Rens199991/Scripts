$OneDrive = @()

#Define Variables
$Lang = (Get-WinSystemLocale).LCID

if ($Lang -ne "1034") 
    {
    #United States (EN-US)
    $PP = "$env:SystemDrive\Users\"
    $PPU = (get-childitem -path $PP | Where-Object { ($_.Name -notlike "default*") } | Where-Object { ($_.Name -ne "public") }).FullName
    foreach ($OneDrive in $PPU) 
        {
        #Find $OneDrive
        $OneDriveLocations = (get-childitem -path $PPU -Filter "OneDrive*" -ErrorAction SilentlyContinue).FullName
        }
    }
elseif ($Lang -eq "1034") 
    {
    #Dutch (NL-NL)
    $PP = "$env:SystemDrive\Gebruikers\"
    $PPU = (get-childitem -path $PP | Where-Object { ($_.Name -notlike "default*") } | Where-Object { ($_.Name -ne "publiek") }).FullName
    foreach ($OneDrive in $PPU) 
        {
        #Find $OneDrive
        $OneDriveLocations = (get-childitem -path $PPU -Filter "OneDrive*" -ErrorAction SilentlyContinue).FullName
        }   
    }

foreach ($OneDriveLocation in $OneDriveLocations) 
    {
    $Icons = @()
    $AllEdgeIcons = New-Object PSobject
    $AllTeamsIcons = New-Object PSobject
    $EdgeIcons = (get-childitem -Path $OneDriveLocation  -Filter "Microsoft Edge*.lnk" -Recurse -ErrorAction SilentlyContinue)
    $TeamsIcons = (get-childitem -Path $OneDriveLocation -Filter "Microsoft Teams*.lnk" -Recurse -ErrorAction SilentlyContinue)
    $AllEdgeIcons | Add-Member -MemberType NoteProperty -Name "Fullname" -Value $EdgeIcons.fullname
    $AllTeamsIcons | Add-Member -MemberType NoteProperty -Name "Fullname" -Value $TeamsIcons.fullname
    $icons += $EdgeIcons
    $icons += $TeamsIcons
    }

if (($icons.count -eq "0")) 
    {
    #Start remediation
    
    If(-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\RemoveTeamsandEdgeCopyFromDestkopDRNOT"))
        {
        New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\RemoveTeamsandEdgeCopyFromDestkopDRNOT"
        Set-Content -Path "$($env:ProgramData)\CXN\Scripts\RemoveTeamsandEdgeCopyFromDestkopDRNOT\RemoveTeamsandEdgeCopyFromDestkopDRNOT.ps1.tag" -Value "Installed"
        }
        write-host "No Remediation Needed"
    exit 0
        }
else 
    {
    #No remediation required    
    
    If(-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\RemoveTeamsandEdgeCopyFromDestkopDRNeeded"))
        {
        New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\RemoveTeamsandEdgeCopyFromDestkopDRNeeded"
        Set-Content -Path "$($env:ProgramData)\CXN\Scripts\RemoveTeamsandEdgeCopyFromDestkopDRNeeded\RemoveTeamsandEdgeCopyFromDestkopDRNeeded.ps1.tag" -Value "Installed"
        }
    write-host "Remediation Needed"    
    exit 1
    }   
    


