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
