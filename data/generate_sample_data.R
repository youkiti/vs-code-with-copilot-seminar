# サンプルデータ生成スクリプト

# 必要なパッケージの読み込み
library(tidyverse)

# 乱数のシードを設定して再現性を確保
set.seed(123)

# サンプルサイズ
n <- 200

# データ生成
patient_data <- tibble(
  # 患者ID
  id = 1:n,
  
  # 基本属性
  age = round(rnorm(n, mean = 65, sd = 10)),  # 年齢
  sex = sample(c("男性", "女性"), n, replace = TRUE),  # 性別
  height = round(rnorm(n, mean = ifelse(sex == "男性", 170, 157), sd = 7), 1),  # 身長(cm)
  weight = round(rnorm(n, mean = ifelse(sex == "男性", 65, 52), sd = 10), 1),  # 体重(kg)
  
  # 生活習慣
  smoking = sample(c("なし", "過去", "現在"), n, replace = TRUE, prob = c(0.6, 0.2, 0.2)),  # 喫煙歴
  drinking = sample(c("なし", "時々", "毎日"), n, replace = TRUE),  # 飲酒
  exercise = sample(c("なし", "週1-2回", "週3回以上"), n, replace = TRUE),  # 運動習慣
  
  # 検査値
  sbp = round(rnorm(n, mean = 135, sd = 15)),  # 収縮期血圧
  dbp = round(rnorm(n, mean = 85, sd = 10)),   # 拡張期血圧
  hdl = round(rnorm(n, mean = 55, sd = 15)),   # HDLコレステロール
  ldl = round(rnorm(n, mean = 120, sd = 30)),  # LDLコレステロール
  hba1c = round(rnorm(n, mean = 6.2, sd = 1.0), 1),  # HbA1c
  
  # 疾患
  hypertension = sbp >= 140 | dbp >= 90,  # 高血圧
  diabetes = hba1c >= 6.5,  # 糖尿病
  dyslipidemia = hdl < 40 | ldl >= 140    # 脂質異常症
)

# BMIの計算と追加
patient_data <- patient_data %>%
  mutate(
    bmi = round(weight / ((height/100)^2), 1),  # BMI
    obesity = bmi >= 25  # 肥満
  )

# データの確認
summary(patient_data)

# CSVファイルとして保存
write.csv(patient_data, "data/patient_data.csv", row.names = FALSE)

# 基本的な記述統計
patient_data %>%
  tbl_summary(
    by = sex,
    statistic = list(
      all_continuous() ~ "{mean} ({sd})",
      all_categorical() ~ "{n} ({p}%)"
    ),
    digits = all_continuous() ~ 1
  )
