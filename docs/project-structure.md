# 项目结构方案

## 总体原则

- 若依只负责后台管理端和后端基础骨架。
- 小程序端使用独立 `uni-app` 工程开发。
- 后端统一提供 `admin` 和 `app` 两套接口。
- AI 模型接入采用适配器模式，避免把第三方平台逻辑写死。

## 推荐仓库结构

```text
ruoyi-ai-project/
├── ruoyi-admin                  # 启动模块
├── ruoyi-common                 # 公共常量、工具、返回封装
├── ruoyi-framework              # 安全、配置、拦截器
├── ruoyi-system                 # 若依系统模块
├── ruoyi-quartz                 # 定时任务
├── ruoyi-generator              # 代码生成
├── ruoyi-ai
│   ├── ruoyi-ai-user            # C端用户、登录、资料
│   ├── ruoyi-ai-model           # 模型管理、版本管理、参数模板
│   ├── ruoyi-ai-task            # 任务提交、查询、回调、重试
│   ├── ruoyi-ai-wallet          # 算力账户、流水、扣减、退款
│   ├── ruoyi-ai-order           # 订单、支付、卡密、套餐
│   ├── ruoyi-ai-work            # 作品、收藏、删除、分享
│   ├── ruoyi-ai-team            # 邀请关系、团队收益
│   └── ruoyi-ai-operate         # banner、公告、活动配置
├── ruoyi-ai-project             # 若依 Vue3 管理后台
└── uniapp-mini                  # uni-app 小程序端
```

## 后端分层建议

每个业务模块保持统一分层：

```text
controller
service
service/impl
domain
mapper
enums
convert
vo
```

说明：

- `controller`：分成 `admin` 和 `app` 两类接口。
- `domain`：数据库实体。
- `vo`：请求和响应对象。
- `enums`：任务状态、订单状态、作品状态等枚举。
- `convert`：实体和 VO 转换。

## 接口命名建议

### 后台接口

```text
/admin/user/*
/admin/model/*
/admin/task/*
/admin/order/*
/admin/work/*
/admin/operate/*
```

### 小程序接口

```text
/app/auth/*
/app/user/*
/app/model/*
/app/task/*
/app/work/*
/app/wallet/*
/app/order/*
/app/team/*
```

## 小程序端目录建议

```text
uniapp-mini/
├── pages
│   ├── app/index               # 应用页
│   ├── home/index              # 首页
│   ├── assets/index            # 资产页
│   ├── works/index             # 作品页
│   ├── mine/index              # 我的页
│   ├── create/image            # 图片创作
│   ├── create/video            # 视频创作
│   ├── create/text             # 文本创作
│   ├── order/recharge          # 充值页
│   ├── wallet/flow             # 算力流水
│   └── login/index             # 登录页
├── store
├── api
├── utils
├── components
└── static
```

## 若依中可直接复用的能力

- 用户、角色、菜单、权限
- 字典管理
- 参数配置
- 附件上传
- 操作日志
- 定时任务
- 代码生成器

## 建议新增字典项

- `ai_model_type`：文本、图片、视频
- `ai_task_status`：待执行、执行中、成功、失败、取消
- `ai_order_status`：待支付、已支付、已关闭、已退款
- `ai_work_status`：正常、删除、审核中、违规
- `ai_pay_type`：微信支付、卡密激活、后台赠送

## 核心设计建议

### 1. 模型配置后台化

不要把模型名称、消耗算力、支持比例、支持风格写死在前端。  
建议在后台配置以下内容：

- 模型编码
- 模型名称
- 分类
- 封面
- 默认提示词
- 支持比例
- 支持风格
- 消耗算力
- 是否上架

### 2. 任务和扣费解耦

提交流程建议如下：

1. 校验账户算力
2. 冻结算力
3. 创建任务
4. 调用模型平台
5. 成功则正式扣减
6. 失败则解冻或退回

### 3. 统一 AI 适配器

建议定义统一接口：

```java
public interface AiModelAdapter {
    SubmitTaskResp submitTask(SubmitTaskReq req);
    QueryTaskResp queryTask(String thirdTaskId);
    CancelTaskResp cancelTask(String thirdTaskId);
}
```

适配器实现示例：

- `JimengAdapter`
- `TongyiAdapter`
- `KlingAdapter`
- `OpenAiImageAdapter`
- `RunwayAdapter`

## 第一阶段建议范围

先做最小闭环：

1. 微信登录
2. 模型列表
3. 图片创作单模型
4. 提交任务和查询结果
5. 我的作品
6. 算力账户与流水
7. 后台模型配置
