# 5. 解析プロジェクト演習

このセクションでは、実際の臨床研究を想定したデータセットを用いて、これまでに学んだスキルを活用した解析プロジェクトを行います。

## 目標

- 研究目的とデザインの理解
- データ解析の実践
- GitHubを使用したバージョン管理
- 解析結果のレポート作成

## 5.1 研究デザインの基礎

### 主な研究デザイン

1. **横断研究（Cross-sectional Study）**
   - 特定の時点でのデータを収集
   - 疾患の有病率や関連要因の調査に適する
   - 例：高血圧の有病率調査

2. **コホート研究（Cohort Study）**
   - 対象者を一定期間追跡
   - 要因と結果の因果関係を調査
   - 例：喫煙と肺がんの関連調査

3. **症例対照研究（Case-Control Study）**
   - 疾患群と対照群を比較
   - まれな疾患の危険因子の調査に適する
   - 例：特定の副作用と薬剤使用の関連調査

4. **ランダム化比較試験（RCT）**
   - 介入群と対照群をランダムに割り付け
   - 治療効果の評価に最適
   - 例：新薬の有効性評価

## 5.2 プロジェクトの進め方

### Step 1: 研究計画の立案

1. 研究目的の設定
   - 明確な研究課題の設定
   - 仮説の構築
   - 期待される成果の定義

2. 解析計画の作成
   - 必要なデータの特定
   - 統計手法の選択
   - 結果の評価方法の決定

### Step 2: データの準備

#### コードの入力場所について

このプロジェクトでは、2種類のコードを使います：

1. **Rのコード**：データの分析用
   - 拡張子が `.R` のファイルに書く
   - VS Codeで新しいファイルを作って保存
   - ファイル名の例：`analysis.R`

2. **ターミナルコマンド**：ファイル管理用
   - VS Code内の「ターミナル」で実行
   - メニューの「ターミナル」→「新しいターミナル」で開く
   - Windowsの場合は「Git Bash」を使用

#### データのダウンロードと保存

1. **最初に、新しいRファイルを作成します**
   - VS Codeで「ファイル」→「新規ファイル」
   - `analysis.R` という名前で保存

2. **以下のコードをRファイルに書きます**
```R
# GitHubからデータをダウンロード
download.file(
  "https://raw.githubusercontent.com/vscodejp/vs-code-with-copilot-seminar/main/data/patient_data.csv",
  "patient_data.csv"
)

# 現在の作業ディレクトリを確認
getwd()

# ファイルが存在するか確認
file.exists("patient_data.csv")

# CSVファイルを読み込む
data <- read.csv("patient_data.csv")

# データの中身を確認
head(data)  # 最初の6行を表示
str(data)   # データの構造を確認
summary(data)  # 基本統計量を確認
```

#### データ読み込みのトラブルシューティング

1. **ファイルが見つからないエラー**
```R
# エラーメッセージ例：
# Error in file(file, "rt") : cannot open the connection
# Error: cannot open file 'patient_data.csv': No such file or directory

# 解決方法：
# 1. 作業ディレクトリの確認
getwd()  # 現在の作業ディレクトリを表示
list.files()  # ディレクトリ内のファイル一覧を表示

# 2. 正しいディレクトリに移動
setwd("ファイルがある場所のパス")  # 作業ディレクトリの変更

# 3. フルパスで指定
data <- read.csv("C:/Users/あなたの名前/Documents/patient_data.csv")  # Windowsの例
data <- read.csv("/Users/あなたの名前/Documents/patient_data.csv")    # macOSの例
```

2. **文字化けの対処**
```R
# 文字化けの例：
# 性別が"男性"ではなく"??"と表示される

# 解決方法：
# 1. エンコーディングを指定して読み込み
data <- read.csv("patient_data.csv", fileEncoding = "UTF-8")  # UTF-8の場合
data <- read.csv("patient_data.csv", fileEncoding = "CP932")  # Shift-JISの場合

# 2. 読み込み後に文字コードを変換
data$sex <- iconv(data$sex, from = "UTF-8", to = "CP932")
```

3. **データの確認と修正**
```R
# 1. 列名の確認
names(data)  # 列名の一覧表示

# 2. データ型の確認
str(data)    # 各列のデータ型を表示

# 3. 文字列を因子型に変換
data$sex <- as.factor(data$sex)
data$smoking <- as.factor(data$smoking)

# 4. 数値の確認
summary(data)  # 数値の範囲や欠損値を確認
```

#### データの整理

1. 欠損値の確認
```R
# 欠損値の数を確認
colSums(is.na(data))

# 欠損値がある行を除外
data_clean <- na.omit(data)
```

2. 異常値の確認
```R
# 年齢の範囲を確認
range(data$age)

# 血圧の範囲を確認
range(data$sbp)  # 収縮期血圧
range(data$dbp)  # 拡張期血圧
```

### Step 3: 探索的データ解析

1. 記述統計
```R
# 基本統計量の算出
# グラフによる可視化
```

2. 仮説の検証
```R
# 統計検定
# 多変量解析
```

### Step 4: 結果のまとめ

1. 図表の作成
```R
# 結果を視覚的に表現
# 効果的なグラフの選択
```

2. レポートの作成
   - R Markdownを使用
   - 結果の解釈と考察
   - 限界点の検討

## 5.3 作業の記録と管理

プログラムを書いていると、途中で間違えたり、前の状態に戻りたくなったりすることがあります。そんなとき、作業の記録（これを「バージョン管理」と呼びます）があると便利です。

### 作業の記録方法

作業の記録は、写真を撮るように残すことができます。
これらのコマンドはターミナルで実行します。

**ターミナルの開き方**:
1. VS Codeのメニューから「ターミナル」を選択
2. 「新しいターミナル」をクリック
3. Windowsの場合：
   - 右上の「+」の横にある「∨」をクリック
   - 「Git Bash」を選択
4. macOSの場合：
   - デフォルトのターミナルを使用

**作業の手順**:

1. **作業フォルダの準備**
   - 開いたターミナルで以下のコマンドを入力：
```bash
# 新しい作業フォルダを作る（写真アルバムを用意する感じ）
git init
```

2. **変更内容の記録**
   - 同じターミナルで以下のコマンドを順番に入力：
```bash
# 変更したファイルを記録する準備（写真を撮る準備）
git add .

# 変更内容を記録（シャッターを押す）
git commit -m "今日の作業：データの読み込みをしました"
```

### 別の作業をするとき

新しい機能を試すときは、元の作業を壊さないように別の場所で試すことができます。
これらのコマンドもターミナルで実行します：

1. **作業場所を分ける**
```bash
# 新しい作業場所を作る（実験用のコピーを作る感じ）
git checkout -b test-feature

# 色々試してみる
# うまくいったら...

# 元の作業場所に戻って、うまくいった変更を取り込む
git checkout main  # 元の場所に戻る
git merge test-feature  # 試した内容を取り込む
```

**重要**: 
- `R`で始まるコードブロックは、Rファイル（.R）に書きます
- `bash`で始まるコードブロックは、ターミナルで実行します

このように記録を残しておくと：
- 間違えても前の状態に戻れる
- 新しいことを安心して試せる
- 作業の履歴が残る

## 5.4 サンプルプロジェクト：高血圧に関する横断研究

### 研究の目的
- 高血圧の有病率を調査する
- 高血圧と関連する要因を特定する

### 解析コード例

1. **データの準備**
```R
# 必要なパッケージの読み込み
library(tidyverse)
library(gtsummary)

# データの読み込み
data <- read.csv("patient_data.csv")

# 高血圧の定義（収縮期血圧140以上または拡張期血圧90以上）
data <- data %>%
    mutate(hypertension = ifelse(sbp >= 140 | dbp >= 90, "あり", "なし"))
```

2. **記述統計**
```R
# 基本統計量の作成
tbl_summary(
    data,
    by = hypertension,
    include = c("age", "sex", "bmi", "smoking", "exercise")
)

# 年齢層による層別解析
data %>%
    mutate(age_group = cut(age, 
        breaks = c(0, 50, 65, 100),
        labels = c("50歳未満", "50-65歳", "65歳以上")
    )) %>%
    tbl_summary(
        by = age_group,
        include = c("hypertension", "sbp", "dbp")
    )
```

3. **グラフ作成**
```R
# 年齢と血圧の散布図
ggplot(data, aes(x = age, y = sbp)) +
    geom_point(aes(color = sex)) +
    geom_smooth(method = "lm") +
    labs(
        title = "年齢と収縮期血圧の関係",
        x = "年齢",
        y = "収縮期血圧 (mmHg)"
    ) +
    theme_minimal()

# 高血圧の有病率（性別・年齢層別）
data %>%
    mutate(age_group = cut(age, 
        breaks = c(0, 50, 65, 100),
        labels = c("50歳未満", "50-65歳", "65歳以上")
    )) %>%
    ggplot(aes(x = age_group, fill = hypertension)) +
    geom_bar(position = "fill") +
    facet_wrap(~sex) +
    labs(
        title = "性別・年齢層別の高血圧有病率",
        x = "年齢層",
        y = "割合"
    ) +
    theme_minimal()
```

4. **統計解析**
```R
# ロジスティック回帰分析
model <- glm(
    hypertension == "あり" ~ age + sex + bmi + smoking + exercise,
    family = binomial,
    data = data
)

# 結果の表示
summary(model)

# オッズ比の計算
exp(coef(model))
```

### 結果の解釈例

1. **記述統計**
   - 年齢層別の高血圧有病率
   - 性別による血圧値の違い
   - BMIと高血圧の関連

2. **多変量解析**
   - 年齢の影響（1歳上がるごとのオッズ比）
   - 性別の影響（男性vs女性）
   - 生活習慣の影響（喫煙、運動）

## チェックポイント

以下の項目を確認してください：

- [ ] 研究デザインを理解し、適切な解析計画を立てられる
- [ ] データの前処理から解析まで実行できる
- [ ] GitHubでバージョン管理ができる
- [ ] 結果を適切にまとめ、レポートを作成できる

## 演習課題

1. サンプルデータを使用して、以下の解析を実施してください：
   - 基本的な記述統計
   - 群間比較
   - 多変量解析
   - 結果の可視化

2. 解析結果をR Markdownでレポートにまとめてください

3. 全ての作業をGitHubで管理してください

## 次のステップ

プロジェクトが完了したら、[次のセクション](../06-presentation/README.md)に進んでください。
