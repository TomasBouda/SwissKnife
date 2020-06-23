function Invoke-ErrorProne {
	param(
		[Parameter(Mandatory = $true)]
		[scriptblock]$Script,
		[Parameter(Mandatory = $false)]
		[scriptblock]$OnExit,
		[Parameter(Mandatory = $false)]
		[char]$ResolveChar = 'N',
		[Parameter(Mandatory = $false)]
		[string]$ResolveMessage = "Please resolve this issue end press any key to continue or [$ResolveChar] to exit"
	)

	process {
		do {
			try {
				Invoke-Command -ScriptBlock $Script -ErrorAction Stop
				$commandError = $false
			}
			catch {
				$ex = $_.Exception
				$commandError = $true
		
				Write-WarningLog -MessageTemplate $ex.Message -Exception $ex
		
				if ((Read-HostColored $ResolveMessage) -eq $ResolveChar) {
					if ($null -ne $OnExit) {
						Invoke-Command $OnExit
					}
					else {
						exit
					}
				}
			}
		}
		while ($commandError)
	}
}
