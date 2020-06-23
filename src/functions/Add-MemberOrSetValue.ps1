function Add-MemberOrSetValue{
	[cmdletbinding()]
	param(
		[Parameter(Mandatory = $true, ValueFromPipeline = $true)]
		[object]$InputObject,
		[Parameter(Mandatory = $true)]
		[string]$PropertyName,
		[Parameter(Mandatory = $true)]
		[object]$PropertyValue
	)

	process{
		if(-not (Get-Member -InputObject $InputObject -name $PropertyName -Membertype Properties)){
			$InputObject | Add-Member -NotePropertyName $PropertyName -NotePropertyValue $PropertyValue
		}
		else{
			$InputObject."$PropertyName" = $PropertyValue
		}
	}
}
