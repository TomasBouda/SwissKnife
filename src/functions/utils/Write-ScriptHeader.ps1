function Write-ScriptHeader {
	[Cmdletbinding()]
	param (
		[Parameter(Mandatory = $true)]
		[string]$ScriptVersion,
		[Parameter(Mandatory = $true)]
		[string]$ScriptName,
		[Parameter(Mandatory = $false)]
		[string]$Description,
		[Parameter(Mandatory = $false)]
		[string]$Usage,
		[Parameter(Mandatory = $false)]
		[string]$Parameters = 'Currently not used',
		[Parameter(Mandatory = $false)]
		[System.ConsoleColor]$ForegroundColor = [System.ConsoleColor]::Green
	)

	process {
		$callerScriptName = (Get-Item $MyInvocation.PSCommandPath).Name

		Write-Host "
#********************************************************************************************
#  Title: $callerScriptName
#
#  Description: $Description
#
#  Usage: $Usage
#
#  Parameters: $Parameters
#
#  Version: $($global:scriptVersion) / $($global:scriptName)
#********************************************************************************************" -ForegroundColor $ForegroundColor
	}
}