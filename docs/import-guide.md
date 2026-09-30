# 新手導入指南：把 learn-langs-skills 放進網頁版 AI App

給不熟悉程式的使用者。不需要寫任何程式碼，只要打包、上傳、開啟即可。

English version: [import-guide-en.md](import-guide-en.md)

> 各平台介面常更新。若畫面上的名稱與下方不同，請以官方說明為準（文末附連結）。
> 最後查證日期：2026-09-30。

---

## 第 0 步：取得 zip 檔

1. 在專案資料夾開啟終端機，執行：

   ```bash
   ./package.sh
   ```

2. 完成後，zip 會出現在 `dist/learn-langs-skills-日期時間.zip`。
3. 看到 `🎉 驗收通過` 就代表打包正確。

這個 zip 只包含 AI 需要讀的檔案（`SKILL.md`、`shared/`、`languages/`、`language-pairs/`、`skills/`）。
`README.md`、`README-en.md`、`docs/`（包含這份指南）與隱藏檔案不會被放進去。

zip 的最上層直接就是 `SKILL.md`，不多包一層資料夾。

---

## Gemini Spark

已於官方說明查證。

1. 開啟 [gemini.google.com](https://gemini.google.com)，使用**個人** Google 帳號（工作或學校帳號目前不支援）。
2. 點 **Settings（設定）→ Skills**。
3. 點上方的 **Upload（上傳）**。
4. 選擇剛才的 zip 檔，按 **Open**。
5. 檢查內容後，按上方的 **Create（建立）**。

注意：
- Skill 名稱必須是小寫加連字號，本專案是 `learn-langs-skills`，符合規定。
- 上傳大小上限 100 MB，本專案約 600 KB。
- 上傳失敗時，先確認 zip 裡沒有 `.DS_Store` 之類的隱藏檔。用 `package.sh` 打包的 zip 不會有。

---

## Claude Work

已於官方說明查證。

1. 開啟 [claude.ai](https://claude.ai)，登入。
2. 進入 **Customize（自訂）→ Skills**。
3. 點 **+**，選 **Create skill → Upload a skill**，選擇 zip 檔。
4. 上傳後，Skill 會出現在清單中。確認旁邊的開關是**開啟**狀態。
5. 在 Claude Work 中，已開啟的 Skill 會自動可用，也可以在側邊欄的 Customize 面板查看。

注意：
- 使用 Skills 需要先開啟 **code execution（程式碼執行）**。
- 官方說明沒有明講 zip 最上層是否要多包一層資料夾。若上傳被拒，請告訴 Claude Code：「把 zip 改成最上層有 `learn-langs-skills/` 資料夾再打包」。

---

## Codex Work（ChatGPT 網頁版）

上傳入口由使用者實際確認，官方文件沒有寫到；下方按鈕名稱可能與實際畫面略有出入。

1. 登入 ChatGPT 後，開啟 [chatgpt.com/skills](https://chatgpt.com/skills)。
2. 找到上傳（Upload）相關的按鈕，選擇 zip 檔。
3. 上傳後，確認 Skill 已啟用。

若上傳失敗或找不到按鈕，可改用以下方式：

- 在對話中輸入 `@skill-creator`，請它建立 Skill，並貼上 `SKILL.md` 的內容。
- 使用 Codex CLI 或桌面 App 的人，可把整個專案資料夾放到 `~/.agents/skills/learn-langs-skills/`，重新開啟即可自動偵測。

---

## 如何確認導入成功

新開一個對話，輸入：

```text
請用 learn-langs-skills 帶我學葡萄牙語（歐洲葡語），我是 A1 程式小白，母語是繁體中文。
```

成功的話，AI 會：

- 用繁體中文解釋，
- 只給少量新句子，
- 要你先回答，再給修正。

如果 AI 沒有照這樣做，回到 Skills 設定頁，確認開關已開啟，並開一個新的對話再試一次。

---

## 常見問題

**Q：修改了檔案，平台上會自動更新嗎？**
不會。重新執行 `./package.sh`，再上傳新的 zip。平台若不允許覆蓋，請先刪掉舊版再上傳。

**Q：Gemini、Claude 和 Codex 可以共用同一個 zip 嗎？**
可以，格式都是 `SKILL.md` 加參考檔案。

**Q：目前有哪些等級可以用？**
共用政策已有 A1–C2（`shared/cefr/`）。哪些語言與等級已有專屬設定，請看 [README 的「里程碑」](../README.md)。沒有專屬設定的等級，會使用共用政策作為備援。

---

## 官方說明連結

- Gemini：[Create and manage skills for Gemini Apps](https://support.google.com/gemini/answer/17094296)
- Claude：[Use skills in Claude](https://support.claude.com/en/articles/12512180-use-skills-in-claude)
- Codex／ChatGPT：[Build skills](https://learn.chatgpt.com/docs/build-skills)
