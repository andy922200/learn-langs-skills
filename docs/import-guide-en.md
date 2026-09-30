# Beginner Import Guide: Adding learn-langs-skills to a Web AI App

For users who are not familiar with programming. You do not need to write any
code: just package, upload, and turn it on.

中文版：[import-guide.md](import-guide.md)

> Interfaces change often. If the names on your screen differ from those below,
> follow the official documentation (links at the end).
> Last verified: 2026-09-30.

---

## Step 0: Get the zip file

1. Open a terminal in the project folder and run:

   ```bash
   ./package.sh
   ```

2. When it finishes, the zip appears at `dist/learn-langs-skills-<date-time>.zip`.
3. If you see `🎉 驗收通過` (verification passed), the package is correct.

The zip contains only the files the AI needs to read (`SKILL.md`, `shared/`,
`languages/`, `language-pairs/`, `skills/`). `README.md`, `README-en.md`, `docs/` (including this
guide), and hidden files are not included.

`SKILL.md` sits at the top level of the zip, with no extra wrapper folder.

---

## Gemini Spark

Verified against the official help page.

1. Open [gemini.google.com](https://gemini.google.com) and sign in with a
   **personal** Google account (work or school accounts are not supported at the
   moment).
2. Click **Settings → Skills**.
3. Click **Upload** at the top.
4. Select the zip file and click **Open**.
5. Review the content, then click **Create** at the top.

Notes:
- The skill name must be lowercase with hyphens. This project uses
  `learn-langs-skills`, which is valid.
- The upload limit is 100 MB; this project is about 600 KB.
- If the upload fails, make sure the zip contains no hidden files such as
  `.DS_Store`. A zip built with `package.sh` has none.

---

## Claude Work

Verified against the official help page.

1. Open [claude.ai](https://claude.ai) and sign in.
2. Go to **Customize → Skills**.
3. Click **+**, choose **Create skill → Upload a skill**, and select the zip
   file.
4. After uploading, the skill appears in the list. Make sure the switch next to
   it is **on**.
5. In Claude Work, enabled skills are available automatically. You can also see
   them in the Customize panel in the sidebar.

Notes:
- Skills require **code execution** to be enabled first.
- The official documentation does not say whether the zip needs an extra
  top-level folder. If the upload is rejected, ask Claude Code: "Repackage the
  zip with a top-level `learn-langs-skills/` folder."

---

## Codex Work (ChatGPT web)

The upload entry point was confirmed by a user; the official documentation does
not mention it. Button names below may differ slightly from your screen.

1. Sign in to ChatGPT and open [chatgpt.com/skills](https://chatgpt.com/skills).
2. Find the upload button and select the zip file.
3. After uploading, confirm the skill is enabled.

If the upload fails or you cannot find the button, use one of these fallbacks:

- In a chat, type `@skill-creator`, ask it to create a skill, and paste the
  contents of `SKILL.md`.
- If you use the Codex CLI or desktop app, place the whole project folder at
  `~/.agents/skills/learn-langs-skills/` and restart; it is detected
  automatically.

---

## How to confirm it works

Start a new chat and type:

```text
Use learn-langs-skills to teach me European Portuguese. I am an A1 beginner
with no programming background, and my native language is Traditional Chinese.
```

If it works, the AI will:

- explain in Traditional Chinese,
- give only a few new sentences,
- ask you to answer first, then correct you.

If it does not behave this way, go back to the Skills settings page, confirm the
switch is on, and try again in a new chat.

---

## FAQ

**Q: If I edit the files, does the platform update automatically?**
No. Run `./package.sh` again and upload the new zip. If the platform does not
allow overwriting, delete the old version first and then upload.

**Q: Can Gemini, Claude, and Codex share the same zip?**
Yes. The format is the same: `SKILL.md` plus reference files.

**Q: Which levels are available right now?**
The shared policies cover A1–C2 (`shared/cefr/`), but the dedicated
"Chinese-to-Portuguese" setup currently exists only for A1
(`skills/zh-TW-to-pt-PT/a1/`). Other levels fall back to the shared policies.

---

## Official documentation

- Gemini: [Create and manage skills for Gemini Apps](https://support.google.com/gemini/answer/17094296)
- Claude: [Use skills in Claude](https://support.claude.com/en/articles/12512180-use-skills-in-claude)
- Codex / ChatGPT: [Build skills](https://learn.chatgpt.com/docs/build-skills)
