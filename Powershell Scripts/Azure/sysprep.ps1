#Voor Syspreppen van VM--> platform moet hetzelfde zijn (bv: Azure-VMWare is niet mogelijk)

$sysPrepActionPath = "$env:windir\System32\Sysprep\ActionFiles"
$sysPrepActionFile = "Generalize.xml"
$sysPrepActionPathItem = Get-Item $sysPrepActionPath.Replace("C:\", "\\localhost\\c$\") -ErrorAction Ignore
$acl = $sysPrepActionPathItem.GetAccessControl()
$acl.SetOwner((New-Object System.Security.Principal.NTAccount("SYSTEM")))
$sysPrepActionPathItem.SetAccessControl($acl)
$aclSystemFull = New-Object System.Security.AccessControl.FileSystemAccessRule("SYSTEM", "FullControl", "Allow")
$acl.AddAccessRule($aclSystemFull)
$sysPrepActionPathItem.SetAccessControl($acl)
[xml]$xml = Get-Content -Path "$sysPrepActionPath\$sysPrepActionFile"
$xmlNode = $xml.sysprepInformation.imaging | Where-Object { $_.sysprepModule.moduleName -match "AppxSysprep.dll" }
if ($null -ne $xmlNode) {
    $xmlNode.ParentNode.RemoveChild($xmlNode)
    $xml.sysprepInformation.imaging.Count
    $xml.Save("$sysPrepActionPath\$sysPrepActionFile.new")
    Remove-Item "$sysPrepActionPath\$sysPrepActionFile.old" -Force -ErrorAction Ignore
    Move-Item "$sysPrepActionPath\$sysPrepActionFile" "$sysPrepActionPath\$sysPrepActionFile.old"
    Move-Item "$sysPrepActionPath\$sysPrepActionFile.new" "$sysPrepActionPath\$sysPrepActionFile"
}

Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Setup\Sysprep" -Name "SysprepCorrupt" -ErrorAction Ignore
New-ItemProperty -Path "HKLM:\SYSTEM\Setup\Status\SysprepStatus" -Name "State" -Value 2 -force
New-ItemProperty -Path "HKLM:\SYSTEM\Setup\Status\SysprepStatus" -Name "GeneralizationState" -Value 7 -force

Get-ChildItem "Cert:\LocalMachine\Microsoft Monitoring Agent" -ErrorAction Ignore | Remove-Item

Start-Process -FilePath "C:\Windows\System32\Sysprep\sysprep.exe" -WorkingDirectory "C:\Windows\System32\Sysprep\" -ArgumentList @("/generalize", "/shutdown", "/oobe", "/mode:vm")