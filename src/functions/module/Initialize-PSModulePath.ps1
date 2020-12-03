function Initialize-PSModulePath {
	$documentsDir = [Environment]::GetFolderPath("MyDocuments")
	$currUserPSModulePath = "$documentsDir\WindowsPowerShell\Modules"

	New-Item $currUserPSModulePath -ItemType Directory -Force | Out-Null
	Add-PSModulePath -Path $currUserPSModulePath
}