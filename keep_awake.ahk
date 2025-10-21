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

; トレイアイコンのツールチップ
A_IconTip := "Keep Awake"

SetupTraiMenu
; --- トレイメニューをカスタマイズ ---
SetupTraiMenu() {
    A_TrayMenu.Delete() ; 既定項目をすべて削除
    if Enabled {
        A_TrayMenu.Add("無効化(&D)", ToggleEnabled)
        A_IconTip := "Keep Awake (有効)"
    } else {
        A_TrayMenu.Add("有効化(&E)", ToggleEnabled)
        A_IconTip := "Keep Awake (無効)"
    }
    A_TrayMenu.Add("デバッグで1回移動(&D)", DebugMove)
    A_TrayMenu.Add("終了(&E)", OnExitApp)
}

; 移動量（ピクセル）とインターバル（ミリ秒）
moveAmount := 1
intervalMs := 60000 ; 1分

; 初期マウス位置取得は不要（MoveMouseTick で A_MouseX/A_MouseY を直接利用）

; F8: トグル（GUIを使わずトレイ通知のみ）
F8:: {
    ToggleEnabled()
}

; F9: デバッグで即時1回移動
F9:: {
    DebugMove()
}

; 終了
^!q:: {
    OnExitApp()
}

; タイマーをセット (v2: Func("Name") は不要、関数オブジェクトを直接渡す)
SetTimer(TimerTick, intervalMs)

TimerTick(*) {
    global Enabled
    if !Enabled
        return
    MoveMouseTick()
}

MoveMouseTick(*) {
    global moveAmount
    ; 現在のマウス座標を安全に取得（AHK v2: ByRef）
    MouseGetPos(&curX, &curY)
    ; 右へ1ピクセル移動してすぐ戻す
    MouseMove(curX + moveAmount, curY, 0)
    Sleep(10)
    MouseMove(curX, curY, 0)
}

; -----------------------------
; トレイメニューのハンドラ
; -----------------------------

ToggleEnabled(*) {
    global Enabled
    Enabled := !Enabled
    if Enabled
        TrayTip("Keep Awake", "Enabled - マウス移動を再開します.", 2)
    else
        TrayTip("Keep Awake", "Disabled - マウス移動を停止します.", 2)
    SetupTraiMenu()
}

DebugMove(*) {
    MoveMouseTick()
    TrayTip("Keep Awake", "Debug move sent.", 2)
}

OnExitApp(*) {
    ; 明示的に終了
    ExitApp()
}
