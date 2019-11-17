@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('TICKETSELL') AND COLUMN_NAME = upper('CUSTOMername')}
alter table TICKETSELL add CUSTOMername VARCHAR2(50);

@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('TICKETSELL') AND COLUMN_NAME = upper('CERTIFICATETYPENAME')}
alter table TICKETSELL add CERTIFICATETYPENAME VARCHAR2(50);

@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('TICKETSELL') AND COLUMN_NAME = upper('CERTIFICATENO')}
alter table TICKETSELL add CERTIFICATENO VARCHAR2(50)  null;

@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('TICKETSELL') AND COLUMN_NAME = upper('vehicleid')}
alter table TICKETSELL add vehicleid NUMBER(10);

@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('TICKETSELL') AND COLUMN_NAME = upper('DEPARTINVOICESNO')}
alter table TICKETSELL add DEPARTINVOICESNO VARCHAR2(20)  null;

@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('TICKETSELL') AND COLUMN_NAME = upper('VEHICLEBRANDMODELID')}
alter table TICKETSELL add VEHICLEBRANDMODELID NUMBER(10)  null;


comment on column TICKETSELL.VEHICLEBRANDMODELID  is '计划报到车辆品牌型号ID';

comment on column TICKETSELL.CUSTOMername  is '旅客姓名';

comment on column TICKETSELL.CERTIFICATETYPENAME IS '证件类型名称';

comment on column TICKETSELL.CERTIFICATENO  is '证件号码';

comment on column TICKETSELL.vehicleid  is '报到车辆ID';

comment on column TICKETSELL.DEPARTINVOICESNO  is '单号';


@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('TICKETSELLAGENT') AND COLUMN_NAME = upper('CUSTOMERNAME')}
alter table TICKETSELLAGENT add CUSTOMERNAME VARCHAR2(50);

@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('TICKETSELLAGENT') AND COLUMN_NAME = upper('CERTIFICATETYPENAME')}
alter table TICKETSELLAGENT add CERTIFICATETYPENAME VARCHAR2(50);

@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('TICKETSELLAGENT') AND COLUMN_NAME = upper('CERTIFICATENO')}
alter table TICKETSELLAGENT add CERTIFICATENO VARCHAR2(50);

comment on column TICKETSELLAGENT.CUSTOMERNAME  is '旅客姓名';
comment on column TICKETSELLAGENT.CERTIFICATETYPENAME  is '证件类型';
comment on column TICKETSELLAGENT.CERTIFICATENO  is '证件号码';


--begin 增加检票日志表
@repeat{select count(*) from user_tables where table_name=upper('CHECKTICKETLOG')}
create table CHECKTICKETLOG
(
  ID               NUMBER(10) not null ,
  DEPARTDATE       DATE ,
  DEPARTTIME       VARCHAR2(5) ,
  SCHEDULECODE     VARCHAR2(30) ,
  REACHSTATION     VARCHAR2(50) ,
  TICKETNO         VARCHAR2(20) ,
  CHECKEDBY        VARCHAR2(30) ,
  CHECKTIME        DATE  default SYSDATE not null,
  CHECKEDIP        VARCHAR2(40),
  CHECKEDBYCODE    VARCHAR2(10),
  CHECKTYPE        VARCHAR2(10) ,
  OPERATIONTYPE    VARCHAR2(10) ,
  CUSTOMERNAME     VARCHAR2(30) ,
  CERTIFICATETYPE  VARCHAR2(20),
  CERTIFICATENO    VARCHAR2(50),
  primary key (ID) 
);
-- Add comments to the table 
comment on table CHECKTICKETLOG
  is '检票日志表';
-- Add comments to the columns 
comment on column CHECKTICKETLOG.SCHEDULECODE
  is '班次号';
comment on column CHECKTICKETLOG.REACHSTATION
  is '到达站';
comment on column CHECKTICKETLOG.TICKETNO
  is '票号';
comment on column CHECKTICKETLOG.CHECKEDBY
  is '检票人';
comment on column CHECKTICKETLOG.CHECKTIME
  is '检票时间';
comment on column CHECKTICKETLOG.CHECKEDIP
  is '检票机器IP';
comment on column CHECKTICKETLOG.CHECKEDBYCODE
  is '检票人工号';
comment on column CHECKTICKETLOG.CHECKTYPE
  is '检票类型：0：条码检票、1：全检、2：补检、3：混检、4：连检、5：实名制检票、6：条码实名制检票。其中直接扫描票号进行检票的记录为0，直接刷身份证或输入证件号检票的记录为5，先扫描票号查询出车票和证件信息再检票的记录为6。';
comment on column CHECKTICKETLOG.OPERATIONTYPE
  is '2)	操作类型：包括0：检票，1退检';
comment on column CHECKTICKETLOG.CUSTOMERNAME
  is '顾客姓名';
comment on column CHECKTICKETLOG.CERTIFICATETYPE
  is '顾客证件类型';
comment on column CHECKTICKETLOG.CERTIFICATENO
  is '顾客证件号';
--end
  
--begin 孙越 2016年8月29日 11:22:37 vehicle 表添加线路标志牌起止日期 --
-- Add/modify columns 
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('VEHICLE') AND COLUMN_NAME = upper('roadstartdate')}
alter table VEHICLE add roadstartdate date;
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('VEHICLE') AND COLUMN_NAME = upper('roadenddate')}
alter table VEHICLE add roadenddate date;
-- Add comments to the columns 
comment on column VEHICLE.roadstartdate
  is '线路标志牌起始时间';
comment on column VEHICLE.roadenddate
  is '线路标志牌截止时间';
--end--



--begin
@repeat{select count(*) from user_tables where table_name=upper('schedulestartcheck') }
create table schedulestartcheck
(
  ID         NUMBER(10) not null,
  scheduleid NUMBER(10) not null,
  vehicleid  NUMBER(10) not null,
  orgid      NUMBER(10) not null,
  departdate Date not null,
  driver1id  NUMBER(10) not null,
  driver2id  NUMBER(10),
  driver3id  NUMBER(10),
  driver4id  NUMBER(10),
  CREATETIME DATE default SYSDATE not null,
  CREATEBY   NUMBER(10) not null,
  UPDATETIME DATE default SYSDATE not null,
  UPDATEBY   NUMBER(10) not null
);
--end

-- Add comments to the table 
comment on table schedulestartcheck
  is '发班前身份验证';
-- Add comments to the columns 
comment on column schedulestartcheck.scheduleid
  is '班次id';
comment on column schedulestartcheck.vehicleid
  is '车辆id';
comment on column schedulestartcheck.departdate
  is '发车日期';
-- Create/Recreate primary, unique and foreign key constraints 


--处理营运车辆违规情况处理添加报错问题
@repeat{SELECT 1-COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('vehicleviolation') AND COLUMN_NAME = upper('routename')}
alter table vehicleviolation modify routename VARCHAR2(80);

@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('pack') AND COLUMN_NAME = upper('agentfee')}
alter table pack add agentfee NUMBER(10,2) default 0;    
-- Add comments to the columns 
comment on column pack.agentfee
  is '货代费';

@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('TICKETSELL') AND COLUMN_NAME = upper('olddepartdate')}
alter table TICKETSELL add olddepartdate DATE null;


comment on column TICKETSELL.olddepartdate  is '混检前发车日期';  
--  begin jyr 将证件类型 临时身份证 改为手机号
@repeat{SELECT COUNT(*)-1 FROM digitaldictionarydetail WHERE digitaldictionaryid = 35 AND code = 1 }
update digitaldictionarydetail d set d.value = '手机号' where d.digitaldictionaryid = 35 and code = 1;
--end