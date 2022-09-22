function Disable-FusionLog {
	Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Fusion' -Name 'EnableLog'
	Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Fusion' -Name 'LogPath'
	Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Fusion' -Name 'LogFailures'
	Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Fusion' -Name 'ForceLog'
}