# learn-langs-skills

模組化的多語言學習 AI skill：共用教學法 + CEFR 等級 + 語言規則 + 雙向學習流程。

English version: [README-en.md](README-en.md)

---

## 概覽

將教學行為拆成獨立、可重用的層級，新增語言、學習方向或 CEFR 等級時不必複製整套系統。

### 里程碑

| 組態 | 狀態 | 已有 | 尚缺 |
| --- | --- | --- | --- |
| `zh-TW → pt-PT`，A1 | 已完成 | 目標語言、語言對、方向＋等級 | — |
| `zh-TW → en-US`，B2 | 已完成 | 目標語言、語言對、方向＋等級 | — |
| `zh-TW → de-DE`，B1 | 已完成 | 目標語言、語言對、方向＋等級 | — |

共用的 CEFR 政策（A1–C2）已就緒，其餘組態尚未排定。

---

## 使用方式

根目錄的 `SKILL.md` 是進入點；將整個儲存庫放到 AI agent 讀取 skill 的位置即可。
tutor 會從對話判斷學習組態，若該組態尚無專屬檔案，則保守地改用共用政策（見「擴充與貢獻」的常見問題）。

不熟悉程式？請看 [新手導入指南](docs/import-guide.md)，內含 Gemini Spark、Claude Work、Codex Work 的上傳步驟。
執行 `./package.sh` 會在 `dist/` 產生 zip；README 與 `docs/` 不會被放進 zip。

---

## 架構

### 分層

```text
shared pedagogy + shared policies + CEFR policy
+ target language + language pair + direction/level policy
= tutor behavior
```

| 層級 | 位置 | 核心目的 |
| --- | --- | --- |
| 進入點 | `SKILL.md` | 判斷組態、導向參考檔、定義規則優先順序 |
| 教學法 | `shared/pedagogy/` | 與語言無關的教學行為：修正、回想、間隔複習、錯誤分類、學習流程 |
| CEFR 等級 | `shared/cefr/`（`a1.md`–`c2.md`） | 各等級的難度、鷹架、輸出量與每次練習的新內容量 |
| 共用政策 | `shared/policies/` | 來源忠實性、語言比較原則 |
| 目標語言 | `languages/<語言代碼>.md`（`pt-PT`、`en-US`、`de-DE`、`zh-TW`） | 該語言的文法、詞彙、發音與地區變體（如 PT-PT 與 PT-BR、en-US 與 en-GB） |
| 語言對 | `language-pairs/<A>__<B>.md` | 雙向結構對比與轉移風險 |
| 方向＋等級 | `skills/<方向>/<等級>/level-policy.md` | 解釋語言、課本或文本進度（依該 CEFR 等級的規定）、日期標題、今日重點 |

### 語言對 vs 方向＋等級

一句話：語言對講「這兩種語言哪裡不同」，方向＋等級講「這個學習者在這個階段該怎麼教」。

| | 語言對 | 方向＋等級 |
| --- | --- | --- |
| 性質 | 語言事實（描述） | 教學行為（規則） |
| 方向 | 雙向，共用一份 | 單向，每個方向各一套 |
| 等級 | 不分等級 | 每個等級各一份（`a1/`、`a2/`…） |
| 回答的問題 | 中文和葡語在冠詞、變位上差在哪？ | 這個學習者現在該怎麼教？ |

例如「中文沒有冠詞，容易漏寫」屬於語言對；「每組 2 句新對話、每次最多 2 組」屬於方向＋等級。

判斷方式：換方向或換等級後，這條內容還是對的，就放語言對；會改變，就放方向＋等級。
方向＋等級檔案會引用語言對，所以新增反向學習時不需要重寫語言事實。

### 規則優先順序

指示重疊時，由高到低（詳見 `SKILL.md` §5）：

```text
learner request > source fidelity > target-language correctness
> direction/level policy > CEFR policy > shared pedagogy > default behavior
```

---

## CEFR 等級概覽

`shared/cefr/` 各等級的每次練習設計（皆見各檔第 20 節）。時長是設計意圖，實際以互動回合數控管。

| 等級 | 時長 / 回合 | 輸入 | 每次練習內容 | 鷹架 | 重心 |
| --- | --- | --- | --- | --- | --- |
| [A1](shared/cefr/a1.md) | ~6 分 / 10–12 | 短句、短對話 | 2 個新句（上限 4）＋ 2 個複習項目 ＋ 1–2 個產出任務 | 強 | 核心句型的回想與重用 |
| [A2](shared/cefr/a2.md) | ~8 分 / 12–14 | 短對話、短訊息 | 4–6 個新句 ＋ 1–2 題回想 ＋ 2 個產出任務（受控 → 半受控） | 中等 | 簡單連貫語句 |
| [B1](shared/cefr/b1.md) | ~10 分 / 8–10 | 80–120 字短文 | 1 題理解 ＋ 2–3 句摘要 ＋ 1 句個人意見 | 輕度 | 理解並用自己的話輸出 |
| [B2](shared/cefr/b2.md) | ~6 分 / 5–7 | 120–180 字，有論點 | 找出作者主張 ＋ 改寫 ＋ 3–5 句回應 | 極少 | 論點分析與有理由的回應 |
| [C1](shared/cefr/c1.md) | ~6 分 / 4–6 | 150–250 字，含隱含語氣 | 單一聚焦任務：意圖、語域或語氣細微差異（三選一） | 極低 | 語氣、語域、精確度 |
| [C2](shared/cefr/c2.md) | ~6 分 / 4–6 | 200–300 字真實素材 | 單一高階任務：語氣轉換、語用判斷或精確改寫（三選一） | 近乎無 | 語用判斷與風格控制 |

規律：A1–A2 以句子與回想為主；B1 起以文本為中心；B2 起減少逐句文法練習；C1–C2 每次只做一件事。

---

## 目錄結構

```text
learn-langs-skills/
├── SKILL.md
├── README.md
├── README-en.md
├── LICENSE
├── package.sh
├── docs/
│   ├── import-guide.md
│   └── import-guide-en.md
├── shared/
│   ├── pedagogy/
│   │   ├── correction-policy.md
│   │   ├── retrieval-practice.md
│   │   ├── spaced-review.md
│   │   ├── error-taxonomy.md
│   │   └── session-flow.md
│   ├── cefr/
│   │   ├── a1.md
│   │   ├── a2.md
│   │   ├── b1.md
│   │   ├── b2.md
│   │   ├── c1.md
│   │   └── c2.md
│   └── policies/
│       ├── source-integrity.md
│       └── language-comparison.md
├── languages/
│   ├── pt-PT.md
│   ├── zh-TW.md
│   ├── en-US.md
│   └── de-DE.md
├── language-pairs/
│   ├── zh-TW__pt-PT.md
│   ├── zh-TW__en-US.md
│   └── zh-TW__de-DE.md
└── skills/
    ├── zh-TW-to-pt-PT/
    │   └── a1/
    │       └── level-policy.md
    ├── zh-TW-to-en-US/
    │   └── b2/
    │       └── level-policy.md
    └── zh-TW-to-de-DE/
        └── b1/
            └── level-policy.md
```

### 命名慣例

| 項目 | 格式 | 範例 |
| --- | --- | --- |
| 語言代碼 | locale 格式（需區分地區時） | `pt-PT`、`zh-TW`、`en-US` |
| 語言對 | `<language-A>__<language-B>.md`（雙向） | `zh-TW__pt-PT.md` |
| 學習方向 | `<support-language>-to-<target-language>` | `zh-TW-to-pt-PT` |
| CEFR 等級 | 小寫目錄與檔名 | `a1`、`a2`、`b1` |

---

## 擴充與貢獻

### 擴充方式

| 情境 | 新增 | 重用 |
| --- | --- | --- |
| 新增等級（`zh-TW → pt-PT` A1 → A2） | `skills/zh-TW-to-pt-PT/a2/level-policy.md` | `shared/cefr/a2.md`（已存在）、`shared/pedagogy/`、`shared/policies/`、`languages/pt-PT.md`、`language-pairs/zh-TW__pt-PT.md` |
| 新增目標語言（zh-TW → de-DE） | `languages/de-DE.md`<br>`language-pairs/zh-TW__de-DE.md`<br>`skills/zh-TW-to-de-DE/a1/level-policy.md` | `shared/`、`languages/zh-TW.md` |
| 新增反向學習（pt-PT → zh-TW） | `skills/pt-PT-to-zh-TW/a1/level-policy.md` | `shared/`、`languages/zh-TW.md`、`languages/pt-PT.md`、`language-pairs/zh-TW__pt-PT.md` |

只定義新層級真正改變的部分，不要複製既有檔案。

### 常見問題：缺少專屬設定時

**Q：如果我選的母語（支援語言）或學習語言不在 `skills/` 裡，會發生什麼事？**
仍然可以使用，但只會用到共用的部分，而且 AI 應該說明缺了哪些專屬檔案。目前有專屬設定的組態見「里程碑」。

| 情況 | 例子 | 會用到 | 缺少 |
| --- | --- | --- | --- |
| 組態存在，但等級沒有 | 繁中 → 葡語 B1 | 共用教學法、該等級的 CEFR 政策、`languages/`、`language-pairs/` | 方向＋等級專屬規則 |
| 學習語言有 `languages/` 檔，但母語不同 | 日語母語 → 葡語 | 共用教學法、CEFR 政策、`languages/pt-PT.md` | 語言對對照、方向＋等級專屬規則 |
| 學習語言沒有 `languages/` 檔 | 繁中 → 日語 | 共用教學法、CEFR 政策 | 目標語言規則、語言對對照、方向＋等級專屬規則 |
| 兩者都沒有 | 韓語母語 → 德語 | 同上 | 同上 |

後兩種情況下，沒有經過專案檢查的語言規則，AI 只能依自身的一般知識回答，穩定度會比有專屬設定的組態低。AI 不會虛構不存在的專屬規則，也不應宣稱已套用它沒有的檔案。

想讓某個組態有完整支援，請參考上方「擴充方式」。這些行為是寫在 `SKILL.md`（第 3、23 節）的規則，實際表現仍可能因平台與模型而異。

### 貢獻原則

- 每條規則只放在一個層級，依「架構」的分層表判斷歸屬。
- 不要為了架構完整而建立空的檔案或目錄，真正需要時才新增。

---

## 授權

本專案採用 [MIT License](LICENSE) 授權。
