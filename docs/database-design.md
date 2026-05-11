# 数据库设计初稿

## 设计原则

- 若依系统表保持原样。
- 业务表统一使用 `ai_c_` 前缀。
- 所有金额和算力字段保留冗余日志，不直接只看余额。
- 任务、订单、作品三类数据都要有状态字段。

## 1. 用户相关

### `ai_c_user`

| 字段 | 类型 | 说明 |
|---|---|---|
| id | bigint | 主键 |
| user_no | varchar(32) | 用户编号 |
| nick_name | varchar(64) | 昵称 |
| avatar | varchar(255) | 头像 |
| mobile | varchar(20) | 手机号 |
| status | char(1) | 状态 |
| invite_code | varchar(32) | 邀请码 |
| inviter_user_id | bigint | 邀请人 |
| activate_status | char(1) | 激活状态 |
| activate_time | datetime | 激活时间 |
| create_time | datetime | 创建时间 |
| update_time | datetime | 更新时间 |

### `ai_c_user_auth`

| 字段 | 类型 | 说明 |
|---|---|---|
| id | bigint | 主键 |
| user_id | bigint | 用户 ID |
| auth_type | varchar(20) | 登录类型 |
| openid | varchar(64) | 微信 openid |
| unionid | varchar(64) | 微信 unionid |
| session_key | varchar(128) | 会话信息 |
| create_time | datetime | 创建时间 |

## 2. 算力与资产

### `ai_c_wallet`

| 字段 | 类型 | 说明 |
|---|---|---|
| id | bigint | 主键 |
| user_id | bigint | 用户 ID |
| balance_power | int | 可用算力 |
| freeze_power | int | 冻结算力 |
| total_recharge_power | int | 累计充值算力 |
| total_consume_power | int | 累计消耗算力 |
| total_give_power | int | 累计赠送算力 |
| update_time | datetime | 更新时间 |

### `ai_c_wallet_flow`

| 字段 | 类型 | 说明 |
|---|---|---|
| id | bigint | 主键 |
| user_id | bigint | 用户 ID |
| biz_type | varchar(32) | 业务类型 |
| biz_id | bigint | 关联业务 ID |
| change_type | varchar(20) | 增加/扣减/冻结/解冻 |
| power_num | int | 算力值 |
| before_balance | int | 变更前余额 |
| after_balance | int | 变更后余额 |
| remark | varchar(255) | 备注 |
| create_time | datetime | 创建时间 |

## 3. 模型配置

### `ai_c_model`

| 字段 | 类型 | 说明 |
|---|---|---|
| id | bigint | 主键 |
| model_code | varchar(64) | 模型编码 |
| model_name | varchar(64) | 模型名称 |
| model_type | varchar(20) | 文本/图片/视频 |
| provider | varchar(32) | 服务商 |
| cover_url | varchar(255) | 封面 |
| intro | varchar(255) | 简介 |
| status | char(1) | 上下架状态 |
| sort | int | 排序 |
| create_time | datetime | 创建时间 |

### `ai_c_model_version`

| 字段 | 类型 | 说明 |
|---|---|---|
| id | bigint | 主键 |
| model_id | bigint | 模型 ID |
| version_code | varchar(64) | 版本编码 |
| version_name | varchar(64) | 版本名称 |
| power_cost | int | 单次消耗算力 |
| support_ratio | varchar(255) | 支持比例，JSON |
| support_style | varchar(2000) | 支持风格，JSON |
| support_mode | varchar(255) | 文生图/图生图等 |
| ext_config | text | 扩展配置 |
| status | char(1) | 状态 |
| create_time | datetime | 创建时间 |

## 4. 创作任务

### `ai_c_task`

| 字段 | 类型 | 说明 |
|---|---|---|
| id | bigint | 主键 |
| task_no | varchar(32) | 任务编号 |
| user_id | bigint | 用户 ID |
| model_id | bigint | 模型 ID |
| model_version_id | bigint | 模型版本 ID |
| task_type | varchar(20) | 文本/图片/视频 |
| create_mode | varchar(20) | 文生图/图生图 |
| prompt_text | text | 正向提示词 |
| negative_prompt | text | 反向提示词 |
| style_code | varchar(64) | 风格 |
| ratio_code | varchar(32) | 比例 |
| source_url | varchar(255) | 原图地址 |
| status | varchar(20) | 任务状态 |
| power_cost | int | 消耗算力 |
| third_task_id | varchar(128) | 第三方任务 ID |
| fail_reason | varchar(255) | 失败原因 |
| submit_time | datetime | 提交时间 |
| finish_time | datetime | 完成时间 |
| create_time | datetime | 创建时间 |

### `ai_c_task_result`

| 字段 | 类型 | 说明 |
|---|---|---|
| id | bigint | 主键 |
| task_id | bigint | 任务 ID |
| result_type | varchar(20) | 图片/视频 |
| file_url | varchar(255) | 文件地址 |
| cover_url | varchar(255) | 封面 |
| width | int | 宽 |
| height | int | 高 |
| duration | int | 视频时长 |
| seq_no | int | 序号 |
| create_time | datetime | 创建时间 |

## 5. 作品中心

### `ai_c_work`

| 字段 | 类型 | 说明 |
|---|---|---|
| id | bigint | 主键 |
| user_id | bigint | 用户 ID |
| task_id | bigint | 来源任务 ID |
| work_type | varchar(20) | 图片/视频/文本 |
| title | varchar(128) | 标题 |
| prompt_text | text | 提示词 |
| cover_url | varchar(255) | 封面 |
| file_url | varchar(255) | 文件地址 |
| is_public | char(1) | 是否公开 |
| status | varchar(20) | 状态 |
| create_time | datetime | 创建时间 |

## 6. 套餐与订单

### `ai_c_package`

| 字段 | 类型 | 说明 |
|---|---|---|
| id | bigint | 主键 |
| package_name | varchar(64) | 套餐名称 |
| package_type | varchar(20) | 充值/会员/激活 |
| price_amount | decimal(10,2) | 金额 |
| give_power | int | 获得算力 |
| extra_power | int | 赠送算力 |
| status | char(1) | 状态 |
| sort | int | 排序 |
| create_time | datetime | 创建时间 |

### `ai_c_pay_order`

| 字段 | 类型 | 说明 |
|---|---|---|
| id | bigint | 主键 |
| order_no | varchar(32) | 订单号 |
| user_id | bigint | 用户 ID |
| package_id | bigint | 套餐 ID |
| order_type | varchar(20) | 充值/会员/激活 |
| order_status | varchar(20) | 订单状态 |
| pay_type | varchar(20) | 支付方式 |
| total_amount | decimal(10,2) | 支付金额 |
| total_power | int | 到账算力 |
| pay_time | datetime | 支付时间 |
| third_order_no | varchar(64) | 第三方单号 |
| create_time | datetime | 创建时间 |

### `ai_c_activation_code`

| 字段 | 类型 | 说明 |
|---|---|---|
| id | bigint | 主键 |
| code_no | varchar(64) | 卡密 |
| package_id | bigint | 套餐 ID |
| status | varchar(20) | 未使用/已使用/已失效 |
| use_user_id | bigint | 使用人 |
| use_time | datetime | 使用时间 |
| expire_time | datetime | 过期时间 |
| create_time | datetime | 创建时间 |

## 7. 团队关系

### `ai_c_team_relation`

| 字段 | 类型 | 说明 |
|---|---|---|
| id | bigint | 主键 |
| user_id | bigint | 用户 ID |
| parent_user_id | bigint | 上级用户 ID |
| level_no | int | 层级 |
| bind_time | datetime | 绑定时间 |
| create_time | datetime | 创建时间 |

## 第一版必须完成的表

建议先只建这些：

- `ai_c_user`
- `ai_c_user_auth`
- `ai_c_wallet`
- `ai_c_wallet_flow`
- `ai_c_model`
- `ai_c_model_version`
- `ai_c_task`
- `ai_c_task_result`
- `ai_c_work`
- `ai_c_package`
- `ai_c_pay_order`

卡密和团队关系可以放到第二阶段。
