global Enabled := true
; keep_awake.ahk
; AutoHotkey v2 用に書き換え済み
; 目的: Windowsの自動スリープを防ぐため、定期的にマウスを微小移動させるスクリプト
; ホットキー:
; - F8: トグル（有効/無効）
; - F9: デバッグ用に1回移動（動作確認）
; - Ctrl+Alt+Q: 終了

#Requires AutoHotkey v2.0
#SingleInstance force
; デフォルトは有効
Enabled := true

; 移動量（ピクセル）とインターバル（ミリ秒）
moveAmount := 1
intervalMs := 60000 ; 1分

; 初期マウス位置取得（保持は任意）
pos := MouseGetPos()
lastX := pos.X
lastY := pos.Y

; シンプルなステータスGUIを作成
Gui := GuiCreate()
Gui.Add("Text", "vStatusText", "Running: Enabled")
Gui.Show("x10 y10 NoActivate AlwaysOnTop")

; F8: トグル
F8:: {
    Enabled := !Enabled
    Gui.ControlSetText("StatusText", "Running: " (Enabled ? "Enabled" : "Disabled"))
    if Enabled
        TrayTip("Keep Awake", "Enabled - マウス移動を再開します.", 2)
    else
        TrayTip("Keep Awake", "Disabled - マウス移動を停止します.", 2)
}

; F9: デバッグで即時1回移動
F9:: {
    MoveMouseTick()
    TrayTip("Keep Awake", "Debug move sent.", 2)
}

; 終了
^!q:: ExitApp

; タイマーをセット
SetTimer(Func("TimerTick"), intervalMs)

TimerTick(*) {
    global Enabled
    if !Enabled
        return
    MoveMouseTick()
}

MoveMouseTick(*) {
    global moveAmount
    pos := MouseGetPos()
    curX := pos.X
    curY := pos.Y
    ; 右へ1ピクセル移動してすぐ戻す
    MouseMove(curX + moveAmount, curY, 0)
    Sleep(10)
    MouseMove(curX, curY, 0)
}
