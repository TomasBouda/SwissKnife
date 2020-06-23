function Merge-Folder {
	[Cmdletbinding()]
	param (
		[Parameter(Mandatory = $true)]
		[string]$Source,
		[Parameter(Mandatory = $true)]
		[string]$Destination
	)

	foreach ($file in (Get-ChildItem $Source -Force -ea SilentlyContinue)) {
		if ($file.PSIsContainer) {
			$newDstFile = (Join-Path $Destination $file.Name)
			if (Test-Path $newDstFile -PathType 'Leaf') {
				Write-VerboseLog -MessageTemplate 'Removing {dstFile}' -PropertyValues $newDstFile
				Remove-Item -Path $newDstFile -Force
			}
			if (-not (Test-Path $newDstFile -PathType 'Container')) {
				Write-VerboseLog -MessageTemplate 'Creating new directory {dstFile}' -PropertyValues $newDstFile
				New-Item -ItemType Directory -Force -Path $newDstFile -WarningAction SilentlyContinue | Out-Null
			}
			Merge-Folder -Source $file.FullName -Destination $newDstFile
		}
		else {
			Write-VerboseLog -MessageTemplate 'Copying {src} into {target}' -PropertyValues $file.FullName, $Destination
			Copy-Item -Path $file.FullName -Destination $Destination -Force -ErrorAction Stop

			Write-VerboseLog -MessageTemplate 'Removing {file}' -PropertyValues $file.FullName
			Remove-Item -Path $file.FullName -Force -ErrorAction Stop
		}
	}
	[io.directory]::delete($Source)
}