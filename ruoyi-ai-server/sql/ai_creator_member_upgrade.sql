-- 会员表结构补充
-- 适用于已经执行过 ai_creator_init.sql 的环境
-- 当前按 MySQL 8.0 环境编写，使用 information_schema 做幂等检查

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
) engine=innodb comment='C端用户邀请关系表';

drop procedure if exists proc_ai_creator_member_upgrade;
delimiter $$
create procedure proc_ai_creator_member_upgrade()
begin
    if not exists (
        select 1 from information_schema.columns
        where table_schema = database() and table_name = 'ai_c_user' and column_name = 'email'
    ) then
        alter table ai_c_user add column email varchar(64) default '' comment '邮箱' after avatar;
    end if;

    if not exists (
        select 1 from information_schema.columns
        where table_schema = database() and table_name = 'ai_c_user' and column_name = 'last_login_ip'
    ) then
        alter table ai_c_user add column last_login_ip varchar(128) default '' comment '最近登录IP' after activate_time;
    end if;

    if not exists (
        select 1 from information_schema.columns
        where table_schema = database() and table_name = 'ai_c_user' and column_name = 'last_login_device'
    ) then
        alter table ai_c_user add column last_login_device varchar(255) default '' comment '最近登录设备' after last_login_ip;
    end if;

    if not exists (
        select 1 from information_schema.columns
        where table_schema = database() and table_name = 'ai_c_user' and column_name = 'last_login_time'
    ) then
        alter table ai_c_user add column last_login_time datetime default null comment '最近登录时间' after last_login_device;
    end if;

    if not exists (
        select 1 from information_schema.statistics
        where table_schema = database() and table_name = 'ai_c_user' and index_name = 'uk_ai_c_user_email'
    ) then
        alter table ai_c_user add unique key uk_ai_c_user_email (email);
    end if;

    if not exists (
        select 1 from information_schema.statistics
        where table_schema = database() and table_name = 'ai_c_user' and index_name = 'uk_ai_c_user_mobile'
    ) then
        alter table ai_c_user add unique key uk_ai_c_user_mobile (mobile);
    end if;

    if not exists (
        select 1 from information_schema.columns
        where table_schema = database() and table_name = 'ai_c_user_auth' and column_name = 'auth_nick_name'
    ) then
        alter table ai_c_user_auth add column auth_nick_name varchar(64) default '' comment '三方昵称' after session_key;
    end if;

    if not exists (
        select 1 from information_schema.columns
        where table_schema = database() and table_name = 'ai_c_user_auth' and column_name = 'auth_avatar'
    ) then
        alter table ai_c_user_auth add column auth_avatar varchar(255) default '' comment '三方头像' after auth_nick_name;
    end if;

    if not exists (
        select 1 from information_schema.columns
        where table_schema = database() and table_name = 'ai_c_user_auth' and column_name = 'auth_mobile'
    ) then
        alter table ai_c_user_auth add column auth_mobile varchar(20) default '' comment '三方手机号' after auth_avatar;
    end if;

    if not exists (
        select 1 from information_schema.columns
        where table_schema = database() and table_name = 'ai_c_user_auth' and column_name = 'remark'
    ) then
        alter table ai_c_user_auth add column remark varchar(255) default '' comment '备注' after auth_mobile;
    end if;

    if not exists (
        select 1 from information_schema.columns
        where table_schema = database() and table_name = 'ai_c_user_auth' and column_name = 'update_time'
    ) then
        alter table ai_c_user_auth add column update_time datetime default current_timestamp comment '更新时间' after create_time;
    end if;
end $$
delimiter ;

call proc_ai_creator_member_upgrade();
drop procedure if exists proc_ai_creator_member_upgrade;
