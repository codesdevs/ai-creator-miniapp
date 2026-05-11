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
select 2003, '任务管理', 2000, '3', 'task', 'ai/task/index', '', '', 1, 0, 'C', '0', '0', 'ai:task:list', 'job', 'admin', sysdate(), '', null, 'AI任务管理菜单'
where not exists (select 1 from sys_menu where menu_id = 2003);

insert into sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
select 2004, '算力流水', 2000, '4', 'wallet', 'ai/wallet/index', '', '', 1, 0, 'C', '0', '0', 'ai:wallet:list', 'money', 'admin', sysdate(), '', null, 'AI算力流水菜单'
where not exists (select 1 from sys_menu where menu_id = 2004);

insert into sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
select 2006, '充值套餐', 2000, '5', 'rechargePackage', 'ai/rechargePackage/index', '', '', 1, 0, 'C', '0', '0', 'ai:rechargePackage:list', 'shopping', 'admin', sysdate(), '', null, '充值套餐管理菜单'
where not exists (select 1 from sys_menu where menu_id = 2006);

insert into sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
select 2010, '订单管理', 0, '6', 'orderManage', '', '', '', 1, 0, 'M', '0', '0', '', 'shopping', 'admin', sysdate(), '', null, '订单管理目录'
where not exists (select 1 from sys_menu where menu_id = 2010);

insert into sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
select 2007, '充值订单', 2010, '1', 'order', 'ai/order/index', '', '', 1, 0, 'C', '0', '0', 'ai:order:list', 'order', 'admin', sysdate(), '', null, '充值订单管理菜单'
where not exists (select 1 from sys_menu where menu_id = 2007);

insert into sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
select 2008, '支付配置', 2010, '2', 'payConfig', 'ai/payConfig/index', '', '', 1, 0, 'C', '0', '0', 'ai:payConfig:list', 'edit', 'admin', sysdate(), '', null, '支付配置管理菜单'
where not exists (select 1 from sys_menu where menu_id = 2008);

insert into sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
select 2005, '会员列表', 0, '6', 'member', '', '', '', 1, 0, 'M', '0', '0', '', 'peoples', 'admin', sysdate(), '', null, '会员目录菜单'
where not exists (select 1 from sys_menu where menu_id = 2005);

update sys_menu
set menu_name = '会员列表',
    parent_id = 0,
    order_num = '6',
    path = 'member',
    component = '',
    menu_type = 'M',
    perms = '',
    icon = 'peoples',
    remark = '会员目录菜单'
where menu_id = 2005;

update sys_menu
set menu_name = '订单管理',
    parent_id = 0,
    order_num = '6',
    path = 'orderManage',
    component = '',
    menu_type = 'M',
    perms = '',
    icon = 'shopping',
    remark = '订单管理目录'
where menu_id = 2010;

update sys_menu
set menu_name = '充值订单',
    parent_id = 2010,
    order_num = '1',
    path = 'order',
    component = 'ai/order/index',
    menu_type = 'C',
    perms = 'ai:order:list',
    icon = 'order',
    remark = '充值订单管理菜单'
where menu_id = 2007;

update sys_menu
set menu_name = '支付配置',
    parent_id = 2010,
    order_num = '2',
    path = 'payConfig',
    component = 'ai/payConfig/index',
    menu_type = 'C',
    perms = 'ai:payConfig:list',
    icon = 'edit',
    remark = '支付配置管理菜单'
where menu_id = 2008;

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

insert into sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
select 2300, '任务查询', 2003, '1', '#', '', '', '', 1, 0, 'F', '0', '0', 'ai:task:query', '#', 'admin', sysdate(), '', null, ''
where not exists (select 1 from sys_menu where menu_id = 2300);

insert into sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
select 2301, '任务处理', 2003, '2', '#', '', '', '', 1, 0, 'F', '0', '0', 'ai:task:handle', '#', 'admin', sysdate(), '', null, ''
where not exists (select 1 from sys_menu where menu_id = 2301);

insert into sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
select 2400, '流水查询', 2004, '1', '#', '', '', '', 1, 0, 'F', '0', '0', 'ai:wallet:list', '#', 'admin', sysdate(), '', null, ''
where not exists (select 1 from sys_menu where menu_id = 2400);

insert into sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
select 2401, '赠送算力', 2004, '2', '#', '', '', '', 1, 0, 'F', '0', '0', 'ai:wallet:grant', '#', 'admin', sysdate(), '', null, ''
where not exists (select 1 from sys_menu where menu_id = 2401);

insert into sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
select 2600, '套餐查询', 2006, '1', '#', '', '', '', 1, 0, 'F', '0', '0', 'ai:rechargePackage:query', '#', 'admin', sysdate(), '', null, ''
where not exists (select 1 from sys_menu where menu_id = 2600);

insert into sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
select 2601, '套餐新增', 2006, '2', '#', '', '', '', 1, 0, 'F', '0', '0', 'ai:rechargePackage:add', '#', 'admin', sysdate(), '', null, ''
where not exists (select 1 from sys_menu where menu_id = 2601);

insert into sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
select 2602, '套餐修改', 2006, '3', '#', '', '', '', 1, 0, 'F', '0', '0', 'ai:rechargePackage:edit', '#', 'admin', sysdate(), '', null, ''
where not exists (select 1 from sys_menu where menu_id = 2602);

insert into sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
select 2700, '订单查询', 2007, '1', '#', '', '', '', 1, 0, 'F', '0', '0', 'ai:order:query', '#', 'admin', sysdate(), '', null, ''
where not exists (select 1 from sys_menu where menu_id = 2700);

insert into sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
select 2701, '订单处理', 2007, '2', '#', '', '', '', 1, 0, 'F', '0', '0', 'ai:order:handle', '#', 'admin', sysdate(), '', null, ''
where not exists (select 1 from sys_menu where menu_id = 2701);

insert into sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
select 2800, '支付配置查询', 2008, '1', '#', '', '', '', 1, 0, 'F', '0', '0', 'ai:payConfig:query', '#', 'admin', sysdate(), '', null, ''
where not exists (select 1 from sys_menu where menu_id = 2800);

insert into sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
select 2801, '支付配置新增', 2008, '2', '#', '', '', '', 1, 0, 'F', '0', '0', 'ai:payConfig:add', '#', 'admin', sysdate(), '', null, ''
where not exists (select 1 from sys_menu where menu_id = 2801);

insert into sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
select 2802, '支付配置修改', 2008, '3', '#', '', '', '', 1, 0, 'F', '0', '0', 'ai:payConfig:edit', '#', 'admin', sysdate(), '', null, ''
where not exists (select 1 from sys_menu where menu_id = 2802);

insert into sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
select 2500, '用户管理', 2005, '1', 'user', 'ai/user/index', '', '', 1, 0, 'C', '0', '0', 'ai:user:list', 'user', 'admin', sysdate(), '', null, '会员用户管理菜单'
where not exists (select 1 from sys_menu where menu_id = 2500);

insert into sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
select 2501, '邀请管理', 2005, '2', 'userInvite', 'ai/userInvite/index', '', '', 1, 0, 'C', '0', '0', 'ai:userInvite:list', 'share', 'admin', sysdate(), '', null, '会员邀请关系管理菜单'
where not exists (select 1 from sys_menu where menu_id = 2501);

update sys_menu
set menu_name = '用户管理',
    parent_id = 2005,
    order_num = '1',
    path = 'user',
    component = 'ai/user/index',
    menu_type = 'C',
    perms = 'ai:user:list',
    icon = 'user',
    remark = '会员用户管理菜单'
where menu_id = 2500;

update sys_menu
set menu_name = '邀请管理',
    parent_id = 2005,
    order_num = '2',
    path = 'userInvite',
    component = 'ai/userInvite/index',
    menu_type = 'C',
    perms = 'ai:userInvite:list',
    icon = 'share',
    remark = '会员邀请关系管理菜单'
where menu_id = 2501;

insert into sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
select 2502, '邀请查询', 2501, '1', '#', '', '', '', 1, 0, 'F', '0', '0', 'ai:userInvite:list', '#', 'admin', sysdate(), '', null, ''
where not exists (select 1 from sys_menu where menu_id = 2502);

-- 给测试角色补菜单，管理员角色默认拥有全部菜单，无需关联
insert into sys_role_menu (role_id, menu_id)
select 2, 2000 where not exists (select 1 from sys_role_menu where role_id = 2 and menu_id = 2000);
insert into sys_role_menu (role_id, menu_id)
select 2, 2001 where not exists (select 1 from sys_role_menu where role_id = 2 and menu_id = 2001);
insert into sys_role_menu (role_id, menu_id)
select 2, 2002 where not exists (select 1 from sys_role_menu where role_id = 2 and menu_id = 2002);
insert into sys_role_menu (role_id, menu_id)
select 2, 2003 where not exists (select 1 from sys_role_menu where role_id = 2 and menu_id = 2003);
insert into sys_role_menu (role_id, menu_id)
select 2, 2004 where not exists (select 1 from sys_role_menu where role_id = 2 and menu_id = 2004);
insert into sys_role_menu (role_id, menu_id)
select 2, 2006 where not exists (select 1 from sys_role_menu where role_id = 2 and menu_id = 2006);
insert into sys_role_menu (role_id, menu_id)
select 2, 2010 where not exists (select 1 from sys_role_menu where role_id = 2 and menu_id = 2010);
insert into sys_role_menu (role_id, menu_id)
select 2, 2007 where not exists (select 1 from sys_role_menu where role_id = 2 and menu_id = 2007);
insert into sys_role_menu (role_id, menu_id)
select 2, 2008 where not exists (select 1 from sys_role_menu where role_id = 2 and menu_id = 2008);
insert into sys_role_menu (role_id, menu_id)
select 2, 2005 where not exists (select 1 from sys_role_menu where role_id = 2 and menu_id = 2005);
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
insert into sys_role_menu (role_id, menu_id)
select 2, 2300 where not exists (select 1 from sys_role_menu where role_id = 2 and menu_id = 2300);
insert into sys_role_menu (role_id, menu_id)
select 2, 2301 where not exists (select 1 from sys_role_menu where role_id = 2 and menu_id = 2301);
insert into sys_role_menu (role_id, menu_id)
select 2, 2400 where not exists (select 1 from sys_role_menu where role_id = 2 and menu_id = 2400);
insert into sys_role_menu (role_id, menu_id)
select 2, 2401 where not exists (select 1 from sys_role_menu where role_id = 2 and menu_id = 2401);
insert into sys_role_menu (role_id, menu_id)
select 2, 2600 where not exists (select 1 from sys_role_menu where role_id = 2 and menu_id = 2600);
insert into sys_role_menu (role_id, menu_id)
select 2, 2601 where not exists (select 1 from sys_role_menu where role_id = 2 and menu_id = 2601);
insert into sys_role_menu (role_id, menu_id)
select 2, 2602 where not exists (select 1 from sys_role_menu where role_id = 2 and menu_id = 2602);
insert into sys_role_menu (role_id, menu_id)
select 2, 2700 where not exists (select 1 from sys_role_menu where role_id = 2 and menu_id = 2700);
insert into sys_role_menu (role_id, menu_id)
select 2, 2701 where not exists (select 1 from sys_role_menu where role_id = 2 and menu_id = 2701);
insert into sys_role_menu (role_id, menu_id)
select 2, 2800 where not exists (select 1 from sys_role_menu where role_id = 2 and menu_id = 2800);
insert into sys_role_menu (role_id, menu_id)
select 2, 2801 where not exists (select 1 from sys_role_menu where role_id = 2 and menu_id = 2801);
insert into sys_role_menu (role_id, menu_id)
select 2, 2802 where not exists (select 1 from sys_role_menu where role_id = 2 and menu_id = 2802);
insert into sys_role_menu (role_id, menu_id)
select 2, 2500 where not exists (select 1 from sys_role_menu where role_id = 2 and menu_id = 2500);
insert into sys_role_menu (role_id, menu_id)
select 2, 2501 where not exists (select 1 from sys_role_menu where role_id = 2 and menu_id = 2501);
insert into sys_role_menu (role_id, menu_id)
select 2, 2502 where not exists (select 1 from sys_role_menu where role_id = 2 and menu_id = 2502);

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
