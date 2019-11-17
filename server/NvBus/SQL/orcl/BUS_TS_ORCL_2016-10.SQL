--顾客信息表增加顾客民族字段，取数据字典。
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('customer') AND COLUMN_NAME = upper('nation')}
alter table customer add nation VARCHAR2(30);
comment on column customer.nation  is '民族';
--end

--begin zhaohuaihu 2016-10-16 联网售票增加留位代理表
@repeat{select count(*) from user_tables where table_name=upper('SEATRESERVEAGENT')}
create table SEATRESERVEAGENT
(
  ID               NUMBER(10) not null,
  SCHEDULEPLANID   NUMBER(10) not null,
  ORGID            NUMBER(10) not null,
  DEPARTDATE       DATE not null,
  SCHEDULECODE     VARCHAR2(20) not null,
  DEPARTTIME       CHAR(5) not null,
  DEPARTSTATIONID  NUMBER(10),
  REACHSTATIONID   NUMBER(10),
  FULLPRICE        NUMBER(10,2),
  TICKETTYPE       CHAR(1),
  SEATNO           NUMBER(4) not null,
  SERVICEPRICE     NUMBER(10,2) default 0 not null,
  PASSWORD         VARCHAR2(20),
  CARRYCHILDNUM    NUMBER(2) default 0 not null,
  ISAUTOCANCEL     NUMBER(1) default 0 not null,
  AUTOCANCELTIME   DATE,
  CUSTOMERID       NUMBER(10),
  RESERVETIME      DATE not null,
  RESERVEIP        VARCHAR2(40) not null,
  TICKETOUTLETSID  NUMBER(10) not null,
  RESERVEBY        NUMBER(10) not null,
  RESERVEWAY       VARCHAR2(10) default '0' not null,
  REMARKS          VARCHAR2(40),
  SELLSTATE        VARCHAR2(10) default 'R' not null,
  TURNOVERDETAILID NUMBER(10),
  CANCELBY         NUMBER(10),
  CANCELTIME       DATE,
  CREATETIME       DATE default SYSDATE not null,
  CREATEBY         NUMBER(10) not null,
  UPDATETIME       DATE default SYSDATE not null,
  UPDATEBY         NUMBER(10) not null,
  RESERVEORGID     NUMBER(10),
  ROUTENAME        VARCHAR2(50),
  SCHEDULESYNCCODE VARCHAR2(100),
  SEATTYPE         VARCHAR2(10)
);
-- Add comments to the table 
comment on table SEATRESERVEAGENT
  is '座位预留表';
-- Add comments to the columns 
comment on column SEATRESERVEAGENT.ID
  is '主键';
comment on column SEATRESERVEAGENT.SCHEDULEPLANID
  is '异站班次运行计划ID';
comment on column SEATRESERVEAGENT.ORGID
  is '班次所属车站ID';
comment on column SEATRESERVEAGENT.DEPARTDATE
  is '发车日期';
comment on column SEATRESERVEAGENT.SCHEDULECODE
  is '班次号';
comment on column SEATRESERVEAGENT.DEPARTTIME
  is '发车时间';
comment on column SEATRESERVEAGENT.DEPARTSTATIONID
  is '发车站id';
comment on column SEATRESERVEAGENT.REACHSTATIONID
  is '到达站id';
comment on column SEATRESERVEAGENT.FULLPRICE
  is '全票价';
comment on column SEATRESERVEAGENT.TICKETTYPE
  is '车票类型: 全票,半票,学生票,打折票  取车票类型表';
comment on column SEATRESERVEAGENT.SEATNO
  is '座位号';
comment on column SEATRESERVEAGENT.SERVICEPRICE
  is '留票服务费';
comment on column SEATRESERVEAGENT.PASSWORD
  is '取票密码';
comment on column SEATRESERVEAGENT.CARRYCHILDNUM
  is '带儿童数量';
comment on column SEATRESERVEAGENT.ISAUTOCANCEL
  is '是否自动取消';
comment on column SEATRESERVEAGENT.AUTOCANCELTIME
  is '自动取消留位时间';
comment on column SEATRESERVEAGENT.CUSTOMERID
  is '顾客id';
comment on column SEATRESERVEAGENT.RESERVETIME
  is '留票时间';
comment on column SEATRESERVEAGENT.RESERVEIP
  is '留票电脑';
comment on column SEATRESERVEAGENT.TICKETOUTLETSID
  is '留票点id';
comment on column SEATRESERVEAGENT.RESERVEBY
  is '留票人ID';
comment on column SEATRESERVEAGENT.RESERVEWAY
  is '留票途径  从数据字典取';
comment on column SEATRESERVEAGENT.SELLSTATE
  is '售票状态：''R''-留票，''S''-已售，''C''-取消   取数据字典';
comment on column SEATRESERVEAGENT.TURNOVERDETAILID
  is '应缴款明细ID';
comment on column SEATRESERVEAGENT.CANCELBY
  is '取消人';
comment on column SEATRESERVEAGENT.CANCELTIME
  is '取消时间';
comment on column SEATRESERVEAGENT.RESERVEORGID
  is '留票机构';
  
-- Create/Recreate primary, unique and foreign key constraints 
@repeat{select count(*) from user_constraints t where t.table_name = 'SEATRESERVEAGENT' and t.constraint_type = 'P' }
alter table SEATRESERVEAGENT add constraint PK_SEATRESERVEAGENT primary key (ID);
-- Create/Recreate indexes 
@repeat{select count(*) from user_indexes t where t.table_name = 'SEATRESERVEAGENT' and t.index_name = 'IDX_SEATRESERVEAGENT' }
create index IDX_SEATRESERVEAGENT on SEATRESERVEAGENT (DEPARTDATE, SCHEDULECODE, SEATNO);
@repeat{select count(*) from user_indexes t where t.table_name = 'SEATRESERVEAGENT' and t.index_name = 'IDX_SEATRESERVEAGENT2' }
create index IDX_SEATRESERVEAGENT2 on SEATRESERVEAGENT (SCHEDULEPLANID, SEATNO);

@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('SEATRESERVEAGENT') AND COLUMN_NAME = upper('ROUTENAME')}
alter table SEATRESERVEAGENT add ROUTENAME VARCHAR2(50);
comment on column SEATRESERVEAGENT.ROUTENAME  is '线路名称';
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('SEATRESERVEAGENT') AND COLUMN_NAME = upper('SCHEDULESYNCCODE')}
alter table SEATRESERVEAGENT add SCHEDULESYNCCODE VARCHAR2(100);
comment on column SEATRESERVEAGENT.SCHEDULESYNCCODE  is '班次同步码';
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('SEATRESERVEAGENT') AND COLUMN_NAME = upper('SEATTYPE')}
alter table SEATRESERVEAGENT add SEATTYPE VARCHAR2(10);
comment on column SEATRESERVEAGENT.SEATTYPE  is '座位类型';
--end zhaohuaihu 2016-10-16 联网售票增加留位代理表

--班次表增加删除标记，2016-10-20 addby daijy
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('schedule') AND COLUMN_NAME = upper('isdelete')}
alter table schedule add (isdelete NUMBER(1) default 0);
comment on column schedule.isdelete  is '是否删除标记，和isactive同时作用。默认为0：没有删除，为1：删除';
--end
--begin 姜蓥瑞 2016年10月25日08:48:10  VIP 表索引问题修改
@repeat{select 1- count(*) from user_indexes t where t.table_name = 'VIP' and t.index_name = 'PK_VIP' }
drop index PK_VIP;
@repeat{select count(*) from user_indexes t where t.table_name = 'VIP' and t.index_name = 'PK_VIP' }
create unique index PK_VIP on VIP (id);
--end
--添加黑名单功能 2016-10-31 张清风 start
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('customer') AND COLUMN_NAME = upper('isblack')}  
alter table customer  add  isblack number(1) default 0;
comment on column customer.isblack is '是否黑名单0：不是1：是';
--添加黑名单功能 2016-10-31 张清风 end
