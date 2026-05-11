-- AI 创作小程序后台菜单、权限和字典初始化
-- 可重复执行，已存在的数据会跳过

-- ----------------------------
-- 1、菜单初始化
-- ----------------------------

insert into sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
select 2000, 'AI创作', 0, '5', 'ai', '', '', '', 1, 0, 'M', '0', '0', '', 'magic-stick', 'admin', sysdate(), '', null, 'AI创作目录'
where not exists (select 1 from sys_menu where menu_id = 2000);

insert into sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
select 2001, '模型管理', 2000, '1', 'model', 'ai/model/index', '', '', 1, 0, 'C', '0', '0', 'ai:model:list', 'guide', 'admin', sysdate(), '', null, 'AI模型管理菜单'
where not exists (select 1 from sys_menu where menu_id = 2001);

insert into sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
select 2002, '模型版本', 2000, '2', 'modelVersion', 'ai/modelVersion/index', '', '', 1, 0, 'C', '0', '0', 'ai:modelVersion:list', 'tree-table', 'admin', sysdate(), '', null, 'AI模型版本管理菜单'
where not exists (select 1 from sys_menu where menu_id = 2002);

insert into sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
select 2100, '模型查询', 2001, '1', '#', '', '', '', 1, 0, 'F', '0', '0', 'ai:model:query', '#', 'admin', sysdate(), '', null, ''
where not exists (select 1 from sys_menu where menu_id = 2100);

insert into sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
select 2101, '模型新增', 2001, '2', '#', '', '', '', 1, 0, 'F', '0', '0', 'ai:model:add', '#', 'admin', sysdate(), '', null, ''
where not exists (select 1 from sys_menu where menu_id = 2101);

insert into sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
select 2102, '模型修改', 2001, '3', '#', '', '', '', 1, 0, 'F', '0', '0', 'ai:model:edit', '#', 'admin', sysdate(), '', null, ''
where not exists (select 1 from sys_menu where menu_id = 2102);

insert into sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
select 2103, '模型删除', 2001, '4', '#', '', '', '', 1, 0, 'F', '0', '0', 'ai:model:remove', '#', 'admin', sysdate(), '', null, ''
where not exists (select 1 from sys_menu where menu_id = 2103);

insert into sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
select 2200, '版本查询', 2002, '1', '#', '', '', '', 1, 0, 'F', '0', '0', 'ai:modelVersion:query', '#', 'admin', sysdate(), '', null, ''
where not exists (select 1 from sys_menu where menu_id = 2200);

insert into sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
select 2201, '版本新增', 2002, '2', '#', '', '', '', 1, 0, 'F', '0', '0', 'ai:modelVersion:add', '#', 'admin', sysdate(), '', null, ''
where not exists (select 1 from sys_menu where menu_id = 2201);

insert into sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
select 2202, '版本修改', 2002, '3', '#', '', '', '', 1, 0, 'F', '0', '0', 'ai:modelVersion:edit', '#', 'admin', sysdate(), '', null, ''
where not exists (select 1 from sys_menu where menu_id = 2202);

insert into sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
select 2203, '版本删除', 2002, '4', '#', '', '', '', 1, 0, 'F', '0', '0', 'ai:modelVersion:remove', '#', 'admin', sysdate(), '', null, ''
where not exists (select 1 from sys_menu where menu_id = 2203);

-- 给测试角色补菜单，管理员角色默认拥有全部菜单，无需关联
insert into sys_role_menu (role_id, menu_id)
select 2, 2000 where not exists (select 1 from sys_role_menu where role_id = 2 and menu_id = 2000);
insert into sys_role_menu (role_id, menu_id)
select 2, 2001 where not exists (select 1 from sys_role_menu where role_id = 2 and menu_id = 2001);
insert into sys_role_menu (role_id, menu_id)
select 2, 2002 where not exists (select 1 from sys_role_menu where role_id = 2 and menu_id = 2002);
insert into sys_role_menu (role_id, menu_id)
select 2, 2100 where not exists (select 1 from sys_role_menu where role_id = 2 and menu_id = 2100);
insert into sys_role_menu (role_id, menu_id)
select 2, 2101 where not exists (select 1 from sys_role_menu where role_id = 2 and menu_id = 2101);
insert into sys_role_menu (role_id, menu_id)
select 2, 2102 where not exists (select 1 from sys_role_menu where role_id = 2 and menu_id = 2102);
insert into sys_role_menu (role_id, menu_id)
select 2, 2103 where not exists (select 1 from sys_role_menu where role_id = 2 and menu_id = 2103);
insert into sys_role_menu (role_id, menu_id)
select 2, 2200 where not exists (select 1 from sys_role_menu where role_id = 2 and menu_id = 2200);
insert into sys_role_menu (role_id, menu_id)
select 2, 2201 where not exists (select 1 from sys_role_menu where role_id = 2 and menu_id = 2201);
insert into sys_role_menu (role_id, menu_id)
select 2, 2202 where not exists (select 1 from sys_role_menu where role_id = 2 and menu_id = 2202);
insert into sys_role_menu (role_id, menu_id)
select 2, 2203 where not exists (select 1 from sys_role_menu where role_id = 2 and menu_id = 2203);

-- ----------------------------
-- 2、字典类型初始化
-- ----------------------------

insert into sys_dict_type (dict_id, dict_name, dict_type, status, create_by, create_time, update_by, update_time, remark)
select 100, 'AI模型类型', 'ai_model_type', '0', 'admin', sysdate(), '', null, 'AI模型类型列表'
where not exists (select 1 from sys_dict_type where dict_type = 'ai_model_type');

insert into sys_dict_type (dict_id, dict_name, dict_type, status, create_by, create_time, update_by, update_time, remark)
select 101, 'AI任务状态', 'ai_task_status', '0', 'admin', sysdate(), '', null, 'AI任务状态列表'
where not exists (select 1 from sys_dict_type where dict_type = 'ai_task_status');

insert into sys_dict_type (dict_id, dict_name, dict_type, status, create_by, create_time, update_by, update_time, remark)
select 102, 'AI订单状态', 'ai_order_status', '0', 'admin', sysdate(), '', null, 'AI订单状态列表'
where not exists (select 1 from sys_dict_type where dict_type = 'ai_order_status');

insert into sys_dict_type (dict_id, dict_name, dict_type, status, create_by, create_time, update_by, update_time, remark)
select 103, 'AI作品状态', 'ai_work_status', '0', 'admin', sysdate(), '', null, 'AI作品状态列表'
where not exists (select 1 from sys_dict_type where dict_type = 'ai_work_status');

-- ----------------------------
-- 3、字典数据初始化
-- ----------------------------

insert into sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark)
select 1000, 1, '文本', 'TEXT', 'ai_model_type', '', 'primary', 'N', '0', 'admin', sysdate(), '', null, '文本模型'
where not exists (select 1 from sys_dict_data where dict_type = 'ai_model_type' and dict_value = 'TEXT');

insert into sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark)
select 1001, 2, '图片', 'IMAGE', 'ai_model_type', '', 'success', 'Y', '0', 'admin', sysdate(), '', null, '图片模型'
where not exists (select 1 from sys_dict_data where dict_type = 'ai_model_type' and dict_value = 'IMAGE');

insert into sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark)
select 1002, 3, '视频', 'VIDEO', 'ai_model_type', '', 'warning', 'N', '0', 'admin', sysdate(), '', null, '视频模型'
where not exists (select 1 from sys_dict_data where dict_type = 'ai_model_type' and dict_value = 'VIDEO');

insert into sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark)
select 1010, 1, '待执行', 'PENDING', 'ai_task_status', '', 'info', 'N', '0', 'admin', sysdate(), '', null, '待执行'
where not exists (select 1 from sys_dict_data where dict_type = 'ai_task_status' and dict_value = 'PENDING');

insert into sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark)
select 1011, 2, '执行中', 'RUNNING', 'ai_task_status', '', 'warning', 'N', '0', 'admin', sysdate(), '', null, '执行中'
where not exists (select 1 from sys_dict_data where dict_type = 'ai_task_status' and dict_value = 'RUNNING');

insert into sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark)
select 1012, 3, '成功', 'SUCCESS', 'ai_task_status', '', 'success', 'Y', '0', 'admin', sysdate(), '', null, '成功'
where not exists (select 1 from sys_dict_data where dict_type = 'ai_task_status' and dict_value = 'SUCCESS');

insert into sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark)
select 1013, 4, '失败', 'FAIL', 'ai_task_status', '', 'danger', 'N', '0', 'admin', sysdate(), '', null, '失败'
where not exists (select 1 from sys_dict_data where dict_type = 'ai_task_status' and dict_value = 'FAIL');

insert into sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark)
select 1020, 1, '待支付', 'WAIT_PAY', 'ai_order_status', '', 'warning', 'N', '0', 'admin', sysdate(), '', null, '待支付'
where not exists (select 1 from sys_dict_data where dict_type = 'ai_order_status' and dict_value = 'WAIT_PAY');

insert into sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark)
select 1021, 2, '已支付', 'PAID', 'ai_order_status', '', 'success', 'Y', '0', 'admin', sysdate(), '', null, '已支付'
where not exists (select 1 from sys_dict_data where dict_type = 'ai_order_status' and dict_value = 'PAID');

insert into sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark)
select 1022, 3, '已关闭', 'CLOSED', 'ai_order_status', '', 'info', 'N', '0', 'admin', sysdate(), '', null, '已关闭'
where not exists (select 1 from sys_dict_data where dict_type = 'ai_order_status' and dict_value = 'CLOSED');

insert into sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark)
select 1023, 4, '已退款', 'REFUNDED', 'ai_order_status', '', 'danger', 'N', '0', 'admin', sysdate(), '', null, '已退款'
where not exists (select 1 from sys_dict_data where dict_type = 'ai_order_status' and dict_value = 'REFUNDED');

insert into sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark)
select 1030, 1, '正常', 'NORMAL', 'ai_work_status', '', 'success', 'Y', '0', 'admin', sysdate(), '', null, '正常'
where not exists (select 1 from sys_dict_data where dict_type = 'ai_work_status' and dict_value = 'NORMAL');

insert into sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark)
select 1031, 2, '已删除', 'DELETED', 'ai_work_status', '', 'info', 'N', '0', 'admin', sysdate(), '', null, '已删除'
where not exists (select 1 from sys_dict_data where dict_type = 'ai_work_status' and dict_value = 'DELETED');

insert into sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark)
select 1032, 3, '审核中', 'REVIEWING', 'ai_work_status', '', 'warning', 'N', '0', 'admin', sysdate(), '', null, '审核中'
where not exists (select 1 from sys_dict_data where dict_type = 'ai_work_status' and dict_value = 'REVIEWING');

insert into sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark)
select 1033, 4, '违规', 'BLOCKED', 'ai_work_status', '', 'danger', 'N', '0', 'admin', sysdate(), '', null, '违规'
where not exists (select 1 from sys_dict_data where dict_type = 'ai_work_status' and dict_value = 'BLOCKED');
