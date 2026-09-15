#Requires AutoHotkey v2.0

; ============================================
; Save selected text as a JSON note
;
; Hotkey: Win + Shift + Q
; File:   Documents\Notes\notes.json
; ============================================

#+q::
{
    notesDir := A_MyDocuments "\Notes"
    notesFile := notesDir "\notes.json"

    ; Create Notes folder if it doesn't exist
    DirCreate(notesDir)

    ; Save current clipboard
    oldClipboard := ClipboardAll()

    ; Copy selected text
    A_Clipboard := ""
    Send "^c"

    ; Wait for copied text
    if !ClipWait(1)
    {
        A_Clipboard := oldClipboard
        return
    }

    text := A_Clipboard

    ; Restore clipboard
    A_Clipboard := oldClipboard

    ; Remove unnecessary whitespace at beginning/end
    text := Trim(text)

    if (text = "")
        return

    ; Timestamp
    timestamp := FormatTime(, "yyyy-MM-ddTHH:mm:ss")

    ; Escape text for JSON
    text := JsonEscape(text)

    ; Build the new note
    newNote :=
    (
        '  {' "`n"
        '    "timestamp": "' timestamp '",' "`n"
        '    "note": "' text '"' "`n"
        '  }'
    )

    ; ============================================
    ; Create file if it doesn't exist
    ; ============================================

    if !FileExist(notesFile)
    {
        json := "[`n" newNote "`n]"
        FileAppend(json, notesFile, "UTF-8")
    }
    else
    {
        json := FileRead(notesFile, "UTF-8")
        json := Trim(json)

        ; Make sure we're dealing with a JSON array
        if (SubStr(json, 1, 1) != "[" || SubStr(json, -1) != "]")
        {
            A_Clipboard := oldClipboard
            MsgBox "The notes.json file appears to be invalid.`n`nPlease fix or delete it before continuing.", "Save Note", "Icon!"
            return
        }

        ; Remove the final ]
        json := SubStr(json, 1, -1)
        json := RTrim(json)

        ; Determine whether there are existing notes
        if (SubStr(json, -1) = "[")
        {
            ; Empty array
            json .= "`n" newNote "`n]"
        }
        else
        {
            ; Existing notes → add comma
            json .= ",`n" newNote "`n]"
        }

        ; Rewrite the file
        FileDelete(notesFile)
        FileAppend(json, notesFile, "UTF-8")
    }

    ; Confirmation
    ToolTip "✓ Note saved"
    SetTimer () => ToolTip(), -1000
}


; ============================================
; Escape text for JSON
; ============================================

JsonEscape(text)
{
    ; Backslash
    text := StrReplace(text, "\", "\\")

    ; Double quote
    text := StrReplace(text, '"', '\"')

    ; Newlines
    text := StrReplace(text, "`r`n", "\n")
    text := StrReplace(text, "`r", "\n")
    text := StrReplace(text, "`n", "\n")

    ; Tab
    text := StrReplace(text, "`t", "\t")

    return text
}

