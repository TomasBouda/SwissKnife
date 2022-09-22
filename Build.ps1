$moduleName = 'SwissKnife'

. "$PSScriptRoot\src\functions\module\Start-ModuleBuild.ps1"

Start-ModuleBuild -ModuleDirectory "$PSScriptRoot\src" -ModuleName $moduleName -TargetVersion 1.0.0 -PublishFolder "$PSScriptRoot\output\$moduleName"