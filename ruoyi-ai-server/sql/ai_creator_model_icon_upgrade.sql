set @sql = (
    select if(count(*) = 0, 'alter table ai_c_model add column icon_url varchar(255) default '''' comment ''模型图标'' after capabilities', 'select 1')
    from information_schema.columns
    where table_schema = database() and table_name = 'ai_c_model' and column_name = 'icon_url'
);
prepare stmt from @sql; execute stmt; deallocate prepare stmt;

update ai_c_model
set icon_url = '/static/images/application/index/tpcz/jmai.png'
where (icon_url is null or icon_url = '') and lower(model_code) like '%jimeng%';

update ai_c_model
set icon_url = '/static/images/application/index/tpcz/tywx.png'
where (icon_url is null or icon_url = '') and (lower(model_code) like '%tongyi-wanxiang%' or lower(model_code) like '%wanxiang%' or lower(model_code) like '%tywx%');

update ai_c_model
set icon_url = '/static/images/application/index/tpcz/klai.png'
where (icon_url is null or icon_url = '') and lower(model_code) like '%keling%';

update ai_c_model
set icon_url = '/static/images/application/index/tpcz/seedream.png'
where (icon_url is null or icon_url = '') and lower(model_code) like '%seedream%';

update ai_c_model
set icon_url = '/static/images/application/index/tpcz/banana.png'
where (icon_url is null or icon_url = '') and lower(model_code) like '%banana%';

update ai_c_model
set icon_url = '/static/images/application/index/tpcz/gpt-image-2.png'
where (icon_url is null or icon_url = '') and (lower(model_code) like '%gpt-image-2%' or lower(model_code) like '%gpt-image%');

update ai_c_model
set icon_url = '/static/images/application/index/tpcz/midjourney.png'
where (icon_url is null or icon_url = '') and lower(model_code) like '%midjourney%';

update ai_c_model
set icon_url = '/static/images/application/index/tpcz/luma.png'
where (icon_url is null or icon_url = '') and lower(model_code) like '%luma%';

update ai_c_model
set icon_url = '/static/images/application/index/tpcz/sora2.png'
where (icon_url is null or icon_url = '') and (lower(model_code) like '%sora2%' or lower(model_code) like '%sora%');

update ai_c_model
set icon_url = '/static/images/application/index/tpcz/zp.png'
where (icon_url is null or icon_url = '') and (lower(model_code) like '%glm-image%' or lower(model_code) like '%zhipu%');
