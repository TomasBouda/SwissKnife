function Show-ChooseMenu {
	[Cmdletbinding()]
	param (
		[Parameter(Mandatory = $true)]
		[object[]]$Options,
		[Parameter(Mandatory = $false)]
		[object[]]$ExpandProperty,
		[Parameter(Mandatory = $false)]
		[object[]]$Title
	)

	begin {
		Write-HostColored "$Title (Pres {{arrow keys}} and hit {{Enter}} to choose; {{Escape}} to exit):" -ForegroundColor Yellow -HighlightColor Magenta

		$i = 0
		$key = $null
		$startPos = Get-CursorPosition
		$currPos = $startPos
	}
	process {

		foreach ($option in $Options) {	
			if ($null -ne $ExpandProperty) {
				Write-Host "[ ] $($option.$ExpandProperty)" -BackgroundColor Black
			}
			else {
				Write-Host "[ ] $option" -BackgroundColor Black
			}
		}

		$endPos = Get-CursorPosition
		$currPos.X++
		$prevPos = $currPos
		Set-CursorPosition $currPos
		Write-Host "x" -NoNewline -BackgroundColor Black
		Set-CursorPosition $currPos

		while ($null -eq $key -or ($key.Key -ne 'Enter' -and $key.Key -ne 'Esc')) {

			$key = [System.Console]::ReadKey()
			if ($key.Key -eq 'DownArrow') {
				if ($i -eq $Options.Length - 1) {
					$i = 0
					$currPos.Y = $startPos.Y
				}
				else {
					$currPos.Y = $currPos.Y + 1
					$i++
				}
			}
			elseif ($key.Key -eq 'UpArrow') {
				if ($i -eq 0) {
					$i = $Options.Length - 1
					$currPos.Y = $endPos.Y - 1
				}
				else {
					$currPos.Y = $currPos.Y - 1
					$i--
				}
			}

			Set-CursorPosition $prevPos
			Write-Host " " -NoNewline -BackgroundColor Black
			Set-CursorPosition $currPos
			Write-Host "x" -NoNewline -BackgroundColor Black
			Set-CursorPosition $currPos
			$prevPos = $currPos
		}

		if ($key.Key -eq 'Esc') {
			exit
		}

		Set-CursorPosition $endPos
		Write-Host

		$Options[$i]
	}
}