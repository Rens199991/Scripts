#This disables the MS Store, but will still allow you to deploy and update apps centrally.
#https://andrewstaylor.com/2023/07/24/restricting-microsoft-store-via-intune-for-pro-and-enterprise/

$Path = "HKLM:\SOFTWARE\Policies\Microsoft\WindowsStore"
$Name = "RequirePrivateStoreOnly"
$Value = 1
$Registry = Get-ItemProperty -Path $Path -Name $Name -ErrorAction SilentlyContinue | Select-Object -ExpandProperty $Name


if ($Registry -eq $Value)
    {
    #Create a tag file just so Intune knows this was installed
    If(-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\DisableMicrosoftPublicStoreDRNOT"))
        {
        New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\DisableMicrosoftPublicStoreDRNOT"
        Set-Content -Path "$($env:ProgramData)\CXN\Scripts\DisableMicrosoftPublicStoreDRNOT\DisableMicrosoftPublicStoreDRNOT.ps1.tag" -Value "Installed"
        }
    Write-Output "No Remediation Needed"
    Exit 0
    }
Else
    { 
    Write-Output "Remediation Needed"
    #Create a tag file just so Intune knows this was installed
    If(-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\DisableMicrosoftPublicStoreDRNeeded"))
        {
        New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\DisableMicrosoftPublicStoreDRNeeded"
        Set-Content -Path "$($env:ProgramData)\CXN\Scripts\DisableMicrosoftPublicStoreDRNeeded\DisableMicrosoftPublicStoreDRNeeded.ps1.tag" -Value "Installed"
        }
    Exit 1
    }   