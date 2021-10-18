ALTER TABLE `ordercenter`.`sell_order`
ADD COLUMN `balance_deduction_amount` decimal(18, 2) NULL DEFAULT NULL COMMENT '余额抵扣金额',
ADD COLUMN `deduction_points` bigint(4) NULL DEFAULT NULL COMMENT '抵扣积分值' ,
ADD COLUMN `points_deduction_amount` decimal(18, 2) NULL DEFAULT NULL COMMENT '积分抵扣的余额',
ADD COLUMN `points_mall_deduction_amount` decimal(18, 2) NULL DEFAULT NULL comment '积分商城的抵扣金额';

ALTER TABLE `ordercenter`.`sell_order_pay_serial`
ADD COLUMN `balance_deduction_amount` decimal(18, 2) NULL DEFAULT NULL COMMENT '余额抵扣金额',
ADD COLUMN `deduction_points` bigint(4) NULL DEFAULT NULL COMMENT '抵扣积分值' ,
ADD COLUMN `points_deduction_amount` decimal(18, 2) NULL DEFAULT NULL COMMENT '积分抵扣的余额' ,
ADD COLUMN `balance_record_id` bigint(20) NULL DEFAULT NULL COMMENT '余额流水ID',
ADD COLUMN `point_record_id` bigint(20) NULL DEFAULT NULL COMMENT '积分流水ID';

ALTER TABLE `ordercenter`.`sell_order_pay_return_serial`
ADD COLUMN `balance_deduction_amount` decimal(18, 2) NULL DEFAULT NULL COMMENT '余额抵扣金额',
ADD COLUMN `deduction_points` bigint(4) NULL DEFAULT NULL COMMENT '抵扣积分值',
ADD COLUMN `points_deduction_amount` decimal(18, 2) NULL DEFAULT NULL COMMENT '积分抵扣的余额',
ADD COLUMN `balance_record_id` bigint(20) NULL DEFAULT NULL COMMENT '余额流水ID',
ADD COLUMN `point_record_id` bigint(20) NULL DEFAULT NULL COMMENT '积分流水ID';

ALTER TABLE `ordercenter`.`payment_term`
MODIFY COLUMN `business_type` int(11) NOT NULL COMMENT '业务类型：1,支付、2,充值、3,抵扣',
MODIFY COLUMN `business_type_desc` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '业务类型描述：1,支付、2,充值、3,抵扣';

ALTER TABLE `ordercenter`.`sell_order`
MODIFY COLUMN `order_pay_amount` decimal(18, 2) NOT NULL COMMENT '订单应付金额' AFTER `order_remark_cancel`,
ADD COLUMN `order_payed_amount` varchar(255) COMMENT '订单实际支付金额' AFTER `order_pay_amount`;

USE ordercenter;
update payment_term set business_type = 3, business_type_desc = '抵扣' where payment_style = 4;

USE member;

CREATE TABLE `m_member_point_deduct_rule` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `benefit_id` bigint(20) DEFAULT NULL COMMENT '会员权益ID（m_member_benefit_id）',
  `deductible_rule` int(11) DEFAULT NULL COMMENT '抵扣规则 比如1积分=0.01元，存1',
  `deductible_amount` varchar(20) DEFAULT '0.01' COMMENT '抵扣金额 默认0.01元',
  `deductible_limit` int(4) DEFAULT NULL COMMENT '抵扣额度 比如95%，存95，80%就是80',
  `applicable_scope` tinyint(4) DEFAULT NULL COMMENT '适用范围（1：全部商品；2：指定商品可用；3：指定商品不可用）',
  `org_type` tinyint(4) DEFAULT NULL COMMENT '组织类型（0：总部；1：公司：2：商家）',
  `org_id` bigint(20) DEFAULT NULL COMMENT '组织ID',
  `channel_code` varchar(20) DEFAULT NULL COMMENT '销售渠道编码',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态 1-启用，2-停用',
  `is_deleted` tinyint(4) DEFAULT '0' COMMENT '是否删除（0：未删除；1：已删除；默认：未删除）',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人ID',
  `create_user_name` varchar(50) DEFAULT NULL COMMENT '创建人姓名',
  `create_user_ip` varchar(50) DEFAULT NULL COMMENT '创建人IP',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人ID',
  `update_user_name` varchar(50) DEFAULT NULL COMMENT '更新人姓名',
  `update_user_ip` varchar(50) DEFAULT NULL COMMENT '更新人IP',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='积分抵扣规则表';

CREATE TABLE `m_member_point_deduct_goods` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `deduct_rule_id` bigint(20) DEFAULT NULL COMMENT '积分抵扣规则ID',
  `spu_id` bigint(20) DEFAULT NULL COMMENT '商品编码',
  `spu_name` varchar(100) DEFAULT NULL COMMENT '商品名称',
  `sku_id` bigint(20) DEFAULT NULL COMMENT '商品规格编码',
  `sku_name` varchar(100) DEFAULT NULL COMMENT '规格名称',
  `is_deleted` tinyint(4) DEFAULT '0' COMMENT '是否删除（0：未删除；1：已删除；默认：未删除）',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人ID',
  `create_user_name` varchar(50) DEFAULT NULL COMMENT '创建人姓名',
  `create_user_ip` varchar(50) DEFAULT NULL COMMENT '创建人IP',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人ID',
  `update_user_name` varchar(50) DEFAULT NULL COMMENT '更新人姓名',
  `update_user_ip` varchar(50) DEFAULT NULL COMMENT '更新人IP',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='积分抵扣规则关联商品表';


CREATE TABLE `m_member_point_deduct_goods_select` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `deduct_rule_id` bigint(20) DEFAULT NULL COMMENT '积分抵扣规则ID',
  `spu_id` bigint(20) DEFAULT NULL COMMENT '商品编码',
  `sku_id` bigint(20) DEFAULT NULL COMMENT '商品规格编码',
  `is_deleted` tinyint(4) DEFAULT '0' COMMENT '是否删除（0：未删除；1：已删除；默认：未删除）',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='积分抵扣规则被选择的商品表';


CREATE TABLE `m_point_mall` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `enable_status` tinyint(4) DEFAULT '0' COMMENT '启用状态（0：未启用；1：已启用）',
  `org_type` tinyint(4) DEFAULT NULL COMMENT '组织类型（0：总部；1：公司；2：商家）',
  `org_id` bigint(20) DEFAULT NULL COMMENT '组织ID',
  `channel_code` varchar(20) DEFAULT NULL COMMENT '销售渠道编码',
  `is_deleted` tinyint(4) DEFAULT '0' COMMENT '是否删除（0：未删除；1：已删除）',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人ID',
  `create_user_name` varchar(50) DEFAULT NULL COMMENT '创建人姓名',
  `create_user_ip` varchar(50) DEFAULT NULL COMMENT '创建人IP',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人ID',
  `update_user_name` varchar(50) DEFAULT NULL COMMENT '更新人姓名',
  `update_user_ip` varchar(50) DEFAULT NULL COMMENT '更新人IP',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='会员积分商城表';

CREATE TABLE `m_point_mall_goods` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `point_mall_id` bigint(20) DEFAULT NULL COMMENT '积分商城ID',
  `spu_id` bigint(20) DEFAULT NULL COMMENT '商品编码',
  `spu_name` varchar(255) DEFAULT NULL COMMENT '商品名称',
  `sku_id` bigint(20) DEFAULT NULL COMMENT '商品规格编码',
  `sku_name` varchar(255) DEFAULT NULL COMMENT '商品规格名称',
  `total_quantity` int(11) DEFAULT '0' COMMENT '积分商品总数量',
  `remaining_quantity` int(11) DEFAULT '0' COMMENT '剩余可兑换数量',
  `base_price` decimal(9,2) DEFAULT '0.00' COMMENT '商品原价',
  `limit_quantity` int(11) DEFAULT '0' COMMENT '每人限购数量',
  `exchange_point` int(11) DEFAULT '0' COMMENT '兑换积分',
  `exchange_price` decimal(9,2) DEFAULT '0.00' COMMENT '兑换价格',
  `shelves_status` tinyint(4) DEFAULT '0' COMMENT '上下架状态（0：未上架；1：已上架）',
  `spu_image_url` varchar(255) DEFAULT NULL COMMENT '商品主图URL（spu-image-url）',
  `sku_image_url` varchar(255) DEFAULT NULL COMMENT '商品规格图URL（sku-image-url）',
  `is_top` tinyint(4) DEFAULT '0' COMMENT '是否置顶（0：未置顶；1：已置顶）',
  `sorting` int(11) DEFAULT '0' COMMENT '排序号',
  `is_deleted` tinyint(4) DEFAULT '0' COMMENT '是否删除（0：未删除；1：已删除）',
  `org_type` tinyint(4) DEFAULT NULL COMMENT '组织类型（0：总部；1：公司；2：商家）',
  `org_id` bigint(20) DEFAULT NULL COMMENT '组织ID',
  `channel_code` varchar(20) DEFAULT NULL COMMENT '销售渠道编码',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建人ID',
  `create_user_name` varchar(50) DEFAULT NULL COMMENT '创建人姓名',
  `create_user_ip` varchar(50) DEFAULT NULL COMMENT '创建人IP',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `update_user_id` bigint(20) DEFAULT NULL COMMENT '更新人ID',
  `update_user_name` varchar(50) DEFAULT NULL COMMENT '更新人姓名',
  `update_user_ip` varchar(50) DEFAULT NULL COMMENT '更新人IP',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='会员积分商城商品表';


CREATE TABLE `m_point_mall_goods_exchanged_record` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `mall_goods_id` bigint(20) NOT NULL COMMENT '商品主键',
  `member_id` bigint(20) NOT NULL COMMENT '会员id',
  `number` bigint(20) DEFAULT '0' COMMENT '已兑换商品数',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='会员已兑换记录表';


CREATE TABLE `m_point_mall_goods_selected` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `point_mall_id` bigint(20) DEFAULT NULL COMMENT '积分商城ID',
  `spu_id` bigint(20) DEFAULT NULL COMMENT '商品编码',
  `sku_id` bigint(20) DEFAULT NULL COMMENT '商品规格编码',
  `org_type` tinyint(4) DEFAULT NULL COMMENT '组织类型（0：总部；1：公司；2：商家）',
  `org_id` bigint(20) DEFAULT NULL COMMENT '组织ID',
  `channel_code` varchar(20) DEFAULT NULL COMMENT '销售渠道编码',
  `is_deleted` tinyint(4) DEFAULT '0' COMMENT '是否删除（0：未删除；1：已删除）',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='会员积分商城已选择商品';

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