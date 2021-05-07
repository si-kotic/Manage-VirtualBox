Function Get-VMs {
	$Report = "" | Select-Object -Property Name,OS,Memory,CPUs,PowerState
    $VMsObj = @()
	. 'C:\Program Files\Oracle\VirtualBox\VBoxManage.exe' list vms | ForEach-Object {
        # $vmName = $_.Split('"')[1]
		# $fullInfo = . 'C:\Program Files\Oracle\VirtualBox\VBoxManage.exe' showvminfo $vmName
        # $vmProperties = @{
        #     "Name" = $vmName,
        #     "OS" = ($fullInfo | Where-Object {$_ -like "Guest OS*"}).SubString(17)
        #     "Memory" = ($fullInfo | Where-Object {$_ -like "Memory Size*"}).SubString(17)
        #     "CPUs" = ($fullInfo | Where-Object {$_ -like "Number of CPUs*"}).SubString(17)
        #     "PowerState" = ($fullInfo | Where-Object {$_ -like "State*"}).SubString(17)
        # }
		# $Report += New-Object -TypeName PSObject -Property $vmProperties
        $Report.Name = $_.Split('"')[1]
        $fullInfo = . 'C:\Program Files\Oracle\VirtualBox\VBoxManage.exe' showvminfo $Report.Name
		$Report.OS = ($fullInfo | Where-Object {$_ -like "Guest OS*"}).SubString(17)
		$Report.Memory = ($fullInfo | Where-Object {$_ -like "Memory Size*"}).SubString(17)
		$Report.CPUs = ($fullInfo | Where-Object {$_ -like "Number of CPUs*"}).SubString(17)
		$Report.PowerState = ($fullInfo | Where-Object {$_ -like "State*"}).SubString(17)
        $Report
	}
    # $Report
}
function Start-VM {
    Params (
        $VM
    )
    . 'C:\Program Files\Oracle\VirtualBox\VBoxManage.exe' startvm $VM
}