#Connect with the Managed Identity
Connect-AzAccount -Identity


#Get all VMs that should be part of the Schedule:
$VMS = Get-AzResource -ResourceType "Microsoft.Compute/VirtualMachines" -TagName "VMTYPE" -TagValue "AVDVM"


#Loop door al de VMs met de TAG die we hebben gedefinieerd en deze opstarten
foreach ($VM in $VMS) 
    {
	Start-AzVM -ResourceGroupName $VM.ResourceGroupName -Name $VM.Name
	}

	
