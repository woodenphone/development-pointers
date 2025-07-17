; save-file-timestamp.ahk
; --------------------
; SYNOPSIS: 
; Automate prepending timestamp to filenames in save file dialogs.
; --------------------
; DESCRIPTION:
; Prepend timestamp to filename in "Save File" dialog boxes.
; Switch to a dialog box if one isn't active
; If no "Save File" dialog is open, do nothing.
; --------------------
; USAGE:
;  (With AutoHotKey installed, and thus .ahk files associated.)
;  Run this script, should sit in system tray.
;
; When script is running:
;  [ Ctrl + Shift + ' ] - Handle "Save As" dialog by prepending timestamp and pressing "Ok".
;
; ----------
; Auto-start with user login:
; A) Start Menu "Startup" dir - special dir whose contents are run on login.
; Place script like:
; CMD> %APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\save-file-timestamp.ahk
; PS> "$Env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup\save-file-timestamp.ahk"
;  ExpandedPath: "C:\Users\User\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\save-file-timestamp.ahk"
; --------------------
; REFERENCES:
; - https://www.autohotkey.com/
; - https://www.autohotkey.com/docs/v2/Tutorial.htm
; - https://www.autohotkey.com/docs/v2/Hotkeys.htm
; ========================================
; Author: Ctrl-S
; License: BSD0
; Created: 2025-07-17
; Modified: 2025-07-18
; ========================================
; Script directives:
#SingleInstance Force ; Only most-recent instance stays running.
#Requires AutoHotkey v2 ; Uses AHK v2 API.
; ----------------------------------------

; ----------------------------------------
; Prepend timestamp to filename in "Save File" dialog boxes.
; Switch to a dialog box if one isn't active
#HotIf WinExist("ahk_class #32770") ; Only if "Save As" window is active.
+^':: ; [ Ctrl + Shift + ' ]
{
	SetControlDelay(20) ; 20ms default.
	; Prepare timestamp string:
	IsoUtcTimestamp := FormatTime(A_NowUTC, "yyyy-MM-ddTHH-mm-ssZ") ; Filename-safe ISO-8601 UTC. (Uses builtin variable A_NowUTC.)
	; SendInput(IsoUtcTimestamp) ; Send key sequence.

	; ----- "Save As" Dialog Active  -----
	; Ensure a "Save As" dialog is active window.
	; FirstActiveHwnd := WinExist("A")
	FirstWinTitle := WinGetTitle("A") ; "A" is a special value meaning the currently active window.
	FirstWinRegexMatch := RegExMatch(FirstWinTitle, "Save As") ; Compare window title.
	if (! FirstWinRegexMatch) { ; If regex did not match.
		WinActivate("ahk_class #32770") ; Swap to a save file dialog.
	}

	; ----- Close "Confirm Save As" dialog if active -----
	; Detect "Confirm Save As" dialog by comparing window title:
	WinTitle := WinGetTitle("A")
	WinTitleRegexMatch := RegExMatch(WinTitle, "Confirm Save As") ; Compare window title.
	if (WinTitleRegexMatch) { ; If regex matched.
		; Close "Confirm Save As" dialog via clicking "No".
		SetControlDelay(-1) ; '-1 for no delay at all' (for reliability)
		ControlClick( "&No", "Confirm Save As",,,, "NA")
		SetControlDelay(20) ; 20ms default.
		sleep(200) ; Give "Confirm Save As" dialog time to close and switch to "Save As" dialog.
		WinActivate("ahk_class #32770") ; Swap to a save file dialog.
	}
	
	; ConfirmSaveHWND := WinExist("Confirm Save As ahk_class #32770") ;. "WindowTitle [ExtraCriteria..]"
	; if ConfirmSaveHWND {
	; 	; Close "Confirm Save As" dialog via clicking "No".
	; 	SetControlDelay(-1) ; '-1 for no delay at all' (for reliability)
	; 	ControlClick( "&No", "Confirm Save As",,,, "NA")
	; 	SetControlDelay(20) ; 20ms default.
	; }
	
	; ----- Edit filename -----
	; Select filename text box control:
	ControlFocus("Edit1", "ahk_class #32770")
	; Edit contents of text box:
	SaveAsEditOrigText := ControlGetText("Edit1", "A")
	SaveAsEditNewText := Format("{1:s}.{2:s}", IsoUtcTimestamp, SaveAsEditOrigText)
	ControlSetText(SaveAsEditNewText, "Edit1", "A")
	sleep(50)
	
	; ----- Submit dialog box -----
	SetControlDelay(-1) ; '-1 for no delay at all' (for reliability)
	ControlClick( "&Save",  "A",,,, "NA")
	SetControlDelay(20) ; 20ms default.
}
; --------------------
; Table of relevant GUI elements:
; ----------
; Firefox "Save As" dialog box -> Filename text box.
; Save As
; ahk_class #32770
; ahk_exe firefox.exe
; ClassNN:	Edit1
; ----------
; Firefox "Save As" dialog box -> "Save" button.
; Save As
; ahk_class #32770
; ClassNN:	Button2
; Text:	&Save
; ----------
; Firefox "Save As" dialog -> "Confirm Save As" dialog -> "No" button.
; Confirm Save As
; ahk_class #32770
; ahk_exe firefox.exe
; ClassNN:	Button2
; Text:	&No
; ----------
; Firefox "Save As" dialog box
; Enter name of file to save to…
; ahk_class #32770
; ahk_exe firefox.exe
; ----------
; Confirm Save As
; ahk_class #32770
; ahk_exe firefox.exe
; ----------------------------------------

