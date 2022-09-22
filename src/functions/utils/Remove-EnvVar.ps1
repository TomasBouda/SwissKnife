function Remove-EnvVar {
	param (
		[Parameter(Mandatory = $true)]
		[string]$Name,
		[Parameter(Mandatory = $false)]
		[ValidateSet('Machine', 'Process', 'User')]
		[System.EnvironmentVariableTarget]$Target = [System.EnvironmentVariableTarget]::User
	)
	
	Set-EnvVar -Name $Name -Value $null -Target $Target
}