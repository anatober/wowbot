#RequireAdmin
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=tesobot.ico
#AutoIt3Wrapper_Compile_Both=y
#AutoIt3Wrapper_UseX64=y
#AutoIt3Wrapper_Res_ProductName=TESO Bot
#AutoIt3Wrapper_Res_requestedExecutionLevel=requireAdministrator
#Tidy_Parameters=/tc 4 /sf /reel
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

#include <Misc.au3>
#include <Array.au3>

HotKeySet("{F2}", GetMouse)
HotKeySet("{F3}", Pause)
HotKeySet("{F4}", RestartScript)
HotKeySet("{F5}", Quit)

Global $screenResX = 1920, $screenResY = 1080, $paused = False

$handle = WinActivate("World of Warcraft")
Sleep(2000)

While True
    If WinActive("World of Warcraft") Then
		If ShouldCastShred() Then
			Send("{NUMPAD1}")
			Sleep(500)
		ElseIf ShouldCastFerociusBite() Then
			Send("{NUMPAD2}")
			Sleep(500)
		ElseIf ShouldCastRake() Then
			Send("{NUMPAD3}")
			Sleep(500)
		ElseIf ShouldCastThrash() Then
			Send("{NUMPAD4}")
			Sleep(500)
		ElseIf ShouldCastTigersFury() Then
			Send("{NUMPAD5}")
			Sleep(500)
		EndIf
;~ 		If ShouldCastSolarWrath() Then
;~ 			Send("{NUMPAD1}")
;~ 			Sleep(1500)
;~ 		ElseIf ShouldCastMoonfire() Then
;~ 			Send("{NUMPAD2}")
;~ 			Sleep(500)
;~ 		ElseIf ShouldCastStarsurge() Then
;~ 			Send("{NUMPAD3}")
;~ 			Sleep(500)
;~ 		EndIf
    EndIf
WEnd

Func ClickM5()
    DllCall("user32.dll", "none", "mouse_event", "dword", 128, "dword", 0, "dword", 0, "dword", 2, "ptr", 0)
    DllCall("user32.dll", "none", "mouse_event", "dword", 256, "dword", 0, "dword", 0, "dword", 2, "ptr", 0)
EndFunc   ;==>ClickM5

Func GetMouse()
    $temp = MouseGetPos()
    MsgBox(0, "", $temp[0] & " " & $temp[1] & " " & PixelGetColor($temp[0], $temp[1], $handle))
;~     MsgBox(0, "", PixelGetColor(869, 750, $handle))
EndFunc   ;==>GetMouse

Func Pause()
    $paused = Not $paused
    While $paused
        Sleep(1)
    WEnd
EndFunc   ;==>Pause

Func Quit()
    Exit
EndFunc   ;==>Quit

Func RestartScript()
    If @Compiled = 1 Then
        Run(FileGetShortName(@ScriptFullPath))
    Else
        Run(FileGetShortName(@AutoItExe) & " " & FileGetShortName(@ScriptFullPath))
    EndIf
    Exit
EndFunc   ;==>RestartScript

Func ShouldCastSolarWrath()
	Return PixelGetColor(869, 750, $handle) = 11962880
EndFunc

Func ShouldCastMoonfire()
	Return PixelGetColor(869, 758, $handle) = 13153016
EndFunc

Func ShouldCastStarsurge()
	Return PixelGetColor(850, 759, $handle) = 15641087
EndFunc

Func ShouldCastShred()
	Return PixelGetColor(869, 763, $handle) = 12866601
EndFunc

Func ShouldCastFerociusBite()
	Return PixelGetColor(871, 767, $handle) = 3609111
EndFunc

Func ShouldCastRake()
	Return PixelGetColor(868, 766, $handle) = 9646119
EndFunc

Func ShouldCastThrash()
	Return PixelGetColor(866, 772, $handle) = 3419951
EndFunc

Func ShouldCastTigersFury()
	Return PixelGetColor(866, 766, $handle) = 16242564
EndFunc