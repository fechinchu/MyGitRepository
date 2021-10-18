USE product;

ALTER TABLE g_category ADD `weight_one` bigint(20) NOT NULL DEFAULT 1000 COMMENT '排序权重' AFTER sort;
ALTER TABLE g_category ADD `weight_two` bigint(20) NOT NULL DEFAULT 1000 COMMENT  '排序权重' AFTER weight_one;
ALTER TABLE g_category ADD `weight_three` bigint(20) NOT NULL DEFAULT 1000 COMMENT '排序权重' AFTER weight_two;
ALTER TABLE g_category ADD `weight_four` bigint(20) NOT NULL DEFAULT 1000 COMMENT '排序权重' AFTER weight_three;

ALTER TABLE g_category_apply ADD `weight_one` bigint(20) NOT NULL DEFAULT 1000 COMMENT '排序权重' AFTER sort;
ALTER TABLE g_category_apply ADD `weight_two` bigint(20) NOT NULL DEFAULT 1000 COMMENT '排序权重' AFTER weight_one;
ALTER TABLE g_category_apply ADD `weight_three` bigint(20) NOT NULL DEFAULT 1000 COMMENT '排序权重' AFTER weight_two;
ALTER TABLE g_category_apply ADD `weight_four` bigint(20) NOT NULL DEFAULT 1000 COMMENT '排序权重' AFTER weight_three;

set @rownum=1000;
update g_category SET weight_one = (
select @rownum := @rownum +1 as nid)
where sort != -1 and level = 1;

update g_category son inner join  g_category parent on son.parent_id = parent.id set  son.weight_one = parent.weight_one where son.level = 2;

set @rownum =1000;
update g_category SET weight_two = (
select @rownum := @rownum +1 as nid)
where sort != -1 and level = 2;

update g_category son inner join  g_category parent on son.parent_id = parent.id set  son.weight_one = parent.weight_one ,son.weight_two = parent.weight_two where son.level = 3;

set @rownum =1000;
update g_category SET weight_three = (
select @rownum := @rownum +1 as nid)
where sort != -1 and level = 3;

update g_category son inner join  g_category parent on son.parent_id = parent.id set  son.weight_one = parent.weight_one ,son.weight_two = parent.weight_two ,son.weight_three = parent.weight_three where son.level = 4;

set @rownum =1000;
update g_category SET weight_four = (
select @rownum := @rownum +1 as nid)
where sort != -1 and level = 4;


set @rownum=2000;
update g_category_apply SET weight_one = (
select @rownum := @rownum +1 as nid)
where sort != -1 and level = 1;

update g_category_apply son inner join  g_category_apply parent on son.parent_id = parent.id set  son.weight_one = parent.weight_one where son.level = 2;
update g_category_apply son inner join  g_category parent on son.parent_id = parent.id set  son.weight_one = parent.weight_one where son.level = 2;

set @rownum =2000;
update g_category_apply SET weight_two = (
select @rownum := @rownum +1 as nid)
where sort != -1 and level = 2;

update g_category_apply son inner join  g_category_apply parent on son.parent_id = parent.id set  son.weight_one = parent.weight_one ,son.weight_two = parent.weight_two where son.level = 3;
update g_category_apply son inner join  g_category parent on son.parent_id = parent.id set  son.weight_one = parent.weight_one ,son.weight_two = parent.weight_two where son.level = 3;

set @rownum =2000;
update g_category_apply SET weight_three = (
select @rownum := @rownum +1 as nid)
where sort != -1 and level = 3;

update g_category_apply son inner join  g_category_apply parent on son.parent_id = parent.id set  son.weight_one = parent.weight_one ,son.weight_two = parent.weight_two ,son.weight_three = parent.weight_three where son.level = 4;
update g_category_apply son inner join  g_category parent on son.parent_id = parent.id set  son.weight_one = parent.weight_one ,son.weight_two = parent.weight_two ,son.weight_three = parent.weight_three where son.level = 4;

set @rownum =2000;
update g_category_apply SET weight_four = (
select @rownum := @rownum +1 as nid)
where sort != -1 and level = 4;

update g_category set weight_one = 1,weight_two = 1,weight_three = 1,weight_four = 1 where sort =-1;

update g_category_apply
set weight_one   = (select g_category.weight_one from g_category where id = g_category_apply.id),
    weight_two   = (select g_category.weight_two from g_category where id = g_category_apply.id),
    weight_three = (select g_category.weight_three from g_category where id = g_category_apply.id),
    weight_four  = (select g_category.weight_four from g_category where id = g_category_apply.id)
    where g_category_apply.id = (select g_category.id from g_category where id = g_category_apply.id);