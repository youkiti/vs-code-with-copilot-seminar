# 3. R言語を使ってみよう

このセクションでは、データ分析のための言語「R」の使い方を学びます。
プログラミングは初めてという方でも、一つずつ順番に進めていけば大丈夫です。

## このセクションでやること

1. **Rを使えるようにする**
   - Rのインストール
   - VS CodeでRを使うための設定

2. **Rの基本を学ぶ**
   - 数字や文字の扱い方
   - 計算の仕方
   - データの読み込み方

3. **データの整理方法を学ぶ**
   - データの形を整える
   - 必要な部分を取り出す
   - 新しい情報を追加する

4. **データを分析する**
   - 基本的な統計量の計算
   - グラフの作成

## 3.1 Rをインストールしよう

### Rのインストール方法

#### Windowsの場合
1. [CRAN](https://cran.r-project.org/)のウェブサイトにアクセス
2. 「Download R for Windows」をクリック
3. 「base」をクリック
4. 一番上にある「Download R-x.x.x for Windows」をクリック
   - x.x.xは最新のバージョン番号です
5. ダウンロードしたファイルをダブルクリック
6. インストール画面が表示されたら：
   - 基本的に「Next」を押していけばOK
   - 分からない設定はデフォルトのままで大丈夫です

#### Macの場合
1. [CRAN](https://cran.r-project.org/)のウェブサイトにアクセス
2. 「Download R for macOS」をクリック
3. お使いのmacOSのバージョンに合わせたインストーラをダウンロード
4. ダウンロードしたファイルをダブルクリック
5. 画面の指示に従ってインストール

### VS CodeでRを使えるようにする

前のセクションでインストールした拡張機能を設定します：

1. **拡張機能の確認**
   - VS Codeを開く
   - 左側のパズルのピースアイコンをクリック
   - 以下の拡張機能がインストールされているか確認：
     * R Extension for Visual Studio Code
     * R LSP Client

2. **Rの場所を設定**
   - VS Codeの設定を開く
     * Windowsの場合：Ctrl + ,
     * Macの場合：Cmd + ,
   - 検索バーに「R path」と入力
   - 「R > Rpath: Windows」または「R > Rpath: Mac」に
     Rのインストール場所を入力
     * Windows例：C:\\Program Files\\R\\R-4.x.x\\bin\\R.exe
     * Mac例：/usr/local/bin/R

3. **動作確認**
   - 新しいRファイルを作成
     * 「ファイル」→「新規ファイル」
     * 「.R」という拡張子で保存（例：test.R）
   - 以下のコードを入力：
     ```R
     print("Hello, R!")
     ```
   - 右上の実行ボタン（▶）をクリック
   - 「Hello, R!」と表示されれば成功です

## 3.2 Rの基本を学ぼう

### データを保存する（変数）

変数は、データを一時的に保存しておく場所です。
箱にものを入れるようなイメージです。

### 変数名の付け方に関する重要な注意点

1. **英語を使う**
   - 理由1：プログラミングは英語が基本
   - 理由2：他の人とコードを共有しやすい
   - 理由3：エラーメッセージが英語なので対応しやすい

2. **スペースを使わない**
   - 理由：スペースがあるとエラーになる
   - 代わりに以下の方法を使う：
     * アンダースコア: first_name
     * キャメルケース: firstName

3. **分かりやすい名前をつける**
   - 良い例：age, height, weight
   - 悪い例：a, x1, temp

```R
# 数字を保存する
age <- 25           # 整数
height <- 170.5     # 小数点あり

# 文字を保存する
name <- "Taro"      # 文字列は""で囲む
gender <- "male"    # 性別

# はい/いいえを保存する
exercise <- TRUE    # TRUEは「はい」
smoking <- FALSE    # FALSEは「いいえ」

# 複数の値をまとめて保存する
scores <- c(80, 75, 90, 85)  # c()で複数の値をまとめる
```

### 計算をする

基本的な計算は電卓と同じように使えます：

```R
# 足し算、引き算
total <- 10 + 5     # 15になる
diff <- 10 - 5      # 5になる

# 掛け算、割り算
area <- 10 * 5      # 50になる
mean <- 10 / 2      # 5になる

# 複数の値の計算
scores <- c(80, 75, 90, 85)
total_score <- sum(scores)       # 全部足す
mean_score <- mean(scores)       # 平均を計算
max_score <- max(scores)         # 最大値
min_score <- min(scores)         # 最小値

### 条件分岐と繰り返し

プログラムでは、条件によって処理を変えたり、同じ処理を繰り返したりできます。

#### 条件によって処理を変える（if文）
```R
# 年齢によって区分を決める
age <- 25

if (age >= 65) {
    category <- "elderly"
} else if (age >= 20) {
    category <- "adult"
} else {
    category <- "minor"
}

print(paste("Category:", category))
```

#### 決まった回数繰り返す（for文）
```R
# 5人分の点数を表示する
scores <- c(80, 75, 90, 85, 95)

for (i in 1:5) {
    print(paste("Score", i, ":", scores[i]))
}
```

#### 条件が満たされる間繰り返す（while文）
```R
# 合計が100を超えるまで数を足していく
total <- 0
count <- 0

while (total < 100) {
    total <- total + 10
    count <- count + 1
    print(paste("Step", count, ": Total is", total))
}
```

## 3.3 データを読み込んで整理しよう

### データの読み込み方

このコースでは、実際の医療データを模したサンプルデータを使用します。
以下のような情報が含まれています：

- 基本属性：年齢、性別、身長、体重
- 生活習慣：喫煙、飲酒、運動習慣
- 検査値：血圧、コレステロール、HbA1c
- 疾患情報：高血圧、糖尿病、脂質異常症の有無

#### コードの入力場所について

データの読み込みには2種類のコードを使います：

1. **Rのコード**（.Rファイルに書く）
   - VS Codeで新しいファイルを作成
   - 拡張子を`.R`にして保存
   - 例：`data_analysis.R`

2. **ターミナルコマンド**（ターミナルで実行）
   - VS Codeのメニューから「ターミナル」→「新しいターミナル」
   - 表示されたターミナルに直接コマンドを入力
   - Windowsの場合は「Git Bash」を使用

以下のコードは、特に指定がない限り**Rファイル**に書いてください。

#### データのダウンロードと保存

1. **GitHubからデータをダウンロード**
```R
# URLを指定してダウンロード
download.file(
    "https://raw.githubusercontent.com/vscodejp/vs-code-with-copilot-seminar/main/data/patient_data.csv",
    "patient_data.csv"
)
```

2. **ファイルの場所を確認**
```R
# 現在の作業ディレクトリを確認
getwd()  # このパスにファイルが保存されます

# ディレクトリ内のファイル一覧を表示
list.files()  # patient_data.csvがあるか確認

# ファイルが存在するか確認
file.exists("patient_data.csv")  # TRUEならファイルが存在します
```

3. **作業ディレクトリの変更（必要な場合）**
```R
# Windowsの場合
setwd("C:/Users/YourName/Documents/R")  # バックスラッシュ（\）ではなくスラッシュ（/）を使う

# Macの場合
setwd("/Users/YourName/Documents/R")
```

#### データの読み込みとエラー対処

1. **基本的な読み込み方**
```R
# CSVファイルを読み込む
patient_data <- read.csv("patient_data.csv")
```

2. **よくあるエラーと解決方法**

a. ファイルが見つからない場合
```R
# エラーメッセージ例：
# Error: cannot open file 'patient_data.csv': No such file or directory

# 解決方法1：フルパスで指定
patient_data <- read.csv("C:/Users/YourName/Documents/patient_data.csv")  # Windows
patient_data <- read.csv("/Users/YourName/Documents/patient_data.csv")    # Mac

# 解決方法2：作業ディレクトリを変更
setwd("データファイルがある場所のパス")
```

b. 文字化けが発生する場合
```R
# 文字化けの例：性別が"男性"ではなく"??"と表示される

# 解決方法：エンコーディングを指定
patient_data <- read.csv("patient_data.csv", fileEncoding = "UTF-8")
# または
patient_data <- read.csv("patient_data.csv", fileEncoding = "CP932")  # Windowsの場合
```

3. **データの確認方法**
```R
# 最初の6行を表示
head(patient_data)

# データの構造を確認
str(patient_data)

# 列名の確認
names(patient_data)

# 基本統計量の確認
summary(patient_data)
```

#### 他の形式のファイルを読む場合

1. **Excelファイル**
```R
# パッケージのインストールと読み込み
install.packages("readxl")
library(readxl)

# Excelファイルを読み込む
excel_data <- read_excel("patient_data.xlsx")
```

2. **タブ区切りファイル**
```R
# タブ区切りファイルを読み込む
tab_data <- read.delim("patient_data.txt")
```

### データの整理方法（dplyrパッケージ）

データを分析しやすい形に整理する方法を学びましょう：

```R
# 必要なパッケージを読み込む
library(dplyr)

# 例：患者データから必要な情報を取り出す
patient_data %>%                           # データを受け取って...
    filter(age >= 20) %>%                  # 20歳以上を選び...
    select(patient_id, name, age, sex) %>% # 必要な列だけ選んで...
    arrange(age)                           # 年齢順に並べる

# 新しい情報を追加する
patient_data %>%
    mutate(
        age_category = case_when(
            age >= 65 ~ "elderly",
            age >= 20 ~ "adult",
            TRUE      ~ "minor"
        ),
        bmi = weight / (height/100)^2
    )

# グループごとの集計
patient_data %>%
    group_by(sex, age_category) %>%        # グループ分けして...
    summarise(                             # 以下の計算を実行
        count = n(),
        mean_age = mean(age),
        mean_bmi = mean(bmi)
    )
```

## 3.4 データを分析しよう

### 基本的な統計量の計算

#### gtsummaryパッケージを使う方法

```R
# パッケージのインストールと読み込み
install.packages("gtsummary")
library(gtsummary)

# 患者データの基本統計量を計算
patient_data %>%
    select(age, height, weight, bmi) %>%
    tbl_summary(
        statistic = list(
            all_continuous() ~ "{mean} ({sd})"
        ),
        digits = all_continuous() ~ 1
    )

# 性別ごとの比較
patient_data %>%
    select(sex, age, height, weight, bmi) %>%
    tbl_summary(
        by = sex,
        statistic = list(
            all_continuous() ~ "{mean} ({sd})"
        ),
        digits = all_continuous() ~ 1
    )
```

#### 基本的な関数を使う方法

```R
# データの概要を見る
summary(patient_data)

# 年齢の基本統計量
mean(patient_data$age)     # 平均年齢
sd(patient_data$age)       # 標準偏差
median(patient_data$age)   # 中央値
range(patient_data$age)    # 最小値と最大値
```

### 統計的な比較

#### 2群の比較（t検定）

```R
# 性別による身長の違いを比較
result <- t.test(height ~ sex, data = patient_data)
print(result)
```

**結果の見方**:
- `p-value`：統計的有意性を示す（0.05より小さければ「有意差あり」）
- `mean in group 男性`：男性の平均身長
- `mean in group 女性`：女性の平均身長
- `95 percent confidence interval`：平均値の差の95%信頼区間

#### 相関関係の確認

```R
# 身長と体重の関係を確認
result <- cor.test(patient_data$height, patient_data$weight)
print(result)
```

**結果の見方**:
- `cor`：相関係数（-1から1の値）
  * 1に近い：強い正の相関（一方が増えると他方も増える）
  * -1に近い：強い負の相関（一方が増えると他方は減る）
  * 0に近い：相関が弱い
- `p-value`：統計的有意性を示す

## 3.5 グラフを作ろう

### ggplot2パッケージでグラフ作成

#### ヒストグラム（分布の形を見る）

```R
# 年齢の分布
ggplot(patient_data, aes(x = age)) +
    geom_histogram(binwidth = 5, fill = "skyblue", color = "white") +
    labs(
        title = "Age Distribution",
        x = "Age",
        y = "Count"
    ) +
    theme_minimal()
```

**グラフの見方**:
- 横軸：年齢
- 縦軸：各年齢層の人数
- 山の形：データの分布（左右対称か、どこに集中しているか）
- 棒の幅（binwidth）：データをまとめる区間の大きさ

#### 散布図（2つの変数の関係を見る）

```R
# 身長と体重の関係
ggplot(patient_data, aes(x = height, y = weight, color = sex)) +
    geom_point(alpha = 0.6) +
    labs(
        title = "Height vs Weight by Sex",
        x = "Height (cm)",
        y = "Weight (kg)"
    ) +
    theme_minimal()
```

**グラフの見方**:
- 横軸：身長
- 縦軸：体重
- 点の色：性別による区別
- 点の分布：
  * 右上がり：正の相関（身長が高いほど体重も重い）
  * 右下がり：負の相関
  * ばらばら：相関が弱い

#### 箱ひげ図（グループ間の分布を比較）

```R
# BMIの分布を性別で比較
ggplot(patient_data, aes(x = sex, y = bmi)) +
    geom_boxplot(fill = "lightgreen") +
    labs(
        title = "BMI Distribution by Sex",
        x = "Sex",
        y = "BMI"
    ) +
    theme_minimal()
```

**グラフの見方**:
- 箱の中央線：中央値
- 箱の上端：75パーセンタイル
- 箱の下端：25パーセンタイル
- ひげの上端：最大値（外れ値を除く）
- ひげの下端：最小値（外れ値を除く）
- 点：外れ値

## チェックポイント

以下の項目を確認してください：

- [ ] Rがインストールされ、VS Codeで実行できる
- [ ] 基本的なR文法を理解している
- [ ] データの読み込みと前処理ができる
- [ ] 基本的な統計解析ができる
- [ ] グラフを作成できる

## 演習問題

1. サンプルデータを使って基本的な統計量を計算してみましょう
2. データをグループ化して集計してみましょう
3. 結果をグラフで可視化してみましょう

## 次のステップ

R言語の基礎を理解したら、[次のセクション](../04-ai-tools/README.md)に進んでください。
