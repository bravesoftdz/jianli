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

@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('SPECIALORDERINFO') AND COLUMN_NAME = upper('sellorgcode')}
alter table SPECIALORDERINFO add sellorgcode VARCHAR2(40);
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('SPECIALORDERINFO') AND COLUMN_NAME = upper('sellorgname')}
alter table SPECIALORDERINFO add sellorgname VARCHAR2(100);
-- Add comments to the columns 
comment on column SPECIALORDERINFO.sellorgcode
  is '代售机构编码';
comment on column SPECIALORDERINFO.sellorgname
  is '代售机构名称';
  
@repeat{select count(1) from user_indexes t where t.table_name = 'TICKETSELL' and t.index_name = 'IDX_TSCERTIFICATETYPNO' }
create index IDX_TScertificatetypno on TICKETSELL (certificatetypename, certificateno);

@repeat{select count(*) from user_tables where table_name=upper('TICKETOUTLETSTYPEPRICE') }
create table TICKETOUTLETSTYPEPRICE
(
  ID                  NUMBER(10) not null,
  TICKETOUTLETSID     NUMBER(10) not null,
  ROUTEID             NUMBER(10) not null,
  SCHEDULEID          NUMBER(10) not null,
  FULLPRICEFORMULA    VARCHAR2(200) not null,
  HALFPRICEFORMULA    VARCHAR2(200) not null,
  STUDENTPRICEFORMULA VARCHAR2(200) not null,
  STARTDATE           DATE not null,
  ENDDATE             DATE not null,
  CREATETIME          DATE default SYSDATE,
  CREATEBY            NUMBER(10),
  UPDATETIME          DATE default SYSDATE,
  UPDATEBY            NUMBER(10)
);
-- Add comments to the table 
comment on table TICKETOUTLETSTYPEPRICE
  is '售票点票种差额';
-- Add comments to the columns 
comment on column TICKETOUTLETSTYPEPRICE.TICKETOUTLETSID
  is '售票点ID';
comment on column TICKETOUTLETSTYPEPRICE.ROUTEID
  is '线路ID';
comment on column TICKETOUTLETSTYPEPRICE.SCHEDULEID
  is '班次ID';
comment on column TICKETOUTLETSTYPEPRICE.FULLPRICEFORMULA
  is '全票差额公式';
comment on column TICKETOUTLETSTYPEPRICE.HALFPRICEFORMULA
  is '半票差额公式';
comment on column TICKETOUTLETSTYPEPRICE.STUDENTPRICEFORMULA
  is '学生票差额公式';
comment on column TICKETOUTLETSTYPEPRICE.STARTDATE
  is '开始时间';
comment on column TICKETOUTLETSTYPEPRICE.ENDDATE
  is '结束时间';
@repeat{select count(*) from user_constraints t where t.table_name = 'TICKETOUTLETSTYPEPRICE' and t.constraint_type = 'P' }
alter table TICKETOUTLETSTYPEPRICE add constraint PK_TICKETOUTLETSTYPEPRICE primary key (ID);
@repeat{select count(1) from user_indexes t where t.table_name = 'TICKETOUTLETSTYPEPRICE' and t.index_name = 'IDX_TIME1' }
create unique index IDX_TIME1 on TICKETOUTLETSTYPEPRICE (TICKETOUTLETSID, ROUTEID, SCHEDULEID, STARTDATE, ENDDATE);

--begin zhaohuaihu 20170824 #11365 车辆安检记录增加通知单重打次数字段
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('SECURITYCHECK') AND COLUMN_NAME = upper('reprinttimes')}
alter table SECURITYCHECK add reprinttimes NUMBER(5) default 0 not null;
comment on column SECURITYCHECK.reprinttimes is '车辆安检通知单重打次数，默认为重打0次';
--end


--begin 2017-08-31 zhangqingfeng 电子支付退票业务修改
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('ticketturnoverdetail') AND COLUMN_NAME = upper('chargesweb')}
alter table ticketturnoverdetail add chargesweb NUMBER(15,2) default 0;
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('ticketturnoverdetail') AND COLUMN_NAME = upper('returnamountweb')}
alter table ticketturnoverdetail add returnamountweb NUMBER(15,2) default 0;
comment on column TICKETTURNOVERDETAIL.chargesweb
  is '网售原路返还手续费';
comment on column TICKETTURNOVERDETAIL.returnamountweb
  is '网售原路返还退票金额';
--end 2017-08-31 zhangqingfeng 


@repeat{select count(1) from user_indexes t where t.table_name = 'TICKETMIXCHECK' and upper(t.index_name) = upper('idx_ticketmix2') }
create index idx_ticketmix2 on TICKETMIXCHECK (ticketsellid, isactive);

--begin 2017-10-17 zhaohh 售票缴款明细增加字段，记录改签、补票凭证打印张数
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('TICKETTURNOVERDETAIL') AND COLUMN_NAME = upper('TICKETPRINTNUM')}
alter table TICKETTURNOVERDETAIL add TICKETPRINTNUM NUMBER(9) default 0 not null;
comment on column TICKETTURNOVERDETAIL.TICKETPRINTNUM is '售票、改签、补票等打印物理票张数：包含车票数、改签凭证数、补票凭证数';
  
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('TICKETTURNOVERDETAIL') AND COLUMN_NAME = upper('CHANGEPRINTNUM')} 
alter table TICKETTURNOVERDETAIL add CHANGEPRINTNUM NUMBER(9) default 0 not null;
comment on column TICKETTURNOVERDETAIL.CHANGEPRINTNUM is '改签凭证打印张数';

@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('TICKETTURNOVERDETAIL') AND COLUMN_NAME = upper('SUPPLEMENTPRINTNUM')} 
alter table TICKETTURNOVERDETAIL add SUPPLEMENTPRINTNUM NUMBER(9) default 0 not null;
comment on column TICKETTURNOVERDETAIL.SUPPLEMENTPRINTNUM is '补票凭证打印张数';
--end 2017-10-17 zhaohh 

--add by zhangxibao 行包表（pack）中增加托运人证件类型字段 start 2017-10-23
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('pack') AND COLUMN_NAME = upper('sendercertificatetype')}
alter table pack add sendercertificatetype varchar2(10);
comment on column PACK.SENDERCERTIFICATETYPE
  is '托运人证件类型：0：身份证，1：学生证，2：军官证，3：教师证 取数据字典';
--add by zhangxibao end

--add by zhangxibao 行包表（pack）中增加托运人证件类型字段 start  2017-10-23
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('pack') AND COLUMN_NAME = upper('sendercertificateno')}
alter table pack add sendercertificateno varchar2(30);
comment on column PACK.SENDERCERTIFICATENO
  is '托运人证件号码';
--add by zhangxibao end

--孙越 2017年10月26日 14:42:34 vehicle 增加字段 --
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('VEHICLE') AND COLUMN_NAME = upper('businesscertificateno')}
alter table VEHICLE add businesscertificateno VARCHAR2(30);
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('VEHICLE') AND COLUMN_NAME = upper('businesscertificatestartdate')}
alter table VEHICLE add businesscertificatestartdate date;
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('VEHICLE') AND COLUMN_NAME = upper('businesscertificateenddate')}
alter table VEHICLE add businesscertificateenddate date;
comment on column VEHICLE.businesscertificateno
  is '经营许可证号';
comment on column VEHICLE.businesscertificatestartdate
  is '经营许可证有效期开始日期';
comment on column VEHICLE.businesscertificateenddate
  is '经营许可证有效期截止日期';
--end--
  
--add by zhangxibao 路单打印表（roadbillprint）中增加路单编号字段 start  2017-11-1
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('ROADBILLPRINT') AND COLUMN_NAME = upper('waybillnumber')}
alter table roadbillprint add waybillnumber number(10);
comment on column ROADBILLPRINT.waybillnumber
  is '路单编号';
--add by zhangxibao end
  
-- Create sequence zhangxibao 建序列，用于路单编号的取值  start  2017-11-1
@repeat{select count(*) from user_sequences t  where upper（t.sequence_name）='SEQ_ROADBILLPRINT'}
create sequence SEQ_ROADBILLPRINT
minvalue 1
maxvalue 9999999999
start with 1
increment by 1
cache 20;
--end

--add by zhangxibao 驾驶员表（driver）中增加 全拼   字段 start  2017-11-2
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('DRIVER') AND COLUMN_NAME = upper('quanpin')}
alter table driver add quanpin VARCHAR2(50);
comment on column DRIVER.quanpin
  is '全拼';
--add by zhangxibao end
  
--add by zhangxibao 车辆违规管理表（vehicleviolation）中增加 “结算单ID”  字段 start  2017-11-2
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('VEHICLEVIOLATION') AND COLUMN_NAME = upper('departinvoicesid')}
alter table VEHICLEVIOLATION add departinvoicesid NUMBER(10);
comment on column VEHICLEVIOLATION.departinvoicesid
  is '结算单ID';
--add by zhangxibao end

--add by zhangxibao 车辆违规管理表（vehicleviolation）中增加 “现金罚款”  字段 start  2017-11-6
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('VEHICLEVIOLATION') AND COLUMN_NAME = upper('iscash')}
alter table VEHICLEVIOLATION add iscash VARCHAR2(1);
comment on column VEHICLEVIOLATION.iscash
  is '现金罚款0:非现金1:现金';
--add by zhangxibao end
  
  
update  vehicle t set t.nextmaintaindistance=0  where t.nextmaintaindistance is null;
-- Add/modify columns 

@repeat{select count(*) from user_tab_cols t where table_name=upper('VEHICLE') and t.COLUMN_NAME=upper('nextmaintaindistance') and t.NULLABLE='N'}
alter table VEHICLE modify nextmaintaindistance not null;

@repeat{select count(*) from user_tab_cols t  where t.TABLE_NAME = upper('OPERATIONLOG')  and t.COLUMN_NAME = upper('content')  and t.NULLABLE = 'Y'}
alter table OPERATIONLOG modify content  null;

--begin 2017年12月21日19:53:15 zhangxibao 客户表新加冗余字段，用于查询
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('CUSTOMER') AND COLUMN_NAME = upper('departstationname') }
alter table CUSTOMER add departstationname VARCHAR2(20);
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('CUSTOMER') AND COLUMN_NAME = upper('reachstationname') }
alter table CUSTOMER add reachstationname VARCHAR2(20);
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('CUSTOMER') AND COLUMN_NAME = upper('endstationname') }
alter table CUSTOMER add endstationname VARCHAR2(20);
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('CUSTOMER') AND COLUMN_NAME = upper('schcode') }
alter table CUSTOMER add schcode VARCHAR2(10);
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('CUSTOMER') AND COLUMN_NAME = upper('planvehicleno') }
alter table CUSTOMER add planvehicleno VARCHAR2(20);
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('CUSTOMER') AND COLUMN_NAME = upper('ticketno') }
alter table CUSTOMER add ticketno VARCHAR2(20);
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('CUSTOMER') AND COLUMN_NAME = upper('departdate') }
alter table CUSTOMER add departdate Date;
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('CUSTOMER') AND COLUMN_NAME = upper('departtime') }
alter table CUSTOMER add departtime CHAR(5);
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('CUSTOMER') AND COLUMN_NAME = upper('ticketstatus') }
alter table CUSTOMER add ticketstatus VARCHAR2(10);
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('CUSTOMER') AND COLUMN_NAME = upper('seatno') }
alter table CUSTOMER add seatno NUMBER(4);
-- Add comments to the columns 
comment on column CUSTOMER.departstationname is '发车站';
comment on column CUSTOMER.reachstationname is '到达站';
comment on column CUSTOMER.endstationname is '终点站';
comment on column CUSTOMER.schcode is '班次';
comment on column CUSTOMER.planvehicleno is '车牌号码';
comment on column CUSTOMER.ticketno is '票号';
comment on column CUSTOMER.departdate is '发车日期';
comment on column CUSTOMER.departtime is '发车时间';
comment on column CUSTOMER.ticketstatus is '车票状态：0-正常，1-退票，2-废票 取数据字典';
comment on column CUSTOMER.seatno is '座位号';
--end 2017年12月21日19:53:15 zhangxibao 客户表新加冗余字段，用于查询

--begin  2018年2月1日15:34:03 zhangxibao 修改pack表中表字段的长度
@repeat{select count(*)-1 from user_tab_cols t where table_name=upper('PACK') and t.COLUMN_NAME=upper('sendercertificatetype')}
alter table PACK modify sendercertificatetype VARCHAR2(30);
--end

--增加保险售票时间索引
@repeat{select  count(*) from   dba_indexes t  where upper(t.index_name)=upper('IDX_INSELLTIME')}
create index idx_inselltime on INSURANCE (SELLTIME, SELLBY)
  tablespace TS_DEPARTINVOICES
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
 );


@repeat{select count(*) from user_tables where table_name=upper('SEATRESERVEORDER') }
create table SEATRESERVEORDER
(
  id            NUMBER(10) not null,
  orderno       VARCHAR2(20) not null,
  seatreserveid NUMBER(10) not null,
  status        NUMBER(1) default 0 not null,
  createtime    DATE default SYSDATE not null,
  createby      NUMBER(10) default 0 not null,
  updatetime    DATE default SYSDATE not null,
  updateby      NUMBER(10) default 0 not null
);
-- Add comments to the columns 
comment on column SEATRESERVEORDER.orderno
  is '订单号';
comment on column SEATRESERVEORDER.seatreserveid
  is '座位预留表ID';
comment on column SEATRESERVEORDER.status
  is '0为正常,1为删除';
-- Create/Recreate indexes 
@repeat{select  count(*) from   dba_indexes t  where upper(t.index_name)=upper('IDX_SEATRESERVEORDER')}
create unique index IDX_SEATRESERVEORDER on SEATRESERVEORDER (ORDERNO, SEATRESERVEID);
@repeat{select count(*) from user_constraints t where t.table_name = 'SEATRESERVEORDER' and t.constraint_type = 'P' }
alter table SEATRESERVEORDER  add constraint PK_SEATRESERVEORDER primary key (ID);


--begin 20180416 zhaohh 修改顾客表中红名单字段不允许为空
@repeat{select count(*) - 1 from user_tab_cols t where table_name=upper('customer') and t.COLUMN_NAME=upper('isred')}
update customer t set t.isred = 0 where t.isred is null;
@repeat{select count(*) - 1 from dba_tab_columns t where t.TABLE_NAME ='CUSTOMER' AND T.COLUMN_NAME = 'ISRED' AND T.NULLABLE = 'Y'}
alter table CUSTOMER modify ISRED default 0 not null;
--end
--begin 20180418 zqf 修改结算单字段精确度
@repeat{SELECT 1-COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('balance') AND COLUMN_NAME = upper('packmoney') }
alter table balance modify  packmoney number(12,2);
@repeat{SELECT 1-COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('balance') AND COLUMN_NAME = upper('ticketincome') }
alter table balance modify  ticketincome number(12,2);
@repeat{SELECT 1-COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('balance') AND COLUMN_NAME = upper('additionfee') }
alter table balance modify  additionfee number(12,2);
@repeat{SELECT 1-COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('balance') AND COLUMN_NAME = upper('divide') }
alter table balance modify  divide number(12,2);
@repeat{SELECT 1-COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('balance') AND COLUMN_NAME = upper('packprice') }
alter table balance modify  packprice number(12,2);
@repeat{SELECT 1-COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('balance') AND COLUMN_NAME = upper('rentmoney') }
alter table balance modify  rentmoney number(12,2);
@repeat{SELECT 1-COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('balance') AND COLUMN_NAME = upper('rentprice') }
alter table balance modify  rentprice number(12,2);
@repeat{SELECT 1-COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('balance') AND COLUMN_NAME = upper('debit') }
alter table balance modify  debit number(12,2);
@repeat{SELECT 1-COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('balance') AND COLUMN_NAME = upper('backmoney') }
alter table balance modify  backmoney number(12,2);
@repeat{SELECT 1-COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('balance') AND COLUMN_NAME = upper('bysj') }
alter table balance modify  bysj number(12,2);
@repeat{SELECT 1-COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('balance') AND COLUMN_NAME = upper('syqj') }
alter table balance modify  syqj number(12,2);
@repeat{SELECT 1-COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('balance') AND COLUMN_NAME = upper('goodsagent') }
alter table balance modify  goodsagent number(12,2);
@repeat{SELECT 1-COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('balance') AND COLUMN_NAME = upper('packamount') }
alter table balance modify  packamount number(12,2);
--end
