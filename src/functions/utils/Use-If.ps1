function Use-If {
	[CmdletBinding()]
	param (
		[parameter(Mandatory = $false, 
			ValueFromPipeline = $true)]
		[bool]$Condition,
		[parameter(Mandatory = $true)]
		[scriptblock]$IfTrue,
		[parameter(Mandatory = $false)]
		[scriptblock]$IfFalse
	)

	if ($Condition) {
		if ($null -ne $IfTrue) {
			Invoke-Command -ScriptBlock $IfTrue
		}
	}
	else {
		if ($null -ne $IfFalse) {
			Invoke-Command -ScriptBlock $IfFalse
		}
	}
}