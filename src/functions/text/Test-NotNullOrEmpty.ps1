function Test-NotNullOrEmpty{
	param(
		[Parameter(Mandatory=$true, Position=0)]
		[AllowEmptyString()]
		[string]$String
	)

	$null -ne $String -and $String -ne ''
}