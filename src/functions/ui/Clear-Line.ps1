function Clear-Line {
	process {
		$startPos = Get-CursorPosition
		$initPos = New-Object System.Management.Automation.Host.Coordinates -Property @{
			X = 0
			Y = $startPos.Y
		}

		$windowWidth = $Host.UI.RawUI.WindowSize.Width

		Set-CursorPosition $initPos

		for($i = 0; $i -lt $windowWidth; $i++){
			Write-Host " " -NoNewline
		}

		Set-CursorPosition $startPos
	}
}