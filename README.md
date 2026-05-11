# AI Creator Mini App

基于 `RuoYi + RuoYi-Vue3 + uni-app` 的 AI 创作小程序工作区。

## 当前工作区结构

- `ruoyi-ai-server`
  统一主工作区，包含若依后端、Vue3 管理后台前端和小程序端目录。
- `docs`
  本项目的结构、表设计、接口与页面文档。

## 目录说明

### `ruoyi-ai-server`

这里作为你的统一主仓：

- `ruoyi-admin`、`ruoyi-common`、`ruoyi-framework` 等作为后端主工程
- `ruoyi-ai-project` 作为 Vue3 管理后台前端
- `uniapp-mini` 作为微信小程序工程
- 后端统一提供后台和小程序两套业务接口

## 文档索引

- [项目结构方案](./docs/project-structure.md)
- [数据库设计初稿](./docs/database-design.md)
- [接口与页面清单](./docs/api-and-pages.md)
- [工作区初始化说明](./docs/workspace-setup.md)

## 下一步建议

1. 在 `ruoyi-ai-server` 中创建 AI 业务模块包结构。
2. 在 `ruoyi-ai-server/uniapp-mini` 中初始化小程序工程。
3. 导入若依 SQL 并追加 AI 业务表。
4. 先打通登录、模型列表、图片创作和作品列表链路。
