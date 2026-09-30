#!/usr/bin/env bash
# 打包 learn-langs-skills-[YYYY-MM-DD-HH-mm-ss].zip
# 僅收錄 INCLUDES 內的項目，並排除所有隱藏檔（.git/.claude/.DS_Store 等）
# README.md、README-en.md、docs/ 不在 INCLUDES 內，因此不會被打包
set -euo pipefail

cd "$(dirname "$0")"

INCLUDES=(SKILL.md language-pairs languages shared skills)
OUT_DIR="dist"
ZIP_NAME="learn-langs-skills-$(date +%Y-%m-%d-%H-%M-%S).zip"
ZIP_PATH="$OUT_DIR/$ZIP_NAME"

# ---- 打包前檢查 ----
for item in "${INCLUDES[@]}"; do
  [[ -e "$item" ]] || { echo "❌ 找不到必要項目：$item" >&2; exit 1; }
done

mkdir -p "$OUT_DIR"

# ---- 打包（排除任何路徑層級的隱藏檔／資料夾）----
zip -rq "$ZIP_PATH" "${INCLUDES[@]}" -x '*/.*' '.*'

# ---- 驗收 ----
fail=0
entries="$(zipinfo -1 "$ZIP_PATH")"

# 1. 頂層項目必須恰好等於 INCLUDES
actual_top="$(printf '%s\n' "$entries" | cut -d/ -f1 | sort -u)"
expected_top="$(printf '%s\n' "${INCLUDES[@]}" | sort -u)"
if [[ "$actual_top" == "$expected_top" ]]; then
  echo "✅ 頂層項目正確：$(echo $actual_top)"
else
  echo "❌ 頂層項目不符"; echo "  預期：$(echo $expected_top)"; echo "  實際：$(echo $actual_top)"; fail=1
fi

# 2. 不得含任何隱藏檔／資料夾
hidden="$(printf '%s\n' "$entries" | grep -E '(^|/)\.' || true)"
if [[ -z "$hidden" ]]; then
  echo "✅ 無隱藏檔案／資料夾"
else
  echo "❌ 含隱藏項目："; echo "$hidden"; fail=1
fi

# 3. 檔案清單需與磁碟上的非隱藏檔案完全一致
expected_files="$(find "${INCLUDES[@]}" -type f -not -path '*/.*' | sort)"
actual_files="$(printf '%s\n' "$entries" | grep -v '/$' | sort)"
if [[ "$expected_files" == "$actual_files" ]]; then
  echo "✅ 檔案清單與來源一致（$(echo "$actual_files" | wc -l | tr -d ' ') 個檔案）"
else
  echo "❌ 檔案清單與來源不一致"; diff <(echo "$expected_files") <(echo "$actual_files") || true; fail=1
fi

# 4. zip 完整性
if unzip -tq "$ZIP_PATH" >/dev/null; then
  echo "✅ zip 完整性檢查通過"
else
  echo "❌ zip 完整性檢查失敗"; fail=1
fi

if (( fail )); then
  echo "驗收失敗：$ZIP_PATH" >&2
  exit 1
fi
echo "🎉 驗收通過：$ZIP_PATH"
