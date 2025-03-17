# R開発環境セットアップガイド for Cline (Windows環境)

このガイドは、VS Code内のClineエージェントがWindows環境のターミナルを使用してR言語開発環境をセットアップするための手順を提供します。

# 依頼方法 
Clineに以下を頼む
```
@/docs/07-cline/readme_for_cline_windows.md これを使ってRをセットアップして
```

## Windows環境に関する注意点

- このガイドはWindows環境専用です
- PowerShellターミナルを使用することを前提としています
- パスの区切り文字にはバックスラッシュ(`\`)ではなくスラッシュ(`/`)を使用します
- Rのインストール場所は環境によって異なる可能性があります

## 環境セットアップ手順

### 1. Rのインストール確認

まず、Rがインストールされているか確認します。以下のコマンドをターミナルで実行してください：

```powershell
# Rのインストールパスを探す
$possible_paths = @(
    "C:/Program Files/R/*/bin/R.exe",
    "C:/Program Files/R/R-*/bin/R.exe"
)

$r_path = $null
foreach ($pattern in $possible_paths) {
    $found_paths = Get-ChildItem -Path $pattern -ErrorAction SilentlyContinue
    if ($found_paths) {
        $r_path = $found_paths[0].FullName
        break
    }
}

if ($r_path) {
    Write-Host "Rが見つかりました: $r_path"
    # バージョン確認
    & $r_path --version
} else {
    Write-Host "Rが見つかりません。インストールが必要です。"
}
```

### Rがインストール済みか確認する別の方法

```powershell
# Rコマンドがパスに通っているか確認
Get-Command R -ErrorAction SilentlyContinue

# 一般的なインストール場所を確認
Test-Path "C:/Program Files/R"
```

### 2. Rがインストールされていない場合

Rがインストールされていない場合は、以下の方法でインストールできます：

#### 方法1: PowerShellでダウンロードして実行

```powershell
# Rの最新バージョンをダウンロード
$tempFile = [System.IO.Path]::GetTempFileName() + ".exe"
Invoke-WebRequest -Uri "https://cran.r-project.org/bin/windows/base/R-4.3.3-win.exe" -OutFile $tempFile

# インストーラを実行
Start-Process -FilePath $tempFile -Wait
Remove-Item $tempFile
```

#### 方法2: choco (Chocolatey)を使用する場合

既にChocolateyがインストールされている場合：

```powershell
# Rをインストール
choco install r.project -y
```

Chocolateyがない場合は、先にChocolateyをインストールしてから実行します：

```powershell
# Chocolateyをインストール
Set-ExecutionPolicy Bypass -Scope Process -Force
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# Rをインストール
choco install r.project -y
```

### 3. インストール後のRパスの設定

インストール後、Rの実行ファイルのパスを変数に設定します：

```powershell
# Rのインストールパスを再探索
$possible_paths = @(
    "C:/Program Files/R/*/bin/R.exe",
    "C:/Program Files/R/R-*/bin/R.exe"
)

$r_path = $null
foreach ($pattern in $possible_paths) {
    $found_paths = Get-ChildItem -Path $pattern -ErrorAction SilentlyContinue
    if ($found_paths) {
        $r_path = $found_paths[0].FullName
        break
    }
}

if ($r_path) {
    Write-Host "Rが見つかりました: $r_path"
} else {
    Write-Host "Rが見つかりません。インストールに問題がある可能性があります。"
    exit
}
```

### 4. 必要なパッケージのインストール

以下のRスクリプトを作成して実行し、必要なパッケージをインストールします：

```powershell
# パッケージインストール用のRスクリプトを作成
$installPackagesScript = @'
# 必要なパッケージをインストール
packages <- c("dplyr", "ggplot2", "readxl", "gtsummary")
new_packages <- packages[!(packages %in% installed.packages()[,"Package"])]
if(length(new_packages)) {
  install.packages(new_packages, repos="https://cran.rstudio.com/")
  print(paste("インストールされたパッケージ:", paste(new_packages, collapse=", ")))
} else {
  print("すべてのパッケージはすでにインストールされています")
}
'@

# スクリプトをファイルに保存
$installPackagesScript | Out-File -FilePath "install_packages.R" -Encoding utf8

# スクリプトを実行
& $r_path --vanilla -f "install_packages.R"
```

### 5. サンプルデータのダウンロード

READMEに記載されているサンプルデータをダウンロードします：

```powershell
# データダウンロード用のRスクリプトを作成
$downloadDataScript = @'
# URLを指定してダウンロード
download.file(
    "https://raw.githubusercontent.com/vscodejp/vs-code-with-copilot-seminar/main/data/patient_data.csv",
    "patient_data.csv"
)

# ファイルが存在するか確認
if (file.exists("patient_data.csv")) {
    print("データのダウンロードに成功しました")
    # 最初の数行を表示
    patient_data <- read.csv("patient_data.csv")
    print(head(patient_data))
} else {
    print("データのダウンロードに失敗しました")
}
'@

# スクリプトをファイルに保存
$downloadDataScript | Out-File -FilePath "download_data.R" -Encoding utf8

# スクリプトを実行
& $r_path --vanilla -f "download_data.R"
```

### 6. 環境テスト

R環境が正しく構成されているか確認するためのテストスクリプトを実行します：

```powershell
# 環境テスト用のRスクリプトを作成
$testEnvironmentScript = @'
# Rとパッケージのバージョン確認
cat("Rバージョン:", R.version.string, "\n\n")

# インストール済みパッケージを確認
cat("必要なパッケージ:\n")
packages <- c("dplyr", "ggplot2", "readxl", "gtsummary")
installed <- packages %in% installed.packages()[,"Package"]
status <- ifelse(installed, "インストール済み", "未インストール")
for (i in 1:length(packages)) {
  cat(sprintf("- %s: %s\n", packages[i], status[i]))
}

# 作業ディレクトリの確認
cat("\n作業ディレクトリ:", getwd(), "\n")

# データファイルの確認
cat("\nデータファイル:\n")
if (file.exists("patient_data.csv")) {
  patient_data <- read.csv("patient_data.csv")
  cat("- patient_data.csv: 存在します（", nrow(patient_data), "行 x ", ncol(patient_data), "列）\n")
} else {
  cat("- patient_data.csv: 存在しません\n")
}
'@

# スクリプトをファイルに保存
$testEnvironmentScript | Out-File -FilePath "test_environment.R" -Encoding utf8

# スクリプトを実行
& $r_path --vanilla -f "test_environment.R"
```

## R言語の基本機能を試す

READMEに記載されている基本的なR機能を試すスクリプトを実行します：

```powershell
# 基本機能テスト用のRスクリプトを作成
$basicFunctionsScript = @'
# 基本的な変数の作成と表示
age <- 25
height <- 170.5
name <- "Taro"
scores <- c(80, 75, 90, 85)

cat("変数の表示:\n")
cat("- age:", age, "\n")
cat("- height:", height, "\n")
cat("- name:", name, "\n")
cat("- scores:", paste(scores, collapse=", "), "\n\n")

# 計算の例
cat("基本計算:\n")
cat("- 合計点:", sum(scores), "\n")
cat("- 平均点:", mean(scores), "\n")
cat("- 最高点:", max(scores), "\n")
cat("- 最低点:", min(scores), "\n\n")

# データが存在する場合はデータ分析の例も実行
if (file.exists("patient_data.csv")) {
  cat("患者データの分析:\n")
  patient_data <- read.csv("patient_data.csv")
  
  # dplyrがインストールされている場合
  if ("dplyr" %in% installed.packages()[,"Package"]) {
    library(dplyr)
    
    # 基本的な統計量
    cat("基本統計量（最初の3列のみ表示）:\n")
    print(summary(patient_data[,1:3]))
    
    cat("\n年齢の分布:\n")
    age_groups <- cut(patient_data$age, breaks=c(0, 20, 40, 60, 100), labels=c("0-20", "21-40", "41-60", "61+"))
    print(table(age_groups))
  } else {
    cat("dplyrパッケージがインストールされていません。基本的な分析のみ実行します。\n")
    print(summary(patient_data[,1:3]))
  }
}
'@

# スクリプトをファイルに保存
$basicFunctionsScript | Out-File -FilePath "basic_functions.R" -Encoding utf8

# スクリプトを実行
& $r_path --vanilla -f "basic_functions.R"
```

## トラブルシューティング

### Rのパスが見つからない場合

1. 手動でRのインストール場所を探します：
   ```powershell
   Get-ChildItem "C:/Program Files" -Recurse -Filter "R.exe" -ErrorAction SilentlyContinue
   ```

2. 見つかったパスを変数に設定します：
   ```powershell
   $r_path = "見つかったR.exeのフルパス"
   ```

### パッケージのインストールに失敗する場合

1. 管理者権限でPowerShellを実行してください
2. 別のミラーサイトを試してみてください：
   ```powershell
   $alternativeMirrorScript = @'
   install.packages("dplyr", repos="https://cloud.r-project.org/")
   '@
   
   $alternativeMirrorScript | Out-File -FilePath "alt_mirror.R" -Encoding utf8
   & $r_path --vanilla -f "alt_mirror.R"
   ```

### 文字化けが発生する場合

1. ファイルエンコーディングを指定してみてください：
   ```powershell
   $encodingFixScript = @'
   patient_data <- read.csv("patient_data.csv", fileEncoding = "UTF-8")
   # または
   # patient_data <- read.csv("patient_data.csv", fileEncoding = "CP932")  # Windowsの場合
   
   print(head(patient_data))
   '@
   
   $encodingFixScript | Out-File -FilePath "encoding_fix.R" -Encoding utf8
   & $r_path --vanilla -f "encoding_fix.R"
   ```

## R言語の学習を進める

READMEの指示に従って、以下のようなステップで学習を進めることができます：

1. 基本的なR文法の理解
2. データの読み込みと前処理
3. 基本的な統計解析
4. グラフの作成

各ステップごとに、READMEのコード例をRスクリプトとして保存して実行してみましょう。

---

このガイドがWindowsでのR開発環境セットアップのお役に立てば幸いです。
