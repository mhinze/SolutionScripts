param($installPath, $toolsPath, $package, $project)

$parentFolder = resolve-path "$package\..";
$global:solutionScriptsContainer = Join-Path $parentFolder "SolutionScripts"

function global:Update-SolutionScripts()
{		
	if(!(test-path $solutionScriptsContainer -pathtype container)) 
	{
		new-item $solutionScriptsContainer -type directory
	}

	$files = Get-ChildItem $solutionScriptsContainer

	foreach ($file in $files)
	{	
		if ($file.extension -eq ".ps1") 
		{
			Write-Host "        Sourcing: $file"			
			. $file.fullname
		}
		if ($file.extension -eq ".psm1")
		{
			Write-Host "Importing Module: $file"
			Import-Module $file.fullname -Force
		}
	}
}

Update-SolutionScripts