function Install-ModuleInDirectory {
	param(
		[Parameter(Mandatory = $true, ParameterSetName = 'Default')]
		[Parameter(Mandatory = $true, ParameterSetName = 'CustomRepo')]
		[string]$Name,
		[Parameter(Mandatory = $true, ParameterSetName = 'Default')]
		[Parameter(Mandatory = $true, ParameterSetName = 'CustomRepo')]
		[string]$InstallDirectory,
		[Parameter(Mandatory = $true, ParameterSetName = 'CustomRepo')]
		[string]$RepositoryName,
		[Parameter(Mandatory = $true, ParameterSetName = 'CustomRepo')]
		[Pscredential]$Credential,
		[Parameter(Mandatory = $false, ParameterSetName = 'Default')]
		[Parameter(Mandatory = $false, ParameterSetName = 'CustomRepo')]
		[switch]$AllowPrerelease,
		[Parameter(Mandatory = $false, ParameterSetName = 'Default')]
		[Parameter(Mandatory = $false, ParameterSetName = 'CustomRepo')]
		[switch]$Force
	)

	process {
		New-Item $InstallDirectory -ItemType Directory -Force | Out-Null

		switch ($PsCmdlet.ParameterSetName) { 
			'Default' {
				Find-Module -Name $Name -Repository 'PSGallery' -AllowPrerelease:$AllowPrerelease | Save-Module -Path $InstallDirectory -Force:$Force
			}
			'CustomRepo' {
				Find-Module -Name $Name -Repository $RepositoryName -Credential $Credential -AllowPrerelease:$AllowPrerelease | Save-Module -Path $InstallDirectory -Force:$Force
			}
		}
	}
}