# Functie om de bootmodus te controleren via de EFI-partitie.
# Dit is de meest betrouwbare methode omdat het de WMI-laag omzeilt.
function Check-UEFIStatus {
    $isUEFI = $false
    try {
        # Zoek naar de partitie met de EFI-partitiestijl (Type "System")
        $efiPartition = Get-Partition | Where-Object { $_.Type -eq "System" -and $_.IsSystem -eq $true }
        
        # Als een partitie met het type 'EFI System Partition' wordt gevonden, is het UEFI.
        if ($null -ne $efiPartition) {
            $isUEFI = $true
        }
    }
    catch {
        # Als er een fout optreedt, wordt de controle overgeslagen
        # en wordt de Legacy-waarde teruggegeven.
        $isUEFI = $false
    }
    return $isUEFI
}

# Functie om te controleren of TPM 2.0 aanwezig en ingeschakeld is.
function Check-TPMStatus {
    try {
        $tpm = Get-CimInstance -ClassName Win32_Tpm -Namespace "root\CIMV2\Security\MicrosoftTpm" -ErrorAction Stop
        if ($tpm -eq $null -or $tpm.SpecVersion -notlike "2.0*") {
            return $false
        }
        return $true
    }
    catch {
        return $false
    }
}

# Functie om te controleren op minimaal 4 GB RAM.
function Check-Memory {
    $memory = Get-CimInstance -ClassName Win32_ComputerSystem
    if ($memory.TotalPhysicalMemory -lt (4GB)) {
        return $false
    }
    return $true
}

# Functie om te controleren op de processorvereisten (64-bit en minstens 2 cores).
function Check-Processor {
    $processor = Get-CimInstance -ClassName Win32_Processor
    if ($processor.NumberOfCores -lt 2 -or $processor.AddressWidth -ne 64) {
        return $false
    }
    return $true
}

# Functie om te controleren op minimaal 64 GB opslag.
function Check-Storage {
    $drives = Get-CimInstance -ClassName Win32_LogicalDisk -Filter "DriveType=3" | Select-Object -First 1
    if ($drives.Size -lt (64GB)) {
        return $false
    }
    return $true
}

# Hoofdlogica van het script. Controleert alle vereisten.
if (-not (Check-UEFIStatus)) {
    Write-Output "Apparaat voldoet niet aan de vereisten: UEFI is niet ingeschakeld."
    exit 1
}

if (-not (Check-TPMStatus)) {
    Write-Output "Apparaat voldoet niet aan de vereisten: TPM 2.0 is niet aanwezig of ingeschakeld."
    exit 1
}

if (-not (Check-Memory)) {
    Write-Output "Apparaat voldoet niet aan de vereisten: Minder dan 4 GB RAM."
    exit 1
}

if (-not (Check-Processor)) {
    Write-Output "Apparaat voldoet niet aan de vereisten: Processor heeft minder dan 2 cores of is geen 64-bit."
    exit 1
}

if (-not (Check-Storage)) {
    Write-Output "Apparaat voldoet niet aan de vereisten: Minder dan 64 GB opslagruimte."
    exit 1
}

# Als alle controles succesvol zijn, wordt het apparaat als compliant beschouwd.
Write-Output "Apparaat is klaar voor Windows 11."
exit 0