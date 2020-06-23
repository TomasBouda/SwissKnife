function Build-Module {
	param(
		[Parameter(Mandatory = $true)]
		[string]$ModuleDirectory,
		[Parameter(Mandatory = $true)]
		[Version]$TargetVersion,
		[Parameter(Mandatory = $false)]
		[string]$ReleaseNotes,
		[Parameter(Mandatory = $false)]
		[string]$ModuleName = (Get-Item $ModuleDirectory).BaseName,
		[Parameter(Mandatory = $false)]
		[string]$PublishFolder = "$PSScriptRoot\publish\$ModuleName\"
	)

	$excludedItems = Get-Content "$PSScriptRoot\.buildExclude" -ErrorAction SilentlyContinue

	$functions = @()
	Get-ChildItem -Path "$ModuleDirectory\functions" -Recurse -File -Filter '*.ps1' | ForEach-Object {
		# Export all functions except internal
		if ($_.FullName -notlike '*\internal\*') {
			$functions += $_.BaseName
		}
	}

	# Update module version
	Update-ModuleManifest "$ModuleDirectory\$ModuleName.psd1" -ModuleVersion $TargetVersion -ReleaseNotes $ReleaseNotes -FunctionsToExport $functions

	# Create clean publish folder
	if (Test-Path $PublishFolder) {
		Remove-Item $PublishFolder -Recurse -Force
	}
	New-Item -Path $PublishFolder -ItemType Directory -Force | Out-Null

	# Filter module files and move them to publish folder
	Get-ChildItem $ModuleDirectory | Where-Object { $excludedItems -notcontains $_.Name } | Select-Object -ExpandProperty FullName | Copy-Item -Destination $PublishFolder -Recurse -Force
}