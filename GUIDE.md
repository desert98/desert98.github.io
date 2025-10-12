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
summary = "一句话摘要"
++ 
```

- 新建文章建议用编辑器模板或 `archetypes/default.md`。

## 3. 主题与模板定制（PaperMod）

- 覆盖主题模板：复制主题中的布局到 `layouts/`，Hugo 会优先使用站点层级的模板。
	例如：

```text
cp themes/PaperMod/layouts/_default/single.html layouts/_default/single.html
```

- 样式组织建议：
	- 小改：文章内联 `<style>`（快速但不便维护）。
	- 推荐：把样式放 `assets/css/*.css` 或 `assets/scss/*.scss` 并使用 Hugo Pipes 处理（`resources.Get`、`minify`、`fingerprint`）。

## 4. 搜索与索引（已配置）

- 已启用 JSON 输出：`[outputs] home = ["HTML","JSON"]`，因此会生成 `public/index.json`，被 PaperMod 的搜索脚本读取。
- 搜索参数在 `hugo.toml` 的 `[params.fuseOpts]` 中可配置（如 threshold、minMatchCharLength 等）。中文体验通常需要降低 threshold 并将 `minMatchCharLength=1`。

## 5. 部署与 CI（GitHub Pages）

- workflow 文件：`.github/workflows/hugo.yaml`。关键步骤：安装 Hugo、checkout、build、upload artifact、deploy.
- 手动触发构建：
	```powershell
	git commit --allow-empty -m "rebuild site"
	git push origin main
	```

## 6. 自动生成 Resume PDF（已在 workflow 中添加）

- 我在 workflow 中添加了 `wkhtmltopdf` 的安装和生成步骤（在 Build 后）：
	- 如果 `public/resume/index.html` 存在，workflow 会将其转换为 `public/_pdf/resume.pdf`，并随 `public/` 一并上传与部署。
	- 该方法依赖 `wkhtmltopdf`，它直接将 HTML 转为 PDF，支持离线转换与常见 CSS 特性。

## 7. 常见错误与修复步骤（排查指南）

- 错误：生成的页面头部出现 `%3C...%3E` 或看起来像编码的占位符
	- 原因：`hugo.toml` 中存在带尖括号的占位字符串（例如 `<link / abs url>`），这些被插入模板后会变成非法 URL。
	- 解决：将这些占位值替换为空或有效 URL（已在本仓库修复）。

- 错误：页面 HTML 被当作代码块显示（显示在 `<pre><code>`）
	- 原因：Markdown 中的 HTML 缩进会被当作代码块，或者 `markup.goldmark.renderer.unsafe` 未启用。
	- 解决：不要给 HTML 块添加前导空格，或在 `hugo.toml` 启用 `markup.goldmark.renderer.unsafe = true`（仓库已启用）。

- 错误：站内搜索无结果或结果不相关
	- 检查 `public/index.json` 是否包含文章；查看 `public/assets/js/search.*.js` 中 Fuse 配置是否匹配 `hugo.toml`。
	- 调整 `threshold`，或为中文做分词预处理（复杂但可明显提高中文搜索质量）。

- 错误：GitHub Pages 部署失败
	- 在仓库 Actions 页查看最新 workflow 的日志，重点看 Build with Hugo 步骤的 stderr/stdout。
	- 常见问题：Hugo 版本不匹配、theme 子模块未拉取、assets 管线工具（如 Dart Sass）未安装。

## 8. 模板示例

- 简历专用 layout（`layouts/resume/single.html`）示例（仓库已包含）：

```html
{{ "{{ define \"main\" }}" }}
	{{ "{{ partial \"breadcrumbs.html\" . }}" }}
	<h1 class="post-title">{{ "{{ .Title }}" }}</h1>
	<div class="post-description">{{ "{{ .Description }}" }}</div>
	{{ "{{ $styles := resources.Get \"css/resume.css\" | minify | fingerprint }}" }}
	<link rel="stylesheet" href="{{ "{{ $styles.Permalink }}" }}" integrity="{{ "{{ $styles.Data.Integrity }}" }}">
	<main class="post-content resume-page">
		{{ "{{ .Content }}" }}
	</main>
{{ "{{ end }}" }}
```

## 9. 迁移内联样式到 `assets/`（已完成）

- 我已把 `content/resume/_index.md` 中的内联 CSS 提取到 `assets/css/resume.css`，并更新 `content/resume/_index.md` 的 `layout` 为 `resume`，以及新增 `layouts/resume/single.html` 来引入样式。这会使样式更易维护，并在 Actions 中使用 fingerprint 缓存。

## 10. 常用命令速查

```powershell
# 本地预览
hugo server -D

# 生产构建
hugo --minify

# 触发远端构建
git commit --allow-empty -m "rebuild"; git push origin main

# 新建文章
New-Item -Path content/posts -Name "my-post.md" -ItemType File
```

---

如果你需要，我可以：

- 把 `resume.pdf` 同步到站点根的某个可下载位置并在 `resume` 页面加上下载按钮；
- 改用 Puppeteer/Chrome 生成 PDF（更好的 CSS 支持）；
- 为搜索加入中文分词（需要额外预处理步骤）。

如果你要我继续执行其中某些任务（比如把 PDF 链接到页面或用 Puppeteer 替代 wkhtmltopdf），告诉我我会继续。 
