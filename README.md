# learn-langs-skills

模組化的多語言學習 AI skill：共用教學法 + CEFR 等級 + 語言規則 + 雙向學習流程。

Modular AI skills for multilingual language learning: shared pedagogy + CEFR
levels + language rules + bidirectional learning workflows.

---

## 概覽 · Overview

將教學行為拆成獨立、可重用的層級，新增語言、學習方向或 CEFR 等級時不必複製整套系統。

Tutoring behavior is split into independent, reusable layers, so new languages,
directions, and CEFR levels can be added without duplicating the whole system.

目前實作 / Currently implemented：**`zh-TW → pt-PT`，CEFR A1**

---

## 使用方式 · Usage

根目錄的 `SKILL.md` 是進入點；將整個儲存庫放到 AI agent 讀取 skill 的位置即可。
tutor 會從對話判斷學習組態，若該組態尚無專屬檔案，則保守地改用共用政策。

`SKILL.md` is the entry point; place the whole repository where your AI agent
loads skills. The tutor infers the configuration from the conversation and
falls back to shared policies when no dedicated files exist.

---

## 架構分層 · Architecture

```text
shared pedagogy + shared policies + CEFR policy
+ target language + language pair + direction/level policy
= tutor behavior
```

| 層級 · Layer | 位置 · Location | 核心目的 · Purpose |
| --- | --- | --- |
| 進入點<br>Entry point | `SKILL.md` | 判斷組態、導向參考檔、定義規則優先順序<br>Detect configuration, route to references, define rule priority |
| 教學法<br>Pedagogy | `shared/pedagogy/` | 與語言無關的教學行為：修正、回想、間隔複習、錯誤分類、學習流程<br>Language-independent teaching: correction, retrieval, spaced review, error taxonomy, session flow |
| CEFR 等級<br>CEFR level | `shared/cefr/a1.md` | 各等級的難度、鷹架與輸出量<br>Difficulty, scaffolding, and output size per level |
| 共用政策<br>Policies | `shared/policies/` | 來源忠實性、語言比較原則<br>Source integrity, language-comparison rules |
| 目標語言<br>Target language | `languages/pt-PT.md` | PT-PT 文法、詞彙、發音，並與 PT-BR 區隔<br>PT-PT grammar, vocabulary, pronunciation; PT-BR guardrails |
| 語言對<br>Language pair | `language-pairs/zh-TW__pt-PT.md` | 雙向結構對比與轉移風險<br>Bidirectional contrasts and transfer risks |
| 方向＋等級<br>Direction + level | `skills/zh-TW-to-pt-PT/a1/level-policy.md` | 解釋語言、課本進度（每日最多 4 句新對話）、日期標題、今日重點<br>Explanation language, textbook pacing (max 4 new lines/day), date header, recap |

---

## 目錄結構 · Repository Structure

```text
learn-langs-skills/
├── SKILL.md
├── README.md
├── LICENSE
├── shared/
│   ├── pedagogy/
│   │   ├── correction-policy.md
│   │   ├── retrieval-practice.md
│   │   ├── spaced-review.md
│   │   ├── error-taxonomy.md
│   │   └── session-flow.md
│   ├── cefr/
│   │   └── a1.md
│   └── policies/
│       ├── source-integrity.md
│       └── language-comparison.md
├── languages/
│   └── pt-PT.md
├── language-pairs/
│   └── zh-TW__pt-PT.md
└── skills/
    └── zh-TW-to-pt-PT/
        └── a1/
            └── level-policy.md
```

---

## 規則優先順序 · Rule Priority

指示重疊時，由高到低（詳見 `SKILL.md` §5）：

When instructions overlap, from highest to lowest (see `SKILL.md` §5):

```text
learner request > source fidelity > target-language correctness
> direction/level policy > CEFR policy > shared pedagogy > default behavior
```

---

## 擴充方式 · Extending

| 情境 · Scenario | 新增 · Add | 重用 · Reuse |
| --- | --- | --- |
| 新增等級（A1 → A2）<br>New CEFR level | `shared/cefr/a2.md`<br>`skills/zh-TW-to-pt-PT/a2/level-policy.md` | `shared/pedagogy/`、`shared/policies/`、`languages/pt-PT.md`、`language-pairs/zh-TW__pt-PT.md` |
| 新增目標語言（zh-TW → de-DE）<br>New target language | `languages/de-DE.md`<br>`language-pairs/zh-TW__de-DE.md`<br>`skills/zh-TW-to-de-DE/a1/level-policy.md` | `shared/` |
| 新增反向學習（pt-PT → zh-TW）<br>Reverse direction | `languages/zh-TW.md`<br>`skills/pt-PT-to-zh-TW/a1/level-policy.md` | `shared/`、`language-pairs/zh-TW__pt-PT.md` |

只定義新層級真正改變的部分，不要複製既有檔案。

Only define what actually changes; never copy existing files.

---

## 命名慣例 · Naming Conventions

| 項目 · Item | 格式 · Format | 範例 · Example |
| --- | --- | --- |
| 語言代碼<br>Language code | locale 格式（需區分地區時）<br>locale style when variety matters | `pt-PT`、`zh-TW`、`de-DE` |
| 語言對<br>Language pair | `<language-A>__<language-B>.md`（雙向 / bidirectional） | `zh-TW__pt-PT.md` |
| 學習方向<br>Direction | `<support-language>-to-<target-language>` | `zh-TW-to-pt-PT` |
| CEFR 等級<br>CEFR level | 小寫目錄與檔名<br>lowercase dirs and files | `a1`、`a2`、`b1` |

---

## 貢獻原則 · Contributing

- 每條規則只放在一個層級，依上方「架構分層」表判斷歸屬。
  Each rule lives in exactly one layer — use the Architecture table to decide.
- 不要為了架構完整而建立空的檔案或目錄，真正需要時才新增。
  Don't create empty files or directories for completeness; add them only when needed.

---

## 授權 · License

本專案採用 [MIT License](LICENSE) 授權。

This project is licensed under the [MIT License](LICENSE).
