# ahk-keep-alive

このリポジトリには、Windowsの自動スリープを防ぐためのAutoHotkeyスクリプトが含まれています。

## ファイル

- `keep_awake.ahk` - 1分ごとにマウスを1ピクセル移動させる常駐スクリプト（AutoHotkey v2 対応）。

## 要件

- Windows
- AutoHotkey v2.x（https://www.autohotkey.com/）

## 使い方

1. AutoHotkey v2 をインストールします。
2. `keep_awake.ahk` をダブルクリックして実行します。

ホットキー:

- F8: スクリプトの有効/無効をトグルします。
- F9: デバッグ用に1回だけマウスを移動します（動作確認用）。
- Ctrl+Alt+Q: スクリプトを終了します。

## スタートアップ登録（オプション）

スクリプトをWindows起動時に自動で実行したい場合は、ショートカットを作成して以下のフォルダに入れてください:
`%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup`

## 注意点

- マウスが常に微小に移動するため、遠隔操作やゲームなどで影響が出る場合があります。必要に応じて無効にしてください。
- 管理者権限は不要ですが、特定の環境ではAutoHotkeyの権限により動作が制限されることがあります。

## 変更履歴

初回作成（AutoHotkey v2 対応、1分ごとに1ピクセル移動）
