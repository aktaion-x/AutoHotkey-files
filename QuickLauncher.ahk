#Requires AutoHotkey v2.0

; ============================================================
; Configuration
; ============================================================

commands := [
    { type:"seperator", key: false, title: "Helium" }, 
    { type:"hotkey", key: "q", name: "Helium", exe: "chrome.exe" }, 
    { type:"hotkey", key: "z", name: "Readest", exe: "https://web.readest.com/" }, 
    { type:"hotkey", key: "x", name: "ChatGPT", exe: "https://chatgpt.com/" }, 
{ type:"hotkey", key: "-", name: "Definer Settings", exe: "chrome.exe chrome-extension://noagjioaihamoljcbelhdlldnmlgnkon/options/options.html#/history/list?size=50" }, 
    { type:"hotkey", key: "g", name: "Google", exe: "https://google.com/" }, 
    { type:"hotkey", key: ";", name: "DuckDuckGo", exe: '"https://duckduckgo.com/"' }, 
    { type:"hotkey", key: "'", name: "DuckDuckGo Incognito", exe: 'chrome.exe --incognito "https://duckduckgo.com/"' }, 
    { type:"seperator", key: true, title: "Chrome" }, 
    { type:"hotkey", key: "c", name: "Chrome Profiles", exe: "C:\Program Files\Google\Chrome\Application\chrome.exe" }, 
    { type:"hotkey", key: "k", name: "Chrome Karake", exe: '"C:\Program Files\Google\Chrome\Application\chrome.exe" --profile-directory="Profile 4"' }, 
    { type:"seperator", key: true, title: "Obsidian" }, 
    { type:"hotkey", key: "o", name: "Obsidian Main", exe: "obsidian://open?vault=Main" }, 
    { type:"hotkey", key: "i", name: "Obsidian English", exe: "obsidian://open?vault=English" }, 
    { type:"seperator", key: true, title: "Development" }, 
    { type:"hotkey", key: "t", name: "Command Prompt", exe: 'wt.exe -p "Command Prompt"' }, 
    { type:"hotkey", key: "p", name: "PowerShell", exe: 'wt.exe -p "PowerShell"' }, 
    { type:"hotkey", key: "u", name: "Ubuntu", exe: 'wt.exe -p "Ubuntu"' }, 
    { type:"hotkey", key: "v", name: "VSCode", exe: "C:\Users\TLS\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Helium Apps\Visual Studio Code" }, 
    { type:"seperator", key: true, title: "Windows" }, 
    { type:"hotkey", key: "n", name: "Notepad", exe: "notepad.exe" }, 
    { type:"hotkey", key: "e", name: "Explorer", exe: "explorer C:\Users\TLS" }, 
    { type:"hotkey", key: "d", name: "Downloads", exe: 'explorer "C:\Users\TLS\Downloads"' },
    { type:"hotkey", key: "f", name: "Documents", exe: 'explorer "C:\Users\TLS\Documents"' },
    { type:"hotkey", key: "/", name: "Edit files", exe: 'explorer "C:\Users\TLS\Documents\AutoHotkey Repo"' }
]


; ============================================================
; Double CapsLock
; ============================================================

#CapsLock::
{
    Send("")
    Launcher()
}
!CapsLock::
{
    Launcher()
}

; ============================================================
; Launcher
; ============================================================

Launcher()
{
    global commands

    launcher := Gui(
        "+AlwaysOnTop -Caption +Border",
        "Quick Launcher"
    )

    ; -------------------------
    ; Appearance
    ; -------------------------

    launcher.BackColor := "202124"
    ; launcher.SetWindowColor(0xFF5733)
    WinSetTransColor("EEAA99", launcher)
    launcher.SetFont("s11", "Segoe UI")

    ; Slight transparency.
    WinSetTransparent(242, launcher)

    ; -------------------------
    ; Header
    ; -------------------------

    launcher.SetFont("s16 Bold", "Segoe UI")

    launcher.AddText(
        "x25 y18 w350 Center cFFFFFF",
        "Quick Launcher"
    )

    launcher.SetFont("s10", "Segoe UI")

    launcher.AddText(
        "x25 y48 w350 Center cAAAAAA",
        "Press a key to launch"
    )

    ; -------------------------
    ; Commands
    ; -------------------------

    y := 85

    for command in commands
    {
        if command.type = "seperator" {
            if command.key {
                launcher.AddText("x20 y" y " w360 h1 Background333333")                
            }
            launcher.SetFont("s12 Bold", "Segoe UI")
            launcher.AddText("x35 y" y+ 10 " w280 cDDDDDD", command.title)
            y += 38
        } else {
            ; Key
            launcher.SetFont("s11 Bold", "Segoe UI")

            launcher.AddText("x35 y" y " w35 Center cFFFFFF Background333333",StrUpper(command.key))

            ; Application name
            launcher.SetFont("s11 norm", "Segoe UI")

            launcher.AddText("x85 y" y " w280 cDDDDDD",command.name)
            y += 38
        }

    }

    ; -------------------------
    ; Error message
    ; -------------------------

    errorText := launcher.AddText(
        "x25 y" y " w350 Center cFF7070 Hidden",
        ""
    )

    y += 30

    ; -------------------------
    ; Show window
    ; -------------------------

    launcher.Show("w400 h" y)

    ; Slight transparency.
    WinSetTransparent(242, launcher)

    ; --------------------------------------------------------
    ; The important part:
    ; physically click the GUI so Windows gives it focus.
    ; --------------------------------------------------------

    ; WinGetPos(&x, &yPos, &w, &h, launcher.Hwnd)

    ; MouseGetPos(&oldX, &oldY)

    ; Click(x + w // 2, yPos + h // 2)

    ; MouseMove(oldX, oldY, 0)

    ; --------------------------------------------------------
    ; Listen for one key.
    ; --------------------------------------------------------

    loop
    {
        hook := InputHook("L1")
        hook.Start()
        hook.Wait()

        key := hook.Input

        ; Escape closes the launcher.
        if (key = Chr(27))
        {
            launcher.Destroy()
            return
        }

        ; Look for command.
        found := false

        for command in commands
        {
            if (key = command.key)
            {
                found := true

                launcher.Destroy()

                Run command.exe

                return
            }
        }

        ; Unknown key.
        if !found
        {
            errorText.Text := 'The key "' key '" is not defined.'
            errorText.Visible := true
        }
    }
}

; =========================================================
; Reloading
; =========================================================


!F1:: Reload