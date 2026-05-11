# 接口与页面清单

## 一、小程序页面清单

### Tab 页面

- `pages/app/index`：应用页
- `pages/assets/index`：资产页
- `pages/home/index`：首页
- `pages/works/index`：作品页
- `pages/mine/index`：我的页

### 功能页面

- `pages/login/index`：登录授权
- `pages/create/image`：图片创作
- `pages/create/video`：视频创作
- `pages/create/text`：文本创作
- `pages/work/detail`：作品详情
- `pages/task/detail`：任务详情
- `pages/order/recharge`：充值页
- `pages/wallet/flow`：算力流水
- `pages/code/activate`：卡密激活
- `pages/mine/team`：我的团队
- `pages/mine/settings`：设置页

## 二、后台页面清单

- 模型管理
- 模型版本管理
- 套餐管理
- 卡密管理
- 订单管理
- 用户管理
- 用户资产管理
- 创作任务管理
- 作品管理
- banner 配置
- 公告配置

## 三、小程序接口清单

## 1. 认证模块

- `POST /app/auth/wxLogin`
  微信登录
- `POST /app/auth/bindMobile`
  绑定手机号
- `GET /app/auth/profile`
  获取当前登录用户信息

## 2. 用户模块

- `GET /app/user/info`
  获取用户中心信息
- `GET /app/user/homeStat`
  获取首页统计数据

返回建议包含：

- 剩余算力
- 我的资产
- 我的作品数
- 激活状态
- 团队人数

## 3. 模型模块

- `GET /app/model/categoryList`
  模型分类
- `GET /app/model/list`
  模型列表
- `GET /app/model/detail/{modelId}`
  模型详情
- `GET /app/model/versionList/{modelId}`
  模型版本列表

## 4. 任务模块

- `POST /app/task/submitImage`
  提交图片生成任务
- `POST /app/task/submitVideo`
  提交视频生成任务
- `POST /app/task/submitText`
  提交文本生成任务
- `GET /app/task/detail/{taskId}`
  查询任务详情
- `GET /app/task/page`
  任务分页列表
- `POST /app/task/cancel/{taskId}`
  取消任务

### 图片生成请求建议

```json
{
  "modelId": 1,
  "versionId": 11,
  "createMode": "TEXT_TO_IMAGE",
  "promptText": "一个未来城市中的白发机器人少女",
  "negativePrompt": "模糊，低质量，畸形",
  "styleCode": "ANIME",
  "ratioCode": "9_16",
  "sourceUrl": "",
  "extraParams": {}
}
```

## 5. 作品模块

- `GET /app/work/page`
  我的作品列表
- `GET /app/work/detail/{workId}`
  作品详情
- `POST /app/work/delete/{workId}`
  删除作品
- `POST /app/work/public/{workId}`
  公开作品

## 6. 资产模块

- `GET /app/wallet/info`
  钱包信息
- `GET /app/wallet/flowPage`
  算力流水

## 7. 订单模块

- `GET /app/order/packageList`
  套餐列表
- `POST /app/order/create`
  创建充值订单
- `GET /app/order/detail/{orderId}`
  订单详情
- `POST /app/order/activateCode`
  卡密激活

## 四、后台接口清单

### 模型配置

- `GET /admin/model/page`
- `POST /admin/model/add`
- `PUT /admin/model/edit`
- `GET /admin/modelVersion/page`
- `POST /admin/modelVersion/add`

### 任务管理

- `GET /admin/task/page`
- `GET /admin/task/detail/{taskId}`
- `POST /admin/task/retry/{taskId}`

### 订单管理

- `GET /admin/order/page`
- `GET /admin/order/detail/{orderId}`

### 用户资产

- `GET /admin/user/page`
- `GET /admin/wallet/flowPage`
- `POST /admin/wallet/grantPower`

## 五、第一阶段最低接口范围

如果先做 MVP，建议优先只实现：

- `POST /app/auth/wxLogin`
- `GET /app/model/list`
- `GET /app/model/detail/{modelId}`
- `POST /app/task/submitImage`
- `GET /app/task/detail/{taskId}`
- `GET /app/work/page`
- `GET /app/wallet/info`
- `GET /admin/model/page`
- `POST /admin/model/add`
- `GET /admin/task/page`
