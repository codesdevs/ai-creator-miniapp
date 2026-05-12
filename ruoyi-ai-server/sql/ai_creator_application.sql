-- AI 应用广场与创作工作台配置

create table if not exists ai_c_app_category (
    category_id    bigint       not null auto_increment comment '分类ID',
    category_code  varchar(64)  not null comment '分类编码',
    category_name  varchar(64)  not null comment '分类名称',
    parent_id      bigint       default 0 comment '父分类ID',
    icon_url       varchar(255) default '' comment '分类图标',
    sort           int          default 0 comment '排序',
    status         char(1)      default '0' comment '状态（0启用 1停用）',
    create_time    datetime     default current_timestamp comment '创建时间',
    update_time    datetime     default null comment '更新时间',
    primary key (category_id),
    unique key uk_ai_c_app_category_code (category_code)
) comment = 'AI应用分类';

create table if not exists ai_c_app (
    app_id            bigint       not null auto_increment comment '应用ID',
    category_id       bigint       not null comment '分类ID',
    app_code          varchar(64)  not null comment '应用编码',
    app_name          varchar(64)  not null comment '应用名称',
    app_type          varchar(32)  not null comment '应用类型 MODEL/TEMPLATE/TOOL/AGENT/WORKFLOW',
    ability_type      varchar(32)  not null comment '能力类型 TEXT/IMAGE/VIDEO/AUDIO/MIXED',
    icon_url          varchar(255) default '' comment '图标',
    card_image_url    varchar(255) default '' comment '首页卡片图',
    description       varchar(255) default '' comment '副标题',
    intro             varchar(500) default '' comment '应用介绍',
    route_url         varchar(255) default '' comment '前端路由',
    model_id          bigint       default null comment '默认模型ID',
    model_version_id  bigint       default null comment '默认模型版本ID',
    pricing_mode      varchar(20)  default 'FIXED' comment '计费模式 FIXED/DYNAMIC',
    power_cost        int          default 0 comment '默认算力',
    tags              varchar(500) default '' comment '标签JSON',
    form_schema       longtext     comment '应用表单配置JSON',
    is_hot            char(1)      default '1' comment '是否热门（0是 1否）',
    is_recommend      char(1)      default '1' comment '是否推荐（0是 1否）',
    sort              int          default 0 comment '排序',
    status            char(1)      default '0' comment '状态（0上架 1下架）',
    create_time       datetime     default current_timestamp comment '创建时间',
    update_time       datetime     default null comment '更新时间',
    primary key (app_id),
    unique key uk_ai_c_app_code (app_code),
    key idx_ai_c_app_category (category_id),
    key idx_ai_c_app_status_sort (status, sort)
) comment = 'AI应用入口';

create table if not exists ai_c_app_mode (
    mode_id          bigint       not null auto_increment comment '模式ID',
    app_id           bigint       not null comment '应用ID',
    mode_code        varchar(64)  not null comment '模式编码',
    mode_name        varchar(64)  not null comment '模式名称',
    mode_type        varchar(32)  not null comment '模式类型',
    placeholder      varchar(255) default '' comment '输入框占位',
    intro            varchar(500) default '' comment '模式说明',
    power_cost       int          default 0 comment '默认算力',
    prompt_template  text         comment '提示词模板',
    form_schema      longtext     comment '模式表单配置JSON',
    sort             int          default 0 comment '排序',
    status           char(1)      default '0' comment '状态（0启用 1停用）',
    create_time      datetime     default current_timestamp comment '创建时间',
    update_time      datetime     default null comment '更新时间',
    primary key (mode_id),
    unique key uk_ai_c_app_mode (app_id, mode_code),
    key idx_ai_c_app_mode_app (app_id)
) comment = 'AI应用模式';

create table if not exists ai_c_app_model_relation (
    relation_id        bigint       not null auto_increment comment '关系ID',
    app_id             bigint       not null comment '应用ID',
    model_id           bigint       not null comment '模型ID',
    default_version_id bigint       default null comment '默认版本ID',
    display_name       varchar(64)  default '' comment '前台展示名',
    intro              varchar(500) default '' comment '模型入口说明',
    sort               int          default 0 comment '排序',
    status             char(1)      default '0' comment '状态（0启用 1停用）',
    create_time        datetime     default current_timestamp comment '创建时间',
    update_time        datetime     default null comment '更新时间',
    primary key (relation_id),
    unique key uk_ai_c_app_model (app_id, model_id),
    key idx_ai_c_app_model_app (app_id)
) comment = 'AI应用可用模型';

create table if not exists ai_c_style_preset (
    style_id       bigint       not null auto_increment comment '风格ID',
    style_code     varchar(64)  not null comment '风格编码',
    style_name     varchar(64)  not null comment '风格名称',
    style_type     varchar(32)  default 'IMAGE' comment '风格类型',
    cover_url      varchar(255) default '' comment '封面图',
    prompt_suffix  varchar(500) default '' comment '提示词追加',
    sort           int          default 0 comment '排序',
    status         char(1)      default '0' comment '状态（0启用 1停用）',
    create_time    datetime     default current_timestamp comment '创建时间',
    update_time    datetime     default null comment '更新时间',
    primary key (style_id),
    unique key uk_ai_c_style_code (style_code)
) comment = 'AI风格预设';

create table if not exists ai_c_model_version_style (
    id          bigint   not null auto_increment comment 'ID',
    version_id  bigint   not null comment '版本ID',
    style_id    bigint   not null comment '风格ID',
    primary key (id),
    unique key uk_ai_c_version_style (version_id, style_id)
) comment = '模型版本风格关系';

set @sql = (
    select if(count(*) = 0, 'alter table ai_c_model_version add column version_intro varchar(1000) default '''' comment ''版本介绍''', 'select 1')
    from information_schema.columns where table_schema = database() and table_name = 'ai_c_model_version' and column_name = 'version_intro'
);
prepare stmt from @sql; execute stmt; deallocate prepare stmt;

set @sql = (
    select if(count(*) = 0, 'alter table ai_c_model_version add column support_size varchar(500) default '''' comment ''支持尺寸JSON''', 'select 1')
    from information_schema.columns where table_schema = database() and table_name = 'ai_c_model_version' and column_name = 'support_size'
);
prepare stmt from @sql; execute stmt; deallocate prepare stmt;

set @sql = (
    select if(count(*) = 0, 'alter table ai_c_model_version add column default_ratio varchar(32) default '''' comment ''默认比例''', 'select 1')
    from information_schema.columns where table_schema = database() and table_name = 'ai_c_model_version' and column_name = 'default_ratio'
);
prepare stmt from @sql; execute stmt; deallocate prepare stmt;

set @sql = (
    select if(count(*) = 0, 'alter table ai_c_model_version add column default_size varchar(32) default '''' comment ''默认尺寸''', 'select 1')
    from information_schema.columns where table_schema = database() and table_name = 'ai_c_model_version' and column_name = 'default_size'
);
prepare stmt from @sql; execute stmt; deallocate prepare stmt;

set @sql = (
    select if(count(*) = 0, 'alter table ai_c_model_version add column mode_config longtext comment ''模式配置JSON''', 'select 1')
    from information_schema.columns where table_schema = database() and table_name = 'ai_c_model_version' and column_name = 'mode_config'
);
prepare stmt from @sql; execute stmt; deallocate prepare stmt;

set @sql = (
    select if(count(*) = 0, 'alter table ai_c_task add column app_id bigint default null comment ''来源应用ID''', 'select 1')
    from information_schema.columns where table_schema = database() and table_name = 'ai_c_task' and column_name = 'app_id'
);
prepare stmt from @sql; execute stmt; deallocate prepare stmt;

set @sql = (
    select if(count(*) = 0, 'alter table ai_c_task add column mode_id bigint default null comment ''应用模式ID''', 'select 1')
    from information_schema.columns where table_schema = database() and table_name = 'ai_c_task' and column_name = 'mode_id'
);
prepare stmt from @sql; execute stmt; deallocate prepare stmt;

set @sql = (
    select if(count(*) = 0, 'alter table ai_c_task add column style_id bigint default null comment ''风格ID''', 'select 1')
    from information_schema.columns where table_schema = database() and table_name = 'ai_c_task' and column_name = 'style_id'
);
prepare stmt from @sql; execute stmt; deallocate prepare stmt;

set @sql = (
    select if(count(*) = 0, 'alter table ai_c_task add column size_code varchar(32) default '''' comment ''图片尺寸''', 'select 1')
    from information_schema.columns where table_schema = database() and table_name = 'ai_c_task' and column_name = 'size_code'
);
prepare stmt from @sql; execute stmt; deallocate prepare stmt;

set @sql = (
    select if(count(*) = 0, 'alter table ai_c_task add column input_params longtext comment ''完整输入参数JSON''', 'select 1')
    from information_schema.columns where table_schema = database() and table_name = 'ai_c_task' and column_name = 'input_params'
);
prepare stmt from @sql; execute stmt; deallocate prepare stmt;

insert into ai_c_app_category (category_id, category_code, category_name, sort, status)
values
    (1, 'TEXT_CREATE', '文本创作', 1, '0'),
    (2, 'IMAGE_CREATE', '图片创作', 2, '0'),
    (3, 'VIDEO_CREATE', '视频创作', 3, '0'),
    (4, 'IMAGE_TOOL', '图片工具箱', 4, '0'),
    (5, 'AI_AGENT', 'AI智能体', 5, '0')
on duplicate key update category_name = values(category_name), sort = values(sort), status = values(status);

insert into ai_c_app
    (app_id, category_id, app_code, app_name, app_type, ability_type, card_image_url, description, intro, route_url, pricing_mode, power_cost, sort, status)
values
    (1, 1, 'copywriting', '文案创作', 'TEMPLATE', 'TEXT', '/static/images/application/index/wbcz/wacz.png', '爆文自带流量', '智能生成高质量文案，覆盖营销、广告、社交媒体等场景。', '/pages/create/text', 'FIXED', 2, 1, '0'),
    (2, 1, 'polish', '文案润色', 'TEMPLATE', 'TEXT', '/static/images/application/index/wbcz/wars.png', '文案重新编排', '对现有文案进行润色、改写和风格强化。', '/pages/create/text', 'FIXED', 2, 2, '0'),
    (3, 1, 'imitate', '文案仿写', 'TEMPLATE', 'TEXT', '/static/images/application/index/wbcz/wafx.png', '模仿生成相似文案', '根据样例文案仿写出结构和风格相近的新内容。', '/pages/create/text', 'FIXED', 2, 3, '0'),
    (4, 1, 'revise', '文案订正', 'TEMPLATE', 'TEXT', '/static/images/application/index/wbcz/wadz.png', '快速、准确、自然', '纠正文案中的表达、错别字和逻辑问题。', '/pages/create/text', 'FIXED', 2, 4, '0'),
    (5, 1, 'expand', '文案扩写', 'TEMPLATE', 'TEXT', '/static/images/application/index/wbcz/wakx.png', '一句话生成专业文案', '将短句扩写成完整且可发布的文案。', '/pages/create/text', 'FIXED', 2, 5, '0'),
    (6, 1, 'summary', '文案精简', 'TEMPLATE', 'TEXT', '/static/images/application/index/wbcz/wajj.png', '快速提炼精准表达', '压缩长文案，保留核心卖点。', '/pages/create/text', 'FIXED', 2, 6, '0'),
    (20, 2, 'image_create', '图片创作', 'MODEL', 'IMAGE', '/static/images/application/index/tpcz/jmai.png', '多模型图片创作', '聚合即梦、通义万象、可灵等图片创作模型。', '/pages/create/image-studio', 'DYNAMIC', 20, 1, '0')
on duplicate key update app_name = values(app_name), card_image_url = values(card_image_url), description = values(description), intro = values(intro), route_url = values(route_url), pricing_mode = values(pricing_mode), power_cost = values(power_cost), sort = values(sort), status = values(status);

insert into ai_c_app_mode
    (app_id, mode_code, mode_name, mode_type, placeholder, intro, power_cost, sort, status)
values
    (1, 'copy_create', '文案创作', 'TEXT_TO_TEXT', '请输入文案创作的提示词和创作要求', '根据要求生成原创文案。', 2, 1, '0'),
    (1, 'imitate', '文案仿写', 'TEXT_TO_TEXT', '请输入对应的文案内容，如整段的文案内容', '参考原文结构和语气进行仿写。', 2, 2, '0'),
    (1, 'polish', '文案润色', 'TEXT_TO_TEXT', '请输入对应的文案内容，如整段的文案内容', '提升表达质感与转化力。', 2, 3, '0'),
    (1, 'expand', '文案扩写', 'TEXT_TO_TEXT', '请输入需要扩写的文案内容', '补充细节和卖点。', 2, 4, '0'),
    (1, 'correct', '文案订正', 'TEXT_TO_TEXT', '请输入需要订正的文案内容', '修正错别字和病句。', 2, 5, '0'),
    (1, 'summary', '文案精简', 'TEXT_TO_TEXT', '请输入需要精简的文案内容', '提炼核心内容。', 2, 6, '0'),
    (20, 'TEXT_TO_IMAGE', '文生图片', 'TEXT_TO_IMAGE', '输入想要绘制的画面场景、风格和细节', '根据文字描述生成图片。', 20, 1, '0'),
    (20, 'IMAGE_TO_IMAGE', '图生图片', 'IMAGE_TO_IMAGE', '上传参考图并描述需要调整的内容', '基于参考图生成或编辑图片。', 22, 2, '0')
on duplicate key update mode_name = values(mode_name), mode_type = values(mode_type), placeholder = values(placeholder), intro = values(intro), power_cost = values(power_cost), sort = values(sort), status = values(status);

insert into ai_c_app_model_relation (app_id, model_id, default_version_id, display_name, intro, sort, status)
values
    (20, 1, 1, '即梦AI', '字节跳动图片模型', 1, '0'),
    (20, 2, 3, '通义万象', '阿里通义AI大模型', 2, '0'),
    (20, 3, 4, '可灵AI', '快手AI大模型', 3, '0')
on duplicate key update default_version_id = values(default_version_id), display_name = values(display_name), intro = values(intro), sort = values(sort), status = values(status);

update ai_c_model_version
set version_intro = case version_code
    when 'jimeng-3.0' then '即梦AI-3.0支持多模态输入与实时编辑，商用级输出，独创版权保护算法，为专业设计者而生。'
    when 'jimeng-4.0' then '即梦AI-4.0支持单次输入多张图像及复合编辑，提升中文生图准确率，支持4K超高清输出。'
    when 'wanxiang-v1' then '通义万象适合中文语义理解和东方审美风格生成。'
    when 'keling-v1' then '可灵AI适合视频与动态视觉创意。'
    else version_intro
end,
support_size = if(support_size is null or support_size = '', '["1K","2K","4K"]', support_size),
default_ratio = if(default_ratio is null or default_ratio = '', '9:16', default_ratio),
default_size = if(default_size is null or default_size = '', '2K', default_size)
where version_code in ('jimeng-3.0', 'jimeng-4.0', 'wanxiang-v1', 'keling-v1');

insert into ai_c_style_preset (style_id, style_code, style_name, style_type, cover_url, prompt_suffix, sort, status)
values
    (1, 'CUSTOM', '自定义', 'IMAGE', '', '', 1, '0'),
    (2, 'GONGBI', '新工笔画', 'IMAGE', '', '新工笔画风格', 2, '0'),
    (3, 'VAN_GOGH', '梵高风', 'IMAGE', '', '梵高油画风格', 3, '0'),
    (4, 'CHINESE', '中国画风', 'IMAGE', '', '中国画风格', 4, '0'),
    (5, 'FANTASY', '奇幻风格', 'IMAGE', '', '奇幻艺术风格', 5, '0'),
    (6, 'ANIME', '动漫风格', 'IMAGE', '', '动漫插画风格', 6, '0'),
    (7, 'CARTOON', '卡通风格', 'IMAGE', '', '卡通电影风格', 7, '0'),
    (8, 'REALISTIC', '写实风', 'IMAGE', '', '写实摄影风格', 8, '0'),
    (9, 'SKETCH', '素描风', 'IMAGE', '', '素描线稿风格', 9, '0'),
    (10, 'PHOTO', '摄影风', 'IMAGE', '', '自然摄影风格', 10, '0'),
    (11, 'CLAY', '黏土风', 'IMAGE', '', '黏土玩偶风格', 11, '0'),
    (12, 'BLACK_WHITE', '黑白风格', 'IMAGE', '', '黑白影像风格', 12, '0'),
    (13, 'JAPANESE_ANIME', '日漫风格', 'IMAGE', '', '日式动漫风格', 13, '0'),
    (14, 'MOVIE', '电影风格', 'IMAGE', '', '电影镜头风格', 14, '0'),
    (15, 'WATERCOLOR', '浅水彩', 'IMAGE', '', '浅水彩风格', 15, '0'),
    (16, 'PIXEL', '像素风', 'IMAGE', '', '像素游戏风格', 16, '0')
on duplicate key update style_name = values(style_name), style_type = values(style_type), prompt_suffix = values(prompt_suffix), sort = values(sort), status = values(status);

insert ignore into ai_c_model_version_style (version_id, style_id)
select v.version_id, s.style_id
from ai_c_model_version v
join ai_c_style_preset s on s.status = '0'
where v.model_id in (1, 2, 3);
