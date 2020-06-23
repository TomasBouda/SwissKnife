function Join-String{
	[Cmdletbinding()]
	param(
		[Parameter(Mandatory=$true, ValueFromPipeline=$true, ParameterSetName='String')]
		[Parameter(Mandatory=$true, ValueFromPipeline=$true, ParameterSetName='Object')]
		[object[]]$Value,
		[Parameter(Mandatory=$true, ParameterSetName='Object')]
		[string]$ExpandProperty,
		[Parameter(Mandatory=$true)]
		[string]$Separator
	)	

	begin{
		$stringCache = ""
	}
	process{
		switch ($PsCmdlet.ParameterSetName){
			'String'{
				$stringCache += $Value
			}
			'Object'{
				$stringCache += ($Value | Select-Object -ExpandProperty $ExpandProperty)
			}
		}
		$stringCache += $Separator
	}
	end{
		$stringCache.Trim().TrimEnd(',')
	}
}