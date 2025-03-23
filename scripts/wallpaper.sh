#!/bin/bash

# 设置目标文件夹（支持通过脚本参数传递路径）
TARGET_DIR="${1:-$HOME/Pictures}"

# 检查 swww 是否安装
if ! command -v swww >/dev/null; then
  echo "错误：请先安装 swww 工具！"
  exit 1
fi

# 检查目标文件夹是否存在
if [ ! -d "$TARGET_DIR" ]; then
  echo "错误：目录 '$TARGET_DIR' 不存在"
  exit 1
fi

# 启用文件名通配符扩展选项
shopt -s nullglob   # 允许模式不匹配时返回空
shopt -s nocaseglob # 不区分文件名大小写

# 收集支持的图片文件（jpg/jpeg/png/gif）
files=("$TARGET_DIR"/*.{jpg,jpeg,png,gif})

# 关闭通配符扩展选项
shopt -u nullglob nocaseglob

# 检查是否找到图片文件
if [ ${#files[@]} -eq 0 ]; then
  echo "错误：目录中未找到支持的图片文件（jpg/jpeg/png/gif）"
  exit 1
fi

# 获取当前壁纸路径（通过 swww query）
current_wallpaper=$(swww query | grep -oP 'image: \K.*' | awk '{print $1}')

# 过滤掉当前壁纸（如果存在当前壁纸且位于目标目录）
if [[ -n "$current_wallpaper" ]]; then
  filtered_files=()
  for file in "${files[@]}"; do
    if [[ "$(realpath "$file")" != "$(realpath "$current_wallpaper")" ]]; then
      filtered_files+=("$file")
    fi
  done
  # 如果过滤后仍有文件则替换数组
  if [ ${#filtered_files[@]} -ge 1 ]; then
    files=("${filtered_files[@]}")
  else
    echo "警告：未找到其他可用壁纸，将使用当前壁纸"
  fi
fi

# 使用 shuf 随机选择一个文件
selected_file=$(printf "%s\n" "${files[@]}" | shuf -n 1)

# 初始化 swww（如果尚未初始化）
swww init >/dev/null 2>&1 || true

# 设置壁纸并应用效果
swww img "$selected_file" --transition-type center --transition-fps 144

echo "已更换壁纸：$selected_file"
