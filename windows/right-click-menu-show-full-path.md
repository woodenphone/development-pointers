# Right-click context menu option to copy full path to clipboard (Windows)
Right-click context menu option to copy full path to clipboard.




## Technical breakdown
Registry key to add "":
```reg
[HKEY_CLASSES_ROOT\AllFilesystemObjects\shell\windows.copyaspath]
"CanonicalName"="{707C7BC6-685A-4A4D-A275-3966A5A3EFAA}"
"CommandStateHandler"="{3B1599F9-E00A-4BBF-AD3E-B3F99FA87779}"
"CommandStateSync"=""
"Description"="@shell32.dll,-30336"
"Icon"="imageres.dll,-5302"
"InvokeCommandOnSelection"=dword:00000001
"MUIVerb"="@shell32.dll,-30329"
"VerbHandler"="{f3d06e7c-1e45-4a26-847e-f9fcdee59be0}"
"VerbName"="copyaspath"

[HKEY_CLASSES_ROOT\AllFilesystemObjects\shellex\ContextMenuHandlers\CopyAsPathMenu]
@="{f3d06e7c-1e45-4a26-847e-f9fcdee59be0}"
```

```reg

[HKEY_CLASSES_ROOT\Allfilesystemobjects\shell\windows.copyaspath]
"CanonicalName"="{707C7BC6-685A-4A4D-A275-3966A5A3EFAA}"
"CommandStateHandler"="{3B1599F9-E00A-4BBF-AD3E-B3F99FA87779}"
"CommandStateSync"=""
"Description"="@shell32.dll,-30336"
"Icon"="imageres.dll,-5302"
"InvokeCommandOnSelection"=dword:00000001
"MUIVerb"="@shell32.dll,-30329"
"VerbHandler"="{f3d06e7c-1e45-4a26-847e-f9fcdee59be0}"
"VerbName"="copyaspath"
```


```registry-path
HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell
```



## Investigation

Basic inspection of involved locations:
----------

Simple but very long `dir` of registry location via powershell registry provider `hklm:`:
```powershell
dir hklm:Software\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell
```


In `regedit`, look at: 
- `HKEY_CLASSES_ROOT\Allfilesystemobjects\shell`
- `HKEY_CLASSES_ROOT\AllFilesystemObjects\shellex`
- `HKEY_CLASSES_ROOT\AllFilesystemObjects\shellex\ContextMenuHandlers`
- `HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell`




Basic web research of registry locations:
----------

Web search for `HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell` leads to:
- BIG LEAD BIG INFO: https://learn.microsoft.com/en-us/windows/win32/shell/context-menu-handlers
- https://learn.microsoft.com/en-us/windows/win32/shell/how-to--create-cascading-menus-with-the-subcommands-registry-entry


### Summary of principles:





## Files:


## Links:
### Places demonstrating method:
- https://www.tenforums.com/tutorials/73649-copy-path-add-context-menu-windows-10-a.html
- https://gist.github.com/unbleaklessness/50e6a175635f79f4ed2b8a8e0b9d4019
- https://gist.github.com/ebicoglu/5a8a2921ba6ed62eef88eec7943c0440
- https://gist.github.com/Camork/b0753b8e8c6d5639a42df25a7917dc51
- https://winaero.com/how-to-add-any-ribbon-command-to-the-right-click-menu-in-windows-8/
- https://learn.microsoft.com/en-us/windows/win32/shell/how-to--create-cascading-menus-with-the-subcommands-registry-entry
- https://learn.microsoft.com/en-us/windows/win32/shell/shell-entry


### Microsoft official documentation 
- "provide drag-and-drop operations" https://learn.microsoft.com/en-us/windows/win32/api/oleidl/nn-oleidl-idroptarget


### Right-Click Context Menu (Microsoft official documentation) 
- BIG LEAD BIG INFO: https://learn.microsoft.com/en-us/windows/win32/shell/context-menu-handlers

- https://learn.microsoft.com/en-us/windows/win32/shell/shell-entry
- https://learn.microsoft.com/en-us/windows/win32/shell/how-to--create-cascading-menus-with-the-subcommands-registry-entry
- "Shortcut Menu Reference" https://learn.microsoft.com/en-us/windows/win32/shell/context-menu-reference


### Powershell-related:


- https://learn.microsoft.com/en-us/powershell/scripting/samples/working-with-registry-entries?view=powershell-7.5
- https://learn.microsoft.com/en-us/powershell/scripting/samples/working-with-registry-keys?view=powershell-7.5
- https://devblogs.microsoft.com/powershell-community/how-to-update-or-add-a-registry-key-value-with-powershell/


### Registry-related:
- Overview of how the registry works and is organized: https://learn.microsoft.com/en-us/troubleshoot/windows-server/performance/windows-registry-advanced-users
- https://archive.org/download/vdoc.pub_microsoft-windows-registry-guide/microsoft-windows-registry-guide_compress.pdf
- win32 API for registry access:  https://learn.microsoft.com/en-us/windows/win32/sysinfo/registry-functions
- https://learn.microsoft.com/en-us/windows/win32/shell/how-to--create-cascading-menus-with-the-subcommands-registry-entry
- '.reg' format: https://support.microsoft.com/en-us/topic/how-to-add-modify-or-delete-registry-subkeys-and-values-by-using-a-reg-file-9c7f37cf-a5e9-e1cd-c4fa-2a26218a1a23


## Meta
Related to writing this document.

- URL ["FILENAME"](<FILE_PATH>) (`SIZE_FILENAME_AND_HASH`)
<!-- - URL ["FILENAME"](<FILE_PATH>) (`SIZE_FILENAME_AND_HASH`) -->

- SUMMARY ["TITLE" - "SUBTITLE" ()](<URL>) Locally: ["FILENAME"](<FILE_PATH>) (`SIZE_FILENAME_AND_HASH` at YYYY-MM-DD Zulu)

