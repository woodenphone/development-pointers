

## List files git knows about and isn't ignoring:
[string[]] $git_ls_params = $( ## Prepare positional params as array of strings for commenting.
	## https://git-scm.com/docs/git-ls-files#Documentation/git-ls-files.txt
	# > git 
	'ls-files',
	'--cached', ## 'cached' status.
	'--others',
	# '--ignored', ## Show ignored files.
	'--exclude-standard', ## Apply gitignore rules.
	'--deduplicate' ## Only list any filepath onece.
)

## https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_operators?view=powershell-7.5#array-subexpression-operator--
[string[]] $files_git_sees = @(  ## Capture output lines as an array of strings.
	git ${git_ls_params}
)

# Write-Host $files_git_sees ## Print: foo bar baz...
$files_git_sees| ForEach-Object { Write-Host "$_" } ## Print: foo<LF>bar<LF>baz<LF>...







exit



# ## Paths that we want to skip:
# [string[]] $Gitignored-Paths = (
# 	## 
# 	'.git', ## Git repo special dir.
# 	## All files relative to pwd to exclude:
# 	(git ls-files -o -i --exclude-standard)
# 	# git ls-files -o -i --exclude-standard
# )

# [string[]] $params={ ## Prepare positional params as array of strings for commenting.
# 	''
# }


# Get-ChildItem -Path .\ -Recurse -Force | Where-Object { 
# 	$_.PSIsContainer -eq $false  -and -not (git check-ignore $_.FullName) 
# 	}  | Resolve-Path -Relative


# ## 