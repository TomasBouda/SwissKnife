function ConvertTo-Base64 {
	[CmdletBinding()]
	param(
		[Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true, ParameterSetName = 'Text')]
		[string]$Text,
		[Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true, ParameterSetName = 'Bytes')]
		[byte[]]$Bytes
	)

	process {
		if($PSCmdlet.ParameterSetName -eq 'Text'){
			[System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($Text))
		}
		else{
			[System.Convert]::ToBase64String($Bytes)
		}		
	}
}