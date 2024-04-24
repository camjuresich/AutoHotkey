F14::
    ; Restarts file explorer 
    ; Press Windows Key + R
    Send, #r
    ; Wait for the Run dialog to appear
    Sleep, 500
    ; Type the path to the batch file
    SendInput, Documents\batch files\winex.bat
    ; Wait a bit before pressing Enter
    Sleep, 50
    ; Press Enter
    Send, {Enter}
return

F15::
    ; Used to change the default browser to Chrome
    ; Open windows run dialog 
    Send, #r
    Sleep, 250
    ; Enter the default apps settins
    SendInput, ms-settings:defaultapps
    Sleep, 250
    Send, {Enter}
    
    ; Wait for 1 second (1000 milliseconds)
    Sleep, 1000
    
    ; Press Tab four times
    Send, {Tab 4}
    Sleep, 100
    
    ; Type "chrome"
    SendInput, chrome
    Sleep, 10
    ; Press Tab
    Send, {Tab}
    
    ; Press Enter
    Send, {Enter}
    Sleep, 100
    Send {Enter}
    
    ; Wait for a moment before sending Alt+F4
    Sleep, 1500
    
    ; Send Alt+F4 to close the Settings window
    Send, !{F4}
return

F16::
    ; Used to change the default browser to edge
    ; Open windows run dialog 
    Send, #r
    Sleep, 250
    ; Enter the default apps settins
    SendInput, ms-settings:defaultapps
    Sleep, 250
    Send, {Enter}
    
    ; Wait for 1 second (1000 milliseconds)
    Sleep, 1000
    
    ; Press Tab four times
    Send, {Tab 4}
    Sleep, 1000
    ; Type "edge"
    SendInput, edge
    Sleep, 10
    ; Press Tab
    Send, {Tab}
    
    ; Press Enter
    Send, {Enter}
    Sleep, 100
    Send {Enter}
    
    ; Wait for a moment before sending Alt+F4
    Sleep, 1500
    
    ; Send Alt+F4 to close the Settings window
    Send, !{F4}
return

F17::
    ; Retype whatever is on the clipboard
    Clipboard := ClipboardAll
    SendRaw, %Clipboard%
return

/* A previous attempt at escaping curly braces before I knew of the SendRaw feature
EscapeCurly(text) {
    Loop, Parse, text
    {
        if (A_LoopField == "{")
            str .= "{{}"
        else if (A_LoopField == "}")
            str .= "{}}"
        else
            str .= A_LoopField
    }
    return str
}
*/
