--修改线路间隔备注
comment on column route.reportinterval 
  is '报班时间间隔，该线路在设置的时间间隔内部允许报班，0：不限制，单位：分钟';
--end
  
-- 孙越 2016年11月2日 15:36:04  vehicle 表 添加 燃料类型字段 --
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('VEHICLE') AND COLUMN_NAME = upper('fueltype')}
alter table VEHICLE add fueltype varchar2(10) default 0;
-- Add comments to the columns 
comment on column VEHICLE.fueltype
  is '燃料类型, 取数据字典';
-- end --
--begin 班次添加是否自动报班字段 BY jiangyr
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('SCHEDULE') AND COLUMN_NAME = upper('ISAUTOREPORT')}
alter table SCHEDULE add ISAUTOREPORT NUMBER(1) default 0;
--end
--begin
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('customer') AND COLUMN_NAME = upper('isblack')}
alter table customer  add  isblack number(1) default 0;
comment on column customer.isblack is '是否黑名单0：不是1：是';
--end

--start 孙越 2016年11月9日 09:44:26 添加表 --
@repeat{select count(*) from user_tables where table_name=upper('TICKETOUTLETSROUTEPRICE')}
create table TICKETOUTLETSROUTEPRICE
(
  id              NUMBER(10) not null,
  routeid         NUMBER(10) not null,
  ticketoutletsid NUMBER(10) not null,
  price           NUMBER(10,2) not null,
  orgid           NUMBER(10) not null,
  createtime      DATE not null,
  createby        NUMBER(10) not null,
  updatetime      DATE not null,
  updateby        NUMBER(10) not null,
  startdate       DATE not null,
  enddate         DATE not null,
  routestopid     NUMBER(10) not null
);
-- Add comments to the table 
comment on table TICKETOUTLETSROUTEPRICE
  is '线路票价差额管理';
-- Add comments to the columns 
comment on column TICKETOUTLETSROUTEPRICE.routeid
  is '线路ID';
comment on column TICKETOUTLETSROUTEPRICE.ticketoutletsid
  is '售票点ID';
comment on column TICKETOUTLETSROUTEPRICE.price
  is '价差';
comment on column TICKETOUTLETSROUTEPRICE.orgid
  is '机构ID，当前车站';
comment on column TICKETOUTLETSROUTEPRICE.startdate
  is '开始时间';
comment on column TICKETOUTLETSROUTEPRICE.enddate
  is '结束时间';
comment on column TICKETOUTLETSROUTEPRICE.routestopid
  is '线路停靠点ID';
@repeat{select count(*) from user_indexes t where t.table_name = 'TICKETOUTLETSROUTEPRICE' and t.index_name = 'IDXTCKPRICE' }
create unique index IDXTCKPRICE on TICKETOUTLETSROUTEPRICE (ROUTEID, TICKETOUTLETSID, ROUTESTOPID, STARTDATE, ENDDATE);
@repeat{select count(*) from user_constraints t where t.table_name = 'TICKETOUTLETSROUTEPRICE' and t.constraint_type = 'P' }
alter table TICKETOUTLETSROUTEPRICE add constraint PKTCKROUTEPRICE primary key (ID);
--end--

--begin 孙越 2016年11月10日 10:33:31 添加字段--
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('VEHICLE') AND COLUMN_NAME = upper('pullinagreementno')}
alter table VEHICLE add pullinagreementno VARCHAR2(30);
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('VEHICLE') AND COLUMN_NAME = upper('pullinstartdate')}
alter table VEHICLE add pullinstartdate date;
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('VEHICLE') AND COLUMN_NAME = upper('pullinenddate')}
alter table VEHICLE add pullinenddate date;
-- Add comments to the columns 
comment on column VEHICLE.pullinagreementno
  is '进站协议号';
comment on column VEHICLE.pullinstartdate
  is '进站协议开始日期';
comment on column VEHICLE.pullinenddate
  is '进站协议结束日期';
--end--

@repeat{select count(*) from user_indexes t where t.table_name = 'TICKETSELLOTHER' and t.index_name = 'IDX_TICKETSELLIDE' }
create index IDX_TICKETSELLIDE on TICKETSELLOTHER (ticketsellid);
--start 2016年11月11日 11:37:35   张清风 --
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('platforminsureorderdetail') AND COLUMN_NAME = upper('INSURETICKETNO')}
alter table platforminsureorderdetail add INSURETICKETNO varchar2(100);
comment on column PLATFORMINSUREORDERDETAIL.insureticketno
  is '保险票号'; 
--end 2016年11月11日 11:37:35   张清风 --

--addby daijy 2016-11-16
@repeat{SELECT 1-COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('PARAMETER') AND COLUMN_NAME = upper('REMARK')}
alter table PARAMETER modify REMARK VARCHAR2(400);
--end

--begin 2016年11月15日 zhaohuaihu 车牌表增加字段
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('VEHICLE') AND COLUMN_NAME = upper('ISCHARGESTOPFEE')}
alter table VEHICLE add ISCHARGESTOPFEE NUMBER(1) default 0 not null;
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('VEHICLE') AND COLUMN_NAME = upper('ISCHARGESCHECKFEE')}
alter table VEHICLE add ISCHARGESCHECKFEE NUMBER(1) default 0 not null;
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('VEHICLE') AND COLUMN_NAME = upper('ISCHARGEOTHERFEE')}
alter table VEHICLE add ISCHARGEOTHERFEE NUMBER(1) default 0 not null;
-- Add comments to the columns 
comment on column VEHICLE.ISCHARGESTOPFEE
  is '是否收取停车费';
comment on column VEHICLE.ISCHARGESCHECKFEE
  is '是否收取例检费';
comment on column VEHICLE.ISCHARGEOTHERFEE
  is '是否收取其他费用';
--end 2016年11月15日 zhaohuaihu 车牌表增加字段
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('PACKTTURNOVERDETAIL') AND COLUMN_NAME = upper('PAYMETHOD')}
alter table PACKTTURNOVERDETAIL add PAYMETHOD VARCHAR2(10) default '0' not null;
comment on column PACKTTURNOVERDETAIL.PAYMETHOD  is '行包付款方式';
--end--

--begin 孙越 2016年12月2日 14:03:24  打印模版添加字段 --
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('PRINTTEMPLATE') AND COLUMN_NAME = upper('printheighttype')}
alter table PRINTTEMPLATE add printheighttype NUMBER(1) default 0 not null;
-- Add comments to the columns 
comment on column PRINTTEMPLATE.printheighttype
  is '走纸高度 0:取打印模版高度 , 1:取打印机纸张大小高度. 默认为0';
--end--