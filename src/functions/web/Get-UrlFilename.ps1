function Get-UrlFilename {
	[Cmdletbinding()]
	param (
		[Parameter(Mandatory = $true)]
		[string]$Url
	)

	process {
		$Url.Substring($Url.LastIndexOf("/") + 1)
	}
}