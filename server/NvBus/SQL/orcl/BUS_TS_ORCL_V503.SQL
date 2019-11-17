-- 2015/03/24  杨志文 驾驶员档案管理 开始-- 
@repeat{SELECT 1-COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('driver') AND COLUMN_NAME = upper('politicsstatus') and nullable = 'N'}
ALTER TABLE driver MODIFY politicsstatus NULL;
@repeat{SELECT 1-COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('driver') AND COLUMN_NAME = upper('education') and nullable = 'N'}
ALTER TABLE driver MODIFY education NULL;
-- 2015/03/24 杨志文 驾驶员档案管理 结束-- 

--yuanzhaolun 04-07 begin
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('CLIENT') AND COLUMN_NAME = upper('INTEGRATER')}  
ALTER TABLE CLIENT ADD  INTEGRATER  NUMBER(8) ;

COMMENT ON COLUMN CLIENT.INTEGRATER IS  '可用积分'; 

--yuanzhaolun 04-07 end

-- 2015/04/13  增加版本号表   孙越 begin-- 
@repeat{select count(*) from user_tables where table_name=upper('VERSION') }
create table VERSION
(
  ID         NUMBER(10) not null,
  VERSIONNUM VARCHAR2(50) not null,
  UPDATETIME DATE not null
);
-- Add comments to the table 
comment on table VERSION
  is '版本';
-- Add comments to the columns 
comment on column VERSION.VERSIONNUM
  is '版本号';
comment on column VERSION.UPDATETIME
  is '更新日期';
-- Create/Recreate primary, unique and foreign key constraints 

@repeat{select count(1) from user_constraints t where t.table_name = upper('VERSION') and t.constraint_type = 'P' }
alter table VERSION
  add constraint PKVERSION primary key (ID);

-- 2015/04/13  增加版本号表   end -- 

--2015/04/14 增加字段  begin
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('PACK') AND COLUMN_NAME = upper('TAKECERTIFICATENO') }  
alter table pack add  TAKECERTIFICATENO varchar2(30);
--end

--2015/04/20 新增字段 type，dataid,删除字段orgid begin  liyi
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('balancedeductapplysell') AND COLUMN_NAME = upper('type') } 
alter table balancedeductapplysell add (type varchar2(10));
comment on column BALANCEDEDUCTAPPLYSELL.TYPE is '0:机构,1:售票点';
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('balancedeductapplysell') AND COLUMN_NAME = upper('dataid')} 
alter table balancedeductapplysell add (dataid number(10) not null);
@repeat{SELECT 1-COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('balancedeductapplysell') AND COLUMN_NAME = upper('orgid') } 
alter table balancedeductapplysell drop column orgid;
-- end



@repeat{select count(*) from user_tables where table_name=upper('ENTRYTICKET') }
create table ENTRYTICKET
(
  ID         NUMBER(10) not null,
  TICKETNO   VARCHAR2(20) not null,
  CREATETIME DATE default SYSDATE not null
);
-- Create/Recreate primary, unique and foreign key constraints 
@repeat{select  COUNT(*) from user_indexes t where t.table_name= upper('ENTRYTICKET') and t.index_name=upper('PK_TICKET2ID') }  
alter table ENTRYTICKET
  add constraint PK_TICKET2ID primary key (ID);
-- Create/Recreate indexes 

@repeat{select  COUNT(*) from user_indexes t where t.table_name= upper('ENTRYTICKET') and t.index_name=upper('IDX_TICKET2NO') }  
create index IDX_TICKET2NO on ENTRYTICKET (TICKETNO);

--2015/05/20增加字段  begin
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('steward') AND COLUMN_NAME = upper('jianpin') }  
alter table steward add jianpin varchar2(10);
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('driver') AND COLUMN_NAME = upper('jianpin') }  
alter table driver add jianpin varchar2(10);
--end
--微机单表中新增驾驶员，乘务员ID，用来做数据同步
-- Add/modify columns  2015/05/21
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('DEPARTINVOICES') AND COLUMN_NAME = upper('DRIVER1ID') } 
alter table DEPARTINVOICES add DRIVER1ID NUMBER(10);
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('DEPARTINVOICES') AND COLUMN_NAME = upper('DRIVER2ID') } 
alter table DEPARTINVOICES add DRIVER2ID NUMBER(10);
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('DEPARTINVOICES') AND COLUMN_NAME = upper('STEWARD1ID') } 
alter table DEPARTINVOICES add STEWARD1ID NUMBER(10);
-- end
--新增安检费字段
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('securitycheck') AND COLUMN_NAME = upper('securityfee') } 
alter table securitycheck add securityfee number(10,2);

@repeat{select count(*) from user_tables where table_name=upper('PACKARRIVER')}
-- Create table
create table PACKARRIVER
(
  ID               NUMBER(10) not null,
  PACKID           NUMBER(10) not null,
  PACKARRIVERNO    VARCHAR2(20) not null,
  ARRIVERDATE      DATE not null,
  SENDSTATIONID    NUMBER(10) not null,
  SERVICEFEE       NUMBER(10,2) not null,
  PACKFEE          NUMBER(10,2) not null,
  PACKPRICE        NUMBER(10,2) not null,
  TRANSITSTATIONID NUMBER(10),
  RECEIVER         NUMBER(10) not null,
  CONSIGNEE        VARCHAR2(60) not null,
  CONSIGNEEPHONE   VARCHAR2(20) not null,
  PIECES           NUMBER(3) not null,
  PACKED           VARCHAR2(10) not null,
  LOCATION         VARCHAR2(60),
  DRIVERID         NUMBER(10),
  STATUS           VARCHAR2(10) default 0 not null,
  PACKBALANCEID    NUMBER(10),
  ORGID            NUMBER(10) not null,
  CREATETIME       DATE default SYSDATE not null,
  CREATEBY         NUMBER(10) not null,
  UPDATETIME       DATE default SYSDATE not null,
  UPDATEBY         NUMBER(10) not null
);
-- Add comments to the table 
comment on table PACKARRIVER
  is '行包收讫表';
-- Add comments to the columns 
comment on column PACKARRIVER.PACKID
  is '行包ID';
comment on column PACKARRIVER.PACKARRIVERNO
  is '收讫单号';
comment on column PACKARRIVER.ARRIVERDATE
  is '收讫日期';
comment on column PACKARRIVER.SENDSTATIONID
  is '发货站';
comment on column PACKARRIVER.SERVICEFEE
  is '服务费';
comment on column PACKARRIVER.PACKFEE
  is '代收运费=入仓时总金额';
comment on column PACKARRIVER.PACKPRICE
  is '货款';
comment on column PACKARRIVER.TRANSITSTATIONID
  is '中转至';
comment on column PACKARRIVER.RECEIVER
  is '收讫人';
comment on column PACKARRIVER.CONSIGNEE
  is '收货人';
comment on column PACKARRIVER.CONSIGNEEPHONE
  is '收货人电话';
comment on column PACKARRIVER.PIECES
  is '件数';
comment on column PACKARRIVER.PACKED
  is '包装类型';
comment on column PACKARRIVER.LOCATION
  is '存放位置';
comment on column PACKARRIVER.DRIVERID
  is '司机ID';
comment on column PACKARRIVER.STATUS
  is '状态：0：未结算；1：已注销：2：已结算';
-- Create/Recreate primary, unique and foreign key constraints 
@repeat{select count(1) from user_constraints t where t.table_name = upper('PACKARRIVER') and t.constraint_type = 'P' }
alter table PACKARRIVER
  add constraint PK_PACKARRIVER primary key (ID);
-- Create/Recreate indexes 
@repeat{select count(*) from user_indexes where Index_Name=upper('IDXPACKARRIVER')}
create index IDXPACKARRIVER on PACKARRIVER (ARRIVERDATE, PACKARRIVERNO);

drop table PACKBALANCE;

@repeat{select count(*) from user_tables where table_name=upper('PACKBALANCE')}
create table PACKBALANCE
(
  ID               NUMBER(10) not null,
  DATATYPE         VARCHAR2(10) default 0 not null,
  PACKBALANCENO    VARCHAR2(20) not null,
  BALANCEUNITNAME  VARCHAR2(100) not null,
  PACKNOS          NUMBER(10) not null,
  PIECES           NUMBER(10) not null,
  PACKMONEY        NUMBER(15,3) default 0 not null,
  PACKPRICE        NUMBER(15,3) default 0 not null,
  PACKDEDUCTMONEY  NUMBER(15,3) default 0 not null,
  PACKBALANCEMONEY NUMBER(15,3) default 0 not null,
  BALANCBY         NUMBER(10) not null,
  BALANCETIME      DATE default SYSDATE not null,
  BALANCEIP        VARCHAR2(255) not null,
  CANCELBY         NUMBER(10),
  CLEARTIME        DATE,
  CANCELIP         VARCHAR2(255),
  STATUS           CHAR(1) not null,
  ORGID            NUMBER(10) not null,
  CREATETIME       DATE default SYSDATE not null,
  CREATEBY         NUMBER(10) not null,
  UPDATETIME       DATE default SYSDATE not null,
  UPDATEBY         NUMBER(10) not null
);
-- Add comments to the table 
comment on table PACKBALANCE
  is '行包结算单';
-- Add comments to the columns 
comment on column PACKBALANCE.DATATYPE
  is '0：出库结算，1：前台结算';
comment on column PACKBALANCE.PACKBALANCENO
  is '结帐单号';
comment on column PACKBALANCE.BALANCEUNITNAME
  is '结算单位';
comment on column PACKBALANCE.PACKNOS
  is '单据张数';
comment on column PACKBALANCE.PIECES
  is '件数';
comment on column PACKBALANCE.PACKMONEY
  is '运费';
comment on column PACKBALANCE.PACKPRICE
  is '货款';
comment on column PACKBALANCE.PACKDEDUCTMONEY
  is '总行包扣款金额';
comment on column PACKBALANCE.PACKBALANCEMONEY
  is '总行包结算金额';
comment on column PACKBALANCE.BALANCBY
  is '结算人';
comment on column PACKBALANCE.BALANCETIME
  is '结算时间';
comment on column PACKBALANCE.BALANCEIP
  is '结算计算机ip';
comment on column PACKBALANCE.CANCELBY
  is '注销人';
comment on column PACKBALANCE.CLEARTIME
  is '注销时间';
comment on column PACKBALANCE.CANCELIP
  is '注销计算机名称';
comment on column PACKBALANCE.STATUS
  is '结算单状态(0正常, 1注销)';
-- Create/Recreate primary, unique and foreign key constraints 
alter table PACKBALANCE
  add constraint PK_PACKBALANCE primary key (ID);
-- Create/Recreate check constraints 
alter table PACKBALANCE
  add constraint CK_PACKBALANCEBALANCEMONEY
  check (packbalancemoney >= 0);
alter table PACKBALANCE
  add constraint CK_PACKBALANCEDEDUCTMONEY
  check (packdeductmoney >= 0);
alter table PACKBALANCE
  add constraint CK_PACKBALANCEMONEY
  check (packmoney >= 0);

@repeat{select count(*) from user_tables where table_name=upper('RENTPLACE')}
create table RENTPLACE
(
  ID          NUMBER(10) not null,
  STATIONNAME VARCHAR2(50) not null,
  HOUSENUM    VARCHAR2(10) not null,
  RENTTYPE    VARCHAR2(10) not null,
  LOCATION    VARCHAR2(60) not null,
  AREA        VARCHAR2(60) not null,
  PURPOSE     VARCHAR2(200) not null,
  ORGID       NUMBER(10) not null,
  ISACTIVE    NUMBER(1) default 1 not null,
  CREATETIME  DATE default SYSDATE not null,
  CREATEBY    NUMBER(10) not null,
  UPDATETIME  DATE default SYSDATE not null,
  UPDATEBY    NUMBER(10) not null
);
-- Add comments to the table 
comment on table RENTPLACE
  is '租赁场地';
-- Add comments to the columns 
comment on column RENTPLACE.STATIONNAME
  is '站别';
comment on column RENTPLACE.HOUSENUM
  is '房屋编号';
comment on column RENTPLACE.RENTTYPE
  is '租赁类型（可自定义，如房屋、场地、广告位等）,字典表';
comment on column RENTPLACE.LOCATION
  is '位置';
comment on column RENTPLACE.AREA
  is '面积';
comment on column RENTPLACE.PURPOSE
  is '租赁用途';
-- Create/Recreate primary, unique and foreign key constraints 
@repeat{select count(1) from user_constraints t where t.table_name = upper('RENTPLACE') and t.constraint_type = 'P' }
alter table RENTPLACE
  add constraint PK_RENTPLACE primary key (ID);

-- 2015/05/20 张彪 行包结算单建表语句 开始-- 
@repeat{select count(*) from user_tables where table_name=upper('PACKDEPARTINVOICES')}
create table PACKDEPARTINVOICES
(
  ID                NUMBER(10) not null,
  DEPARTINVOICESNO  VARCHAR2(20),
  SCHEDULEPLANID  NUMBER(10) not null,
  DEPARTDATE      DATE not null,
  SCHEDULEID      NUMBER(10) not null,
  DEPARTTIME      CHAR(5) not null,
  VEHICLEID       NUMBER(10) not null,
  REPORTID        NUMBER(10) not null,
  PRINTORGID      NUMBER(10) not null,
  PRINTIP         VARCHAR2(40) not null,
  PRINTBY         NUMBER(10) not null,
  PRINTTIME       DATE not null,
  PIECES         NUMBER(3),
  SHIPPRICE      NUMBER(6,2),
  PACKFEE        NUMBER(6,2),
  HANDFEE        NUMBER(6,2),
  CUSTODIAL      NUMBER(6,2),
  TRANSITFEE     NUMBER(6,2),
  INSUREDAMOUNT  NUMBER(6,2),
  INSURANCEFEE   NUMBER(6,2),
  DELIVERYFEE    NUMBER(6,2),
  OTHERFEE       NUMBER(6,2),
  PACKPRICE      NUMBER(6,2),
  SERVICEFEE     NUMBER(6,2),
  TOTALFEE       NUMBER(6,2),
  BALANCEAMOUNT  NUMBER(6,2),
  CANCELSTATIONID NUMBER(10),
  CANCELBY NUMBER(10),
  CANCELTIME DATE,
  STATUS VARCHAR2(10) not null,
  PACKBALANCEID NUMBER(10),
  PRINTWAY VARCHAR2(10),
  DATATYPE VARCHAR2(10),
  CREATETIME        DATE default SYSDATE not null,
  CREATEBY          NUMBER(10) not null,
  UPDATETIME        DATE default SYSDATE not null,
  UPDATEBY          NUMBER(10) not null
)
tablespace TS_DEPARTINVOICES
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

comment on table PACKDEPARTINVOICES
  is '行包结算单/运量单表';
-- Add comments to the columns 
comment on column PACKDEPARTINVOICES.DEPARTINVOICESNO
  is '行包结算单号';
comment on column PACKDEPARTINVOICES.SCHEDULEPLANID
  is '班次计划ID';
comment on column PACKDEPARTINVOICES.DEPARTDATE
  is '发车日期';
comment on column PACKDEPARTINVOICES.SCHEDULEID
  is '班次ID';
comment on column PACKDEPARTINVOICES.DEPARTTIME
  is '发车时间';
comment on column PACKDEPARTINVOICES.VEHICLEID
  is '车辆ID';
comment on column PACKDEPARTINVOICES.REPORTID
  is '车辆报到表ID';
comment on column PACKDEPARTINVOICES.PRINTORGID
  is '开单组织机构id';
comment on column PACKDEPARTINVOICES.PRINTIP
  is '开单Ip';
comment on column PACKDEPARTINVOICES.PRINTBY
  is '开单人id';
comment on column PACKDEPARTINVOICES.PRINTTIME
  is '开单时间';
comment on column PACKDEPARTINVOICES.PIECES
  is '行包件数';
comment on column PACKDEPARTINVOICES.SHIPPRICE
  is '托运费';
comment on column PACKDEPARTINVOICES.PACKFEE
  is '包装费';
comment on column PACKDEPARTINVOICES.HANDFEE
  is '装卸费';
comment on column PACKDEPARTINVOICES.CUSTODIAL
  is '保管费';
comment on column PACKDEPARTINVOICES.TRANSITFEE
  is '中转费';
comment on column PACKDEPARTINVOICES.INSUREDAMOUNT
  is '保价金额';
comment on column PACKDEPARTINVOICES.INSURANCEFEE
  is '保险费';
comment on column PACKDEPARTINVOICES.DELIVERYFEE
  is '送货费';
comment on column PACKDEPARTINVOICES.OTHERFEE
  is '其他费用';
comment on column PACKDEPARTINVOICES.PACKPRICE
  is '代收货款';
comment on column PACKDEPARTINVOICES.SERVICEFEE
  is '服务费';
comment on column PACKDEPARTINVOICES.TOTALFEE
  is '合计金额';
comment on column PACKDEPARTINVOICES.BALANCEAMOUNT
  is '结算金额';
comment on column PACKDEPARTINVOICES.CANCELSTATIONID
  is '注销站点id';
comment on column PACKDEPARTINVOICES.CANCELBY
  is '注销人id';
comment on column PACKDEPARTINVOICES.CANCELTIME
  is '注销时间';
comment on column PACKDEPARTINVOICES.CANCELTIME
  is '注销时间';
comment on column PACKDEPARTINVOICES.CANCELTIME
  is '注销时间';
comment on column PACKDEPARTINVOICES.STATUS
  is '运量单状态: 0未结算、 1注销、 2已结算、3待结算， 取数据字典';  
comment on column PACKDEPARTINVOICES.PACKBALANCEID
  is '行包结算单id';
comment on column PACKDEPARTINVOICES.PRINTWAY
  is '打印结算单方式：0：发班打印、1：补开、2：重打';
comment on column PACKDEPARTINVOICES.DATATYPE
  is '数据类型：0：微机单、1：手工单';

@repeat{select count(1) from user_constraints t where t.table_name = upper('PACKDEPARTINVOICES') and t.constraint_type = 'P' }
alter table PACKDEPARTINVOICES
  add constraint PK_PACKDEPARTINVOICES primary key (ID)
  using index 
  tablespace TS_DEPARTINVOICES
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
-- 2015/05/20 张彪 行包结算单建表语句 结束-- 

-- 2015/05/20 张彪 行包结算单明细表建表语句 开始--
@repeat{select count(*) from user_tables where table_name=upper('PACKDEPARTINVOICESDETAIL')}
create table PACKDEPARTINVOICESDETAIL
(
  ID                NUMBER(10) not null,
  PACKDEPARTINVOICESID  NUMBER(10) not null,
  SENDSTATIONID     NUMBER(10) not null,
  TOSTATIONID    NUMBER(10) not null,
  PIECES         NUMBER(3),
  SHIPPRICE      NUMBER(6,2),
  PACKFEE        NUMBER(6,2),
  HANDFEE        NUMBER(6,2),
  CUSTODIAL      NUMBER(6,2),
  TRANSITFEE     NUMBER(6,2),
  INSUREDAMOUNT  NUMBER(6,2),
  INSURANCEFEE   NUMBER(6,2),
  DELIVERYFEE    NUMBER(6,2),
  OTHERFEE       NUMBER(6,2),
  PACKPRICE      NUMBER(6,2),
  SERVICEFEE     NUMBER(6,2),
  TOTALFEE       NUMBER(6,2),
  BALANCEAMOUNT  NUMBER(6,2),
  CREATETIME        DATE default SYSDATE not null,
  CREATEBY          NUMBER(10) not null,
  UPDATETIME        DATE default SYSDATE not null,
  UPDATEBY          NUMBER(10) not null
)
tablespace TS_DEPARTINVOICESDETAIL
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
comment on table PACKDEPARTINVOICESDETAIL
  is '行包结算单/运量单明细表';
-- Add comments to the columns 
comment on column PACKDEPARTINVOICESDETAIL.PACKDEPARTINVOICESID
  is '行包结算单ID';
comment on column PACKDEPARTINVOICESDETAIL.SENDSTATIONID
  is '发车站ID';
comment on column PACKDEPARTINVOICESDETAIL.TOSTATIONID
  is '到达站ID';
comment on column PACKDEPARTINVOICESDETAIL.PIECES
  is '行包件数';
comment on column PACKDEPARTINVOICESDETAIL.SHIPPRICE
  is '托运费';
comment on column PACKDEPARTINVOICESDETAIL.PACKFEE
  is '包装费';
comment on column PACKDEPARTINVOICESDETAIL.HANDFEE
  is '装卸费';
comment on column PACKDEPARTINVOICESDETAIL.CUSTODIAL
  is '保管费';
comment on column PACKDEPARTINVOICESDETAIL.TRANSITFEE
  is '中转费';
comment on column PACKDEPARTINVOICESDETAIL.INSUREDAMOUNT
  is '保价金额';
comment on column PACKDEPARTINVOICESDETAIL.INSURANCEFEE
  is '保险费';
comment on column PACKDEPARTINVOICESDETAIL.DELIVERYFEE
  is '送货费';
comment on column PACKDEPARTINVOICESDETAIL.OTHERFEE
  is '其他费用';
comment on column PACKDEPARTINVOICESDETAIL.PACKPRICE
  is '代收货款';
comment on column PACKDEPARTINVOICESDETAIL.SERVICEFEE
  is '服务费';
comment on column PACKDEPARTINVOICESDETAIL.TOTALFEE
  is '合计金额';
comment on column PACKDEPARTINVOICESDETAIL.BALANCEAMOUNT
  is '结算金额';

@repeat{select count(1) from user_constraints t where t.table_name = upper('PACKDEPARTINVOICESDETAIL') and t.constraint_type = 'P' }

alter table PACKDEPARTINVOICESDETAIL
  add constraint PK_PACKDEPARTINVOICESDETAIL primary key (ID)
  using index 
  tablespace TS_DEPARTINVOICESDETAIL
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
-- 2015/05/20 张彪 行包结算单明细表建表语句 结束-- 

-- 2015/05/20 张彪 行包与行包结算单关系建表语句 开始--
-- Create table
@repeat{select count(*) from user_tables where table_name=upper('PACKDEPARTINVOICESPACK')}
create table PACKDEPARTINVOICESPACK
(
  ID                    NUMBER(10) not null,
  PACKID          NUMBER(10) not null,
  PACKDEPARTINVOICESID NUMBER(10) not null,
  CREATETIME            DATE default SYSDATE not null,
  CREATEBY              NUMBER(10) not null,
  UPDATETIME            DATE default SYSDATE not null,
  UPDATEBY              NUMBER(10) not null
)
tablespace TS_CENTER
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

comment on table PACKDEPARTINVOICESPACK
  is '行包与行包结算单关系表';
-- Create/Recreate primary, unique and foreign key constraints 

@repeat{select count(1) from user_constraints t where t.table_name = upper('PACKDEPARTINVOICESPACK') and t.constraint_type = 'P' }
alter table PACKDEPARTINVOICESPACK
  add constraint PKPACKDEPARTINVOICESPACK primary key (ID)
  using index 
  tablespace TS_CENTER
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

-- Create/Recreate indexes 
@repeat{select count(*) from user_indexes where Index_Name=upper('IDXPACKDEPID')}
create index IDXPACKDEPID on PACKDEPARTINVOICESPACK (PACKDEPARTINVOICESID)
  tablespace TS_CENTER
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
@repeat{select count(*) from user_indexes where Index_Name=upper('IDXPACKID')}
create index IDXPACKID on PACKDEPARTINVOICESPACK (PACKID)
  tablespace TS_CENTER
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
-- 2015/05/20 张彪 行包与行包结算单关系建表语句 结束--

-- 2015/05/20 张彪 行包缴款明细表建表语句 开始--
-- Create table
@repeat{select count(*) from user_tables where table_name=upper('PACKTTURNOVERDETAIL')}
create table PACKTTURNOVERDETAIL
(
  ID              NUMBER(10) not null,
  PACKTTURNOVERID NUMBER(10),
  MONEYDATE       DATE not null,
  SELLBY          NUMBER(10) not null,
  TICKETSTARTNO   VARCHAR2(20) default '0' not null,
  TICKETENDNO     VARCHAR2(20) default '0' not null,
  TURNOVERTIME    DATE,
  AUDITTIME       DATE,
  SENDPACKS       NUMBER(6),
  SENDPACKAMOUNT  NUMBER(10,2),
  PICKUPS         NUMBER(6),
  PICKUPAMOUNT    NUMBER(10,2),
  MONEYPAYABLE    NUMBER(10,2),
  ISTURNOVER      NUMBER(1) default 0 not null,
  ISAUDIT         NUMBER(1) default 0 not null,
  BATCHNO         VARCHAR2(30) default 0,
  SHIPPRICE       NUMBER(6,2),
  PACKFEE         NUMBER(6,2),
  UNLOADFEE       NUMBER(6,2),
  HANDFEE         NUMBER(6,2),
  CUSTODIAL       NUMBER(6,2),
  TRANSITFEE      NUMBER(6,2),
  INSUREDAMOUNT   NUMBER(8,2),
  INSURANCEFEE    NUMBER(6,2),
  INSURANCE       NUMBER(6,2),
  DELIVERYFEE     NUMBER(6,2),
  SERVICEFEE      NUMBER(6,2),
  OTHERFEE        NUMBER(6,2),
  PACKPRICE       NUMBER(8,2),
  SYNCCODE        VARCHAR2(60),
  ORGID           NUMBER(10),
  DATAFROM        VARCHAR2(10) default 0,
  CREATETIME      DATE default SYSDATE not null,
  CREATEBY        NUMBER(10) not null,
  UPDATETIME      DATE default SYSDATE not null,
  UPDATEBY        NUMBER(10) not null
)
tablespace TS_CENTER
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
-- Add comments to the table 
comment on table PACKTTURNOVERDETAIL
  is '行包缴款明细表';
-- Add comments to the columns 
comment on column PACKTTURNOVERDETAIL.PACKTTURNOVERID
  is '缴款id';
comment on column PACKTTURNOVERDETAIL.MONEYDATE
  is '票款日期';
comment on column PACKTTURNOVERDETAIL.SELLBY
  is '办理员id';
comment on column PACKTTURNOVERDETAIL.TICKETSTARTNO
  is '缴款起始票号';
comment on column PACKTTURNOVERDETAIL.TICKETENDNO
  is '缴款截止票号';
comment on column PACKTTURNOVERDETAIL.TURNOVERTIME
  is '缴款时间';
comment on column PACKTTURNOVERDETAIL.AUDITTIME
  is '审核时间';
comment on column PACKTTURNOVERDETAIL.SENDPACKS
  is '受理件数';
comment on column PACKTTURNOVERDETAIL.SENDPACKAMOUNT
  is '受理金额';
comment on column PACKTTURNOVERDETAIL.PICKUPS
  is '提领件数';
comment on column PACKTTURNOVERDETAIL.PICKUPAMOUNT
  is '提领金额';
comment on column PACKTTURNOVERDETAIL.MONEYPAYABLE
  is '应缴款';
comment on column PACKTTURNOVERDETAIL.ISTURNOVER
  is '是否已缴款';
 comment on column PACKTTURNOVERDETAIL.ISAUDIT
  is '是否已审核';
comment on column PACKTTURNOVERDETAIL.BATCHNO
  is '批次号';
comment on column PACKTTURNOVERDETAIL.SHIPPRICE
  is '托运费';
comment on column PACKTTURNOVERDETAIL.PACKFEE
  is '包装费';
comment on column PACKTTURNOVERDETAIL.UNLOADFEE
  is '到货装卸费';
comment on column PACKTTURNOVERDETAIL.HANDFEE
  is '装卸费';
comment on column PACKTTURNOVERDETAIL.CUSTODIAL
  is '保管费';
comment on column PACKTTURNOVERDETAIL.TRANSITFEE
  is '中转费';
comment on column PACKTTURNOVERDETAIL.INSUREDAMOUNT
  is '保价金额';
comment on column PACKTTURNOVERDETAIL.INSURANCEFEE
  is '保价费';
comment on column PACKTTURNOVERDETAIL.INSURANCE
  is '保险费';
comment on column PACKTTURNOVERDETAIL.DELIVERYFEE
  is '送货费';
comment on column PACKTTURNOVERDETAIL.SERVICEFEE
  is '服务费';
comment on column PACKTTURNOVERDETAIL.OTHERFEE
  is '其他费用';
comment on column PACKTTURNOVERDETAIL.PACKPRICE
  is '代收货款';
comment on column PACKTTURNOVERDETAIL.SYNCCODE
  is '全局同步编码';
comment on column PACKTTURNOVERDETAIL.DATAFROM
  is '0：发货，1：到货';
-- Create/Recreate primary, unique and foreign key constraints 
@repeat{select count(1) from user_constraints t where t.table_name = upper('PACKTTURNOVERDETAIL') and t.constraint_type = 'P' }
alter table PACKTTURNOVERDETAIL
  add constraint PK_PACKTTURNOVERDETAIL primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
-- 2015/05/20 张彪 行包缴款明细表建表语句 结束--

-- 2015/05/20 张彪 行包缴款表结构修改语句 开始-- 
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('packtturnover') AND COLUMN_NAME = upper('packstrike') }
alter table packtturnover add packstrike number(10,2);
comment on column packtturnover.packstrike is '行包冲账';
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('packtturnover') AND COLUMN_NAME = upper('SENDPACKAMOUNT') AND nullable = 'N' }
alter table packtturnover modify SENDPACKAMOUNT number(10,2) null;
-- 2015/05/20 张彪 行包缴款表结构修改语句 结束--

-- 2015/05/20 张彪 行包表结构修改语句 开始--
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('pack') AND COLUMN_NAME = upper('balancestatus') }
alter table pack add balancestatus varchar2(10) default 0;
comment on column PACK.BALANCESTATUS
  is '0：未结算、1：已结算';
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('pack') AND COLUMN_NAME = upper('GOODSSTATUS') }
alter table pack add GOODSSTATUS varchar2(10) default 0;
comment on column PACK.BALANCESTATUS
  is '0：完好、1：破损、2：打湿';
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('pack') AND COLUMN_NAME = upper('vehiclereportid') }
alter table pack add vehiclereportid number(10);
comment on column PACK.VEHICLEREPORTID
  is '车辆报到表id';
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('pack') AND COLUMN_NAME = upper('RECYCLESTATUS') }
ALTER TABLE PACK ADD RECYCLESTATUS VARCHAR2(10) DEFAULT '0';
comment on column PACK.RECYCLESTATUS  is '回收状态：0未回收 1已回收';


@repeat{SELECT 1-COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('pack') AND COLUMN_NAME = upper('CONSIGNEE') and nullable = 'N'}
alter table pack modify CONSIGNEE null;


@repeat{SELECT 1-COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('pack') AND COLUMN_NAME = upper('CONSIGNEEPHONE') and nullable = 'N'}
alter table pack modify CONSIGNEEPHONE null;
-- 2015/05/20 张彪 行包表结构修改语句 结束--

-- 2015/05/26 赵怀虎 行包表结构修改语句 结束--
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('pack') AND COLUMN_NAME = upper('ENTRYPACKER') }
alter table pack add ENTRYPACKER varchar2(100);
comment on column PACK.ENTRYPACKER is '到货入仓操作员';
-- 2015/05/26 赵怀虎 行包表结构修改语句 结束--

-- 2015/03/05 林洪起 行包单表结构修改语句 开始-- 
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('pack') AND COLUMN_NAME = upper('collectstatus') }
ALTER TABLE pack ADD collectstatus VARCHAR2(10) DEFAULT '0';
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('pack') AND COLUMN_NAME = upper('collectby') }
ALTER TABLE pack ADD collectby NUMBER(10);
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('pack') AND COLUMN_NAME = upper('collectdate') }
ALTER TABLE pack ADD collectdate DATE;

@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('pack') AND COLUMN_NAME = upper('recycleby') }
ALTER TABLE pack ADD recycleby NUMBER(10);
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('pack') AND COLUMN_NAME = upper('recycledate') }
ALTER TABLE pack ADD recycledate DATE;
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('pack') AND COLUMN_NAME = upper('collectbalanceid') }
ALTER TABLE pack ADD collectbalanceid NUMBER(10);
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('pack') AND COLUMN_NAME = upper('collectmoney') }
ALTER TABLE pack ADD collectmoney NUMBER(10,2);

comment on column PACK.collectstatus  is '代售货款:0未代收 1已代收 2已回收';
comment on column PACK.collectby  is '代收人';
comment on column PACK.collectdate  is '代收日期';
comment on column PACK.recycleby  is '回收人';
comment on column PACK.recycledate  is '回收日期';
comment on column PACK.collectbalanceid  is '代收货款结算单ID';
comment on column PACK.collectmoney  is '代收金额/回收金额';
-- 2015/03/05 林洪起 行包单表结构修改语句 结束--

--营收缴款表新增字段改签数  同步503版本的营收缴款新增改签数问题
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('TICKETTURNOVERDETAIL') AND COLUMN_NAME = upper('CHANGEnum') }
alter table TICKETTURNOVERDETAIL add CHANGEnum NUMBER(9) default 0;
--end
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('PACKINTEGRATERULE') AND COLUMN_NAME = upper('CLIENTTYPE') }
alter table PACKINTEGRATERULE add CLIENTTYPE VARCHAR2(10);
--2015/06/03  4.5版本 升级缺少的字段
--登陆缺少的脚本
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('department') AND COLUMN_NAME = upper('isactive') }
alter table department add isactive number(1) default 1;
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('station') AND COLUMN_NAME = upper('distance') }
alter table station add distance number(10) default 0;
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('ticketoutlets') AND COLUMN_NAME = upper('isprint') }
alter table ticketoutlets add isprint number(1) default 0;
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('steward') AND COLUMN_NAME = upper('FINGERSTR1') }
alter table steward add (FINGERSTR1 VARCHAR2(2000) ,FINGERSTR2 VARCHAR2(2000) ,FINGERSTR3 VARCHAR2(2000));
--end
@repeat{select count(*) from user_tables where table_name=upper('SCHEDULEDISCOUNTPRICE') }
create table SCHEDULEDISCOUNTPRICE
(
  ID              NUMBER(10) not null,
  SCHEDULEID      NUMBER(10) not null,
  STARTDATE       DATE not null,
  ENDDATE         DATE not null,
  DEPARTSTATIONID NUMBER(10) not null,
  REACHSTATIONID  NUMBER(10) not null,
  PRICE           NUMBER(10,2) not null,
  SALENUM         NUMBER(3) default 1 not null,
  ORGID           NUMBER(10) not null,
  CREATETIME      DATE default SYSDATE not null,
  CREATEBY        NUMBER(10) not null,
  UPDATETIME      DATE default SYSDATE not null,
  UPDATEBY        NUMBER(10) not null,
  REFERENCEPRICE  NUMBER(10,2) default 0 not null
);
comment on table SCHEDULEDISCOUNTPRICE
  is '优惠票价设置';
-- Add comments to the columns 
comment on column SCHEDULEDISCOUNTPRICE.SCHEDULEID
  is '班次ID';
comment on column SCHEDULEDISCOUNTPRICE.STARTDATE
  is '开始日期';
comment on column SCHEDULEDISCOUNTPRICE.ENDDATE
  is '结束日期';
comment on column SCHEDULEDISCOUNTPRICE.DEPARTSTATIONID
  is '发车站';
comment on column SCHEDULEDISCOUNTPRICE.REACHSTATIONID
  is '到达站';
comment on column SCHEDULEDISCOUNTPRICE.PRICE
  is '票价';
comment on column SCHEDULEDISCOUNTPRICE.SALENUM
  is '可售张数';
comment on column SCHEDULEDISCOUNTPRICE.ORGID
  is '机构ID';
comment on column SCHEDULEDISCOUNTPRICE.REFERENCEPRICE
  is '参考票价';
-- Create/Recreate primary, unique and foreign key constraints 
alter table SCHEDULEDISCOUNTPRICE
  add constraint PK_SCHDISCOUNTPRICE primary key (ID)
  
--线路停靠点缺字段 
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('routestop') AND COLUMN_NAME = upper('isdepart') }
alter table routestop add (isdepart number(1) default 0 not null );  
--班次表新增字段 
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('SCHEDULE') AND COLUMN_NAME = upper('STARTSTATIONPRICE') }
alter table SCHEDULE add STARTSTATIONPRICE number(10,2);
comment on column SCHEDULE.STARTSTATIONPRICE is '始发站票价';
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('SCHEDULE') AND COLUMN_NAME = upper('ENDSTATION') }
alter table SCHEDULE add ENDSTATION varchar2(300);
comment on column SCHEDULE.ENDSTATION is '终到车站';
--菜单表缺少字段
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('MENU') AND COLUMN_NAME = upper('CLAZZ') }
alter table MENU add   CLAZZ   VARCHAR2(100);
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('MENU') AND COLUMN_NAME = upper('URL') }
alter table MENU add   URL   VARCHAR2(100);
comment on column MENU.URL is '菜单url';
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('MENU') AND COLUMN_NAME = upper('ICON') }
alter table MENU add   ICON   VARCHAR2(100);
comment on column MENU.ICON is '菜单图标url';
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('MENU') AND COLUMN_NAME = upper('CLICKNUM') }
alter table MENU add   CLICKNUM   NUMBER(10) default 0;
comment on column MENU.CLICKNUM is '点击数';
--安检表新增驾驶员ID
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('Securitycheck') AND COLUMN_NAME = upper('driverid') }
alter table Securitycheck add driverid number(10);
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('Securitycheck') AND COLUMN_NAME = upper('RECHECKTIME') } 
alter table SECURITYCHECK add RECHECKTIME DATE ;
comment on column SECURITYCHECK.RECHECKTIME is '复检日期';

@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('packdepartinvoices') AND COLUMN_NAME = upper('ISAUDIT')}
alter table packdepartinvoices add ISAUDIT NUMBER(1) default 0 not null;
comment on column packdepartinvoices.ISAUDIT is '是否已审核';
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('packdepartinvoices') AND COLUMN_NAME = upper('SELLBY') }
alter table packdepartinvoices add SELLBY NUMBER(10);
comment on column packdepartinvoices.SELLBY is '审核人';
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('packdepartinvoices') AND COLUMN_NAME = upper('AUDITTIME') }
alter table packdepartinvoices add AUDITTIME DATE;
comment on column packdepartinvoices.AUDITTIME is '审核时间';

--新增 取票操作日志表 begin --
-- Create table
@repeat{select count(*) from user_tables where table_name=upper('TAKETICKETLOG') }
-- Create table
create table TAKETICKETLOG
(
  ID                NUMBER(10) not null,
  SELLORGNAME       VARCHAR2(50),
  SCHORGNAME        VARCHAR2(50),
  TICKETNO          VARCHAR2(20),
  DEPARTDATE        DATE,
  DEPARTTIME        VARCHAR2(5),
  SCHCODE           VARCHAR2(20),
  DEPARTSTATIONNAME VARCHAR2(50),
  REACHSTATIONNAME  VARCHAR2(50),
  TICKETTYPENAME    VARCHAR2(20),
  TICKETPRICE       NUMBER(10,2),
  SEATNO            NUMBER(4),
  ORDERNO           VARCHAR2(50),
  PASSWORD          VARCHAR2(50),
  CUSTOMERNAME      VARCHAR2(20),
  CERTIFICATENO     VARCHAR2(50),
  MOBILEPHONE       VARCHAR2(20),
  SELLTIME          DATE,
  TAKETIME          DATE not null,
  TAKEWAY           VARCHAR2(10) not null,
  STATUS            VARCHAR2(10) not null,
  OPERATORNAME      VARCHAR2(20) not null,
  OPERATORGNAME     VARCHAR2(50) not null,
  TICKETOUTLETSNAME VARCHAR2(50) not null,
  TAKECOMPUTE       VARCHAR2(50),
  CREATETIME        DATE default SYSDATE not null,
  CREATEBY          NUMBER(10) default 0 not null,
  UPDATETIME        DATE default SYSDATE not null,
  UPDATEBY          NUMBER(10) not null,
  REMARK            VARCHAR2(200)
);
-- Add comments to the columns 
comment on column TAKETICKETLOG.SELLORGNAME
  is '售票机构';
comment on column TAKETICKETLOG.SCHORGNAME
  is '班次机构';
comment on column TAKETICKETLOG.TICKETNO
  is '票号';
comment on column TAKETICKETLOG.DEPARTDATE
  is '发车日期';
comment on column TAKETICKETLOG.DEPARTTIME
  is '发车时间';
comment on column TAKETICKETLOG.SCHCODE
  is '班次号';
comment on column TAKETICKETLOG.DEPARTSTATIONNAME
  is '上车站点';
comment on column TAKETICKETLOG.REACHSTATIONNAME
  is '到达站';
comment on column TAKETICKETLOG.TICKETTYPENAME
  is '票种';
comment on column TAKETICKETLOG.TICKETPRICE
  is '票价';
comment on column TAKETICKETLOG.SEATNO
  is '座位号';
comment on column TAKETICKETLOG.ORDERNO
  is '订单号';
comment on column TAKETICKETLOG.PASSWORD
  is '取票密码';
comment on column TAKETICKETLOG.CUSTOMERNAME
  is '取票人';
comment on column TAKETICKETLOG.CERTIFICATENO
  is '身份证号';
comment on column TAKETICKETLOG.MOBILEPHONE
  is '手机号';
comment on column TAKETICKETLOG.SELLTIME
  is '购票时间';
comment on column TAKETICKETLOG.TAKETIME
  is '取票时间';
comment on column TAKETICKETLOG.TAKEWAY
  is '取票方式';
comment on column TAKETICKETLOG.STATUS
  is '操作状态';
comment on column TAKETICKETLOG.OPERATORNAME
  is '操作员姓名';
comment on column TAKETICKETLOG.OPERATORGNAME
  is '取票机构';
comment on column TAKETICKETLOG.TICKETOUTLETSNAME
  is '取票点';
comment on column TAKETICKETLOG.TAKECOMPUTE
  is '取票机器';
comment on column TAKETICKETLOG.REMARK
  is '备注';
-- Create/Recreate primary, unique and foreign key constraints 
@repeat{select count(*) from user_constraints t where t.table_name = 'TAKETICKETLOG' and t.constraint_type = 'P' }
alter table TAKETICKETLOG
  add constraint PKTAKETICKETLOGID primary key (ID);
-- Create/Recreate indexes 
@repeat{select count(*) from user_indexes t where t.table_name = 'TAKETICKETLOG' and t.index_name = 'IDX_TAKETICKET' }
create index IDX_TAKETICKET on TAKETICKETLOG (DEPARTDATE);
@repeat{select count(*) from user_indexes t where t.table_name = 'TAKETICKETLOG' and t.index_name = 'IDX_TAKETIMELOG' }  
create index IDX_TAKETIMELOG on TAKETICKETLOG (TAKETIME);
-- end  -- 
---新增 用户售票点表 start2015年6月10日 17:14:14--------------
@repeat{select count(*) from user_tables where table_name=upper('USERTICKETOUTLETS') }
create table USERTICKETOUTLETS
(
  ID              NUMBER(10) not null,
  USERINFOID      NUMBER(10) not null,
  TICKETOUTLETSID NUMBER(10) not null,
  CREATETIME      DATE default SYSDATE not null,
  CREATEBY        NUMBER(10) not null,
  UPDATETIME      DATE default SYSDATE not null,
  UPDATEBY        NUMBER(10) not null
);
-- Add comments to the table 
comment on table USERTICKETOUTLETS
  is '用户售票点表';
-- Create/Recreate primary, unique and foreign key constraints 
@repeat{select count(*) from user_constraints t where t.table_name = 'USERTICKETOUTLETS' and t.constraint_type = 'P' }
alter table USERTICKETOUTLETS
  add constraint PKUSERTICKETOUTLETS primary key (ID);
-- end --


--开始--添加检票闸机允许重复刷票进行检票的最大次数--2015-06-05--杨志文
@repeat{SELECT COUNT(*) FROM PARAMETER where ID=3105}
insert into parameter 
(ID,  TYPE,  CODE,  VALUE,  ISVISIBLE,  ISEDITABLE,  REMARK,  UPDATETIME,  UPDATEBY,  UNIT)
values('3105','31','3105','3','1','1','检票闸机允许重复刷票进行检票的最大次数',sysdate,'1158013','次数');
--结束--添加检票闸机允许重复刷票进行检票的最大次数--2015-06-05--杨志文
- 2015-06-06 17:47:58
--表ENTRYTICKET 的索引
@repeat{select 1-count(*) from user_indexes t where  Index_Name=upper('IDX_TICKET2NO') and t.uniqueness='UNIQUE'}
drop index IDX_TICKET2NO;
@repeat{select count(*) from user_indexes t where  Index_Name=upper('IDX_TICKET2NO')}
create index IDX_TICKET2NO on ENTRYTICKET (TICKETNO);
 
@repeat{select count(*) from user_constraints t where t.table_name = 'INSURETYPEDISTANCE' and t.constraint_type = 'P' }
alter table INSURETYPEDISTANCE add constraint PK_INSURETYPEDISTANCE primary key (ID);

--begin
-- Create table 基础票价
@repeat{select count(*) from user_tables where table_name=upper('STANDARDBASEPRICE') }
create table STANDARDBASEPRICE
(
  ID             NUMBER(10) not null,
  ROUTEID        NUMBER(10) not null,
  FROMSTATIONID  NUMBER(10) not null,
  REACHSTATIONID NUMBER(10) not null,
  ORGID          NUMBER(10) not null,
  BASEPRICE      NUMBER(10,2) default 0 not null
)
tablespace TS_CENTER
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
-- Add comments to the columns 
comment on column STANDARDBASEPRICE.ID
  is 'id';
comment on column STANDARDBASEPRICE.ROUTEID
  is '线路';
comment on column STANDARDBASEPRICE.FROMSTATIONID
  is '上车站';
comment on column STANDARDBASEPRICE.REACHSTATIONID
  is '到达站';
comment on column STANDARDBASEPRICE.ORGID
  is '所属机构';
comment on column STANDARDBASEPRICE.BASEPRICE
  is '基础票价';
-- Create/Recreate primary, unique and foreign key constraints 
@repeat{select count(*) from user_constraints t where t.table_name = 'STANDARDBASEPRICE' and t.constraint_type = 'P' }
alter table STANDARDBASEPRICE
  add constraint STANDARDBASEPRICEPK primary key (ID)
  using index 
  tablespace TS_CENTER
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
 -- Create table 保险类型票价
@repeat{select count(*) from user_tables where table_name=upper('INSURANCETYPEFARES') } 
create table INSURANCETYPEFARES
(
  ID           NUMBER(10) not null,
  ORGID        NUMBER(10) not null,
  INSURETYPEID NUMBER(10) not null,
  FROMPRICE    NUMBER(10) not null,
  ENDPRICE     NUMBER(10) not null,
  CREATETIME   DATE default SYSDATE not null,
  CREATEBY     NUMBER(10) not null,
  UPDATETIME   DATE default SYSDATE not null,
  UPDATEBY     NUMBER(10) not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
-- Add comments to the columns 
comment on column INSURANCETYPEFARES.ORGID
  is '所属车站id';
  --end