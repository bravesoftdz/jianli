-- 2016年2月19日 王远媛 设置售票点不可售中途站点表站点ID可为空 begin --
@repeat{SELECT 1-COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('TICKETOUTLETSUNSELLSTATION ') AND COLUMN_NAME = upper('stationid')}
alter table TICKETOUTLETSUNSELLSTATION modify stationid number;
--设置售票点不可售中途站点表站点ID可为空 end --

@repeat{select count(*) from user_constraints t where t.table_name = 'TAKETICKETLOG' and t.constraint_type = 'P' }
alter table TAKETICKETLOG
  add constraint PKTAKETICKETLOGID primary key (ID);
-- Create/Recreate indexes 
@repeat{select count(*) from user_indexes t where t.table_name = 'TAKETICKETLOG' and t.index_name = 'IDX_TAKETICKET' }
create index IDX_TAKETICKET on TAKETICKETLOG (DEPARTDATE);
@repeat{select count(*) from user_indexes t where t.table_name = 'TAKETICKETLOG' and t.index_name = 'IDX_TAKETIMELOG' }  
create index IDX_TAKETIMELOG on TAKETICKETLOG (TAKETIME);


@repeat{select count(*) from user_constraints t where t.table_name = 'VEHICLEDRIVERREPORT' and t.constraint_type = 'P' }
alter table VEHICLEDRIVERREPORT
  add constraint PKVEHICLEDRIVERREPORT primary key (ID);
  

@repeat{select count(*) from user_constraints t where t.table_name = 'TICKETTURNOVERDIFADJUST' and t.constraint_type = 'P' }
alter table TICKETTURNOVERDIFADJUST
  add constraint PK_DIFADJUST primary key (ID);
  

@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('schedulemerge') AND COLUMN_NAME = upper('isactive')}  
Alter table schedulemerge add  isactive NUMBER(1) default 0 not null;  
--通知表新增通知功能对象
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('notify') AND COLUMN_NAME = upper('notifyfuncitem')}  
alter table notify add notifyfuncitem varchar2(50);

@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('DEPARTINVOICES') AND COLUMN_NAME = upper('TICKETOUTLETSID')}  
alter table DEPARTINVOICES add TICKETOUTLETSID NUMBER(10) default 0;
-- Add comments to the columns 
comment on column DEPARTINVOICES.TICKETOUTLETSID
  is '结算售票点';

@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('BALANCEDEDUCTDETAIL') AND COLUMN_NAME = upper('DEDUCTITEMname') }
alter table BALANCEDEDUCTDETAIL add DEDUCTITEMname varchar2(50);

@repeat{SELECT 1-COUNT(*) FROM USER_TAB_COLUMNS t WHERE TABLE_NAME = upper('BALANCEDEDUCTDETAIL') AND COLUMN_NAME = upper('BALANCEDEDUCTITEMID')  and t.NULLABLE = 'N'}
alter table BALANCEDEDUCTDETAIL modify BALANCEDEDUCTITEMID null;


--begin 增加结算单位  addby daijy
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('departinvoicesother') AND COLUMN_NAME = upper('balanceunitid') }
alter table departinvoicesother add balanceunitid number(10) default 0 ;
comment on column departinvoicesother.balanceunitid is '结算单位id';
--end
--BEGIN 2015-8-31 vehicle是否需要证件核查才允许报班  杨志文 
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('VEHICLE') AND COLUMN_NAME = upper('ISNEEDCHECK') }
alter table VEHICLE add ISNEEDCHECK NUMBER(1) default 1;
comment on column VEHICLE.ISNEEDCHECK is '是否需要证件核查才允许报班0：不需要 ； 1：需要';
--end BEGIN 2015-8-31 vehicle是否需要证件核查才允许报班  杨志文 

--begin 2015-8-31 赵怀虎  修改  GpsCheck表  表结构
-- Add/modify columns 
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('gpscheck') AND COLUMN_NAME = upper('isactive')}
alter table gpscheck add isactive number(1) default 1 not null;
comment on column gpscheck.isactive  is '是否激活';
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('gpscheck') AND COLUMN_NAME = upper('islocaldelete')}
alter table gpscheck add islocaldelete number(1) default 0 not null;
comment on column gpscheck.islocaldelete is '是否本地注销';   
-- Add/modify columns 
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('gpscheck') AND COLUMN_NAME = upper('SYNCCODE')}
alter table gpscheck add SYNCCODE VARCHAR2(40);
-- Add comments to the columns 
comment on column gpscheck.SYNCCODE  is '全局同步编码';
@repeat{SELECT COUNT(*) FROM gpscheck where synccode is not null}
update gpscheck t set t.synccode=t.id||t.vehicleid||t.orgid||to_char(sysdate,'hh24miss') ;  
-- Create/Recreate indexes 
@repeat{select count(*) from user_indexes t where t.table_name = upper('gpscheck') and t.index_name = upper('idx_gpscheckSYNCCODE') }
create unique index idx_gpscheckSYNCCODE on gpscheck (synccode);
--end  2015-8-31 赵怀虎  修改  GpsCheck表  表结构
--begin  新增手工单是否需要审核字段 addby liyi
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('departinvoicesother') AND COLUMN_NAME = upper('ISAUDIT') }
alter table departinvoicesother add   ISAUDIT  VARCHAR2(1) default 0;
--end
--begin 2015-9-6 杨志文 保险类型新加字段
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('INSURETYPE') AND COLUMN_NAME = upper('YWMoney') }
alter table INSURETYPE add YWMoney NUMBER(10,2);
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('INSURETYPE') AND COLUMN_NAME = upper('SHMoney') }
alter table INSURETYPE add SHMoney NUMBER(10,2);
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('INSURETYPE') AND COLUMN_NAME = upper('EMoney') }
alter table INSURETYPE add EMoney NUMBER(10,2);
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('INSURETYPE') AND COLUMN_NAME = upper('EMMoney') }
alter table INSURETYPE add EMMoney NUMBER(10,2);
-- Add comments to the columns 
comment on column INSURETYPE.YWMoney is '意外医疗费';
comment on column INSURETYPE.SHMoney is '意外伤害费';
comment on column INSURETYPE.EMoney is '意外伤害保险金额';
comment on column INSURETYPE.EMMoney is '意外伤害医疗保险金额';
--end 2015-9-6 杨志文 保险类型新加字段

@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('DIGITALDICTIONARY') AND COLUMN_NAME = upper('ISCANADD') }
alter table DIGITALDICTIONARY add ISCANADD NUMBER(1) default 0;


--20150911  add by daijy  增加对应发车站点id
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('TICKETOUTLETS') AND COLUMN_NAME = upper('STARTSTATIONID') }
alter table TICKETOUTLETS add STARTSTATIONID NUMBER(10);
comment on column TICKETOUTLETS.STARTSTATIONID  is '对应发车站点Id';
--end
--20150923  liyi  燃油附加费精度扩大
@repeat{SELECT 1-COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('fuelfeegrade') AND COLUMN_NAME = upper('fromprice') }
alter table fuelfeegrade modify  fromprice number(10,3);
@repeat{SELECT 1-COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('fuelfeegrade') AND COLUMN_NAME = upper('toprice') }
alter table fuelfeegrade modify  toprice number(10,3);
--end
-- begin 杨志文 2015/10/12 驾驶员驾驶车辆设置建表
@repeat{select count(*) from user_tables where table_name=upper('SETDRIVERVEHICLE') }
create table SETDRIVERVEHICLE
(
  ID         NUMBER(10) not null,
  ORGID      NUMBER(10) not null,
  DRIVERID   NUMBER(10) not null,
  VEHICLEID  NUMBER(10) not null,
  REMARK     VARCHAR2(100),
  CREATETIME DATE not null,
  CREATEBY   NUMBER(10) not null,
  UPDATETIME DATE not null,
  UPDATEBY   NUMBER(10) not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
-- Add comments to the table 
comment on table SETDRIVERVEHICLE
  is '驾驶员驾驶车辆设置';
-- Add comments to the columns 
comment on column SETDRIVERVEHICLE.ORGID
  is '机构ID';
comment on column SETDRIVERVEHICLE.DRIVERID
  is '驾驶员ID';
comment on column SETDRIVERVEHICLE.VEHICLEID
  is '车辆ID';
comment on column SETDRIVERVEHICLE.REMARK
  is '备用';
@repeat{select count(*) from user_constraints t where t.table_name = 'SETDRIVERVEHICLE' and t.constraint_type = 'P' }  
alter table SETDRIVERVEHICLE
  add constraint PK_SETDRIVERVEHICLEID primary key (ID);
@repeat{select count(*) from user_indexes t where t.table_name = 'SETDRIVERVEHICLE' and t.index_name = 'UNIQUE_SETDRIVERVEHICLE' }  
create unique index UNIQUE_SETDRIVERVEHICLE on SETDRIVERVEHICLE (DRIVERID, VEHICLEID);  
-- end 杨志文 2015/10/12 驾驶员驾驶车辆设置建表  
 --姜蓥瑞 2015-10-19 11:40:42 车辆运营线路设置
  @repeat{select count(*) from user_tables where table_name=upper('Vehiclerouteconctrl') }
  create table Vehiclerouteconctrl
(
  ID         NUMBER(10) not null,
  VEHICLEID  NUMBER(10) not null,
  SCHEDULEID NUMBER(10) ,
  routeid     number(10) not null,
  orgid      number(10) not null,
  CREATETIME DATE default SYSDATE not null,
  CREATEBY   NUMBER(10) default 0 not null,
  UPDATETIME DATE default SYSDATE not null,
  UPDATEBY   NUMBER(10) not null
);
-- Add comments to the table 
comment on table Vehiclerouteconctrl
  is '车辆运营线路设置';
  -- Create/Recreate primary, unique and foreign key constraints 
@repeat{select count(*) from user_constraints t where t.table_name = 'VEHICLEROUTECONCTRL' and t.constraint_type = 'P' }  
alter table VEHICLEROUTECONCTRL
add constraint VEHICLEROUTECONCTRLID primary key (ID);
---end--

--BEGIN姜蓥瑞 2015年11月12日18:53:39
  @repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('ROUTE') AND COLUMN_NAME = upper('ISREALNAMETICKET') }
alter table route add ISREALNAMETICKET NUMBER(1) default 0;
--end

--孙越 2015年12月9日 10:20:11 --
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('departinvoices') AND COLUMN_NAME = upper('seller') }
alter table departinvoices add seller number(10) default 0;

@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('departinvoicesother') AND COLUMN_NAME = upper('seller') }
alter table departinvoicesother add seller number(10) default 0;
--end--
--begin 杨志文 2015-12-30 车票缴款表添加索引
@repeat{select count(*) from user_indexes t where t.table_name = 'TICKETSELL' and t.index_name = 'IDX_TICKETTURNOVER' }  
create index IDX_TICKETTURNOVER on TICKETSELL (TURNOVERDETAILID, SELLBY);
--end 杨志文 2015-12-30 车票缴款表添加索引

--begin 李春 2016-1-19  售票点票价差额表新加字段
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('ticketoutletsprice') AND COLUMN_NAME = upper('starttime') }
alter table ticketoutletsprice add starttime date;

@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('ticketoutletsprice') AND COLUMN_NAME = upper('endtime') }
alter table ticketoutletsprice add endtime date;
--end  李春 2016-1-19  售票点票价差额表新加字段

@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('departinvoicesother') AND COLUMN_NAME = upper('pieces')}
alter table departinvoicesother add pieces number(10) default 0;
--end

@repeat{SELECT 1-COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('USERINFO') AND COLUMN_NAME = upper('NAME')}
alter table USERINFO modify NAME VARCHAR2(50);

@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('TICKETSELL') AND COLUMN_NAME = upper('tiksno')}  
Alter table TICKETSELL add  tiksno VARCHAR2(100) ;

@repeat{SELECT 1-COUNT(*) FROM USER_TAB_COLUMNS t WHERE TABLE_NAME = upper('ticketchargeoff') AND COLUMN_NAME = upper('ticketno') }
alter table ticketchargeoff modify ticketno NUMBER(12);


@repeat{select count(*) from user_indexes t where t.table_name = upper('DEPARTINVOICES') and t.index_name = upper('idx_balanceid') } 
create index idx_balanceid on DEPARTINVOICES (balanceid);

@repeat{select count(*) from user_indexes t where t.table_name = upper('BALANCE') and t.index_name = upper('idx_balancetime') } 
create index idx_balancetime on BALANCE (balancetime);

--begin addby daijy 添加改签表中的改签凭证号
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('ticketchange') AND COLUMN_NAME = upper('changeticketno') }
alter table ticketchange add  changeticketno VARCHAR2(20) ;
comment on column ticketchange.changeticketno
  is '改签凭证号';
--end


@repeat{select 1-count(*) from user_indexes  u where u.index_name = upper('IDX_INSURANCETURNOVERDETAIL')}
drop index IDX_INSURANCETURNOVERDETAIL;
@repeat{select count(*) from user_indexes  u where u.index_name = upper('IDX_INSURANCETURNOVERDETAIL')}
create unique index IDX_INSURANCETURNOVERDETAIL on INSURANCETURNOVERDETAIL (CASE  WHEN TICKETSTARTNO<>'0' THEN MONEYDATE ELSE NULL END, CASE  WHEN TICKETSTARTNO<>'0' THEN SELLER ELSE NULL END, CASE  WHEN TICKETSTARTNO<>'0' THEN TICKETSTARTNO ELSE NULL END, CASE  WHEN TICKETENDNO<>'0' THEN TICKETENDNO ELSE NULL END);

@repeat{select count(*) from user_indexes t where t.table_name = upper('TICKETSELL') and t.index_name = upper('idx_TICKETSELL4') } 
create index idx_TICKETSELL4 on TICKETSELL (departdate, orgid);

--begin addby daijy  增加货运代理费
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('balance') AND COLUMN_NAME = upper('goodsagent') }
alter table balance add goodsagent NUMBER(8,2) default 0.00 ;
comment on column balance.goodsagent is '货运代理费';
--end


--add by zhangqingfeng 2016/5/13  系统数据对比
@repeat{select count(*) from user_tables where table_name=upper('HBHSDATARESTORE') }
create table HBHSDATARESTORE
(
  systemname      VARCHAR2(20),
  totleprice      NUMBER,
  totlepeoplenum  NUMBER,
  createtime      TIMESTAMP(6),
  sendschedulenum NUMBER,
  solddistance    NUMBER
);
-- Add comments to the columns 
comment on column HBHSDATARESTORE.totleprice
  is '总营收';
comment on column HBHSDATARESTORE.totlepeoplenum
  is '总运量';
comment on column HBHSDATARESTORE.sendschedulenum
  is '发班班次数';
comment on column HBHSDATARESTORE.solddistance
  is '周转量';

@repeat{select count(*) from user_tables where table_name=upper('DATACOMPARETICKETSELL') }
create table DATACOMPARETICKETSELL
(
  systemname            VARCHAR2(30),
  totleprice            NUMBER(15,2),
  totlepeoplenum        NUMBER,
  stationcharge         NUMBER(15,2),
  localstationticketnum NUMBER,
  localstationprice     NUMBER(15,2),
  currenttime           TIMESTAMP(6),
  ischeckednum          NUMBER
);
-- Add comments to the columns 
comment on column DATACOMPARETICKETSELL.systemname
  is '数据来源';
comment on column DATACOMPARETICKETSELL.totleprice
  is '总营收';
comment on column DATACOMPARETICKETSELL.totlepeoplenum
  is '总客流量';
comment on column DATACOMPARETICKETSELL.stationcharge
  is '站务费';
comment on column DATACOMPARETICKETSELL.localstationticketnum
  is '本站售票数';
comment on column DATACOMPARETICKETSELL.localstationprice
  is '本站售票总价格';
comment on column DATACOMPARETICKETSELL.ischeckednum
  is '检票数量';

 @repeat{select count(*) from user_tables where table_name=upper('DATACOMPARETICKETRETURN') }
 create table DATACOMPARETICKETRETURN
(
  systemname      VARCHAR2(20),
  ticketreturnnum NUMBER,
  createtime      TIMESTAMP(6)
);
-- Add comments to the columns 
comment on column DATACOMPARETICKETRETURN.ticketreturnnum
  is '退票数量';

@repeat{select count(*) from user_tables where table_name=upper('DATACOMPAREDEPAREANDVOLUME') }
create table DATACOMPAREDEPAREANDVOLUME
(
  systemname VARCHAR2(20),
  totalnum   NUMBER,
  seatnum    NUMBER,
  createtime TIMESTAMP(6),
  vehicleno  VARCHAR2(20)
);
-- Add comments to the columns 
comment on column DATACOMPAREDEPAREANDVOLUME.totalnum
  is '客流量';
comment on column DATACOMPAREDEPAREANDVOLUME.seatnum
  is '座位数';
comment on column DATACOMPAREDEPAREANDVOLUME.vehicleno
  is '车牌号';
--end


--begin zhujiajun  2016-6-13
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('steward') AND COLUMN_NAME = upper('vehicleid')}
alter table steward add vehicleid number(10);

@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('steward') AND COLUMN_NAME = upper('vehicleno')}
alter table steward add vehicleno varchar2(30);

@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('outstationcheck') AND COLUMN_NAME = upper('steward1')}
alter table outstationcheck add steward1 varchar2(10);
--end

--begin addby daijy  增加二维证件号（二保卡）
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('vehicle') AND COLUMN_NAME = upper('twodimensionno') }
alter table vehicle add twodimensionno VARCHAR2(30) ;
comment on column vehicle.twodimensionno is '二维证件号（二保卡）';
--end


--begin addby zhangqingfeng  保险服务器对接 
-- Create table
@repeat{select count(*) from user_tables where table_name=upper('PLATFORMINSURANCETYPE') }
create table PLATFORMINSURANCETYPE
(
  id                  NUMBER(10) not null,
  insurecompanycode   VARCHAR2(50) not null,
  insurecompanyname   VARCHAR2(50) not null,
  varcode             VARCHAR2(50),
  varname             VARCHAR2(50),
  productcode         VARCHAR2(50),
  insuretype          NUMBER(3) not null,
  explanation         VARCHAR2(1000),
  premium             NUMBER(10,2) not null,
  dieinsureamount     NUMBER(10,2) not null,
  medicalinsureamount NUMBER(10,2) not null,
  createtime          DATE default SYSDATE not null,
  createby            NUMBER(10) not null,
  updatetime          DATE default SYSDATE not null,
  updateby            NUMBER(10) not null
);
-- Add comments to the columns 
comment on column PLATFORMINSURANCETYPE.insurecompanycode
  is '保险公司代码';
comment on column PLATFORMINSURANCETYPE.insurecompanyname
  is '保险公司名称';
comment on column PLATFORMINSURANCETYPE.varcode
  is '险种代码';
comment on column PLATFORMINSURANCETYPE.varname
  is '险种名称';
comment on column PLATFORMINSURANCETYPE.productcode
  is '产品代码';
comment on column PLATFORMINSURANCETYPE.insuretype
  is '保险类型（公式、固定）';
comment on column PLATFORMINSURANCETYPE.explanation
  is '保险产品说明';
comment on column PLATFORMINSURANCETYPE.premium
  is '保险费';
comment on column PLATFORMINSURANCETYPE.dieinsureamount
  is '身故保额';
comment on column PLATFORMINSURANCETYPE.medicalinsureamount
  is '医疗保额';

@repeat{select count(*) from user_tables where table_name=upper('PLATFORMINSUREORDER') }
-- Create table
create table PLATFORMINSUREORDER
(
  id          NUMBER(10) not null,
  insuranceno VARCHAR2(50),
  orderno     VARCHAR2(50) not null,
  status      NUMBER(3),
  createtime  DATE default sysdate not null,
  createby    NUMBER(10) not null,
  updatetime  DATE default sysdate not null,
  updateby    NUMBER(10) not null,
  issuingtype NUMBER(3),
  sellorgcode VARCHAR2(50)
);
-- Add comments to the columns 
comment on column PLATFORMINSUREORDER.insuranceno
  is '保险订单号';
comment on column PLATFORMINSUREORDER.orderno
  is '车票订单号';
comment on column PLATFORMINSUREORDER.status
  is '1-申请售保2-投保成功3-投保失败';
@repeat{SELECT COUNT(*)-1 FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('PLATFORMINSUREORDER') AND COLUMN_NAME = upper('issuingtype')}   
comment on column PLATFORMINSUREORDER.issuingtype
  is '出单方式1-电子 2-纸质';
@repeat{SELECT COUNT(*)-1 FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('PLATFORMINSUREORDER') AND COLUMN_NAME = upper('sellorgcode')}   
comment on column PLATFORMINSUREORDER.sellorgcode
  is '售保机构代码';

@repeat{select count(*) from user_tables where table_name=upper('PLATFORMINSUREORDERDETAIL') }
-- Create table
create table PLATFORMINSUREORDERDETAIL
(
  id             NUMBER(10) not null,
  insuranceid    NUMBER(10) not null,
  insureorderid  NUMBER(10) not null,
  insureno       VARCHAR2(20),
  etinsureno     VARCHAR2(50),
  ticketno       VARCHAR2(50),
  iswithchildren NUMBER(3),
  insureid       NUMBER(10) not null,
  rangkm         NUMBER(10,2),
  price          NUMBER(10,2),
  premium        NUMBER(10,2),
  departdate     VARCHAR2(25),
  departtime     VARCHAR2(25),
  schedulecode   VARCHAR2(25),
  seatno         VARCHAR2(25),
  passengername  VARCHAR2(50),
  passengerphone VARCHAR2(15),
  passengeremail VARCHAR2(50),
  idtype         NUMBER(3),
  idnum          VARCHAR2(25),
  departcode     VARCHAR2(25),
  departname     VARCHAR2(50),
  reachcode      VARCHAR2(25),
  reachname      VARCHAR2(50),
  selltickettime DATE,
  status         NUMBER(3) default 0
);
-- Add comments to the columns 
comment on column PLATFORMINSUREORDERDETAIL.insuranceid
  is '保险id';
comment on column PLATFORMINSUREORDERDETAIL.insureorderid
  is '保险订单id';
comment on column PLATFORMINSUREORDERDETAIL.insureno
  is '保险票据号';
comment on column PLATFORMINSUREORDERDETAIL.etinsureno
  is '电子保单号';
comment on column PLATFORMINSUREORDERDETAIL.ticketno
  is '车票票据号';
comment on column PLATFORMINSUREORDERDETAIL.iswithchildren
  is '是否携带儿童：0-否，1-是，默认否';
comment on column PLATFORMINSUREORDERDETAIL.insureid
  is '保险产品id';
comment on column PLATFORMINSUREORDERDETAIL.rangkm
  is '里程';
comment on column PLATFORMINSUREORDERDETAIL.price
  is '票价';
comment on column PLATFORMINSUREORDERDETAIL.status
  is '售保状态1-申请售保2-售保成功4-退保申请5-退保成功';

-- Create sequence 
@repeat{select count(*) from user_sequences t  where upper（t.sequence_name）='SEQ_INSUREORDER'}
create sequence SEQ_INSUREORDER
minvalue 1
maxvalue 9999999999
start with 100001
increment by 1
nocache;

--end addby zhangqingfeng  保险服务器对接

--班次计划表增加手持售票数字段
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('SCHEDULEPLAN') AND COLUMN_NAME = upper('posnum') }
alter table SCHEDULEPLAN add posnum NUMBER(4) default 0;
-- Add comments to the columns
comment on column SCHEDULEPLAN.posnum
  is '手持售票人数';

--start addby zhangqingfeng 打印模板增加图片
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('printtemplateitem') AND COLUMN_NAME = upper('printpicture') }
alter table printtemplateitem add printpicture BLOB;
--end addby zhangqingfeng 打印模板增加图片

-- 2016年6月22日 09:56:24 maxiao 添加菜单 begin --
@repeat{select count(*) from user_tables where table_name=upper('TICKETOUTLETSCTR')}
create table TICKETOUTLETSCTR
(
  ID              NUMBER(10) not null,
  TICKETOUTLETSID NUMBER(10) not null,
  CARRYCHILDRATE  NUMBER(10,2) default 0 not null,
  MAXSELLMONEY    NUMBER(10,2) default 0 not null,
  CREATETIME      DATE not null,
  CREATEBY        NUMBER(10) not null,
  UPDATETIME      DATE not null,
  UPDATEBY        NUMBER(10) not null
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255;
-- Add comments to the table 
comment on table TICKETOUTLETSCTR
  is '售票点售票控制';
-- Add comments to the columns 
comment on column TICKETOUTLETSCTR.TICKETOUTLETSID
  is '售票点ID';
comment on column TICKETOUTLETSCTR.CARRYCHILDRATE
  is '免票比例';
comment on column TICKETOUTLETSCTR.MAXSELLMONEY
  is '最大售票金额';
-- Create/Recreate indexes 
@repeat{select count(*) from user_indexes t where t.table_name = upper('TICKETOUTLETSCTR') and t.index_name = upper('IDXTICKETOUTLETSCTR') }
create unique index IDXTICKETOUTLETSCTR on TICKETOUTLETSCTR (TICKETOUTLETSID);
--end--  

-- 2016年7月20日 yaolu 特殊订单退款明细 begin --
@repeat{SELECT COUNT(*) FROM functionreg where ID=260}
insert into functionreg(ID,packagename,name,functionkey,functiondescribe,parameterdescribe,createtime,createby,updatetime,updateby,instruction)
values(260,'QuerySpecialorderinfo.bpl','特殊订单退款明细','{36FB9648-F3AF-47F9-BCCF-40934CF36924}','特殊订单退款明细','',sysdate,1158013,sysdate,1158013,null);
@repeat{SELECT COUNT(*) FROM menu where ID=260}
insert into menu(ID,name,functionregid,grade,orderno,parentid,parameter,createtime,createby,updatetime,updateby,clicknum,clazz,url,icon,systype,menutype)
values(260,'特殊订单退款明细',260,3,10.01,31,'',sysdate,1158013,sysdate,1158013,0,'','','',0,1);
--end-- 

--BEGIN 遥路 添加异常订单表 为网站的特殊订单 存数据 2016年7月21日
@repeat{select count(*) from user_tables where table_name=upper('SPECIALORDERINFO') }
CREATE TABLE SPECIALORDERINFO (
	id NUMBER(10) NOT NULL ,
	orderno VARCHAR2(40 BYTE) NOT NULL ,
	buscode VARCHAR2(20 BYTE) NOT NULL ,
	busname VARCHAR2(40 BYTE) NOT NULL ,
	orderdate DATE NOT NULL ,
	departdate DATE NOT NULL ,
	price NUMBER(10,2) NOT NULL ,
	insurefee NUMBER(10,2) NULL ,
	status NUMBER(1) NOT NULL ,
	returnfee NUMBER(10,2) NULL ,
	returncause VARCHAR2(40 BYTE) NULL ,
	returnperson VARCHAR2(20 BYTE) NULL ,
	returntime DATE NULL ,
	createtime DATE NULL ,
	remark VARCHAR2(100 BYTE) NULL 
);
COMMENT ON COLUMN SPECIALORDERINFO.orderno IS '订单号';
COMMENT ON COLUMN SPECIALORDERINFO.buscode IS '车站编码';
COMMENT ON COLUMN SPECIALORDERINFO.busname IS '车站名称';
COMMENT ON COLUMN SPECIALORDERINFO.orderdate IS '订单时间';
COMMENT ON COLUMN SPECIALORDERINFO.departdate IS '发车日期';
COMMENT ON COLUMN SPECIALORDERINFO.price IS '票价';
COMMENT ON COLUMN SPECIALORDERINFO.insurefee IS '保险金额';
COMMENT ON COLUMN SPECIALORDERINFO.status IS '车票状态0：正常 1：已退票  2：已废票  3：已检票' ;
COMMENT ON COLUMN SPECIALORDERINFO.returnfee IS '退票费';
COMMENT ON COLUMN SPECIALORDERINFO.returncause IS '退票原因';
COMMENT ON COLUMN SPECIALORDERINFO.returnperson IS '退票人';
COMMENT ON COLUMN SPECIALORDERINFO.returntime IS '退票时间';
COMMENT ON COLUMN SPECIALORDERINFO.remark IS '备注';
@repeat{select count(*) from user_constraints t where t.table_name = 'SPECIALORDERINFO' and t.constraint_type = 'P' }
alter table SPECIALORDERINFO
  add constraint PK_SPECIALORDERINFOID primary key (ID);
@repeat{select count(*) from user_sequences  where sequence_name = 'SEQ_SPECIALORDERINFO'}
create sequence SEQ_SPECIALORDERINFO minvalue 1 maxvalue 9999999999999 start with 21 increment by 1 cache 20;

@repeat{SELECT 1-COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('SPECIALORDERINFO') AND COLUMN_NAME = upper('returncause')}
alter table specialorderinfo modify (returncause VARCHAR2(600 BYTE));
--END

--begin zhaohuaihu  20160810 九江 车辆停车费表
@repeat{select count(*) from user_tables where table_name=upper('VEHICLEPARKFEE') }
create table VEHICLEPARKFEE
(
  ID         NUMBER(10) not null,
  VEHICLENO  NVARCHAR2(30) not null,
  DEPARTDATE DATE not null,
  PARKFEE    NUMBER(10,2) default 0.00 not null,
  ISBALANCED NUMBER(1) default 0 not null,
  ORGID      NUMBER(10) not null,
  BALANCEID  NUMBER(10),
  CREATEBY   NUMBER(10) default 0 not null,
  CREATETIME DATE default SYSDATE not null,
  UPDATEBY   NUMBER(10) default 0 not null,
  UPDATETIME DATE default SYSDATE not null
);
-- Add comments to the table 
comment on table VEHICLEPARKFEE
  is '车辆停车费表';
-- Add comments to the columns 
comment on column VEHICLEPARKFEE.VEHICLENO
  is '车牌号码';
comment on column VEHICLEPARKFEE.DEPARTDATE
  is '发车日期';
comment on column VEHICLEPARKFEE.PARKFEE
  is '停车费';
comment on column VEHICLEPARKFEE.ISBALANCED
  is '是否结算，0未结算，1已结算，默认为0未结算';
comment on column VEHICLEPARKFEE.ORGID
  is '扣费所属机构ID(车站机构ID)';
comment on column VEHICLEPARKFEE.BALANCEID
  is '结账单id';
comment on column VEHICLEPARKFEE.CREATEBY
  is '创建人';
comment on column VEHICLEPARKFEE.CREATETIME
  is '创建时间';
comment on column VEHICLEPARKFEE.UPDATEBY
  is '更新人';
comment on column VEHICLEPARKFEE.UPDATETIME
  is '更新时间';

@repeat{select count(*) from user_constraints t where t.table_name = 'VEHICLEPARKFEE' and t.constraint_type = 'P' }
alter table VEHICLEPARKFEE add constraint PK_VEHICLEPARKFEEID primary key (ID);
  
@repeat{select count(*) from user_indexes t where t.table_name = upper('VEHICLEPARKFEE') and t.index_name = upper('IDX_VEHICLEPARKFEEDATE') }
create unique index IDX_VEHICLEPARKFEEDATE on VEHICLEPARKFEE (departdate, vehicleno);
--end zhaohuaihu  20160810 九江 车辆停车费表


--begin zhaohuaihu 20160819 增加网售机构取票设置表，配置为不可取票的机构
@repeat{select count(*) from user_tables where table_name=upper('NETORGTAKESETTING') }
create table NETORGTAKESETTING
(
  ID         NUMBER(10) not null,
  ORGCODE    VARCHAR2(20) not null,
  CANTAKE    NUMBER(1) default 0 not null,
  CREATEBY   NUMBER(10) default 0 not null,
  CREATETIME DATE default sysdate not null,
  UPDATEBY   NUMBER(10) default 0 not null,
  UPDATETIME DATE default sysdate not null
);
-- Add comments to the table 
comment on table NETORGTAKESETTING
  is '网售机构取票设置';
-- Add comments to the columns 
comment on column NETORGTAKESETTING.ORGCODE
  is '机构编码';
comment on column NETORGTAKESETTING.CANTAKE
  is '是否可取，0不可取，1可取，默认为0不可取';
comment on column NETORGTAKESETTING.CREATEBY
  is '创建人';
comment on column NETORGTAKESETTING.CREATETIME
  is '创建时间';
comment on column NETORGTAKESETTING.UPDATEBY
  is '更新人';
comment on column NETORGTAKESETTING.UPDATETIME
  is '更新时间';
  
@repeat{select count(*) from user_constraints t where t.table_name = 'NETORGTAKESETTING' and t.constraint_type = 'P' }
alter table NETORGTAKESETTING add constraint PK_NETORGTAKESETTING primary key (ID);

@repeat{select count(*) from user_indexes t where t.table_name = upper('NETORGTAKESETTING') and t.index_name = upper('IDX_NETORGTAKECODE') }
create unique index IDX_NETORGTAKECODE on NETORGTAKESETTING (ORGCODE );
--end zhaohuaihu 20160819 增加网售机构取票设置表，配置为不可取票的机构

--add by zqf 电子支付 start
@repeat{select count(*) from user_tables where table_name=upper('GATEWAY') }
create table GATEWAY
(
  id              VARCHAR2(20) not null,
  paywaytype      NUMBER(3),
  paytradename    NUMBER(3),
  paytradenameval VARCHAR2(50),
  picturepath     VARCHAR2(200),
  bankcode        VARCHAR2(20),
  bankname        VARCHAR2(100),
  createtime      DATE default sysdate,
  updatetime      DATE default sysdate
);
-- Add comments to the columns 
comment on column GATEWAY.id
  is '网关id';
comment on column GATEWAY.paywaytype
  is '支付方式';
comment on column GATEWAY.paytradename
  is '支付商';
comment on column GATEWAY.paytradenameval
  is '支付商名称';
comment on column GATEWAY.picturepath
  is '支付商logo';
comment on column GATEWAY.bankcode
  is '银行代码';
comment on column GATEWAY.bankname
  is '银行名称';
comment on column GATEWAY.createtime
  is '创建时间';
comment on column GATEWAY.updatetime
  is '修改时间';
@repeat{select count(*) from user_constraints t where t.table_name = 'GATEWAY' and t.constraint_type = 'P' }
alter table GATEWAY
  add primary key (ID);
  
@repeat{select count(*) from user_tables where table_name=upper('PAYINFO') }
create table PAYINFO
(
  id            NUMBER(20) not null,
  orderno       VARCHAR2(36) not null,
  payorderno    VARCHAR2(36) not null,
  payno         VARCHAR2(36),
  totalprice    NUMBER(8,2) not null,
  gatewayid     NUMBER(8) not null,
  paystatus     NUMBER(3),
  paymessage    VARCHAR2(50),
  refundmoney   NUMBER(8,2),
  returnstatus  VARCHAR2(10),
  returnmessage VARCHAR2(50),
  createtime    DATE default sysdate,
  updatetime    DATE,
  createby      NUMBER(20),
  updateby      NUMBER(20),
  alipaycode    VARCHAR2(16),
  isactive      NUMBER(1) default 1
);
-- Add comments to the columns 
comment on column PAYINFO.orderno
  is '订单号';
comment on column PAYINFO.payorderno
  is '平台订单号';
comment on column PAYINFO.payno
  is '支付交易号';
comment on column PAYINFO.totalprice
  is '订单总金额';
comment on column PAYINFO.gatewayid
  is '支付网关id';
comment on column PAYINFO.paystatus
  is '支付状态0-未支付或支付失败1-支付成功2-查询失败3-退票成功';
comment on column PAYINFO.paymessage
  is '支付结果信息';
comment on column PAYINFO.refundmoney
  is '退款金额';
comment on column PAYINFO.returnstatus
  is '退款状态1111-成功0001-订单号为空0002-支付交易号为空...';
comment on column PAYINFO.returnmessage
  is '退款结果信息';
comment on column PAYINFO.isactive
  is '是否删除';
@repeat{select count(*) from user_indexes t where t.table_name = upper('PAYINFO') and t.index_name = upper('IDX_PAYINFOPAYNO') }
create unique index IDX_PAYINFOPAYNO on PAYINFO (PAYNO);
@repeat{select count(*) from user_sequences  where sequence_name = 'SEQ_PAYINFO'}
create sequence SEQ_PAYINFO
minvalue 1
maxvalue 9999999999
start with 10057
increment by 1
nocache;
@repeat{select count(*) from user_constraints t where t.table_name = 'PAYINFO' and t.constraint_type = 'P' }
alter table PAYINFO
  add primary key (ID);
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('TICKETRETURN') AND COLUMN_NAME = upper('returnamountweb') }  
alter table TICKETRETURN add returnamountweb NUMBER(15,2) default 0 ;
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('TICKETRETURN') AND COLUMN_NAME = upper('chargesweb') }  
alter table TICKETRETURN add chargesweb NUMBER(15,2) default 0;
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('TICKETRETURN') AND COLUMN_NAME = upper('returnmethod') }  
alter table TICKETRETURN add returnmethod NUMBER(3);
-- Add comments to the columns 
comment on column TICKETRETURN.returnamountweb
  is '电子票退票款';
comment on column TICKETRETURN.chargesweb
  is '电子票手续费';
comment on column TICKETRETURN.returnmethod
  is '退票途径 0车站,1 非车站 ';

@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('TICKETTURNOVERDETAIL') AND COLUMN_NAME = upper('ETICKETreturnCHARGE') }  
alter table TICKETTURNOVERDETAIL add ETICKETreturnCHARGE NUMBER(15,2) default 0;
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('TICKETTURNOVERDETAIL') AND COLUMN_NAME = upper('ETICKETreturnMONEY') }  
alter table TICKETTURNOVERDETAIL add ETICKETreturnMONEY NUMBER(15,2) default 0;
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('TICKETTURNOVERDETAIL') AND COLUMN_NAME = upper('ETICKETreturnnum') }  
alter table TICKETTURNOVERDETAIL add ETICKETreturnnum NUMBER(9) default 0;

@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('TICKETTURNOVERDETAIL') AND COLUMN_NAME = upper('eservicefee') }
alter table TICKETTURNOVERDETAIL add eservicefee NUMBER(9) default 0;
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('TICKETTURNOVERDETAIL') AND COLUMN_NAME = upper('ebookservicefee') }  
alter table TICKETTURNOVERDETAIL add ebookservicefee NUMBER(9) default 0;
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('TICKETTURNOVERDETAIL') AND COLUMN_NAME = upper('echangeservicefee') }  
alter table TICKETTURNOVERDETAIL add echangeservicefee NUMBER(9) default 0;
-- Add comments to the columns 
comment on column TICKETTURNOVERDETAIL.eticketreturncharge
  is '电子票退票手续费';
comment on column TICKETTURNOVERDETAIL.eticketreturnmoney
  is '电子票退票金额';
comment on column TICKETTURNOVERDETAIL.eticketreturnnum
  is '电子票退票数';
comment on column TICKETTURNOVERDETAIL.eservicefee
  is '电子补票服务费';
comment on column TICKETTURNOVERDETAIL.ebookservicefee
  is '电子订票服务费';
comment on column TICKETTURNOVERDETAIL.echangeservicefee
  is '电子改签服务费';
  
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('ticketturnover') AND COLUMN_NAME = upper('ETICKETreturnCHARGE') }  
alter table ticketturnover add ETICKETreturnCHARGE NUMBER(15,2) default 0;
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('ticketturnover') AND COLUMN_NAME = upper('ETICKETreturnMONEY') }  
alter table ticketturnover add ETICKETreturnMONEY NUMBER(15,2) default 0;
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('ticketturnover') AND COLUMN_NAME = upper('ETICKETreturnnum') }  
alter table ticketturnover add ETICKETreturnnum NUMBER(3);
-- Add comments to the columns 
comment on column ticketturnover.eticketreturncharge
  is '电子票退票手续费';
comment on column ticketturnover.eticketreturnmoney
  is '电子票退票金额';
comment on column ticketturnover.eticketreturnnum
  is '电子票退票数';
  
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('INSURANCETURNOVERDETAIL') AND COLUMN_NAME = upper('ereturncharge') }    
alter table INSURANCETURNOVERDETAIL add ereturncharge NUMBER(15,2) default 0;
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('INSURANCETURNOVERDETAIL') AND COLUMN_NAME = upper('ereturnmoney') }  
alter table INSURANCETURNOVERDETAIL add ereturnmoney NUMBER(15,2) default 0;
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('INSURANCETURNOVERDETAIL') AND COLUMN_NAME = upper('ereturnnum') }  
alter table INSURANCETURNOVERDETAIL add ereturnnum NUMBER(3);
-- Add comments to the columns 
comment on column INSURANCETURNOVERDETAIL.ereturncharge
  is '电子退保险手续费';
comment on column INSURANCETURNOVERDETAIL.ereturnmoney
  is '电子退保险金额';
comment on column INSURANCETURNOVERDETAIL.ereturnnum
  is '电子退保险数';
--add by zqf 电子支付 end

--add by maxiao 电子支付增加字段 start 
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('ticketsellbysalerday') AND COLUMN_NAME = upper('paymethod')}
alter table ticketsellbysalerday add paymethod varchar2(10); 
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('ticketsellbysalerday') AND COLUMN_NAME = upper('ticketoutletsid')}
alter table ticketsellbysalerday add ticketoutletsid  number(10);
--add by maxiao 电子支付增加字段 end

--begin  addby 遥路  2016-9-20
@repeat{SELECT COUNT(*) FROM functionreg  where ID=530 }
insert into functionreg(ID, packagename, name,functionkey, functiondescribe,parameterdescribe,createtime,createby, updatetime,updateby,instruction)
  values(530,'QueryCanceledInsurance.bpl','废保明细查询','{E823BF90-0521-4AC6-8C64-F15262D02F85}','废保明细查询','',sysdate,1158013,sysdate, 1158013,null);
@repeat{SELECT COUNT(*) FROM menu  where ID=530 }
insert into menu(ID,name,functionregid,grade, orderno,parentid,parameter,createtime,createby,updatetime,updateby,clicknum,clazz,url,icon,systype,menutype)
values (530,'废保明细查询',530,3,11.06,30,'',sysdate,0,sysdate,0,0,'','','',0,1);
--end

--add by zhangqingfeng保险服务器增加保险订单号 start
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('insurance') AND COLUMN_NAME = upper('platforminsuranceno')}
alter table insurance add platforminsuranceno varchar2(50);
comment on column insurance.platforminsuranceno
  is '保险订单号';
--add by zhangqingfeng 保险服务器增加保险订单号 end

--add by zhaomingliang 线路表增加字段打印模版ID start
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('ROUTE') AND COLUMN_NAME = upper('PRINTTEMPLATEID')}
alter table route add(printtemplateid number(10) default 0);
comment on COLUMN route.printtemplateid is '打印模版ID';
-- add by zhaomingliang 线路表增加字段打印模版ID end

--begin 刘红超  银行名称长度不够 2016/11/16   --
@repeat{SELECT 1-COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('GATEWAY') AND COLUMN_NAME = upper('bankname') }
alter table GATEWAY modify bankname VARCHAR2(50);
---end ---
