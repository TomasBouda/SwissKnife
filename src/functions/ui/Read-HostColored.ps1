function Read-HostColored() {
	param(
		[parameter(Mandatory = $true)]
		[string]$Message,
		[parameter(Mandatory = $false)]
		[ConsoleColor]$ForegroundColor = [System.ConsoleColor]::Yellow,
		[parameter(Mandatory = $false)]
		[ConsoleColor]$HighlightColor = [System.ConsoleColor]::Magenta
	)

	$results = $Message | Select-String '\{\{.+?\}\}' -AllMatches 

	if ($null -ne $results -and $results.Matches.Count -gt 0) {
		$index = 0
		$Message -split '\{\{.+?\}\}' | ForEach-Object { 
			Write-Host $_ -NoNewline -ForegroundColor $ForegroundColor
			$word = ($results.Matches[$index++].Value -replace "{{", "") -replace "}}", ""
			Write-Host $word -ForegroundColor $HighlightColor -NoNewline
		}
		Write-Host ": " -NoNewline
	}
	else {
		Write-Host "$($Message): " -ForegroundColor $ForegroundColor -NoNewline
	}

	return Read-Host
}