# DeepSeek Harness Docker

在 Docker 平台中运行官方 `@deepseek-ai/dsh web`。容器监听平台提供的 `PORT`，
并用 `PUBLIC_HOST` 校验浏览器的 Host/Origin。

## 启动

```bash
docker compose up -d --build
docker compose logs -f dsh
```

本地地址是 `http://localhost:8080`。日志会打印带 `?token=...` 的一次性认证链接；在浏览器中打开它，
然后到 **Settings → Models** 配置 DeepSeek API Key。配置、凭据和会话保存在
`dsh-data` volume 中。

默认工作区是 `./workspace`。也可以挂载已有项目：

```bash
WORKSPACE=/absolute/path/to/project docker compose up -d --build
```

## 部署到公网 Docker 平台

平台需要设置两个环境变量：

- `PORT`：平台分配的监听端口，默认 `8080`
- `PUBLIC_HOST`：平台域名，不带 `https://`，例如 `harness.example.com`

部署后查看平台日志，复制 `?token=...`，拼到公网域名后打开：

```text
https://harness.example.com/?token=日志中的token
```

平台必须提供 HTTPS。建议再启用平台的登录保护或访问白名单；DeepSeek Harness 仍处于
开发者预览阶段，并能读写挂载的工作区、执行命令。

镜像会仅为 `PUBLIC_HOST` 启用远程设置页面。该补丁扩大了公网控制面，因此 HTTPS、
token 保密和平台访问控制都是必需的。

## 停止

```bash
docker compose down
```
