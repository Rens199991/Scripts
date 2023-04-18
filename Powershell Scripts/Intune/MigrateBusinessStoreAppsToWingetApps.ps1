#Requires -Modules @{ ModuleName="Microsoft.Graph.Devices.CorporateManagement"; ModuleVersion="1.18.0" }, @{ ModuleName="Microsoft.Graph.Authentication"; ModuleVersion="1.18.0" }

[CmdletBinding(SupportsShouldProcess = $true)]
param ()

Connect-MgGraph -Scopes "DeviceManagementApps.ReadWrite.All" -ContextScope Process
Select-MgProfile -Name "beta"



#fetch existing Windows Store for Business (legacy) apps from Intune
$apps = Get-MgDeviceAppMgtMobileApp -Filter "isOf('microsoft.graph.microsoftStoreForBusinessApp')" -ExpandProperty "assignments"
$windowsStoreApps = $apps | ForEach-Object { [PSCustomObject]@{
        Displayname       = $_.displayname
        PackageIdentifier = $_.AdditionalProperties["productKey"].Split("/")[0]
    }
    }
    
<# Nog testen waarom package identifier niet werkt

# fetch existing Legacy apps from Intune
$legacyapps = Get-MgDeviceAppMgtMobileApp -Filter "isOf('microsoft.graph.WindowsStoreApp')" -ExpandProperty "assignments" 
$windowsStorelegacyApps = $legacyapps | ForEach-Object { [PSCustomObject]@{
        Displayname       = $_.displayname
        #PackageIdentifier = $_.AdditionalProperties["productKey"].Split("/")[0]
        }
    }

#>

# fetch package IDs of existing winget apps
$existingWingetApps = Get-MgDeviceAppMgtMobileApp -Filter "isOf('microsoft.graph.winGetApp')" | ForEach-Object { $_.AdditionalProperties["packageIdentifier"] } | Select-Object -Unique


#Start Converting Store for Business apps in New Winget Apps
foreach ($app in $windowsStoreApps) 
{

    $logContext = "`"$($app.Displayname)`" ($($app.PackageIdentifier))"

    if ($app.PackageIdentifier -notin $existingWingetApps) {

        Write-Output "Importing app: $logContext as winget app..."

        try {
            # fetch app information from packageManifests
            Write-Verbose "Fetching packageManifests..."
            $appUrl = "https://storeedgefd.dsx.mp.microsoft.com/v9.0/packageManifests/{0}" -f $app.PackageIdentifier
            $packageManifest = Invoke-RestMethod -Uri $appUrl -ErrorAction Stop
            $appInfo = $packageManifest.Data.Versions[-1].DefaultLocale
            $appInstaller = $packageManifest.Data.Versions[-1].Installers

            # extract image bytes from productsDetails
            Write-Verbose "Fetching ProductsDetails..."
            $productsDetailsUri = "https://apps.microsoft.com/store/api/ProductsDetails/GetProductDetailsById/{0}?hl=en-US&gl=US" -f $app.PackageIdentifier
            $productsDetails = Invoke-RestMethod -Uri $productsDetailsUri -Method GET 
            [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12
            Write-Verbose "Fetching Image..."
            $imageBytes = (New-Object System.Net.WebClient).DownloadData($productsDetails.iconUrl)

            $requestBody = @{
                "@odata.type"         = "#microsoft.graph.winGetApp"
                description           = $appInfo.Description
                developer             = $appInfo.Publisher
                displayName           = $appInfo.packageName
                informationUrl        = $appInfo.PublisherSupportUrl
                largeIcon             = @{
                    "@odata.type" = "#microsoft.graph.mimeContent"
                    "type"        = "image/png"
                    "value"       = [System.Convert]::ToBase64String($imageBytes)
                }
                installExperience     = @{
                    runAsAccount = $appInstaller[-1].Scope
                }
                isFeatured            = $false
                packageIdentifier     = $app.PackageIdentifier
                privacyInformationUrl = $appInfo.PrivacyUrl
                publisher             = $appInfo.publisher
                repositoryType        = "microsoftStore"
            }

            # sanitize input values to avoid import failures
            if ([string]::IsNullOrEmpty($appInfo.PrivacyUrl) -and (-not $appInfo.PrivacyUrl -match "http|https")) {
                $requestBody["privacyInformationUrl"] = "https://" + $appInfo.PrivacyUrl
            } else {
                $requestBody.Remove("privacyInformationUrl")
            }

            if ([string]::IsNullOrEmpty($appInfo.PublisherSupportUrl) -and (-not $appInfo.PublisherSupportUrl -match "http|https")) {
                $requestBody["informationUrl"] = "https://" + $appInfo.PublisherSupportUrl
            } else {
                $requestBody.Remove("informationUrl")
            }
            
            # build request body
            $params = @{
                Method      = "POST"
                Uri         = "https://graph.microsoft.com/beta/deviceAppManagement/mobileApps"
                ContentType = "application/json;charset=utf-8"
                Body        = $requestBody
            }

            Write-Verbose "Creating mobileApp..."
            $createdApp = Invoke-MgGraphRequest @params -ErrorAction Stop
            Write-Output "Created winget app $logContext with appId: `"$($createdApp.Id)`""
        } catch {
            Write-Error "Error importing app: $logContext as winget app!"
            Write-Error $_
        }
    } else {
        Write-Warning "Skipping app: $logContext as it is already present as winget app!"
    }
}



<#

#Start Converting Legacy apps in New Winget Apps
foreach ($legacyapp in $legacyapps) 
{

    $logContext = "`"$($legacyapp.Displayname)`" ($($legacyapp.PackageIdentifier))"

    if ($legacyapp.PackageIdentifier -notin $existingWingetApps) {

        Write-Output "Importing app: $logContext as winget app..."

        try {
            # fetch app information from packageManifests
            Write-Verbose "Fetching packageManifests..."
            $appUrl = "https://storeedgefd.dsx.mp.microsoft.com/v9.0/packageManifests/{0}" -f $legacyapp.PackageIdentifier
            $packageManifest = Invoke-RestMethod -Uri $appUrl -ErrorAction Stop
            $appInfo = $packageManifest.Data.Versions[-1].DefaultLocale
            $appInstaller = $packageManifest.Data.Versions[-1].Installers

            # extract image bytes from productsDetails
            Write-Verbose "Fetching ProductsDetails..."
            $productsDetailsUri = "https://apps.microsoft.com/store/api/ProductsDetails/GetProductDetailsById/{0}?hl=en-US&gl=US" -f $legacyapp.PackageIdentifier
            $productsDetails = Invoke-RestMethod -Uri $productsDetailsUri -Method GET 
            [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12
            Write-Verbose "Fetching Image..."
            $imageBytes = (New-Object System.Net.WebClient).DownloadData($productsDetails.iconUrl)

            $requestBody = @{
                "@odata.type"         = "#microsoft.graph.winGetApp"
                description           = $legacyappInfo.Description
                developer             = $legacyappInfo.Publisher
                displayName           = $legacyappInfo.packageName
                informationUrl        = $legacyappInfo.PublisherSupportUrl
                largeIcon             = @{
                    "@odata.type" = "#microsoft.graph.mimeContent"
                    "type"        = "image/png"
                    "value"       = [System.Convert]::ToBase64String($imageBytes)
                }
                installExperience     = @{
                    runAsAccount = $appInstaller[-1].Scope
                }
                isFeatured            = $false
                packageIdentifier     = $legacyapp.PackageIdentifier
                privacyInformationUrl = $legacyappInfo.PrivacyUrl
                publisher             = $legacyappInfo.publisher
                repositoryType        = "microsoftStore"
            }

            # sanitize input values to avoid import failures
            if ([string]::IsNullOrEmpty($appInfo.PrivacyUrl) -and (-not $legacyappInfo.PrivacyUrl -match "http|https")) {
                $requestBody["privacyInformationUrl"] = "https://" + $legacyappInfo.PrivacyUrl
            } else {
                $requestBody.Remove("privacyInformationUrl")
            }

            if ([string]::IsNullOrEmpty($appInfo.PublisherSupportUrl) -and (-not $legacyappInfo.PublisherSupportUrl -match "http|https")) {
                $requestBody["informationUrl"] = "https://" + $legacyappInfo.PublisherSupportUrl
            } else {
                $requestBody.Remove("informationUrl")
            }
            
            # build request body
            $params = @{
                Method      = "POST"
                Uri         = "https://graph.microsoft.com/beta/deviceAppManagement/mobileApps"
                ContentType = "application/json;charset=utf-8"
                Body        = $requestBody
            }

            Write-Verbose "Creating mobileApp..."
            $createdApp = Invoke-MgGraphRequest @params -ErrorAction Stop
            Write-Output "Created winget app $logContext with appId: `"$($createdApp.Id)`""
        } catch {
            Write-Error "Error importing app: $logContext as winget app!"
            Write-Error $_
        }
    } else {
        Write-Warning "Skipping app: $logContext as it is already present as winget app!"
    }
}

#>