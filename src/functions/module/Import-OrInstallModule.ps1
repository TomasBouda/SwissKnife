function Import-OrInstallModule {
	param(
		[Parameter(Mandatory = $true, ParameterSetName = 'Default')]
		[Parameter(Mandatory = $true, ParameterSetName = 'CustomRepo')]
		[string]$Name,
		[Parameter(Mandatory = $false, ParameterSetName = 'Default')]
		[Parameter(Mandatory = $false, ParameterSetName = 'CustomRepo')]
		[string]$InstallDirectory = $null,
		[Parameter(Mandatory = $false, ParameterSetName = 'Default')]
		[Parameter(Mandatory = $false, ParameterSetName = 'CustomRepo')]
		[string]$InstallScope = 'CurrentUser',
		[Parameter(Mandatory = $true, ParameterSetName = 'CustomRepo')]
		[string]$RepositoryName,
		[Parameter(Mandatory = $true, ParameterSetName = 'CustomRepo')]
		[string]$RepositoryUrl,
		[Parameter(Mandatory = $true, ParameterSetName = 'CustomRepo')]
		[string]$UserName,
		[Parameter(Mandatory = $true, ParameterSetName = 'CustomRepo')]
		[SecureString]$Password,
		[Parameter(Mandatory = $false, ParameterSetName = 'Default')]
		[Parameter(Mandatory = $false, ParameterSetName = 'CustomRepo')]
		[switch]$AllowPrerelease,
		[Parameter(Mandatory = $false, ParameterSetName = 'Default')]
		[Parameter(Mandatory = $false, ParameterSetName = 'CustomRepo')]
		[switch]$Force
	)

	switch ($PsCmdlet.ParameterSetName) { 
		'Default' {
			Install-ModuleIfNotExist -Name $Name -InstallDirectory $InstallDirectory -InstallScope $InstallScope -AllowPrerelease:$AllowPrerelease -Force:$Force
		}
		'CustomRepo' {
			Install-ModuleIfNotExist -Name $Name -InstallDirectory $InstallDirectory -InstallScope $InstallScope -RepositoryName $RepositoryName -RepositoryUrl $RepositoryUrl -UserName $UserName -Password $Password -AllowPrerelease:$AllowPrerelease -Force:$Force
		}
	}

	if ($null -ne $InstallDirectory -and $InstallDirectory -ne "") {
		Import-Module -FullyQualifiedName "$InstallDirectory\$Name"
	}
	else {
		Import-Module -Name $Name
	}
}