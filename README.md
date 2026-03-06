# {{PROJECT_NAME}}

## Project Overview

> **このプロジェクトのルール・アーキテクチャ:**
> - `RULES.md` — 開発絶対ルール（最上位）
> - `ARCHITECTURE.md` — コード構造・行数制限・分割ガイド
> - `PROJECT.md` — プロジェクト固有設定（作成後に追記）

---

## Quick Start

```bash
# 1. テンプレートをコピー
cp -r project-template/ my-new-project/
cd my-new-project/

# 2. 初期セットアップ
npm install

# 3. Git 初期化
git init
git config core.hooksPath .githooks
git add .
git commit -m "Initial commit from project-template"

# 4. 開発開始
npm run dev
```

---

## テンプレート構造

```
project-template/
├── RULES.md                           # 開発絶対ルール（共通）
├── ARCHITECTURE.md                    # コード構造・行数制限
├── PROJECT.md                         # プロジェクト固有設定（要編集）
├── README.md                          # このファイル
├── .github/
│   └── workflows/
│       └── quality-gate.yml           # CI 品質ゲート（9項目自動チェック）
├── .githooks/
│   └── pre-commit                     # コミット時行数チェック
├── scripts/
│   └── wave-check.sh                  # Wave チェックリスト
├── src/
│   ├── components/
│   │   └── common/                    # 汎用UIコンポーネント
│   ├── hooks/                         # カスタムフック
│   ├── utils/                         # ユーティリティ関数
│   ├── types/                         # 型定義
│   │   └── index.ts                   # 基本型定義テンプレート
│   ├── pages/                         # ページコンポーネント
│   ├── lib/                           # 外部サービス設定
│   ├── config/                        # アプリ設定
│   ├── styles/                        # グローバルスタイル
│   └── __tests__/
│       ├── setup.ts                   # テストセットアップ
│       └── smoke.test.ts              # スモークテスト
├── public/
│   └── static/                        # 静的ファイル
├── package.json                       # 依存関係・スクリプト
├── tsconfig.json                      # TypeScript 設定
├── tsconfig.app.json                  # アプリ用 TS 設定
├── tsconfig.node.json                 # Node 用 TS 設定
├── vite.config.ts                     # Vite 設定
├── vitest.config.ts                   # Vitest 設定
├── ecosystem.config.cjs               # PM2 設定
├── .gitignore                         # Git 除外設定
└── .dev.vars                          # ローカル環境変数（Git除外）
```

---

## NPM Scripts

| コマンド | 説明 |
|---|---|
| `npm run dev` | 開発サーバー起動 (Vite) |
| `npm run build` | 本番ビルド |
| `npm test` | テスト実行 |
| `npm run lint` | ESLint チェック |
| `npm run wave` | Wave チェックリスト（全項目一括チェック） |
| `npm run check:filesize` | ファイル行数チェック |
| `npm run deploy` | Cloudflare Pages デプロイ |

---

## 新規プロジェクトでやること

### 1. テンプレートコピー後

- [ ] `PROJECT.md` を作成（プロジェクト名・概要・DB・外部サービス）
- [ ] `package.json` の `name` を変更
- [ ] `ecosystem.config.cjs` の `name` を変更
- [ ] GitHub リポジトリ作成・push
- [ ] Cloudflare Pages プロジェクト作成

### 2. 開発中

- [ ] CI (quality-gate.yml) が緑であることを確認
- [ ] 3機能以上の実装後に `npm run wave` を実行
- [ ] 技術的負債が出たら `ARCHITECTURE.md` セクション7 に追記

### 3. デプロイ

- [ ] `npm run build` 成功
- [ ] `npm test` 全パス
- [ ] CI 緑
- [ ] `npm run deploy`

---

## CI 品質ゲート (9項目)

| # | チェック | 失敗時の対応 |
|---|---|---|
| 1 | ファイル行数制限 | ARCHITECTURE.md に従い分割 |
| 2 | TypeScript 型チェック | 型エラーを修正 |
| 3 | `any` 型の禁止 | 具体的な型を指定 |
| 4 | `console.log` 禁止 | `console.error` か削除 |
| 5 | API キー検出 | 環境変数に移行 |
| 6 | テスト存在チェック | テストファイルを作成 |
| 7 | テスト実行 | 失敗テストを修正 |
| 8 | 浮動小数点金額計算 | 整数 + Math.floor に変更 |
| 9 | ビルド | ビルドエラーを修正 |

---

## Wave プロセス

3機能以上の実装後、`npm run wave` を実行:

```bash
npm run wave
# → 全8項目を自動チェック
# → エラーがあれば修正してからコミット
# → コミットメッセージ: [Wave A] feat: ...
```

---

*テンプレートバージョン: 1.0.0*
*作成日: 2026-03-06*
