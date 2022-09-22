function Add-ToGAC {
	param(
		[Parameter(Mandatory = $true, ValueFromPipeline = $true)]
		[string]$FilePath
	)

	begin {
		[System.Reflection.Assembly]::Load("System.EnterpriseServices, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a")
		$publish = New-Object System.EnterpriseServices.Internal.Publish
	}
	process {
		$publish.GacInstall($FilePath)
	}
}