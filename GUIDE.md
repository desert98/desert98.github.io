# Hugo + PaperMod 站点使用与定制指南 (详细)

本指南覆盖：本地开发、内容编写、主题定制、搜索/索引、部署与 CI（含 PDF 生成）、常见错误与修复、以及模板示例。

## 1. 快速上手

- 安装 Hugo Extended（与 Actions 中使用的版本保持一致，建议 v0.148.x）：https://gohugo.io/getting-started/installing/
- 本地开发服务器（实时预览）

```powershell
hugo server -D
```

- 生产构建（生成 `public/`）

```powershell
hugo --minify
```

## 2. 内容管理

- 文章存放：`content/posts/`。每篇文章采用 front matter（TOML/YAML/JSON）配置元数据。
- 常用 front matter 示例（TOML）：

```toml
++ 
title = "示例文章"
date = 2025-10-12T12:00:00+08:00
draft = false
tags = ["hugo","notes"]
categories = ["技术学习"]
# 全流程指南：写文章 / 删除文章、Git 操作、常见错误排查、项目文件说明

下面这份文档覆盖你要的所有步骤，按操作场景拆分，包含可复制的 PowerShell 命令、常见报错定位方法与项目文件详解。

----------

目录（快速导航）
- 新增文章：从空白到发布（本地 → 提交 → 部署）
- 删除文章：完整流程
- 完整 Git 工作流（命令、分支、冲突、撤销）
- 常见错误定位与修复（本次修改中可能遇到的）
- 项目文件与目录详解（每个重要文件说明）
- 附：常用命令速查

----------

一、新增文章：从本地编辑到线上发布（全流程）

步骤 1 — 新建文件（本地）

1. 在 `content/posts/` 下创建新文件。例如：

```powershell
# 在 PowerShell 中
New-Item -Path content\posts -Name "my-new-article.md" -ItemType File
notepad content\posts\my-new-article.md
```

2. 编辑文件顶部 front matter（推荐使用 TOML 格式）：

```toml
++
title = "我的新文章"
date = 2025-10-12T10:00:00+08:00
draft = true   # 本地调试发布前可设为 true
tags = ["笔记","hugo"]
categories = ["技术学习"]
summary = "一句话摘要"
aliases = ["/old-url/"]
++ 

文章内容写在 front matter 下面。
```

注意：
- `draft = true` 会使文章只在 `hugo server -D` 下可见，发布前请把它设为 `false` 或移除。
- 若需上传图片，放在 `static/images/`（例如 `static/images/my-post-img.png`），在 Markdown 中可直接使用 `/images/my-post-img.png`。

步骤 2 — 本地预览与校验

```powershell
hugo server -D
# 打开 http://localhost:1313/ 并检查文章展示、代码块、图片、TOC 等
```

常见本地预览检查点：
- 是否显示文章（若 draft = true 则必须用 -D）
- 是否有 Markdown 渲染错误（未闭合的代码块、缩进导致的代码块）
- 页面是否有缺失资源（查看浏览器的 Network/Console）

步骤 3 — 提交到 Git（建议使用 feature 分支）

推荐的 Git 流程（PowerShell）：

```powershell
# 创建并切换到 feature 分支
git checkout -b feature/add-my-new-article

git add content/posts/my-new-article.md
git commit -m "feat(post): add my-new-article"
git push -u origin feature/add-my-new-article
```

步骤 4 — 远程合并与部署

- 通过 GitHub 上创建 Pull Request（PR），在 PR 中说明文章分类、摘要、是否需要 review。
- 合并到 `main` 分支后，GitHub Actions 会触发构建并部署到 Pages（workflow 文件：`.github/workflows/hugo.yaml`）。
- 等待 Actions 成功后访问线上页面（如 https://desert98.github.io/posts/... 或直接站点根）确认发布。若部署失败，查看 Actions 的日志（下文有定位方法）。

二、删除文章（全流程）

步骤 1 — 在本地删除文件并测试

```powershell
git checkout main
git pull origin main
git checkout -b chore/remove-old-article

git rm content/posts/old-article.md
git commit -m "chore(post): remove old-article"
git push -u origin chore/remove-old-article
```

步骤 2 — 通过 PR 合并并部署

- 在 GitHub 上发起 PR 并合并。合并后 Actions 会重新构建站点并移除已删除文章的页面。
- 若你不想留下历史记录，可以在本地直接用 `git rm` 并 push 到 main（仅在你理解 git 历史的情况下使用）。

注意：删除文章会导致原有的外部链接（若有）返回 404。若需要保留旧 URL，可在 `content/_index.md` 或 `static/` 下添加重定向页面，或使用 `aliases` 在新文章里指向旧 URL（但删除后 aliases 无效）。

三、完整 Git 操作与最佳实践

基础命令（PowerShell）

```powershell
# 克隆仓库
git clone https://github.com/desert98/desert98.github.io.git

# 查看状态
git status -sb

# 创建分支
git checkout -b feature/short-desc

# 添加并提交
git add <files>
git commit -m "feat: 描述"

# 推送分支
git push -u origin <branch>

# 将远程改动合并到本地
git pull --rebase origin main

# 查看日志
git log --oneline -n 20
```

分支模型建议
- 使用 feature 分支（`feature/...`）、修复分支（`fix/...`）、chore 分支（`chore/...`）。
- 在合并到 `main` 之前通过 PR 做 code review 与 CI 校验。

处理冲突

1. 当 `git pull` 报冲突时，Git 会提示具体文件。打开文件并按冲突标记（<<<<<<< ======= >>>>>>>）手动合并。
2. 合并完成后：

```powershell
git add <resolved-files>
git commit --no-edit
git push origin <branch>
```

撤销/回退策略
- 撤销未提交更改（重置工作区）：

```powershell
git restore <file>
git restore --staged <file>  # 从暂存区移除
```

- 放弃本地提交并回到远端（危险，慎用）

```powershell
git reset --hard origin/main
```

- 使用 `git revert` 撤销已发布的提交（更安全，会生成一个反向提交）：

```powershell
git revert <commit-hash>
git push origin main
```

临时保存工作（stash）

```powershell
git stash push -m "WIP: 调整 resume"  # 保存
git stash pop  # 恢复
```

Cherry-pick（挑选提交到另一个分支）

```powershell
git checkout main
git cherry-pick <commit-hash>
```

四、此次修改中常见报错与定位方法（详尽）

1) Hugo 构建失败（`hugo` 报错）
- 典型错误信息与含义：
  - "ERROR: failed to render pages": 模板或 shortcode 报错，通常是模板语法问题或数据缺失。
  - "found no layout file for \"json\" for layout \"archives\" for kind \"section\"": 表示你启用了 JSON 输出（outputs: section = ["HTML","JSON"]），但没有对应的 JSON layout。若 JSON layout 不是必须，可忽略或添加 `layouts/_default/list.json`。

定位方法：
```powershell
hugo --minify 2>&1 | Select-String -Pattern "ERROR|WARN"
```
检查日志中的文件路径、模板名称，然后定位 `layouts/` 中的模板。

修复建议：
- 如果是模板语法错误，打开提示的模板文件修复 Go template 表达式。
- 如果是缺少 JSON 模板，添加一个 `layouts/_default/list.json` 或在 `hugo.toml` 中移除对应的 JSON 输出配置。

2) 站点页面 404（线上）
- 可能原因：
  - GitHub Pages 部署尚未完成或失败（检查 Actions）。
  - 文章是 draft（未在生产构建中包含）。
  - baseURL 配置错误导致资源路径错位。

定位方法：
- 在 GitHub 仓库 > Actions 中查看最新 workflow 的构建日志；检查 "Build with Hugo" 步骤是否成功并查看上传 artifact 的输出。
- 本地用 `hugo --minify` 生成 `public/`，并查看 `public/<path>/index.html` 是否存在。

3) 资源加载异常（CSS/JS 没生效或返回 HTML）
- 常见原因：
  - `hugo.toml` 中存在占位字符串（例如 `<link / abs url>`），导致模板生成非法 URL（被编码为 `%3C...%3E`）。
  - assets 未正确构建（如果使用 Hugo Pipes/SCSS 但 Actions 没安装 Dart Sass）。

定位方法：在浏览器 DevTools 的 Network 标签中查看具体请求与响应类型（是否 200，Content-Type 是否正确）。

修复建议：
- 清理占位值（或把占位改为空）；确保 workflow 安装了必要工具（Dart Sass、Node 等）。

4) Search 无结果或中文匹配差
- 检查 `public/index.json` 是否存在并包含文章项（title/permalink/content/summary）。
- 检查 `public/assets/js/search.*.js` 是否成功加载且 Fuse 参数与你在 `hugo.toml` 中设置一致。

5) PDF 生成失败（CI）
- 常见问题：wkhtmltopdf 在 runner 上未安装或缺少库 / Chinese fonts 未安装，导致 PDF 无法正常渲染中文。

定位方法：在 Actions 的 build 日志中找到 wkhtmltopdf 安装与执行步骤的输出，贴出 stderr 内容以便诊断。

修复建议：
- 安装系统字库（例如 `fonts-noto-cjk`）或改用 Puppeteer（Chrome）在 Node 环境中生成 PDF，更兼容现代 CSS。

五、项目中文件与目录说明（逐项）

根目录简介（按你仓库当前结构）：

- `hugo.toml`：站点配置文件（主题、params、taxonomies、outputs、markup 配置等）。这是最重要的配置。
- `archetypes/`：文章模板，`default.md` 在你执行 `hugo new` 时作为默认 front matter 模板。
- `assets/`：存放可通过 Hugo Pipes 处理的资源（CSS/SCSS/JS），例如我们新增的 `assets/css/resume.css`。
- `content/`：网站内容（文章、页面）。关键子目录：
  - `content/posts/`：博客文章
  - `content/resume/_index.md`：简历页面的内容（现在使用 `layout = "resume"`）
  - `content/archives/`、`content/search/`、`content/categories/`：自定义页面或 section
- `data/`：存放可被模板读取的结构化数据（YAML/JSON/TOML），本项目未大量使用但可扩展。
- `i18n/`：国际化字符串，PaperMod 提供多个语言文件。
- `layouts/`：站点层级的模板（优先级高于主题），我们新增了 `layouts/resume/single.html`。
- `public/`：Hugo 生成的静态站点输出，通常不纳入版本控制（我们已将其移除并添加到 `.gitignore`）。
- `resources/`：Hugo 生成的中间资源（如指纹化后的 CSS），通常也不纳入版本控制。
- `static/`：静态资源直接拷贝到网站根（无需编译），如 favicon、robots.txt，访问路径为 `/<file>`。
- `themes/`：第三方主题（PaperMod）代码，包含其 own layouts、assets、i18n 等；可通过复制模板到 `layouts/` 来覆盖。
- `.github/workflows/hugo.yaml`：CI 配置，负责在 push 时构建并部署到 GitHub Pages；我们在此加入了 PDF 生成步骤。
- `GUIDE.md`：本文件，站点使用与维护手册。
- `.gitignore`：忽略文件配置（我们已添加 `public/`、`resources/` 等）。

Public 目录常见文件（构建产物）说明：
- `public/index.html`：站点首页
- `public/index.json`：搜索索引（供 Fuse.js 使用）
- `public/posts/...`：每篇文章的静态页面
- `public/_pdf/resume.pdf`：CI 生成的简历 PDF（若 CI 成功）

六、附：常用命令速查（PowerShell 风格）

```powershell
# 本地预览
hugo server -D

# 生产构建
hugo --minify

# Git 基础流程
git checkout -b feature/xxx
git add .
git commit -m "feat: ..."
git push -u origin feature/xxx

# 触发远端构建
git commit --allow-empty -m "rebuild"; git push origin main

# 查看 Actions 日志（需要在 GitHub 网页界面操作）
```

----------

