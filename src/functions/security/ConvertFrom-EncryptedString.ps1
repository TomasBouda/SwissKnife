function ConvertFrom-EncryptedString {
	param(
		[Parameter(Mandatory = $true, ValueFromPipeline = $true)]
		[string]$EncryptedString,
		[Parameter(Mandatory = $false)]
		[switch]$AsPlainText,
		[Parameter(Mandatory = $false)]
		[ValidateSet('CurrentUser', 'LocalMachine')]
		[System.Security.Cryptography.DataProtectionScope]$Scope = [System.Security.Cryptography.DataProtectionScope]::CurrentUser
	)
	
	begin {
		$entropy = Get-Entropy
	}
	process {
		$decryptedData = [System.Security.Cryptography.ProtectedData]::Unprotect(
			[System.Convert]::FromBase64String($EncryptedString), 
			[System.Text.Encoding]::Unicode.GetBytes($entropy), 
			$Scope)
		
		$decrtypted = [System.Text.Encoding]::Unicode.GetString($decryptedData)

		if ($AsPlainText) {
			$decrtypted
		}
		else {
			ConvertTo-SecureString -String $decrtypted -AsPlainText
		}
	}
}