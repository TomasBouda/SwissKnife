function Install-ModuleIfNotExist {
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

	$installInDirectory = $null -ne $InstallDirectory -and $InstallDirectory -ne ""
	if ($installInDirectory) {
		$isInstalled =	$null -ne (Get-Module -ListAvailable -FullyQualifiedName "$InstallDirectory\$Name" -ErrorAction SilentlyContinue)
	}
	else {
		$isInstalled = $null -ne (Get-Module -ListAvailable -Name $Name)
	}
	
	if (-not $isInstalled) {
		switch ($PsCmdlet.ParameterSetName) {
			'Default' {
				if ($null -ne $InstallDirectory -and $InstallDirectory -ne "") {
					Write-Host "Installing module $Name into $InstallDirectory"
					Install-ModuleInDirectory -Name $Name -InstallDirectory $InstallDirectory -AllowPrerelease:$AllowPrerelease -Force:$Force
				}
				else {
					Write-Host "Installing module $Name"
					Install-Module -Name $Name -Repository 'PSGallery' -Scope $InstallScope -AllowPrerelease:$AllowPrerelease -Force:$Force
				}
			}
			'CustomRepo' {
				if ($null -eq (Get-PSRepository -Name $RepositoryName)) {
					Register-PSRepository -Name $RepositoryName -SourceLocation $RepositoryUrl -PublishLocation $RepositoryUrl -InstallationPolicy Trusted
				}
				$credsAzureDevopsServices = New-Object System.Management.Automation.PSCredential $UserName, $Password

				if ($null -ne $InstallDirectory -and $InstallDirectory -ne "") {
					Write-Host "Installing module $Name from $RepositoryName into $InstallDirectory"
					Install-ModuleInDirectory -Name $Name -InstallDirectory $InstallDirectory -Credential $credsAzureDevopsServices -AllowPrerelease:$AllowPrerelease -Force:$Force	
				}
				else {
					Write-Host "Installing module $Name from $RepositoryName"
					Install-Module -Name $Name -Repository $RepositoryName -Credential $credsAzureDevopsServices -Scope $InstallScope -AllowPrerelease:$AllowPrerelease -Force:$Force
				}
			}
		}
	}

	if ($installInDirectory) {
		$modulePath = (Get-Module -ListAvailable -FullyQualifiedName "$InstallDirectory\$Name").Path
	}
	else {
		$modulePath = (Get-Module -ListAvailable -Name $Name).Path
	}

	# Test moulde path
	if ($null -eq $modulePath -or -not (Test-Path $modulePath)) {
		Write-Error "Module $Name was not isntalled! Path:$modulePath is invalid!"
	}
	elseif (-not $isInstalled) {
		Write-Host "Module $Name is installed in $modulePath"
	}
}