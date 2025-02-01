# Find who is locking a file (Windows)



## Practical
To just make the problem go away.
* https://learn.microsoft.com/en-us/sysinternals/downloads/process-explorer
* https://learn.microsoft.com/en-us/sysinternals/downloads/handle


### Graphically via Sysinternals Process Explorer utility

`Find` -> `Find handle or DLL`  (or Hotkey `Ctrl+Shift+F`.)

Type part of the path into the `Handle or DLL substring:`  text box then click the `Search` button.

Wait for results, this can be slow.

Click on a result to cause Process Explorer to navigate to and select it to it in the main window.
Both the upper "Process view" pane and the lower "?attribute view?" pane autonavigate to bring the selected result process and filepath into view.

* Example of the result shown in the main window: Type: `File` Name: `C:\Users\User\Documents\repos\gpg-dirty.private`

Right clicking the result in the lower "?attribute view?" pane gives the option to forcefully close the handle.

Right clicking the process in the upper "Process view" pane gives the option to kill the process.


### "handle" CLI utility


#### Releasing file lock with 'handle' util 
Example step-by-step of using the `handle.exe` program to release unlock a file.
Download program from the Microsoft website. [Download page for "Handle" (Learn / Sysinternals / Handle) (learn.microsoft.com))](https://learn.microsoft.com/en-us/sysinternals/downloads/handle)

From official docs; ["Usage", (Learn / Sysinternals / Handle), (learn.microsoft.com)](https://learn.microsoft.com/en-us/sysinternals/downloads/handle#usage)
`usage: handle [[-a [-l]] [-v|-vt] [-u] | [-c <handle> [-y]] | [-s]] [-p <process>|<pid>] [name]`
9You may optionally elect to place the Sysinternals suite of tools in a dir referenced by `$PATH`

Example of regaining control of dir:
```powershell
## Navigate to location of program `handle.exe`
## 'cd' is a out-of-the-box alias for the 'Set-Location' cmdlet.
cd "C:\Users\User\Downloads\utils\SysinternalsSuite"

## 
./handle64.exe  

## todo
```




## Theory
To understand the reasons behind the problem, and concepts related to it.
* TODO: Get solid grasp of theory and explain things here.
* TODO: Files and handles, locks, File IO concepts
* TODO: Processes, threads, PIDs
* TODO: Execution contexts - User, Groups, permissions, ACLs, Windows SIDs, Windows well-known SIDs, Workgroups / Windows in multi-user multi-host hotdesking corporate type network environment.
* TODO: Filesystems - NTFS, FAT16/32, ExFAT, SMB, CIFS, etc.
* TODO:Collect pertinent links from bookmarks dump.
* TODO:Collect pertinent links from web searching.


### Links relating to theory
* https://learn.microsoft.com/en-us/windows/win32/sysinfo/handles-and-objects



## Links
### Microsoft
* https://learn.microsoft.com/en-us/sysinternals/downloads/process-explorer
* https://learn.microsoft.com/en-us/sysinternals/downloads/handle


### Misc
* https://superuser.com/questions/196882/how-do-i-know-which-file-is-open-in-windows-from-command-line
* https://stackoverflow.com/questions/15708/how-can-i-determine-whether-a-specific-file-is-open-in-windows
