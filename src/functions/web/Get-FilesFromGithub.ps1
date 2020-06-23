function Get-FilesFromGithub{
	<#
	.SYNOPSIS
		This function retrieves the specified repository on GitHub to a local directory with authentication.

	.DESCRIPTION
		This function retrieves the specified repository on GitHub to a local directory with authentication, being a single file, a complete folder, or the entire repository.

	.PARAMETER User
		Your GitHub username, for using the Authenticated Service. Providing 5000 requests per hour.
		Without this you will be limited to 60 requests per hour.
		See for more information: https://developer.github.com/v3/auth/

	.PARAMETER Token
		The parameter Token is the generated token for authenticated users.
		Create one here (after logging in on your account): https://github.com/settings/tokens

	.PARAMETER Owner
		Owner of the repository you want to download from.

	.PARAMETER Repository
		The repository name you want to download from.

	.PARAMETER Path
		The path inside the repository you want to download from.
		If empty, the function will iterate the whole repository.
		Alternatively you can specify a single file.

	.PARAMETER Destination
		The local folder you want to download the repository to.

	.PARAMETER Ref
		The name of the commit/branch/tag. Default: the repository’s default branch (usually master)

	.EXAMPLE
		PS C:\> Get-FilesFromRepo -User "MyUsername" -Token "My40CharactersLongToken" -Owner "GitHubDeveloper" -Repository "RepositoryName" -Path "InternalFolder" -Destination "C:/MyDownloadedRepository" -Ref 'feature/test'
	#>

	Param(
		[Parameter(Mandatory=$true)]
		[string]$User,
		[Parameter(Mandatory=$true)]
		[string]$Token,
		[Parameter(Mandatory=$true)]
		[string]$Owner,
		[Parameter(Mandatory=$true)]
		[string]$Repository,
		[Parameter(Mandatory=$true)]
		[AllowEmptyString()]
		[string]$Path,
		[Parameter(Mandatory=$True)]
		[string]$Destination,
		[Parameter(Mandatory = $false)]
		[string]$Ref='master'
	)

	begin{ 
		[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

		$baseUri = "https://api.github.com";

		# Authentication
		$authPair = "$($User):$($Token)";
		$encAuth = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes($authPair));
		$headers = @{ Authorization = "Basic $encAuth" };
	}
	process{
		# REST Building
		$argsUri = "repos/$Owner/$Repository/contents/$($Path)?ref=$Ref";
		$response = Invoke-WebRequest -Uri ("$baseUri/$argsUri") -Headers $headers -UseBasicParsing

		# Data Handler
		$objects = $response.Content | ConvertFrom-Json
		$files = $objects | Where-Object {$_.type -eq "file"} | Select-Object -exp download_url
		$directories = $objects | Where-Object {$_.type -eq "dir"}
		
		# Iterate Directories
		$directories | ForEach-Object { 
			Get-FilesFromGithub -User $User -Token $Token -Owner $Owner -Repository $Repository -Path $_.path -Destination "$($Destination)/$($_.name)" -Ref:$Ref
		}

		if (-not (Test-Path $Destination)) {
			New-Item -Path $Destination -ItemType Directory -ErrorAction Stop
		}

		foreach ($file in $files) {
			$outputFilename = (Join-Path $Destination (Split-Path $file -Leaf)) -replace '\?.*', ''

			Invoke-WebRequest -Uri $file -OutFile $outputFilename -ErrorAction Stop
		}
	}
}