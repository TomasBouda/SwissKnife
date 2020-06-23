function Get-GithubArchive(){
	[CmdLetBinding()]
	param(
		[parameter(Mandatory = $true)]
		[string]$Url,
		[parameter(Mandatory = $true)]
		[string]$OutFilePath,
		[parameter(Mandatory = $true)]
		[string]$AuthToken
	)

	begin{
		$wc = New-Object System.Net.WebClient
		$wc.Headers.Add('Authorization',"token $AuthToken")
	}
	process{
		$wc.DownloadFile($Url, $OutFilePath)
	}
	end{
		$wc.Dispose()
	}
}