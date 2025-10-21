; keep_awake.ahk
; 目的: Windowsの自動スリープを防ぐため、定期的にマウスを微小移動させるAutoHotkeyスクリプト
; 使い方: AutoHotkeyがインストールされている環境でこのスクリプトを実行してください。
; - F8: トグル（有効/無効）
; - F9: 一時的に1回移動してメッセージ表示（デバッグ用）
; - Ctrl+Alt+Q: 終了（スクリプトから退避）

#SingleInstance force
#NoEnv
SendMode Input
SetBatchLines -1

; デフォルトは有効
global Enabled := true

; 移動量（ピクセル）とインターバル（ミリ秒）
moveAmount := 1
intervalMs := 60000 ; 1分

; 前回のマウス位置を保持
MouseGetPos, lastX, lastY

; ステータスGUIを作る
Gui, +AlwaysOnTop -Caption +ToolWindow
Gui, Margin, 6,6
Gui, Add, Text, vStatusText, Running: Enabled
Gui, Show, x10 y10 NoActivate, Keep Awake

; トグルホットキー
F8::
    Enabled := !Enabled
    Gosub, UpdateGui
    if (Enabled)
        TrayTip, Keep Awake, Enabled - マウス移動を再開します。, 2
    else
        TrayTip, Keep Awake, Disabled - マウス移動を停止します., 2
return

; デバッグ用: 1回だけ移動してメッセージ表示
F9::
    Gosub, MoveMouseTick
    TrayTip, Keep Awake, Debug move sent., 2
return

; 終了
^!q::
    ExitApp
return

; GUI更新
UpdateGui:
    GuiControl,, StatusText, Running: % (Enabled ? "Enabled" : "Disabled")
return

; メインループ: タイマーで実行
SetTimer, TimerTick, %intervalMs%
; 初回実行を少し待つ（起動直後の誤動作防止）
SetTimer, TimerTick, Off
Sleep, 1000
SetTimer, TimerTick, %intervalMs%

TimerTick:
    if (!Enabled)
        return
    Gosub, MoveMouseTick
return

MoveMouseTick:
    ; 現在のマウス位置を取得
    MouseGetPos, curX, curY
    ; 微小に移動（右へ1ピクセル）、すぐ戻す
    MouseMove, % curX + moveAmount, % curY, 0
    Sleep, 10
    MouseMove, % curX, % curY, 0
    return
