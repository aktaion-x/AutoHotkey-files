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
; #Requires AutoHotkey v2.0

; CapsLock::
; {
;     static lastPress := 0

;     now := A_TickCount

;     if (now - lastPress <= 300)
;     {
;         lastPress := 0
;         Launcher()
;     }
;     else
;     {
;         lastPress := now
;     }
; }

; Launcher()
; {
;     launcher := Gui("+AlwaysOnTop -Caption", "Launcher")
;     launcher.BackColor := "202020"

;     launcher.SetFont("s14", "Segoe UI")
;     launcher.AddText("cFFFFFF Center", "Press a key...")

;     launcher.OnEvent("Close", (*) => launcher.Destroy())

;     launcher.Show("w300 h80")

;     ; Give the GUI focus.
;     WinActivate(launcher.Hwnd)

;     ; Listen for keys while this GUI is active.
;     HotIfWinActive("ahk_id " launcher.Hwnd)

;     Hotkey("q", (*) => LaunchCommand(launcher, "chrome.exe"))
;     Hotkey("o", (*) => LaunchCommand(launcher, "obsidian.exe"))
;     Hotkey("n", (*) => LaunchCommand(launcher, "notepad.exe"))

;     HotIf
; }

; LaunchCommand(launcher, program)
; {
;     ; Destroy the temporary window first.
;     launcher.Destroy()

;     ; Then launch the application.
;     Run program
; }

#Requires AutoHotkey v2.0
SetCapsLockState("Off")
; CapsLock::
; {
;     static lastPress := 0

;     now := A_TickCount

;     if (now - lastPress <= 300)
;     {
;         lastPress := 0
;         Launcher()
;     }
;     else
;     {
;         lastPress := now
;     }
; }

; Launcher()
; {
;     launcher := Gui("+AlwaysOnTop -Caption", "Launcher")
;     launcher.BackColor := "202020"

;     launcher.SetFont("s14", "Segoe UI")
;     launcher.AddText("cFFFFFF Center", "Press a key...")

;     launcher.Show("w300 h80")

;     ; Make the launcher the foreground window.
;     WinActivate(launcher.Hwnd)

;     ; Wait for exactly one key.
;     hook := InputHook("L1")
;     hook.Start()
;     hook.Wait()

;     key := hook.Input

;     ; IMPORTANT:
;     ; Destroy the launcher before starting the target.
;     launcher.Destroy()

;     switch key
;     {
;         case "q":
;             Run "chrome.exe"

;         case "c":
;             Run "C:\Program Files\Google\Chrome\Application\chrome.exe"

;         case "o":
;             Run "obsidian.exe"

;         case "n":
;             Run "notepad.exe"

;         case "t":
;             Run "C:\Program Files\WindowsApps\Microsoft.WindowsTerminal_1.24.11911.0_x64__8wekyb3d8bbwe\wt.exe"
;     }
; }

; Launcher()
; {
;     launcher := Gui("+AlwaysOnTop -Caption", "Launcher")
;     launcher.BackColor := "202020"

;     launcher.SetFont("s14", "Segoe UI")
;     launcher.AddText("cFFFFFF Center", "Press a key...")

;     launcher.Show("w300 h80")

;     ; Get the GUI's position and size.
;     ; WinGetPos(&x, &y, &w, &h, launcher.Hwnd)

;     ; ; Click the center of the GUI.
;     ; MouseGetPos(&oldX, &oldY)

;     ; Click(x + w // 2, y + h // 2)

;     ; ; Put the mouse back where it was.
;     ; MouseMove(oldX, oldY, 0)

;     ; Now listen for one key.
;     hook := InputHook("L1")
;     hook.Start()
;     hook.Wait()

;     key := hook.Input

;     launcher.Destroy()

;     switch key
;     {
;         case "e":
;             Run "explorer C:\Users\TLS"

;         case "q":
;             Run "https://www.google.com"

;         case "r":
;             Run "https://web.readest.com/"

;         case "c":
;             Run '"C:\Program Files\Google\Chrome\Application\chrome.exe" "www.google.com"'

;         case "o":
;             Run "obsidian://open?vault=English"
;         case "p":
;             Run "obsidian://open?vault=Main"

;         case "n":
;             Run "notepad.exe"

;         case "t":
;             Run "C:\Program Files\WindowsApps\Microsoft.WindowsTerminal_1.24.11911.0_x64__8wekyb3d8bbwe\wt.exe"
;     }
; }


;+++++++++++++++++++++++++++++++++++++
; #Requires AutoHotkey v2.0

; ; ============================================================
; ; Configuration
; ; ============================================================

; commands := Map(
;     "q", ["Helium", "chrome.exe"],
;     "z", ["Readest", "https://web.readest.com/"],
;     "x", ["ChatGPT", "https://chatgpt.com/"],
;     "g", ["Google", "https://google.com/"],
;     "c", ["Chrome", "C:\Program Files\Google\Chrome\Application\chrome.exe"],
;     "k", ["Chrome", '"C:\Program Files\Google\Chrome\Application\chrome.exe" --profile-directory="Profile 4"'],
;     "o", ["Obsidian English", "obsidian://open?vault=English"],
;     "o", ["Obsidian Main", "obsidian://open?vault=Main"],
;     "t", ["Terminal", "wt.exe"],
;     "n", ["Notepad", "notepad.exe"],
;     "e", ["Explorer", "explorer C:\Users\TLS"]
; )


; ; ============================================================
; ; Double CapsLock
; ; ============================================================

; CapsLock::
; {
;     static lastPress := 0

;     now := A_TickCount

;     if (now - lastPress <= 300)
;     {
;         lastPress := 0
;         Launcher()
;     }
;     else
;     {
;         lastPress := now
;     }
; }


; ; ============================================================
; ; Launcher
; ; ============================================================

; Launcher()
; {
;     global commands

;     launcher := Gui("+AlwaysOnTop -Caption +Border", "Launcher")

;     launcher.BackColor := "202020"
;     launcher.SetFont("s12", "Segoe UI")

;     launcher.AddText(
;         "x20 y15 w360 Center cFFFFFF",
;         "Command Launcher"
;     )

;     y := 50

;     for key, command in commands
;     {
;         launcher.AddText(
;             "x30 y" y " w40 cFFFFFF",
;             key
;         )

;         launcher.AddText(
;             "x80 y" y " w270 cFFFFFF",
;             command[1]
;         )

;         y += 30
;     }

;     height := y + 10

;     launcher.Show("w400 h" height)

;     ; --------------------------------------------------------
;     ; Force focus using a real mouse click
;     ; --------------------------------------------------------

;     WinGetPos(&x, &y, &w, &h, launcher.Hwnd)

;     MouseGetPos(&oldX, &oldY)

;     Click(x + w // 2, y + h // 2)

;     MouseMove(oldX, oldY, 0)

;     ; --------------------------------------------------------
;     ; Wait for one key
;     ; --------------------------------------------------------

;     hook := InputHook("L1")
;     hook.Start()
;     hook.Wait()

;     key := StrLower(hook.Input)

;     ; --------------------------------------------------------
;     ; Close launcher BEFORE executing command
;     ; --------------------------------------------------------

;     launcher.Destroy()

;     ; --------------------------------------------------------
;     ; Execute command
;     ; --------------------------------------------------------

;     if commands.Has(key)
;         Run commands[key][2]
; }













#Requires AutoHotkey v2.0

; ============================================================
; Configuration
; ============================================================

commands := [
    ; {key: "q", name: "Chrome",   exe: "chrome.exe"},
    ; {key: "o", name: "Obsidian", exe: "obsidian.exe"},
    ; {key: "v", name: "VS Code",  exe: "Code.exe"},
    ; {key: "e", name: "Explorer", exe: "explorer.exe"},
    ; {key: "n", name: "Notepad",  exe: "notepad.exe"}
    {key: "q", name: "Helium", exe: "chrome.exe", icon: A_ScriptDir "\icons\chrome.png"},
    {key: "z", name: "Readest", exe: "https://web.readest.com/", icon: A_ScriptDir "\icons\chrome.png"},
    {key: "x", name: "ChatGPT", exe: "https://chatgpt.com/", icon: A_ScriptDir "\icons\chrome.png"},
    {key: "g", name: "Google", exe: "https://google.com/", icon: A_ScriptDir "\icons\chrome.png"},
    {key: "c", name: "Chrome", exe: "C:\Program Files\Google\Chrome\Application\chrome.exe", icon: A_ScriptDir "\icons\chrome.png"},
    {key: "k", name: "Chrome", exe: '"C:\Program Files\Google\Chrome\Application\chrome.exe" --profile-directory="Profile 4"', icon: A_ScriptDir "\icons\chrome.png"},
    {key: "o", name: "Obsidian Main", exe: "obsidian://open?vault=Main", icon: A_ScriptDir "\icons\chrome.png"},
    {key: "p", name: "Obsidian English", exe: "obsidian://open?vault=English", icon: A_ScriptDir "\icons\chrome.png"},
    {key: "t", name: "Terminal", exe: "wt.exe", icon: A_ScriptDir "\icons\chrome.png"},
    {key: "n", name: "Notepad", exe: "notepad.exe", icon: A_ScriptDir "\icons\chrome.png"},
    {key: "e", name: "Explorer", exe: "explorer C:\Users\TLS", icon: A_ScriptDir "\icons\chrome.png"}
]



; ============================================================
; Double CapsLock
; ============================================================

CapsLock::
{
    static lastPress := 0

    now := A_TickCount

    if (now - lastPress <= 300)
    {
        lastPress := 0
        Launcher()
    }
    else
    {
        lastPress := now
    }
}


; ; ============================================================
; ; Launcher
; ; ============================================================

; Launcher()
; {
;     global commands

;     launcher := Gui(
;         "+AlwaysOnTop -Caption +Border",
;         "Quick Launcher"
;     )

;     ; -------------------------
;     ; Appearance
;     ; -------------------------

;     launcher.BackColor := "202124"
;     launcher.SetFont("s11", "Segoe UI")

;     ; Slight transparency.
;     WinSetTransparent(242, launcher)

;     ; -------------------------
;     ; Header
;     ; -------------------------

;     launcher.SetFont("s16 Bold", "Segoe UI")

;     launcher.AddText(
;         "x25 y18 w350 Center cFFFFFF",
;         "Quick Launcher"
;     )

;     launcher.SetFont("s10", "Segoe UI")

;     launcher.AddText(
;         "x25 y48 w350 Center cAAAAAA",
;         "Press a key to launch"
;     )

;     ; -------------------------
;     ; Commands
;     ; -------------------------

;     y := 85

;     for command in commands
;     {
;         ; Key
;         launcher.SetFont("s11 Bold", "Segoe UI")

;         launcher.AddText(
;             "x35 y" y " w35 Center cFFFFFF",
;             StrUpper(command.key)
;         )

;         ; Application name
;         launcher.SetFont("s11", "Segoe UI")

;         launcher.AddText(
;             "x85 y" y " w280 cDDDDDD",
;             command.name
;         )

;         y += 38
;     }

;     ; -------------------------
;     ; Error message
;     ; -------------------------

;     errorText := launcher.AddText(
;         "x25 y" y " w350 Center cFF7070 Hidden",
;         ""
;     )

;     y += 30

;     ; -------------------------
;     ; Show window
;     ; -------------------------

;     launcher.Show("w400 h" y)

;     ; Slight transparency.
;     WinSetTransparent(242, launcher)

;     ; --------------------------------------------------------
;     ; The important part:
;     ; physically click the GUI so Windows gives it focus.
;     ; --------------------------------------------------------

;     WinGetPos(&x, &yPos, &w, &h, launcher.Hwnd)

;     MouseGetPos(&oldX, &oldY)

;     Click(x + w // 2, yPos + h // 2)

;     MouseMove(oldX, oldY, 0)

;     ; --------------------------------------------------------
;     ; Listen for one key.
;     ; --------------------------------------------------------

;     loop
;     {
;         hook := InputHook("L1")
;         hook.Start()
;         hook.Wait()

;         key := StrLower(hook.Input)

;         ; Escape closes the launcher.
;         if (key = Chr(27))
;         {
;             launcher.Destroy()
;             return
;         }

;         ; Look for command.
;         found := false

;         for command in commands
;         {
;             if (key = command.key)
;             {
;                 found := true

;                 launcher.Destroy()

;                 Run command.exe

;                 return
;             }
;         }

;         ; Unknown key.
;         if !found
;         {
;             errorText.Text := 'The key "' key '" is not defined.'
;             errorText.Visible := true
;         }
;     }
; }


Launcher() {
    global commands

    ; ==========================================
    ; Layout configuration
    ; ==========================================

    minWidth := 400
    preferredWidth := 520
    maxWidth := 760

    minCardW := 150
    preferredCardW := 180
    maxCardW := 240

    cardH := 70

    gapX := 12
    gapY := 12

    marginX := 24
    marginTop := 85
    marginBottom := 24


    ; ==========================================
    ; Determine launcher width
    ; ==========================================

    launcherW := preferredWidth

    if launcherW < minWidth
        launcherW := minWidth

    if launcherW > maxWidth
        launcherW := maxWidth


    ; ==========================================
    ; Determine number of columns
    ; ==========================================

    usableW := launcherW - (marginX * 2)

    columns := Floor(
        (usableW + gapX)
        / (preferredCardW + gapX)
    )

    if columns < 1
        columns := 1

    if columns > commands.Length
        columns := commands.Length


    ; ==========================================
    ; Determine actual card width
    ; ==========================================

    cardW := Floor(
        (usableW - ((columns - 1) * gapX))
        / columns
    )

    if cardW < minCardW
        cardW := minCardW

    if cardW > maxCardW
        cardW := maxCardW


    ; ==========================================
    ; Determine rows
    ; ==========================================

    rows := Ceil(commands.Length / columns)

    gridH :=
        rows * cardH
        + (rows - 1) * gapY

    launcherH :=
        marginTop
        + gridH
        + marginBottom
        + 35


    ; ==========================================
    ; Create GUI
    ; ==========================================

    launcher := Gui(
        "+AlwaysOnTop -Caption +Border",
        "Quick Launcher"
    )

    launcher.BackColor := "000000"

    ; Title
    launcher.SetFont("s16", "Arial")

    launcher.AddText(
        "x0 y18 w" launcherW
        " Center cFFFFFF",
        "Quick Launcher"
    )

    ; Subtitle
    launcher.SetFont("s9", "Arial")

    launcher.AddText(
        "x0 y48 w" launcherW
        " Center c9AA0A6",
        "Press a key to launch"
    )


    ; ==========================================
    ; Create grid cards
    ; ==========================================

    for index, command in commands {

        col := Mod(index - 1, columns)
        row := Floor((index - 1) / columns)

        x := marginX + col * (cardW + gapX)
        y := marginTop + row * (cardH + gapY)


        ; --------------------------------------
        ; Card background
        ; --------------------------------------

        launcher.AddText(
            "x" x
            " y" y
            " w" cardW
            " h" cardH
            ; " Background2B2D31",
            ""
        )


        ; ; --------------------------------------
        ; ; Application icon
        ; ; --------------------------------------

        ; iconSize := 38

        ; iconY := y + (cardH - iconSize) // 2

        ; launcher.AddPicture(
        ;     "x" (x + 12)
        ;     " y" iconY
        ;     " w" iconSize
        ;     " h" iconSize,
        ;     command.icon
        ; )

; ==========================================
; Keyboard shortcut badge
; ==========================================

badgeW := 40
badgeH := 40

badgeX := x + 12
badgeY := y + (cardH - badgeH) // 2


badge := Gui("+Parent" launcher.Hwnd " -Caption")
badge.BackColor := "3A3D43"

badge.SetFont("s12 bold", "Segoe UI")
badge.AddText(
    "x0 y5 w42 h30 Center cFFFFFF",
    StrUpper(command.key)
)

badge.Show("x" badgeX " y" badgeY " w42 h42 NA")

WinSetRegion("0-0 W42 H42 R12-12", badge)
radius := 10

region := DllCall(
    "CreateRoundRectRgn",
    "Int", 0,
    "Int", 0,
    "Int", badgeW + 1,
    "Int", badgeH + 1,
    "Int", radius,
    "Int", radius,
    "Ptr"
)

DllCall(
    "SetWindowRgn",
    "Ptr", badge.Hwnd,
    "Ptr", region,
    "Int", true
)


; Keyboard letter
launcher.SetFont("s13 bold", "Segoe UI")

launcher.AddText(
    "x" badgeX
    " y" (badgeY + 6)
    " w" badgeW
    " h28"
    " Center cFFFFFF BackgroundTrans",
    StrUpper(command.key)
)


; ==========================================
; Application name
; ==========================================

launcher.SetFont("s10", "Segoe UI")

launcher.AddText(
    "x" (x + 64)
    " y" (y + 22)
    " w" (cardW - 76)
    " h25"
    " cFFFFFF",
    command.name
)
    }


    ; ==========================================
    ; Error message
    ; ==========================================

    errorY := marginTop + gridH + 8

    launcher.SetFont("s9", "Arial")

    errorText := launcher.AddText(
        "x0 y" errorY
        " w" launcherW
        " h20"
        " Center cFF6B6B Hidden",
        ""
    )


    ; ==========================================
    ; Show launcher
    ; ==========================================

    launcher.Show(
        "w" launcherW
        " h" launcherH
    )

    WinSetTransparent(242, launcher)


    ; ==========================================
    ; Force focus using real mouse click
    ; ==========================================

    WinGetPos(
        &winX,
        &winY,
        &winW,
        &winH,
        launcher.Hwnd
    )

    MouseGetPos(&oldX, &oldY)

    Click(
        winX + winW // 2,
        winY + 20
    )

    MouseMove(oldX, oldY, 0)


    ; ==========================================
    ; Wait for key
    ; ==========================================

    hook := InputHook("L1")

    hook.Start()
    hook.Wait()

    key := StrLower(hook.Input)


    ; ==========================================
    ; Escape
    ; ==========================================

    if key = Chr(27) {
        launcher.Destroy()
        return
    }


    ; ==========================================
    ; Find command
    ; ==========================================

    for _, command in commands {

        if key = command.key {

            launcher.Destroy()

            Run command.exe

            return
        }
    }


    ; ==========================================
    ; Unknown key
    ; ==========================================

    errorText.Text :=
        'The key "' key '" is not defined.'

    errorText.Visible := true


    ; ==========================================
    ; Wait for another key
    ; ==========================================

    hook := InputHook("L1")

    hook.Start()
    hook.Wait()

    key := StrLower(hook.Input)

    launcher.Destroy()


    ; Try the second key
    for _, command in commands {

        if key = command.key {
            Run command.exe
            return
        }
    }
}