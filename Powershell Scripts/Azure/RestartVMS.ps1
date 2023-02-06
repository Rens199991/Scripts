#Connect with the Managed Identity
Connect-AzAccount -Identity

#Get all VMs that should be part of the Schedule:
$VMS = Get-AzResource -ResourceType "Microsoft.Compute/VirtualMachines" -TagName "VMTYPE" -TagValue "AVDVM"

#Restarts all VMS that are part of the Schedule:
foreach ($VM in $VMS) 
    {
    Restart-AzVM -ResourceGroupName $VM.ResourceGroupName -Name $VM.Name
    }



