#include <WindowsConstants.au3>
#include-once

_Webcam_Snap(@ScriptDir&"\"&@YEAR&@MON&@MDAY&@HOUR&@MIN&@SEC&".bmp")
Func _Webcam_Snap($nom_cap)
  Local $ret = False
  $avi = DllOpen("avicap32.dll")
  If $avi <> -1 Then
;~  $Main = WinGetHandle(WinGetTitle(""))
    $cap = DllCall($avi, "int", "capCreateCaptureWindow", "str", "", "int", 1610612736, "int", 0, "int", 0, "int", 0, "int", 0, "hwnd", WinGetHandle(WinGetTitle("")), "int", 1)
    If @error = 0 Then
        $user = DllOpen("user32.dll")
        If $user <> -1 Then
            DllCall($user, "int", "SendMessage", "hWnd", $cap[0], "int", 0x400+10, "int", 0, "int", 0)
            If @error = 0 Then
                DllCall($user, "int", "SendMessage", "hWnd", $cap[0], "int", 0x400+25, "int", 0, "str", $nom_cap)
                If @error=0 And FileExists($nom_cap) And FileGetSize($nom_cap)>0 Then
                    $ret = True
                    ShellExecute($nom_cap)
                EndIf
            EndIf
            DllCall($user, "int", "SendMessage", "hWnd", $cap[0], "int", 0x400+181, "int", 0, "int", 0)
            DllCall($user, "int", "SendMessage", "hWnd", $cap[0], "int", 0x400+11, "int", 0, "int", 0)
        EndIf
    EndIf
DllClose($user)
DllClose($avi)
  EndIf
  Return $ret
EndFunc