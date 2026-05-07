#!/bin/bash

# 进入你的 GitHub 项目目录
cd ~/Project/1_Github || {
    echo "❌ 无法进入目录 ~/Project/1_Github"
    exit 1
}

echo "📁 当前目录：$(pwd)"

# 设置 Git 用户名和邮箱
git config --global user.name "ladyshadowhdk-ui"
git config --global user.email "ladyshadowhdk@gmail.com"

echo "👤 Git 用户：$(git config --global user.name) <$(git config --global user.email)>"

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

# 如果没有新的文件变化，就直接尝试推送已有 commit
if git diff --cached --quiet; then
    echo "ℹ️ 没有新的文件变化需要提交，尝试推送已有提交..."
else
    COMMIT_MSG="Update server files $(date '+%Y-%m-%d %H:%M:%S')"
    echo "📝 正在提交：$COMMIT_MSG"
    git commit -m "$COMMIT_MSG"
fi

echo "⬆️ 正在推送到 GitHub..."
git push -u origin main

if [ $? -eq 0 ]; then
    echo "✅ 更新完成！"
else
    echo "❌ 推送失败，请检查 GitHub 登录/token 权限"
fi