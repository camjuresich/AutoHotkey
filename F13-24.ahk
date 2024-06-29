#SingleInstance
msgbox % "my ahk version: " A_AhkVersion
; Path to the VirtualDesktop executable
VirtualDesktopPath := "VirtualDesktop11.exe"
;; RESTART FILE EXPLORER
F24::
    Run, "%userprofile%\Documents\batch files\winex.bat", , Hide
return
;; OPEN FILE EXPLORER 
#f::
    Run, "explorer.exe"
return
;; MEDIA CONTROLS
#b::
    Send {Media_Prev}
return 
#j::
    Send {Media_Next}
return
#Space:: 
    Send {Media_Play_Pause}
return
;; OPEN CALCULATOR 
#c:: 
    Run, "C:\Windows\System32\calc.exe"
return
;; WINDOWS RUN COMMAND
#z::
    Send, #r
return

;; CLOSE WINDOW
#x::
    Send, !{F4}
return
;; OPEN THE WINDOWS X MENU
#d::
    Send, #x
return

;; VIRTUAL DESKTOP NAVIGATIONS
F13::
    Run, "VirtualDesktop11.exe" "-Switch:Research", , Hide
return

F14::
    Run, "VirtualDesktop11.exe" "-Switch:Code", ,Hide
return

F15::
    Run, "VirtualDesktop11.exe" "-Switch:Design", ,Hide
return

F16::
    Run, "VirtualDesktop11.exe" "-Switch:Preview", ,Hide
return

F17::
    Run, "VirtualDesktop11.exe" "-Switch:Spotify", ,Hide
return

F18::
    Run, "VirtualDesktop11.exe" "-Switch:Discord", ,Hide
return

F19:: 
    Run, "VirtualDesktop11.exe" "-Switch:GPT", ,Hide
return

F20::
    Run, "VirtualDesktop11.exe" "-Switch:Notes", ,Hide
return

F21::
    Run, "VirtualDesktop11.exe" "-Switch:System", ,Hide
return

;; WINDOW NAVIGATIONS
#a::
    Send, #{Left}
return

#s::
    Send, #{Right}
return

#w::
    Send, #{Up}
return

#r:: 
    Send, #{Down}
return