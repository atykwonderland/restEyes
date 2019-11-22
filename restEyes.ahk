#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
#SingleInstance force
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; Set window icon
Menu, Tray, Icon, imgs\icon.jpg

; Main GUI for turning the program on/off
Gui, main:New
Gui, main:Font, cFFFFFF s15, Verdana
Gui, main:Add, Picture, x0 y0 w300 h200, imgs\bg.png
Gui, main:Add, Picture, x90 y75 +BackgroundTrans vC1 gClick, imgs\button-off.png
Gui, main:Add, Picture, x90 y75 +BackgroundTrans vC2 gClick hidden, imgs\button-on.png
Gui, main:Show, w300 h200

; Breaktime GUI indicates when to look away
Gui, time:New
Gui, time:Add, Picture, x0 y0 h%A_ScreenHeight% w%A_ScreenWidth%, imgs\bg.png

; Variables for controlling on/off with click on button
ci := 1
toggle := false
Return

; When button is clicked
Click:
	toggle := !toggle
	if(toggle) {
		SetTimer, RestTwentySec, 1200000
	} else {
		SetTimer, RestTwentySec, Off
	}
	; Hide/show the appropriate on/off button from click
	GuiControl Hide, c%ci%
	ci := 3 - ci
	GuiControl Show, c%ci%
Return

; Start timer and overlay the breaktime GUI on the screen for the duration
RestTwentySec:
	allowedSeconds := 20
	endTime := A_Now
	endTime += %allowedSeconds%, Seconds
	Gui, time:Show, h%A_ScreenHeight% w%A_ScreenWidth%
	SetTimer TicToc, 1000
	; Fallthrough
Return

; Timer function
TicToc:
	remainingTime := endTime
	EnvSub remainingTime, %A_Now%, Seconds
	s := Mod(remainingTime, 60)
	GuiControl, , time, %s%
	; hide the breaktime GUI when timer is done
	if s = 00 {
	Gui, time:Hide
	}
Return

; When window is closed, exit the app
close:
Exitapp
