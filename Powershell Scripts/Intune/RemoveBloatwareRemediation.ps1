<#
Extra info --> https://andrewstaylor.com/2022/08/09/removing-bloatware-from-windows-10-11-via-script/
Run in the 64-bit context
#>

#Create a tag file just so Intune knows this was installed
If(-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\RemoveBloatwareR"))
	{
    New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\RemoveBloatwareR"
    Set-Content -Path "$($env:ProgramData)\CXN\Scripts\RemoveBloatwareR\RemoveBloatwareR.ps1.tag" -Value "Installed"
    }

############################################################################################################
#                                         Initial Setup                                                    #
#                                                                                                          #
############################################################################################################

#Begin Script
#Elevate if needed
If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) 
    {
    Write-Host "You didn't run this script as an Administrator. This script will self elevate to run as an Administrator and continue."
    Start-Sleep 1
    Write-Host "                                               3"
    Start-Sleep 1
    Write-Host "                                               2"
    Start-Sleep 1
    Write-Host "                                               1"
    Start-Sleep 1
    Start-Process powershell.exe -ArgumentList ("-NoProfile -ExecutionPolicy Bypass -File `"{0}`"" -f $PSCommandPath) -Verb RunAs
    Exit
    }

#no errors throughout
$ErrorActionPreference = 'silentlycontinue'

#Create Folder
$DebloatFolder = "C:\ProgramData\DebloatR"
If (Test-Path $DebloatFolder) 
    {
    Write-Output "$DebloatFolder exists. Skipping."
    }
Else 
    {
    Write-Output "The folder '$DebloatFolder' doesn't exist. This folder will be used for storing logs created after the script runs. Creating now."
    Start-Sleep 1
    New-Item -Path "$DebloatFolder" -ItemType Directory
    Write-Output "The folder $DebloatFolder was successfully created."
    }

Start-Transcript -Path "C:\ProgramData\DebloatR\DebloatR.log"

############################################################################################################
#                                        Remove AppX Packages                                              #
#                                                                                                          #
############################################################################################################

#Removes AppxPackages
$WhitelistedApps = 'Microsoft.WindowsNotepad|Microsoft.CompanyPortal|Microsoft.ScreenSketch|Microsoft.Paint3D|Microsoft.WindowsCalculator|Microsoft.WindowsStore|Microsoft.Windows.Photos|CanonicalGroupLimited.UbuntuonWindows|`
|Microsoft.MicrosoftStickyNotes|Microsoft.MSPaint|Microsoft.WindowsCamera|.NET|Framework|`
Microsoft.HEIFImageExtension|Microsoft.ScreenSketch|Microsoft.StorePurchaseApp|Microsoft.VP9VideoExtensions|Microsoft.WebMediaExtensions|Microsoft.WebpImageExtension|Microsoft.DesktopAppInstaller|WindSynthBerry|MIDIBerry|Slack'

#NonRemovable Apps that where getting attempted and the system would reject the uninstall, speeds up debloat and prevents 'initalizing' overlay when removing apps
$NonRemovable = '1527c705-839a-4832-9118-54d4Bd6a0c89|c5e2524a-ea46-4f67-841f-6a9465d9d515|E2A4F912-2574-4A75-9BB0-0D023378592B|F46D4000-FD22-4DB4-AC8E-4E1DDDE828FE|InputApp|Microsoft.AAD.BrokerPlugin|Microsoft.AccountsControl|`
Microsoft.BioEnrollment|Microsoft.CredDialogHost|Microsoft.ECApp|Microsoft.LockApp|Microsoft.MicrosoftEdgeDevToolsClient|Microsoft.MicrosoftEdge|Microsoft.PPIProjection|Microsoft.Win32WebViewHost|Microsoft.Windows.Apprep.ChxApp|`
Microsoft.Windows.AssignedAccessLockApp|Microsoft.Windows.CapturePicker|Microsoft.Windows.CloudExperienceHost|Microsoft.Windows.ContentDeliveryManager|Microsoft.Windows.Cortana|Microsoft.Windows.NarratorQuickStart|`
Microsoft.Windows.ParentalControls|Microsoft.Windows.PeopleExperienceHost|Microsoft.Windows.PinningConfirmationDialog|Microsoft.Windows.SecHealthUI|Microsoft.Windows.SecureAssessmentBrowser|Microsoft.Windows.ShellExperienceHost|`
Microsoft.Windows.XGpuEjectDialog|Microsoft.XboxGameCallableUI|Windows.CBSPreview|windows.immersivecontrolpanel|Windows.PrintDialog|Microsoft.VCLibs.140.00|Microsoft.Services.Store.Engagement|Microsoft.UI.Xaml.2.0|*Nvidia*'

Get-AppxPackage -AllUsers | Where-Object {$_.Name -NotMatch $WhitelistedApps -and $_.Name -NotMatch $NonRemovable} | Remove-AppxPackage
Get-AppxPackage -allusers | Where-Object {$_.Name -NotMatch $WhitelistedApps -and $_.Name -NotMatch $NonRemovable} | Remove-AppxPackage
Get-AppxProvisionedPackage -Online | Where-Object {$_.PackageName -NotMatch $WhitelistedApps -and $_.PackageName -NotMatch $NonRemovable} | Remove-AppxProvisionedPackage -Online

##Remove bloat
$Bloatware = 
    @(
        #Unnecessary Windows 10/11 AppX Apps
        "Microsoft.BingNews"
        "Microsoft.GetHelp"
        "Microsoft.Getstarted"
        "Microsoft.Messaging"
        "Microsoft.Microsoft3DViewer"
        "Microsoft.MicrosoftOfficeHub"
        "Microsoft.MicrosoftSolitaireCollection"
        "Microsoft.NetworkSpeedTest"
        "Microsoft.MixedReality.Portal"
        "Microsoft.News"
        #"Microsoft.Office.Lens"
        #"Microsoft.Office.OneNote"
        "Microsoft.Office.Sway"
        "Microsoft.OneConnect"
        "Microsoft.People"
        "Microsoft.Print3D"
        #"Microsoft.RemoteDesktop"
        "Microsoft.SkypeApp"
        "Microsoft.StorePurchaseApp"
        #"Microsoft.Office.Todo.List"
        #"Microsoft.Whiteboard"
        #"Microsoft.WindowsAlarms"
        #"Microsoft.WindowsCamera"
        "microsoft.windowscommunicationsapps"
        "Microsoft.WindowsFeedbackHub"
        "Microsoft.WindowsMaps"
        "Microsoft.WindowsSoundRecorder"
        "Microsoft.Xbox.TCUI"
        "Microsoft.XboxApp"
        "Microsoft.XboxGameOverlay"
        "Microsoft.XboxIdentityProvider"
        "Microsoft.XboxSpeechToTextOverlay"
        "Microsoft.ZuneMusic"
        "Microsoft.ZuneVideo"
        #"MicrosoftTeams"
        "Microsoft.YourPhone"
        "Microsoft.XboxGamingOverlay_5.721.10202.0_neutral_~_8wekyb3d8bbwe"
        "Microsoft.GamingApp"
        "SpotifyAB.SpotifyMusic"
        "Disney.37853FC22B2CE"
        "*EclipseManager*"
        "*ActiproSoftwareLLC*"
        "*AdobeSystemsIncorporated.AdobePhotoshopExpress*"
        "*Duolingo-LearnLanguagesforFree*"
        "*PandoraMediaInc*"
        "*CandyCrush*"
        "*BubbleWitch3Saga*"
        "*Wunderlist*"
        "*Flipboard*"
        "*Twitter*"
        "*Facebook*"
        "*Spotify*"
        "*Minecraft*"
        "*Royal Revolt*"
        "*Sway*"
        "*Speed Test*"
        "*Dolby*"
        #"*Office*"
        "*Disney*"
             
#Optional: Typically not removed but you can if you need to for some reason
        #"*Microsoft.Advertising.Xaml_10.1712.5.0_x64__8wekyb3d8bbwe*"
        #"*Microsoft.Advertising.Xaml_10.1712.5.0_x86__8wekyb3d8bbwe*"
        #"*Microsoft.BingWeather*"
        #"*Microsoft.MSPaint*"
        #"*Microsoft.MicrosoftStickyNotes*"
        #"*Microsoft.Windows.Photos*"
        #"*Microsoft.WindowsCalculator*"
        #"*Microsoft.WindowsStore*"
    )

foreach ($Bloat in $Bloatware) 
    {
    Get-AppxPackage -allusers -Name $Bloat| Remove-AppxPackage
    Get-AppxProvisionedPackage -Online | Where-Object DisplayName -like $Bloat | Remove-AppxProvisionedPackage -Online
    Write-Host "Trying to remove $Bloat."
    }

############################################################################################################
#                                        Remove Registry Keys                                              #
#                                                                                                          #
############################################################################################################
    
#These are the registry keys that it will delete.            
$Keys = 
    @(
    #Remove Background Tasks
    "HKCR:\Extensions\ContractId\Windows.BackgroundTasks\PackageId\46928bounde.EclipseManager_2.2.4.51_neutral__a5h4egax66k6y"
    "HKCR:\Extensions\ContractId\Windows.BackgroundTasks\PackageId\ActiproSoftwareLLC.562882FEEB491_2.6.18.18_neutral__24pqs290vpjk0"
    "HKCR:\Extensions\ContractId\Windows.BackgroundTasks\PackageId\Microsoft.MicrosoftOfficeHub_17.7909.7600.0_x64__8wekyb3d8bbwe"
    "HKCR:\Extensions\ContractId\Windows.BackgroundTasks\PackageId\Microsoft.PPIProjection_10.0.15063.0_neutral_neutral_cw5n1h2txyewy"
    "HKCR:\Extensions\ContractId\Windows.BackgroundTasks\PackageId\Microsoft.XboxGameCallableUI_1000.15063.0.0_neutral_neutral_cw5n1h2txyewy"
    "HKCR:\Extensions\ContractId\Windows.BackgroundTasks\PackageId\Microsoft.XboxGameCallableUI_1000.16299.15.0_neutral_neutral_cw5n1h2txyewy"
            
    #Windows File
    "HKCR:\Extensions\ContractId\Windows.File\PackageId\ActiproSoftwareLLC.562882FEEB491_2.6.18.18_neutral__24pqs290vpjk0"
            
    #Registry keys to delete if they aren't uninstalled by RemoveAppXPackage/RemoveAppXProvisionedPackage
    "HKCR:\Extensions\ContractId\Windows.Launch\PackageId\46928bounde.EclipseManager_2.2.4.51_neutral__a5h4egax66k6y"
    "HKCR:\Extensions\ContractId\Windows.Launch\PackageId\ActiproSoftwareLLC.562882FEEB491_2.6.18.18_neutral__24pqs290vpjk0"
    "HKCR:\Extensions\ContractId\Windows.Launch\PackageId\Microsoft.PPIProjection_10.0.15063.0_neutral_neutral_cw5n1h2txyewy"
    "HKCR:\Extensions\ContractId\Windows.Launch\PackageId\Microsoft.XboxGameCallableUI_1000.15063.0.0_neutral_neutral_cw5n1h2txyewy"
    "HKCR:\Extensions\ContractId\Windows.Launch\PackageId\Microsoft.XboxGameCallableUI_1000.16299.15.0_neutral_neutral_cw5n1h2txyewy"
            
    #Scheduled Tasks to delete
    "HKCR:\Extensions\ContractId\Windows.PreInstalledConfigTask\PackageId\Microsoft.MicrosoftOfficeHub_17.7909.7600.0_x64__8wekyb3d8bbwe"
            
    #Windows Protocol Keys
    "HKCR:\Extensions\ContractId\Windows.Protocol\PackageId\ActiproSoftwareLLC.562882FEEB491_2.6.18.18_neutral__24pqs290vpjk0"
    "HKCR:\Extensions\ContractId\Windows.Protocol\PackageId\Microsoft.PPIProjection_10.0.15063.0_neutral_neutral_cw5n1h2txyewy"
    "HKCR:\Extensions\ContractId\Windows.Protocol\PackageId\Microsoft.XboxGameCallableUI_1000.15063.0.0_neutral_neutral_cw5n1h2txyewy"
    "HKCR:\Extensions\ContractId\Windows.Protocol\PackageId\Microsoft.XboxGameCallableUI_1000.16299.15.0_neutral_neutral_cw5n1h2txyewy"

    #Windows Share Target
    "HKCR:\Extensions\ContractId\Windows.ShareTarget\PackageId\ActiproSoftwareLLC.562882FEEB491_2.6.18.18_neutral__24pqs290vpjk0"
    )
        
#This writes the output of each key it is removing and also removes the keys listed above.
ForEach ($Key in $Keys) 
    {
    Write-Host "Removing $Key from registry"
    Remove-Item $Key -Recurse
    }

#Disables Windows Feedback Experience
Write-Host "Disabling Windows Feedback Experience program"
$Advertising = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo"
If (Test-Path $Advertising) 
    {
    Set-ItemProperty $Advertising Enabled -Value 0 
    }
            
#Stops Cortana from being used as part of your Windows Search Function
Write-Host "Stopping Cortana from being used as part of your Windows Search Function"
$Search = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search"
If (Test-Path $Search) 
    {
    Set-ItemProperty $Search AllowCortana -Value 0 
    }

#Disables Web Search in Start Menu
Write-Host "Disabling Bing Search in Start Menu"
$WebSearch = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search"
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" BingSearchEnabled -Value 0 
If (!(Test-Path $WebSearch)) 
    {
    New-Item $WebSearch
    }

Set-ItemProperty $WebSearch DisableWebSearch -Value 1 
            
#Stops the Windows Feedback Experience from sending anonymous data
Write-Host "Stopping the Windows Feedback Experience program"
Period = "HKCU:\Software\Microsoft\Siuf\Rules"
If (!(Test-Path $Period)) 
    { 
    New-Item $Period
    }

Set-ItemProperty $Period PeriodInNanoSeconds -Value 0 

#Prevents bloatware applications from returning and removes Start Menu suggestions               
Write-Host "Adding Registry key to prevent bloatware apps from returning"
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent"
$registryOEM = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager"

If (!(Test-Path $registryPath)) 
    { 
    New-Item $registryPath
    }

Set-ItemProperty $registryPath DisableWindowsConsumerFeatures -Value 1 

If (!(Test-Path $registryOEM)) 
    {
    New-Item $registryOEM
    }

Set-ItemProperty $registryOEM  ContentDeliveryAllowed -Value 0 
Set-ItemProperty $registryOEM  OemPreInstalledAppsEnabled -Value 0 
Set-ItemProperty $registryOEM  PreInstalledAppsEnabled -Value 0 
Set-ItemProperty $registryOEM  PreInstalledAppsEverEnabled -Value 0 
Set-ItemProperty $registryOEM  SilentInstalledAppsEnabled -Value 0 
Set-ItemProperty $registryOEM  SystemPaneSuggestionsEnabled -Value 0          
    
#Preping mixed Reality Portal for removal    
Write-Host "Setting Mixed Reality Portal value to 0 so that you can uninstall it in Settings"
$Holo = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Holographic"    
    If (Test-Path $Holo) 
    {
    Set-ItemProperty $Holo  FirstRunSucceeded -Value 0 
    }

#Disables Wi-fi Sense
Write-Host "Disabling Wi-Fi Sense"
$WifiSense1 = "HKLM:\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting"
$WifiSense2 = "HKLM:\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots"
$WifiSense3 = "HKLM:\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\config"

If (!(Test-Path $WifiSense1)) 
    {
    New-Item $WifiSense1
    }

Set-ItemProperty $WifiSense1  Value -Value 0 
    If (!(Test-Path $WifiSense2)) 
    {
    New-Item $WifiSense2
    }

Set-ItemProperty $WifiSense2  Value -Value 0 
Set-ItemProperty $WifiSense3  AutoConnectAllowedOEM -Value 0 
        
#Disables live tiles
Write-Host "Disabling live tiles"
$Live = "HKCU:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\PushNotifications"    
If (!(Test-Path $Live)) 
    {      
    New-Item $Live
    }

Set-ItemProperty $Live  NoTileApplicationNotification -Value 1 
        
#Turns off Data Collection via the AllowTelemtry key by changing it to 0
Write-Host "Turning off Data Collection"
$DataCollection1 = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection"
$DataCollection2 = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection"
$DataCollection3 = "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\DataCollection"    
If (Test-Path $DataCollection1) 
    {
    Set-ItemProperty $DataCollection1  AllowTelemetry -Value 0 
    }

If (Test-Path $DataCollection2) 
    {
    Set-ItemProperty $DataCollection2  AllowTelemetry -Value 0 
    }

If (Test-Path $DataCollection3) 
    {
    Set-ItemProperty $DataCollection3  AllowTelemetry -Value 0 
    }
    
#Disables People icon on Taskbar
Write-Host "Disabling People icon on Taskbar"
$People = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People'
If (Test-Path $People) 
    {
    Set-ItemProperty $People -Name PeopleBand -Value 0
    }

Write-Host "Disabling Cortana"
$Cortana1 = "HKCU:\SOFTWARE\Microsoft\Personalization\Settings"
$Cortana2 = "HKCU:\SOFTWARE\Microsoft\InputPersonalization"
$Cortana3 = "HKCU:\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore"

If (!(Test-Path $Cortana1)) 
    {
    New-Item $Cortana1
    }

Set-ItemProperty $Cortana1 AcceptedPrivacyPolicy -Value 0 
    If (!(Test-Path $Cortana2)) 
    {
    New-Item $Cortana2
    }

Set-ItemProperty $Cortana2 RestrictImplicitTextCollection -Value 1 
Set-ItemProperty $Cortana2 RestrictImplicitInkCollection -Value 1 
    If (!(Test-Path $Cortana3))
    {
    New-Item $Cortana3
    }

Set-ItemProperty $Cortana3 HarvestContacts -Value 0

#Removes 3D Objects from the 'My Computer' submenu in explorer
Write-Host "Removing 3D Objects from explorer 'My Computer' submenu"
$Objects32 = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}"
$Objects64 = "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}"
    If (Test-Path $Objects32) 
    {
    Remove-Item $Objects32 -Recurse 
    }
    If (Test-Path $Objects64) 
    {
    Remove-Item $Objects64 -Recurse 
    }
   
############################################################################################################
#                                        Remove Scheduled Tasks                                            #
#                                                                                                          #
############################################################################################################

#Disables scheduled tasks that are considered unnecessary 
Write-Host "Disabling scheduled tasks"
$task1 = Get-ScheduledTask -TaskName XblGameSaveTaskLogon -ErrorAction SilentlyContinue
if ($null -ne $task1) 
    {
    Get-ScheduledTask  XblGameSaveTaskLogon | Disable-ScheduledTask -ErrorAction SilentlyContinue
    }
    $task2 = Get-ScheduledTask -TaskName XblGameSaveTask -ErrorAction SilentlyContinue
if ($null -ne $task2) 
    {
    Get-ScheduledTask  XblGameSaveTask | Disable-ScheduledTask -ErrorAction SilentlyContinue
    }
    $task3 = Get-ScheduledTask -TaskName Consolidator -ErrorAction SilentlyContinue
if ($null -ne $task3) 
    {
    Get-ScheduledTask  Consolidator | Disable-ScheduledTask -ErrorAction SilentlyContinue
    }
    $task4 = Get-ScheduledTask -TaskName UsbCeip -ErrorAction SilentlyContinue
if ($null -ne $task4) 
    {
    Get-ScheduledTask  UsbCeip | Disable-ScheduledTask -ErrorAction SilentlyContinue
    }
    $task5 = Get-ScheduledTask -TaskName DmClient -ErrorAction SilentlyContinue
if ($null -ne $task5) 
    {
    Get-ScheduledTask  DmClient | Disable-ScheduledTask -ErrorAction SilentlyContinue
    }
    $task6 = Get-ScheduledTask -TaskName DmClientOnScenarioDownload -ErrorAction SilentlyContinue
if ($null -ne $task6) 
    {
    Get-ScheduledTask  DmClientOnScenarioDownload | Disable-ScheduledTask -ErrorAction SilentlyContinue
    }

############################################################################################################
#                                             Disable Services                                             #
#                                                                                                          #
############################################################################################################
#Disabling the Diagnostics Tracking Service
Write-Host "Stopping and disabling Diagnostics Tracking Service"
Stop-Service "DiagTrack"
Set-Service "DiagTrack" -StartupType Disabled

############################################################################################################
#                                        Windows 11 Specific                                               #
#                                                                                                          #
############################################################################################################
#Windows 11 Customisations
write-host "Removing Windows 11 Customisations"

#Remove XBox Game Bar
Get-AppxPackage -allusers Microsoft.XboxGamingOverlay | Remove-AppxPackage
write-host "Removed Xbox Gaming Overlay"
Get-AppxPackage -allusers Microsoft.XboxGameCallableUI | Remove-AppxPackage
write-host "Removed Xbox Game Callable UI"

#Remove Cortana
Get-AppxPackage -allusers Microsoft.549981C3F5F10 | Remove-AppxPackage
write-host "Removed Cortana"

#Remove GetStarted
Get-AppxPackage -allusers *getstarted* | Remove-AppxPackage
write-host "Removed Get Started"

#Remove Parental Controls
Get-AppxPackage -allusers Microsoft.Windows.ParentalControls | Remove-AppxPackage 
write-host "Removed Parental Controls"

#Remove Teams Chat
<#
$MSTeams = "MicrosoftTeams"

$WinPackage = Get-AppxPackage -allusers | Where-Object {$_.Name -eq $MSTeams}
$ProvisionedPackage = Get-AppxProvisionedPackage -Online | Where-Object { $_.DisplayName -eq $WinPackage }
If ($null -ne $WinPackage) 
    {
    Remove-AppxPackage  -Package $WinPackage.PackageFullName
    } 

If ($null -ne $ProvisionedPackage) 
    {
    Remove-AppxProvisionedPackage -online -Packagename $ProvisionedPackage.Packagename
    }

 write-host "Removed Teams Chat"
#>

############################################################################################################
#                                             Clear Start Menu                                             #
#                                                                                                          #
############################################################################################################
<#
write-host "Clearing Start Menu"
#Delete layout file if it already exists

If(Test-Path C:\Windows\StartLayout.xml)
    {
    Remove-Item C:\Windows\StartLayout.xml
    }   

write-host "Creating Default Layout"
#Creates the blank layout file

Write-Output "<LayoutModificationTemplate xmlns:defaultlayout=""http://schemas.microsoft.com/Start/2014/FullDefaultLayout"" xmlns:start=""http://schemas.microsoft.com/Start/2014/StartLayout"" Version=""1"" xmlns=""http://schemas.microsoft.com/Start/2014/LayoutModification"">" >> C:\Windows\StartLayout.xml

Write-Output " <LayoutOptions StartTileGroupCellWidth=""6"" />" >> C:\Windows\StartLayout.xml

Write-Output " <DefaultLayoutOverride>" >> C:\Windows\StartLayout.xml

Write-Output " <StartLayoutCollection>" >> C:\Windows\StartLayout.xml

Write-Output " <defaultlayout:StartLayout GroupCellWidth=""6"" />" >> C:\Windows\StartLayout.xml

Write-Output " </StartLayoutCollection>" >> C:\Windows\StartLayout.xml

Write-Output " </DefaultLayoutOverride>" >> C:\Windows\StartLayout.xml

Write-Output "</LayoutModificationTemplate>" >> C:\Windows\StartLayout.xml
#>

############################################################################################################
#                                        Disable Edge Surf Game                                            #
#                                                                                                          #
############################################################################################################

$surf = "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge"
If (!(Test-Path $surf)) 
    {
    New-Item $surf
    }

New-ItemProperty -Path $surf -Name 'AllowSurfGame' -Value 0 -PropertyType DWord

############################################################################################################
#                                        Remove Manufacturer Bloat                                         #
#                                                                                                          #
############################################################################################################

#Check Manufacturer
write-host "Detecting Manufacturer"
$details = Get-CimInstance -ClassName Win32_ComputerSystem
$manufacturer = $details.Manufacturer

if ($manufacturer -like "*HP*") 
    {
        Write-Host "HP detected"
        Import-Module PackageManagement
     
$UninstallPackages = 
    @(
    "AD2F1837.HPJumpStarts"
    "AD2F1837.HPPCHardwareDiagnosticsWindows"
    "AD2F1837.HPPowerManager"
    "AD2F1837.HPPrivacySettings"
    "AD2F1837.HPSureShieldAI"
    "AD2F1837.HPSystemInformation"
    "AD2F1837.HPQuickDrop"
    "AD2F1837.HPProgrammableKey"
    "AD2F1837.HPWorkWell"
    "AD2F1837.myHP"
    "AD2F1837.HPDesktopSupportUtilities"
    "AD2F1837.HPEasyClean"
    "AD2F1837.HPSystemInformation" 
    "AD2F1837.HPSupportAssistant"
    )

$UninstallPrograms = 
    @(
    "HP Wolf Security"
    "HP Wolf Security Application Support for Sure Sense"
    "HP Wolf Security Application Support for Windows"
    "HP Wolf Security - Console"
    "HP Wolf Security For Busines"
    "HP Client Security Manager"
    "HP Connection Optimizer"
    "HP Documentation"
    "HP MAC Address Manager"
    "HP Notifications"
    "HP System Default Settings"
    "HP Sure Click"
    "HP Sure Click active"
    "HP Privacy Settings"
    "HP Power Manager"
    "HP Sure Run"
    "HP Sure Recover"
    "HP Sure Sense"
    "HP Sure Sense Installer"
    "HP Sure Run Module"
    "HP Security Update Service"
    )
    
$InstalledPackages = Get-AppxPackage -AllUsers | Where-Object {($UninstallPackages -contains $_.Name)} 
$ProvisionedPackages = Get-AppxProvisionedPackage -Online | Where-Object {($UninstallPackages -contains $_.DisplayName)} 
$InstalledPrograms = Get-Package | Where-Object {$UninstallPrograms -contains $_.Name}
    
#Remove provisioned packages first
ForEach ($ProvPackage in $ProvisionedPackages) 
    {
    Write-Host -Object "Attempting to remove provisioned package: [$($ProvPackage.DisplayName)]..."
        Try 
            {
            $Null = Remove-AppxProvisionedPackage -PackageName $ProvPackage.PackageName -Online -ErrorAction Stop
            Write-Host -Object "Successfully removed provisioned package: [$($ProvPackage.DisplayName)]"
            }
        Catch 
            {
            Write-Warning -Message "Failed to remove provisioned package: [$($ProvPackage.DisplayName)]"
            }
    }
    
#Remove appx packages
ForEach ($AppxPackage in $InstalledPackages)
    {                                      
    Write-Host -Object "Attempting to remove Appx package: [$($AppxPackage.Name)]..."
    Try 
        {
        $Null = Remove-AppxPackage -Package $AppxPackage.PackageFullName -AllUsers -ErrorAction Stop
        Write-Host -Object "Successfully removed Appx package: [$($AppxPackage.Name)]"
        }
    Catch 
        {
        Write-Warning -Message "Failed to remove Appx package: [$($AppxPackage.Name)]"
        }
    }


#Remove installed programs
ForEach ($InstalledProgram in $InstalledPrograms)
    {
    Write-Host -Object "Attempting to uninstall: [$($InstalledProgram.Name)]..."
    Try 
        {
        $Null = $InstalledProgram | Uninstall-Package -AllVersions -Force -ErrorAction Stop
        Write-Host -Object "Successfully uninstalled: [$($InstalledProgram.Name)]"
        }
    Catch 
        {
        Write-Warning -Message "Failed to uninstall: [$($InstalledProgram.Name)]"
        }
    }

#Remove HP Programs Alternative Method

#Wolf Security
Start-Process "msiexec.exe" -ArgumentList "/qn /norestart /x {3F5C3ADE-01FF-11EC-A0D9-3863BB3CB5A8}" -wait -verbose
Start-Process "msiexec.exe" -ArgumentList "/qn /norestart /x {0E2E04B0-9EDD-11EB-B38C-10604B96B11E}" -wait -verbose
    
#HP Wolf Security Application Support for Sure Sense
Start-Process "msiexec.exe" -ArgumentList "/qn /norestart /x {7824AE18-69B2-4236-AFF4-BA2302E7E662}" -wait -verbose

#HP Wolf Security Application Support for Windows
Start-Process "msiexec.exe" -ArgumentList "/qn /norestart /x {5621D48E-25BD-4A4A-B336-5C6D63ECC922}" -wait -verbose
Start-Process "msiexec.exe" -ArgumentList "/qn /norestart /x {76FD5CC3-3B06-4C18-9103-FBDB3C4C7F15}" -wait -verbose

#HP Client Security Manger = {4B78BFF4-3BF3-4D31-AA1D-00D6AC370CE4}
Start-Process "msiexec.exe" -ArgumentList "/qn /norestart /x {4B78BFF4-3BF3-4D31-AA1D-00D6AC370CE4}" -wait -verbose
Start-Process "msiexec.exe" -Argumentlist "/qn /norestart /x {39930586-2677-432B-B928-F970FB43F46F}" -wait -verbose
Start-Process "msiexec.exe" -Argumentlist "/qn /norestart /x {3B46DFDA-6155-423B-BCBB-F1C267E4ADD9}" -wait -verbose
Start-Process "msiexec.exe" -Argumentlist "/qn /norestart /x {3AF15EEA-8EDF-4393-BB6C-CF8A9986486A}" -wait -verbose
Start-Process "msiexec.exe" -Argumentlist "/qn /norestart /x {CA19DC3C-DA9E-40B1-B501-710F437604C0}" -wait -verbose
Start-Process "msiexec.exe" -Argumentlist "/qn /norestart /x {D5510D28-D0E4-433E-A0F3-EE3FCECA60D2}" -wait -verbose
Start-Process "msiexec.exe" -Argumentlist "/qn /norestart /x {167AA1D5-8412-44BC-A003-B7A3662D1CE2}" -wait -verbose
Start-Process "msiexec.exe" -Argumentlist "/qn /norestart /x {82E616DB-8BE9-46B7-AE42-60200985AD78}" -wait -verbose
    
#HP Security Update Service = {F95ACB1A-6CB3-4360-BC16-A5E375B22720}
Start-Process "msiexec.exe" -ArgumentList "/qn /norestart /x {F95ACB1A-6CB3-4360-BC16-A5E375B22720}" -wait -verbose

#HP HP Wolf Security Application Support for Sure Sense = {ABCC4F50-65F9-429D-B979-55BB9B635B33}
Start-Process "msiexec.exe" -ArgumentList "/qn /norestart /x {ABCC4F50-65F9-429D-B979-55BB9B635B33}" -wait -verbose

#HP Connection Opzimizer
#TO DO: Uninstall MSI op zoeken


#HP System Default Settings
Start-Process "msiexec.exe" -Argumentlist "/qn /norestart /x {5C90D8CF-F12A-41C6-9007-3B651A1F0D78}" -wait -verbose
Start-Process "msiexec.exe" -Argumentlist "/qn /norestart /x {28FE073B-1230-4BF6-830C-7434FD0C0069}" -wait -verbose
Start-Process "msiexec.exe" -Argumentlist "/qn /norestart /x {C422BF2C-E570-4D3E-8718-7C641B190DB2}" -wait -verbose
Start-Process "msiexec.exe" -Argumentlist "/qn /norestart /x {39011DEC-8956-401E-8369-421D402FFF52}" -wait -verbose

#HP Documentation
Start-Process "msiexec.exe" -Argumentlist "/qn /norestart /x {73A33079-D1A0-4469-8903-C4A48B4975E2}" -wait -verbose
Start-Process "msiexec.exe" -Argumentlist "/qn /norestart /x {C8D60CF4-BE7A-487E-BD36-535111BDB0FE}" -wait -verbose
Start-Process "msiexec.exe" -Argumentlist "/qn /norestart /x {06600E94-1C34-40E2-AB09-D30AECF78172}" -wait -verbose
Start-Process "msiexec.exe" -Argumentlist "/qn /norestart /x {025D3904-FA39-4AA2-A05B-9EFAAF36B1F2}" -wait -verbose
Start-Process "msiexec.exe" -Argumentlist "/qn /norestart /x {1F0493F6-311D-44E5-A9E6-F0D4C63FB8FD}" -wait -verbose
Start-Process "msiexec.exe" -Argumentlist "/qn /norestart /x {5340A3C6-4169-484A-ADA7-63BCF5C557A0}" -wait -verbose
Start-Process "msiexec.exe" -Argumentlist "/qn /norestart /x {7573D7E5-02BB-4903-80EB-36073A99BC8D}" -wait -verbose
Start-Process "msiexec.exe" -Argumentlist "/qn /norestart /x {791A06E2-340F-43B0-8FAB-62D151339362}" -wait -verbose
Start-Process "msiexec.exe" -Argumentlist "/qn /norestart /x {8327F6D2-C8CC-49B5-B8D1-46C83909650E}" -wait -verbose
Start-Process "msiexec.exe" -Argumentlist "/qn /norestart /x {84F0C8C0-263A-4B3A-888D-2A5FDEA15401}" -wait -verbose
Start-Process "msiexec.exe" -Argumentlist "/qn /norestart /x {8ABB6A99-E2D5-47E4-905A-2FD4657D235E}" -wait -verbose
Start-Process "msiexec.exe" -Argumentlist "/qn /norestart /x {9867A917-5D17-40DE-83BA-BEA5293194B1}" -wait -verbose
Start-Process "msiexec.exe" -Argumentlist "/qn /norestart /x {A6365256-0FBA-4DCD-88CE-D92A4DC9328E}" -wait -verbose
Start-Process "msiexec.exe" -Argumentlist "/qn /norestart /x {A1CFA587-90D4-4DE6-B200-68CC0F92252F}" -wait -verbose
Start-Process "msiexec.exe" -Argumentlist "/qn /norestart /x {53AE55F3-8E99-4776-A347-06222894ECD3}" -wait -verbose
Start-Process "msiexec.exe" -Argumentlist "/qn /norestart /x {95CC589C-8D98-4539-9878-4E6A342304F2}" -wait -verbose
Start-Process "msiexec.exe" -Argumentlist "/qn /norestart /x {9D20F550-4222-49A7-A7A7-7CAAB2E16C9C}" -wait -verbose
Start-Process "msiexec.exe" -Argumentlist "/qn /norestart /x {89A12FD9-8FA0-4EB9-AE9A-34C7EB25C25B}" -wait -verbose
Start-Process "msiexec.exe" -Argumentlist "/qn /norestart /x {25F3EC6C-BB03-4CEB-B36C-E656A9DD149E}" -wait -verbose    



Write-Host "Removed HP bloat"
    }
    
#Remove Dell bloat
if ($manufacturer -like "*Dell*") 
    {
    Write-Host "Dell detected"

    $UninstallPrograms = 
        @(
            "Dell Optimizer"
            "DellOptimizerUI"
            "Dell Power Manager"
            "Dell Power Manager Service"
            #"Dell SupportAssist OS Recovery"
            #"Dell SupportAssist OS Recovery Plugin for Dell Update"
            #"Dell SupportAssist"
            "Dell SUpportAssist Remediation"
            "Dell Optimizer Service"
            "Dell OS Recovery Tool"
            #"Dell Command | Update"
            #"Dell Command | Update for Windows 10"
            #"Dell Display Manager 2.0"
            "Dell Core Services"   
        )

    $InstalledPackages = Get-AppxPackage -AllUsers | Where-Object {($UninstallPackages -contains $_.Name)} 
    $ProvisionedPackages = Get-AppxProvisionedPackage -Online | Where-Object {($UninstallPackages -contains $_.DisplayName)}
    $InstalledPrograms = Get-Package | Where-Object {$UninstallPrograms -contains $_.Name}

#Remove provisioned packages first
    ForEach ($ProvPackage in $ProvisionedPackages) 
        {
        Write-Host -Object "Attempting to remove provisioned package: [$($ProvPackage.DisplayName)]..."
            Try 
            {
            $Null = Remove-AppxProvisionedPackage -PackageName $ProvPackage.PackageName -Online -ErrorAction SilentlyContinue
            Write-Host -Object "Successfully removed provisioned package: [$($ProvPackage.DisplayName)]"
            }
            Catch 
            {
            Write-Warning -Message "Failed to remove provisioned package: [$($ProvPackage.DisplayName)]"
            }
        }
        

#Remove appx packages
    ForEach ($AppxPackage in $InstalledPackages) 
        {                                        
        Write-Host -Object "Attempting to remove Appx package: [$($AppxPackage.Name)]..."   
        Try 
            {   
            $Null = Remove-AppxPackage -Package $AppxPackage.PackageFullName -AllUsers -ErrorAction SilentlyContinue
            Write-Host -Object "Successfully removed Appx package: [$($AppxPackage.Name)]"
            }
        Catch 
            {
            Write-Warning -Message "Failed to remove Appx package: [$($AppxPackage.Name)]"
            }
        }
        
#Remove installed programs
    Foreach ($InstalledProgram in $InstalledPrograms)
        {
        Write-Host -Object "Attempting to uninstall: [$($InstalledProgram.Name)]..."
        Try 
            {
            $Null = $InstalledProgram | Uninstall-Package -AllVersions -Force -ErrorAction SilentlyContinue
            Write-Host -Object "Successfully uninstalled: [$($InstalledProgram.Name)]"
            }
        Catch 
            {
            Write-Warning -Message "Failed to uninstall: [$($InstalledPrograms.Name)]"
            }
        }


#Remove Programs Alternate method
    Start-Process "msiexec.exe" -ArgumentList "/qn /norestart /x {E27862BD-4371-4245-896A-7EBE989B6F7F} " -Wait -Verbose

    Start-Process "msiexec.exe" -ArgumentList "/qn /norestart /x {17268bdc-8263-4bc2-a5e2-7de6ce0122bd} " -Wait -Verbose
    Start-Process "msiexec.exe" -ArgumentList "/qn /norestart /x {286A9ADE-A581-43E8-AA85-6F5D58C7DC88} " -Wait -Verbose
    Start-Process "msiexec.exe" -ArgumentList "/qn /norestart /x {2a8bafd6-22ae-4d0e-87a4-686b2a4a2ab0} " -Wait -Verbose

    Start-Process "C:\ProgramData\Package Cache\{17268bdc-8263-4bc2-a5e2-7de6ce0122bd}\DellSupportAssistRemediationServiceInstaller.exe" -ArgumentList "/uninstall /quiet" -Wait -Verbose
    Start-Process "C:\ProgramData\Package Cache\{2a8bafd6-22ae-4d0e-87a4-686b2a4a2ab0}\DellUpdateSupportAssistPlugin.exe" -ArgumentList "/uninstall /quiet" -Wait -Verbose
    Start-Process "C:\Program Files (x86)\InstallShield Installation Information\{286A9ADE-A581-43E8-AA85-6F5D58C7DC88}\DellOptimizer.exe" -ArgumentList "/remove /runfromtemp" -Verbose

    Write-Host "Removed Dell bloat"
    }

#Remove Lenovo bloat
if ($manufacturer -like "*Lenovo") 
    {
    Write-Host "Lenovo detected"
    }

############################################################################################################
#                                        Remove Any other installed crap                                   #
#                                                                                                          #
############################################################################################################

#McAfee
write-host "Detecting McAfee"
$mcafeeinstalled = "false"
$InstalledSoftware = Get-ChildItem "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall"
foreach($obj in $InstalledSoftware)
    {
     $name = $obj.GetValue('DisplayName')
        if ($name -like "*McAfee*") 
        {
        $mcafeeinstalled = "true"
        }
    }

$InstalledSoftware32 = Get-ChildItem "HKLM:\Software\WOW6432NODE\Microsoft\Windows\CurrentVersion\Uninstall"
foreach($obj32 in $InstalledSoftware32)
    {
     $name32 = $obj32.GetValue('DisplayName')
        if ($name32 -like "*McAfee*") 
            {
            $mcafeeinstalled = "true"
            }
    }

#Remove McAfee bloat
if ($mcafeeinstalled -eq "true") 
    {
    Write-Host "McAfee detected"
    write-host "Downloading McAfee Removal Tool"
    $URL = 'https://github.com/andrew-s-taylor/public/raw/main/De-Bloat/mcafeeclean.zip'
    $destination = 'C:\ProgramData\Debloat\mcafee.zip'
    Invoke-WebRequest -Uri $URL -OutFile $destination -Method Get
    Expand-Archive $destination -DestinationPath "C:\ProgramData\Debloat" -Force
    write-host "Removing McAfee"
    start-process "C:\ProgramData\Debloat\Mccleanup.exe" -ArgumentList "-p StopServices,MFSY,PEF,MXD,CSP,Sustainability,MOCP,MFP,APPSTATS,Auth,EMproxy,FWdiver,HW,MAS,MAT,MBK,MCPR,McProxy,McSvcHost,VUL,MHN,MNA,MOBK,MPFP,MPFPCU,MPS,SHRED,MPSCU,MQC,MQCCU,MSAD,MSHR,MSK,MSKCU,MWL,NMC,RedirSvc,VS,REMEDIATION,MSC,YAP,TRUEKEY,LAM,PCB,Symlink,SafeConnect,MGS,WMIRemover,RESIDUE -v -s"
    write-host "McAfee Removal Tool has been run"
    }

<#
#Make sure Intune hasn't installed anything so we don't remove installed apps
$intunepath = "HKLM:\SOFTWARE\Microsoft\IntuneManagementExtension\Win32Apps"
$intunecomplete = @(Get-ChildItem $intunepath).count
if ($intunecomplete -eq 0) 
    {
    $whitelistapps = 
        @(
        "Microsoft Update Health Tools"
        "Microsoft Intune Management Extension"
        "Microsoft Edge"
        "Microsoft Edge Update"
        "Microsoft Edge WebView2 Runtime"
        "Google Chrome"
        )

    $InstalledSoftware = Get-ChildItem "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall"
    foreach($obj in $InstalledSoftware)
        {
        $name = $obj.GetValue('DisplayName')
        if (($name -notcontains $whitelistapps) -and ($null -ne $obj.GetValue('UninstallString'))) 
            {
            $uninstallcommand = $obj.GetValue('UninstallString')
            write-host "Uninstalling $name"
            if ($uninstallcommand -like "*msiexec*") 
                {
                $splitcommand = $uninstallcommand.Split("{")
                $msicode = $splitcommand[1]
                $uninstallapp = "msiexec.exe /X {$msicode /qn"
                start-process "cmd.exe" -ArgumentList "/c $uninstallapp"
                }
            else 
                {
                $splitcommand = $uninstallcommand.Split("{")
                $uninstallapp = "$uninstallcommand /S"
                start-process "cmd.exe" -ArgumentList "/c $uninstallapp"
                }
            }
        }

    $InstalledSoftware32 = Get-ChildItem "HKLM:\Software\WOW6432NODE\Microsoft\Windows\CurrentVersion\Uninstall"
    foreach($obj32 in $InstalledSoftware32)
        {
        $name32 = $obj32.GetValue('DisplayName')
    if (($name32 -notcontains $whitelistapps) -and ($null -ne $obj32.GetValue('UninstallString'))) 
        {
        $uninstallcommand32 = $obj.GetValue('UninstallString')
        write-host "Uninstalling $name"
        if ($uninstallcommand32 -like "*msiexec*") 
            {
            $splitcommand = $uninstallcommand32.Split("{")
            $msicode = $splitcommand[1]
            $uninstallapp = "msiexec.exe /X {$msicode /qn"
            start-process "cmd.exe" -ArgumentList "/c $uninstallapp"
            }
        else 
            {
            $splitcommand = $uninstallcommand32.Split("{")   
            $uninstallapp = "$uninstallcommand /S"
            start-process "cmd.exe" -ArgumentList "/c $uninstallapp"
            }
        }
        }
    }
#>

write-host "Completed"
Stop-Transcript