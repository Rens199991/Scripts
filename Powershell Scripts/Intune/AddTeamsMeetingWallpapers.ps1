#Extra uitleg: https://workplaceascode.com/2020/04/17/distribute-custom-backgrounds-for-teams-via-intune/

$source = "https://hlbteamstrg.blob.core.windows.net/teamswallpapers/teamswallpapers.zip"

Start-BitsTransfer -Source $source -Destination $env:temp
$filename =  Split-Path -Path $source -Leaf
if(test-path -Path $env:temp\CustomBackgroundsTeams)
  {
  remove-item $env:temp\CustomBackgroundsTeams -Recurse -Force
  }
Expand-Archive -LiteralPath $env:TEMP\$filename -DestinationPath "$env:temp\CustomBackgroundsTeams" -Force

$AllLocalUsers = (Get-ChildItem -path $env:SystemDrive:\Users).name 
$AllLocalUsers += "Default"
foreach($user in $AllLocalUsers)
  {
    $destination = ("$env:SystemDrive" + "\users\" + "$user" + "\AppData\Roaming\Microsoft\Teams\Backgrounds\Uploads")
    if(!(Test-Path -Path $destination))
      {
      New-Item -Path "$destination" -ItemType Directory | out-null
      } 
    
      copy-item -path "$env:temp\CustomBackgroundsTeams\*.*" -Destination $destination -Force
  }

