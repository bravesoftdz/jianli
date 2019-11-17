--20150703 mengjian 增加存放报表产生的临时表
@repeat{select count(*) from user_tables where table_name=upper('TMP_TABLE')}
create table TMP_TABLE
(
  id         NUMBER(10) not null,
  sessionid  VARCHAR2(60) not null,
  tablename  VARCHAR2(30) not null,
  createby   NUMBER(10) not null,
  createtime DATE default SYSDATE not null,
  userid     NUMBER(10) not null
)
tablespace TS_CENTER
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 128K
    next 1M
    minextents 1
    maxextents unlimited
  );
-- Add comments to the table 
comment on table TMP_TABLE
  is '临时表信息';
-- Add comments to the columns 
comment on column TMP_TABLE.id
  is 'ID';
comment on column TMP_TABLE.sessionid
  is 'sessionid';
comment on column TMP_TABLE.tablename
  is '临时表名';
comment on column TMP_TABLE.userid
  is '用户id';

  
--20150703 mengjian 
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('META_REFERENCE') AND COLUMN_NAME = upper('idfield')}  
alter table META_REFERENCE add idfield VARCHAR2(500);
comment on column META_REFERENCE.idfield
  is '提交字段';
  
  
--20150703 mengjian  添加报表动态扩展所需字段
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('META_SUBCOLUMN') AND COLUMN_NAME = upper('isdynamicadd')}  
alter table META_SUBCOLUMN add isdynamicadd NUMBER(1) default 0;
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('META_SUBCOLUMN') AND COLUMN_NAME = upper('dynamicaddsql')}  
alter table META_SUBCOLUMN add dynamicaddsql VARCHAR2(500);
-- Add comments to the columns 
comment on column META_SUBCOLUMN.isdynamicadd
  is '是否动态扩展,1表示横向动态扩展,0表示纵向扩展';
comment on column META_SUBCOLUMN.dynamicaddsql
  is '动态扩展列对应sql语句';
  
--2015年7月6日 10:44:49 孙越 添加车辆司机报道表 begin --
  -- Create table
@repeat{select count(*) from user_tables where table_name=upper('VEHICLEDRIVERREPORT') }  
create table VEHICLEDRIVERREPORT
(
  ID                 NUMBER(10) not null,
  VEHICLEREPORTID    NUMBER(10) not null,
  SCHEDULEID         NUMBER(10) not null,
  DEPARTDATE         DATE not null,
  REPORTTIME         DATE not null,
  VEHICLENO          VARCHAR2(20) not null,
  DRIVERNAME         VARCHAR2(20),
  DDRIVINGLICENSERES VARCHAR2(30),
  DQUALIFICATIONRES  VARCHAR2(30),
  VDRIVERLICENSERES  VARCHAR2(30),
  VWORKNORES         VARCHAR2(30),
  VROADNORES         VARCHAR2(30),
  DWORKNORES         VARCHAR2(30),
  VNOTENUM           VARCHAR2(30),
  RATIONSEATNUM      NUMBER(3) not null,
  ACTTICKETS         NUMBER(3),
  DRIVERSIGN         VARCHAR2(20),
  CLASSMEMBER        VARCHAR2(20),
  DISPATCHER         VARCHAR2(20),
  STEWARDNAME        VARCHAR2(20),
  ORGID              NUMBER(10) not null,
  CREATETIME         DATE default SYSDATE not null,
  CREATEBY           NUMBER(10) not null,
  UPDATETIME         DATE default SYSDATE not null,
  UPDATEBY           NUMBER(10) not null,
  DRIVERID           NUMBER(10),
  ISDEPARTED         NUMBER(1) default 0,
  SCHEDULEPLANID     NUMBER(10),
  DEPARTTIME         VARCHAR2(5)
)
partition by range (DEPARTDATE)
(
  partition VEH20150601 values less than (TO_DATE(' 2015-06-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')),
  partition VEH20151001 values less than (TO_DATE(' 2015-10-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')),
  partition VEH20160101 values less than (TO_DATE(' 2016-01-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')),
  partition VEH20160601 values less than (TO_DATE(' 2016-06-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')),
  partition VEH20161001 values less than (TO_DATE(' 2016-10-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')),
  partition VEH20170101 values less than (TO_DATE(' 2017-01-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')),
  partition VEH20170601 values less than (TO_DATE(' 2017-06-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')),
  partition VEH20171001 values less than (TO_DATE(' 2017-10-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')),
  partition VEH20180101 values less than (TO_DATE(' 2018-01-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')),
  partition VEH20180601 values less than (TO_DATE(' 2018-06-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')),
  partition VEH20181001 values less than (TO_DATE(' 2018-10-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')),
  partition VEH20190101 values less than (TO_DATE(' 2019-01-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')),
  partition VEH20190601 values less than (TO_DATE(' 2019-06-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')),
  partition VEH20191001 values less than (TO_DATE(' 2019-10-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')),
  partition VEH20200101 values less than (TO_DATE(' 2020-01-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')),
  partition VEH_OTHER values less than (MAXVALUE)
);
-- Add comments to the table 
comment on table VEHICLEDRIVERREPORT
  is '车辆发（应）班登记表';
-- Add comments to the columns 
comment on column VEHICLEDRIVERREPORT.DRIVERNAME
  is '驾驶员姓名';
comment on column VEHICLEDRIVERREPORT.DDRIVINGLICENSERES
  is '驾驶证';
comment on column VEHICLEDRIVERREPORT.DQUALIFICATIONRES
  is '从业资格证';
comment on column VEHICLEDRIVERREPORT.VDRIVERLICENSERES
  is '行驶证';
comment on column VEHICLEDRIVERREPORT.VWORKNORES
  is '道路运输证';
comment on column VEHICLEDRIVERREPORT.VROADNORES
  is '线路标志牌';
comment on column VEHICLEDRIVERREPORT.DWORKNORES
  is '上岗证';
comment on column VEHICLEDRIVERREPORT.VNOTENUM
  is '例检合格通知单';
comment on column VEHICLEDRIVERREPORT.RATIONSEATNUM
  is '核载人数';
comment on column VEHICLEDRIVERREPORT.ACTTICKETS
  is '实载人数';
comment on column VEHICLEDRIVERREPORT.DRIVERSIGN
  is '驾驶员签字';
comment on column VEHICLEDRIVERREPORT.CLASSMEMBER
  is '带班员签字';
comment on column VEHICLEDRIVERREPORT.DISPATCHER
  is '车辆调度员签字';
comment on column VEHICLEDRIVERREPORT.ORGID
  is '添加者所属组织机构id';
-- Create/Recreate primary, unique and foreign key constraints 
@repeat{select count(*) from user_constraints t where t.table_name = 'VEHICLEDRIVERREPORT' and t.constraint_type = 'P' }
alter table VEHICLEDRIVERREPORT
  add constraint PKVEHICLEDRIVERREPORT primary key (ID);
 -- end --
   -----begin  姜蓥瑞  2015-7-11 18:28  补行包缴款，行包差错明细表 --- 
  -- Create table
@repeat{select count(*) from user_tables where table_name=upper('TICKETTURNOVERDIFADJUST') }  
  create table TICKETTURNOVERDIFADJUST
(
  ID         NUMBER(10) not null,
  MONEYDATE  DATE not null,
  SELLER     NUMBER(10) not null,
  DIFMONEY   NUMBER(10,2) not null,
  ORGID      NUMBER(10) not null,
  REMARK     VARCHAR2(100),
  CREATETIME DATE default SYSDATE not null,
  CREATEBY   NUMBER(10) default 0 not null,
  UPDATETIME DATE default SYSDATE not null,
  UPDATEBY   NUMBER(10) not null
);
-- Create/Recreate primary, unique and foreign key constraints 
@repeat{select count(*) from user_constraints t where t.table_name = 'TICKETTURNOVERDIFADJUST' and t.constraint_type = 'P' }
alter table TICKETTURNOVERDIFADJUST
  add constraint PK_DIFADJUST primary key (ID);
----end--------

--begin  代金岩  2015-7-13 17:28  修改行包结算单/运量单表字段 --- 
@repeat{SELECT 1-COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('packdepartinvoices') AND COLUMN_NAME = upper('scheduleplanid') and nullable ='N' }
ALTER TABLE Packdepartinvoices MODIFY SCHEDULEPLANID NULL;
@repeat{SELECT 1-COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('packdepartinvoices') AND COLUMN_NAME = upper('scheduleid') and nullable ='N'}
ALTER TABLE Packdepartinvoices MODIFY SCHEDULEID  NULL;
@repeat{SELECT 1-COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('packdepartinvoices') AND COLUMN_NAME = upper('departtime') and nullable ='N'}
ALTER TABLE Packdepartinvoices MODIFY DEPARTTIME NULL;
@repeat{SELECT 1-COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('packdepartinvoices') AND COLUMN_NAME = upper('reportid') and nullable ='N'}
ALTER TABLE Packdepartinvoices MODIFY REPORTID NULL;
@repeat{SELECT 1-COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('packdepartinvoices') AND COLUMN_NAME = upper('printorgid') and nullable ='N'}
ALTER TABLE Packdepartinvoices MODIFY PRINTORGID NULL;
@repeat{SELECT 1-COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('packdepartinvoices') AND COLUMN_NAME = upper('printip') and nullable ='N'}
ALTER TABLE Packdepartinvoices MODIFY PRINTIP  NULL;
@repeat{SELECT 1-COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('packdepartinvoices') AND COLUMN_NAME = upper('printby') and nullable ='N'}
ALTER TABLE Packdepartinvoices MODIFY PRINTBY  NULL;
@repeat{SELECT 1-COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('packdepartinvoices') AND COLUMN_NAME = upper('printtime') and nullable ='N'}
ALTER TABLE Packdepartinvoices MODIFY PRINTTIME  NULL;
--end--
--begin 2015/07/14 杨志文 线路在该线路设置的时间间隔内部允许报班增加字段reportinterval
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('ROUTE') AND COLUMN_NAME = upper('REPORTINTERVAL') }
alter table ROUTE add REPORTINTERVAL number(4) default 0;
comment on column ROUTE.REPORTINTERVAL is '报班时间间隔，该线路在设置的时间间隔内部允许报班，0：不限制，单位：小时';
--end 2015/07/14 杨志文 线路在该线路设置的时间间隔内部允许报班增加字段reportinterval

--begin 张彪 2015-07-14 修改结算单表
@repeat{SELECT 1-COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('departinvoices') AND COLUMN_NAME = upper('driver1id') }
alter table departinvoices modify driver1id default 0;
@repeat{SELECT 1-COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('departinvoices') AND COLUMN_NAME = upper('driver2id') }
alter table departinvoices modify driver2id default 0;
@repeat{SELECT 1-COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('departinvoices') AND COLUMN_NAME = upper('steward1id') }
alter table departinvoices modify steward1id default 0;
--end 张彪 2015-07-14 修改结算单表


--begin  代金岩  2015-7-13 17:28  修改行包结算单/运量单表字段 --- 
@repeat{SELECT 1-COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('packtturnoverdetail') AND COLUMN_NAME = upper('ticketstartno') and nullable ='N'}
ALTER TABLE packtturnoverdetail MODIFY ticketstartno NULL;
@repeat{SELECT 1-COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('packtturnoverdetail') AND COLUMN_NAME = upper('ticketendno') and nullable ='N'}
ALTER TABLE packtturnoverdetail MODIFY ticketendno NULL;
--end--

--begin 张彪 2015-07-14 修改积分规则表
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('PACKINTEGRATERULE') AND COLUMN_NAME = upper('TYPE') }
alter table PACKINTEGRATERULE add TYPE NUMBER(1);
comment on column PACKINTEGRATERULE.TYPE is '0：积分规则，1：积分消费规则';
--end 张彪 2015-07-14 修改积分规则表

--begin 杨志文 2015-07-29 检票闸机建表ENTRYTICKET
@repeat{select count(*) from user_tables where table_name=upper('ENTRYTICKET') }
create table ENTRYTICKET
(
  ID         NUMBER(10) not null,
  TICKETNO   VARCHAR2(20) not null,
  CREATETIME DATE default SYSDATE not null
);
@repeat{select  COUNT(*) from user_indexes t where t.table_name= upper('ENTRYTICKET') and t.index_name=upper('PK_TICKET2ID') }  
alter table ENTRYTICKET
  add constraint PK_TICKET2ID primary key (ID);
@repeat{select  COUNT(*) from user_indexes t where t.table_name= upper('ENTRYTICKET') and t.index_name=upper('IDX_TICKET2NO') }  
create index IDX_TICKET2NO on ENTRYTICKET (TICKETNO);
--end 杨志文 2015-07-29 检票闸机建表ENTRYTICKET
--添加车辆座位类型  李电志  2015年7月30日 04:32:22  begin
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('vehicle') AND COLUMN_NAME = upper('seattype') }
alter table vehicle add seattype varchar2(10) default '0';
comment on column vehicle.seattype is '座位类型,包括豪华硬座、豪华软座、豪华飞天、卧铺、卧铺上、卧铺下、商务座、高级座';
--添加车辆座位类型  李电志  2015年7月30日 04:32:22  end

--begin 姜蓥瑞 2015年8月3日17:38:46 并班记录表增加 isactive  --
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('schedulemerge') AND COLUMN_NAME = upper('isactive')}  
Alter table schedulemerge add  isactive NUMBER(1) default 0 not null;
--end 
--begin 姜蓥瑞  添加驾驶员 籍贯 长度不够 2015年8月4日20:54:39   --
@repeat{SELECT 1-COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('driver') AND COLUMN_NAME = upper('nativeplace') }
alter table driver modify nativeplace VARCHAR2(100);
---end ---

--begin 增加结算单手工录入项  addby 代金岩 2015/8/27
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('balance') AND COLUMN_NAME = upper('bysj')}  
alter table balance add bysj NUMBER(8,2);
comment on column balance.bysj is '本月上交';
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('balance') AND COLUMN_NAME = upper('syqj')}  
alter table balance add syqj NUMBER(8,2);
comment on column balance.syqj is '上月欠交';
--end
--孙越 2015年10月31日 16:16:59 行包作废营收 添加字段--
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('PACKTTURNOVERDETAIL') AND COLUMN_NAME = upper('Cancelnum') }
ALTER TABLE PACKTTURNOVERDETAIL
ADD Cancelnum number(10) default 0;
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('PACKTTURNOVERDETAIL') AND COLUMN_NAME = upper('Returnnum') }
ALTER TABLE PACKTTURNOVERDETAIL
ADD Returnnum number(10) default 0;
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('PACKTTURNOVERDETAIL') AND COLUMN_NAME = upper('Ticketnum') }
ALTER TABLE PACKTTURNOVERDETAIL
ADD Ticketnum number(10) default 0;
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('PACKTTURNOVERDETAIL') AND COLUMN_NAME = upper('Returnhandcharge') }
ALTER TABLE PACKTTURNOVERDETAIL
ADD Returnhandcharge number(10,2);
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('PACKTTURNOVERDETAIL') AND COLUMN_NAME = upper('Returnmoney') }
ALTER TABLE PACKTTURNOVERDETAIL
ADD Returnmoney number(10,2);

@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('TICKETSELL') AND COLUMN_NAME = upper('tiksno')}  
Alter table TICKETSELL add  tiksno VARCHAR2(100) ;
--end --