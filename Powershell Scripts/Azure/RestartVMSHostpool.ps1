#Connect with the Managed Identity
Connect-AzAccount -Identity


#Declare Variabels:
$ResourceGroupName = "gda-prod-avd-001-rg"
$HostPoolName = "gda-weu-prod-001-hp"

#Get all Sessionshosts of the hostpool
$VMS = Get-AzWvdSessionHost -ResourceGroupName $ResourceGroupName -HostPoolName $HostPoolName
$VMNewNames =@()


#Rename al VMS:
foreach ($VM in $VMS) 
    {
    $VMNewNames += ((($VM.name -split '/',2)[1]).split('.'))[0]
    }


#Restarts all VMS that are part of Hostpool:
foreach ($VMNewName in $VMNewNames) 
    {
    Restart-AzVM -ResourceGroupName $ResourceGroupName -Name $VMNewName
    }




