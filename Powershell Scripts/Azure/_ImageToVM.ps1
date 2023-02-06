$ErrorActionPreference = "Stop"
Connect-AzAccount -Identity

$rgName = Get-AutomationVariable -Name "avd-image-rgname"
$vaultName = Get-AutomationVariable -Name "avd-kv-name"
$deployImagerJsonUrl = Get-AutomationVariable -Name "avd-imager-arm-url"
$deployImagerParamJsonUrl = Get-AutomationVariable -Name "avd-imager-armparam-url"
$AcgImageDefinitionName = Get-AutomationVariable -Name "avd-image-definition-name"

#region Helper functions
function ConvertFrom-SecureStringCrossPwshVersions {
    [CmdletBinding()]
    param (
        [parameter(ValueFromPipeline)]
        [System.Security.SecureString]$secureString
    )
    $bstr = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($secureString)
    $plaintext = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($bstr)
    return $plaintext
}

function ConvertTo-Hashtable {
    [CmdletBinding()]
    [OutputType('hashtable')]
    param (
        [Parameter(ValueFromPipeline)]
        $InputObject
    )
    process {
        ## Return null if the input is null. This can happen when calling the function
        ## recursively and a property is null
        if ($null -eq $InputObject) {
            return $null
        }
        ## Check if the input is an array or collection. If so, we also need to convert
        ## those types into hash tables as well. This function will convert all child
        ## objects into hash tables (if applicable)
        if ($InputObject -is [System.Collections.IEnumerable] -and $InputObject -isnot [string]) {
            $collection = @(
                foreach ($object in $InputObject) {
                    ConvertTo-Hashtable -InputObject $object
                }
            )
            ## Return the array but don't enumerate it because the object may be pretty complex
            Write-Output -NoEnumerate $collection
        }
        elseif ($InputObject -is [psobject]) {
            ## If the object has properties that need enumeration
            ## Convert it to its own hash table and return it
            $hash = @{}
            foreach ($property in $InputObject.PSObject.Properties) {
                $hash[$property.Name] = ConvertTo-Hashtable -InputObject $property.Value
            }
            $hash
        }
        else {
            ## If the object isn't an array, collection, or other object, it's already a hash table
            ## So just return it.
            $InputObject
        }
    }
}

#endregion

Write-Output "Retrieving RG"
$vmRg = Get-AzResourceGroup -Name $rgName

Write-Output "Retrieving ACG & Image Definition"
$galleryRg = Get-AzResourceGroup -Name $rgName
$gallery = Get-AzGallery -ResourceGroupName $galleryRg.ResourceGroupName
$imageDefinition = Get-AzGalleryImageDefinition -ResourceGroupName $galleryRg.ResourceGroupName -GalleryName $gallery.Name -Name $AcgImageDefinitionName

#Get latest version
$imageVersionList = Get-AzGalleryImageVersion -ResourceGroupName $galleryRg.ResourceGroupName -GalleryName $gallery.Name -GalleryImageDefinitionName $imageDefinition.Name | Select-Object Name -ExpandProperty Name
$latestVersionNumber = ($imageVersionList | ForEach-Object { [version]$_ } | Sort-Object -Descending | Select-Object -First 1).ToString()

Write-Output "Retrieving Keyvault secrets"
$localadmin_user = (Get-AzKeyVaultSecret -VaultName $vaultName -SecretName "localadmin-user" -WarningAction SilentlyContinue).SecretValue | ConvertFrom-SecureStringCrossPwshVersions
$localadmin_password = (Get-AzKeyVaultSecret -VaultName $vaultName -SecretName "localadmin-password" -WarningAction SilentlyContinue).SecretValue | ConvertFrom-SecureStringCrossPwshVersions

Write-Output "Download Deployment files from Storage Account"
Invoke-WebRequest -Uri $deployImagerJsonUrl -OutFile deploy.imager.json -UseBasicParsing
Invoke-WebRequest -Uri $deployImagerParamJsonUrl -OutFile deploy.imager.params.json -UseBasicParsing

Write-Output "Filling in the missing parameters"
if ($PSVersionTable.PSVersion.Major -eq 5) {
    $armparamobject = Get-Content ".\deploy.imager.params.json" | ConvertFrom-Json | ConvertTo-Hashtable
}
else {
    $armparamobject = Get-Content ".\deploy.imager.params.json" | ConvertFrom-Json -AsHashtable
}
$armparamobject.parameters.adminUsername.value = $localadmin_user
$armparamobject.parameters.adminPassword.value = $localadmin_password
$armparamobject.parameters.ACG_ImageVersionName.value = $latestVersionNumber
$bogusparameterobject = @{ }
$armparamobject.parameters.keys | ForEach-Object { $bogusparameterobject[$_] = $armparamobject.parameters[$_]['value'] }

Write-Output "Testing the deployment"
$deploymentName = ("avd.imager.{0}" -f $latestVersionNumber)
$deploymentTest = $null
$deploymentTest = Test-AzResourceGroupDeployment -ResourceGroupName $vmRg.ResourceGroupName -TemplateFile ".\deploy.imager.json" -TemplateParameterObject $bogusparameterobject
if (($null -eq $deploymentTest) -or ($deploymentTest.Count -eq 0)) {
    Write-Output "Kicking off the deployment"
    $deployResult = New-AzResourceGroupDeployment -ResourceGroupName $vmRg.ResourceGroupName -TemplateFile ".\deploy.imager.json" -TemplateParameterObject $bogusparameterobject -Mode Incremental -Name $deploymentName
    Write-Output ($deployResult | ConvertTo-Json)
}
else {
    Write-Warning "Error in ARM Template deployment!"
    Write-Output "Error in Template:"
    Write-Output ($deploymentTest | ConvertTo-Json -Compress)
}

Write-Output "All done!"