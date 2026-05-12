/*
 Navicat Premium Dump SQL

 Source Server         : localhost-3307-8.0
 Source Server Type    : MySQL
 Source Server Version : 80043 (8.0.43)
 Source Host           : localhost:3307
 Source Schema         : ai-creator

 Target Server Type    : MySQL
 Target Server Version : 80043 (8.0.43)
 File Encoding         : 65001

 Date: 12/05/2026 23:17:35
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for ai_c_app
-- ----------------------------
DROP TABLE IF EXISTS `ai_c_app`;
CREATE TABLE `ai_c_app` (
  `app_id` bigint NOT NULL AUTO_INCREMENT COMMENT '应用ID',
  `category_id` bigint NOT NULL COMMENT '分类ID',
  `app_code` varchar(64) COLLATE utf8mb4_general_ci NOT NULL COMMENT '应用编码',
  `app_name` varchar(64) COLLATE utf8mb4_general_ci NOT NULL COMMENT '应用名称',
  `app_type` varchar(32) COLLATE utf8mb4_general_ci NOT NULL COMMENT '应用类型 MODEL/TEMPLATE/TOOL/AGENT/WORKFLOW',
  `ability_type` varchar(32) COLLATE utf8mb4_general_ci NOT NULL COMMENT '能力类型 TEXT/IMAGE/VIDEO/AUDIO/MIXED',
  `icon_url` varchar(255) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '图标',
  `card_image_url` varchar(255) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '首页卡片图',
  `description` varchar(255) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '副标题',
  `intro` varchar(500) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '应用介绍',
  `route_url` varchar(255) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '前端路由',
  `model_id` bigint DEFAULT NULL COMMENT '默认模型ID',
  `model_version_id` bigint DEFAULT NULL COMMENT '默认模型版本ID',
  `pricing_mode` varchar(20) COLLATE utf8mb4_general_ci DEFAULT 'FIXED' COMMENT '计费模式 FIXED/DYNAMIC',
  `power_cost` int DEFAULT '0' COMMENT '默认算力',
  `tags` varchar(500) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '标签JSON',
  `form_schema` longtext COLLATE utf8mb4_general_ci COMMENT '应用表单配置JSON',
  `is_hot` char(1) COLLATE utf8mb4_general_ci DEFAULT '1' COMMENT '是否热门（0是 1否）',
  `is_recommend` char(1) COLLATE utf8mb4_general_ci DEFAULT '1' COMMENT '是否推荐（0是 1否）',
  `sort` int DEFAULT '0' COMMENT '排序',
  `status` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '状态（0上架 1下架）',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`app_id`),
  UNIQUE KEY `uk_ai_c_app_code` (`app_code`),
  KEY `idx_ai_c_app_category` (`category_id`),
  KEY `idx_ai_c_app_status_sort` (`status`,`sort`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='AI应用入口';

-- ----------------------------
-- Records of ai_c_app
-- ----------------------------
BEGIN;
INSERT INTO `ai_c_app` (`app_id`, `category_id`, `app_code`, `app_name`, `app_type`, `ability_type`, `icon_url`, `card_image_url`, `description`, `intro`, `route_url`, `model_id`, `model_version_id`, `pricing_mode`, `power_cost`, `tags`, `form_schema`, `is_hot`, `is_recommend`, `sort`, `status`, `create_time`, `update_time`) VALUES (1, 1, 'copywriting', '文案创作', 'TEMPLATE', 'TEXT', '', '/static/images/application/index/wbcz/wacz.png', '爆文自带流量', '智能生成高质量文案，覆盖营销、广告、社交媒体等场景。', '/pages/create/text', NULL, NULL, 'FIXED', 2, '', NULL, '1', '1', 1, '0', '2026-05-12 21:51:37', NULL);
INSERT INTO `ai_c_app` (`app_id`, `category_id`, `app_code`, `app_name`, `app_type`, `ability_type`, `icon_url`, `card_image_url`, `description`, `intro`, `route_url`, `model_id`, `model_version_id`, `pricing_mode`, `power_cost`, `tags`, `form_schema`, `is_hot`, `is_recommend`, `sort`, `status`, `create_time`, `update_time`) VALUES (2, 1, 'polish', '文案润色', 'TEMPLATE', 'TEXT', '', '/static/images/application/index/wbcz/wars.png', '文案重新编排', '对现有文案进行润色、改写和风格强化。', '/pages/create/text', NULL, NULL, 'FIXED', 2, '', NULL, '1', '1', 2, '0', '2026-05-12 21:51:37', NULL);
INSERT INTO `ai_c_app` (`app_id`, `category_id`, `app_code`, `app_name`, `app_type`, `ability_type`, `icon_url`, `card_image_url`, `description`, `intro`, `route_url`, `model_id`, `model_version_id`, `pricing_mode`, `power_cost`, `tags`, `form_schema`, `is_hot`, `is_recommend`, `sort`, `status`, `create_time`, `update_time`) VALUES (3, 1, 'imitate', '文案仿写', 'TEMPLATE', 'TEXT', '', '/static/images/application/index/wbcz/wafx.png', '模仿生成相似文案', '根据样例文案仿写出结构和风格相近的新内容。', '/pages/create/text', NULL, NULL, 'FIXED', 2, '', NULL, '1', '1', 3, '0', '2026-05-12 21:51:37', NULL);
INSERT INTO `ai_c_app` (`app_id`, `category_id`, `app_code`, `app_name`, `app_type`, `ability_type`, `icon_url`, `card_image_url`, `description`, `intro`, `route_url`, `model_id`, `model_version_id`, `pricing_mode`, `power_cost`, `tags`, `form_schema`, `is_hot`, `is_recommend`, `sort`, `status`, `create_time`, `update_time`) VALUES (4, 1, 'revise', '文案订正', 'TEMPLATE', 'TEXT', '', '/static/images/application/index/wbcz/wadz.png', '快速、准确、自然', '纠正文案中的表达、错别字和逻辑问题。', '/pages/create/text', NULL, NULL, 'FIXED', 2, '', NULL, '1', '1', 4, '0', '2026-05-12 21:51:37', NULL);
INSERT INTO `ai_c_app` (`app_id`, `category_id`, `app_code`, `app_name`, `app_type`, `ability_type`, `icon_url`, `card_image_url`, `description`, `intro`, `route_url`, `model_id`, `model_version_id`, `pricing_mode`, `power_cost`, `tags`, `form_schema`, `is_hot`, `is_recommend`, `sort`, `status`, `create_time`, `update_time`) VALUES (5, 1, 'expand', '文案扩写', 'TEMPLATE', 'TEXT', '', '/static/images/application/index/wbcz/wakx.png', '一句话生成专业文案', '将短句扩写成完整且可发布的文案。', '/pages/create/text', NULL, NULL, 'FIXED', 2, '', NULL, '1', '1', 5, '0', '2026-05-12 21:51:37', NULL);
INSERT INTO `ai_c_app` (`app_id`, `category_id`, `app_code`, `app_name`, `app_type`, `ability_type`, `icon_url`, `card_image_url`, `description`, `intro`, `route_url`, `model_id`, `model_version_id`, `pricing_mode`, `power_cost`, `tags`, `form_schema`, `is_hot`, `is_recommend`, `sort`, `status`, `create_time`, `update_time`) VALUES (6, 1, 'summary', '文案精简', 'TEMPLATE', 'TEXT', '', '/static/images/application/index/wbcz/wajj.png', '快速提炼精准表达', '压缩长文案，保留核心卖点。', '/pages/create/text', NULL, NULL, 'FIXED', 2, '', NULL, '1', '1', 6, '0', '2026-05-12 21:51:37', NULL);
INSERT INTO `ai_c_app` (`app_id`, `category_id`, `app_code`, `app_name`, `app_type`, `ability_type`, `icon_url`, `card_image_url`, `description`, `intro`, `route_url`, `model_id`, `model_version_id`, `pricing_mode`, `power_cost`, `tags`, `form_schema`, `is_hot`, `is_recommend`, `sort`, `status`, `create_time`, `update_time`) VALUES (20, 2, 'image_create', '图片创作', 'MODEL', 'IMAGE', '', '/static/images/application/index/tpcz/jmai.png', '多模型图片创作', '聚合即梦、通义万象、可灵等图片创作模型。', '/pages/create/image-studio', NULL, NULL, 'DYNAMIC', 20, '', NULL, '1', '1', 1, '0', '2026-05-12 21:51:37', NULL);
COMMIT;

-- ----------------------------
-- Table structure for ai_c_app_category
-- ----------------------------
DROP TABLE IF EXISTS `ai_c_app_category`;
CREATE TABLE `ai_c_app_category` (
  `category_id` bigint NOT NULL AUTO_INCREMENT COMMENT '分类ID',
  `category_code` varchar(64) COLLATE utf8mb4_general_ci NOT NULL COMMENT '分类编码',
  `category_name` varchar(64) COLLATE utf8mb4_general_ci NOT NULL COMMENT '分类名称',
  `parent_id` bigint DEFAULT '0' COMMENT '父分类ID',
  `icon_url` varchar(255) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '分类图标',
  `sort` int DEFAULT '0' COMMENT '排序',
  `status` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '状态（0启用 1停用）',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`category_id`),
  UNIQUE KEY `uk_ai_c_app_category_code` (`category_code`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='AI应用分类';

-- ----------------------------
-- Records of ai_c_app_category
-- ----------------------------
BEGIN;
INSERT INTO `ai_c_app_category` (`category_id`, `category_code`, `category_name`, `parent_id`, `icon_url`, `sort`, `status`, `create_time`, `update_time`) VALUES (1, 'TEXT_CREATE', '文本创作', 0, '', 1, '0', '2026-05-12 21:51:37', NULL);
INSERT INTO `ai_c_app_category` (`category_id`, `category_code`, `category_name`, `parent_id`, `icon_url`, `sort`, `status`, `create_time`, `update_time`) VALUES (2, 'IMAGE_CREATE', '图片创作', 0, '', 2, '0', '2026-05-12 21:51:37', NULL);
INSERT INTO `ai_c_app_category` (`category_id`, `category_code`, `category_name`, `parent_id`, `icon_url`, `sort`, `status`, `create_time`, `update_time`) VALUES (3, 'VIDEO_CREATE', '视频创作', 0, '', 3, '0', '2026-05-12 21:51:37', NULL);
INSERT INTO `ai_c_app_category` (`category_id`, `category_code`, `category_name`, `parent_id`, `icon_url`, `sort`, `status`, `create_time`, `update_time`) VALUES (4, 'IMAGE_TOOL', '图片工具箱', 0, '', 4, '0', '2026-05-12 21:51:37', NULL);
INSERT INTO `ai_c_app_category` (`category_id`, `category_code`, `category_name`, `parent_id`, `icon_url`, `sort`, `status`, `create_time`, `update_time`) VALUES (5, 'AI_AGENT', 'AI智能体', 0, '', 5, '0', '2026-05-12 21:51:37', NULL);
COMMIT;

-- ----------------------------
-- Table structure for ai_c_app_home_card
-- ----------------------------
DROP TABLE IF EXISTS `ai_c_app_home_card`;
CREATE TABLE `ai_c_app_home_card` (
  `card_id` bigint NOT NULL AUTO_INCREMENT COMMENT '卡片ID',
  `section_id` bigint NOT NULL COMMENT '分组ID',
  `app_id` bigint DEFAULT NULL COMMENT '关联应用ID',
  `card_code` varchar(64) COLLATE utf8mb4_general_ci NOT NULL COMMENT '卡片编码',
  `card_name` varchar(64) COLLATE utf8mb4_general_ci NOT NULL COMMENT '卡片名称',
  `subtitle` varchar(128) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '副标题',
  `card_image_url` varchar(255) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '卡片图',
  `action_type` varchar(32) COLLATE utf8mb4_general_ci DEFAULT 'APP' COMMENT '动作类型 APP/ROUTE/TOAST/NONE',
  `action_value` varchar(255) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '动作值',
  `extra_config` longtext COLLATE utf8mb4_general_ci COMMENT '扩展配置JSON',
  `sort` int DEFAULT '0' COMMENT '排序',
  `status` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '状态（0启用 1停用）',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`card_id`),
  UNIQUE KEY `uk_ai_c_app_home_card_code` (`card_code`),
  KEY `idx_ai_c_app_home_card_section` (`section_id`,`status`,`sort`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='AI应用首页卡片';

-- ----------------------------
-- Records of ai_c_app_home_card
-- ----------------------------
BEGIN;
INSERT INTO `ai_c_app_home_card` (`card_id`, `section_id`, `app_id`, `card_code`, `card_name`, `subtitle`, `card_image_url`, `action_type`, `action_value`, `extra_config`, `sort`, `status`, `create_time`, `update_time`) VALUES (1, 1, 1, 'copywriting', '文案创作', '爆文自带流量', '/static/images/application/index/wbcz/wacz.png', 'ROUTE', '/pages/create/text?mode=copywriting', NULL, 1, '0', '2026-05-12 22:04:20', NULL);
INSERT INTO `ai_c_app_home_card` (`card_id`, `section_id`, `app_id`, `card_code`, `card_name`, `subtitle`, `card_image_url`, `action_type`, `action_value`, `extra_config`, `sort`, `status`, `create_time`, `update_time`) VALUES (2, 1, 2, 'polish', '文案润色', '文案重新编排', '/static/images/application/index/wbcz/wars.png', 'ROUTE', '/pages/create/text?mode=polish', NULL, 2, '0', '2026-05-12 22:04:20', NULL);
INSERT INTO `ai_c_app_home_card` (`card_id`, `section_id`, `app_id`, `card_code`, `card_name`, `subtitle`, `card_image_url`, `action_type`, `action_value`, `extra_config`, `sort`, `status`, `create_time`, `update_time`) VALUES (3, 1, 3, 'imitate', '文案仿写', '模仿生成相似文案', '/static/images/application/index/wbcz/wafx.png', 'ROUTE', '/pages/create/text?mode=imitate', NULL, 3, '0', '2026-05-12 22:04:20', NULL);
INSERT INTO `ai_c_app_home_card` (`card_id`, `section_id`, `app_id`, `card_code`, `card_name`, `subtitle`, `card_image_url`, `action_type`, `action_value`, `extra_config`, `sort`, `status`, `create_time`, `update_time`) VALUES (4, 1, 4, 'revise', '文案订正', '快速、准确、自然', '/static/images/application/index/wbcz/wadz.png', 'ROUTE', '/pages/create/text?mode=revise', NULL, 4, '0', '2026-05-12 22:04:20', NULL);
INSERT INTO `ai_c_app_home_card` (`card_id`, `section_id`, `app_id`, `card_code`, `card_name`, `subtitle`, `card_image_url`, `action_type`, `action_value`, `extra_config`, `sort`, `status`, `create_time`, `update_time`) VALUES (5, 1, 5, 'expand', '文案扩写', '一句话生成专业文案', '/static/images/application/index/wbcz/wakx.png', 'ROUTE', '/pages/create/text?mode=expand', NULL, 5, '0', '2026-05-12 22:04:20', NULL);
INSERT INTO `ai_c_app_home_card` (`card_id`, `section_id`, `app_id`, `card_code`, `card_name`, `subtitle`, `card_image_url`, `action_type`, `action_value`, `extra_config`, `sort`, `status`, `create_time`, `update_time`) VALUES (6, 1, 6, 'summary', '文案精简', '快速提炼精准表达', '/static/images/application/index/wbcz/wajj.png', 'ROUTE', '/pages/create/text?mode=summary', NULL, 6, '0', '2026-05-12 22:04:20', NULL);
INSERT INTO `ai_c_app_home_card` (`card_id`, `section_id`, `app_id`, `card_code`, `card_name`, `subtitle`, `card_image_url`, `action_type`, `action_value`, `extra_config`, `sort`, `status`, `create_time`, `update_time`) VALUES (20, 2, 20, 'jimeng', '即梦AI', '字节跳动图片模型', '/static/images/application/index/tpcz/jmai.png', 'ROUTE', '/pages/create/image-studio?model=jimeng', NULL, 1, '0', '2026-05-12 22:04:20', NULL);
INSERT INTO `ai_c_app_home_card` (`card_id`, `section_id`, `app_id`, `card_code`, `card_name`, `subtitle`, `card_image_url`, `action_type`, `action_value`, `extra_config`, `sort`, `status`, `create_time`, `update_time`) VALUES (21, 2, 20, 'keling', '可灵AI', '快手 AI大模型', '/static/images/application/index/tpcz/klai.png', 'ROUTE', '/pages/create/image-studio?model=keling', NULL, 2, '0', '2026-05-12 22:04:20', NULL);
INSERT INTO `ai_c_app_home_card` (`card_id`, `section_id`, `app_id`, `card_code`, `card_name`, `subtitle`, `card_image_url`, `action_type`, `action_value`, `extra_config`, `sort`, `status`, `create_time`, `update_time`) VALUES (22, 2, 20, 'seedream', 'Seedream', '字节跳动图片模型', '/static/images/application/index/tpcz/seedream.png', 'ROUTE', '/pages/create/image-studio?model=seedream', NULL, 3, '0', '2026-05-12 22:04:20', NULL);
INSERT INTO `ai_c_app_home_card` (`card_id`, `section_id`, `app_id`, `card_code`, `card_name`, `subtitle`, `card_image_url`, `action_type`, `action_value`, `extra_config`, `sort`, `status`, `create_time`, `update_time`) VALUES (23, 2, 20, 'banana', 'Nano Banana', '轻量快速出图', '/static/images/application/index/tpcz/banana.png', 'ROUTE', '/pages/create/image-studio?model=banana', NULL, 4, '0', '2026-05-12 22:04:20', NULL);
INSERT INTO `ai_c_app_home_card` (`card_id`, `section_id`, `app_id`, `card_code`, `card_name`, `subtitle`, `card_image_url`, `action_type`, `action_value`, `extra_config`, `sort`, `status`, `create_time`, `update_time`) VALUES (24, 2, NULL, 'gpt-image-2', 'GPT Image', 'OpenAI 图片模型', '/static/images/application/index/tpcz/gpt-image-2.png', 'TOAST', 'GPT Image暂未接入', NULL, 5, '0', '2026-05-12 22:04:20', NULL);
INSERT INTO `ai_c_app_home_card` (`card_id`, `section_id`, `app_id`, `card_code`, `card_name`, `subtitle`, `card_image_url`, `action_type`, `action_value`, `extra_config`, `sort`, `status`, `create_time`, `update_time`) VALUES (25, 2, NULL, 'midjourney', 'Midjourney', '专业图片模型', '/static/images/application/index/tpcz/midjourney.png', 'TOAST', 'Midjourney暂未接入', NULL, 6, '0', '2026-05-12 22:04:20', NULL);
INSERT INTO `ai_c_app_home_card` (`card_id`, `section_id`, `app_id`, `card_code`, `card_name`, `subtitle`, `card_image_url`, `action_type`, `action_value`, `extra_config`, `sort`, `status`, `create_time`, `update_time`) VALUES (26, 2, NULL, 'luma', 'Luma', '视觉生成模型', '/static/images/application/index/tpcz/luma.png', 'TOAST', 'Luma暂未接入', NULL, 7, '0', '2026-05-12 22:04:20', NULL);
INSERT INTO `ai_c_app_home_card` (`card_id`, `section_id`, `app_id`, `card_code`, `card_name`, `subtitle`, `card_image_url`, `action_type`, `action_value`, `extra_config`, `sort`, `status`, `create_time`, `update_time`) VALUES (27, 2, NULL, 'sora2', 'Sora 2', 'OpenAI大模型', '/static/images/application/index/tpcz/sora2.png', 'ROUTE', '/pages/create/image-studio?model=sora2', NULL, 8, '0', '2026-05-12 22:04:20', NULL);
INSERT INTO `ai_c_app_home_card` (`card_id`, `section_id`, `app_id`, `card_code`, `card_name`, `subtitle`, `card_image_url`, `action_type`, `action_value`, `extra_config`, `sort`, `status`, `create_time`, `update_time`) VALUES (28, 2, NULL, 'tywx', '通义万相', '阿里通义AI大模型', '/static/images/application/index/tpcz/tywx.png', 'ROUTE', '/pages/create/image-studio?model=wanxiang', NULL, 9, '0', '2026-05-12 22:04:20', NULL);
COMMIT;

-- ----------------------------
-- Table structure for ai_c_app_home_section
-- ----------------------------
DROP TABLE IF EXISTS `ai_c_app_home_section`;
CREATE TABLE `ai_c_app_home_section` (
  `section_id` bigint NOT NULL AUTO_INCREMENT COMMENT '分组ID',
  `section_code` varchar(64) COLLATE utf8mb4_general_ci NOT NULL COMMENT '分组编码',
  `section_name` varchar(64) COLLATE utf8mb4_general_ci NOT NULL COMMENT '分组名称',
  `section_type` varchar(32) COLLATE utf8mb4_general_ci DEFAULT 'GRID' COMMENT '分组类型 GRID/SCROLL',
  `sort` int DEFAULT '0' COMMENT '排序',
  `status` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '状态（0启用 1停用）',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`section_id`),
  UNIQUE KEY `uk_ai_c_app_home_section_code` (`section_code`),
  KEY `idx_ai_c_app_home_section_status_sort` (`status`,`sort`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='AI应用首页分组';

-- ----------------------------
-- Records of ai_c_app_home_section
-- ----------------------------
BEGIN;
INSERT INTO `ai_c_app_home_section` (`section_id`, `section_code`, `section_name`, `section_type`, `sort`, `status`, `create_time`, `update_time`) VALUES (1, 'TEXT_CREATE', '文本创作', 'GRID', 1, '0', '2026-05-12 22:04:13', NULL);
INSERT INTO `ai_c_app_home_section` (`section_id`, `section_code`, `section_name`, `section_type`, `sort`, `status`, `create_time`, `update_time`) VALUES (2, 'IMAGE_CREATE', '图片创作', 'GRID', 2, '0', '2026-05-12 22:04:13', NULL);
INSERT INTO `ai_c_app_home_section` (`section_id`, `section_code`, `section_name`, `section_type`, `sort`, `status`, `create_time`, `update_time`) VALUES (3, 'VIDEO_CREATE', '视频创作', 'GRID', 3, '0', '2026-05-12 22:04:13', NULL);
INSERT INTO `ai_c_app_home_section` (`section_id`, `section_code`, `section_name`, `section_type`, `sort`, `status`, `create_time`, `update_time`) VALUES (4, 'IMAGE_TOOL', '图片工具箱', 'GRID', 4, '0', '2026-05-12 22:04:13', NULL);
INSERT INTO `ai_c_app_home_section` (`section_id`, `section_code`, `section_name`, `section_type`, `sort`, `status`, `create_time`, `update_time`) VALUES (5, 'AI_AGENT', 'AI智能体', 'GRID', 5, '0', '2026-05-12 22:04:13', NULL);
COMMIT;

-- ----------------------------
-- Table structure for ai_c_app_mode
-- ----------------------------
DROP TABLE IF EXISTS `ai_c_app_mode`;
CREATE TABLE `ai_c_app_mode` (
  `mode_id` bigint NOT NULL AUTO_INCREMENT COMMENT '模式ID',
  `app_id` bigint NOT NULL COMMENT '应用ID',
  `mode_code` varchar(64) COLLATE utf8mb4_general_ci NOT NULL COMMENT '模式编码',
  `mode_name` varchar(64) COLLATE utf8mb4_general_ci NOT NULL COMMENT '模式名称',
  `mode_type` varchar(32) COLLATE utf8mb4_general_ci NOT NULL COMMENT '模式类型',
  `placeholder` varchar(255) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '输入框占位',
  `intro` varchar(500) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '模式说明',
  `power_cost` int DEFAULT '0' COMMENT '默认算力',
  `prompt_template` text COLLATE utf8mb4_general_ci COMMENT '提示词模板',
  `form_schema` longtext COLLATE utf8mb4_general_ci COMMENT '模式表单配置JSON',
  `sort` int DEFAULT '0' COMMENT '排序',
  `status` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '状态（0启用 1停用）',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`mode_id`),
  UNIQUE KEY `uk_ai_c_app_mode` (`app_id`,`mode_code`),
  KEY `idx_ai_c_app_mode_app` (`app_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='AI应用模式';

-- ----------------------------
-- Records of ai_c_app_mode
-- ----------------------------
BEGIN;
INSERT INTO `ai_c_app_mode` (`mode_id`, `app_id`, `mode_code`, `mode_name`, `mode_type`, `placeholder`, `intro`, `power_cost`, `prompt_template`, `form_schema`, `sort`, `status`, `create_time`, `update_time`) VALUES (1, 1, 'copy_create', '文案创作', 'TEXT_TO_TEXT', '请输入文案创作的提示词和创作要求', '根据要求生成原创文案。', 2, NULL, NULL, 1, '0', '2026-05-12 21:51:37', NULL);
INSERT INTO `ai_c_app_mode` (`mode_id`, `app_id`, `mode_code`, `mode_name`, `mode_type`, `placeholder`, `intro`, `power_cost`, `prompt_template`, `form_schema`, `sort`, `status`, `create_time`, `update_time`) VALUES (2, 1, 'imitate', '文案仿写', 'TEXT_TO_TEXT', '请输入对应的文案内容，如整段的文案内容', '参考原文结构和语气进行仿写。', 2, NULL, NULL, 2, '0', '2026-05-12 21:51:37', NULL);
INSERT INTO `ai_c_app_mode` (`mode_id`, `app_id`, `mode_code`, `mode_name`, `mode_type`, `placeholder`, `intro`, `power_cost`, `prompt_template`, `form_schema`, `sort`, `status`, `create_time`, `update_time`) VALUES (3, 1, 'polish', '文案润色', 'TEXT_TO_TEXT', '请输入对应的文案内容，如整段的文案内容', '提升表达质感与转化力。', 2, NULL, NULL, 3, '0', '2026-05-12 21:51:37', NULL);
INSERT INTO `ai_c_app_mode` (`mode_id`, `app_id`, `mode_code`, `mode_name`, `mode_type`, `placeholder`, `intro`, `power_cost`, `prompt_template`, `form_schema`, `sort`, `status`, `create_time`, `update_time`) VALUES (4, 1, 'expand', '文案扩写', 'TEXT_TO_TEXT', '请输入需要扩写的文案内容', '补充细节和卖点。', 2, NULL, NULL, 4, '0', '2026-05-12 21:51:37', NULL);
INSERT INTO `ai_c_app_mode` (`mode_id`, `app_id`, `mode_code`, `mode_name`, `mode_type`, `placeholder`, `intro`, `power_cost`, `prompt_template`, `form_schema`, `sort`, `status`, `create_time`, `update_time`) VALUES (5, 1, 'correct', '文案订正', 'TEXT_TO_TEXT', '请输入需要订正的文案内容', '修正错别字和病句。', 2, NULL, NULL, 5, '0', '2026-05-12 21:51:37', NULL);
INSERT INTO `ai_c_app_mode` (`mode_id`, `app_id`, `mode_code`, `mode_name`, `mode_type`, `placeholder`, `intro`, `power_cost`, `prompt_template`, `form_schema`, `sort`, `status`, `create_time`, `update_time`) VALUES (6, 1, 'summary', '文案精简', 'TEXT_TO_TEXT', '请输入需要精简的文案内容', '提炼核心内容。', 2, NULL, NULL, 6, '0', '2026-05-12 21:51:37', NULL);
INSERT INTO `ai_c_app_mode` (`mode_id`, `app_id`, `mode_code`, `mode_name`, `mode_type`, `placeholder`, `intro`, `power_cost`, `prompt_template`, `form_schema`, `sort`, `status`, `create_time`, `update_time`) VALUES (7, 20, 'TEXT_TO_IMAGE', '文生图片', 'TEXT_TO_IMAGE', '输入想要绘制的画面场景、风格和细节', '根据文字描述生成图片。', 20, NULL, NULL, 1, '0', '2026-05-12 21:51:37', NULL);
INSERT INTO `ai_c_app_mode` (`mode_id`, `app_id`, `mode_code`, `mode_name`, `mode_type`, `placeholder`, `intro`, `power_cost`, `prompt_template`, `form_schema`, `sort`, `status`, `create_time`, `update_time`) VALUES (8, 20, 'IMAGE_TO_IMAGE', '图生图片', 'IMAGE_TO_IMAGE', '上传参考图并描述需要调整的内容', '基于参考图生成或编辑图片。', 22, NULL, NULL, 2, '0', '2026-05-12 21:51:37', NULL);
COMMIT;

-- ----------------------------
-- Table structure for ai_c_app_model_relation
-- ----------------------------
DROP TABLE IF EXISTS `ai_c_app_model_relation`;
CREATE TABLE `ai_c_app_model_relation` (
  `relation_id` bigint NOT NULL AUTO_INCREMENT COMMENT '关系ID',
  `app_id` bigint NOT NULL COMMENT '应用ID',
  `model_id` bigint NOT NULL COMMENT '模型ID',
  `default_version_id` bigint DEFAULT NULL COMMENT '默认版本ID',
  `display_name` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '前台展示名',
  `intro` varchar(500) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '模型入口说明',
  `sort` int DEFAULT '0' COMMENT '排序',
  `status` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '状态（0启用 1停用）',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`relation_id`),
  UNIQUE KEY `uk_ai_c_app_model` (`app_id`,`model_id`),
  KEY `idx_ai_c_app_model_app` (`app_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='AI应用可用模型';

-- ----------------------------
-- Records of ai_c_app_model_relation
-- ----------------------------
BEGIN;
INSERT INTO `ai_c_app_model_relation` (`relation_id`, `app_id`, `model_id`, `default_version_id`, `display_name`, `intro`, `sort`, `status`, `create_time`, `update_time`) VALUES (1, 20, 1, 1, '即梦AI', '字节跳动图片模型', 1, '0', '2026-05-12 21:51:37', NULL);
INSERT INTO `ai_c_app_model_relation` (`relation_id`, `app_id`, `model_id`, `default_version_id`, `display_name`, `intro`, `sort`, `status`, `create_time`, `update_time`) VALUES (2, 20, 2, 3, '通义万象', '阿里通义AI大模型', 2, '0', '2026-05-12 21:51:37', NULL);
INSERT INTO `ai_c_app_model_relation` (`relation_id`, `app_id`, `model_id`, `default_version_id`, `display_name`, `intro`, `sort`, `status`, `create_time`, `update_time`) VALUES (3, 20, 3, 4, '可灵AI', '快手AI大模型', 3, '0', '2026-05-12 21:51:37', NULL);
COMMIT;

-- ----------------------------
-- Table structure for ai_c_card_code
-- ----------------------------
DROP TABLE IF EXISTS `ai_c_card_code`;
CREATE TABLE `ai_c_card_code` (
  `card_code_id` bigint NOT NULL AUTO_INCREMENT COMMENT '卡密ID',
  `package_id` bigint NOT NULL COMMENT '卡包ID',
  `package_name` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '卡包名称',
  `card_code` varchar(64) COLLATE utf8mb4_general_ci NOT NULL COMMENT '卡密编码',
  `power_num` int DEFAULT '0' COMMENT '基础算力',
  `bonus_power_num` int DEFAULT '0' COMMENT '赠送算力',
  `status` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '状态（0未使用 1已使用 2停用）',
  `used_user_id` bigint DEFAULT NULL COMMENT '使用用户ID',
  `order_id` bigint DEFAULT NULL COMMENT '关联订单ID',
  `used_time` datetime DEFAULT NULL COMMENT '使用时间',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`card_code_id`),
  UNIQUE KEY `uk_ai_c_card_code_code` (`card_code`),
  KEY `idx_ai_c_card_code_package_id` (`package_id`),
  KEY `idx_ai_c_card_code_status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='卡密表';

-- ----------------------------
-- Records of ai_c_card_code
-- ----------------------------
BEGIN;
INSERT INTO `ai_c_card_code` (`card_code_id`, `package_id`, `package_name`, `card_code`, `power_num`, `bonus_power_num`, `status`, `used_user_id`, `order_id`, `used_time`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1, 1, '新手体验包', 'CKSTARTER000001', 100, 20, '0', NULL, NULL, NULL, 'admin', '2026-05-12 18:46:09', NULL, '2026-05-12 21:52:42', '示例卡密');
INSERT INTO `ai_c_card_code` (`card_code_id`, `package_id`, `package_name`, `card_code`, `power_num`, `bonus_power_num`, `status`, `used_user_id`, `order_id`, `used_time`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2, 2, '进阶创作包', 'CKADVANCE000001', 500, 100, '1', 2, NULL, '2026-05-12 21:38:43', 'admin', '2026-05-12 18:46:09', '', '2026-05-12 21:38:43', '示例卡密');
COMMIT;

-- ----------------------------
-- Table structure for ai_c_channel_model_relation
-- ----------------------------
DROP TABLE IF EXISTS `ai_c_channel_model_relation`;
CREATE TABLE `ai_c_channel_model_relation` (
  `relation_id` bigint NOT NULL AUTO_INCREMENT COMMENT '映射ID',
  `channel_id` bigint NOT NULL COMMENT '渠道ID',
  `model_version_id` bigint NOT NULL COMMENT '模型版本ID',
  `remote_model_name` varchar(128) COLLATE utf8mb4_general_ci NOT NULL COMMENT '渠道实际模型名',
  `enabled` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '状态（0启用 1停用）',
  `price_ratio` decimal(10,4) DEFAULT '1.0000' COMMENT '价格系数',
  `priority` int DEFAULT '0' COMMENT '优先级',
  `weight` int DEFAULT '100' COMMENT '权重',
  `max_qps` int DEFAULT '0' COMMENT '最大QPS',
  `remark` varchar(500) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '备注',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`relation_id`),
  UNIQUE KEY `uk_ai_c_channel_model_relation` (`channel_id`,`model_version_id`),
  KEY `idx_ai_c_cmr_model_version_id` (`model_version_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='AI渠道模型映射表';

-- ----------------------------
-- Records of ai_c_channel_model_relation
-- ----------------------------
BEGIN;
INSERT INTO `ai_c_channel_model_relation` (`relation_id`, `channel_id`, `model_version_id`, `remote_model_name`, `enabled`, `price_ratio`, `priority`, `weight`, `max_qps`, `remark`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (10, 10, 10, 'glm-image', '1', 1.0000, 0, 100, 0, '请启用渠道后再启用此映射', 'admin', '2026-05-12 18:46:09', '', NULL);
COMMIT;

-- ----------------------------
-- Table structure for ai_c_model
-- ----------------------------
DROP TABLE IF EXISTS `ai_c_model`;
CREATE TABLE `ai_c_model` (
  `model_id` bigint NOT NULL AUTO_INCREMENT COMMENT '模型ID',
  `model_code` varchar(64) COLLATE utf8mb4_general_ci NOT NULL COMMENT '模型编码',
  `model_name` varchar(64) COLLATE utf8mb4_general_ci NOT NULL COMMENT '模型名称',
  `model_type` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT '模型类型',
  `provider` varchar(32) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '服务商',
  `official_provider_id` bigint DEFAULT NULL COMMENT '官方提供商ID',
  `capabilities` text COLLATE utf8mb4_general_ci COMMENT '能力标签JSON',
  `icon_url` varchar(255) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '模型图标',
  `cover_url` varchar(255) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '封面地址',
  `intro` varchar(255) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '模型简介',
  `status` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `sort` int DEFAULT '0' COMMENT '排序',
  `remark` varchar(500) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '备注',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`model_id`),
  UNIQUE KEY `uk_ai_c_model_code` (`model_code`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='AI模型配置表';

-- ----------------------------
-- Records of ai_c_model
-- ----------------------------
BEGIN;
INSERT INTO `ai_c_model` (`model_id`, `model_code`, `model_name`, `model_type`, `provider`, `official_provider_id`, `capabilities`, `icon_url`, `cover_url`, `intro`, `status`, `sort`, `remark`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (1, 'jimeng', '即梦AI', 'IMAGE', 'BYTEDANCE', NULL, NULL, '/profile/upload/2026/05/12/dce00dbdffbdabddb62e6783dfd3b0c8_20260512231533A001.png', '/profile/upload/2026/05/12/dce00dbdffbdabddb62e6783dfd3b0c8_20260512231542A002.png', '字节跳动图片模型', '0', 1, '', 'admin', '2026-05-12 18:46:09', 'admin', '2026-05-12 23:15:47');
INSERT INTO `ai_c_model` (`model_id`, `model_code`, `model_name`, `model_type`, `provider`, `official_provider_id`, `capabilities`, `icon_url`, `cover_url`, `intro`, `status`, `sort`, `remark`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (2, 'tongyi-wanxiang', '通义万象', 'IMAGE', 'ALIBABA', NULL, NULL, '', '', '阿里通义AI大模型', '0', 2, '', 'admin', '2026-05-12 18:46:09', '', NULL);
INSERT INTO `ai_c_model` (`model_id`, `model_code`, `model_name`, `model_type`, `provider`, `official_provider_id`, `capabilities`, `icon_url`, `cover_url`, `intro`, `status`, `sort`, `remark`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (3, 'keling', '可灵AI', 'VIDEO', 'KUAISHOU', NULL, NULL, '', '', '快手视频大模型', '0', 3, '', 'admin', '2026-05-12 18:46:09', '', NULL);
INSERT INTO `ai_c_model` (`model_id`, `model_code`, `model_name`, `model_type`, `provider`, `official_provider_id`, `capabilities`, `icon_url`, `cover_url`, `intro`, `status`, `sort`, `remark`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (10, 'glm-image', '智谱文生图', 'IMAGE', 'ZHIPU', 6, '[\"text_to_image\"]', '', '', '智谱官方文生图模型', '0', 10, '', 'admin', '2026-05-12 18:46:09', '', NULL);
INSERT INTO `ai_c_model` (`model_id`, `model_code`, `model_name`, `model_type`, `provider`, `official_provider_id`, `capabilities`, `icon_url`, `cover_url`, `intro`, `status`, `sort`, `remark`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (30, 'copy-text', '通用文案模型', 'TEXT', 'ZHIPU', 6, '[\"text_to_text\"]', '', '', '文案创作默认文本模型', '0', 30, '', 'admin', '2026-05-12 22:35:57', '', NULL);
COMMIT;

-- ----------------------------
-- Table structure for ai_c_model_version
-- ----------------------------
DROP TABLE IF EXISTS `ai_c_model_version`;
CREATE TABLE `ai_c_model_version` (
  `version_id` bigint NOT NULL AUTO_INCREMENT COMMENT '版本ID',
  `model_id` bigint NOT NULL COMMENT '模型ID',
  `version_code` varchar(64) COLLATE utf8mb4_general_ci NOT NULL COMMENT '版本编码',
  `version_name` varchar(64) COLLATE utf8mb4_general_ci NOT NULL COMMENT '版本名称',
  `api_model_name` varchar(128) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '实际请求模型名',
  `power_cost` int DEFAULT '0' COMMENT '单次消耗算力',
  `context_length` int DEFAULT '0' COMMENT '上下文长度',
  `input_price` decimal(10,4) DEFAULT '0.0000' COMMENT '输入单价',
  `output_price` decimal(10,4) DEFAULT '0.0000' COMMENT '输出单价',
  `speed_level` int DEFAULT '0' COMMENT '速度等级',
  `quality_level` int DEFAULT '0' COMMENT '质量等级',
  `support_ratio` varchar(255) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '支持比例(JSON)',
  `support_style` text COLLATE utf8mb4_general_ci COMMENT '支持风格(JSON)',
  `support_mode` varchar(255) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '支持模式',
  `ext_config` text COLLATE utf8mb4_general_ci COMMENT '扩展配置',
  `status` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `remark` varchar(500) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '备注',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `version_intro` varchar(1000) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '版本介绍',
  `support_size` varchar(500) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '支持尺寸JSON',
  `default_ratio` varchar(32) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '默认比例',
  `default_size` varchar(32) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '默认尺寸',
  `mode_config` longtext COLLATE utf8mb4_general_ci COMMENT '模式配置JSON',
  PRIMARY KEY (`version_id`),
  UNIQUE KEY `uk_ai_c_model_version_code` (`version_code`),
  KEY `idx_ai_c_model_version_model_id` (`model_id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='AI模型版本表';

-- ----------------------------
-- Records of ai_c_model_version
-- ----------------------------
BEGIN;
INSERT INTO `ai_c_model_version` (`version_id`, `model_id`, `version_code`, `version_name`, `api_model_name`, `power_cost`, `context_length`, `input_price`, `output_price`, `speed_level`, `quality_level`, `support_ratio`, `support_style`, `support_mode`, `ext_config`, `status`, `remark`, `create_by`, `create_time`, `update_by`, `update_time`, `version_intro`, `support_size`, `default_ratio`, `default_size`, `mode_config`) VALUES (1, 1, 'jimeng-3.0', '即梦3.0', '', 20, 0, 0.0000, 0.0000, 0, 0, '[\"1:1\",\"9:16\",\"16:9\"]', '[\"CUSTOM\",\"ANIME\",\"PHOTO\"]', 'TEXT_TO_IMAGE,IMAGE_TO_IMAGE', NULL, '0', '', 'admin', '2026-05-12 18:46:09', '', NULL, '即梦AI-3.0支持多模态输入与实时编辑，商用级输出，独创版权保护算法，为专业设计者而生。', '[\"1K\",\"2K\",\"4K\"]', '9:16', '2K', NULL);
INSERT INTO `ai_c_model_version` (`version_id`, `model_id`, `version_code`, `version_name`, `api_model_name`, `power_cost`, `context_length`, `input_price`, `output_price`, `speed_level`, `quality_level`, `support_ratio`, `support_style`, `support_mode`, `ext_config`, `status`, `remark`, `create_by`, `create_time`, `update_by`, `update_time`, `version_intro`, `support_size`, `default_ratio`, `default_size`, `mode_config`) VALUES (2, 1, 'jimeng-4.0', '即梦4.0', '', 30, 0, 0.0000, 0.0000, 0, 0, '[\"1:1\",\"9:16\",\"16:9\"]', '[\"CUSTOM\",\"ANIME\",\"PHOTO\"]', 'TEXT_TO_IMAGE,IMAGE_TO_IMAGE', NULL, '0', '', 'admin', '2026-05-12 18:46:09', '', NULL, '即梦AI-4.0支持单次输入多张图像及复合编辑，提升中文生图准确率，支持4K超高清输出。', '[\"1K\",\"2K\",\"4K\"]', '9:16', '2K', NULL);
INSERT INTO `ai_c_model_version` (`version_id`, `model_id`, `version_code`, `version_name`, `api_model_name`, `power_cost`, `context_length`, `input_price`, `output_price`, `speed_level`, `quality_level`, `support_ratio`, `support_style`, `support_mode`, `ext_config`, `status`, `remark`, `create_by`, `create_time`, `update_by`, `update_time`, `version_intro`, `support_size`, `default_ratio`, `default_size`, `mode_config`) VALUES (3, 2, 'wanxiang-v1', '通义万象 V1', '', 25, 0, 0.0000, 0.0000, 0, 0, '[\"1:1\",\"3:4\",\"4:3\"]', '[\"CUSTOM\",\"CHINESE\",\"PHOTO\"]', 'TEXT_TO_IMAGE', NULL, '0', '', 'admin', '2026-05-12 18:46:09', '', NULL, '通义万象适合中文语义理解和东方审美风格生成。', '[\"1K\",\"2K\",\"4K\"]', '9:16', '2K', NULL);
INSERT INTO `ai_c_model_version` (`version_id`, `model_id`, `version_code`, `version_name`, `api_model_name`, `power_cost`, `context_length`, `input_price`, `output_price`, `speed_level`, `quality_level`, `support_ratio`, `support_style`, `support_mode`, `ext_config`, `status`, `remark`, `create_by`, `create_time`, `update_by`, `update_time`, `version_intro`, `support_size`, `default_ratio`, `default_size`, `mode_config`) VALUES (4, 3, 'keling-v1', '可灵视频 V1', '', 50, 0, 0.0000, 0.0000, 0, 0, '[\"16:9\",\"9:16\"]', '[\"CINEMATIC\",\"REALISTIC\"]', 'TEXT_TO_VIDEO,IMAGE_TO_VIDEO', NULL, '0', '', 'admin', '2026-05-12 18:46:09', '', NULL, '可灵AI适合视频与动态视觉创意。', '[\"1K\",\"2K\",\"4K\"]', '9:16', '2K', NULL);
INSERT INTO `ai_c_model_version` (`version_id`, `model_id`, `version_code`, `version_name`, `api_model_name`, `power_cost`, `context_length`, `input_price`, `output_price`, `speed_level`, `quality_level`, `support_ratio`, `support_style`, `support_mode`, `ext_config`, `status`, `remark`, `create_by`, `create_time`, `update_by`, `update_time`, `version_intro`, `support_size`, `default_ratio`, `default_size`, `mode_config`) VALUES (10, 10, 'glm-image-v1', 'GLM Image', '', 15, 0, 0.0000, 0.0000, 0, 0, '[\"1:1\",\"3:4\",\"4:3\",\"9:16\",\"16:9\"]', '[\"PHOTO\",\"ILLUSTRATION\",\"POSTER\"]', 'TEXT_TO_IMAGE', NULL, '0', '', 'admin', '2026-05-12 18:46:09', '', NULL, '', '', '', '', NULL);
INSERT INTO `ai_c_model_version` (`version_id`, `model_id`, `version_code`, `version_name`, `api_model_name`, `power_cost`, `context_length`, `input_price`, `output_price`, `speed_level`, `quality_level`, `support_ratio`, `support_style`, `support_mode`, `ext_config`, `status`, `remark`, `create_by`, `create_time`, `update_by`, `update_time`, `version_intro`, `support_size`, `default_ratio`, `default_size`, `mode_config`) VALUES (30, 30, 'copy-text-v1', '文案创作 V1', '', 2, 0, 0.0000, 0.0000, 0, 0, '', NULL, 'TEXT_TO_TEXT', NULL, '0', '', 'admin', '2026-05-12 22:35:57', '', NULL, '', '', '', '', NULL);
COMMIT;

-- ----------------------------
-- Table structure for ai_c_model_version_style
-- ----------------------------
DROP TABLE IF EXISTS `ai_c_model_version_style`;
CREATE TABLE `ai_c_model_version_style` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `version_id` bigint NOT NULL COMMENT '版本ID',
  `style_id` bigint NOT NULL COMMENT '风格ID',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_ai_c_version_style` (`version_id`,`style_id`)
) ENGINE=InnoDB AUTO_INCREMENT=128 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='模型版本风格关系';

-- ----------------------------
-- Records of ai_c_model_version_style
-- ----------------------------
BEGIN;
INSERT INTO `ai_c_model_version_style` (`id`, `version_id`, `style_id`) VALUES (4, 1, 1);
INSERT INTO `ai_c_model_version_style` (`id`, `version_id`, `style_id`) VALUES (8, 1, 2);
INSERT INTO `ai_c_model_version_style` (`id`, `version_id`, `style_id`) VALUES (12, 1, 3);
INSERT INTO `ai_c_model_version_style` (`id`, `version_id`, `style_id`) VALUES (16, 1, 4);
INSERT INTO `ai_c_model_version_style` (`id`, `version_id`, `style_id`) VALUES (20, 1, 5);
INSERT INTO `ai_c_model_version_style` (`id`, `version_id`, `style_id`) VALUES (24, 1, 6);
INSERT INTO `ai_c_model_version_style` (`id`, `version_id`, `style_id`) VALUES (28, 1, 7);
INSERT INTO `ai_c_model_version_style` (`id`, `version_id`, `style_id`) VALUES (32, 1, 8);
INSERT INTO `ai_c_model_version_style` (`id`, `version_id`, `style_id`) VALUES (36, 1, 9);
INSERT INTO `ai_c_model_version_style` (`id`, `version_id`, `style_id`) VALUES (40, 1, 10);
INSERT INTO `ai_c_model_version_style` (`id`, `version_id`, `style_id`) VALUES (44, 1, 11);
INSERT INTO `ai_c_model_version_style` (`id`, `version_id`, `style_id`) VALUES (48, 1, 12);
INSERT INTO `ai_c_model_version_style` (`id`, `version_id`, `style_id`) VALUES (52, 1, 13);
INSERT INTO `ai_c_model_version_style` (`id`, `version_id`, `style_id`) VALUES (56, 1, 14);
INSERT INTO `ai_c_model_version_style` (`id`, `version_id`, `style_id`) VALUES (60, 1, 15);
INSERT INTO `ai_c_model_version_style` (`id`, `version_id`, `style_id`) VALUES (64, 1, 16);
INSERT INTO `ai_c_model_version_style` (`id`, `version_id`, `style_id`) VALUES (3, 2, 1);
INSERT INTO `ai_c_model_version_style` (`id`, `version_id`, `style_id`) VALUES (7, 2, 2);
INSERT INTO `ai_c_model_version_style` (`id`, `version_id`, `style_id`) VALUES (11, 2, 3);
INSERT INTO `ai_c_model_version_style` (`id`, `version_id`, `style_id`) VALUES (15, 2, 4);
INSERT INTO `ai_c_model_version_style` (`id`, `version_id`, `style_id`) VALUES (19, 2, 5);
INSERT INTO `ai_c_model_version_style` (`id`, `version_id`, `style_id`) VALUES (23, 2, 6);
INSERT INTO `ai_c_model_version_style` (`id`, `version_id`, `style_id`) VALUES (27, 2, 7);
INSERT INTO `ai_c_model_version_style` (`id`, `version_id`, `style_id`) VALUES (31, 2, 8);
INSERT INTO `ai_c_model_version_style` (`id`, `version_id`, `style_id`) VALUES (35, 2, 9);
INSERT INTO `ai_c_model_version_style` (`id`, `version_id`, `style_id`) VALUES (39, 2, 10);
INSERT INTO `ai_c_model_version_style` (`id`, `version_id`, `style_id`) VALUES (43, 2, 11);
INSERT INTO `ai_c_model_version_style` (`id`, `version_id`, `style_id`) VALUES (47, 2, 12);
INSERT INTO `ai_c_model_version_style` (`id`, `version_id`, `style_id`) VALUES (51, 2, 13);
INSERT INTO `ai_c_model_version_style` (`id`, `version_id`, `style_id`) VALUES (55, 2, 14);
INSERT INTO `ai_c_model_version_style` (`id`, `version_id`, `style_id`) VALUES (59, 2, 15);
INSERT INTO `ai_c_model_version_style` (`id`, `version_id`, `style_id`) VALUES (63, 2, 16);
INSERT INTO `ai_c_model_version_style` (`id`, `version_id`, `style_id`) VALUES (2, 3, 1);
INSERT INTO `ai_c_model_version_style` (`id`, `version_id`, `style_id`) VALUES (6, 3, 2);
INSERT INTO `ai_c_model_version_style` (`id`, `version_id`, `style_id`) VALUES (10, 3, 3);
INSERT INTO `ai_c_model_version_style` (`id`, `version_id`, `style_id`) VALUES (14, 3, 4);
INSERT INTO `ai_c_model_version_style` (`id`, `version_id`, `style_id`) VALUES (18, 3, 5);
INSERT INTO `ai_c_model_version_style` (`id`, `version_id`, `style_id`) VALUES (22, 3, 6);
INSERT INTO `ai_c_model_version_style` (`id`, `version_id`, `style_id`) VALUES (26, 3, 7);
INSERT INTO `ai_c_model_version_style` (`id`, `version_id`, `style_id`) VALUES (30, 3, 8);
INSERT INTO `ai_c_model_version_style` (`id`, `version_id`, `style_id`) VALUES (34, 3, 9);
INSERT INTO `ai_c_model_version_style` (`id`, `version_id`, `style_id`) VALUES (38, 3, 10);
INSERT INTO `ai_c_model_version_style` (`id`, `version_id`, `style_id`) VALUES (42, 3, 11);
INSERT INTO `ai_c_model_version_style` (`id`, `version_id`, `style_id`) VALUES (46, 3, 12);
INSERT INTO `ai_c_model_version_style` (`id`, `version_id`, `style_id`) VALUES (50, 3, 13);
INSERT INTO `ai_c_model_version_style` (`id`, `version_id`, `style_id`) VALUES (54, 3, 14);
INSERT INTO `ai_c_model_version_style` (`id`, `version_id`, `style_id`) VALUES (58, 3, 15);
INSERT INTO `ai_c_model_version_style` (`id`, `version_id`, `style_id`) VALUES (62, 3, 16);
INSERT INTO `ai_c_model_version_style` (`id`, `version_id`, `style_id`) VALUES (1, 4, 1);
INSERT INTO `ai_c_model_version_style` (`id`, `version_id`, `style_id`) VALUES (5, 4, 2);
INSERT INTO `ai_c_model_version_style` (`id`, `version_id`, `style_id`) VALUES (9, 4, 3);
INSERT INTO `ai_c_model_version_style` (`id`, `version_id`, `style_id`) VALUES (13, 4, 4);
INSERT INTO `ai_c_model_version_style` (`id`, `version_id`, `style_id`) VALUES (17, 4, 5);
INSERT INTO `ai_c_model_version_style` (`id`, `version_id`, `style_id`) VALUES (21, 4, 6);
INSERT INTO `ai_c_model_version_style` (`id`, `version_id`, `style_id`) VALUES (25, 4, 7);
INSERT INTO `ai_c_model_version_style` (`id`, `version_id`, `style_id`) VALUES (29, 4, 8);
INSERT INTO `ai_c_model_version_style` (`id`, `version_id`, `style_id`) VALUES (33, 4, 9);
INSERT INTO `ai_c_model_version_style` (`id`, `version_id`, `style_id`) VALUES (37, 4, 10);
INSERT INTO `ai_c_model_version_style` (`id`, `version_id`, `style_id`) VALUES (41, 4, 11);
INSERT INTO `ai_c_model_version_style` (`id`, `version_id`, `style_id`) VALUES (45, 4, 12);
INSERT INTO `ai_c_model_version_style` (`id`, `version_id`, `style_id`) VALUES (49, 4, 13);
INSERT INTO `ai_c_model_version_style` (`id`, `version_id`, `style_id`) VALUES (53, 4, 14);
INSERT INTO `ai_c_model_version_style` (`id`, `version_id`, `style_id`) VALUES (57, 4, 15);
INSERT INTO `ai_c_model_version_style` (`id`, `version_id`, `style_id`) VALUES (61, 4, 16);
COMMIT;

-- ----------------------------
-- Table structure for ai_c_order
-- ----------------------------
DROP TABLE IF EXISTS `ai_c_order`;
CREATE TABLE `ai_c_order` (
  `order_id` bigint NOT NULL AUTO_INCREMENT COMMENT '订单ID',
  `order_no` varchar(32) COLLATE utf8mb4_general_ci NOT NULL COMMENT '订单编号',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `package_id` bigint DEFAULT NULL COMMENT '套餐ID',
  `package_name` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '套餐名称',
  `pay_config_id` bigint DEFAULT NULL COMMENT '支付配置ID',
  `pay_channel` varchar(32) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '支付渠道',
  `power_num` int DEFAULT '0' COMMENT '到账算力',
  `bonus_power_num` int DEFAULT '0' COMMENT '赠送算力',
  `pay_amount` decimal(10,2) DEFAULT '0.00' COMMENT '支付金额',
  `order_status` varchar(20) COLLATE utf8mb4_general_ci DEFAULT 'WAIT_PAY' COMMENT '订单状态',
  `third_order_no` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '第三方订单号',
  `pay_time` datetime DEFAULT NULL COMMENT '支付时间',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`order_id`),
  UNIQUE KEY `uk_ai_c_order_no` (`order_no`),
  KEY `idx_ai_c_order_user_id` (`user_id`),
  KEY `idx_ai_c_order_status` (`order_status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='充值订单表';

-- ----------------------------
-- Records of ai_c_order
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for ai_c_pay_config
-- ----------------------------
DROP TABLE IF EXISTS `ai_c_pay_config`;
CREATE TABLE `ai_c_pay_config` (
  `pay_config_id` bigint NOT NULL AUTO_INCREMENT COMMENT '支付配置ID',
  `config_name` varchar(64) COLLATE utf8mb4_general_ci NOT NULL COMMENT '配置名称',
  `config_code` varchar(32) COLLATE utf8mb4_general_ci NOT NULL COMMENT '配置编码',
  `pay_channel` varchar(32) COLLATE utf8mb4_general_ci NOT NULL COMMENT '支付渠道',
  `mch_id` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '商户号',
  `app_id` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '应用ID',
  `notify_url` varchar(255) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '回调地址',
  `status` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `sort` int DEFAULT '0' COMMENT '排序',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`pay_config_id`),
  UNIQUE KEY `uk_ai_c_pay_config_code` (`config_code`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='支付配置表';

-- ----------------------------
-- Records of ai_c_pay_config
-- ----------------------------
BEGIN;
INSERT INTO `ai_c_pay_config` (`pay_config_id`, `config_name`, `config_code`, `pay_channel`, `mch_id`, `app_id`, `notify_url`, `status`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1, '微信小程序支付', 'WX_MP', 'WECHAT_MP', '', '', '', '0', 1, 'admin', '2026-05-12 18:46:09', '', NULL, '微信小程序支付占位配置');
INSERT INTO `ai_c_pay_config` (`pay_config_id`, `config_name`, `config_code`, `pay_channel`, `mch_id`, `app_id`, `notify_url`, `status`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2, '支付宝H5支付', 'ALIPAY_H5', 'ALIPAY_H5', '', '', '', '1', 2, 'admin', '2026-05-12 18:46:09', '', NULL, '支付宝支付占位配置');
COMMIT;

-- ----------------------------
-- Table structure for ai_c_provider
-- ----------------------------
DROP TABLE IF EXISTS `ai_c_provider`;
CREATE TABLE `ai_c_provider` (
  `provider_id` bigint NOT NULL AUTO_INCREMENT COMMENT '提供商ID',
  `provider_name` varchar(64) COLLATE utf8mb4_general_ci NOT NULL COMMENT '提供商名称',
  `provider_code` varchar(64) COLLATE utf8mb4_general_ci NOT NULL COMMENT '提供商编码',
  `provider_type` varchar(20) COLLATE utf8mb4_general_ci DEFAULT 'OFFICIAL' COMMENT '提供商类型',
  `icon` varchar(255) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '图标',
  `website` varchar(255) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '官网地址',
  `status` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `remark` varchar(500) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '备注',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`provider_id`),
  UNIQUE KEY `uk_ai_c_provider_code` (`provider_code`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='AI提供商表';

-- ----------------------------
-- Records of ai_c_provider
-- ----------------------------
BEGIN;
INSERT INTO `ai_c_provider` (`provider_id`, `provider_name`, `provider_code`, `provider_type`, `icon`, `website`, `status`, `remark`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (1, '字节跳动', 'BYTEDANCE', 'OFFICIAL', '', '', '0', '即梦等模型官方提供商', 'admin', '2026-05-12 18:46:09', '', NULL);
INSERT INTO `ai_c_provider` (`provider_id`, `provider_name`, `provider_code`, `provider_type`, `icon`, `website`, `status`, `remark`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (2, '阿里云', 'ALIBABA', 'OFFICIAL', '', '', '0', '通义系列官方提供商', 'admin', '2026-05-12 18:46:09', '', NULL);
INSERT INTO `ai_c_provider` (`provider_id`, `provider_name`, `provider_code`, `provider_type`, `icon`, `website`, `status`, `remark`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (3, '快手', 'KUAISHOU', 'OFFICIAL', '', '', '0', '可灵模型官方提供商', 'admin', '2026-05-12 18:46:09', '', NULL);
INSERT INTO `ai_c_provider` (`provider_id`, `provider_name`, `provider_code`, `provider_type`, `icon`, `website`, `status`, `remark`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (4, 'OpenAI', 'OPENAI', 'OFFICIAL', '', '', '0', 'OpenAI 官方提供商', 'admin', '2026-05-12 18:46:09', '', NULL);
INSERT INTO `ai_c_provider` (`provider_id`, `provider_name`, `provider_code`, `provider_type`, `icon`, `website`, `status`, `remark`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (5, 'Anthropic', 'ANTHROPIC', 'OFFICIAL', '', '', '0', 'Anthropic 官方提供商', 'admin', '2026-05-12 18:46:09', '', NULL);
INSERT INTO `ai_c_provider` (`provider_id`, `provider_name`, `provider_code`, `provider_type`, `icon`, `website`, `status`, `remark`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (6, '智谱AI', 'ZHIPU', 'OFFICIAL', '', '', '0', '智谱官方提供商', 'admin', '2026-05-12 18:46:09', '', NULL);
COMMIT;

-- ----------------------------
-- Table structure for ai_c_provider_channel
-- ----------------------------
DROP TABLE IF EXISTS `ai_c_provider_channel`;
CREATE TABLE `ai_c_provider_channel` (
  `channel_id` bigint NOT NULL AUTO_INCREMENT COMMENT '渠道ID',
  `provider_id` bigint NOT NULL COMMENT '提供商ID',
  `channel_name` varchar(64) COLLATE utf8mb4_general_ci NOT NULL COMMENT '渠道名称',
  `channel_code` varchar(64) COLLATE utf8mb4_general_ci NOT NULL COMMENT '渠道编码',
  `base_url` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '基础地址',
  `api_key` varchar(512) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'API Key',
  `api_secret` varchar(512) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'API Secret',
  `proxy_enabled` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '是否代理（0否 1是）',
  `priority` int DEFAULT '0' COMMENT '优先级',
  `weight` int DEFAULT '100' COMMENT '权重',
  `timeout_ms` int DEFAULT '60000' COMMENT '超时时间毫秒',
  `max_concurrency` int DEFAULT '0' COMMENT '最大并发',
  `rpm_limit` int DEFAULT '0' COMMENT 'RPM限制',
  `tpm_limit` int DEFAULT '0' COMMENT 'TPM限制',
  `is_fallback` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '是否兜底（0否 1是）',
  `health_status` varchar(20) COLLATE utf8mb4_general_ci DEFAULT 'UNKNOWN' COMMENT '健康状态',
  `status` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `remark` varchar(500) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '备注',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`channel_id`),
  UNIQUE KEY `uk_ai_c_provider_channel_code` (`channel_code`),
  KEY `idx_ai_c_provider_channel_provider_id` (`provider_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='AI提供商渠道表';

-- ----------------------------
-- Records of ai_c_provider_channel
-- ----------------------------
BEGIN;
INSERT INTO `ai_c_provider_channel` (`channel_id`, `provider_id`, `channel_name`, `channel_code`, `base_url`, `api_key`, `api_secret`, `proxy_enabled`, `priority`, `weight`, `timeout_ms`, `max_concurrency`, `rpm_limit`, `tpm_limit`, `is_fallback`, `health_status`, `status`, `remark`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (10, 6, '智谱官方', 'ZHIPU_OFFICIAL', 'https://open.bigmodel.cn', '5847da8b13364922b6bb984ff62069ad.DHEK4oP6GZdiY9Cf', NULL, '0', 0, 100, 60000, 0, 0, 0, '0', 'UNKNOWN', '0', '请填写 API Key 后启用', 'admin', '2026-05-12 18:46:09', 'admin', '2026-05-12 22:34:19');
COMMIT;

-- ----------------------------
-- Table structure for ai_c_recharge_package
-- ----------------------------
DROP TABLE IF EXISTS `ai_c_recharge_package`;
CREATE TABLE `ai_c_recharge_package` (
  `package_id` bigint NOT NULL AUTO_INCREMENT COMMENT '套餐ID',
  `package_name` varchar(64) COLLATE utf8mb4_general_ci NOT NULL COMMENT '套餐名称',
  `package_code` varchar(32) COLLATE utf8mb4_general_ci NOT NULL COMMENT '套餐编码',
  `power_num` int DEFAULT '0' COMMENT '算力数量',
  `bonus_power_num` int DEFAULT '0' COMMENT '赠送算力',
  `sale_price` decimal(10,2) DEFAULT '0.00' COMMENT '销售金额',
  `original_price` decimal(10,2) DEFAULT '0.00' COMMENT '原价金额',
  `sort` int DEFAULT '0' COMMENT '排序',
  `package_desc` varchar(255) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '套餐说明',
  `status` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`package_id`),
  UNIQUE KEY `uk_ai_c_recharge_package_code` (`package_code`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='充值套餐表';

-- ----------------------------
-- Records of ai_c_recharge_package
-- ----------------------------
BEGIN;
INSERT INTO `ai_c_recharge_package` (`package_id`, `package_name`, `package_code`, `power_num`, `bonus_power_num`, `sale_price`, `original_price`, `sort`, `package_desc`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1, '新手体验包', 'STARTER_100', 100, 20, 9.90, 19.90, 1, '适合首次体验创作能力', '0', 'admin', '2026-05-12 18:46:09', '', NULL, '');
INSERT INTO `ai_c_recharge_package` (`package_id`, `package_name`, `package_code`, `power_num`, `bonus_power_num`, `sale_price`, `original_price`, `sort`, `package_desc`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2, '进阶创作包', 'ADVANCE_500', 500, 100, 49.90, 69.90, 2, '适合日常图片创作使用', '0', 'admin', '2026-05-12 18:46:09', '', NULL, '');
INSERT INTO `ai_c_recharge_package` (`package_id`, `package_name`, `package_code`, `power_num`, `bonus_power_num`, `sale_price`, `original_price`, `sort`, `package_desc`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (3, '专业高频包', 'PRO_1200', 1200, 300, 99.90, 149.90, 3, '适合高频创作和团队测试', '0', 'admin', '2026-05-12 18:46:09', '', NULL, '');
COMMIT;

-- ----------------------------
-- Table structure for ai_c_style_preset
-- ----------------------------
DROP TABLE IF EXISTS `ai_c_style_preset`;
CREATE TABLE `ai_c_style_preset` (
  `style_id` bigint NOT NULL AUTO_INCREMENT COMMENT '风格ID',
  `style_code` varchar(64) COLLATE utf8mb4_general_ci NOT NULL COMMENT '风格编码',
  `style_name` varchar(64) COLLATE utf8mb4_general_ci NOT NULL COMMENT '风格名称',
  `style_type` varchar(32) COLLATE utf8mb4_general_ci DEFAULT 'IMAGE' COMMENT '风格类型',
  `cover_url` varchar(255) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '封面图',
  `prompt_suffix` varchar(500) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '提示词追加',
  `sort` int DEFAULT '0' COMMENT '排序',
  `status` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '状态（0启用 1停用）',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`style_id`),
  UNIQUE KEY `uk_ai_c_style_code` (`style_code`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='AI风格预设';

-- ----------------------------
-- Records of ai_c_style_preset
-- ----------------------------
BEGIN;
INSERT INTO `ai_c_style_preset` (`style_id`, `style_code`, `style_name`, `style_type`, `cover_url`, `prompt_suffix`, `sort`, `status`, `create_time`, `update_time`) VALUES (1, 'CUSTOM', '自定义', 'IMAGE', '', '', 1, '0', '2026-05-12 21:51:37', NULL);
INSERT INTO `ai_c_style_preset` (`style_id`, `style_code`, `style_name`, `style_type`, `cover_url`, `prompt_suffix`, `sort`, `status`, `create_time`, `update_time`) VALUES (2, 'GONGBI', '新工笔画', 'IMAGE', '', '新工笔画风格', 2, '0', '2026-05-12 21:51:37', NULL);
INSERT INTO `ai_c_style_preset` (`style_id`, `style_code`, `style_name`, `style_type`, `cover_url`, `prompt_suffix`, `sort`, `status`, `create_time`, `update_time`) VALUES (3, 'VAN_GOGH', '梵高风', 'IMAGE', '', '梵高油画风格', 3, '0', '2026-05-12 21:51:37', NULL);
INSERT INTO `ai_c_style_preset` (`style_id`, `style_code`, `style_name`, `style_type`, `cover_url`, `prompt_suffix`, `sort`, `status`, `create_time`, `update_time`) VALUES (4, 'CHINESE', '中国画风', 'IMAGE', '', '中国画风格', 4, '0', '2026-05-12 21:51:37', NULL);
INSERT INTO `ai_c_style_preset` (`style_id`, `style_code`, `style_name`, `style_type`, `cover_url`, `prompt_suffix`, `sort`, `status`, `create_time`, `update_time`) VALUES (5, 'FANTASY', '奇幻风格', 'IMAGE', '', '奇幻艺术风格', 5, '0', '2026-05-12 21:51:37', NULL);
INSERT INTO `ai_c_style_preset` (`style_id`, `style_code`, `style_name`, `style_type`, `cover_url`, `prompt_suffix`, `sort`, `status`, `create_time`, `update_time`) VALUES (6, 'ANIME', '动漫风格', 'IMAGE', '', '动漫插画风格', 6, '0', '2026-05-12 21:51:37', NULL);
INSERT INTO `ai_c_style_preset` (`style_id`, `style_code`, `style_name`, `style_type`, `cover_url`, `prompt_suffix`, `sort`, `status`, `create_time`, `update_time`) VALUES (7, 'CARTOON', '卡通风格', 'IMAGE', '', '卡通电影风格', 7, '0', '2026-05-12 21:51:37', NULL);
INSERT INTO `ai_c_style_preset` (`style_id`, `style_code`, `style_name`, `style_type`, `cover_url`, `prompt_suffix`, `sort`, `status`, `create_time`, `update_time`) VALUES (8, 'REALISTIC', '写实风', 'IMAGE', '', '写实摄影风格', 8, '0', '2026-05-12 21:51:37', NULL);
INSERT INTO `ai_c_style_preset` (`style_id`, `style_code`, `style_name`, `style_type`, `cover_url`, `prompt_suffix`, `sort`, `status`, `create_time`, `update_time`) VALUES (9, 'SKETCH', '素描风', 'IMAGE', '', '素描线稿风格', 9, '0', '2026-05-12 21:51:37', NULL);
INSERT INTO `ai_c_style_preset` (`style_id`, `style_code`, `style_name`, `style_type`, `cover_url`, `prompt_suffix`, `sort`, `status`, `create_time`, `update_time`) VALUES (10, 'PHOTO', '摄影风', 'IMAGE', '', '自然摄影风格', 10, '0', '2026-05-12 21:51:37', NULL);
INSERT INTO `ai_c_style_preset` (`style_id`, `style_code`, `style_name`, `style_type`, `cover_url`, `prompt_suffix`, `sort`, `status`, `create_time`, `update_time`) VALUES (11, 'CLAY', '黏土风', 'IMAGE', '', '黏土玩偶风格', 11, '0', '2026-05-12 21:51:37', NULL);
INSERT INTO `ai_c_style_preset` (`style_id`, `style_code`, `style_name`, `style_type`, `cover_url`, `prompt_suffix`, `sort`, `status`, `create_time`, `update_time`) VALUES (12, 'BLACK_WHITE', '黑白风格', 'IMAGE', '', '黑白影像风格', 12, '0', '2026-05-12 21:51:37', NULL);
INSERT INTO `ai_c_style_preset` (`style_id`, `style_code`, `style_name`, `style_type`, `cover_url`, `prompt_suffix`, `sort`, `status`, `create_time`, `update_time`) VALUES (13, 'JAPANESE_ANIME', '日漫风格', 'IMAGE', '', '日式动漫风格', 13, '0', '2026-05-12 21:51:37', NULL);
INSERT INTO `ai_c_style_preset` (`style_id`, `style_code`, `style_name`, `style_type`, `cover_url`, `prompt_suffix`, `sort`, `status`, `create_time`, `update_time`) VALUES (14, 'MOVIE', '电影风格', 'IMAGE', '', '电影镜头风格', 14, '0', '2026-05-12 21:51:37', NULL);
INSERT INTO `ai_c_style_preset` (`style_id`, `style_code`, `style_name`, `style_type`, `cover_url`, `prompt_suffix`, `sort`, `status`, `create_time`, `update_time`) VALUES (15, 'WATERCOLOR', '浅水彩', 'IMAGE', '', '浅水彩风格', 15, '0', '2026-05-12 21:51:37', NULL);
INSERT INTO `ai_c_style_preset` (`style_id`, `style_code`, `style_name`, `style_type`, `cover_url`, `prompt_suffix`, `sort`, `status`, `create_time`, `update_time`) VALUES (16, 'PIXEL', '像素风', 'IMAGE', '', '像素游戏风格', 16, '0', '2026-05-12 21:51:37', NULL);
COMMIT;

-- ----------------------------
-- Table structure for ai_c_task
-- ----------------------------
DROP TABLE IF EXISTS `ai_c_task`;
CREATE TABLE `ai_c_task` (
  `task_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `task_no` varchar(32) COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务编号',
  `user_id` bigint DEFAULT NULL COMMENT '用户ID',
  `model_id` bigint NOT NULL COMMENT '模型ID',
  `model_version_id` bigint NOT NULL COMMENT '模型版本ID',
  `task_type` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务类型',
  `create_mode` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT '创作模式',
  `prompt_text` text COLLATE utf8mb4_general_ci COMMENT '提示词',
  `negative_prompt` text COLLATE utf8mb4_general_ci COMMENT '反向提示词',
  `style_code` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '风格编码',
  `ratio_code` varchar(32) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '比例编码',
  `source_url` varchar(255) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '原图地址',
  `status` varchar(20) COLLATE utf8mb4_general_ci DEFAULT 'PENDING' COMMENT '任务状态',
  `power_cost` int DEFAULT '0' COMMENT '消耗算力',
  `third_task_id` varchar(128) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '第三方任务ID',
  `request_payload` longtext COLLATE utf8mb4_general_ci COMMENT '请求载荷',
  `response_payload` longtext COLLATE utf8mb4_general_ci COMMENT '响应载荷',
  `fail_reason` varchar(255) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '失败原因',
  `submit_time` datetime DEFAULT NULL COMMENT '提交时间',
  `finish_time` datetime DEFAULT NULL COMMENT '完成时间',
  `remark` varchar(500) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '备注',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `channel_id` bigint DEFAULT NULL COMMENT '渠道ID',
  `channel_model_relation_id` bigint DEFAULT NULL COMMENT '渠道模型映射ID',
  `remote_model_name` varchar(128) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '渠道实际模型名',
  `app_id` bigint DEFAULT NULL COMMENT '来源应用ID',
  `mode_id` bigint DEFAULT NULL COMMENT '应用模式ID',
  `style_id` bigint DEFAULT NULL COMMENT '风格ID',
  `size_code` varchar(32) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '图片尺寸',
  `input_params` longtext COLLATE utf8mb4_general_ci COMMENT '完整输入参数JSON',
  PRIMARY KEY (`task_id`),
  UNIQUE KEY `uk_ai_c_task_no` (`task_no`),
  KEY `idx_ai_c_task_model_id` (`model_id`),
  KEY `idx_ai_c_task_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='AI任务表';

-- ----------------------------
-- Records of ai_c_task
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for ai_c_task_result
-- ----------------------------
DROP TABLE IF EXISTS `ai_c_task_result`;
CREATE TABLE `ai_c_task_result` (
  `result_id` bigint NOT NULL AUTO_INCREMENT COMMENT '结果ID',
  `task_id` bigint NOT NULL COMMENT '任务ID',
  `result_type` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT '结果类型',
  `file_url` varchar(255) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '文件地址',
  `cover_url` varchar(255) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '封面地址',
  `result_text` longtext COLLATE utf8mb4_general_ci COMMENT '文本结果',
  `width` int DEFAULT '0' COMMENT '宽度',
  `height` int DEFAULT '0' COMMENT '高度',
  `duration` int DEFAULT '0' COMMENT '时长',
  `seq_no` int DEFAULT '1' COMMENT '序号',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`result_id`),
  KEY `idx_ai_c_task_result_task_id` (`task_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='AI任务结果表';

-- ----------------------------
-- Records of ai_c_task_result
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for ai_c_user
-- ----------------------------
DROP TABLE IF EXISTS `ai_c_user`;
CREATE TABLE `ai_c_user` (
  `user_id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `user_no` varchar(32) COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户编号',
  `nick_name` varchar(64) COLLATE utf8mb4_general_ci NOT NULL COMMENT '昵称',
  `avatar` varchar(255) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '头像',
  `email` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '邮箱',
  `mobile` varchar(20) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '手机号',
  `status` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `invite_code` varchar(32) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '邀请码',
  `inviter_user_id` bigint DEFAULT NULL COMMENT '邀请人',
  `activate_status` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '激活状态（0未激活 1已激活）',
  `activate_time` datetime DEFAULT NULL COMMENT '激活时间',
  `last_login_ip` varchar(128) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '最近登录IP',
  `last_login_device` varchar(255) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '最近登录设备',
  `last_login_time` datetime DEFAULT NULL COMMENT '最近登录时间',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `uk_ai_c_user_user_no` (`user_no`),
  UNIQUE KEY `uk_ai_c_user_invite_code` (`invite_code`),
  UNIQUE KEY `uk_ai_c_user_email` (`email`),
  UNIQUE KEY `uk_ai_c_user_mobile` (`mobile`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='C端用户表';

-- ----------------------------
-- Records of ai_c_user
-- ----------------------------
BEGIN;
INSERT INTO `ai_c_user` (`user_id`, `user_no`, `nick_name`, `avatar`, `email`, `mobile`, `status`, `invite_code`, `inviter_user_id`, `activate_status`, `activate_time`, `last_login_ip`, `last_login_device`, `last_login_time`, `create_time`, `update_time`) VALUES (1, 'U202605110001', '开发用户', '', '', '', '0', 'DEV00001', NULL, '0', NULL, '', '', NULL, '2026-05-12 18:46:09', '2026-05-12 18:46:09');
INSERT INTO `ai_c_user` (`user_id`, `user_no`, `nick_name`, `avatar`, `email`, `mobile`, `status`, `invite_code`, `inviter_user_id`, `activate_status`, `activate_time`, `last_login_ip`, `last_login_device`, `last_login_time`, `create_time`, `update_time`) VALUES (2, 'U20260512211417E085AD', '用户prg5', '', NULL, NULL, '0', 'D2170708', NULL, '0', NULL, '127.0.0.1', 'Mozilla/5.0 (iPhone; CPU iPhone OS 15_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.0 Mobile/15E148 Safari/604.1 wechatdevtools/1.06.2504010 MicroMessenger/8.0.5 Language/zh_CN webview/ sessionid/67', '2026-05-12 23:14:11', '2026-05-12 21:14:18', '2026-05-12 23:14:11');
COMMIT;

-- ----------------------------
-- Table structure for ai_c_user_auth
-- ----------------------------
DROP TABLE IF EXISTS `ai_c_user_auth`;
CREATE TABLE `ai_c_user_auth` (
  `auth_id` bigint NOT NULL AUTO_INCREMENT COMMENT '认证ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `auth_type` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT '认证类型',
  `openid` varchar(64) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'openid',
  `unionid` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'unionid',
  `session_key` varchar(128) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'sessionKey',
  `auth_nick_name` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '三方昵称',
  `auth_avatar` varchar(255) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '三方头像',
  `auth_mobile` varchar(20) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '三方手机号',
  `remark` varchar(255) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '备注',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`auth_id`),
  UNIQUE KEY `uk_ai_c_user_auth_type_openid` (`auth_type`,`openid`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='C端用户认证表';

-- ----------------------------
-- Records of ai_c_user_auth
-- ----------------------------
BEGIN;
INSERT INTO `ai_c_user_auth` (`auth_id`, `user_id`, `auth_type`, `openid`, `unionid`, `session_key`, `auth_nick_name`, `auth_avatar`, `auth_mobile`, `remark`, `create_time`, `update_time`) VALUES (1, 1, 'DEV', 'dev-user-1', '', '', '', '', '', '', '2026-05-12 18:46:09', '2026-05-12 18:46:09');
INSERT INTO `ai_c_user_auth` (`auth_id`, `user_id`, `auth_type`, `openid`, `unionid`, `session_key`, `auth_nick_name`, `auth_avatar`, `auth_mobile`, `remark`, `create_time`, `update_time`) VALUES (2, 2, 'WECHAT_OPENID', 'oKtZA5QEWPKlR-kZPoDBnYl0WwLo', NULL, 'e29Jj8lucioooKcoCykdlQ==', '用户prg5', '', '', 'WX_MINIAPP_LOGIN', '2026-05-12 21:14:18', '2026-05-12 23:14:11');
COMMIT;

-- ----------------------------
-- Table structure for ai_c_user_invite
-- ----------------------------
DROP TABLE IF EXISTS `ai_c_user_invite`;
CREATE TABLE `ai_c_user_invite` (
  `invite_id` bigint NOT NULL AUTO_INCREMENT COMMENT '邀请记录ID',
  `inviter_user_id` bigint NOT NULL COMMENT '邀请人用户ID',
  `invitee_user_id` bigint NOT NULL COMMENT '被邀请人用户ID',
  `invite_code` varchar(32) COLLATE utf8mb4_general_ci NOT NULL COMMENT '邀请码',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`invite_id`),
  UNIQUE KEY `uk_ai_c_user_invite_invitee` (`invitee_user_id`),
  KEY `idx_ai_c_user_invite_inviter` (`inviter_user_id`),
  KEY `idx_ai_c_user_invite_code` (`invite_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='C端用户邀请关系表';

-- ----------------------------
-- Records of ai_c_user_invite
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for ai_c_wallet
-- ----------------------------
DROP TABLE IF EXISTS `ai_c_wallet`;
CREATE TABLE `ai_c_wallet` (
  `wallet_id` bigint NOT NULL AUTO_INCREMENT COMMENT '钱包ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `balance_power` int DEFAULT '0' COMMENT '可用算力',
  `freeze_power` int DEFAULT '0' COMMENT '冻结算力',
  `total_recharge_power` int DEFAULT '0' COMMENT '累计充值算力',
  `total_consume_power` int DEFAULT '0' COMMENT '累计消耗算力',
  `total_give_power` int DEFAULT '0' COMMENT '累计赠送算力',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`wallet_id`),
  UNIQUE KEY `uk_ai_c_wallet_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='AI钱包表';

-- ----------------------------
-- Records of ai_c_wallet
-- ----------------------------
BEGIN;
INSERT INTO `ai_c_wallet` (`wallet_id`, `user_id`, `balance_power`, `freeze_power`, `total_recharge_power`, `total_consume_power`, `total_give_power`, `update_time`) VALUES (1, 1, 1000, 0, 0, 0, 1000, '2026-05-12 18:46:09');
INSERT INTO `ai_c_wallet` (`wallet_id`, `user_id`, `balance_power`, `freeze_power`, `total_recharge_power`, `total_consume_power`, `total_give_power`, `update_time`) VALUES (2, 2, 600, 0, 600, 0, 0, '2026-05-12 21:38:43');
COMMIT;

-- ----------------------------
-- Table structure for ai_c_wallet_flow
-- ----------------------------
DROP TABLE IF EXISTS `ai_c_wallet_flow`;
CREATE TABLE `ai_c_wallet_flow` (
  `flow_id` bigint NOT NULL AUTO_INCREMENT COMMENT '流水ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `biz_type` varchar(32) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '业务类型',
  `biz_id` bigint DEFAULT NULL COMMENT '业务ID',
  `change_type` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT '变更类型',
  `power_num` int DEFAULT '0' COMMENT '算力值',
  `before_balance` int DEFAULT '0' COMMENT '变更前余额',
  `after_balance` int DEFAULT '0' COMMENT '变更后余额',
  `remark` varchar(255) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '备注',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`flow_id`),
  KEY `idx_ai_c_wallet_flow_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='AI钱包流水表';

-- ----------------------------
-- Records of ai_c_wallet_flow
-- ----------------------------
BEGIN;
INSERT INTO `ai_c_wallet_flow` (`flow_id`, `user_id`, `biz_type`, `biz_id`, `change_type`, `power_num`, `before_balance`, `after_balance`, `remark`, `create_time`) VALUES (1, 2, 'CARD_CODE_REDEEM', 2, 'GRANT', 600, 0, 600, '卡密兑换到账：CKADVANCE000001', '2026-05-12 21:38:43');
COMMIT;

-- ----------------------------
-- Table structure for gen_table
-- ----------------------------
DROP TABLE IF EXISTS `gen_table`;
CREATE TABLE `gen_table` (
  `table_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_name` varchar(200) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '表名称',
  `table_comment` varchar(500) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '表描述',
  `sub_table_name` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '关联子表的表名',
  `sub_table_fk_name` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '子表关联的外键名',
  `class_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '实体类名称',
  `tpl_category` varchar(200) COLLATE utf8mb4_general_ci DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作）',
  `tpl_web_type` varchar(30) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '前端模板类型（element-ui模版 element-plus模版）',
  `package_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '生成模块名',
  `business_name` varchar(30) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '生成业务名',
  `function_name` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '生成功能名',
  `function_author` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '生成功能作者',
  `form_col_num` int DEFAULT '1' COMMENT '表单布局（单列 双列 三列）',
  `gen_type` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '生成代码方式（0zip压缩包 1自定义路径）',
  `gen_path` varchar(200) COLLATE utf8mb4_general_ci DEFAULT '/' COMMENT '生成路径（不填默认项目路径）',
  `options` varchar(1000) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '其它生成选项',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`table_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='代码生成业务表';

-- ----------------------------
-- Records of gen_table
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for gen_table_column
-- ----------------------------
DROP TABLE IF EXISTS `gen_table_column`;
CREATE TABLE `gen_table_column` (
  `column_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_id` bigint DEFAULT NULL COMMENT '归属表编号',
  `column_name` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '列名称',
  `column_comment` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '列描述',
  `column_type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '列类型',
  `java_type` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '是否主键（1是）',
  `is_increment` char(1) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '是否自增（1是）',
  `is_required` char(1) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '是否必填（1是）',
  `is_insert` char(1) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '是否为插入字段（1是）',
  `is_edit` char(1) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '是否编辑字段（1是）',
  `is_list` char(1) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '是否列表字段（1是）',
  `is_query` char(1) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '是否查询字段（1是）',
  `query_type` varchar(200) COLLATE utf8mb4_general_ci DEFAULT 'EQ' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
  `html_type` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
  `dict_type` varchar(200) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '字典类型',
  `sort` int DEFAULT NULL COMMENT '排序',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`column_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='代码生成业务表字段';

-- ----------------------------
-- Records of gen_table_column
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for QRTZ_BLOB_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_BLOB_TRIGGERS`;
CREATE TABLE `QRTZ_BLOB_TRIGGERS` (
  `sched_name` varchar(120) COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `blob_data` blob COMMENT '存放持久化Trigger对象',
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  CONSTRAINT `qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `QRTZ_TRIGGERS` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Blob类型的触发器表';

-- ----------------------------
-- Records of QRTZ_BLOB_TRIGGERS
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for QRTZ_CALENDARS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_CALENDARS`;
CREATE TABLE `QRTZ_CALENDARS` (
  `sched_name` varchar(120) COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `calendar_name` varchar(200) COLLATE utf8mb4_general_ci NOT NULL COMMENT '日历名称',
  `calendar` blob NOT NULL COMMENT '存放持久化calendar对象',
  PRIMARY KEY (`sched_name`,`calendar_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='日历信息表';

-- ----------------------------
-- Records of QRTZ_CALENDARS
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for QRTZ_CRON_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_CRON_TRIGGERS`;
CREATE TABLE `QRTZ_CRON_TRIGGERS` (
  `sched_name` varchar(120) COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `cron_expression` varchar(200) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'cron表达式',
  `time_zone_id` varchar(80) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '时区',
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  CONSTRAINT `qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `QRTZ_TRIGGERS` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Cron类型的触发器表';

-- ----------------------------
-- Records of QRTZ_CRON_TRIGGERS
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for QRTZ_FIRED_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_FIRED_TRIGGERS`;
CREATE TABLE `QRTZ_FIRED_TRIGGERS` (
  `sched_name` varchar(120) COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `entry_id` varchar(95) COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度器实例id',
  `trigger_name` varchar(200) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `instance_name` varchar(200) COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度器实例名',
  `fired_time` bigint NOT NULL COMMENT '触发的时间',
  `sched_time` bigint NOT NULL COMMENT '定时器制定的时间',
  `priority` int NOT NULL COMMENT '优先级',
  `state` varchar(16) COLLATE utf8mb4_general_ci NOT NULL COMMENT '状态',
  `job_name` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '任务名称',
  `job_group` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '任务组名',
  `is_nonconcurrent` varchar(1) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '是否并发',
  `requests_recovery` varchar(1) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '是否接受恢复执行',
  PRIMARY KEY (`sched_name`,`entry_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='已触发的触发器表';

-- ----------------------------
-- Records of QRTZ_FIRED_TRIGGERS
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for QRTZ_JOB_DETAILS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_JOB_DETAILS`;
CREATE TABLE `QRTZ_JOB_DETAILS` (
  `sched_name` varchar(120) COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `job_name` varchar(200) COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(200) COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务组名',
  `description` varchar(250) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '相关介绍',
  `job_class_name` varchar(250) COLLATE utf8mb4_general_ci NOT NULL COMMENT '执行任务类名称',
  `is_durable` varchar(1) COLLATE utf8mb4_general_ci NOT NULL COMMENT '是否持久化',
  `is_nonconcurrent` varchar(1) COLLATE utf8mb4_general_ci NOT NULL COMMENT '是否并发',
  `is_update_data` varchar(1) COLLATE utf8mb4_general_ci NOT NULL COMMENT '是否更新数据',
  `requests_recovery` varchar(1) COLLATE utf8mb4_general_ci NOT NULL COMMENT '是否接受恢复执行',
  `job_data` blob COMMENT '存放持久化job对象',
  PRIMARY KEY (`sched_name`,`job_name`,`job_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='任务详细信息表';

-- ----------------------------
-- Records of QRTZ_JOB_DETAILS
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for QRTZ_LOCKS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_LOCKS`;
CREATE TABLE `QRTZ_LOCKS` (
  `sched_name` varchar(120) COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `lock_name` varchar(40) COLLATE utf8mb4_general_ci NOT NULL COMMENT '悲观锁名称',
  PRIMARY KEY (`sched_name`,`lock_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='存储的悲观锁信息表';

-- ----------------------------
-- Records of QRTZ_LOCKS
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for QRTZ_PAUSED_TRIGGER_GRPS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_PAUSED_TRIGGER_GRPS`;
CREATE TABLE `QRTZ_PAUSED_TRIGGER_GRPS` (
  `sched_name` varchar(120) COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `trigger_group` varchar(200) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  PRIMARY KEY (`sched_name`,`trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='暂停的触发器表';

-- ----------------------------
-- Records of QRTZ_PAUSED_TRIGGER_GRPS
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for QRTZ_SCHEDULER_STATE
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_SCHEDULER_STATE`;
CREATE TABLE `QRTZ_SCHEDULER_STATE` (
  `sched_name` varchar(120) COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `instance_name` varchar(200) COLLATE utf8mb4_general_ci NOT NULL COMMENT '实例名称',
  `last_checkin_time` bigint NOT NULL COMMENT '上次检查时间',
  `checkin_interval` bigint NOT NULL COMMENT '检查间隔时间',
  PRIMARY KEY (`sched_name`,`instance_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='调度器状态表';

-- ----------------------------
-- Records of QRTZ_SCHEDULER_STATE
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for QRTZ_SIMPLE_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_SIMPLE_TRIGGERS`;
CREATE TABLE `QRTZ_SIMPLE_TRIGGERS` (
  `sched_name` varchar(120) COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `repeat_count` bigint NOT NULL COMMENT '重复的次数统计',
  `repeat_interval` bigint NOT NULL COMMENT '重复的间隔时间',
  `times_triggered` bigint NOT NULL COMMENT '已经触发的次数',
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  CONSTRAINT `qrtz_simple_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `QRTZ_TRIGGERS` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='简单触发器的信息表';

-- ----------------------------
-- Records of QRTZ_SIMPLE_TRIGGERS
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for QRTZ_SIMPROP_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_SIMPROP_TRIGGERS`;
CREATE TABLE `QRTZ_SIMPROP_TRIGGERS` (
  `sched_name` varchar(120) COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `str_prop_1` varchar(512) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'String类型的trigger的第一个参数',
  `str_prop_2` varchar(512) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'String类型的trigger的第二个参数',
  `str_prop_3` varchar(512) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'String类型的trigger的第三个参数',
  `int_prop_1` int DEFAULT NULL COMMENT 'int类型的trigger的第一个参数',
  `int_prop_2` int DEFAULT NULL COMMENT 'int类型的trigger的第二个参数',
  `long_prop_1` bigint DEFAULT NULL COMMENT 'long类型的trigger的第一个参数',
  `long_prop_2` bigint DEFAULT NULL COMMENT 'long类型的trigger的第二个参数',
  `dec_prop_1` decimal(13,4) DEFAULT NULL COMMENT 'decimal类型的trigger的第一个参数',
  `dec_prop_2` decimal(13,4) DEFAULT NULL COMMENT 'decimal类型的trigger的第二个参数',
  `bool_prop_1` varchar(1) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'Boolean类型的trigger的第一个参数',
  `bool_prop_2` varchar(1) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'Boolean类型的trigger的第二个参数',
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  CONSTRAINT `qrtz_simprop_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `QRTZ_TRIGGERS` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='同步机制的行锁表';

-- ----------------------------
-- Records of QRTZ_SIMPROP_TRIGGERS
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for QRTZ_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_TRIGGERS`;
CREATE TABLE `QRTZ_TRIGGERS` (
  `sched_name` varchar(120) COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) COLLATE utf8mb4_general_ci NOT NULL COMMENT '触发器的名字',
  `trigger_group` varchar(200) COLLATE utf8mb4_general_ci NOT NULL COMMENT '触发器所属组的名字',
  `job_name` varchar(200) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_job_details表job_name的外键',
  `job_group` varchar(200) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_job_details表job_group的外键',
  `description` varchar(250) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '相关介绍',
  `next_fire_time` bigint DEFAULT NULL COMMENT '上一次触发时间（毫秒）',
  `prev_fire_time` bigint DEFAULT NULL COMMENT '下一次触发时间（默认为-1表示不触发）',
  `priority` int DEFAULT NULL COMMENT '优先级',
  `trigger_state` varchar(16) COLLATE utf8mb4_general_ci NOT NULL COMMENT '触发器状态',
  `trigger_type` varchar(8) COLLATE utf8mb4_general_ci NOT NULL COMMENT '触发器的类型',
  `start_time` bigint NOT NULL COMMENT '开始时间',
  `end_time` bigint DEFAULT NULL COMMENT '结束时间',
  `calendar_name` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '日程表名称',
  `misfire_instr` smallint DEFAULT NULL COMMENT '补偿执行的策略',
  `job_data` blob COMMENT '存放持久化job对象',
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  KEY `sched_name` (`sched_name`,`job_name`,`job_group`),
  CONSTRAINT `qrtz_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `job_name`, `job_group`) REFERENCES `QRTZ_JOB_DETAILS` (`sched_name`, `job_name`, `job_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='触发器详细信息表';

-- ----------------------------
-- Records of QRTZ_TRIGGERS
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config` (
  `config_id` int NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `config_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) COLLATE utf8mb4_general_ci DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='参数配置表';

-- ----------------------------
-- Records of sys_config
-- ----------------------------
BEGIN;
INSERT INTO `sys_config` (`config_id`, `config_name`, `config_key`, `config_value`, `config_type`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1, '主框架页-默认皮肤样式名称', 'sys.index.skinName', 'skin-blue', 'Y', 'admin', '2026-05-12 18:45:51', '', NULL, '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow');
INSERT INTO `sys_config` (`config_id`, `config_name`, `config_key`, `config_value`, `config_type`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2, '用户管理-账号初始密码', 'sys.user.initPassword', '123456', 'Y', 'admin', '2026-05-12 18:45:51', '', NULL, '初始化密码 123456');
INSERT INTO `sys_config` (`config_id`, `config_name`, `config_key`, `config_value`, `config_type`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (3, '主框架页-侧边栏主题', 'sys.index.sideTheme', 'theme-dark', 'Y', 'admin', '2026-05-12 18:45:51', '', NULL, '深色主题theme-dark，浅色主题theme-light');
INSERT INTO `sys_config` (`config_id`, `config_name`, `config_key`, `config_value`, `config_type`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (4, '账号自助-验证码开关', 'sys.account.captchaEnabled', 'false', 'Y', 'admin', '2026-05-12 18:45:51', 'admin', '2026-05-12 18:49:29', '是否开启验证码功能（true开启，false关闭）');
INSERT INTO `sys_config` (`config_id`, `config_name`, `config_key`, `config_value`, `config_type`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (5, '账号自助-是否开启用户注册功能', 'sys.account.registerUser', 'false', 'Y', 'admin', '2026-05-12 18:45:51', '', NULL, '是否开启注册用户功能（true开启，false关闭）');
INSERT INTO `sys_config` (`config_id`, `config_name`, `config_key`, `config_value`, `config_type`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (6, '用户登录-黑名单列表', 'sys.login.blackIPList', '', 'Y', 'admin', '2026-05-12 18:45:51', '', NULL, '设置登录IP黑名单限制，多个匹配项以;分隔，支持匹配（*通配、网段）');
INSERT INTO `sys_config` (`config_id`, `config_name`, `config_key`, `config_value`, `config_type`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (7, '用户管理-初始密码修改策略', 'sys.account.initPasswordModify', '1', 'Y', 'admin', '2026-05-12 18:45:51', '', NULL, '0：初始密码修改策略关闭，没有任何提示，1：提醒用户，如果未修改初始密码，则在登录时就会提醒修改密码对话框');
INSERT INTO `sys_config` (`config_id`, `config_name`, `config_key`, `config_value`, `config_type`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (8, '用户管理-账号密码更新周期', 'sys.account.passwordValidateDays', '0', 'Y', 'admin', '2026-05-12 18:45:51', '', NULL, '密码更新周期（填写数字，数据初始化值为0不限制，若修改必须为大于0小于365的正整数），如果超过这个周期登录系统时，则在登录时就会提醒修改密码对话框');
INSERT INTO `sys_config` (`config_id`, `config_name`, `config_key`, `config_value`, `config_type`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (9, '用户管理-密码字符范围', 'sys.account.chrtype', '0', 'Y', 'admin', '2026-05-12 18:45:51', '', NULL, '默认任意字符范围，0任意（密码可以输入任意字符），1数字（密码只能为0-9数字），2英文字母（密码只能为a-z和A-Z字母），3字母和数字（密码必须包含字母，数字）,4字母数字和特殊字符（目前支持的特殊字符包括：~!@#$%^&*()-=_+）');
COMMIT;

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept` (
  `dept_id` bigint NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `parent_id` bigint DEFAULT '0' COMMENT '父部门id',
  `ancestors` varchar(50) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(30) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '部门名称',
  `order_num` int DEFAULT '0' COMMENT '显示顺序',
  `leader` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '邮箱',
  `status` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `del_flag` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`)
) ENGINE=InnoDB AUTO_INCREMENT=200 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='部门表';

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
BEGIN;
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (100, 0, '0', '若依科技', 0, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-05-12 18:45:51', '', NULL);
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (101, 100, '0,100', '深圳总公司', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-05-12 18:45:51', '', NULL);
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (102, 100, '0,100', '长沙分公司', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-05-12 18:45:51', '', NULL);
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (103, 101, '0,100,101', '研发部门', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-05-12 18:45:51', '', NULL);
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (104, 101, '0,100,101', '市场部门', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-05-12 18:45:51', '', NULL);
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (105, 101, '0,100,101', '测试部门', 3, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-05-12 18:45:51', '', NULL);
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (106, 101, '0,100,101', '财务部门', 4, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-05-12 18:45:51', '', NULL);
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (107, 101, '0,100,101', '运维部门', 5, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-05-12 18:45:51', '', NULL);
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (108, 102, '0,100,102', '市场部门', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-05-12 18:45:51', '', NULL);
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `ancestors`, `dept_name`, `order_num`, `leader`, `phone`, `email`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES (109, 102, '0,100,102', '财务部门', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-05-12 18:45:51', '', NULL);
COMMIT;

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE `sys_dict_data` (
  `dict_code` bigint NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `dict_sort` int DEFAULT '0' COMMENT '字典排序',
  `dict_label` varchar(100) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) COLLATE utf8mb4_general_ci DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`)
) ENGINE=InnoDB AUTO_INCREMENT=1034 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='字典数据表';

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
BEGIN;
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1, 1, '男', '0', 'sys_user_sex', '', '', 'Y', '0', 'admin', '2026-05-12 18:45:51', '', NULL, '性别男');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2, 2, '女', '1', 'sys_user_sex', '', '', 'N', '0', 'admin', '2026-05-12 18:45:51', '', NULL, '性别女');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (3, 3, '未知', '2', 'sys_user_sex', '', '', 'N', '0', 'admin', '2026-05-12 18:45:51', '', NULL, '性别未知');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (4, 1, '显示', '0', 'sys_show_hide', '', 'primary', 'Y', '0', 'admin', '2026-05-12 18:45:51', '', NULL, '显示菜单');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (5, 2, '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', '0', 'admin', '2026-05-12 18:45:51', '', NULL, '隐藏菜单');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (6, 1, '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', '0', 'admin', '2026-05-12 18:45:51', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (7, 2, '停用', '1', 'sys_normal_disable', '', 'danger', 'N', '0', 'admin', '2026-05-12 18:45:51', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (8, 1, '正常', '0', 'sys_job_status', '', 'primary', 'Y', '0', 'admin', '2026-05-12 18:45:51', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (9, 2, '暂停', '1', 'sys_job_status', '', 'danger', 'N', '0', 'admin', '2026-05-12 18:45:51', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (10, 1, '默认', 'DEFAULT', 'sys_job_group', '', '', 'Y', '0', 'admin', '2026-05-12 18:45:51', '', NULL, '默认分组');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (11, 2, '系统', 'SYSTEM', 'sys_job_group', '', '', 'N', '0', 'admin', '2026-05-12 18:45:51', '', NULL, '系统分组');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (12, 1, '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', '0', 'admin', '2026-05-12 18:45:51', '', NULL, '系统默认是');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (13, 2, '否', 'N', 'sys_yes_no', '', 'danger', 'N', '0', 'admin', '2026-05-12 18:45:51', '', NULL, '系统默认否');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (14, 1, '通知', '1', 'sys_notice_type', '', 'warning', 'Y', '0', 'admin', '2026-05-12 18:45:51', '', NULL, '通知');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (15, 2, '公告', '2', 'sys_notice_type', '', 'success', 'N', '0', 'admin', '2026-05-12 18:45:51', '', NULL, '公告');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (16, 1, '正常', '0', 'sys_notice_status', '', 'primary', 'Y', '0', 'admin', '2026-05-12 18:45:51', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (17, 2, '关闭', '1', 'sys_notice_status', '', 'danger', 'N', '0', 'admin', '2026-05-12 18:45:51', '', NULL, '关闭状态');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (18, 99, '其他', '0', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2026-05-12 18:45:51', '', NULL, '其他操作');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (19, 1, '新增', '1', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2026-05-12 18:45:51', '', NULL, '新增操作');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (20, 2, '修改', '2', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2026-05-12 18:45:51', '', NULL, '修改操作');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (21, 3, '删除', '3', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2026-05-12 18:45:51', '', NULL, '删除操作');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (22, 4, '授权', '4', 'sys_oper_type', '', 'primary', 'N', '0', 'admin', '2026-05-12 18:45:51', '', NULL, '授权操作');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (23, 5, '导出', '5', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2026-05-12 18:45:51', '', NULL, '导出操作');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (24, 6, '导入', '6', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2026-05-12 18:45:51', '', NULL, '导入操作');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (25, 7, '强退', '7', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2026-05-12 18:45:51', '', NULL, '强退操作');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (26, 8, '生成代码', '8', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2026-05-12 18:45:51', '', NULL, '生成操作');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (27, 9, '清空数据', '9', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2026-05-12 18:45:51', '', NULL, '清空操作');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (28, 1, '成功', '0', 'sys_common_status', '', 'primary', 'N', '0', 'admin', '2026-05-12 18:45:51', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (29, 2, '失败', '1', 'sys_common_status', '', 'danger', 'N', '0', 'admin', '2026-05-12 18:45:51', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1000, 1, '文本', 'TEXT', 'ai_model_type', '', 'primary', 'N', '0', 'admin', '2026-05-12 18:46:28', '', NULL, '文本模型');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1001, 2, '图片', 'IMAGE', 'ai_model_type', '', 'success', 'Y', '0', 'admin', '2026-05-12 18:46:28', '', NULL, '图片模型');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1002, 3, '视频', 'VIDEO', 'ai_model_type', '', 'warning', 'N', '0', 'admin', '2026-05-12 18:46:28', '', NULL, '视频模型');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1010, 1, '待执行', 'PENDING', 'ai_task_status', '', 'info', 'N', '0', 'admin', '2026-05-12 18:46:28', '', NULL, '待执行');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1011, 2, '执行中', 'RUNNING', 'ai_task_status', '', 'warning', 'N', '0', 'admin', '2026-05-12 18:46:28', '', NULL, '执行中');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1012, 3, '成功', 'SUCCESS', 'ai_task_status', '', 'success', 'Y', '0', 'admin', '2026-05-12 18:46:28', '', NULL, '成功');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1013, 4, '失败', 'FAIL', 'ai_task_status', '', 'danger', 'N', '0', 'admin', '2026-05-12 18:46:28', '', NULL, '失败');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1020, 1, '待支付', 'WAIT_PAY', 'ai_order_status', '', 'warning', 'N', '0', 'admin', '2026-05-12 18:46:28', '', NULL, '待支付');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1021, 2, '已支付', 'PAID', 'ai_order_status', '', 'success', 'Y', '0', 'admin', '2026-05-12 18:46:28', '', NULL, '已支付');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1022, 3, '已关闭', 'CLOSED', 'ai_order_status', '', 'info', 'N', '0', 'admin', '2026-05-12 18:46:28', '', NULL, '已关闭');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1023, 4, '已退款', 'REFUNDED', 'ai_order_status', '', 'danger', 'N', '0', 'admin', '2026-05-12 18:46:28', '', NULL, '已退款');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1030, 1, '正常', 'NORMAL', 'ai_work_status', '', 'success', 'Y', '0', 'admin', '2026-05-12 18:46:28', '', NULL, '正常');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1031, 2, '已删除', 'DELETED', 'ai_work_status', '', 'info', 'N', '0', 'admin', '2026-05-12 18:46:28', '', NULL, '已删除');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1032, 3, '审核中', 'REVIEWING', 'ai_work_status', '', 'warning', 'N', '0', 'admin', '2026-05-12 18:46:28', '', NULL, '审核中');
INSERT INTO `sys_dict_data` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1033, 4, '违规', 'BLOCKED', 'ai_work_status', '', 'danger', 'N', '0', 'admin', '2026-05-12 18:46:28', '', NULL, '违规');
COMMIT;

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type` (
  `dict_id` bigint NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `dict_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '字典类型',
  `status` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`),
  UNIQUE KEY `dict_type` (`dict_type`)
) ENGINE=InnoDB AUTO_INCREMENT=104 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='字典类型表';

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
BEGIN;
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1, '用户性别', 'sys_user_sex', '0', 'admin', '2026-05-12 18:45:51', '', NULL, '用户性别列表');
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2, '菜单状态', 'sys_show_hide', '0', 'admin', '2026-05-12 18:45:51', '', NULL, '菜单状态列表');
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (3, '系统开关', 'sys_normal_disable', '0', 'admin', '2026-05-12 18:45:51', '', NULL, '系统开关列表');
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (4, '任务状态', 'sys_job_status', '0', 'admin', '2026-05-12 18:45:51', '', NULL, '任务状态列表');
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (5, '任务分组', 'sys_job_group', '0', 'admin', '2026-05-12 18:45:51', '', NULL, '任务分组列表');
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (6, '系统是否', 'sys_yes_no', '0', 'admin', '2026-05-12 18:45:51', '', NULL, '系统是否列表');
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (7, '通知类型', 'sys_notice_type', '0', 'admin', '2026-05-12 18:45:51', '', NULL, '通知类型列表');
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (8, '通知状态', 'sys_notice_status', '0', 'admin', '2026-05-12 18:45:51', '', NULL, '通知状态列表');
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (9, '操作类型', 'sys_oper_type', '0', 'admin', '2026-05-12 18:45:51', '', NULL, '操作类型列表');
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (10, '系统状态', 'sys_common_status', '0', 'admin', '2026-05-12 18:45:51', '', NULL, '登录状态列表');
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (100, 'AI模型类型', 'ai_model_type', '0', 'admin', '2026-05-12 18:46:28', '', NULL, 'AI模型类型列表');
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (101, 'AI任务状态', 'ai_task_status', '0', 'admin', '2026-05-12 18:46:28', '', NULL, 'AI任务状态列表');
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (102, 'AI订单状态', 'ai_order_status', '0', 'admin', '2026-05-12 18:46:28', '', NULL, 'AI订单状态列表');
INSERT INTO `sys_dict_type` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (103, 'AI作品状态', 'ai_work_status', '0', 'admin', '2026-05-12 18:46:28', '', NULL, 'AI作品状态列表');
COMMIT;

-- ----------------------------
-- Table structure for sys_job
-- ----------------------------
DROP TABLE IF EXISTS `sys_job`;
CREATE TABLE `sys_job` (
  `job_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `job_name` varchar(64) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '任务名称',
  `job_group` varchar(64) COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
  `invoke_target` varchar(500) COLLATE utf8mb4_general_ci NOT NULL COMMENT '调用目标字符串',
  `cron_expression` varchar(255) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT 'cron执行表达式',
  `misfire_policy` varchar(20) COLLATE utf8mb4_general_ci DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
  `concurrent` char(1) COLLATE utf8mb4_general_ci DEFAULT '1' COMMENT '是否并发执行（0允许 1禁止）',
  `status` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '状态（0正常 1暂停）',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '备注信息',
  PRIMARY KEY (`job_id`,`job_name`,`job_group`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='定时任务调度表';

-- ----------------------------
-- Records of sys_job
-- ----------------------------
BEGIN;
INSERT INTO `sys_job` (`job_id`, `job_name`, `job_group`, `invoke_target`, `cron_expression`, `misfire_policy`, `concurrent`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1, '系统默认（无参）', 'DEFAULT', 'ryTask.ryNoParams', '0/10 * * * * ?', '3', '1', '1', 'admin', '2026-05-12 18:45:51', '', NULL, '');
INSERT INTO `sys_job` (`job_id`, `job_name`, `job_group`, `invoke_target`, `cron_expression`, `misfire_policy`, `concurrent`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2, '系统默认（有参）', 'DEFAULT', 'ryTask.ryParams(\'ry\')', '0/15 * * * * ?', '3', '1', '1', 'admin', '2026-05-12 18:45:51', '', NULL, '');
INSERT INTO `sys_job` (`job_id`, `job_name`, `job_group`, `invoke_target`, `cron_expression`, `misfire_policy`, `concurrent`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (3, '系统默认（多参）', 'DEFAULT', 'ryTask.ryMultipleParams(\'ry\', true, 2000L, 316.50D, 100)', '0/20 * * * * ?', '3', '1', '1', 'admin', '2026-05-12 18:45:51', '', NULL, '');
COMMIT;

-- ----------------------------
-- Table structure for sys_job_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_job_log`;
CREATE TABLE `sys_job_log` (
  `job_log_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务日志ID',
  `job_name` varchar(64) COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(64) COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务组名',
  `invoke_target` varchar(500) COLLATE utf8mb4_general_ci NOT NULL COMMENT '调用目标字符串',
  `job_message` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '日志信息',
  `status` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '执行状态（0正常 1失败）',
  `exception_info` varchar(2000) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '异常信息',
  `start_time` datetime DEFAULT NULL COMMENT '执行开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '执行结束时间',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`job_log_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='定时任务调度日志表';

-- ----------------------------
-- Records of sys_job_log
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for sys_logininfor
-- ----------------------------
DROP TABLE IF EXISTS `sys_logininfor`;
CREATE TABLE `sys_logininfor` (
  `info_id` bigint NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `user_name` varchar(50) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '用户账号',
  `ipaddr` varchar(128) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '操作系统',
  `status` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '提示消息',
  `login_time` datetime DEFAULT NULL COMMENT '访问时间',
  PRIMARY KEY (`info_id`),
  KEY `idx_sys_logininfor_s` (`status`),
  KEY `idx_sys_logininfor_lt` (`login_time`)
) ENGINE=InnoDB AUTO_INCREMENT=105 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='系统访问记录';

-- ----------------------------
-- Records of sys_logininfor
-- ----------------------------
BEGIN;
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (100, 'admin', '127.0.0.1', '内网IP', 'Chrome 147', 'Mac OS >=10.15.7', '0', '登录成功', '2026-05-12 18:49:11');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (101, 'admin', '127.0.0.1', '内网IP', 'Chrome 147', 'Mac OS >=10.15.7', '0', '登录成功', '2026-05-12 20:05:34');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (102, 'admin', '127.0.0.1', '内网IP', 'Chrome 147', 'Mac OS >=10.15.7', '0', '登录成功', '2026-05-12 20:50:57');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (103, 'admin', '127.0.0.1', '内网IP', 'Chrome 147', 'Mac OS >=10.15.7', '0', '登录成功', '2026-05-12 21:38:30');
INSERT INTO `sys_logininfor` (`info_id`, `user_name`, `ipaddr`, `login_location`, `browser`, `os`, `status`, `msg`, `login_time`) VALUES (104, 'admin', '127.0.0.1', '内网IP', 'Chrome 147', 'Mac OS >=10.15.7', '0', '登录成功', '2026-05-12 23:09:27');
COMMIT;

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu` (
  `menu_id` bigint NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `menu_name` varchar(50) COLLATE utf8mb4_general_ci NOT NULL COMMENT '菜单名称',
  `parent_id` bigint DEFAULT '0' COMMENT '父菜单ID',
  `order_num` int DEFAULT '0' COMMENT '显示顺序',
  `path` varchar(200) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '路由地址',
  `component` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '组件路径',
  `query` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '路由参数',
  `route_name` varchar(50) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '路由名称',
  `is_frame` int DEFAULT '1' COMMENT '是否为外链（0是 1否）',
  `is_cache` int DEFAULT '0' COMMENT '是否缓存（0缓存 1不缓存）',
  `menu_type` char(1) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `status` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `perms` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) COLLATE utf8mb4_general_ci DEFAULT '#' COMMENT '菜单图标',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2905 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='菜单权限表';

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
BEGIN;
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1, '系统管理', 0, 1, 'system', NULL, '', '', 1, 0, 'M', '0', '0', '', 'system', 'admin', '2026-05-12 18:45:51', '', NULL, '系统管理目录');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2, '系统监控', 0, 2, 'monitor', NULL, '', '', 1, 0, 'M', '0', '0', '', 'monitor', 'admin', '2026-05-12 18:45:51', '', NULL, '系统监控目录');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (3, '系统工具', 0, 3, 'tool', NULL, '', '', 1, 0, 'M', '0', '0', '', 'tool', 'admin', '2026-05-12 18:45:51', '', NULL, '系统工具目录');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (4, '若依官网', 0, 4, 'http://ruoyi.vip', NULL, '', '', 0, 0, 'M', '0', '0', '', 'guide', 'admin', '2026-05-12 18:45:51', '', NULL, '若依官网地址');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (100, '用户管理', 1, 1, 'user', 'system/user/index', '', '', 1, 0, 'C', '0', '0', 'system:user:list', 'user', 'admin', '2026-05-12 18:45:51', '', NULL, '用户管理菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (101, '角色管理', 1, 2, 'role', 'system/role/index', '', '', 1, 0, 'C', '0', '0', 'system:role:list', 'peoples', 'admin', '2026-05-12 18:45:51', '', NULL, '角色管理菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (102, '菜单管理', 1, 3, 'menu', 'system/menu/index', '', '', 1, 0, 'C', '0', '0', 'system:menu:list', 'tree-table', 'admin', '2026-05-12 18:45:51', '', NULL, '菜单管理菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (103, '部门管理', 1, 4, 'dept', 'system/dept/index', '', '', 1, 0, 'C', '0', '0', 'system:dept:list', 'tree', 'admin', '2026-05-12 18:45:51', '', NULL, '部门管理菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (104, '岗位管理', 1, 5, 'post', 'system/post/index', '', '', 1, 0, 'C', '0', '0', 'system:post:list', 'post', 'admin', '2026-05-12 18:45:51', '', NULL, '岗位管理菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (105, '字典管理', 1, 6, 'dict', 'system/dict/index', '', '', 1, 0, 'C', '0', '0', 'system:dict:list', 'dict', 'admin', '2026-05-12 18:45:51', '', NULL, '字典管理菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (106, '参数设置', 1, 7, 'config', 'system/config/index', '', '', 1, 0, 'C', '0', '0', 'system:config:list', 'edit', 'admin', '2026-05-12 18:45:51', '', NULL, '参数设置菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (107, '通知公告', 1, 8, 'notice', 'system/notice/index', '', '', 1, 0, 'C', '0', '0', 'system:notice:list', 'message', 'admin', '2026-05-12 18:45:51', '', NULL, '通知公告菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (108, '日志管理', 1, 9, 'log', '', '', '', 1, 0, 'M', '0', '0', '', 'log', 'admin', '2026-05-12 18:45:51', '', NULL, '日志管理菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (109, '在线用户', 2, 1, 'online', 'monitor/online/index', '', '', 1, 0, 'C', '0', '0', 'monitor:online:list', 'online', 'admin', '2026-05-12 18:45:51', '', NULL, '在线用户菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (110, '定时任务', 2, 2, 'job', 'monitor/job/index', '', '', 1, 0, 'C', '0', '0', 'monitor:job:list', 'job', 'admin', '2026-05-12 18:45:51', '', NULL, '定时任务菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (111, '数据监控', 2, 3, 'druid', 'monitor/druid/index', '', '', 1, 0, 'C', '0', '0', 'monitor:druid:list', 'druid', 'admin', '2026-05-12 18:45:51', '', NULL, '数据监控菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (112, '服务监控', 2, 4, 'server', 'monitor/server/index', '', '', 1, 0, 'C', '0', '0', 'monitor:server:list', 'server', 'admin', '2026-05-12 18:45:51', '', NULL, '服务监控菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (113, '缓存监控', 2, 5, 'cache', 'monitor/cache/index', '', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis', 'admin', '2026-05-12 18:45:51', '', NULL, '缓存监控菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (114, '缓存列表', 2, 6, 'cacheList', 'monitor/cache/list', '', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis-list', 'admin', '2026-05-12 18:45:51', '', NULL, '缓存列表菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (115, '表单构建', 3, 1, 'build', 'tool/build/index', '', '', 1, 0, 'C', '0', '0', 'tool:build:list', 'build', 'admin', '2026-05-12 18:45:51', '', NULL, '表单构建菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (116, '代码生成', 3, 2, 'gen', 'tool/gen/index', '', '', 1, 0, 'C', '0', '0', 'tool:gen:list', 'code', 'admin', '2026-05-12 18:45:51', '', NULL, '代码生成菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (117, '系统接口', 3, 3, 'swagger', 'tool/swagger/index', '', '', 1, 0, 'C', '0', '0', 'tool:swagger:list', 'swagger', 'admin', '2026-05-12 18:45:51', '', NULL, '系统接口菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (500, '操作日志', 108, 1, 'operlog', 'monitor/operlog/index', '', '', 1, 0, 'C', '0', '0', 'monitor:operlog:list', 'form', 'admin', '2026-05-12 18:45:51', '', NULL, '操作日志菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (501, '登录日志', 108, 2, 'logininfor', 'monitor/logininfor/index', '', '', 1, 0, 'C', '0', '0', 'monitor:logininfor:list', 'logininfor', 'admin', '2026-05-12 18:45:51', '', NULL, '登录日志菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1000, '用户查询', 100, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:query', '#', 'admin', '2026-05-12 18:45:51', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1001, '用户新增', 100, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:add', '#', 'admin', '2026-05-12 18:45:51', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1002, '用户修改', 100, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:edit', '#', 'admin', '2026-05-12 18:45:51', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1003, '用户删除', 100, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:remove', '#', 'admin', '2026-05-12 18:45:51', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1004, '用户导出', 100, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:export', '#', 'admin', '2026-05-12 18:45:51', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1005, '用户导入', 100, 6, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:import', '#', 'admin', '2026-05-12 18:45:51', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1006, '重置密码', 100, 7, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:resetPwd', '#', 'admin', '2026-05-12 18:45:51', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1007, '角色查询', 101, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:query', '#', 'admin', '2026-05-12 18:45:51', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1008, '角色新增', 101, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:add', '#', 'admin', '2026-05-12 18:45:51', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1009, '角色修改', 101, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:edit', '#', 'admin', '2026-05-12 18:45:51', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1010, '角色删除', 101, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:remove', '#', 'admin', '2026-05-12 18:45:51', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1011, '角色导出', 101, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:export', '#', 'admin', '2026-05-12 18:45:51', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1012, '菜单查询', 102, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:query', '#', 'admin', '2026-05-12 18:45:51', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1013, '菜单新增', 102, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:add', '#', 'admin', '2026-05-12 18:45:51', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1014, '菜单修改', 102, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:edit', '#', 'admin', '2026-05-12 18:45:51', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1015, '菜单删除', 102, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:remove', '#', 'admin', '2026-05-12 18:45:51', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1016, '部门查询', 103, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:query', '#', 'admin', '2026-05-12 18:45:51', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1017, '部门新增', 103, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:add', '#', 'admin', '2026-05-12 18:45:51', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1018, '部门修改', 103, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:edit', '#', 'admin', '2026-05-12 18:45:51', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1019, '部门删除', 103, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:remove', '#', 'admin', '2026-05-12 18:45:51', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1020, '岗位查询', 104, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:query', '#', 'admin', '2026-05-12 18:45:51', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1021, '岗位新增', 104, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:add', '#', 'admin', '2026-05-12 18:45:51', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1022, '岗位修改', 104, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:edit', '#', 'admin', '2026-05-12 18:45:51', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1023, '岗位删除', 104, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:remove', '#', 'admin', '2026-05-12 18:45:51', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1024, '岗位导出', 104, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:export', '#', 'admin', '2026-05-12 18:45:51', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1025, '字典查询', 105, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:query', '#', 'admin', '2026-05-12 18:45:51', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1026, '字典新增', 105, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:add', '#', 'admin', '2026-05-12 18:45:51', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1027, '字典修改', 105, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:edit', '#', 'admin', '2026-05-12 18:45:51', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1028, '字典删除', 105, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:remove', '#', 'admin', '2026-05-12 18:45:51', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1029, '字典导出', 105, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:export', '#', 'admin', '2026-05-12 18:45:51', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1030, '参数查询', 106, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:query', '#', 'admin', '2026-05-12 18:45:51', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1031, '参数新增', 106, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:add', '#', 'admin', '2026-05-12 18:45:51', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1032, '参数修改', 106, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:edit', '#', 'admin', '2026-05-12 18:45:51', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1033, '参数删除', 106, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:remove', '#', 'admin', '2026-05-12 18:45:51', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1034, '参数导出', 106, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:export', '#', 'admin', '2026-05-12 18:45:51', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1035, '公告查询', 107, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:query', '#', 'admin', '2026-05-12 18:45:51', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1036, '公告新增', 107, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:add', '#', 'admin', '2026-05-12 18:45:51', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1037, '公告修改', 107, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:edit', '#', 'admin', '2026-05-12 18:45:51', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1038, '公告删除', 107, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:remove', '#', 'admin', '2026-05-12 18:45:51', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1039, '操作查询', 500, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:query', '#', 'admin', '2026-05-12 18:45:51', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1040, '操作删除', 500, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:remove', '#', 'admin', '2026-05-12 18:45:51', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1041, '日志导出', 500, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:export', '#', 'admin', '2026-05-12 18:45:51', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1042, '登录查询', 501, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:query', '#', 'admin', '2026-05-12 18:45:51', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1043, '登录删除', 501, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:remove', '#', 'admin', '2026-05-12 18:45:51', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1044, '日志导出', 501, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:export', '#', 'admin', '2026-05-12 18:45:51', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1045, '账户解锁', 501, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:unlock', '#', 'admin', '2026-05-12 18:45:51', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1046, '在线查询', 109, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:query', '#', 'admin', '2026-05-12 18:45:51', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1047, '批量强退', 109, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:batchLogout', '#', 'admin', '2026-05-12 18:45:51', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1048, '单条强退', 109, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:forceLogout', '#', 'admin', '2026-05-12 18:45:51', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1049, '任务查询', 110, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:query', '#', 'admin', '2026-05-12 18:45:51', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1050, '任务新增', 110, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:add', '#', 'admin', '2026-05-12 18:45:51', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1051, '任务修改', 110, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:edit', '#', 'admin', '2026-05-12 18:45:51', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1052, '任务删除', 110, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:remove', '#', 'admin', '2026-05-12 18:45:51', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1053, '状态修改', 110, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:changeStatus', '#', 'admin', '2026-05-12 18:45:51', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1054, '任务导出', 110, 6, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:export', '#', 'admin', '2026-05-12 18:45:51', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1055, '生成查询', 116, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:query', '#', 'admin', '2026-05-12 18:45:51', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1056, '生成修改', 116, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:edit', '#', 'admin', '2026-05-12 18:45:51', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1057, '生成删除', 116, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:remove', '#', 'admin', '2026-05-12 18:45:51', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1058, '导入代码', 116, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:import', '#', 'admin', '2026-05-12 18:45:51', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1059, '预览代码', 116, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:preview', '#', 'admin', '2026-05-12 18:45:51', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1060, '生成代码', 116, 6, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:code', '#', 'admin', '2026-05-12 18:45:51', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2000, 'AI创作', 0, 5, 'ai', '', '', '', 1, 0, 'M', '0', '0', '', 'magic-stick', 'admin', '2026-05-12 18:46:27', '', NULL, 'AI创作目录');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2001, '模型管理', 2000, 3, 'model', 'ai/model/index', '', '', 1, 0, 'C', '0', '0', 'ai:model:list', 'guide', 'admin', '2026-05-12 18:46:27', '', NULL, 'AI模型管理菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2002, '模型版本', 2001, 99, 'modelVersion', 'ai/modelVersion/index', '', '', 1, 0, 'C', '1', '0', 'ai:modelVersion:list', 'tree-table', 'admin', '2026-05-12 18:46:27', '', NULL, '模型版本内嵌管理页');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2003, '创作任务', 2000, 4, 'task', 'ai/task/index', '', '', 1, 0, 'C', '0', '0', 'ai:task:list', 'job', 'admin', '2026-05-12 18:46:27', '', NULL, 'AI任务管理菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2004, '会员钱包记录', 2005, 3, 'wallet', 'ai/wallet/index', '', '', 1, 0, 'C', '0', '0', 'ai:wallet:list', 'money', 'admin', '2026-05-12 18:46:27', '', NULL, '会员钱包记录菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2005, '会员列表', 0, 6, 'member', '', '', '', 1, 0, 'M', '0', '0', '', 'peoples', 'admin', '2026-05-12 18:46:27', '', NULL, '会员目录菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2006, '卡包管理', 2020, 1, 'cardPackage', 'ai/rechargePackage/index', '', '', 1, 0, 'C', '0', '0', 'ai:rechargePackage:list', 'shopping', 'admin', '2026-05-12 18:46:27', '', NULL, '卡包管理菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2007, '充值订单', 2010, 1, 'order', 'ai/order/index', '', '', 1, 0, 'C', '0', '0', 'ai:order:list', 'order', 'admin', '2026-05-12 18:46:27', '', NULL, '充值订单管理菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2008, '支付配置', 2010, 2, 'payConfig', 'ai/payConfig/index', '', '', 1, 0, 'C', '0', '0', 'ai:payConfig:list', 'edit', 'admin', '2026-05-12 18:46:27', '', NULL, '支付配置管理菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2009, '卡密管理', 2020, 2, 'cardCode', 'ai/cardCode/index', '', '', 1, 0, 'C', '0', '0', 'ai:cardCode:list', 'tickets', 'admin', '2026-05-12 18:46:27', '', NULL, '卡密管理菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2010, '订单管理', 0, 7, 'orderManage', '', '', '', 1, 0, 'M', '0', '0', '', 'shopping', 'admin', '2026-05-12 18:46:27', '', NULL, '订单管理目录');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2020, '卡包管理', 0, 8, 'cardBundle', '', '', '', 1, 0, 'M', '0', '0', '', 'postcard', 'admin', '2026-05-12 18:46:27', '', NULL, '卡包管理目录');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2031, '提供商管理', 2000, 1, 'provider', 'ai/provider/index', '', '', 1, 0, 'C', '0', '0', 'ai:provider:list', 'connection', 'admin', '2026-05-12 18:46:27', '', NULL, 'AI提供商管理菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2032, '渠道管理', 2000, 2, 'providerChannel', 'ai/providerChannel/index', '', '', 1, 0, 'C', '0', '0', 'ai:providerChannel:list', 'guide', 'admin', '2026-05-12 18:46:27', '', NULL, 'AI渠道管理菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2033, '渠道模型映射', 2001, 100, 'channelModelRelation', 'ai/channelModelRelation/index', '', '', 1, 0, 'C', '1', '0', 'ai:channelModelRelation:list', 'share', 'admin', '2026-05-12 18:46:27', '', NULL, '模型支持渠道内嵌管理页');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2100, '模型查询', 2001, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'ai:model:query', '#', 'admin', '2026-05-12 18:46:27', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2101, '模型新增', 2001, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'ai:model:add', '#', 'admin', '2026-05-12 18:46:27', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2102, '模型修改', 2001, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'ai:model:edit', '#', 'admin', '2026-05-12 18:46:27', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2103, '模型删除', 2001, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'ai:model:remove', '#', 'admin', '2026-05-12 18:46:27', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2200, '版本查询', 2002, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'ai:modelVersion:query', '#', 'admin', '2026-05-12 18:46:27', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2201, '版本新增', 2002, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'ai:modelVersion:add', '#', 'admin', '2026-05-12 18:46:27', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2202, '版本修改', 2002, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'ai:modelVersion:edit', '#', 'admin', '2026-05-12 18:46:27', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2203, '版本删除', 2002, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'ai:modelVersion:remove', '#', 'admin', '2026-05-12 18:46:27', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2300, '任务查询', 2003, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'ai:task:query', '#', 'admin', '2026-05-12 18:46:27', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2301, '任务处理', 2003, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'ai:task:handle', '#', 'admin', '2026-05-12 18:46:27', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2350, '提供商查询', 2031, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'ai:provider:query', '#', 'admin', '2026-05-12 18:46:27', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2351, '提供商新增', 2031, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'ai:provider:add', '#', 'admin', '2026-05-12 18:46:27', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2352, '提供商修改', 2031, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'ai:provider:edit', '#', 'admin', '2026-05-12 18:46:27', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2353, '提供商删除', 2031, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'ai:provider:remove', '#', 'admin', '2026-05-12 18:46:27', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2360, '渠道查询', 2032, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'ai:providerChannel:query', '#', 'admin', '2026-05-12 18:46:27', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2361, '渠道新增', 2032, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'ai:providerChannel:add', '#', 'admin', '2026-05-12 18:46:27', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2362, '渠道修改', 2032, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'ai:providerChannel:edit', '#', 'admin', '2026-05-12 18:46:27', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2363, '渠道删除', 2032, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'ai:providerChannel:remove', '#', 'admin', '2026-05-12 18:46:27', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2364, '映射查询', 2033, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'ai:channelModelRelation:query', '#', 'admin', '2026-05-12 18:46:27', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2365, '映射新增', 2033, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'ai:channelModelRelation:add', '#', 'admin', '2026-05-12 18:46:27', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2366, '映射修改', 2033, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'ai:channelModelRelation:edit', '#', 'admin', '2026-05-12 18:46:27', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2367, '映射删除', 2033, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'ai:channelModelRelation:remove', '#', 'admin', '2026-05-12 18:46:27', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2400, '会员钱包记录查询', 2004, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'ai:wallet:list', '#', 'admin', '2026-05-12 18:46:27', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2401, '赠送算力', 2004, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'ai:wallet:grant', '#', 'admin', '2026-05-12 18:46:27', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2500, '用户管理', 2005, 1, 'user', 'ai/user/index', '', '', 1, 0, 'C', '0', '0', 'ai:user:list', 'user', 'admin', '2026-05-12 18:46:27', '', NULL, '会员用户管理菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2501, '邀请管理', 2005, 2, 'userInvite', 'ai/userInvite/index', '', '', 1, 0, 'C', '0', '0', 'ai:userInvite:list', 'share', 'admin', '2026-05-12 18:46:27', '', NULL, '会员邀请关系管理菜单');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2502, '邀请查询', 2501, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'ai:userInvite:list', '#', 'admin', '2026-05-12 18:46:27', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2600, '卡包查询', 2006, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'ai:rechargePackage:query', '#', 'admin', '2026-05-12 18:46:27', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2601, '卡包新增', 2006, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'ai:rechargePackage:add', '#', 'admin', '2026-05-12 18:46:27', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2602, '卡包修改', 2006, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'ai:rechargePackage:edit', '#', 'admin', '2026-05-12 18:46:27', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2700, '订单查询', 2007, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'ai:order:query', '#', 'admin', '2026-05-12 18:46:27', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2701, '订单处理', 2007, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'ai:order:handle', '#', 'admin', '2026-05-12 18:46:27', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2800, '支付配置查询', 2008, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'ai:payConfig:query', '#', 'admin', '2026-05-12 18:46:27', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2801, '支付配置新增', 2008, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'ai:payConfig:add', '#', 'admin', '2026-05-12 18:46:27', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2802, '支付配置修改', 2008, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'ai:payConfig:edit', '#', 'admin', '2026-05-12 18:46:27', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2900, '卡密查询', 2009, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'ai:cardCode:query', '#', 'admin', '2026-05-12 18:46:27', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2901, '卡密新增', 2009, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'ai:cardCode:add', '#', 'admin', '2026-05-12 18:46:27', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2902, '卡密删除', 2009, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'ai:cardCode:remove', '#', 'admin', '2026-05-12 18:46:27', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2903, '卡密修改', 2009, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'ai:cardCode:edit', '#', 'admin', '2026-05-12 18:46:27', '', NULL, '');
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `parent_id`, `order_num`, `path`, `component`, `query`, `route_name`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2904, '卡密导出', 2009, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'ai:cardCode:export', '#', 'admin', '2026-05-12 18:46:27', '', NULL, '');
COMMIT;

-- ----------------------------
-- Table structure for sys_notice
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice`;
CREATE TABLE `sys_notice` (
  `notice_id` int NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `notice_title` varchar(50) COLLATE utf8mb4_general_ci NOT NULL COMMENT '公告标题',
  `notice_type` char(1) COLLATE utf8mb4_general_ci NOT NULL COMMENT '公告类型（1通知 2公告）',
  `notice_content` longblob COMMENT '公告内容',
  `status` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`notice_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='通知公告表';

-- ----------------------------
-- Records of sys_notice
-- ----------------------------
BEGIN;
INSERT INTO `sys_notice` (`notice_id`, `notice_title`, `notice_type`, `notice_content`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1, '温馨提醒：2018-07-01 若依新版本发布啦', '2', 0xE696B0E78988E69CACE58685E5AEB9, '0', 'admin', '2026-05-12 18:45:51', '', NULL, '管理员');
INSERT INTO `sys_notice` (`notice_id`, `notice_title`, `notice_type`, `notice_content`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2, '维护通知：2018-07-01 若依系统凌晨维护', '1', 0xE7BBB4E68AA4E58685E5AEB9, '0', 'admin', '2026-05-12 18:45:51', '', NULL, '管理员');
INSERT INTO `sys_notice` (`notice_id`, `notice_title`, `notice_type`, `notice_content`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (3, '若依开源框架介绍', '1', 0x3C703E3C7370616E207374796C653D22636F6C6F723A20726762283233302C20302C2030293B223EE9A1B9E79BAEE4BB8BE7BB8D3C2F7370616E3E3C2F703E3C703E3C666F6E7420636F6C6F723D2223333333333333223E52756F5969E5BC80E6BA90E9A1B9E79BAEE698AFE4B8BAE4BC81E4B89AE794A8E688B7E5AE9AE588B6E79A84E5908EE58FB0E8849AE6898BE69EB6E6A186E69EB6EFBC8CE4B8BAE4BC81E4B89AE68993E980A0E79A84E4B880E7AB99E5BC8FE8A7A3E586B3E696B9E6A188EFBC8CE9998DE4BD8EE4BC81E4B89AE5BC80E58F91E68890E69CACEFBC8CE68F90E58D87E5BC80E58F91E69588E78E87E38082E4B8BBE8A681E58C85E68BACE794A8E688B7E7AEA1E79086E38081E8A792E889B2E7AEA1E79086E38081E983A8E997A8E7AEA1E79086E38081E88F9CE58D95E7AEA1E79086E38081E58F82E695B0E7AEA1E79086E38081E5AD97E585B8E7AEA1E79086E380813C2F666F6E743E3C7370616E207374796C653D22636F6C6F723A207267622835312C2035312C203531293B223EE5B297E4BD8DE7AEA1E790863C2F7370616E3E3C7370616E207374796C653D22636F6C6F723A207267622835312C2035312C203531293B223EE38081E5AE9AE697B6E4BBBBE58AA13C2F7370616E3E3C7370616E207374796C653D22636F6C6F723A207267622835312C2035312C203531293B223EE380813C2F7370616E3E3C7370616E207374796C653D22636F6C6F723A207267622835312C2035312C203531293B223EE69C8DE58AA1E79B91E68EA7E38081E799BBE5BD95E697A5E5BF97E38081E6938DE4BD9CE697A5E5BF97E38081E4BBA3E7A081E7949FE68890E7AD89E58A9FE883BDE38082E585B6E4B8ADEFBC8CE8BF98E694AFE68C81E5A49AE695B0E68DAEE6BA90E38081E695B0E68DAEE69D83E99990E38081E59BBDE99985E58C96E380815265646973E7BC93E5AD98E38081446F636B6572E983A8E7BDB2E38081E6BB91E58AA8E9AA8CE8AF81E7A081E38081E7ACACE4B889E696B9E8AEA4E8AF81E799BBE5BD95E38081E58886E5B883E5BC8FE4BA8BE58AA1E380813C2F7370616E3E3C666F6E7420636F6C6F723D2223333333333333223EE58886E5B883E5BC8FE69687E4BBB6E5AD98E582A83C2F666F6E743E3C7370616E207374796C653D22636F6C6F723A207267622835312C2035312C203531293B223EE38081E58886E5BA93E58886E8A1A8E5A484E79086E7AD89E68A80E69CAFE789B9E782B9E380823C2F7370616E3E3C2F703E3C703E3C696D67207372633D2268747470733A2F2F666F727564612E67697465652E636F6D2F696D616765732F313737333933313834383334323433393033322F61346432323331335F313831353039352E706E6722207374796C653D2277696474683A20363470783B223E3C62723E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A20726762283233302C20302C2030293B223EE5AE98E7BD91E58F8AE6BC94E7A4BA3C2F7370616E3E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A207267622835312C2035312C203531293B223EE88BA5E4BE9DE5AE98E7BD91E59CB0E59D80EFBC9A266E6273703B3C2F7370616E3E3C6120687265663D22687474703A2F2F72756F79692E76697022207461726765743D225F626C616E6B223E687474703A2F2F72756F79692E7669703C2F613E3C6120687265663D22687474703A2F2F72756F79692E76697022207461726765743D225F626C616E6B223E3C2F613E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A207267622835312C2035312C203531293B223EE88BA5E4BE9DE69687E6A1A3E59CB0E59D80EFBC9A266E6273703B3C2F7370616E3E3C6120687265663D22687474703A2F2F646F632E72756F79692E76697022207461726765743D225F626C616E6B223E687474703A2F2F646F632E72756F79692E7669703C2F613E3C62723E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A207267622835312C2035312C203531293B223EE6BC94E7A4BAE59CB0E59D80E38090E4B88DE58886E7A6BBE78988E38091EFBC9A266E6273703B3C2F7370616E3E3C6120687265663D22687474703A2F2F64656D6F2E72756F79692E76697022207461726765743D225F626C616E6B223E687474703A2F2F64656D6F2E72756F79692E7669703C2F613E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A207267622835312C2035312C203531293B223EE6BC94E7A4BAE59CB0E59D80E38090E58886E7A6BBE78988E69CACE38091EFBC9A266E6273703B3C2F7370616E3E3C6120687265663D22687474703A2F2F7675652E72756F79692E76697022207461726765743D225F626C616E6B223E687474703A2F2F7675652E72756F79692E7669703C2F613E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A207267622835312C2035312C203531293B223EE6BC94E7A4BAE59CB0E59D80E38090E5BEAEE69C8DE58AA1E78988E38091EFBC9A266E6273703B3C2F7370616E3E3C6120687265663D22687474703A2F2F636C6F75642E72756F79692E76697022207461726765743D225F626C616E6B223E687474703A2F2F636C6F75642E72756F79692E7669703C2F613E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A207267622835312C2035312C203531293B223EE6BC94E7A4BAE59CB0E59D80E38090E7A7BBE58AA8E7ABAFE78988E38091EFBC9A266E6273703B3C2F7370616E3E3C6120687265663D22687474703A2F2F68352E72756F79692E76697022207461726765743D225F626C616E6B223E687474703A2F2F68352E72756F79692E7669703C2F613E3C2F703E3C703E3C6272207374796C653D22636F6C6F723A207267622834382C2034392C203531293B20666F6E742D66616D696C793A202671756F743B48656C766574696361204E6575652671756F743B2C2048656C7665746963612C20417269616C2C2073616E732D73657269663B20666F6E742D73697A653A20313270783B223E3C2F703E, '0', 'admin', '2026-05-12 18:45:51', '', NULL, '管理员');
COMMIT;

-- ----------------------------
-- Table structure for sys_notice_read
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice_read`;
CREATE TABLE `sys_notice_read` (
  `read_id` bigint NOT NULL AUTO_INCREMENT COMMENT '已读主键',
  `notice_id` int NOT NULL COMMENT '公告id',
  `user_id` bigint NOT NULL COMMENT '用户id',
  `read_time` datetime NOT NULL COMMENT '阅读时间',
  PRIMARY KEY (`read_id`),
  UNIQUE KEY `uk_user_notice` (`user_id`,`notice_id`) COMMENT '同一用户同一公告只记录一次'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='公告已读记录表';

-- ----------------------------
-- Records of sys_notice_read
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_oper_log`;
CREATE TABLE `sys_oper_log` (
  `oper_id` bigint NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `title` varchar(50) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '模块标题',
  `business_type` int DEFAULT '0' COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(200) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '请求方式',
  `operator_type` int DEFAULT '0' COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(255) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(128) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '主机地址',
  `oper_location` varchar(255) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '操作地点',
  `oper_param` varchar(2000) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '请求参数',
  `json_result` varchar(2000) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '返回参数',
  `status` int DEFAULT '0' COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(2000) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime DEFAULT NULL COMMENT '操作时间',
  `cost_time` bigint DEFAULT '0' COMMENT '消耗时间',
  PRIMARY KEY (`oper_id`),
  KEY `idx_sys_oper_log_bt` (`business_type`),
  KEY `idx_sys_oper_log_s` (`status`),
  KEY `idx_sys_oper_log_ot` (`oper_time`)
) ENGINE=InnoDB AUTO_INCREMENT=105 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='操作日志记录';

-- ----------------------------
-- Records of sys_oper_log
-- ----------------------------
BEGIN;
INSERT INTO `sys_oper_log` (`oper_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (100, '参数管理', 2, 'com.ruoyi.web.controller.system.SysConfigController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/config', '127.0.0.1', '内网IP', '{\"configId\":4,\"configKey\":\"sys.account.captchaEnabled\",\"configName\":\"账号自助-验证码开关\",\"configType\":\"Y\",\"configValue\":\"false\",\"createBy\":\"admin\",\"createTime\":\"2026-05-12 18:45:51\",\"params\":{},\"remark\":\"是否开启验证码功能（true开启，false关闭）\",\"updateBy\":\"admin\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-12 18:49:29', 15);
INSERT INTO `sys_oper_log` (`oper_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (101, '卡密管理', 2, 'com.ruoyi.web.controller.ai.AiCardCodeController.edit()', 'PUT', 1, 'admin', '研发部门', '/ai/cardCode', '127.0.0.1', '内网IP', '{\"bonusPowerNum\":20,\"cardCode\":\"CKSTARTER000001\",\"cardCodeId\":1,\"packageId\":1,\"packageName\":\"新手体验包\",\"powerNum\":100,\"remark\":\"示例卡密\",\"status\":\"2\",\"updateTime\":\"2026-05-12 21:52:40\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-12 21:52:40', 17);
INSERT INTO `sys_oper_log` (`oper_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (102, '卡密管理', 2, 'com.ruoyi.web.controller.ai.AiCardCodeController.edit()', 'PUT', 1, 'admin', '研发部门', '/ai/cardCode', '127.0.0.1', '内网IP', '{\"bonusPowerNum\":20,\"cardCode\":\"CKSTARTER000001\",\"cardCodeId\":1,\"packageId\":1,\"packageName\":\"新手体验包\",\"powerNum\":100,\"remark\":\"示例卡密\",\"status\":\"0\",\"updateTime\":\"2026-05-12 21:52:42\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-12 21:52:42', 19);
INSERT INTO `sys_oper_log` (`oper_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (103, 'AI渠道', 2, 'com.ruoyi.web.controller.ai.AiProviderChannelController.edit()', 'PUT', 1, 'admin', '研发部门', '/ai/providerChannel', '127.0.0.1', '内网IP', '{\"apiKey\":\"5847da8b13364922b6bb984ff62069ad.DHEK4oP6GZdiY9Cf\",\"baseUrl\":\"https://open.bigmodel.cn\",\"channelCode\":\"ZHIPU_OFFICIAL\",\"channelId\":10,\"channelName\":\"智谱官方\",\"createBy\":\"admin\",\"createTime\":\"2026-05-12 18:46:09\",\"healthStatus\":\"UNKNOWN\",\"isFallback\":\"0\",\"maxConcurrency\":0,\"params\":{},\"priority\":0,\"providerId\":6,\"providerName\":\"智谱AI\",\"proxyEnabled\":\"0\",\"remark\":\"请填写 API Key 后启用\",\"rpmLimit\":0,\"status\":\"0\",\"timeoutMs\":60000,\"tpmLimit\":0,\"updateBy\":\"admin\",\"weight\":100} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-12 22:34:19', 12);
INSERT INTO `sys_oper_log` (`oper_id`, `title`, `business_type`, `method`, `request_method`, `operator_type`, `oper_name`, `dept_name`, `oper_url`, `oper_ip`, `oper_location`, `oper_param`, `json_result`, `status`, `error_msg`, `oper_time`, `cost_time`) VALUES (104, 'AI模型配置', 2, 'com.ruoyi.web.controller.ai.AiModelController.edit()', 'PUT', 1, 'admin', '研发部门', '/ai/model', '127.0.0.1', '内网IP', '{\"coverUrl\":\"/profile/upload/2026/05/12/dce00dbdffbdabddb62e6783dfd3b0c8_20260512231542A002.png\",\"createBy\":\"admin\",\"createTime\":\"2026-05-12 18:46:09\",\"iconUrl\":\"/profile/upload/2026/05/12/dce00dbdffbdabddb62e6783dfd3b0c8_20260512231533A001.png\",\"intro\":\"字节跳动图片模型\",\"modelCode\":\"jimeng\",\"modelId\":1,\"modelName\":\"即梦AI\",\"modelType\":\"IMAGE\",\"params\":{},\"provider\":\"BYTEDANCE\",\"remark\":\"\",\"sort\":1,\"status\":\"0\",\"updateBy\":\"admin\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-12 23:15:47', 14);
COMMIT;

-- ----------------------------
-- Table structure for sys_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_post`;
CREATE TABLE `sys_post` (
  `post_id` bigint NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
  `post_code` varchar(64) COLLATE utf8mb4_general_ci NOT NULL COMMENT '岗位编码',
  `post_name` varchar(50) COLLATE utf8mb4_general_ci NOT NULL COMMENT '岗位名称',
  `post_sort` int NOT NULL COMMENT '显示顺序',
  `status` char(1) COLLATE utf8mb4_general_ci NOT NULL COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`post_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='岗位信息表';

-- ----------------------------
-- Records of sys_post
-- ----------------------------
BEGIN;
INSERT INTO `sys_post` (`post_id`, `post_code`, `post_name`, `post_sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1, 'ceo', '董事长', 1, '0', 'admin', '2026-05-12 18:45:51', '', NULL, '');
INSERT INTO `sys_post` (`post_id`, `post_code`, `post_name`, `post_sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2, 'se', '项目经理', 2, '0', 'admin', '2026-05-12 18:45:51', '', NULL, '');
INSERT INTO `sys_post` (`post_id`, `post_code`, `post_name`, `post_sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (3, 'hr', '人力资源', 3, '0', 'admin', '2026-05-12 18:45:51', '', NULL, '');
INSERT INTO `sys_post` (`post_id`, `post_code`, `post_name`, `post_sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (4, 'user', '普通员工', 4, '0', 'admin', '2026-05-12 18:45:51', '', NULL, '');
COMMIT;

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `role_id` bigint NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(30) COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色权限字符串',
  `role_sort` int NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) COLLATE utf8mb4_general_ci DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `menu_check_strictly` tinyint(1) DEFAULT '1' COMMENT '菜单树选择项是否关联显示',
  `dept_check_strictly` tinyint(1) DEFAULT '1' COMMENT '部门树选择项是否关联显示',
  `status` char(1) COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='角色信息表';

-- ----------------------------
-- Records of sys_role
-- ----------------------------
BEGIN;
INSERT INTO `sys_role` (`role_id`, `role_name`, `role_key`, `role_sort`, `data_scope`, `menu_check_strictly`, `dept_check_strictly`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1, '超级管理员', 'admin', 1, '1', 1, 1, '0', '0', 'admin', '2026-05-12 18:45:51', '', NULL, '超级管理员');
INSERT INTO `sys_role` (`role_id`, `role_name`, `role_key`, `role_sort`, `data_scope`, `menu_check_strictly`, `dept_check_strictly`, `status`, `del_flag`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2, '普通角色', 'common', 2, '2', 1, 1, '0', '0', 'admin', '2026-05-12 18:45:51', '', NULL, '普通角色');
COMMIT;

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept` (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `dept_id` bigint NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`,`dept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='角色和部门关联表';

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------
BEGIN;
INSERT INTO `sys_role_dept` (`role_id`, `dept_id`) VALUES (2, 100);
INSERT INTO `sys_role_dept` (`role_id`, `dept_id`) VALUES (2, 101);
INSERT INTO `sys_role_dept` (`role_id`, `dept_id`) VALUES (2, 105);
COMMIT;

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu` (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `menu_id` bigint NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`,`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='角色和菜单关联表';

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
BEGIN;
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 3);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 4);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 100);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 101);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 102);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 103);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 104);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 105);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 106);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 107);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 108);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 109);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 110);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 111);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 112);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 113);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 114);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 115);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 116);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 117);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 500);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 501);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1000);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1001);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1002);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1003);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1004);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1005);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1006);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1007);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1008);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1009);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1010);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1011);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1012);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1013);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1014);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1015);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1016);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1017);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1018);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1019);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1020);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1021);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1022);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1023);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1024);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1025);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1026);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1027);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1028);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1029);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1030);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1031);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1032);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1033);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1034);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1035);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1036);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1037);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1038);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1039);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1040);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1041);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1042);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1043);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1044);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1045);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1046);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1047);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1048);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1049);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1050);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1051);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1052);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1053);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1054);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1055);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1056);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1057);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1058);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1059);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1060);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2000);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2001);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2002);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2003);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2004);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2005);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2006);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2007);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2008);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2009);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2010);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2020);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2031);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2032);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2033);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2100);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2101);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2102);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2103);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2200);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2201);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2202);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2203);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2300);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2301);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2350);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2351);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2352);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2353);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2360);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2361);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2362);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2363);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2364);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2365);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2366);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2367);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2400);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2401);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2500);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2501);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2502);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2600);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2601);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2602);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2700);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2701);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2800);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2801);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2802);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2900);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2901);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2902);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2903);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 2904);
COMMIT;

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `user_id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `dept_id` bigint DEFAULT NULL COMMENT '部门ID',
  `user_name` varchar(30) COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户账号',
  `nick_name` varchar(30) COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户昵称',
  `user_type` varchar(2) COLLATE utf8mb4_general_ci DEFAULT '00' COMMENT '用户类型（00系统用户）',
  `email` varchar(50) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '手机号码',
  `sex` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(100) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '头像地址',
  `password` varchar(100) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '密码',
  `status` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '账号状态（0正常 1停用）',
  `del_flag` char(1) COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `login_ip` varchar(128) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime DEFAULT NULL COMMENT '最后登录时间',
  `pwd_update_date` datetime DEFAULT NULL COMMENT '密码最后更新时间',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='用户信息表';

-- ----------------------------
-- Records of sys_user
-- ----------------------------
BEGIN;
INSERT INTO `sys_user` (`user_id`, `dept_id`, `user_name`, `nick_name`, `user_type`, `email`, `phonenumber`, `sex`, `avatar`, `password`, `status`, `del_flag`, `login_ip`, `login_date`, `pwd_update_date`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (1, 103, 'admin', '若依', '00', 'ry@163.com', '15888888888', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2026-05-12 23:09:27', '2026-05-12 18:45:51', 'admin', '2026-05-12 18:45:51', '', NULL, '管理员');
INSERT INTO `sys_user` (`user_id`, `dept_id`, `user_name`, `nick_name`, `user_type`, `email`, `phonenumber`, `sex`, `avatar`, `password`, `status`, `del_flag`, `login_ip`, `login_date`, `pwd_update_date`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES (2, 105, 'ry', '若依', '00', 'ry@qq.com', '15666666666', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2026-05-12 18:45:51', '2026-05-12 18:45:51', 'admin', '2026-05-12 18:45:51', '', NULL, '测试员');
COMMIT;

-- ----------------------------
-- Table structure for sys_user_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_post`;
CREATE TABLE `sys_user_post` (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `post_id` bigint NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`,`post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='用户与岗位关联表';

-- ----------------------------
-- Records of sys_user_post
-- ----------------------------
BEGIN;
INSERT INTO `sys_user_post` (`user_id`, `post_id`) VALUES (1, 1);
INSERT INTO `sys_user_post` (`user_id`, `post_id`) VALUES (2, 2);
COMMIT;

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role` (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='用户和角色关联表';

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
BEGIN;
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (1, 1);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (2, 2);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
