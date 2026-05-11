-- AI 创作小程序基础表
-- 执行前请确认已导入若依基础 SQL

create table if not exists ai_c_model (
    model_id        bigint          not null auto_increment comment '模型ID',
    model_code      varchar(64)     not null comment '模型编码',
    model_name      varchar(64)     not null comment '模型名称',
    model_type      varchar(20)     not null comment '模型类型',
    provider        varchar(32)     default '' comment '服务商',
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

create table if not exists ai_c_model_version (
    version_id      bigint          not null auto_increment comment '版本ID',
    model_id        bigint          not null comment '模型ID',
    version_code    varchar(64)     not null comment '版本编码',
    version_name    varchar(64)     not null comment '版本名称',
    power_cost      int             default 0 comment '单次消耗算力',
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
