# 2. 開発環境の整備

このセクションでは、データ解析に必要な開発環境を構築します。

## 目標

- VS Codeのインストールと基本設定
- Gitのインストールと初期設定
- GitHubアカウントの作成とリポジトリの作成
- GitHub Copilotのセットアップ

## 2.1 VS Codeのセットアップ

### インストール手順

1. [VS Code公式サイト](https://code.visualstudio.com/)にアクセス
2. お使いのOSに合わせたインストーラをダウンロード
3. インストーラを実行し、画面の指示に従ってインストール

### 日本語化

1. VS Codeを起動
2. 左側のExtensionsアイコン（四角が4つ重なったアイコン）をクリック
3. 検索バーに「Japanese」と入力
4. "Japanese Language Pack for Visual Studio Code"をインストール
5. VS Codeを再起動

### 便利な拡張機能

以下の拡張機能をインストールすることをお勧めします：

- R Extension for Visual Studio Code
- R LSP Client
- GitLens
- GitHub Copilot
- GitHub Pull Requests and Issues

## 2.2 Gitのセットアップ

### インストール手順

#### Windows
1. [Git for Windows](https://gitforwindows.org/)からインストーラをダウンロード
2. インストーラを実行
3. 基本的にはデフォルト設定のまま「Next」を選択

#### macOS
1. ターミナルを開く
2. `git --version`を実行
3. Gitがインストールされていない場合、インストールの案内が表示される

### 初期設定

ターミナル（WindowsはGit Bash）で以下のコマンドを実行：

```bash
git config --global user.name "あなたの名前"
git config --global user.email "あなたのメールアドレス"
```

## 2.3 GitHubアカウントの作成

1. [GitHub](https://github.com/)にアクセス
2. 「Sign up」をクリック
3. 必要事項を入力
   - Username（ユーザー名）
   - Email（メールアドレス）
   - Password（パスワード）
4. アカウント作成後、メールアドレスの確認を行う

### リポジトリの作成

1. GitHubにログイン
2. 右上の「+」マークをクリック→「New repository」を選択
3. リポジトリ名を入力（例：r-data-analysis）
4. 必要に応じて説明を追加
5. 「Private」または「Public」を選択
6. 「Create repository」をクリック

## 2.4 GitHub Copilotのセットアップ

1. [GitHub Copilot](https://github.com/features/copilot)にアクセス
2. 「Start my free trial」をクリック
3. VS Codeを開く
4. 拡張機能から「GitHub Copilot」をインストール
5. VS CodeでGitHubアカウントにサインイン

## チェックポイント

以下の項目を確認してください：

- [ ] VS Codeがインストールされ、日本語化されている
- [ ] 必要な拡張機能がインストールされている
- [ ] Gitがインストールされ、初期設定が完了している
- [ ] GitHubアカウントが作成され、リポジトリが作成できる
- [ ] GitHub Copilotがセットアップされ、使用可能

## トラブルシューティング

### よくある問題と解決方法

1. VS Codeの拡張機能がインストールできない
   - インターネット接続を確認
   - VS Codeを再起動

2. Gitコマンドが認識されない
   - Pathが正しく設定されているか確認
   - PCの再起動を試す

3. GitHubにサインインできない
   - アカウント情報を確認
   - 二要素認証の設定を確認

## 次のステップ

環境構築が完了したら、[次のセクション](../03-r-basics/README.md)に進んでください。
