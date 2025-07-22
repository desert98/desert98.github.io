+++
date = '2025-07-22T20:36:23+08:00'
draft = false
title = 'Hugo博客升级与文章发布指南'
+++
一、修改博客主题
Hugo 主题存放在 themes/ 目录，更换主题需要按以下步骤操作：

1. 选择新主题
- 访问 [Hugo Themes](https://themes.gohugo.io/) 网站
- 选择喜欢的主题（以 PaperMod 为例）
- 复制主题的 Git 仓库地址

2. 准备工作
```bash
# 确保在 main 分支
git checkout main

# 如果之前有旧主题，先删除
git rm -rf themes/旧主题名
```

3. 安装新主题（通过 Git 子模块）
```bash
# 添加主题为 Git 子模块
git submodule add https://github.com/adityatelange/hugo-PaperMod.git themes/PaperMod

# 初始化和更新子模块
git submodule init
git submodule update
```

4. 修改配置文件（hugo.toml）
```toml
baseURL = 'https://你的用户名.github.io/'  # 替换成你的 GitHub Pages 地址
languageCode = 'zh-cn'
title = '网站标题'
theme = 'PaperMod'  # 主题名称

# 其他主题特定配置...
```

5. 提交更改并部署
```bash
# 生成新主题的静态文件
hugo --minify

# 提交更改
git add .
git commit -m "更换主题为 PaperMod"
git push origin main  # GitHub Actions 会自动部署
二、发布新文章
Hugo 文章采用 Markdown 格式，存放在 content/posts/ 目录下。以下是发布文章的完整流程：

1. 创建新文章
```bash
# 在项目根目录执行，自动生成文章模板
hugo new posts/我的新文章.md
```

2. 编辑文章内容
用 VS Code 或其他编辑器打开 `content/posts/我的新文章.md`：
```markdown
+++
title = "我的新文章"
date = "2025-07-23T12:00:00+08:00"
draft = false  # 重要：改为 false 才会发布
+++

这里是文章内容...
可以使用 Markdown 语法编写
```

3. 本地预览
```bash
# 启动本地服务器预览（包括草稿）
hugo server -D

# 访问 http://localhost:1313 查看效果
```

4. 发布文章
```bash
# 生成静态文件
hugo --minify

# 提交更改
git add .
git commit -m "发布文章：我的新文章"
git push origin main  # GitHub Actions 会自动部署
三、常见问题处理

1. 主题相关问题
- 样式不生效：
  * 检查 `hugo.toml` 中 `theme` 字段是否与主题目录名完全一致
  * 确保主题子模块正确克隆：`git submodule status` 查看状态
  * 可以删除 `public` 目录后重新生成：`hugo --minify`

2. 文章相关问题
- 文章不显示：
  * 确保文章的 `draft = false`
  * 检查文章是否在 `content/posts/` 目录下
  * 文章日期不能是未来时间
- 文章格式问题：
  * 使用 `+++` 而不是 `---` 作为 front matter 分隔符
  * 确保文件使用 UTF-8 编码保存

3. 部署相关问题
- GitHub Actions 部署失败：
  * 检查 `.github/workflows/hugo.yaml` 文件是否存在
  * 在仓库的 Actions 标签页查看具体错误信息
- 显示 404 错误：
  * 确保仓库名称为 `用户名.github.io`
  * 检查 GitHub Pages 设置是否启用 Actions
  * 部署后等待 3-5 分钟再访问

4. 本地预览命令
```bash
# 完整的本地预览命令
hugo server -D --disableFastRender --navigateToChanged
```

5. 实用技巧
- 使用 VS Code 编辑文章，可以实时预览 Markdown
- 定期运行 `git submodule update --remote` 更新主题
- 使用 `hugo --cleanDestinationDir` 清理旧文件

需要帮助时可以：
1. 查看 [Hugo 官方文档](https://gohugo.io/documentation/)
2. 访问 [PaperMod 主题文档](https://github.com/adityatelange/hugo-PaperMod/wiki)
3. 在 GitHub Issues 中搜索类似问题