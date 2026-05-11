-- AI 创作小程序基础表
-- 执行前请确认已导入若依基础 SQL

create table if not exists ai_c_provider (
    provider_id      bigint          not null auto_increment comment '提供商ID',
    provider_name    varchar(64)     not null comment '提供商名称',
    provider_code    varchar(64)     not null comment '提供商编码',
    provider_type    varchar(20)     default 'OFFICIAL' comment '提供商类型',
    icon             varchar(255)    default '' comment '图标',
    website          varchar(255)    default '' comment '官网地址',
    status           char(1)         default '0' comment '状态（0正常 1停用）',
    remark           varchar(500)    default '' comment '备注',
    create_by        varchar(64)     default '' comment '创建者',
    create_time      datetime        default current_timestamp comment '创建时间',
    update_by        varchar(64)     default '' comment '更新者',
    update_time      datetime        default null comment '更新时间',
    primary key (provider_id),
    unique key uk_ai_c_provider_code (provider_code)
) engine=innodb auto_increment=1 comment='AI提供商表';

create table if not exists ai_c_provider_channel (
    channel_id        bigint          not null auto_increment comment '渠道ID',
    provider_id       bigint          not null comment '提供商ID',
    channel_name      varchar(64)     not null comment '渠道名称',
    channel_code      varchar(64)     not null comment '渠道编码',
    base_url          varchar(255)    not null comment '基础地址',
    api_key           varchar(512)    default '' comment 'API Key',
    api_secret        varchar(512)    default '' comment 'API Secret',
    proxy_enabled     char(1)         default '0' comment '是否代理（0否 1是）',
    priority          int             default 0 comment '优先级',
    weight            int             default 100 comment '权重',
    timeout_ms        int             default 60000 comment '超时时间毫秒',
    max_concurrency   int             default 0 comment '最大并发',
    rpm_limit         int             default 0 comment 'RPM限制',
    tpm_limit         int             default 0 comment 'TPM限制',
    is_fallback       char(1)         default '0' comment '是否兜底（0否 1是）',
    health_status     varchar(20)     default 'UNKNOWN' comment '健康状态',
    status            char(1)         default '0' comment '状态（0正常 1停用）',
    remark            varchar(500)    default '' comment '备注',
    create_by         varchar(64)     default '' comment '创建者',
    create_time       datetime        default current_timestamp comment '创建时间',
    update_by         varchar(64)     default '' comment '更新者',
    update_time       datetime        default null comment '更新时间',
    primary key (channel_id),
    unique key uk_ai_c_provider_channel_code (channel_code),
    key idx_ai_c_provider_channel_provider_id (provider_id)
) engine=innodb auto_increment=1 comment='AI提供商渠道表';

create table if not exists ai_c_channel_model_relation (
    relation_id        bigint          not null auto_increment comment '映射ID',
    channel_id         bigint          not null comment '渠道ID',
    model_version_id   bigint          not null comment '模型版本ID',
    remote_model_name  varchar(128)    not null comment '渠道实际模型名',
    enabled            char(1)         default '0' comment '状态（0启用 1停用）',
    price_ratio        decimal(10,4)   default 1.0000 comment '价格系数',
    priority           int             default 0 comment '优先级',
    weight             int             default 100 comment '权重',
    max_qps            int             default 0 comment '最大QPS',
    remark             varchar(500)    default '' comment '备注',
    create_by          varchar(64)     default '' comment '创建者',
    create_time        datetime        default current_timestamp comment '创建时间',
    update_by          varchar(64)     default '' comment '更新者',
    update_time        datetime        default null comment '更新时间',
    primary key (relation_id),
    unique key uk_ai_c_channel_model_relation (channel_id, model_version_id),
    key idx_ai_c_cmr_model_version_id (model_version_id)
) engine=innodb auto_increment=1 comment='AI渠道模型映射表';

create table if not exists ai_c_model (
    model_id        bigint          not null auto_increment comment '模型ID',
    model_code      varchar(64)     not null comment '模型编码',
    model_name      varchar(64)     not null comment '模型名称',
    model_type      varchar(20)     not null comment '模型类型',
    provider        varchar(32)     default '' comment '服务商',
    official_provider_id bigint      default null comment '官方提供商ID',
    capabilities    text            comment '能力标签JSON',
    cover_url       varchar(255)    default '' comment '封面地址',
    intro           varchar(255)    default '' comment '模型简介',
    status          char(1)         default '0' comment '状态（0正常 1停用）',
    sort            int             default 0 comment '排序',
    remark          varchar(500)    default '' comment '备注',
    create_by       varchar(64)     default '' comment '创建者',
    create_time     datetime        default current_timestamp comment '创建时间',
    update_by       varchar(64)     default '' comment '更新者',
    update_time     datetime        default null comment '更新时间',
    primary key (model_id),
    unique key uk_ai_c_model_code (model_code)
) engine=innodb auto_increment=1 comment='AI模型配置表';

create table if not exists ai_c_user (
    user_id              bigint          not null auto_increment comment '用户ID',
    user_no              varchar(32)     not null comment '用户编号',
    nick_name            varchar(64)     not null comment '昵称',
    avatar               varchar(255)    default '' comment '头像',
    email                varchar(64)     default '' comment '邮箱',
    mobile               varchar(20)     default '' comment '手机号',
    status               char(1)         default '0' comment '状态（0正常 1停用）',
    invite_code          varchar(32)     default '' comment '邀请码',
    inviter_user_id      bigint          default null comment '邀请人',
    activate_status      char(1)         default '0' comment '激活状态（0未激活 1已激活）',
    activate_time        datetime        default null comment '激活时间',
    last_login_ip        varchar(128)    default '' comment '最近登录IP',
    last_login_device    varchar(255)    default '' comment '最近登录设备',
    last_login_time      datetime        default null comment '最近登录时间',
    create_time          datetime        default current_timestamp comment '创建时间',
    update_time          datetime        default current_timestamp comment '更新时间',
    primary key (user_id),
    unique key uk_ai_c_user_user_no (user_no),
    unique key uk_ai_c_user_invite_code (invite_code),
    unique key uk_ai_c_user_email (email),
    unique key uk_ai_c_user_mobile (mobile)
) engine=innodb auto_increment=1 comment='C端用户表';

create table if not exists ai_c_user_auth (
    auth_id              bigint          not null auto_increment comment '认证ID',
    user_id              bigint          not null comment '用户ID',
    auth_type            varchar(20)     not null comment '认证类型',
    openid               varchar(64)     not null comment 'openid',
    unionid              varchar(64)     default '' comment 'unionid',
    session_key          varchar(128)    default '' comment 'sessionKey',
    auth_nick_name       varchar(64)     default '' comment '三方昵称',
    auth_avatar          varchar(255)    default '' comment '三方头像',
    auth_mobile          varchar(20)     default '' comment '三方手机号',
    remark               varchar(255)    default '' comment '备注',
    create_time          datetime        default current_timestamp comment '创建时间',
    update_time          datetime        default current_timestamp comment '更新时间',
    primary key (auth_id),
    unique key uk_ai_c_user_auth_type_openid (auth_type, openid)
) engine=innodb auto_increment=1 comment='C端用户认证表';

create table if not exists ai_c_user_invite (
    invite_id             bigint          not null auto_increment comment '邀请记录ID',
    inviter_user_id       bigint          not null comment '邀请人用户ID',
    invitee_user_id       bigint          not null comment '被邀请人用户ID',
    invite_code           varchar(32)     not null comment '邀请码',
    create_time           datetime        default current_timestamp comment '创建时间',
    primary key (invite_id),
    unique key uk_ai_c_user_invite_invitee (invitee_user_id),
    key idx_ai_c_user_invite_inviter (inviter_user_id),
    key idx_ai_c_user_invite_code (invite_code)
) engine=innodb auto_increment=1 comment='C端用户邀请关系表';

create table if not exists ai_c_model_version (
    version_id      bigint          not null auto_increment comment '版本ID',
    model_id        bigint          not null comment '模型ID',
    version_code    varchar(64)     not null comment '版本编码',
    version_name    varchar(64)     not null comment '版本名称',
    api_model_name  varchar(128)    default '' comment '实际请求模型名',
    power_cost      int             default 0 comment '单次消耗算力',
    context_length  int             default 0 comment '上下文长度',
    input_price     decimal(10,4)   default 0.0000 comment '输入单价',
    output_price    decimal(10,4)   default 0.0000 comment '输出单价',
    speed_level     int             default 0 comment '速度等级',
    quality_level   int             default 0 comment '质量等级',
    support_ratio   varchar(255)    default '' comment '支持比例(JSON)',
    support_style   text            comment '支持风格(JSON)',
    support_mode    varchar(255)    default '' comment '支持模式',
    ext_config      text            comment '扩展配置',
    status          char(1)         default '0' comment '状态（0正常 1停用）',
    remark          varchar(500)    default '' comment '备注',
    create_by       varchar(64)     default '' comment '创建者',
    create_time     datetime        default current_timestamp comment '创建时间',
    update_by       varchar(64)     default '' comment '更新者',
    update_time     datetime        default null comment '更新时间',
    primary key (version_id),
    unique key uk_ai_c_model_version_code (version_code),
    key idx_ai_c_model_version_model_id (model_id)
) engine=innodb auto_increment=1 comment='AI模型版本表';

create table if not exists ai_c_task (
    task_id              bigint          not null auto_increment comment '任务ID',
    task_no              varchar(32)     not null comment '任务编号',
    user_id              bigint          default null comment '用户ID',
    model_id             bigint          not null comment '模型ID',
    model_version_id     bigint          not null comment '模型版本ID',
    task_type            varchar(20)     not null comment '任务类型',
    create_mode          varchar(20)     not null comment '创作模式',
    prompt_text          text            comment '提示词',
    negative_prompt      text            comment '反向提示词',
    style_code           varchar(64)     default '' comment '风格编码',
    ratio_code           varchar(32)     default '' comment '比例编码',
    source_url           varchar(255)    default '' comment '原图地址',
    status               varchar(20)     default 'PENDING' comment '任务状态',
    power_cost           int             default 0 comment '消耗算力',
    third_task_id        varchar(128)    default '' comment '第三方任务ID',
    fail_reason          varchar(255)    default '' comment '失败原因',
    submit_time          datetime        default null comment '提交时间',
    finish_time          datetime        default null comment '完成时间',
    remark               varchar(500)    default '' comment '备注',
    create_by            varchar(64)     default '' comment '创建者',
    create_time          datetime        default current_timestamp comment '创建时间',
    update_by            varchar(64)     default '' comment '更新者',
    update_time          datetime        default null comment '更新时间',
    primary key (task_id),
    unique key uk_ai_c_task_no (task_no),
    key idx_ai_c_task_model_id (model_id),
    key idx_ai_c_task_status (status)
) engine=innodb auto_increment=1 comment='AI任务表';

create table if not exists ai_c_task_result (
    result_id            bigint          not null auto_increment comment '结果ID',
    task_id              bigint          not null comment '任务ID',
    result_type          varchar(20)     not null comment '结果类型',
    file_url             varchar(255)    default '' comment '文件地址',
    cover_url            varchar(255)    default '' comment '封面地址',
    width                int             default 0 comment '宽度',
    height               int             default 0 comment '高度',
    duration             int             default 0 comment '时长',
    seq_no               int             default 1 comment '序号',
    create_time          datetime        default current_timestamp comment '创建时间',
    primary key (result_id),
    key idx_ai_c_task_result_task_id (task_id)
) engine=innodb auto_increment=1 comment='AI任务结果表';

create table if not exists ai_c_wallet (
    wallet_id             bigint          not null auto_increment comment '钱包ID',
    user_id               bigint          not null comment '用户ID',
    balance_power         int             default 0 comment '可用算力',
    freeze_power          int             default 0 comment '冻结算力',
    total_recharge_power  int             default 0 comment '累计充值算力',
    total_consume_power   int             default 0 comment '累计消耗算力',
    total_give_power      int             default 0 comment '累计赠送算力',
    update_time           datetime        default current_timestamp comment '更新时间',
    primary key (wallet_id),
    unique key uk_ai_c_wallet_user_id (user_id)
) engine=innodb auto_increment=1 comment='AI钱包表';

create table if not exists ai_c_wallet_flow (
    flow_id               bigint          not null auto_increment comment '流水ID',
    user_id               bigint          not null comment '用户ID',
    biz_type              varchar(32)     default '' comment '业务类型',
    biz_id                bigint          default null comment '业务ID',
    change_type           varchar(20)     not null comment '变更类型',
    power_num             int             default 0 comment '算力值',
    before_balance        int             default 0 comment '变更前余额',
    after_balance         int             default 0 comment '变更后余额',
    remark                varchar(255)    default '' comment '备注',
    create_time           datetime        default current_timestamp comment '创建时间',
    primary key (flow_id),
    key idx_ai_c_wallet_flow_user_id (user_id)
) engine=innodb auto_increment=1 comment='AI钱包流水表';

create table if not exists ai_c_recharge_package (
    package_id            bigint          not null auto_increment comment '套餐ID',
    package_name          varchar(64)     not null comment '套餐名称',
    package_code          varchar(32)     not null comment '套餐编码',
    power_num             int             default 0 comment '算力数量',
    bonus_power_num       int             default 0 comment '赠送算力',
    sale_price            decimal(10,2)   default 0.00 comment '销售金额',
    original_price        decimal(10,2)   default 0.00 comment '原价金额',
    sort                  int             default 0 comment '排序',
    package_desc          varchar(255)    default '' comment '套餐说明',
    status                char(1)         default '0' comment '状态（0正常 1停用）',
    create_by             varchar(64)     default '' comment '创建者',
    create_time           datetime        default current_timestamp comment '创建时间',
    update_by             varchar(64)     default '' comment '更新者',
    update_time           datetime        default null comment '更新时间',
    remark                varchar(500)    default '' comment '备注',
    primary key (package_id),
    unique key uk_ai_c_recharge_package_code (package_code)
) engine=innodb auto_increment=1 comment='充值套餐表';

create table if not exists ai_c_pay_config (
    pay_config_id         bigint          not null auto_increment comment '支付配置ID',
    config_name           varchar(64)     not null comment '配置名称',
    config_code           varchar(32)     not null comment '配置编码',
    pay_channel           varchar(32)     not null comment '支付渠道',
    mch_id                varchar(64)     default '' comment '商户号',
    app_id                varchar(64)     default '' comment '应用ID',
    notify_url            varchar(255)    default '' comment '回调地址',
    status                char(1)         default '0' comment '状态（0正常 1停用）',
    sort                  int             default 0 comment '排序',
    create_by             varchar(64)     default '' comment '创建者',
    create_time           datetime        default current_timestamp comment '创建时间',
    update_by             varchar(64)     default '' comment '更新者',
    update_time           datetime        default null comment '更新时间',
    remark                varchar(500)    default '' comment '备注',
    primary key (pay_config_id),
    unique key uk_ai_c_pay_config_code (config_code)
) engine=innodb auto_increment=1 comment='支付配置表';

create table if not exists ai_c_order (
    order_id              bigint          not null auto_increment comment '订单ID',
    order_no              varchar(32)     not null comment '订单编号',
    user_id               bigint          not null comment '用户ID',
    package_id            bigint          default null comment '套餐ID',
    package_name          varchar(64)     default '' comment '套餐名称',
    pay_config_id         bigint          default null comment '支付配置ID',
    pay_channel           varchar(32)     default '' comment '支付渠道',
    power_num             int             default 0 comment '到账算力',
    bonus_power_num       int             default 0 comment '赠送算力',
    pay_amount            decimal(10,2)   default 0.00 comment '支付金额',
    order_status          varchar(20)     default 'WAIT_PAY' comment '订单状态',
    third_order_no        varchar(64)     default '' comment '第三方订单号',
    pay_time              datetime        default null comment '支付时间',
    create_by             varchar(64)     default '' comment '创建者',
    create_time           datetime        default current_timestamp comment '创建时间',
    update_by             varchar(64)     default '' comment '更新者',
    update_time           datetime        default null comment '更新时间',
    remark                varchar(500)    default '' comment '备注',
    primary key (order_id),
    unique key uk_ai_c_order_no (order_no),
    key idx_ai_c_order_user_id (user_id),
    key idx_ai_c_order_status (order_status)
) engine=innodb auto_increment=1 comment='充值订单表';

create table if not exists ai_c_card_code (
    card_code_id          bigint          not null auto_increment comment '卡密ID',
    package_id            bigint          not null comment '卡包ID',
    package_name          varchar(64)     default '' comment '卡包名称',
    card_code             varchar(64)     not null comment '卡密编码',
    power_num             int             default 0 comment '基础算力',
    bonus_power_num       int             default 0 comment '赠送算力',
    status                char(1)         default '0' comment '状态（0未使用 1已使用 2停用）',
    used_user_id          bigint          default null comment '使用用户ID',
    order_id              bigint          default null comment '关联订单ID',
    used_time             datetime        default null comment '使用时间',
    create_by             varchar(64)     default '' comment '创建者',
    create_time           datetime        default current_timestamp comment '创建时间',
    update_by             varchar(64)     default '' comment '更新者',
    update_time           datetime        default null comment '更新时间',
    remark                varchar(500)    default '' comment '备注',
    primary key (card_code_id),
    unique key uk_ai_c_card_code_code (card_code),
    key idx_ai_c_card_code_package_id (package_id),
    key idx_ai_c_card_code_status (status)
) engine=innodb auto_increment=1 comment='卡密表';

alter table ai_c_model add column if not exists official_provider_id bigint default null comment '官方提供商ID';
alter table ai_c_model add column if not exists capabilities text comment '能力标签JSON';
alter table ai_c_model_version add column if not exists api_model_name varchar(128) default '' comment '实际请求模型名';
alter table ai_c_model_version add column if not exists context_length int default 0 comment '上下文长度';
alter table ai_c_model_version add column if not exists input_price decimal(10,4) default 0.0000 comment '输入单价';
alter table ai_c_model_version add column if not exists output_price decimal(10,4) default 0.0000 comment '输出单价';
alter table ai_c_model_version add column if not exists speed_level int default 0 comment '速度等级';
alter table ai_c_model_version add column if not exists quality_level int default 0 comment '质量等级';
alter table ai_c_task add column if not exists channel_id bigint default null comment '渠道ID';
alter table ai_c_task add column if not exists channel_model_relation_id bigint default null comment '渠道模型映射ID';
alter table ai_c_task add column if not exists remote_model_name varchar(128) default '' comment '渠道实际模型名';
alter table ai_c_channel_model_relation add column if not exists remote_model_name varchar(128) not null comment '渠道实际模型名';
alter table ai_c_channel_model_relation add column if not exists enabled char(1) default '0' comment '状态（0启用 1停用）';
alter table ai_c_channel_model_relation add column if not exists price_ratio decimal(10,4) default 1.0000 comment '价格系数';
alter table ai_c_channel_model_relation add column if not exists priority int default 0 comment '优先级';
alter table ai_c_channel_model_relation add column if not exists weight int default 100 comment '权重';
alter table ai_c_channel_model_relation add column if not exists max_qps int default 0 comment '最大QPS';
alter table ai_c_channel_model_relation add column if not exists remark varchar(500) default '' comment '备注';
alter table ai_c_channel_model_relation add column if not exists create_by varchar(64) default '' comment '创建者';
alter table ai_c_channel_model_relation add column if not exists create_time datetime default current_timestamp comment '创建时间';
alter table ai_c_channel_model_relation add column if not exists update_by varchar(64) default '' comment '更新者';
alter table ai_c_channel_model_relation add column if not exists update_time datetime default null comment '更新时间';

insert into ai_c_provider (provider_id, provider_name, provider_code, provider_type, status, create_by, remark)
values
    (1, '字节跳动', 'BYTEDANCE', 'OFFICIAL', '0', 'admin', '即梦等模型官方提供商'),
    (2, '阿里云', 'ALIBABA', 'OFFICIAL', '0', 'admin', '通义系列官方提供商'),
    (3, '快手', 'KUAISHOU', 'OFFICIAL', '0', 'admin', '可灵模型官方提供商'),
    (4, 'OpenAI', 'OPENAI', 'OFFICIAL', '0', 'admin', 'OpenAI 官方提供商'),
    (5, 'Anthropic', 'ANTHROPIC', 'OFFICIAL', '0', 'admin', 'Anthropic 官方提供商')
on duplicate key update provider_name = values(provider_name), provider_type = values(provider_type), status = values(status), remark = values(remark);

update ai_c_model m
left join ai_c_provider p on p.provider_code = m.provider
set m.official_provider_id = p.provider_id
where m.official_provider_id is null and m.provider is not null and m.provider <> '';

insert into ai_c_model (model_id, model_code, model_name, model_type, provider, intro, status, sort, create_by)
values
    (1, 'jimeng', '即梦AI', 'IMAGE', 'BYTEDANCE', '字节跳动图片模型', '0', 1, 'admin'),
    (2, 'tongyi-wanxiang', '通义万象', 'IMAGE', 'ALIBABA', '阿里通义AI大模型', '0', 2, 'admin'),
    (3, 'keling', '可灵AI', 'VIDEO', 'KUAISHOU', '快手视频大模型', '0', 3, 'admin')
on duplicate key update model_name = values(model_name), provider = values(provider), intro = values(intro);

insert into ai_c_model_version
    (version_id, model_id, version_code, version_name, power_cost, support_ratio, support_style, support_mode, status, create_by)
values
    (1, 1, 'jimeng-3.0', '即梦3.0', 20, '["1:1","9:16","16:9"]', '["CUSTOM","ANIME","PHOTO"]', 'TEXT_TO_IMAGE,IMAGE_TO_IMAGE', '0', 'admin'),
    (2, 1, 'jimeng-4.0', '即梦4.0', 30, '["1:1","9:16","16:9"]', '["CUSTOM","ANIME","PHOTO"]', 'TEXT_TO_IMAGE,IMAGE_TO_IMAGE', '0', 'admin'),
    (3, 2, 'wanxiang-v1', '通义万象 V1', 25, '["1:1","3:4","4:3"]', '["CUSTOM","CHINESE","PHOTO"]', 'TEXT_TO_IMAGE', '0', 'admin'),
    (4, 3, 'keling-v1', '可灵视频 V1', 50, '["16:9","9:16"]', '["CINEMATIC","REALISTIC"]', 'TEXT_TO_VIDEO,IMAGE_TO_VIDEO', '0', 'admin')
on duplicate key update version_name = values(version_name), power_cost = values(power_cost), status = values(status);

insert into ai_c_wallet (wallet_id, user_id, balance_power, freeze_power, total_recharge_power, total_consume_power, total_give_power, update_time)
values
    (1, 1, 1000, 0, 0, 0, 1000, sysdate())
on duplicate key update balance_power = values(balance_power), total_give_power = values(total_give_power), update_time = sysdate();

insert into ai_c_user (user_id, user_no, nick_name, avatar, mobile, status, invite_code, inviter_user_id, activate_status, activate_time, create_time, update_time)
values
    (1, 'U202605110001', '开发用户', '', '', '0', 'DEV00001', null, '0', null, sysdate(), sysdate())
on duplicate key update nick_name = values(nick_name), update_time = sysdate();

insert into ai_c_user_auth (auth_id, user_id, auth_type, openid, unionid, session_key, create_time)
values
    (1, 1, 'DEV', 'dev-user-1', '', '', sysdate())
on duplicate key update user_id = values(user_id);

insert into ai_c_recharge_package
    (package_id, package_name, package_code, power_num, bonus_power_num, sale_price, original_price, sort, package_desc, status, create_by)
values
    (1, '新手体验包', 'STARTER_100', 100, 20, 9.90, 19.90, 1, '适合首次体验创作能力', '0', 'admin'),
    (2, '进阶创作包', 'ADVANCE_500', 500, 100, 49.90, 69.90, 2, '适合日常图片创作使用', '0', 'admin'),
    (3, '专业高频包', 'PRO_1200', 1200, 300, 99.90, 149.90, 3, '适合高频创作和团队测试', '0', 'admin')
on duplicate key update package_name = values(package_name), power_num = values(power_num), bonus_power_num = values(bonus_power_num), sale_price = values(sale_price), status = values(status);

insert into ai_c_pay_config
    (pay_config_id, config_name, config_code, pay_channel, mch_id, app_id, notify_url, status, sort, create_by, remark)
values
    (1, '微信小程序支付', 'WX_MP', 'WECHAT_MP', '', '', '', '0', 1, 'admin', '微信小程序支付占位配置'),
    (2, '支付宝H5支付', 'ALIPAY_H5', 'ALIPAY_H5', '', '', '', '1', 2, 'admin', '支付宝支付占位配置')
on duplicate key update config_name = values(config_name), pay_channel = values(pay_channel), status = values(status), remark = values(remark);

insert into ai_c_card_code
    (card_code_id, package_id, package_name, card_code, power_num, bonus_power_num, status, create_by, remark)
values
    (1, 1, '新手体验包', 'CKSTARTER000001', 100, 20, '0', 'admin', '示例卡密'),
    (2, 2, '进阶创作包', 'CKADVANCE000001', 500, 100, '0', 'admin', '示例卡密')
on duplicate key update package_name = values(package_name), power_num = values(power_num), bonus_power_num = values(bonus_power_num), status = values(status), remark = values(remark);
