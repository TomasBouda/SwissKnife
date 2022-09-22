function Get-EnvVar {
	param (
		[Parameter(Mandatory = $true, Position = 0)]
		[string]$Name,
		[Parameter(Mandatory = $false)]
		[ValidateSet('Machine', 'Process', 'User')]
		[System.EnvironmentVariableTarget]$Target = [System.EnvironmentVariableTarget]::User
	)
	
	[System.Environment]::GetEnvironmentVariable($Name, $Target)
}