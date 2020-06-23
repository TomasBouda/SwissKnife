function Get-ParentUrl {
	[Cmdletbinding()]
	param (
		[Parameter(Mandatory = $true)]
		[string]$Url
	)

	process {
		$Url = $Url.TrimEnd('/')

		$Url.Remove($Url.LastIndexOf('/'), $Url.Length - $Url.LastIndexOf('/'))
	}
}