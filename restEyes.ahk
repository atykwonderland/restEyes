#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#SingleInstance force

Menu, Tray, Icon, E:\test\icon.jpg
Gui, New
Gui, Font, cFFFFFF s15, Verdana
Gui, Add, Picture, x0 y0 w300 h200, E:\test\bg.png
Gui, Add, Picture, x90 y75 +BackgroundTrans vC1 gClick, E:\test\button-off.png
Gui, Add, Picture, x90 y75 +BackgroundTrans vC2 gClick hidden, E:\test\button-on.png
Gui, Show, w300 h200
ci := 1
Return

Click:
	GuiControl Hide, c%ci%
	ci := 3 - ci
	GuiControl Show, c%ci%
Return

close:
Exitapp