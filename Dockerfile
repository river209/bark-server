# 第一阶段：构建阶段
FROM golang:1.18 AS builder

# 设置工作目录
WORKDIR /app

# 复制项目代码
COPY . .

# 编译服务为可执行文件
RUN go build -o bark-server

# 第二阶段：运行阶段
FROM debian:bullseye-slim

# 设置工作目录
WORKDIR /app

# 从构建阶段复制二进制文件和配置文件
COPY --from=builder /app/bark-server .

# 暴露端口
EXPOSE 8080

# 启动服务
CMD ["./bark-server", "-serverless", "true"]
