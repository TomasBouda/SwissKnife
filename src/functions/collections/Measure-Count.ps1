function Measure-Count {
	[CmdletBinding()]
	param(
		[Parameter(Mandatory = $true, ValueFromPipeline = $true)]
		[object[]]$InputObject
	)
	
	begin {
		$count = 0;
	}
	process {
		$count++
	}
	end {
		$count
	}
}