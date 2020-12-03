function Invoke-ElevatedScript {
	param(
		[Parameter(Mandatory = $true)]
		[string]$Script,
		[Parameter(Mandatory = $false)]
		[switch]$KeepOpen
	)

	if ($KeepOpen) {		
		$Script += "`npause"
	}

	if($PSVersionTable.PSEdition -eq 'Core'){
		Start-Process pwsh '-c', $Script -Verb RunAs
	}
	else{
		Start-Process 'powershell.exe' $Script -Verb RunAs
	}
}