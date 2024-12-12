#!/bin/bash

# 使用docker run启动PostgreSQL容器
docker run --name postgres -e POSTGRES_PASSWORD=sonar123 -p 5432:5432 -v /opt/postgres/data:/var/lib/postgresql/data -d postgres &

# 获取容器启动后的ID
container_id=$(docker ps -aqf "name=postgres")

# 等待一段时间，确保容器完全启动（这里等待5秒，可根据实际情况调整）
sleep 5

# 定义要执行的SQL语句，将多条语句放在一个字符串中，每条语句以分号隔开
sql_commands="DROP DATABASE IF EXISTS sonarqube;
CREATE DATABASE sonarqube WITH  ENCODING = 'UTF8';
CREATE USER sonarqube WITH PASSWORD 'sonarqube';
GRANT ALL PRIVILEGES ON DATABASE sonarqube TO sonarqube;
GRANT ALL PRIVILEGES ON all tables in schema public TO sonarqube;"

# 使用docker exec在容器内执行psql命令来运行SQL语句
docker exec -i $container_id psql -U postgres -c "$sql_commands"

# 这里看你的物理机ip地址是多少，如果想使用10开头的内网地址，那么直接使用
# 如果使用172开头那么把grep -v '172.*'改为grep -v '10.*'
phy_ip=ip addr show | sed -n '/inet /{s/.*inet \([0-9.]*\).*/\1/p}' | grep -v '127.0.0.1' | grep -v '172.*' | grep -v '192.*'
# 启动服务
docker run -d --name sonarqube-host -p 9000:9000 \
-v /opt/sonarqube/data:/opt/sonarqube/data \
-v /opt/sonarqube/extensions:/opt/sonarqube/extensions \
-v /opt/sonarqube/logs:/opt/sonarqube/logs \
-v /opt/sonarqube/temp:/opt/sonarqube/temp \
-e SONAR_JDBC_URL="jdbc:postgresql://$(phy_ip):5432/sonarqube?useUnicode=true&characterEncoding=utf-8" \
-e SONAR_JDBC_USERNAME="sonarqube" \
-e SONAR_JDBC_PASSWORD="sonarqube" \
-e SONAR_ES_BOOTSTRAP_CHECKS_DISABLE=true \
sonarqube:9.9.8-community
