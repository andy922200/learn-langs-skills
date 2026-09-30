# learn-langs-skills

Modular AI skills for multilingual language learning: shared pedagogy + CEFR
levels + language rules + bidirectional learning workflows.

中文版：[README.md](README.md)

---

## Overview

Tutoring behavior is split into independent, reusable layers, so new languages,
directions, and CEFR levels can be added without duplicating the whole system.

### Milestones

| Configuration | Status | Available | Missing |
| --- | --- | --- | --- |
| `zh-TW → pt-PT`, A1 | Done | Target language, language pair, direction + level | — |
| `zh-TW → en-US`, B2 | Done | Target language, language pair, direction + level | — |

The shared CEFR policies (A1–C2) are in place; no other configurations are scheduled yet.

---

## Usage

`SKILL.md` is the entry point; place the whole repository where your AI agent
loads skills. The tutor infers the configuration from the conversation and
falls back to shared policies when no dedicated files exist (see the FAQ under
"Extending and Contributing").

New to coding? See the [beginner import guide](docs/import-guide-en.md) for
Gemini Spark, Claude Work, and Codex Work.
Run `./package.sh` to build a zip in `dist/`; the READMEs and `docs/` are not
included in the zip.

---

## Architecture

### Layers

```text
shared pedagogy + shared policies + CEFR policy
+ target language + language pair + direction/level policy
= tutor behavior
```

| Layer | Location | Purpose |
| --- | --- | --- |
| Entry point | `SKILL.md` | Detect configuration, route to references, define rule priority |
| Pedagogy | `shared/pedagogy/` | Language-independent teaching: correction, retrieval, spaced review, error taxonomy, session flow |
| CEFR level | `shared/cefr/` (`a1.md`–`c2.md`) | Difficulty, scaffolding, output size, and amount of new material per session, per level |
| Policies | `shared/policies/` | Source integrity, language-comparison rules |
| Target language | `languages/<language-code>.md` (`pt-PT`, `en-US`, `zh-TW`) | Grammar, vocabulary, pronunciation, and regional-variety guardrails (e.g. PT-PT vs PT-BR, en-US vs en-GB) |
| Language pair | `language-pairs/<A>__<B>.md` | Bidirectional contrasts and transfer risks |
| Direction + level | `skills/<direction>/<level>/level-policy.md` | Explanation language, textbook or text pacing (per the CEFR level policy), date header, recap |

### Language pair vs direction + level

In one sentence: the language pair says "how the two languages differ"; direction + level says "how to teach this learner at this stage".

| | Language pair | Direction + level |
| --- | --- | --- |
| Nature | Language facts (descriptive) | Teaching behavior (rules) |
| Direction | Bidirectional, one shared file | One direction only, one set per direction |
| Level | Not level-specific | One file per level (`a1/`, `a2/`, …) |
| Answers | How do Chinese and Portuguese differ in articles and conjugation? | How should this learner be taught right now? |

For example, "Chinese has no articles, so learners tend to omit them" belongs in the language pair; "2 new dialogue sentences per group, at most 2 groups per session" belongs in direction + level. A quick test: if the statement stays true when the direction or level changes, put it in the language pair; if it would change, put it in direction + level.

Direction + level files refer to the language pair, so adding a reverse direction does not require rewriting the language facts.

### Rule priority

When instructions overlap, from highest to lowest (see `SKILL.md` §5):

```text
learner request > source fidelity > target-language correctness
> direction/level policy > CEFR policy > shared pedagogy > default behavior
```

---

## CEFR Level Overview

Per-session design for each level in `shared/cefr/` (see Section 20 of each
file). Time is a design intention; sessions are enforced by interaction rounds.

| Level | Time / Rounds | Input | Session content | Scaffolding | Focus |
| --- | --- | --- | --- | --- | --- |
| [A1](shared/cefr/a1.md) | ~6 min / 10–12 | Short sentences and dialogues | 2 new sentences (max 4) + 2 review items + 1–2 production tasks | Strong | Retrieval and reuse of core patterns |
| [A2](shared/cefr/a2.md) | ~8 min / 12–14 | Short dialogues and messages | 4–6 new sentences + 1–2 retrieval questions + 2 production tasks (controlled → semi-controlled) | Moderate | Connected simple language |
| [B1](shared/cefr/b1.md) | ~10 min / 8–10 | 80–120-word text | 1 comprehension question + 2–3-sentence summary + 1 opinion sentence | Light | Understand and restate in own words |
| [B2](shared/cefr/b2.md) | ~6 min / 5–7 | 120–180 words with an argument | Identify claim + paraphrase + 3–5-sentence response | Minimal | Argument analysis and reasoned response |
| [C1](shared/cefr/c1.md) | ~6 min / 4–6 | 150–250 words with implicit tone | One focused task: intent, register, or nuance (pick one) | Very little | Nuance, register, precision |
| [C2](shared/cefr/c2.md) | ~6 min / 4–6 | 200–300 words of authentic material | One high-level task: tone shift, pragmatic judgment, or precise rewrite (pick one) | Near zero | Pragmatic judgment and stylistic control |

Pattern: A1–A2 center on sentences and retrieval; from B1 the session centers
on a text; from B2 sentence-level grammar drills are reduced; at C1–C2 each
session does one thing only.

---

## Repository Structure

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
│   └── en-US.md
├── language-pairs/
│   ├── zh-TW__pt-PT.md
│   └── zh-TW__en-US.md
└── skills/
    ├── zh-TW-to-pt-PT/
    │   └── a1/
    │       └── level-policy.md
    └── zh-TW-to-en-US/
        └── b2/
            └── level-policy.md
```

### Naming Conventions

| Item | Format | Example |
| --- | --- | --- |
| Language code | locale style when variety matters | `pt-PT`, `zh-TW`, `en-US` |
| Language pair | `<language-A>__<language-B>.md` (bidirectional) | `zh-TW__pt-PT.md` |
| Direction | `<support-language>-to-<target-language>` | `zh-TW-to-pt-PT` |
| CEFR level | lowercase dirs and files | `a1`, `a2`, `b1` |

---

## Extending and Contributing

### Extending

| Scenario | Add | Reuse |
| --- | --- | --- |
| New CEFR level (`zh-TW → pt-PT` A1 → A2) | `skills/zh-TW-to-pt-PT/a2/level-policy.md` | `shared/cefr/a2.md` (already exists), `shared/pedagogy/`, `shared/policies/`, `languages/pt-PT.md`, `language-pairs/zh-TW__pt-PT.md` |
| New target language (zh-TW → de-DE) | `languages/de-DE.md`<br>`language-pairs/zh-TW__de-DE.md`<br>`skills/zh-TW-to-de-DE/a1/level-policy.md` | `shared/`, `languages/zh-TW.md` |
| Reverse direction (pt-PT → zh-TW) | `skills/pt-PT-to-zh-TW/a1/level-policy.md` | `shared/`, `languages/zh-TW.md`, `languages/pt-PT.md`, `language-pairs/zh-TW__pt-PT.md` |

Only define what actually changes; never copy existing files.

### FAQ: when dedicated setup is missing

**Q: What happens if my native (support) language or my target language is not in `skills/`?**
You can still use it, but only the shared parts apply, and the AI should say which dedicated files are missing. See "Milestones" for the configurations with dedicated setups.

| Situation | Example | Used | Missing |
| --- | --- | --- | --- |
| The configuration exists, but not the level | zh-TW → Portuguese B1 | Shared pedagogy, that level's CEFR policy, `languages/`, `language-pairs/` | Direction + level rules |
| The target language has a `languages/` file, but the native language differs | Japanese → Portuguese | Shared pedagogy, CEFR policy, `languages/pt-PT.md` | Language-pair reference, direction + level rules |
| The target language has no `languages/` file | zh-TW → Japanese | Shared pedagogy, CEFR policy | Target-language rules, language-pair reference, direction + level rules |
| Neither is covered | Korean → German | Same as above | Same as above |

In the last two cases there are no project-checked language rules, so the AI can only rely on its own general knowledge, and results will be less consistent than for a configuration with dedicated setup. The AI should not invent missing dedicated rules or claim to apply files it does not have.

To give a configuration full support, see "Extending" above. This behavior is defined by the rules in `SKILL.md` (Sections 3 and 23); actual results may still vary by platform and model.

### Contributing

- Each rule lives in exactly one layer — use the Architecture layers table to decide.
- Don't create empty files or directories for completeness; add them only when
  needed.

---

## License

This project is licensed under the [MIT License](LICENSE).
