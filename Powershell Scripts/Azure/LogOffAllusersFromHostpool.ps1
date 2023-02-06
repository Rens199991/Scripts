function Write-Log {
    # Note: this is required to support param such as ErrorAction
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$Message,

        [switch]$Err,

        [switch]$Warn
    )

    [string]$MessageTimeStamp = (Get-LocalDateTime).ToString('yyyy-MM-dd HH:mm:ss')
    $Message = "[$($MyInvocation.ScriptLineNumber)] $Message"
    [string]$WriteMessage = "$MessageTimeStamp $Message"

    if ($Err) {
        Write-Error $WriteMessage
        $Message = "ERROR: $Message"
    }
    elseif ($Warn) {
        Write-Warning $WriteMessage
        $Message = "WARN: $Message"
    }
    else {
        Write-Output $WriteMessage
    }
}

function TryForceLogOffUser {
    [CmdletBinding(SupportsShouldProcess)]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        $Session
    )
    Begin { }
    Process {
        [string[]]$Toks = $Session.Name.Split('/')
        [string]$SessionHostName = $Toks[1]
        [string]$SessionID = $Toks[-1]
        try {
            Write-Log "Force log off user: '$($Session.ActiveDirectoryUserName)', session ID: $SessionID"
            if ($PSCmdlet.ShouldProcess($SessionID, 'Force log off user with session ID')) {
                # Note: -SessionHostName param is case sensitive, so the command will fail if it's case is modified
                Remove-AzWvdUserSession -ResourceGroupName $ResourceGroupName -HostPoolName $HostPoolName -SessionHostName $SessionHostName -Id $SessionID -Force
            }
        }
        catch {
            Write-Log -Warn "Failed to force log off user: '$($Session.ActiveDirectoryUserName)', session ID: $SessionID $($PSItem | Format-List -Force | Out-String)"
        }
    }
    End { }
}

function TryResetSessionHostUserSessions {
    [CmdletBinding(SupportsShouldProcess)]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [hashtable]$VM
    )
    Begin { }
    Process {
        
        $SessionHost = $VM.SessionHost
        [string]$SessionHostName = $VM.SessionHostName
        if (!$SessionHost.Session) {
            return
        }

        Write-Log -Warn "Session host '$SessionHostName' still has $($SessionHost.Session) sessions left behind in broker DB"

        [array]$UserSessions = @()
        Write-Log "Get all user sessions from session host '$SessionHostName'"
        try {
            $UserSessions = @(Get-AzWvdUserSession -ResourceGroupName $ResourceGroupName -HostPoolName $HostPoolName -SessionHostName $SessionHostName)
        }
        catch {
            Write-Log -Warn "Failed to retrieve user sessions of session host '$SessionHostName': $($PSItem | Format-List -Force | Out-String)"
            return
        }

        Write-Log "Force log off $($UserSessions.Count) users on session host: '$SessionHostName'"
        $UserSessions | TryForceLogOffUser
    }
    End { }
}

Connect-AzAccount -Identity

$ResourceGroupName = "gda-prod-avd-001-rg"
$HostPoolName = "gda-weu-prod-001-hp"


$SessionHosts = @(Get-AzWvdSessionHost -ResourceGroupName $ResourceGroupName -HostPoolName $HostPoolName)
$VMs = @{ }
foreach ($SessionHost in $SessionHosts) {
    [string]$SessionHostName = Get-SessionHostName -SessionHost $SessionHost
    $VMs.Add($SessionHostName.Split('.')[0].ToLower(), @{ 'SessionHostName' = $SessionHostName; 'SessionHost' = $SessionHost; 'Instance' = $null })
}

foreach ($VM in $VMs) {
    TryResetSessionHostUserSessions -VM $VM
}
