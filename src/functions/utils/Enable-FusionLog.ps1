function Enable-FusionLog {
	param (
		[Parameter(Mandatory = $false)]
		[string]$LogPath,
		[Parameter(Mandatory = $false)]
		[switch]$ForceLog,
		[Parameter(Mandatory = $false)]
		[switch]$LogFailures
	)
	
	New-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Fusion' -Name 'EnableLog' -Value 1 -PropertyType DWORD -Force | Out-Null

	if($null -ne $LogPath -and $LogPath -ne ''){
		$LogPath = $LogPath.TrimEnd('\').Trim() + '\'

		if(-not (Test-Path $LogPath)){
			Write-Warning 'Fusion LogPath must exist! Creating the directory...'
			New-Item -Path $LogPath -ItemType Directory -Force | Out-Null
		}

		New-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Fusion' -Name 'LogPath' -Value $LogPath -PropertyType String -Force | Out-Null
	}
	
	if($LogFailures){
		New-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Fusion' -Name 'LogFailures' -Value 1 -PropertyType DWORD -Force | Out-Null
	}
	
	if($ForceLog){
		New-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Fusion' -Name 'ForceLog' -Value 1 -PropertyType DWORD -Force | Out-Null
	}
}