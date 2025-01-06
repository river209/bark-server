# 基础镜像
FROM golang:1.18 AS builder

# 设置工作目录
WORKDIR /app

# 复制项目代码
COPY . .

# 编译服务
RUN go build -o bark-server

# 创建最终运行镜像
FROM debian:bullseye-slim

# 设置运行目录
WORKDIR /app

# 从构建阶段复制二进制文件
COPY --from=builder /app/bark-server .

# 暴露端口
EXPOSE 8080

# 设置启动命令
CMD ["./bark-server"]
