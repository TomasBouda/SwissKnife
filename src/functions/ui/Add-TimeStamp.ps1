function Add-TimeStamp {
	[CmdletBinding()]
	param (
		[parameter(Mandatory = $false, 
			ValueFromPipeline = $true)]
		[string]$Text = $null,
		[parameter(Mandatory = $false)]
		[ConsoleColor]$TimeStampColor = 15	# White
	)

	$textWithTimeStamp = "$(Get-Date -Format "MM.dd.yyyy HH:mm:ss") | $Text"

	if ($null -eq $Text -or "" -eq $Text) {
		Write-Host $textWithTimeStamp -ForegroundColor $TimeStampColor -NoNewline
	}
	else {
		$textWithTimeStamp
	}
}