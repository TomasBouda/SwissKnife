function Set-CursorPosition {
	[Cmdletbinding()]
	param (
		[Parameter(Mandatory = $true)]
		[System.Management.Automation.Host.Coordinates]$Coords
	)

	process {
		$host.UI.RawUI.CursorPosition = $Coords
	}
}