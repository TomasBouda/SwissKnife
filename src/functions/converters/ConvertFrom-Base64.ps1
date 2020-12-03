function ConvertFrom-Base64 {
	[CmdletBinding()]
	param(
		[Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true)]
		[string]$Data
	)

	process {
		[System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($Data))
	}
}