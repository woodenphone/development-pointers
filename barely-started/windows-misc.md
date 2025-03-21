# Windows misc
Miscellaneous information relating to windows.
Probably gonna act as a temporary storage place for useful-looking stuff.

* TODO: Download all linked material to prevent it vanishing entirely;
* TODO: Come up with a nice format for citing/referencing PDFs and other saved materials, including `(title, date, filename, filesize, hash)` information.


----------

Windows GUI docs:
* [""](https://old.portnov.com/files/WindowsUserExperience_(Windows_XP_2000).pdf)
* ["Official Guidelines for User Interface Developers and Designers"](https://rauterberg.employee.id.tue.nl/lecturenotes/MS-Official-GUI-2001.pdf)


* [Search for "Microsoft Windows Interface" books on archive.org](https://archive.org/search?query=Microsoft+Windows+Interface&and%5B%5D=mediatype%3A%22texts%22)
* ["Microsoft Windows user experience" (1999) by Microsoft Corporation  (non-downloadable item on archive.org)](https://archive.org/details/microsoftwindows00micr_0)
* ["Windows User Experience Interaction Guidelines for Windows 7 and Windows Vista"  (2010) by Microsoft Corporation  (pdf on archive.org)](https://archive.org/details/microsoftwindows00micr_0)
* (metadata about book) https://openlibrary.org/books/OL1269219M/The_Windows_interface_guidelines_for_software_design.
* https://guidebookgallery.org/books/thewindowsinterfaceguidelinesforsoftwaredesign
* https://guidebookgallery.org/books



----------

Windows GUI customization

----------

Customizing "Quick Access" sidebar




Location where list of items in Quick Access sidebar is kept: 
File: `%AppData%\Microsoft\Windows\Recent\AutomaticDestinations\f01b4d95cf55d32a.automaticDestinations-ms`
In dir: `%AppData%\Microsoft\Windows\Recent\AutomaticDestinations\`

Add any UNC path to Quick Access sidebar:
```powershell
$quickaccess.Namespace("\\munfs01\public\sales").Self.InvokeVerb("pintohome")
```

Remove any UNC path to Quick Access sidebar:
```powershell
($QuickAccess.Namespace("shell:::{679f85cb-0220-4080-b29b-5540cc05aab6}").Items() | where {$_.Path -eq "C:\CorpApp\Report"}).InvokeVerb("unpinfromhome")
```

* ["How to Add or Remove Pinned Folders to Quick Access with PowerShell and GPO"](https://woshub.com/add-remove-pinned-folders-quick-access-powershell-gpo/)
* ["How to Backup and Restore Quick Access Pinned Folders in Windows 10" (tenforums.com)](https://www.tenforums.com/tutorials/175934-how-backup-restore-quick-access-pinned-folders-windows-10-a.html)
* ["Clear and Reset Quick Access Folders in Windows 11" (elevenforum.com)](https://www.elevenforum.com/t/clear-and-reset-quick-access-folders-in-windows-11.4693/)


----------

App SDK:
* ["Windows App SDK" (learn.microsoft.com)](https://learn.microsoft.com/en-us/windows/apps/windows-app-sdk/)
* ["WinUI" (learn.microsoft.com)](https://learn.microsoft.com/en-us/windows/apps/winui/)
* https://learn.microsoft.com/en-us/windows/windows-app-sdk/api/win32/_winuicominterop/
* https://learn.microsoft.com/en-us/windows/winui/api/
* https://learn.microsoft.com/en-us/windows/windows-app-sdk/api/winrt/



----------

Display scaling
* ["Microsoft.Graphics.Display Namespace" "Contains components to determine aspects of a physical display."](https://learn.microsoft.com/en-us/windows/windows-app-sdk/api/winrt/microsoft.graphics.display?view=windows-app-sdk-1.6)
* ["Scaling according to DPI sample"](https://github.com/Microsoft/Windows-universal-samples/tree/main/Samples/DpiScaling)
* DPI, rotation, scaling: ["DisplayInformation Class"](https://learn.microsoft.com/en-us/uwp/api/windows.graphics.display.displayinformation?view=winrt-26100&redirectedfrom=MSDN)
* Scaling factors enum: ["ResolutionScale Enum" Namespace:Windows.Graphics.Display ](https://learn.microsoft.com/en-us/uwp/api/windows.graphics.display.resolutionscale?view=winrt-26100&redirectedfrom=MSDN)
* ["DisplayInformation.ResolutionScale Property" "Gets the scale factor of the app window." Namespace:Windows.Graphics.Display ](https://learn.microsoft.com/en-us/uwp/api/windows.graphics.display.displayinformation.resolutionscale?view=winrt-26100#Windows_Graphics_Display_DisplayInformation_ResolutionScale)
* ["Windows.Graphics.Display Namespace" "Contains components to determine aspects of a physical display."](https://learn.microsoft.com/en-us/uwp/api/windows.graphics.display?view=winrt-26100)
* ["TITLE"](LINK)
* ["TITLE"](LINK)
* ["TITLE"](LINK)
* ["TITLE"](LINK)
* ["TITLE"](LINK)
* ["TITLE"](LINK)


----------

Debloat and tweak utils:
* https://christitus.com/windows-tool/
* https://www.oo-software.com/en/shutup10


----------

Windows Shell:
* https://learn.microsoft.com/en-us/windows/win32/shell/intro
* https://learn.microsoft.com/en-us/windows/win32/shell/customizing-file-types-bumper
* https://learn.microsoft.com/en-us/windows/win32/api/_shell/

----------


Control panel related topics:
* https://learn.microsoft.com/en-us/windows/win32/shell/controlpanel-canonical-names
* https://learn.microsoft.com/en-us/windows/win32/shell/registering-control-panel-items
* https://learn.microsoft.com/en-us/windows/win32/shell/executing-control-panel-items

* "Course" rather than just docpages: https://learn.microsoft.com/en-us/training/modules/explore-common-configuration-options/?source=recommendations
* https://learn.microsoft.com/en-us/entra/identity/devices/enterprise-state-roaming-windows-settings-reference


----------

Windows API:
* ["Windows API index"](https://learn.microsoft.com/en-us/windows/win32/apiindex/windows-api-list)
* ["Programming reference for the Win32 API"](https://learn.microsoft.com/en-us/windows/win32/api/)
* ["TITLE"](LINK)
* ["TITLE"](LINK)
* ["TITLE"](LINK)
* ["TITLE"](LINK)
* ["TITLE"](LINK)



----------

Scripting the Windows API (e.g. via powershell):
* ["Use PowerShell to Interact with the Windows API: Part 1" (June 25th, 2013)](https://devblogs.microsoft.com/scripting/use-powershell-to-interact-with-the-windows-api-part-1/)
* ["TITLE"](LINK)
* ["TITLE"](LINK)
* ["TITLE"](LINK)
* ["TITLE"](LINK)
* ["TITLE"](LINK)
* ["TITLE"](LINK)
* ["TITLE"](LINK)
* ["TITLE"](LINK)
* ["TITLE"](LINK)

----------


----------

Misc.

* ["TITLE"](LINK)
* ["TITLE"](LINK)
* ["TITLE"](LINK)
* ["TITLE"](LINK)
* ["TITLE"](LINK)
* ["TITLE"](LINK)
* ["TITLE"](LINK)
* ["TITLE"](LINK)
* ["TITLE"](LINK)
* ["TITLE"](LINK)
