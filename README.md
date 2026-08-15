# Dangma Wiki

使用 VitePress 构建的个人多游戏攻略站。目前首个专题为《全面战争：战锤3》原版8.1震旦攻略。

## 本地运行

需要 Node.js 20 或更高版本。

```bash
npm install
npm run docs:dev
```

生产构建与预览：

```bash
npm run docs:build
npm run docs:preview
```

## 发布到 GitHub Pages

1. 在 GitHub 创建公开仓库 `dangma-wiki`。
2. 把本目录内容推送到仓库的 `main` 分支。
3. 打开仓库 **Settings → Pages**，将 Source 设置为 **GitHub Actions**。
4. 等待 Actions 中的 `Deploy VitePress site to Pages` 完成。
5. 网站地址通常为 `https://你的用户名.github.io/dangma-wiki/`。

如果仓库名不是 `dangma-wiki`，需要同步修改：

- `docs/.vitepress/config.mts` 中的 `base` 和图标资源路径。

## 内容维护

- 游戏目录：`docs/games/`
- 战锤3攻略：`docs/games/total-war-warhammer-3/`
- VitePress配置：`docs/.vitepress/config.mts`
- 主题样式：`docs/.vitepress/theme/custom.css`

页面采用普通 Markdown，可以直接编辑。提交到 `main` 后会自动重新构建并发布。

## 添加其他游戏

1. 在 `docs/games/` 下新建英文路径目录，例如 `docs/games/game-name/`。
2. 创建该游戏的 `index.md`，再按需要增加角色、装备、任务、流派或资料库子目录。
3. 在 `docs/games/index.md` 增加游戏入口。
4. 在 `docs/.vitepress/config.mts` 中增加导航或侧边栏配置。
5. 运行 `npm run docs:build`，确认内部链接与页面构建正常。
