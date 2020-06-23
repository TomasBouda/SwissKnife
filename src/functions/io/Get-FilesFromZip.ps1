function Get-FilesFromZip(){
	[CmdletBinding()]
	param(
		[parameter(Mandatory = $true)]
		[string]$ZipFilePath,
		[parameter(Mandatory = $true)]
		[string[]]$PathsToExtract,
		[parameter(Mandatory = $true)]
		[string]$TargetDir,
		[parameter(Mandatory = $false)]
		[string]$FlattenPath
	)

	$zip = [IO.Compression.ZipFile]::OpenRead($ZipFilePath)
	try {
		foreach($pathToExtract in $PathsToExtract){
			$zip.Entries | 
				Where-Object { $_.FullName -match $pathToExtract } | 
				ForEach-Object { 
					$fileName = $_ -replace $FlattenPath, ""

					$fileOrDirToExtract = "$targetDir\$fileName"

					if($fileOrDirToExtract -match '\..*'){				
						[System.IO.Compression.ZipFileExtensions]::ExtractToFile($_, $fileOrDirToExtract, $true) 
					}
					else{
						New-Item $fileOrDirToExtract -Type Directory -Force | Out-Null
					}
				}
		}
	}
	finally {
		$zip.Dispose()
	}
}