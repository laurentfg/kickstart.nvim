#Requires AutoHotkey v2.0

; Remap Capslock to Ctrl:
Capslock::Ctrl

#SuspendExempt
#n::
{
	DllCall("keybd_event", "UChar", 0x5B, "UChar", 0, "UInt", 2, "UPtr", 0)  ; LWin up
	DllCall("keybd_event", "UChar", 0x4E, "UChar", 0, "UInt", 2, "UPtr", 0)  ; N up
	
    activeExe := WinGetProcessName("A")

    if (activeExe != "explorer.exe") {
        Send("{LWin down}{4 down}")
        Sleep(50)
		Send("{4 up}{LWin up}")
		Sleep(100)
    }

    Send("+{F10}")
    Sleep(50)
    Send("x")
}