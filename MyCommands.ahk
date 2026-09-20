#Requires AutoHotkey v2.0

; =========================================================
; Disabling CapsLock Default state
; =========================================================

; SetCapsLockState "AlwaysOff"

; myCaps := false

; #F10::
; {
;     global myCaps
;     myCaps := !myCaps

;     if myCaps
;         SetCapsLockState "On"
;     else
;         SetCapsLockState "Off"
; }
; #F11::
; {
;     global myCaps
;     myCaps := false
;     SetCapsLockState "AlwaysOff"
; }

; Send("{Tab}")
; Send("{Enter}")
; Send("{Escape}")
; Send("{Right}")
; Send("{Left}")
; Send("{Up}")
; Send("{Down}")

; =========================================================
; Jumping around
; =========================================================


; CapsLock & a:: Send("{Left}")
; CapsLock & s:: Send("{Down}")
; CapsLock & w:: Send("{Up}")
; CapsLock & d:: Send("{Right}")

; CapsLock & u::Home
; CapsLock & o::End

; CapsLock & n::PgDn
; CapsLock & p::PgUp


; =========================================================
; Scrolling
; =========================================================


CapsLock & w:: Send "{WheelUp}"
CapsLock & s:: Send "{WheelDown}"


; =========================================================
; Editing
; =========================================================


; CapsLock & c::Send "^c"
; CapsLock & x::Send "^x"
; CapsLock & v::Send "^v"
; CapsLock & z::Send "^z"
; CapsLock & a::Send "^a"


; =========================================================
; Navigating
; =========================================================


; CapsLock & 1::Send("#^{Left}")
; CapsLock & 2::Send("#{Tab}")
; CapsLock & 3::Send("#^{Right}")


; =========================================================
; Controlling
; =========================================================


;#`:: Send("{Media_Play_Pause}")
;#w:: Send("{AppsKey}")
;^CapsLock::Send("{F11}")
!w:: Send("{AppsKey}")
^Escape::Send("{F11}")


; =========================================================
; Text
; =========================================================


; only in Obsidian
#HotIf WinActive("ahk_exe obsidian.exe")
::/time::
{
    dateTime := FormatTime(, "dddd, MMMM d, yyyy - hh:mm:ss tt")
    SendText(dateTime)
}
::/u::
{
    SendText "<u></u>"
    Send "{Left 4}"
}
::/c::
{
    SendText "<center></center>"
    Send "{Left 9}"
}
::/mk::
{
    SendText "<mark></mark>"
    Send "{Left 7}"
}
::/rmk::
{
    SendText "<mark class='red'></mark>"
    Send "{Left 7}"
}
::/ymk::
{
    SendText "<mark class='yellow'></mark>"
    Send "{Left 7}"
}
::/gmk::
{
    SendText "<mark class='green'></mark>"
    Send "{Left 7}"
}
::/bmk::
{
    SendText "<mark class='blue'></mark>"
    Send "{Left 7}"
}
::/wmk::
{
    SendText "<mark class='white'></mark>"
    Send "{Left 7}"
}
#HotIf
::/lorem:: 
{
    SendText "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
}


; =========================================================
; Mouse Controlling
; =========================================================


ModifyXButtons := false

^F1::
{
    global ModifyXButtons
    ModifyXButtons := !ModifyXButtons
}

#HotIf ModifyXButtons
XButton1::
{
    Send "{Esc}"
}
XButton2::
{
    Send("!q")
}
#HotIf


; =========================================================
; Reloading
; =========================================================


!F1:: Reload

