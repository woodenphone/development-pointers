# WinSCP
File transfer utility.

* https://winscp.net


## Scripting and automation
Making the program do things without needing a user present.

* https://winscp.net/eng/docs/scripting
* https://winscp.net/eng/docs/scripts
* https://winscp.net/eng/docs/custom_distribution
* https://winscp.net/eng/docs/commandline#scripting
* https://winscp.net/eng/docs/guide_automation_advanced
* https://winscp.net/eng/docs/library_examples
* https://winscp.net/eng/docs/administration


## Settings export / import
Exporting, importing, and modifying of configuration for backup etc.

* https://superuser.com/questions/1435022/how-can-i-export-or-import-my-winscp-sessions#1435027
* https://winscp.net/eng/docs/session_configuration#site
* https://winscp.net/eng/docs/faq_transfer_config
* https://winscp.net/eng/docs/guide_config_cloud

Settings locations
----------
Registry: `[HKEY_CURRENT_USER\Software\Martin Prikryl\WinSCP 2]`

Appdata: 
```powershell
"${env:APPDATA}\WinSCP.ini"
```
i.e. `C:\Users\username\AppData\Roaming\WinSCP.ini

Executable dir as `WinSCP.ini`


## heading
