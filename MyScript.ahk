#Requires AutoHotkey v2.0

SetTimer(CheckForChanges, 500)

lastModified := FileGetTime(A_ScriptFullPath, "M")

CheckForChanges() {
    global lastModified

    newModified := FileGetTime(A_ScriptFullPath, "M")

    if (newModified != lastModified) {
        lastModified := newModified
        Reload
    }
}
SetCapsLockState "AlwaysOff"

; ;^ = Ctrl
; ;! = Alt
; ;+ = Shift
; ;# = Windows

; ; #Hotstring EndChars -()[]{}:;'"/,.?!`n `t

; ;#n::Run "notepad.exe"
; ;^!o::Run "obsidian:"

; ; ::/hello::Hello{!} How are you?
; ; ::/hello::{Text}Hello! How are you?

; ; name := "John"

; ; ::/abc::TEST
; ; ^!t:: {
; ;     MsgBox "Hello from AutoHotkey!"
; ; }

; ; ^!t:: {
; ;     MsgBox "Hello, " name ".How are you"
; ;     Run "notepad.exe"
; ; }

; ; ^!h:: {
; ;     SayHello(name)
; ; }

; ; SayHello(variable) {
; ;     MsgBox "Hello, " variable "!"
; ; }


; #HotIf WinActive("ahk_exe notepad.exe")

; ; ^s:: {
; ;     MsgBox "You pressed Ctrl+S inside Notepad!"
; ; }

; ::/hello::Hello, notepad

; #HotIf


; ; CapsLock::Return
; ^CapsLock::Return
; +^CapsLock::Return
; ; CapsLock & s::Send "{WheelDown}"
; CapsLock & q::Send "{WheelUp}"
; CapsLock & e::Send "{WheelDown}"

; CapsLock & s::Down
; CapsLock & w::Up
; CapsLock & a::Left
; CapsLock & d::Right

; CapsLock & 1::#^Left
; CapsLock & 2::#Tab
; CapsLock & 3::#^Right

; #w::+F10

; ; CapsLock::
; ; {
; ;     KeyWait "CapsLock"

; ;     if A_PriorKey = "CapsLock"
; ;         ; Send "{Escape}"
; ;         MsgBox "Capskey was pressed twice"
; ; }

; ; #HotIf GetKeyState("Shift", "P") && GetKeyState("CapsLock", "P")
; ; w::Send "{WheelUp}"
; ; #HotIf
; ; #HotIf GetKeyState("Shift", "P") && GetKeyState("CapsLock", "P")
; ; S::Send "{WheelDown}"
; ; #HotIf
; ; CapsLock & s:: {
; ;     MsgBox "Hello"
; ; }

; ; ^!t:: {
;     ; Send "Hello!"
;     ; Send "{Enter}"
;     ; Send "This is AutoHotkey."
    
;     ; Send "^a"
;     ; Send "Hello"
;     ; Send "{Enter}"
    
;     ; Send "{Ctrl down}"
;     ; Send "c"
;     ; Send "v"
;     ; Send "{Ctrl up}"

;     ; Send "{Shift down}"
;     ; Send "hello"
;     ; Send "{Shift up}"

;     ; SendText "Hello {Enter} ^c"
; ; }

; ; ^!t:: {
; ;     Send "^a"
; ;     Sleep 500
; ;     SendText "Hello"
; ;     Sleep 500
; ;     Send "{Enter}"
; ; }


; ^!n:: {
;     Run "notepad.exe"
;     WinWaitActive "ahk_exe notepad.exe"
;     ; Sleep 500

;     ; SendText "Hello from AutoHotkey"
;     ; Sleep 500
;     ; Send "{Enter}"
;     ; Sleep 500
;     ; SendText "This was typed automatically."
; }


; ^!t:: {
;     SendText "Hello from AutoHotkey!"
;     Send "{Enter}"
;     SendText "I just automated my keyboard."
; }

; #Requires AutoHotkey v2.0

; =========================================================
; CapsLock = Escape when tapped
; CapsLock = modifier when held
; =========================================================

CapsLock::
{
    if !KeyWait("CapsLock", "T0.2")
    {
        Send "{Return}"
    }
}

; =========================================================
; Navigation
; =========================================================

CapsLock & a::Left
CapsLock & s::Down
CapsLock & w::Up
CapsLock & d::Right


; =========================================================
; Jumping around
; =========================================================

; CapsLock & u::Home
; CapsLock & o::End

; CapsLock & n::PgDn
; CapsLock & p::PgUp


; =========================================================
; Scrolling
; =========================================================

CapsLock & q::Send "{WheelUp}"
CapsLock & e::Send "{WheelDown}"


; =========================================================
; Editing
; =========================================================

; CapsLock & c::Send "^c"
; CapsLock & x::Send "^x"
; CapsLock & v::Send "^v"
; CapsLock & z::Send "^z"
; CapsLock & a::Send "^a"

; =========================================================
; Editing
; =========================================================

CapsLock & 1::#^Left
CapsLock & 2::#Tab
CapsLock & 3::#^Right

; =========================================================
; Editing
; =========================================================

#w::+F10


; CapsLock & n::
; {
;     if GetKeyState("Shift", "P")
;         ; Send "{Down}"
;         Click "WheelDown", 5
;         ; MsgBox "something"
;     else
;         Send "{WheelDown 5}"
; }

; CapsLock & y::
; {
;     if GetKeyState("Shift", "P")
;         ; Send "{Up}"
;         Click "WheelUp", 5
;         ; MsgBox "something"
;     else
;         Send "{WheelUp 5}"
; }
; F8::
; {
;     Send "{WheelDown 5}"
; }

; F9::
; {
;     Click "WheelDown", 5
; }

CapsLock & n::
{
    if GetKeyState("Shift", "P")
        Click "WheelRight", 5
    else
        Click "WheelDown", 5
}

CapsLock & y::
{
    if GetKeyState("Shift", "P")
        Click "WheelLeft", 5
    else
        Click "WheelUp", 5
}

#Requires AutoHotkey v2.0

#`::Send("{Media_Play_Pause}") 

myCaps := false

#^F10::
{
    global myCaps
    myCaps := !myCaps

    if myCaps
        SetCapsLockState "On"
    else
        SetCapsLockState "Off"
}
#+F10::
{
    global myCaps
    myCaps := false
    SetCapsLockState "AlwaysOff"
}


; myGui := Gui()
; myGui.Add("Text",, "Hello!")
; myGui.Add("Button",, "OK")
; myGui.Show()



; #Requires AutoHotkey v2.0

; #HotIf GetKeyState("Shift", "P")

; CapsLock & n::Send "{WheelRight 5}"
; CapsLock & y::Send "{WheelLeft 5}"

; #HotIf

; CapsLock & n::Send "{WheelDown 5}"
; CapsLock & y::Send "{WheelUp 5}"