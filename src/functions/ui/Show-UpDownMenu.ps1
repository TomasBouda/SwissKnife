function Show-UpDownMenu {
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
		$titlePos = Get-CursorPosition
		Write-HostColored "$Title (Pres arrow keys and {{Enter}} to choose or {{Escape}} to exit):" -ForegroundColor Yellow -HighlightColor Magenta

		$i = 0
		$key = $null
		$startPos = Get-CursorPosition
	}
	process {
		while ($null -eq $key -or ($key.Key -ne 'Enter' -and $key.Key -ne 'Esc')) {

			Clear-Line
			Set-CursorPosition $startPos

			if ($null -ne $ExpandProperty) {
				Write-Host "> $($Options[$i].$ExpandProperty)" -NoNewline -BackgroundColor Black
			}
			else {
				Write-Host "> $($Options[$i])" -NoNewline -BackgroundColor Black
			}

			$key = [System.Console]::ReadKey()
			if ($key.Key -eq 'DownArrow') {
				if ($i -eq $Options.Length - 1) {
					$i = 0
				}
				else {
					$i++
				}
			}
			elseif ($key.Key -eq 'UpArrow') {
				if ($i -eq 0) {
					$i = $Options.Length - 1
				}
				else {
					$i--
				}
			}
		}

		if ($key.Key -eq 'Esc') {
			exit
		}

		Set-CursorPosition $titlePos
		Clear-Line
		Write-Host

		$Options[$i]
	}
}