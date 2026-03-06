#!/bin/bash
# ============================================================
# Wave チェックリスト — RULES.md セクション10 準拠
#
# 使い方: npm run wave
# 3機能以上または大型機能の後に実行すること
# ============================================================

set -e
echo ""
echo "🌊 Wave チェックリスト実行中..."
echo "=================================="
echo ""

ERRORS=0
WARNINGS=0

# ── 1. RULES.md 存在確認 ──
echo "📋 1. RULES.md 確認"
if [ -f "RULES.md" ]; then
  echo "   ✅ RULES.md 存在"
else
  echo "   ❌ RULES.md が見つかりません"
  ERRORS=$((ERRORS + 1))
fi

# ── 2. ファイル行数チェック ──
echo ""
echo "📏 2. ファイル行数チェック"
if [ -f ".githooks/pre-commit" ]; then
  bash .githooks/pre-commit 2>/dev/null && echo "   ✅ 全ファイル制限内" || {
    echo "   ⚠️  行数超過ファイルあり（技術的負債を含む）"
    WARNINGS=$((WARNINGS + 1))
  }
else
  echo "   ⚠️  pre-commit フック未設定"
  WARNINGS=$((WARNINGS + 1))
fi

# ── 3. テスト実行 ──
echo ""
echo "🧪 3. テスト実行"
npx vitest run --reporter=verbose 2>&1 | tail -5
if [ ${PIPESTATUS[0]} -eq 0 ]; then
  echo "   ✅ テスト全パス"
else
  echo "   ❌ テスト失敗"
  ERRORS=$((ERRORS + 1))
fi

# ── 4. TypeScript 型チェック ──
echo ""
echo "🔍 4. TypeScript 型チェック"
npx tsc --noEmit 2>&1 && echo "   ✅ 型エラーなし" || {
  echo "   ❌ 型エラーあり"
  ERRORS=$((ERRORS + 1))
}

# ── 5. console.log 検出 ──
echo ""
echo "🔇 5. console.log / debugger チェック"
CONSOLE_HITS=$(grep -rn 'console\.\(log\|info\|debug\)\|debugger' src/ \
  --include='*.ts' --include='*.tsx' \
  | grep -v '__tests__/' | grep -v '.test.' | grep -v '// keep' || true)
if [ -n "$CONSOLE_HITS" ]; then
  echo "$CONSOLE_HITS" | head -10
  COUNT=$(echo "$CONSOLE_HITS" | wc -l)
  echo "   ⚠️  $COUNT 箇所の console/debugger"
  WARNINGS=$((WARNINGS + 1))
else
  echo "   ✅ 検出なし"
fi

# ── 6. API キー ハードコード検出 ──
echo ""
echo "🔐 6. API キー ハードコード検出"
KEY_HITS=$(grep -rn 'AIza[A-Za-z0-9_-]\{30,\}\|sk-[A-Za-z0-9]\{40,\}' src/ \
  --include='*.ts' --include='*.tsx' \
  | grep -v '__tests__/' | grep -v '.test.' || true)
if [ -n "$KEY_HITS" ]; then
  echo "$KEY_HITS"
  echo "   ❌ ハードコード API キー検出"
  ERRORS=$((ERRORS + 1))
else
  echo "   ✅ 検出なし"
fi

# ── 7. ビルド ──
echo ""
echo "🏗️  7. ビルド"
npm run build 2>&1 | tail -3
if [ ${PIPESTATUS[0]} -eq 0 ]; then
  echo "   ✅ ビルド成功"
else
  echo "   ❌ ビルド失敗"
  ERRORS=$((ERRORS + 1))
fi

# ── 8. バンドルサイズ ──
echo ""
echo "📦 8. バンドルサイズ"
DIST_SIZE=$(du -sh dist/ 2>/dev/null | cut -f1)
if [ -n "$DIST_SIZE" ]; then
  echo "   dist/ サイズ: $DIST_SIZE"
else
  echo "   ⚠️  dist/ が見つかりません"
fi

# ── 結果サマリー ──
echo ""
echo "=================================="
echo "🌊 Wave チェック完了"
echo "   エラー: $ERRORS"
echo "   警告: $WARNINGS"
echo ""

if [ "$ERRORS" -gt 0 ]; then
  echo "❌ エラーを解消してからコミットしてください"
  exit 1
fi

if [ "$WARNINGS" -gt 0 ]; then
  echo "⚠️  警告あり。確認の上コミット可"
else
  echo "✅ 全チェックパス！コミット可"
fi
echo ""
echo "💡 コミット時は [Wave X] を含めてください"
echo "   例: git commit -m '[Wave A] feat: ユーザー管理画面追加'"
