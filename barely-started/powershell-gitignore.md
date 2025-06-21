


```powershell
## Emit relative paths:
Get-ChildItem -Path ./ -Recurse -Force | Where-Object { $_.PSIsContainer -eq $false -and $_.FullName -notlike '*.git*'  } | Resolve-Path -Relative
```


Works sort of alright to exclude .git dir:
```powershell
## Emit relative paths:
Get-ChildItem -Path ./ -Recurse -Force | Where-Object {
     $_.PSIsContainer -eq $false -and $_.FullName -notlike '*.git*'  
     } | Resolve-Path -Relative
```

```powershell
## Emit relative paths:
Get-FilteredChildItem -IgnoreFileName -Path ./ -Recurse -Force | Where-Object { $_.PSIsContainer -eq $false -and $_.FullName -notlike '*.git*'  } | Resolve-Path -Relative
```

Slow but uses gitignore: (Has to call 'git check-ignore' seperately for each path)
```powershell
Get-ChildItem -Path .\ -Recurse -Force | Where-Object { 
	$_.PSIsContainer -eq $false  -and $_.FullName -notlike '*.git*'  -and -not (git check-ignore $_.FullName) 
	}  | Resolve-Path -Relative
```

Slower but uses gitignore: (No cheap exclude of .git dir)
```powershell
Get-ChildItem -Path .\ -Recurse -Force | Where-Object { 
	$_.PSIsContainer -eq $false  -and -not (git check-ignore $_.FullName) 
	}  | Resolve-Path -Relative
```


