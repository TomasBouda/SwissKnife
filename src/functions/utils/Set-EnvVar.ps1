function Set-EnvVar {
	param (
		[Parameter(Mandatory = $true)]
		[string]$Name,
		[Parameter(Mandatory = $true)]
		[AllowNull()]
		[AllowEmptyString()]
		[string]$Value,
		[Parameter(Mandatory = $false)]
		[ValidateSet('Machine', 'Process', 'User')]
		[System.EnvironmentVariableTarget]$Target = [System.EnvironmentVariableTarget]::User
	)
	
	[System.Environment]::SetEnvironmentVariable($Name, $Value, $Target)
}