function Get-Enum { 
    param (
		[Parameter(Mandatory=$true)]
        [Type]$Type
    )
 
    if ($Type.BaseType.FullName -ne 'System.Enum')
    {
        return
    }
 
    if ($Type.CustomAttributes | Where-Object { $_.AttributeType -eq [System.FlagsAttribute] })
    {
        $isFlagsEnum = $true
    }
 
    $props = @(
        @{ Name = 'Name'; Expression={ [string]$_ } }
        @{ Name = 'Value'; Expression={ [uint32](Invoke-Expression "[$($type.FullName)]'$_'") }}
    )
 
    if ($isFlagsEnum)
    {
        $props += @{ Name = 'Binary'; Expression={[Convert]::ToString([uint32](Invoke-Expression "[$($type.FullName)]'$_'"), 2)}}
    }
 
    [enum]::GetNames($Type) | Select-Object -Property $props   
} 