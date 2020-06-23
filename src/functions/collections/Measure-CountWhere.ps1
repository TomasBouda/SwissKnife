function Measure-CountWhere {
	[CmdletBinding()]
	param(
		[Parameter(Mandatory = $true, ValueFromPipeline = $true)]
		[PSObject[]]$InputObject,
		[Parameter(Mandatory = $true, Position = 0)]
		[ScriptBlock]$FilterScript
	)
	
	begin {
		$count = 0;
	}
	process {
		if ($InputObject | Where-Object $FilterScript) {
			$count++
		}
	}
	end {
		$count
	}
}