--begin    2017-2-06  修改结算单 vehicleno字段长度，能适应1000张以上的结算单结算
@repeat{SELECT 1-COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('balance') AND COLUMN_NAME = upper('vehicleno')  }
alter table balance modify vehicleno VARCHAR2(4000);
--end
--begin 2017年2月9日 18:31:01 孙越 --
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('USERINFO') AND COLUMN_NAME = upper('lastchangepasswordtime')}
alter table USERINFO add lastchangepasswordtime date default sysdate not null;
comment on column USERINFO.lastchangepasswordtime
  is '上次修改密码时间';
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('USERINFO') AND COLUMN_NAME = upper('defeatcount')}
alter table USERINFO add defeatcount number(10) default 0 not null;
comment on column USERINFO.defeatcount
  is '登录失败次数';
--end--
  
--begin zhaohuaihu 2017-02-22 增加 主票-携童票售票记录表
@repeat{select count(*) from user_tables where table_name=upper('CARRYCHILD') }
create table CARRYCHILD
(
  ID            NUMBER(10) not null,
  QTICKETID     NUMBER(10) not null,
  CHILDTICKETID NUMBER(10) not null,
  CREATETIME    DATE not null,
  CREATEBY      NUMBER(10) not null,
  UPDATETIME    DATE not null,
  UPDATEBY      NUMBER(10) not null,
  REMARK        VARCHAR2(300)
);
-- Add comments to the table
comment on table CARRYCHILD
  is '主票-携童票售票记录表';
-- Add comments to the columns 
comment on column CARRYCHILD.QTICKETID
  is '全票(主票)id';
comment on column CARRYCHILD.CHILDTICKETID
  is '携童票id';
comment on column CARRYCHILD.REMARK
  is '备注';
@repeat{select count(*) from user_constraints t where t.table_name = 'CARRYCHILD' and t.constraint_type = 'P' }
alter table CARRYCHILD add constraint PK_CARRYCHILD primary key (ID);
@repeat{select count(*) from user_indexes  u where u.index_name = upper('IDX_KIDCHILDTICKETID')}
create unique index IDX_KIDCHILDTICKETID on CARRYCHILD (CHILDTICKETID);
@repeat{select count(*) from user_indexes  u where u.index_name = upper('IDX_KIDPRIMARYTICKETID')}
create unique index IDX_KIDPRIMARYTICKETID on CARRYCHILD (QTICKETID);
--end

--begin zhaohuaihu 2017-03-02 修改CUSTOMER姓名长度为200(新疆名字较长)
@repeat{SELECT COUNT(*) - 1 FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('CUSTOMER') AND COLUMN_NAME = upper('NAME') }
alter table CUSTOMER modify NAME VARCHAR2(200);
--end
--begin zhaohuaihu 2017-02-22 增加 主票-携童票售票记录表
@repeat{select count(*) from user_tables where table_name=upper('CARRYCHILD') }
create table CARRYCHILD
(
  ID            NUMBER(10) not null,
  QTICKETID     NUMBER(10) not null,
  CHILDTICKETID NUMBER(10) not null,
  CREATETIME    DATE not null,
  CREATEBY      NUMBER(10) not null,
  UPDATETIME    DATE not null,
  UPDATEBY      NUMBER(10) not null,
  REMARK        VARCHAR2(300)
);
-- Add comments to the table
comment on table CARRYCHILD
  is '主票-携童票售票记录表';
-- Add comments to the columns 
comment on column CARRYCHILD.QTICKETID
  is '全票(主票)id';
comment on column CARRYCHILD.CHILDTICKETID
  is '携童票id';
comment on column CARRYCHILD.REMARK
  is '备注';
@repeat{select count(*) from user_constraints t where t.table_name = 'CARRYCHILD' and t.constraint_type = 'P' }
alter table CARRYCHILD add constraint PK_CARRYCHILD primary key (ID);
@repeat{select count(*) from user_indexes  u where u.index_name = upper('IDX_KIDCHILDTICKETID')}
create unique index IDX_KIDCHILDTICKETID on CARRYCHILD (CHILDTICKETID);
@repeat{select count(*) from user_indexes  u where u.index_name = upper('IDX_KIDPRIMARYTICKETID')}
create unique index IDX_KIDPRIMARYTICKETID on CARRYCHILD (QTICKETID);
--end

@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('driver') AND COLUMN_NAME = upper('sincerityauditingdate')}
alter table driver add sincerityauditingdate DATE default sysdate;    
-- Add comments to the columns 
comment on column driver.sincerityauditingdate
  is '诚信考核记录时间';
  
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('driver') AND COLUMN_NAME = upper('continuingeducationdate')}
alter table driver add continuingeducationdate DATE default sysdate;    
-- Add comments to the columns 
comment on column driver.continuingeducationdate
  is '教育记录时间';
  
@repeat{SELECT 1-COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('CHECKTICKETLOG') AND COLUMN_NAME = upper('CUSTOMERNAME')}
alter table CHECKTICKETLOG modify CUSTOMERNAME VARCHAR2(100);  

--退票模块，改签费率。以及退票费率逻辑修改
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('ticketsign') AND COLUMN_NAME = upper('SIGNRATE')}
alter table ticketsign add SIGNRATE NUMBER(10,2) default 0;
comment on column ticketsign.SIGNRATE
  is '签票费率';
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('ticketsign') AND COLUMN_NAME = upper('ISRATE')}
alter table ticketsign add ISRATE NUMBER(1);
comment on column ticketsign.ISRATE
  is '是否费率,1为费率、0为固定值';
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('ticketreturn') AND COLUMN_NAME = upper('rate')}
alter table ticketreturn add rate NUMBER(4,2) default 0;
--end


--指纹报班暂存表
@repeat{select count(*) from user_tables where table_name=upper('fingercache')}
create table fingercache
(
  ID                           NUMBER(12) not null,
  vehicleid                    NUMBER(12) not null,
  driverorstewardid            NUMBER(12) not null,
  driverorstewardname          VARCHAR2(50) not null,
  driverorstewardmark          VARCHAR2(2) not null,
  savedate                     DATE  not null,
  ORGID            NUMBER(10) not null,
  CREATETIME       DATE default SYSDATE not null,
  CREATEBY         NUMBER(10) not null,
  UPDATETIME       DATE default SYSDATE not null,
  UPDATEBY         NUMBER(10) not null
);
-- Add comments to the table 
comment on table fingercache
  is '指纹报班暂存表';
-- Add comments to the columns 
comment on column fingercache.vehicleid
  is '车辆id';
comment on column fingercache.driverorstewardid
  is '驾驶员或乘务员id';
comment on column fingercache.driverorstewardname
  is '驾驶员或乘务员姓名';
comment on column fingercache.driverorstewardmark
  is '驾驶员或乘务员标记，1为驾驶员，2为乘务员';
comment on column fingercache.savedate
  is '保存日期';
@repeat{select count(*) from user_constraints t where t.table_name = upper('fingercache') and t.constraint_type = 'P' }
alter table fingercache add constraint PK_fingercache primary key (ID);
--end
--begin custormer 增加isred字段
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('CUSTOMER') AND COLUMN_NAME = upper('ISRED')}
alter table CUSTOMER add ISRED NUMBER(1) default 0;
-- Add comments to the columns 
comment on column CUSTOMER.ISRED
  is '是否红名单0：不是 、1：是';
 --end
  
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('PACKTTURNOVERDETAIL') AND COLUMN_NAME = upper('RETURNNUM')}  
alter table PACKTTURNOVERDETAIL add RETURNNUM NUMBER(6) default 0;

@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('ticketsell') AND COLUMN_NAME = upper('returnfeemode')}  
Alter table ticketsell add  returnfeemode  VARCHAR2(1) default 0 ; 
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('ticketreturn') AND COLUMN_NAME = upper('returnfeemode')}  
Alter table ticketreturn add  returnfeemode  VARCHAR2(1) default 0 ;  
--标准站点导入 张清风 start
@repeat{select count(*) from user_tables where table_name=upper('STATIONSTANDARD')}
-- Create table
create table STATIONSTANDARD
(
  id             NUMBER(10) not null,
  code           VARCHAR2(20) not null,
  province       VARCHAR2(20),
  city           VARCHAR2(50),
  area           VARCHAR2(50),
  stationname    VARCHAR2(100),
  stationaddress VARCHAR2(200),
  createtime     DATE default SYSDATE not null,
  createby       NUMBER(10) not null,
  updatetime     DATE default SYSDATE not null,
  updateby       NUMBER(10) not null,
  name           VARCHAR2(30)
);

-- Add comments to the table 
comment on table STATIONSTANDARD
  is '站点标准表';
-- Add comments to the columns 
comment on column STATIONSTANDARD.id
  is '主键';
comment on column STATIONSTANDARD.code
  is '标准站点编码';
comment on column STATIONSTANDARD.province
  is '所属省';
comment on column STATIONSTANDARD.city
  is '所属市';
comment on column STATIONSTANDARD.area
  is '所属区';
comment on column STATIONSTANDARD.stationname
  is '对应车站名称';
comment on column STATIONSTANDARD.stationaddress
  is '对应车站详细地址';
comment on column STATIONSTANDARD.name
  is '标准站点名称';
-- Create/Recreate primary, unique and foreign key constraints 
@repeat{select count(*) from user_constraints t where t.table_name = 'STATIONSTANDARD' and t.constraint_type = 'P' }
alter table STATIONSTANDARD
  add primary key (ID);
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('STATION') AND COLUMN_NAME = upper('standradid')}  
alter table station add standradid number(10);
comment on column STATION.standradid
  is '标准站点id';
--标准站点导入 张清风 end


-- begin 增加结算单补录票号(结算单号和发车日期索引)  zhaomingliang
@repeat{select count(*) from user_indexes  u where u.index_name = upper('IDX_OTHER_DEPARTDATE')}
create index IDX_OTHER_DEPARTDATE on DEPARTINVOICESOTHER (DEPARTDATE);
@repeat{select count(*) from user_indexes  u where u.index_name = upper('IDX_OTHER_DEPARTINVOICESNO')}
create index IDX_OTHER_DEPARTINVOICESNO on DEPARTINVOICESOTHER (DEPARTINVOICESNO);
--end

-- Add/modify columns 
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('VEHICLE') AND COLUMN_NAME = upper('technialstartdate')}  
alter table VEHICLE add technialstartdate date;
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('VEHICLE') AND COLUMN_NAME = upper('technialenddate')}  
alter table VEHICLE add technialenddate date;
-- Add comments to the columns 
comment on column VEHICLE.technialstartdate
  is '技术等级评定开始日期';
comment on column VEHICLE.technialenddate
  is '技术等级评定结束日期';
@repeat{SELECT COUNT(*)-1 FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('VEHICLE') AND COLUMN_NAME = upper('nextmaintaindistance') and NULLABLE='Y'}  
alter table VEHICLE modify nextmaintaindistance not null;


@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('VEHICLEVIOLATION') AND COLUMN_NAME = upper('departinvoicesid')}  
alter table VEHICLEVIOLATION add departinvoicesid NUMBER(10);

@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('VEHICLEVIOLATION') AND COLUMN_NAME = upper('iscash')}  
alter table VEHICLEVIOLATION add iscash NUMBER(1) default 0;

comment on column VEHICLEVIOLATION.iscash
  is '现金罚款0:非现金1:现金';
