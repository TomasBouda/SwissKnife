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

	Start-Process 'powershell.exe' $Script -Verb RunAs
}