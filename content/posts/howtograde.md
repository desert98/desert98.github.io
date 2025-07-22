+++
date = '2025-07-22T20:36:23+08:00'
draft = false
title = 'Howtograde'
+++
一、修改博客主题
Hugo 主题存放在 themes/ 目录，更换主题需替换主题文件 + 修改配置文件：
1. 选择新主题（以 PaperMod 为例）
进入 Hugo 主题官网 挑选主题，复制主题的 Git 仓库地址。
2. 安装新主题（通过 Git 子模块，推荐）
在 Hugo 项目根目录执行：
bash
# 添加主题为 Git 子模块（替换为目标主题的仓库地址）
git submodule add https://github.com/adityatelange/hugo-PaperMod.git themes/PaperMod
3. 修改 Hugo 配置文件（hugo.toml）
打开 hugo.toml，修改 theme 字段为新主题名称（如 PaperMod）：
toml
theme = "PaperMod"  # 替换为你安装的主题名称
4. 生成并部署新主题
bash
hugo  # 生成新主题的静态文件
git add .  # 暂存所有修改（含主题配置和子模块）
git commit -m "更换主题为 PaperMod"
git push origin main  # 推送到 GitHub，触发 Pages 重新部署
二、提交新文章
Hugo 文章需放在 content/posts/ 目录（Markdown 格式），步骤如下：
1. 创建新文章（自动生成模板）
在项目根目录执行：
bash
hugo new posts/我的新文章.md
这会在 content/posts/ 下生成 我的新文章.md，包含默认 Front Matter（标题、日期等）。
2. 编辑文章内容
用 Markdown 编辑器打开 content/posts/我的新文章.md，编写内容：
markdown
---
title: "我的新文章"
date: 2025-07-23T12:00:00+08:00
draft: false  # 设为 false 才会被 Hugo 生成
---

这里是文章内容...
3. 生成静态文件并部署
bash
hugo  # 生成包含新文章的静态文件
git add .  # 暂存新文章和生成的静态文件
git commit -m "新增文章：我的新文章"
git push origin main  # 推送到 GitHub，更新博客
三、常见问题处理
主题样式不生效：
检查 hugo.toml 中 theme 字段是否与主题目录名一致。
执行 hugo server -D 本地预览，确认主题配置正确后再部署。
新文章未显示：
确保文章的 draft: false（草稿不会被生成）。
检查 content/posts/ 路径是否正确，Hugo 默认读取该目录下的文章。
GitHub Pages 部署延迟：
推送代码后，GitHub Pages 可能需要 1~2 分钟生效，耐心等待后刷新页面即可。