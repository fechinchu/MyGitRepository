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
