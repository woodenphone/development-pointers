# Windows CLSIDs 
Windows uses an identifier value called a CLSID ... TODO


* ["CLSID Key" (learn.microsoft.com)](https://learn.microsoft.com/en-us/windows/win32/com/clsid-key-hklm)
 and its [document source in "MicrosoftDocs/win32" (github repo)](https://github.com/MicrosoftDocs/win32/blob/docs/desktop-src/com/clsid-key-hklm.md)
 ("Apps / Win32 / Desktop Technologies / System Services / Component Object Model (COM) / CLSID Key")

----------

Formats used:
- `{D4480A50-BA28-11d1-8E75-00C04FA31A86}`
- `{#D4480A50-BA28-11d1-8E75-00C04FA31A86}`


----------


## Exporting list of CLSID
Export a list of CLSIDs from a windows machine

Goal: Produce table of name - CLSID-GUID mappings, (maybe multiple tables for different things?)
Like:
```
> SOME_COMMAND
".png" "{SOME_GUID}"
...
```


Examining registry entries for filetypes:
----------

Simple dir on PowerShell Registry Provider:
```powershell
dir HKCR:
```

Display as list:
```powershell
dir HKCR: | Format List
```

Display as JSON:
```powershell
dir HKCR: | ConvertTo-Json -Depth 1
```

Get entry for a specific file extention:
```powershell
Get-Item "HKCR:.mp3"

Get-Item "HKCR:.mp3" | format-list *

Get-Item "HKCR:.mp3" | Get-Member *

Get-Item "HKCR:.mp3" | ConvertTo-Json -Depth 1
```

----------

Fails to produce CLSID GUID values:
```
Get-ChildItem HKLM:\Software\Classes -ErrorAction SilentlyContinue | Where-Object {
	$_.PSChildName -match '^\w+\.\w+$' -and (Test-Path -Path "$($_.PSPath)\CLSID")
} | Select-Object -ExpandProperty PSChildName
```
* From <https://powershellmagazine.com/2013/06/27/pstip-get-a-list-of-all-com-objects-available/>

----------

CLSID found at paths:
* `Computer\HKEY_CLASSES_ROOT\X509Enrollment.CX509AttributeExtensions.1\CLSID`
* `Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Classes\.dll\PersistentHandler`
* `Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Classes\.docx\ShellEx\{8895b1c6-b41f-4c1c-a562-0d564250836f}`


----------


```powershell
Get-ChildItem HKLM:\Software\Classes\* | Select-Object `(default`), PSChildName
```

```powershell
todo
| format-list 
> clsid-list.txt
```

----------

* TODO: Write script(s) and put in powershell example scripts dir, linking from here.



----------



### CLSID uses
* TODO: What uses CLSID values for what
* TODO: How to determine what references a CLSID - possibly script recursively collating references in registry and other juicy information places?


### Windows COM (Component Object Model)
* TODO: Explain WTF it is and how to do useful things with it.


### Windows COM+ (?)
* TODO: Explain WTF it is and how to do useful things with it.


### Windows WMI (?)
* TODO: Decide if pertinent and deserving on inclusion.
* TODO: Explain WTF it is and how to do useful things with it.



## Related files
Files and dirs in this repo related to this topic.
* TODO: Add file links.


## Links
This section is functionally kinda a bibliography; providing whatever I can find on the topic, in hopes having a collection of high-relevancy links helps.
* TODO: Titles and descriptions for each link.


### Microsoft documentation
* ["CLSID Key" (learn.microsoft.com)](https://learn.microsoft.com/en-us/windows/win32/com/clsid-key-hklm)
 and its [document source in "MicrosoftDocs/win32" (github repo)](https://github.com/MicrosoftDocs/win32/blob/docs/desktop-src/com/clsid-key-hklm.md)
* ["TITLE" (learn.microsoft.com)]https://learn.microsoft.com/en-us/previous-versions/windows/desktop/automat/guids-and-the-system-registry)
* ["TITLE" (learn.microsoft.com)]https://learn.microsoft.com/en-us/windows/win32/api/guiddef/ns-guiddef-guid)
* ["TITLE" (learn.microsoft.com)]https://learn.microsoft.com/en-us/troubleshoot/entra/entra-id/governance/verify-first-party-apps-sign-in#application-ids-of-commonly-used-microsoft-applications)
* ["GetClassFile function (objbase.h)" "Returns the CLSID associated with the specified file name"  (learn.microsoft.com)](https://learn.microsoft.com/en-us/windows/win32/api/objbase/nf-objbase-getclassfile)
* ["TITLE" (learn.microsoft.com)](LINK)
* ["TITLE" (learn.microsoft.com)](LINK)


---------
COM (Component Object Model)

* ["Component Object Model (COM)" (learn.microsoft.com)](https://learn.microsoft.com/en-us/windows/win32/com/component-object-model--com--portal)
* ["Registry Entries (COM)" (learn.microsoft.com)](https://learn.microsoft.com/en-us/windows/win32/com/registry-entries)
* ["HKEY_LOCAL_MACHINE\SOFTWARE\Classes" (learn.microsoft.com)](https://learn.microsoft.com/en-us/windows/win32/com/hkey-local-machine-software-classes)
* ["HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Ole" (learn.microsoft.com)](https://learn.microsoft.com/en-us/windows/win32/com/hkey-local-machine-software-microsoft-ole)
* file extention handlers: ["<file_extension> Key" (learn.microsoft.com)](https://learn.microsoft.com/en-us/windows/win32/com/-file-extension--key)
* `HKEY_LOCAL_MACHINE\SOFTWARE\Classes\AppID\{AppID_GUID}` - ["AppID Key" (learn.microsoft.com)](https://learn.microsoft.com/en-us/windows/win32/com/appid-key)
* `HKEY_LOCAL_MACHINE\SOFTWARE\Classes\{ProgID}` - ["ProgID Key" (learn.microsoft.com)](https://learn.microsoft.com/en-us/windows/win32/com/-progid--key)
* `HKEY_LOCAL_MACHINE\SOFTWARE\Classes\FileType\{CLSID}` - ["FileType Key" (learn.microsoft.com)](https://learn.microsoft.com/en-us/windows/win32/com/filetype-key)
* ["TITLE" (learn.microsoft.com)](LINK)
* ["TITLE" (learn.microsoft.com)](LINK)
* ["TITLE" (learn.microsoft.com)](LINK)
* ["TITLE" (learn.microsoft.com)](LINK)



----------
COM+
* ["COM+ (Component Services)" (learn.microsoft.com)](https://learn.microsoft.com/en-us/windows/win32/cossdk/component-services-portal)
* ["COM+ Developers Overview" (learn.microsoft.com)]https://learn.microsoft.com/en-us/windows/win32/cossdk/com--developers-overview)
* ["COM+ Programming Overview" (learn.microsoft.com)](https://learn.microsoft.com/en-us/windows/win32/cossdk/com--programming-overview)
* ["COM+ Reference" (learn.microsoft.com)]https://learn.microsoft.com/en-us/windows/win32/cossdk/com--reference)
* ["COM+ Programming Reference" (learn.microsoft.com)]https://learn.microsoft.com/en-us/windows/win32/cossdk/com--programming-reference)
* ["COM+ Administration Reference" (learn.microsoft.com)]https://learn.microsoft.com/en-us/windows/win32/cossdk/com--administration-reference)
* ["TITLE" (learn.microsoft.com)](LINK)
* ["TITLE" (learn.microsoft.com)](LINK)
* ["TITLE" (learn.microsoft.com)](LINK)
* ["TITLE" (learn.microsoft.com)](LINK)


----------
"OLE Automation"
* ActivX-related: ["Automation (formerly called OLE Automation)" ( Previous Versions / Windows )(learn.microsoft.com)](https://learn.microsoft.com/en-us/previous-versions/windows/desktop/automat/automation-programming-reference)
* "OLE Automation" ["oaidl.h header" "This header is used by Automation" ( Learn / Windows / Apps / Win32 / API )(learn.microsoft.com)](https://learn.microsoft.com/en-us/windows/win32/api/oaidl/)
* OLE Automation: ["Automation" ( Learn / Windows / Apps / Win32 / API  )(learn.microsoft.com)](https://learn.microsoft.com/en-us/windows/win32/api/_automat/)
* ["TITLE" (learn.microsoft.com)](LINK)
* ["TITLE" (learn.microsoft.com)](LINK)

----------
"UI Automation"
* ["UI Automation Specification and Community Promise" (learn.microsoft.com)](https://learn.microsoft.com/en-us/windows/win32/winauto/uiauto-specandcommunitypromise)
* ["UI Automation Tree Overview" (learn.microsoft.com)](https://learn.microsoft.com/en-us/windows/win32/winauto/uiauto-treeoverview)
* ["UI Automation Control Types Overview" (learn.microsoft.com)](https://learn.microsoft.com/en-us/windows/win32/winauto/uiauto-controltypesoverview)
* ["UI Automation Client Programmer's Guide" (learn.microsoft.com)](https://learn.microsoft.com/en-us/windows/win32/winauto/uiauto-clientportal)
*  ["TITLE" (learn.microsoft.com)](LINK)
*  ["TITLE" (learn.microsoft.com)](LINK)


----------
Thumbnail handling

*  ["Creating Thumbnail Images" (Learn/Windows/Apps/Win32/Desktop Technologies/Graphics and Gaming/GDI+) (learn.microsoft.com)](https://learn.microsoft.com/en-us/windows/win32/gdiplus/-gdiplus-creating-thumbnail-images-use)


Thumbnail generation for Explorer: 
* ["Thumbnail Handlers" (Learn/Windows/Apps/Win32/Desktop Technologies/Desktop Environment/Windows Shell) (learn.microsoft.com)](https://learn.microsoft.com/en-us/windows/win32/shell/thumbnail-providers)
* ["Thumbnail Handler Guidelines" (Learn/Windows/Apps/Win32/Desktop Technologies/Desktop Environment/Windows Shell) (learn.microsoft.com)](https://learn.microsoft.com/en-us/windows/win32/shell/thumbnail-provider-guidelines)
* ["Building Thumbnail Handlers" (Learn/Windows/Apps/Win32/Desktop Technologies/Desktop Environment/Windows Shell) (learn.microsoft.com)](https://learn.microsoft.com/en-us/windows/win32/shell/building-thumbnail-providers)
["Recipe Thumbnail Provider Sample" (Learn/Windows/Apps/Win32/Desktop Technologies/Desktop Environment/Windows Shell) (learn.microsoft.com)](https://learn.microsoft.com/en-us/windows/win32/shell/samples-recipethumbnailprovider)
* ["How to Assign a Custom Icon to a File Type" (learn.microsoft.com)](https://learn.microsoft.com/en-us/windows/win32/shell/how-to-assign-a-custom-icon-to-a-file-type)
* ["IThumbnailProvider interface (thumbcache.h)" (Learn/Windows/Apps/Win32/API/The Windows Shell/Thumbcache.h ) (learn.microsoft.com)](https://learn.microsoft.com/en-us/windows/win32/api/thumbcache/nn-thumbcache-ithumbnailprovider)

Thumbs.db:
* "Thumbs.db file" ["IThumbnailCache interface (thumbcache.h)" (learn.microsoft.com)](https://learn.microsoft.com/en-us/windows/win32/api/thumbcache/nn-thumbcache-ithumbnailcache)
* ["IThumbnailCache::GetThumbnail method (thumbcache.h)" - "Gets a cached thumbnail for a given Shell item." (learn.microsoft.com)](https://learn.microsoft.com/en-us/windows/desktop/api/thumbcache/nf-thumbcache-ithumbnailcache-getthumbnail)


Thumbnail-related headers:
* ["thumbcache.h header" (Learn/Windows/Apps/Win32/API/) (learn.microsoft.com)](https://learn.microsoft.com/en-us/windows/win32/api/thumbcache/)
* ["thumbnailstreamcache.h header" (Learn/Windows/Apps/Win32/API/) (learn.microsoft.com)](https://learn.microsoft.com/en-us/windows/win32/api/thumbnailstreamcache/)


Thumbnails of running apps:
* "thumbnail representations of application windows" ["DWM Thumbnail Overview" (Apps/Win32/Desktop/Technologies/Desktop App User Interface/Desktop Window Manager) (learn.microsoft.com)](https://learn.microsoft.com/en-us/windows/win32/dwm/thumbnail-ovw)


### Powershell documentation

----------

PowerShell: Registry:
* ["about_Registry_Provider" (PowerShell docs)](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_registry_provider?view=powershell-7.4)
* ["Working with registry keys" (PowerShell docs)](https://learn.microsoft.com/en-us/powershell/scripting/samples/working-with-registry-keys?view=powershell-7.4)
* ["Use the PowerShell Registry Provider to Simplify Registry Access" (MSFT "Dev Blogs / Scripting Blog [archived]")](https://devblogs.microsoft.com/scripting/use-the-powershell-registry-provider-to-simplify-registry-access/)


----------

PowerShell: Formattin and conversiong:
* ["Format-List" (PowerShell docs)](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/format-list?view=powershell-7.4)
* ["Format-Table" (PowerShell docs)](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/format-table?view=powershell-7.4)
* ["ConvertTo-Csv" (PowerShell docs)](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/convertto-csv?view=powershell-7.4)
* ["ConvertTo-Xml" (PowerShell docs)](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/convertto-xml?view=powershell-7.4)
* ["ConvertTo-Json" (PowerShell docs)](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/convertto-json?view=powershell-7.4)


----------
Powershell: Misc
* ["DOCNAME" (PowerShell docs)](LINK)
* ["DOCNAME" (PowerShell docs)](LINK)
* ["DOCNAME" (PowerShell docs)](LINK)
* ["DOCNAME" (PowerShell docs)](LINK)
* ["DOCNAME" (PowerShell docs)](LINK)
* ["DOCNAME" (PowerShell docs)](LINK)


### Guides and articles


----------
(Seven / Eight / Ten / Eleven)-forums" articles and discussions:
* https://www.tenforums.com/tutorials/3123-clsid-key-guid-shortcuts-list-windows-10-a.html
* https://www.tenforums.com/tutorials/130522-generate-globally-unique-identifier-guid-windows.html
* https://www.elevenforum.com/t/i-want-to-generate-a-list-of-installed-microsoft-store-applications.15385/
* https://www.elevenforum.com/t/list-of-windows-11-clsid-key-guid-shortcuts.1075/

----------

### Lists of CLSIDs:
Lists, tables, databases, etc. of CLSID values and what they refer to.

----------
Official (MSFT sources)
* CLSIDs for MSFT apps: ["merill/microsoft-info" - "Repository hosting a static list of Microsoft First party apps and Graph permissions that's updated daily" (github repo)](https://github.com/merill/microsoft-info/)

----------
Unofficial (Non-MSFT sources)
* ["lundeen-bryan/ClsidWin10.md" - "All CLSIDs in Win10" (github gist)](https://gist.github.com/lundeen-bryan/51f5e73770cbfbbe97ba99561c8077ea)


----------
Incidental (Non-MSFT sources that just happen to have CLSID info)
* https://github.com/merill/microsoft-info/blob/main/_info/MicrosoftApps.csv
* https://github.com/ohpe/juicy-potato/blob/master/CLSID/Windows_10_Pro/README.md
* https://github.com/ohpe/juicy-potato/blob/master/CLSID/GetCLSID.ps1


### Questions and answers
* https://superuser.com/questions/1559064/how-to-get-list-of-clsids-along-with-their-associated-com-object-names#1559087

## Unsorted links



* 
* 
* https://powershellmagazine.com/2013/06/27/pstip-get-a-list-of-all-com-objects-available/





## document meta
github:
* ["USER_NAME/REPO_NAME" "REPO_DESCRIPTION" (github)](ADDRESS)
* ["USER_NAME/REPO_NAME" "REPO_DESCRIPTION" (github)](ADDRESS)

gist:
* ["USERNAME/FILENAME" (github gist)](ADDRESS)
* ["USERNAME/FILENAME" (github gist)](ADDRESS)
