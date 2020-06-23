function Clear-Line {
	process {
		$startPos = Get-CursorPosition
		$initPos = new-object System.Management.Automation.Host.Coordinates -Property @{
			X = 0
			Y = $startPos.Y
		}

		Set-CursorPosition $initPos
		# TODO clear it better
		Write-Host "                                                                                                                                                                                                                                                                  " -NoNewline
		Set-CursorPosition $startPos
	}
}