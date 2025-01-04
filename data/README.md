# サンプルデータの説明

このディレクトリには、R言語学習用のサンプルデータが含まれています。

## patient_data.csv

架空の患者データセットです。生活習慣病に関する基本的な分析練習に使用できます。

### 変数の説明

#### 基本属性
- `id`: 患者ID（1から連番）
- `age`: 年齢（歳）
- `sex`: 性別（"男性" / "女性"）
- `height`: 身長（cm）
- `weight`: 体重（kg）
- `bmi`: Body Mass Index（kg/m²）

#### 生活習慣
- `smoking`: 喫煙歴（"なし" / "過去" / "現在"）
- `drinking`: 飲酒習慣（"なし" / "時々" / "毎日"）
- `exercise`: 運動習慣（"なし" / "週1-2回" / "週3回以上"）

#### 検査値
- `sbp`: 収縮期血圧（mmHg）
- `dbp`: 拡張期血圧（mmHg）
- `hdl`: HDLコレステロール（mg/dL）
- `ldl`: LDLコレステロール（mg/dL）
- `hba1c`: HbA1c（%）

#### 疾患の有無（TRUE/FALSE）
- `hypertension`: 高血圧（sbp ≥ 140 または dbp ≥ 90）
- `diabetes`: 糖尿病（hba1c ≥ 6.5）
- `dyslipidemia`: 脂質異常症（hdl < 40 または ldl ≥ 140）
- `obesity`: 肥満（bmi ≥ 25）

### データの特徴
- サンプルサイズ: 200名
- 年齢層: 平均65歳前後（SD=10）の中高年者集団
- 性別: 男女がほぼ同数
- 疾患の定義は一般的な診断基準に基づく

### 想定される分析例

1. 基本的な記述統計
   - 年齢・性別分布
   - 各検査値の要約統計量
   - 各疾患の有病率

2. グループ比較
   - 性別による各指標の比較
   - 生活習慣と疾患の関連
   - 年齢層別の有病率比較

3. 相関分析
   - BMIと血圧の関連
   - 各検査値間の相関
   - 年齢と各指標の関連

4. リスク因子分析
   - 生活習慣と疾患の関連（ロジスティック回帰）
   - 複数の要因を考慮した多変量解析

### データの生成方法

データは `generate_sample_data.R` スクリプトで生成されています。乱数のシードを設定しているため、スクリプトを実行すれば同じデータセットが再現できます。

### データのダウンロード方法

以下のいずれかの方法でサンプルデータをダウンロードできます：

#### 方法1: Rを使用してダウンロード

```R
# GitHubから直接データを読み込む
data <- read.csv("https://raw.githubusercontent.com/vscodejp/vs-code-with-copilot-seminar/main/data/patient_data.csv")

# ローカルに保存する場合
download.file(
  "https://raw.githubusercontent.com/vscodejp/vs-code-with-copilot-seminar/main/data/patient_data.csv",
  "patient_data.csv"
)
```

#### 方法2: 直接ダウンロード

1. GitHubリポジトリの[data/patient_data.csv](https://github.com/vscodejp/vs-code-with-copilot-seminar/blob/main/data/patient_data.csv)にアクセス
2. 「Raw」ボタンをクリック
3. 表示されたページを「名前を付けて保存」

### 注意事項

- このデータは教育目的で作成された架空のデータです
- 実際の臨床データとは分布や関連性が異なる可能性があります
- 分析結果の解釈は、教育的な文脈で行ってください
