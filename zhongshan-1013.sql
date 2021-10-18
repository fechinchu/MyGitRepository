create table m_ecard_rule (
    id bigint auto_increment comment '主键ID' primary key,
    `name` varchar(20) null comment 'e卡名称',
    `type` varchar(60) null comment 'e卡类型:1.生日卡,2.节日卡,3.餐卡,4.卡一,5.卡二',
    start_time timestamp null comment 'e卡开始时间',
    end_time timestamp null comment 'e卡结束时间',
    direction varchar(1000) null comment '使用说明',
    remarks varchar(1000) null comment '备注',
    channel_code varchar(20) null comment '销售渠道',
    company_scope tinyint null comment '公司的适用范围(1:全部公司可用,2:指定公司可用,3.指定公司不可用)',
    merchant_scope tinyint null comment '商家的适用范围(1:全部商家可用,2:指定商家可用,3.指定商家不可用)',
    category_scope tinyint null comment '品类的适用范围(1:全部品类可用,2:指定品类可用,3.指定品类不可用)',
    org_type tinyint null comment '组织类型（0：总部；1：公司：2：商家）',
    org_id bigint null comment '组织ID',
    `status` tinyint default 1 null comment '是否上架(0:未上架,1:已上架)',
    is_deleted tinyint default 0 null comment '是否删除（0：未删除；1：已删除；默认：未删除）',
    create_user_id bigint null comment '创建人ID',
    create_user_name varchar(50) null comment '创建人姓名',
    create_user_ip varchar(50) null comment '创建人IP',
    create_time timestamp null comment '创建时间',
    update_user_id bigint null comment '更新人ID',
    update_user_name varchar(50) null comment '更新人姓名',
    update_user_ip varchar(50) null comment '更新人IP',
    update_time timestamp null comment '更新时间'
) comment '钟山e卡规则表';

create table m_ecard_company (
    id bigint auto_increment comment '主键ID' primary key,
    ecard_rule_id bigint null comment '钟山e卡规则表主键',
    company_id bigint null comment '公司id',
    company_code varchar(255) default '' not null comment '公司编码',
    company_name varchar(255) default '' not null comment '公司名称',
    company_type int(2) default 0 not null comment '公司类型：0  下属公司 1 入驻公司',
    is_deleted tinyint default 0 null comment '是否删除（0：未删除；1：已删除；默认：未删除）',
    create_user_id bigint null comment '创建人ID',
    create_user_name varchar(50) null comment '创建人姓名',
    create_user_ip varchar(50) null comment '创建人IP',
    create_time timestamp null comment '创建时间',
    update_user_id bigint null comment '更新人ID',
    update_user_name varchar(50) null comment '更新人姓名',
    update_user_ip varchar(50) null comment '更新人IP',
    update_time timestamp null comment '创建时间'
) comment '钟山e卡关联公司表';

create table m_ecard_company_selected (
    id bigint auto_increment comment '主键ID' primary key,
    operate_type tinyint null comment '1.部分可用,2.部分不可用',
    company_id bigint null comment '公司id',
    company_code varchar(255) default '' not null comment '公司编码',
    batch_no bigint  null comment '批次号',
    is_deleted tinyint default 0 null comment '是否删除（0：未删除；1：已删除；默认：未删除）',
    create_time timestamp null comment '创建时间',
    update_time timestamp null comment '创建时间'
) comment '钟山e卡已选择关联公司表';

create table m_ecard_merchant (
    id bigint auto_increment comment '主键ID' primary key,
    ecard_rule_id bigint null comment '钟山e卡规则表主键',
    merchant_id bigint null comment '商家id',
    merchant_code varchar(255) not null comment '商家code',
    merchant_name varchar(255) default '' not null comment '商家名称',
    merchant_type int(2) default 0 not null comment '商家类别：0自营商家 1外部商家',
    is_deleted tinyint default 0 null comment '是否删除（0：未删除；1：已删除；默认：未删除）',
    create_user_id bigint null comment '创建人ID',
    create_user_name varchar(50) null comment '创建人姓名',
    create_user_ip varchar(50) null comment '创建人IP',
    create_time timestamp null comment '创建时间',
    update_user_id bigint null comment '更新人ID',
    update_user_name varchar(50) null comment '更新人姓名',
    update_user_ip varchar(50) null comment '更新人IP',
    update_time timestamp null comment '创建时间'
) comment '钟山e卡关联商家表';

create table m_ecard_merchant_selected (
    id bigint auto_increment comment '主键ID' primary key,
    operate_type tinyint null comment '1.部分可用,2.部分不可用',
    merchant_id bigint null comment '商家id',
    merchant_code varchar(255) not null comment '商家code',
    batch_no bigint null comment '批次号',
    is_deleted tinyint default 0 null comment '是否删除（0：未删除；1：已删除；默认：未删除）',
    create_time timestamp null comment '创建时间',
    update_time timestamp null comment '创建时间'
) comment '钟山e卡已选择关联商家表';

create table m_ecard_category (
    id bigint auto_increment comment '主键ID' primary key,
    ecard_rule_id bigint null comment '钟山e卡规则表主键',
    category_id bigint null comment '品类id',
    category_name varchar(255) default '' not null comment '品类名称',
    is_deleted tinyint default 0 null comment '是否删除（0：未删除；1：已删除；默认：未删除）',
    create_user_id bigint null comment '创建人ID',
    create_user_name varchar(50) null comment '创建人姓名',
    create_user_ip varchar(50) null comment '创建人IP',
    create_time timestamp null comment '创建时间',
    update_user_id bigint null comment '更新人ID',
    update_user_name varchar(50) null comment '更新人姓名',
    update_user_ip varchar(50) null comment '更新人IP',
    update_time timestamp null comment '创建时间'
) comment '钟山e卡关联品类表';

create table m_ecard_category_selected (
    id bigint auto_increment comment '主键ID' primary key,
    operate_type tinyint null comment '1.部分可用,2.部分不可用',
    category_id bigint null comment '品类id',
    batch_no bigint null comment '批次号',
    is_deleted tinyint default 0 null comment '是否删除（0：未删除；1：已删除；默认：未删除）',
    create_time timestamp null comment '创建时间',
    update_time timestamp null comment '创建时间'
) comment '钟山e卡已选择关联商家表';

USE ordercenter;

ALTER TABLE `payment_term` MODIFY COLUMN `payment_style` int  null comment '支付类型:1,微信支付、2,支付宝支付、3,现金支付、4,储值卡支付、5.分期付款,6,线下付款,8.一卡通,9.钟山e卡';
ALTER TABLE `payment_term` MODIFY COLUMN `payment_style_desc` varchar(20) null comment '支付类型描述:1,微信支付、2,支付宝支付、3,现金支付、4,储值卡支付、5.分期付款,6,线下付款,8.一卡通,9.钟山e卡';
ALTER TABLE `payment_term` MODIFY COLUMN `payment_channel` int null comment '支付渠道: 1,微信公众号支付、2,微信小程序支付、3,微信APP支付、4,微信H5支付、5,微信主扫支付、6,现金支付、7,储值卡支付、8,支付宝H5支付、9,支付宝APP支付、10,支付宝PC支付、11,支付宝主扫支付、12,线下付款,15.一卡通支付,16.储值卡扫码支付,17.钟山e卡支付,18.钟山e卡扫码支付';
ALTER TABLE `payment_term` MODIFY COLUMN `payment_channel_desc`  varchar(20) null comment '支付渠道描述: 1,微信公众号支付、2,微信小程序支付、3,微信APP支付、4,微信H5支付、5,微信主扫支付、6,现金支付、7,储值卡支付、8,支付宝H5支付、9,支付宝APP支付、10,支付宝PC支付、11,支付宝主扫支付、12,线下付款,15.一卡通支付,16.储值卡扫码支付,17.钟山e卡支付,18.钟山e卡扫码支付';
ALTER TABLE `payment_term` MODIFY COLUMN `business_type` int not null comment '业务类型：1,支付、2,充值,3.抵扣';
ALTER TABLE `payment_term` MODIFY COLUMN `business_type_desc` varchar(10) not null comment '业务类型描述：1,支付、2,充值,3.抵扣';
ALTER TABLE `payment_term` ADD COLUMN `update_code_time` int not null default 0 comment '换码时间,默认60,10-600的正整数' AFTER business_type_desc;

use base;

INSERT INTO base.base_dictionary (type, base_key, base_value, description, is_deleted, create_userid, create_username, create_userip, create_time, update_userid, update_username, update_userip, update_time) VALUES ('payType', '9', '钟山e卡', '', 0, 0, '', '', '2019-12-03 16:59:03', 0, '', '', '2019-12-03 16:59:03');
INSERT INTO base.base_dictionary (type, base_key, base_value, description, is_deleted, create_userid, create_username, create_userip, create_time, update_userid, update_username, update_userip, update_time) VALUES ('paychannel', '16', '储值卡扫码支付', '', 0, 0, '', '', '2019-12-03 16:59:03', 0, '', '', '2019-12-03 16:59:03');
INSERT INTO base.base_dictionary (type, base_key, base_value, description, is_deleted, create_userid, create_username, create_userip, create_time, update_userid, update_username, update_userip, update_time) VALUES ('paychannel', '17', '钟山e卡支付', '', 0, 0, '', '', '2019-12-03 16:59:03', 0, '', '', '2019-12-03 16:59:03');
INSERT INTO base.base_dictionary (type, base_key, base_value, description, is_deleted, create_userid, create_username, create_userip, create_time, update_userid, update_username, update_userip, update_time) VALUES ('paychannel', '18', '钟山e卡扫码支付', '', 0, 0, '', '', '2019-12-03 16:59:03', 0, '', '', '2019-12-03 16:59:03');

use member;

CREATE TABLE m_ecard_import_task 
(
    id               bigint auto_increment
        primary key,
    file_name        varchar(100) default ''  not null comment '上传文件名称',
    uploader_name    varchar(45)              not null comment '上传人名称',
    uploader_id      bigint       default 0   not null comment '上传者id',
    channel_code     varchar(64)  default ''  not null,
    top_up_object    int(4)       default 1   not null comment '会员类型 1 普通会员，2 企业会员',
    status           int(4)       default 0   not null comment '0 待处理 1 处理中 2 处理失败 3 处理完成',
    upload_time      timestamp                null comment '上传时间',
    is_deleted       int(2)       default 0   not null,
    create_time      timestamp                null,
    create_user_id   bigint       default 0   not null,
    create_user_name varchar(100) default ''  not null,
    create_user_ip   varchar(50)  default ''  not null,
    update_time      timestamp                null,
    update_user_id   bigint       default 0   not null,
    update_user_name varchar(100) default ''  not null,
    update_user_ip   varchar(50)  default ''  not null
)comment '钟山E卡导入任务表';

