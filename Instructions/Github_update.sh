#!/bin/bash

# 进入你的 GitHub 项目目录
cd ~/Project/1_Github || {
    echo "❌ 无法进入目录 ~/Project/1_Github"
    exit 1
}

echo "📁 当前目录：$(pwd)"

# 检查是否是 Git 仓库
if [ ! -d ".git" ]; then
    echo "❌ 当前目录不是 Git 仓库，请先执行 git init"
    exit 1
fi

# 检查远程仓库是否存在
if ! git remote get-url origin > /dev/null 2>&1; then
    echo "🔗 未检测到 origin，正在添加 GitHub 远程仓库..."
    git remote add origin https://github.com/ladyshadowhdk-ui/301-sever-Github.git
fi

# 确保分支是 main
git branch -M main

echo "🔍 检查文件变化..."
git status

# 添加所有变化
git add .

# 如果没有变化，就退出
if git diff --cached --quiet; then
    echo "✅ 没有新的文件变化需要提交"
    exit 0
fi

# 自动生成提交信息
COMMIT_MSG="Update server files $(date '+%Y-%m-%d %H:%M:%S')"

echo "📝 正在提交：$COMMIT_MSG"
git commit -m "$COMMIT_MSG"

echo "⬆️ 正在推送到 GitHub..."
git push -u origin main

echo "✅ 更新完成！"