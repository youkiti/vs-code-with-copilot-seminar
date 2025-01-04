# 3. R基礎講座

このセクションでは、R言語の基礎を学び、データ解析の基本的なスキルを身につけます。

## 目標

- Rのインストールと基本設定
- R言語の基本文法の理解
- データの読み込みと基本的な前処理
- 基礎統計とデータ可視化

## 3.1 Rのセットアップ

### インストール手順

1. [CRAN](https://cran.r-project.org/)にアクセス
2. お使いのOSに合わせたインストーラをダウンロード
3. インストーラを実行し、画面の指示に従ってインストール

### VS CodeでのR環境設定

1. R Extension for Visual Studio Codeがインストールされていることを確認
2. R LSP Clientがインストールされていることを確認
3. VS Codeの設定でRのパスを指定（必要な場合）

## 3.2 R言語の基礎

### 変数と基本的なデータ型

```R
# 数値
x <- 10
y <- 3.14

# 文字列
name <- "データ分析"

# 論理値
is_valid <- TRUE

# ベクトル
numbers <- c(1, 2, 3, 4, 5)
```

### 基本的な演算

```R
# 四則演算
a <- 10 + 5  # 加算
b <- 10 - 5  # 減算
c <- 10 * 5  # 乗算
d <- 10 / 5  # 除算

# ベクトル演算
v1 <- c(1, 2, 3)
v2 <- c(4, 5, 6)
v3 <- v1 + v2  # ベクトル同士の加算
```

### 制御構文

```R
# if文
x <- 10
if (x > 5) {
    print("xは5より大きい")
} else {
    print("xは5以下")
}

# for文
for (i in 1:5) {
    print(paste("現在の値:", i))
}

# while文
i <- 1
while (i <= 5) {
    print(i)
    i <- i + 1
}
```

## 3.3 データの読み込みと前処理

### データの読み込み

```R
# CSVファイルの読み込み
data <- read.csv("data.csv")

# Excelファイルの読み込み（readxlパッケージが必要）
library(readxl)
excel_data <- read_excel("data.xlsx")
```

### データの前処理（dplyrパッケージ）

```R
library(dplyr)

# データのフィルタリング
filtered_data <- data %>%
    filter(age >= 20)

# 列の選択
selected_data <- data %>%
    select(id, name, age)

# 新しい列の作成
mutated_data <- data %>%
    mutate(age_group = ifelse(age < 40, "若年", "高年"))

# グループ化と集計
summarized_data <- data %>%
    group_by(sex) %>%
    summarise(
        mean_age = mean(age),
        sd_age = sd(age)
    )
```

## 3.4 基礎統計

### 記述統計

#### gtsummaryパッケージの使用

```R
# gtsummaryパッケージのインストールと読み込み
install.packages("gtsummary")
library(gtsummary)

# 基本的な記述統計表の作成
tbl_summary(data)

# 重要な注意点：
# tbl_summary()にp値は追加しないでください。
# p値の追加は統計的検定の文脈で別途行うべきです。

# グループ別の記述統計表（p値なし）
data %>%
    tbl_summary(
        by = group,        # グループ化変数
        missing = "no"     # 欠損値の表示方法
    )

# より詳細な設定例
data %>%
    tbl_summary(
        by = group,
        statistic = list(
            all_continuous() ~ "{mean} ({sd})",
            all_categorical() ~ "{n} ({p}%)"
        ),
        digits = all_continuous() ~ 1,
        missing = "no"
    )
```

#### その他の基本統計

```R
# 基本的な統計量
summary(data)

# 個別の統計量の計算
mean(data$age)      # 平均値
sd(data$age)        # 標準偏差
median(data$age)    # 中央値
```

### 統計検定

```R
# t検定
t.test(data$value ~ data$group)

# 相関係数
cor.test(data$height, data$weight)
```

## 3.5 データ可視化（ggplot2パッケージ）

```R
library(ggplot2)

# ヒストグラム
ggplot(data, aes(x = age)) +
    geom_histogram()

# 散布図
ggplot(data, aes(x = height, y = weight)) +
    geom_point()

# 箱ひげ図
ggplot(data, aes(x = group, y = value)) +
    geom_boxplot()
```

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
