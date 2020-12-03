function Add-PSModulePath {
	param(
		[Parameter(Mandatory = $true)]
		[string]$Path
	)

	$CurrentValue = [Environment]::GetEnvironmentVariable("PSModulePath")
	if (-not ($CurrentValue.Split(';') -contains $Path)) {
		[Environment]::SetEnvironmentVariable("PSModulePath", $CurrentValue + ";$Path")
	}
}