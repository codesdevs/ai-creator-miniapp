# 工作区初始化说明

## 当前状态

当前工作区已经整理成一个主工作区：

- `ruoyi-ai-server`：若依官方后端仓库
- `ruoyi-ai-server/ruoyi-ai-project`：若依 Vue3 前端仓库
- `ruoyi-ai-server/uniapp-mini`：小程序端目录

## 为什么保留两套仓库

若依官方后端仓库原本自带 `ruoyi-ui`，但它是旧版前端实现。  
你这次项目希望使用 `Vue3`，所以我们保留单独的 `RuoYi-Vue3` 作为后台前端，并已经移除了旧版 `ruoyi-ui`。

实际开发时建议这样使用：

- `ruoyi-ai-server`：唯一主仓
- `ruoyi-ai-server/ruoyi-ai-project`：后台管理前端
- `ruoyi-ai-server/uniapp-mini`：小程序端

## 推荐开发方式

### 后端

在 `ruoyi-ai-server` 中新增业务包，例如：

```text
com.ruoyi.ai.user
com.ruoyi.ai.model
com.ruoyi.ai.task
com.ruoyi.ai.wallet
com.ruoyi.ai.order
com.ruoyi.ai.work
com.ruoyi.ai.team
```

### 后台前端

在 `ruoyi-ai-server/ruoyi-ai-project/src/views` 中新增：

- 模型管理
- 模型版本管理
- 任务管理
- 订单管理
- 作品管理
- 用户资产

### 小程序端

在 `ruoyi-ai-server/uniapp-mini` 中规划页面：

- 应用
- 首页
- 资产
- 作品
- 我的
- 图片创作
- 视频创作
- 充值
- 算力流水

## 注意事项

1. 若依前后端默认接口路径和登录方式，后面要额外增加小程序端鉴权逻辑。
2. 小程序接口建议统一放到 `/app/*` 路径，后台接口继续沿用 `/system/*` 或独立拆成 `/admin/*`。
