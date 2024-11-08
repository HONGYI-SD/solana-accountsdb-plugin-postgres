#!/bin/bash

# 获取当前脚本所在的目录
SCRIPT_DIR=$(dirname "$(realpath "$0")")

# 从 geyser.json 中读取配置
CONFIG_FILE="$SCRIPT_DIR/geyser.json"

# 提取配置项
HOST=$(jq -r '.host' $CONFIG_FILE)
USER=$(jq -r '.user' $CONFIG_FILE)
PASSWORD=$(jq -r '.password' $CONFIG_FILE)
DBNAME=$(jq -r '.dbname' $CONFIG_FILE)
PORT=$(jq -r '.port' $CONFIG_FILE)

# 设置 PGPASSWORD 环境变量
export PGPASSWORD=$PASSWORD

# 构建 psql 命令
SQL_FILE="$SCRIPT_DIR/create_schema.sql"
PSQL_CMD="psql -U $USER -p $PORT -h $HOST -d $DBNAME -f $SQL_FILE"

# 执行 psql 命令
#echo "执行命令: $PSQL_CMD"
$PSQL_CMD

# 清理环境变量
unset PGPASSWORD
