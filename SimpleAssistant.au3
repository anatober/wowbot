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
#include <FileConstants.au3>
#include "Json.au3"

HotKeySet("{F2}", GetMouse)
HotKeySet("{F3}", Pause)
HotKeySet("{F4}", RestartScript)
HotKeySet("{F5}", Quit)

Global $screenResX = 1920, $screenResY = 1080, $paused = False, $binds
Read()

Func Read()
    Local $hFileOpen = FileOpen("binds.json", $FO_READ)
    Local $sFileRead = FileRead($hFileOpen)
    FileClose($hFileOpen)
	$binds = Json_Decode($sFileRead)
EndFunc

$handle = WinActivate("World of Warcraft")
Sleep(2000)

Main()

Func Main()
	Local $keys = Json_ObjGetKeys($binds)
	While True
		If WinActive("World of Warcraft") Then
			For $key In $keys
				Local $keySkills = Json_ObjGet($binds, $key)
				For $keySkill In $keySkills
					If PixelGetColor($keySkill[1], $keySkill[2]) = $keySkill[3] Then
						Send($key)
						Sleep(100)
						ExitLoop(2)
					EndIf
				Next
			Next
		EndIf
	WEnd
EndFunc

Func ClickM5()
    DllCall("user32.dll", "none", "mouse_event", "dword", 128, "dword", 0, "dword", 0, "dword", 2, "ptr", 0)
    DllCall("user32.dll", "none", "mouse_event", "dword", 256, "dword", 0, "dword", 0, "dword", 2, "ptr", 0)
EndFunc   ;==>ClickM5w


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
