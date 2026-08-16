---
name: update-dangma-wiki
description: Maintain the project-scoped Dangma Wiki VitePress repository. Use when Codex is asked to add, revise, move, or remove game-guide pages; import game screenshots; update indexes, navigation, or sidebars; verify the Wiki build; or commit, push, and check the GitHub Pages deployment for dangma-wiki.
---

# Update Dangma Wiki

Maintain the multi-game VitePress Wiki at `D:\UGit\dangma-wiki`. Keep guide content, navigation, build verification, and optional GitHub Pages publication in one consistent workflow.

## Establish scope

1. Resolve the repository with `git rev-parse --show-toplevel`; expect `D:\UGit\dangma-wiki` unless the repository has intentionally moved.
2. Read `git status --short --branch` before editing. Preserve unrelated and user-owned changes.
3. Inspect the affected page, nearby index pages, `docs/.vitepress/config.mts`, `package.json`, and `.github/workflows/deploy.yml` as relevant.
4. Treat “更新到 Wiki” or “写进 Wiki” as authorization to edit and verify locally. Commit or push only when the user also asks to submit, publish, or synchronize with GitHub.

## Maintain content

- Store source pages under `docs/games/<game-slug>/`; keep `docs/games/` suitable for multiple games.
- Place faction material below the game and faction directories. Place character-specific openings, builds, skills, and tactics under a `characters/` section rather than creating a separate prologue section.
- Do not create a “序章” section unless the user explicitly requests one.
- Write concise Chinese Markdown. Lead with actionable conclusions, then explain mechanics, choices, and exceptions.
- State the applicable game version and whether the information is vanilla or modded when balance or mechanics depend on it.
- Distinguish facts visible in screenshots from inference. Do not invent hidden tooltip effects or numerical values; research current facts when necessary or record the limitation.
- Preserve useful source links near the claims they support. Prefer official patch notes and developer material for version-sensitive claims.
- Copy retained screenshots into `docs/public/images/<game-slug>/` with descriptive lowercase kebab-case names. Reference them as `/images/<game-slug>/<name>.<ext>`.
- Never edit generated files in `docs/.vitepress/dist/` or cache directories.

## Keep navigation coherent

When adding, moving, renaming, or removing a page:

1. Update the nearest `index.md` so the page is discoverable.
2. Update `docs/.vitepress/config.mts` when the page belongs in the global navigation or sidebar.
3. Check inbound Markdown links and image paths with `rg` before renaming or deleting files.
4. Keep sidebar labels short while allowing page titles to be descriptive.
5. Add new games to `docs/games/index.md`; add prominent games to the top navigation only when useful.

## Verify every update

Run from the repository root:

```powershell
npm run docs:build
git diff --check
git status --short
git diff --stat
git diff
```

- Use the existing `node_modules` when available. Run `npm ci` only when dependencies are missing or the lockfile changed.
- Fix build errors, broken links reported by VitePress, malformed frontmatter, and whitespace errors before handing off.
- Review the final diff for accidental generated files, temporary files, secrets, unrelated changes, and unsupported claims.

## Publish only when authorized

1. Confirm the build passes and review the exact changed files.
2. Stage only intended paths with `git add -- <paths>`.
3. Use a concise Chinese conventional commit message, for example `feat: 添加色孽科技路线攻略` or `docs: 修正震旦单位说明`.
4. Push the current branch normally. Never rewrite history or force-push unless the user explicitly requests it and understands the risk.
5. For the normal production flow, push `main` to `origin`; `.github/workflows/deploy.yml` builds and deploys GitHub Pages automatically.
6. When GitHub tooling is available, verify the workflow run associated with the pushed commit and report whether deployment succeeded. The current site is `https://gkec11.github.io/dangma-wiki/`.

## Report the result

Summarize:

- pages and navigation changed;
- build result;
- commit hash and push state, if published;
- GitHub Pages deployment state and affected public page links, if checked;
- any claims intentionally left unranked or unverified because source evidence was incomplete.
