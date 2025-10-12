# Hugo + PaperMod 站点使用与定制指南

这份指南整合了仓库的常用流程、主题定制、搜索与索引、部署与排错要点。

## 快速上手
- 本地运行：`hugo server -D`
- 生产构建：`hugo --minify`

## 内容管理
- 文章路径：`content/posts/`
- front matter 示例（TOML）

## 主题与样式
- 覆盖主题模板：将文件从 `themes/PaperMod/layouts/...` 复制到 `layouts/...`
- 样式最佳实践：把样式放到 `assets/` 并使用 Hugo Pipes（如需要）

## 搜索与索引
- 已启用 JSON 输出（`[outputs] home = ["HTML","JSON"]`），索引文件为 `public/index.json`
- 调整搜索参数：`[params.fuseOpts]` 在 `hugo.toml`

## 部署
- GitHub Actions workflow：`.github/workflows/hugo.yaml`
- 手动触发：`git commit --allow-empty -m "rebuild"; git push origin main`

## 常见问题排查
- 页面 404 → 检查 Actions、Pages 设置、清缓存
- 页面内容显示为文本 → 检查 Markdown 中 HTML 是否被缩进或 `markup.goldmark.renderer.unsafe` 是否启用

## 进阶建议
- 将简历样式迁移到 `assets/` 并创建 `layouts/resume/single.html`
- 在 CI 中生成 PDF（使用 Headless Chrome）

---
如需完整详细版或把样式迁移与 PDF 自动化，告诉我我会替你实现。
