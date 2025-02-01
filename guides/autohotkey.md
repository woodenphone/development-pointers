# Autohotkey - NOTES


## Installing Autohotkey

* [Autohotkey Downloads page](https://www.autohotkey.com/download/)



### Autostart AHK script
Make AHK script load/run automaticaly.

Contents of this folder get run on startup (when user logs in?):
```path
C:\Users\User\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup
```

AHK script filepath:
```path
C:\Users\User\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\ctrls-collection.ahk
```

Powershell to install the script:
```powershell
Copy-Item "manual-win10\autohotkey\ctrls-collection.ahk" "${Env:APPDATA}/Microsoft\Windows\Start Menu\Programs\Startup"
```


## AHK Scripting
* [Documentation: Online - v1.1](https://www.autohotkey.com/docs/v1/)
* [Documentation: Online - v2.0](https://www.autohotkey.com/docs/v2/)

