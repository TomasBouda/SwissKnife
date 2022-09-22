function ConvertTo-EncryptedString {
	param(
		[Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'SecureString')]
		[SecureString]$SecureString,
		[Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'PlainText')]
		[string]$PlainText,
		[Parameter(Mandatory = $false)]
		[ValidateSet('CurrentUser', 'LocalMachine')]
		[System.Security.Cryptography.DataProtectionScope]$Scope = [System.Security.Cryptography.DataProtectionScope]::CurrentUser
	)

	begin {
		$entropy = Get-Entropy
	}
	process {
		if ($PSCmdlet.ParameterSetName -eq 'SecureString') {
			$encryptedData = [System.Security.Cryptography.ProtectedData]::Protect(
				[System.Text.Encoding]::Unicode.GetBytes((ConvertFrom-SecureString $SecureString -AsPlainText)), 
				[System.Text.Encoding]::Unicode.GetBytes($entropy), 
				$Scope)
		}
		else {
			$encryptedData = [System.Security.Cryptography.ProtectedData]::Protect(
				[System.Text.Encoding]::Unicode.GetBytes($PlainText), 
				[System.Text.Encoding]::Unicode.GetBytes($entropy), 
				$Scope)
		}
	
		ConvertTo-Base64 -Bytes $encryptedData
	}	
}
