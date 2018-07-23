#include <FontConstants.au3>
#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>

Opt("GUIOnEventMode", 1)

Local Const $sFont = "Arial"
Local $flag = 0
Local $sPred = ""
Local $hGUI = GUICreate("EXAMOD checker", 220, 270)
GUISetOnEvent($GUI_EVENT_CLOSE, "CLOSEButton")
Local $idURL = GUICtrlCreateInput("http://localhost:3000/binance", 10, 5, 200, 20)
Local $idStart = GUICtrlCreateButton("Start", 10, 25, 60, 20)
GUICtrlSetOnEvent($idStart, "StartButton")
Local $idStop = GUICtrlCreateButton("Exit", 150, 25, 60, 20)
GUICtrlSetOnEvent($idStop, "StopButton")
Local $idList = GUICtrlCreateList("", 10, 45, 200, 220)
GUICtrlSetFont($idList, 19, $FW_BOLD, $GUI_FONTNORMAL, $sFont)

GUISetState(@SW_SHOW, $hGUI)

While 1
    If $flag = 1 Then
        Local $sUrl = StringStripWS(GUICtrlRead($idURL), 8) & "?all=1"
        Local $dData = InetRead($sUrl, 1)
        Local $sInput = BinaryToString($dData)
        Local $sOutput = StringRegExpReplace($sInput, '.+\:\[(.+)\]\}\}', '$1')
        Local $sList = StringReplace($sOutput, '"', "")
        If $sPred <> $sList Then
            $sPred = $sList
            Local $aList = StringSplit($sList, ",")
            GUICtrlSetData($idList, "")
            For $i = 1 To $aList[0]
                 GUICtrlSetData($idList, $aList[$i] & "|")
            Next
            GUISetState(@SW_RESTORE)
        EndIf
    EndIf
    Sleep(1000)
WEnd

Func StartButton()
    $flag = 1
EndFunc


Func StopButton()
    Exit
EndFunc
