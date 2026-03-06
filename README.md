# AI ライブコーディングOS — プロジェクト共通テンプレート

## これは何？

**田中貴大のプロジェクト開発における「憲法」と「自動品質管理」を1つにまとめたテンプレート。**

たかひろさんが「〇〇を作って」と指示するだけで、AIがこのテンプレートを使って：
- コード品質を自動で維持
- 行数制限を自動で監視
- テストを自動で作成・実行
- CI で push ごとに9項目チェック
- 緑になるまで自動で修正

**たかひろさんの手作業: ゼロ。**

---

## AI アシスタントへの指示（最重要）

### 新規プロジェクト開始時の手順

たかひろさんから「〇〇を作って」と指示が来たら、以下を**すべて自動で**実行すること:

1. **このテンプレートリポジトリをクローン**
   ```bash
   git clone https://github.com/hitopcorp-gif/project-template.git {project-name}
   cd {project-name}
   rm -rf .git
   ```

2. **プロジェクト固有設定を自動生成**
   - `PROJECT.md` — プロジェクト名・概要・DB・外部サービスを記入
   - `package.json` — `name` を変更
   - `ecosystem.config.cjs` — `name` を変更
   - `README.md` — プロジェクト固有の README に書き換え

3. **Git 初期化 → GitHub リポジトリ作成 → push**
   ```bash
   git init
   git config core.hooksPath .githooks
   git add -A
   git commit -m "feat: {project-name} 初期セットアップ from project-template"
   # GitHub リポジトリ作成 → push
   ```

4. **CI 緑を確認してから開発開始**

5. **RULES.md を読んでから作業開始（読み飛ばし禁止）**

### セッション開始時

1. `RULES.md` を読む
2. `ARCHITECTURE.md` を読む
3. `PROJECT.md` を読む
4. CI の最新状態を確認

### push 前の必須作業

1. `npm test` — 全テストパス
2. `npm run build` — ビルド成功
3. `git push` → CI 結果を確認
4. **CI 赤なら即修正、緑になるまで繰り返す**
5. 完了報告に「CI: ✅ 緑」を含める

---

## テンプレート構造

```
project-template/
├── RULES.md                   # 開発絶対ルール（12セクション）
├── ARCHITECTURE.md            # コード構造・行数制限・分割ガイド
├── PROJECT.md                 # プロジェクト固有設定（AI が自動記入）
├── .github/workflows/
│   └── quality-gate.yml       # CI 品質ゲート（9項目自動チェック）
├── .githooks/
│   └── pre-commit             # コミット時行数制限チェック
├── scripts/
│   └── wave-check.sh          # Wave 一括品質検証
├── src/
│   ├── components/common/     # 汎用UIコンポーネント
│   ├── hooks/                 # カスタムフック
│   ├── utils/                 # ユーティリティ関数
│   ├── types/index.ts         # 型定義テンプレート
│   ├── pages/                 # ページコンポーネント
│   ├── lib/                   # 外部サービス設定
│   ├── config/                # アプリ設定
│   ├── styles/index.css       # Tailwind CSS エントリー
│   └── __tests__/
│       ├── setup.ts           # テストセットアップ
│       └── smoke.test.ts      # スモークテスト
├── package.json               # React 19 + Vite + Vitest + Tailwind v4
├── vite.config.ts             # Vite 設定
├── vitest.config.ts           # Vitest 設定
├── ecosystem.config.cjs       # PM2 設定
└── .gitignore                 # Git 除外設定
```

---

## CI 品質ゲート（9項目）

push / PR ごとに自動実行:

| # | チェック | 失敗時 |
|---|---|---|
| 1 | ファイル行数制限 | 分割する |
| 2 | TypeScript 型チェック | 型エラー修正 |
| 3 | `any` 型の禁止 | 具体型を指定 |
| 4 | `console.log` 禁止 | 削除 |
| 5 | API キー検出 | 環境変数に移行 |
| 6 | テスト存在チェック | テスト作成 |
| 7 | テスト実行 | 失敗テスト修正 |
| 8 | 浮動小数点金額計算 | 整数 + Math.floor |
| 9 | ビルド | エラー修正 |

---

## NPM Scripts

| コマンド | 説明 |
|---|---|
| `npm run dev` | 開発サーバー起動 |
| `npm run build` | 本番ビルド |
| `npm test` | テスト実行 |
| `npm run wave` | Wave 一括品質検証 |
| `npm run check:filesize` | ファイル行数チェック |
| `npm run deploy` | Cloudflare Pages デプロイ |

---

## 技術スタック

| レイヤー | 技術 |
|---|---|
| フロントエンド | React 19, TypeScript, Tailwind CSS v4 |
| アイコン | Lucide React |
| ルーティング | React Router v7 |
| CI/CD | GitHub Actions (quality-gate.yml) |
| テスト | Vitest + Testing Library |
| ビルド | Vite |
| ホスティング | Cloudflare Pages |

---

*テンプレートバージョン: 1.0.0*
*作成日: 2026-03-06*
*GitHub: https://github.com/hitopcorp-gif/project-template*
