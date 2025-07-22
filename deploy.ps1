# 删除旧的 public 文件夹
Remove-Item -Path ".\public\*" -Recurse -Force -ErrorAction SilentlyContinue

# 生成新的站点文件
hugo --minify

# 添加所有更改到 Git
git add .

# 提交更改
$date = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
git commit -m "Site updated: $date"

# 推送到 GitHub
git push origin main
