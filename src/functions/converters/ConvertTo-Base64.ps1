function ConvertTo-Base64 {
	[CmdletBinding()]
	param(
		[Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true)]
		[string]$Text
	)

	process {
		[System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($Text))
	}
}