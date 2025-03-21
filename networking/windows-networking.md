# Networking on Windows


----------


Check link speed of ethernet interface:
Get interface link speed via WMIC:
```powershell
wmic NIC where NetEnabled=true get Name,Speed
```

Get interface link speed via Get-NetAdapter cmdlet:
```powershell
Get-NetAdapter | where Status -eq "Up" | select InterfaceDescription, LinkSpeed
```

```powershell
```

* https://www.elevenforum.com/t/check-network-adapter-connection-speed-in-windows-11.4520/
* https://www.tenforums.com/tutorials/75371-see-network-adapter-speed-windows-10-a.html
* https://superuser.com/questions/412952/how-to-detect-the-speed-fast-or-gigabit-ethernet-of-a-network-connection-over
----------



## Links
* TL;DR: No. ["Are the QoS API's in Winsock useful?"](https://stackoverflow.com/questions/18948674/are-the-qos-apis-in-winsock-useful)
* ["Quality of Service (QOS)" "Overview of the Quality of Service (QOS) technology." (Learn/Windows/Apps/Win32/API) (learn.microsoft.com)](https://learn.microsoft.com/en-us/windows/win32/api/_qos)
* ["Generic Quality of Service (QOS) 10 Part 1"](https://www.winsocketdotnetworkprogramming.com/winsock2programming/winsock2advancedqos10.html)
* ["Quality of Service" (Learn/Previous Versions/Windows) (learn.microsoft.com)](https://learn.microsoft.com/en-us/previous-versions/windows/desktop/qos/qos-start-page)
["Tutorials on 'Advanced' Winsock 2 Network Programming using C"](https://www.winsocketdotnetworkprogramming.com/winsock2programming/


* ["TITLE" (docpath) (learn.microsoft.com)](LINK)
* ["TITLE" (docpath) (learn.microsoft.com)](LINK)
* ["TITLE" (docpath) (learn.microsoft.com)](LINK)
* ["TITLE" (docpath) (learn.microsoft.com)](LINK)
