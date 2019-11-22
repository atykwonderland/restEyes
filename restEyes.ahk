#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
#SingleInstance force
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

Menu, Tray, Icon, imgs\icon.jpg

Gui, main:New
Gui, main:Font, cFFFFFF s15, Verdana
Gui, main:Add, Picture, x0 y0 w300 h200, imgs\bg.png
Gui, main:Add, Picture, x90 y75 +BackgroundTrans vC1 gClick, imgs\button-off.png
Gui, main:Add, Picture, x90 y75 +BackgroundTrans vC2 gClick hidden, imgs\button-on.png
Gui, main:Show, w300 h200

Gui, time:New
Gui, time:Add, Picture, x0 y0 h%A_ScreenHeight% w%A_ScreenWidth%, imgs\bg.png

ci := 1
toggle := false
Return

Click:
	toggle := !toggle
	if(toggle) {
		SetTimer, RestTwentySec, 1200000
	} else {
		SetTimer, RestTwentySec, Off
	}
	GuiControl Hide, c%ci%
	ci := 3 - ci
	GuiControl Show, c%ci%
Return

RestTwentySec:
	allowedSeconds := 20
	endTime := A_Now
	endTime += %allowedSeconds%, Seconds
	Gui, time:Show, h%A_ScreenHeight% w%A_ScreenWidth%
	SetTimer TicToc, 1000
	; Fallthrough
Return

TicToc:
	remainingTime := endTime
	EnvSub remainingTime, %A_Now%, Seconds
	s := Mod(remainingTime, 60)
	displayedTime := Format2Digits(s)
	GuiControl, , time, %displayedTime%
	if displayedTime = 00 {
	Gui, time:Hide
	}
Return

Format2Digits(_val) {
	_val += 100
	StringRight _val, _val, 2
	Return _val
}

close:
Exitapp
