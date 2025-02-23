#Requires AutoHotkey v2.0
#SingleInstance Force

F24:: Run "C:\Users\camju\Documents\batch files\winex.bat", , "Hide"

#b:: Send "{Media_Prev}"
#j:: Send "{Media_Next}"
#Space:: Send "{Media_Play_Pause}"
#c:: Run "C:\Windows\System32\calc.exe"
#z:: Send "!{F4}"

; MyMyGui := Gui(Options, Title, EventObj)
; MyMyGui := Gui.Call(Options, Title, EventObj)

SwitchWorkspace(deskNum) {
    name := ReadWorkspaceName(deskNum)
    Run("VirtualDesktop11.exe -Switch:" name, , "Hide")
}

MoveActiveWindowToWorkspace(deskNum) {
    name := ReadWorkspaceName(deskNum)
    Run("VirtualDesktop11.exe -gd:" name " -maw -switch", , "Hide" )
}
; Keybindings for switching workspaces

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; OPEN A TEXT BOX USING A HOTKEY AND RENAME CURRENT WORKSPACE ; Version 2
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; RenameCurrentWorkspace() {
;     ; Get the current desktop's numerical position
;     CurrentDesktop := GetCurrentDesktopIndex()
;     if (CurrentDesktop = "") {
;         ToolTip("Error: Could not determine current desktop.")
;         SetTimer(RemoveToolTip, -1500)
;         return
;     }
;     ; Read the current name from desktops.ini
;     CurrentName := ReadWorkspaceName(CurrentDesktop)
;     ; Create GUI for renaming
;     MyGui := Gui()
;     MyGui.Opt("+AlwaysOnTop -Caption +ToolWindow")  ; No title bar
;     MyGui.SetFont("s12", "Segoe UI")
;     InputBox := MyGui.Add("Edit", "w300 h30 vUserInput", CurrentName)  ; Pre-fill with existing name
;     Hwnd := InputBox.Hwnd
;     OnMessage(0x0100, KeyPressHandler.Bind(MyGui, Hwnd, CurrentDesktop))  ; Listen for Enter/Escape
;     MyGui.Show("AutoSize Center")
; }

; KeyPressHandler(MyGui, Hwnd, CurrentDesktop, wParam, lParam, msg, ControlHwnd) {
;     If (ControlHwnd = Hwnd) {
;         if (wParam = 0x0D) {  ; Enter key (0x0D)
;             NewName := MyGui["UserInput"].Text
;             RenameWorkspace(CurrentDesktop, NewName)
;             MyGui.Destroy()
;         } else if (wParam = 0x1B) {  ; Escape key (0x1B)
;             MyGui.Destroy()
;         }
;     }
; }

; RenameWorkspace(DeskNum, NewName) {
;     IniWrite(NewName, "desktops.ini", "Workspaces", DeskNum)  ; Correctly update name in INI
;     Run("VirtualDesktop11.exe -Switch:" DeskNum, , "Hide")  ; Ensure correct desktop is selected
;     Sleep(50)
;     Run("VirtualDesktop11.exe -Name:" NewName, , "Hide")  ; Rename the workspace in Windows
;     ToolTip("Renamed workspace " DeskNum " to " NewName)
;     SetTimer(RemoveToolTip, -1500)
; }

; GetCurrentDesktopIndex() {
;     OutputVar := ""
;     RunWait("VirtualDesktop11.exe -GetCurrentDesktop", , "Hide", &OutputVar)
;     DesktopNumber := Trim(OutputVar)  ; Get the current desktop number
;     ; Read INI file and match the name to find the correct index
;     Loop 9 {  ; Assuming a max of 9 workspaces
;         If (ReadWorkspaceName(A_Index) = DesktopNumber) {
;             return A_Index  ; Return the correct index
;         }
;     }
;     return ""  ; Return empty if no match
; }
; ReadWorkspaceName(DeskNum) {
;     return IniRead("desktops.ini", "Workspaces", DeskNum, "")
; }
; RemoveToolTip(*) {
;     ToolTip()
; }

; ; Hotkey to trigger renaming (change as needed)
; F22::RenameCurrentWorkspace()  ; Press F23 to rename the current workspace


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; OPEN A TEXT BOX USING A HOTKEY AND RENAME CURRENT WORKSPACE ; only changes first workspace name, Never writes the key properly
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

RenameCurrentWorkspace() {
    ; Get the current desktop number using VirtualDesktop11.exe
    CurrentDesktop := GetCurrentDesktop()
    if (CurrentDesktop = "") {
        ToolTip("Error: Could not determine current desktop.")
        SetTimer(RemoveToolTip, -1500)
        return
    }
    ; Get the current workspace name from desktops.ini
    CurrentName := ReadWorkspaceName(CurrentDesktop)
    ; Create a GUI for renaming
    MyGui := Gui()
    MyGui.Opt("+AlwaysOnTop -Caption +ToolWindow")  ; No title bar
    MyGui.SetFont("s12", "Segoe UI")
    InputBox := MyGui.Add("Edit", "w300 h30 vUserInput", CurrentName)  ; Pre-fill current name
    Hwnd := InputBox.Hwnd
    OnMessage(0x0100, KeyPressHandler.Bind(MyGui, Hwnd, CurrentDesktop))  ; Listen for Enter/Escape
    MyGui.Show("AutoSize Center")
}

KeyPressHandler(MyGui, Hwnd, CurrentDesktop, wParam, lParam, msg, ControlHwnd) {
    If (ControlHwnd = Hwnd) {
        if (wParam = 0x0D) {  ; Enter key (0x0D)
            NewName := MyGui["UserInput"].Text
            RenameWorkspace(CurrentDesktop, NewName)
            MyGui.Destroy()
        } else if (wParam = 0x1B) {  ; Escape key (0x1B)
            MyGui.Destroy()
        }
    }
}

RenameWorkspace(DeskNum, NewName) {
    IniWrite(NewName, "desktops.ini", "Workspaces", DeskNum)  ; Update desktops.ini
    Run("VirtualDesktop11.exe -GetDesktop:" DeskNum, , "Hide")  ; Select desktop
    Sleep(50)  ; Small delay
    Run("VirtualDesktop11.exe -Name:" NewName, , "Hide")  ; Rename in system
    ToolTip("Renamed workspace " DeskNum " to " NewName)
    SetTimer(RemoveToolTip, -1500)
}

GetCurrentDesktop() {
    ; Runs VirtualDesktop11.exe to get the current desktop number
    OutputVar := ""
    RunWait("VirtualDesktop11.exe -GetCurrentDesktop", , "Hide", &OutputVar)
    return Trim(OutputVar)  ; Return trimmed result
}

ReadWorkspaceName(DeskNum) {
    return IniRead("desktops.ini", "Workspaces", DeskNum, "Default")
}

RemoveToolTip(*) {
    ToolTip()
}

; Hotkey to trigger renaming (change as needed)
F22::RenameCurrentWorkspace()  ; Press F23 to rename the current workspace

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; OPEN A TEXT BOX USING A HOT KEY AND CLOSE ON ENTER
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; ReadWorkspaceName(deskNum) {
;     name := IniRead("desktops.ini", "Workspaces", deskNum, "Default")
;     return name
; }
; SwitchWorkspace(deskNum) {
;     name := ReadWorkspaceName(deskNum)
;     Run("VirtualDesktop11.exe -Switch:" name, , "Hide")
; }
; MoveActiveWindowToWorkspace(deskNum) {
;     name := ReadWorkspaceName(deskNum)
;     Run("VirtualDesktop11.exe -gd:" name " -maw -switch", , "Hide" )
; }
; ShowInputBox() {
;     MyGui := Gui()
;     MyGui.Opt("+AlwaysOnTop -Caption +ToolWindow")  ; No title bar, always on top
;     MyGui.SetFont("s12", "Segoe UI")
;     InputBox := MyGui.Add("Edit", "w300 h30 vUserInput")  ; Create an input field
;     ; Get the window handle of the InputBox and listen for key events
;     Hwnd := InputBox.Hwnd
;     OnMessage(0x0100, KeyPressHandler.Bind(MyGui, Hwnd))  ; Listen for WM_KEYDOWN
;     MyGui.Show("AutoSize Center")
; }
; KeyPressHandler(MyGui, Hwnd, wParam, lParam, msg, ControlHwnd) {
;     If (ControlHwnd = Hwnd && wParam = 0x0D) {  ; 0x0D = Enter key
;         MyGui.Destroy()
;     }
; }

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; END

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
; OPEN A TEXT BOX USING A HOT KEY AND CLOSE WITH ESCAPE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
; ShowInputBox() {
;     MyGui := Gui()  ; Create a new GUI window
;     MyGui.Opt("+AlwaysOnTop -Caption +ToolWindow")  ; Remove title bar, no taskbar button
;     MyGui.SetFont("s12", "Segoe UI")  ; Set font size
;     InputBox := MyGui.Add("Edit", "w300 h30 vUserInput")  ; Add an input field with a variable name
;     ; Register an event handler for the Enter key
;     MyGui.OnEvent("Escape", HandleEnter.Bind(MyGui))
;     MyGui.Show("AutoSize Center")  ; Show in center
; }

; HandleEnter(MyGui, *) {  ; Function to close GUI when Enter is pressed
;     MyGui.Destroy()
; }
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; END

F13::SwitchWorkspace(1)
F14::SwitchWorkspace(2)
F15::SwitchWorkspace(3)
F16::SwitchWorkspace(4)
F17::SwitchWorkspace(5)
F18::SwitchWorkspace(6)
F19::SwitchWorkspace(7)
F20::SwitchWorkspace(8)
F21::SwitchWorkspace(9)

; Keybindings to move active window
+F13::MoveActiveWindowToWorkspace(1)
+F14::MoveActiveWindowToWorkspace(2)
+F15::MoveActiveWindowToWorkspace(3)
+F16::MoveActiveWindowToWorkspace(4)
+F17::MoveActiveWindowToWorkspace(5)
+F18::MoveActiveWindowToWorkspace(6)
+F19::MoveActiveWindowToWorkspace(7)
+F20::MoveActiveWindowToWorkspace(8)
+F21::MoveActiveWindowToWorkspace(9)
; F22::ShowInputBox()  ; Call function to display the text box
F23::Reload