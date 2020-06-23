function New-ScheduledTaskFolder {
	[CmdletBinding()]
	param (
		[string]$FolderPath
	)

	$prevEAP = $ErrorActionPreference
	$ErrorActionPreference = "stop"

	$scheduleObject = New-Object -ComObject schedule.service
	$scheduleObject.connect()
	$rootFolder = $scheduleObject.GetFolder("\")

	Try {
		$null = $scheduleObject.GetFolder($FolderPath)
	}
	Catch { 
		$null = $rootFolder.CreateFolder($FolderPath) 
	}
	Finally { 
		$ErrorActionPreference = $prevEAP
	} 
}
