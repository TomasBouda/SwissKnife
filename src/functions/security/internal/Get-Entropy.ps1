function Get-Entropy {
	$entropyFilePath = "$PSScriptRoot\.entropy"
	if (-not (Test-Path $entropyFilePath)) {
		$entropy = (New-Guid) -replace '-', ''
		Set-Content -Path $entropyFilePath -Value $entropy
	}
	else {
		$entropy = Get-Content -Path $entropyFilePath
	}

	$entropy
}