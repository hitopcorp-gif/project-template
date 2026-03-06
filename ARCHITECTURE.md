# Architecture & Coding Standards

> **このファイルはプロジェクトの「憲法」です。**
> AI アシスタント (Claude 等) はこのファイルを会話の最初に読み込み、
> すべてのコード生成・レビュー時にここに記載されたルールを適用してください。

---

## 1. ファイルサイズ制限 (厳守)

| ファイル種別 | 警告 (warn) | エラー (error) |
|---|---|---|
| ページコンポーネント (`src/pages/**/*.tsx`) | 400行 | 600行 |
| UIコンポーネント (`src/components/**/*.tsx`) | 250行 | 400行 |
| フック (`src/hooks/**/*.ts`) | 200行 | 300行 |
| ユーティリティ (`src/utils/**/*.ts`) | 150行 | 250行 |
| 型定義 (`src/types/**/*.ts`) | 200行 | 400行 |
| テスト (`**/__tests__/**`) | 300行 | 500行 |

### 自動検出

- `pre-commit` フックでコミット時にチェック
- CI quality-gate でプッシュ時にチェック
- `npm run wave` で手動一括チェック

### ファイルが上限を超えたら

1. **即座に分割する** — 次のコミットまでに対応
2. 分割先は下記「コンポーネント分割ガイド」に従う
3. 分割後にテスト (`npm test`) とビルド (`npm run build`) を必ず通す

---

## 2. コンポーネント分割ガイド

### 分割の判断基準

- **関心の分離**: 1ファイル = 1つの責務
- **再利用可能性**: 2箇所以上で使うロジックは抽出
- **Props が 8個以上**: カスタムフックや Context で整理を検討
- **JSX が 100行以上のブロック**: 子コンポーネントに分割

### 分割パターン

```
[ページが大きい場合]
src/pages/admin/SomePage.tsx (メインロジック + レイアウト)
  -> src/components/some/SomeTable.tsx     (テーブル部分)
  -> src/components/some/SomeModal.tsx     (モーダル部分)
  -> src/components/some/SomeFilters.tsx   (フィルター部分)
  -> src/hooks/useSomeData.ts             (データ取得ロジック)

[フックが大きい場合]
src/hooks/useBigHook.ts
  -> src/hooks/useBigHook/index.ts        (メインフック)
  -> src/hooks/useBigHook/helpers.ts      (ヘルパー関数)
  -> src/hooks/useBigHook/types.ts        (型定義)
```

### 命名規則

- コンポーネント: PascalCase (`ExpenseTable.tsx`)
- フック: camelCase、`use` プレフィックス (`useExpenseData.ts`)
- ユーティリティ: camelCase (`formatCurrency.ts`)
- 型定義: PascalCase + `.types.ts` or `types/` ディレクトリ
- テスト: 対象ファイル名 + `.test.tsx` / `.test.ts`

---

## 3. ディレクトリ構造

```
src/
  pages/                    # ページコンポーネント (ルーティング単位)
    admin/                  # 管理者ページ
    __tests__/              # ページテスト
  components/               # UIコンポーネント
    common/                 # 汎用コンポーネント
    {feature}/              # 機能別コンポーネント
    __tests__/              # コンポーネントテスト
  hooks/                    # カスタムフック
    __tests__/              # フックテスト
  utils/                    # ユーティリティ関数
    __tests__/              # ユーティリティテスト
  types/                    # 型定義
  lib/                      # 外部サービス設定
  config/                   # アプリ設定
  styles/                   # グローバルスタイル
```

### 新しいコンポーネントの配置ルール

1. ページ固有なら `components/{feature}/` に配置
2. 2つ以上のページで使うなら `components/common/` に配置
3. データ取得ロジックは `hooks/` に分離
4. 型定義は `types/` に集約 (ただし小さい型はコンポーネント内でも可)

---

## 4. コーディングルール

### TypeScript

- `any` は原則禁止
- 明示的な戻り値型は省略可 (TypeScript の型推論に任せる)
- `interface` を基本とし、`type` は union/intersection で使用

### React

- 関数コンポーネントのみ使用 (クラスコンポーネント禁止)
- カスタムフックでロジックを分離
- `useMemo` / `useCallback` は計測してから適用 (過剰最適化しない)
- `React.memo` は子コンポーネントが重い場合のみ

### インポート順序

```typescript
// 1. React / ライブラリ
import { useState, useEffect } from 'react'
import { useNavigate } from 'react-router-dom'

// 2. 内部コンポーネント・フック
import { DataTable } from '../components/common/DataTable'
import { useDataFetch } from '../hooks/useDataFetch'

// 3. 型定義
import type { DataItem } from '../types'

// 4. ユーティリティ・定数
import { formatCurrency } from '../utils/format'
```

---

## 5. テスト規約

- ページ/コンポーネントに対しテストファイルを配置
- テスト名は日本語で可 (e.g., `it('ボタンを押すとAPIが呼ばれる')`)
- モックは `vi.mock()` で集約
- テストは `npm test` で全パス必須

---

## 6. パフォーマンス基準

| 指標 | 目標 |
|---|---|
| dist サイズ | < 3 MB |
| メインバンドル (gzip) | < 80 kB |
| ビルド時間 | < 15 秒 |
| テスト時間 | < 60 秒 |

---

## 7. 既知の技術的負債 (要改善リスト)

> ファイルサイズ上限を超えているファイル。次回改修時に対応すること。
> **新規プロジェクトではこのセクションは空。超過ファイルが出た場合にここに追記する。**

| ファイル | 現在行数 | 上限 | 対応方針 |
|---|---|---|---|
| _(なし)_ | - | - | - |

---

## 8. AI アシスタントへの指示

> **このセクションは AI (Claude 等) が参照するためのものです。**

### 会話の最初に行うこと

1. `RULES.md` を読む（最上位ルール）
2. `ARCHITECTURE.md` を読む (このファイル)
3. `PROJECT.md` を読む（プロジェクト固有設定）
4. 技術的負債リスト (セクション7) を把握する

### コードを書く/修正するとき

1. **ファイルサイズ上限を常に意識する** — 上限を超える変更は行わない
2. 新しい関数/コンポーネントの追加先を上記ルールに従って判断する
3. 変更後に `wc -l` でファイル行数を確認する
4. 上限を超えそうな場合は、先に分割してから機能を追加する

### 新機能を追加するとき

1. まず該当ページ/コンポーネントの行数を確認
2. 追加で 100行以上増える場合、先に分割計画を提示
3. 分割後に機能追加を実施

### push 前の必須作業

1. `npm test` — 全テストパス
2. `npm run build` — ビルド成功
3. `git push` 後に CI 結果を確認
4. CI 赤なら即修正、緑になるまで繰り返す
5. 完了報告に「CI: ✅ 緑」を含める

---

*テンプレートバージョン: 1.0.0*
*作成日: 2026-03-06*
