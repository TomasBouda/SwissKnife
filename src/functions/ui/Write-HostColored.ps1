function Write-HostColored() {
	[CmdletBinding()]
	param(
		[parameter(Mandatory = $true, 
			ValueFromPipeline = $true)]
		[string]$Format,
		[parameter(Mandatory = $false)]
		[ConsoleColor]$ForegroundColor = [System.ConsoleColor]::White,
		[parameter(Mandatory = $false)]
		[ConsoleColor]$HighlightColor = [System.ConsoleColor]::Yellow,
		[parameter(Mandatory = $false)]
		[switch]$PassThru = $false,
		[parameter(Mandatory = $false)]
		[switch]$AddTimestamp = $false
	)

	if ($AddTimestamp) {
		Add-TimeStamp
	}

	$index = 0
	$results = $Format | Select-String '\{\{.+?\}\}' -AllMatches 

	$Format -split '\{\{.+?\}\}' | ForEach-Object { 
		Write-Host $_ -NoNewline -ForegroundColor $ForegroundColor
		$word = ($results.Matches[$index++].Value -replace "{{", "") -replace "}}", ""
		Write-Host $word -ForegroundColor $HighlightColor -NoNewline
	}
	Write-Host ""

	if ($PassThru -eq $true) {
		return ($Format -replace "{{", "") -replace "}}", ""
	}
}