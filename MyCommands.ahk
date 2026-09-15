#Requires AutoHotkey v2.0

; =========================================================
; Disabling CapsLock Default state
; =========================================================

SetCapsLockState "AlwaysOff"

myCaps := false

#F10::
{
    global myCaps
    myCaps := !myCaps

    if myCaps
        SetCapsLockState "On"
    else
        SetCapsLockState "Off"
}
#F11::
{
    global myCaps
    myCaps := false
    SetCapsLockState "AlwaysOff"
}

; =========================================================
; Jumping around
; =========================================================


CapsLock & a::Left
CapsLock & s::Down
CapsLock & w::Up
CapsLock & d::Right

; CapsLock & u::Home
; CapsLock & o::End

; CapsLock & n::PgDn
; CapsLock & p::PgUp


; =========================================================
; Scrolling
; =========================================================


CapsLock & q:: Send "{WheelUp}"
CapsLock & e:: Send "{WheelDown}"


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


CapsLock & 1::#^Left
CapsLock & 2::#Tab
CapsLock & 3::#^Right


; =========================================================
; Controlling
; =========================================================


#`:: Send("{Media_Play_Pause}")
#w::+F10


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
::/m::
{
    SendText "<mark></mark>"
    Send "{Left 7}"
}
#HotIf


; =========================================================
; Reloading
; =========================================================


^!r:: Reload

