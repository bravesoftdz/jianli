-- 孙越 2016年11月2日 15:36:04  vehicle 表 添加 燃料类型字段 --
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('BALANCE') AND COLUMN_NAME = upper('packamount')}
alter table BALANCE add packamount NUMBER(8,2) default 0.00;
-- Add comments to the columns 
comment on column BALANCE.packamount
  is '货票金额';
-- end --
--张清风 2016年12月21日17:29:45 营收缴款增加支付明细 start--
@repeat{select count(*) from user_tables where table_name=upper('Ticketturnoverdetailepay') }
create table Ticketturnoverdetailepay
(
   id  number(10) not null primary key,
   ticketturnoverdetailid number(10) not null,
   paymethod char(1),
   price number(10,2),
   ticketnum number(6) default 0,
   createtime DATE default SYSDATE not null,
   createby               NUMBER(10) not null,
   updatetime             DATE default SYSDATE not null,
   updateby               NUMBER(10) not null
);
@repeat{select count(*) from user_sequences t  where upper（t.sequence_name）='SEQ_TICKETTURNOVERDETAILEPAY'}
create sequence SEQ_TICKETTURNOVERDETAILEPAY
minvalue 1
maxvalue 9999999999
start with 10001
increment by 1
nocache;
--张清风 2016年12月21日17:29:45 营收缴款增加支付明细 start--

--begin 孙越 2016年12月22日 09:28:52  添加表--
@repeat{select count(*) from user_tables where table_name=upper('NETSALECONTROL') }
create table NETSALECONTROL
(
  id         NUMBER(10) not null PRIMARY KEY,
  orgid      NUMBER(10) not null,
  netorgid   NUMBER(10) not null,
  scheduleid NUMBER(10) not null,
  routeid    NUMBER(10) not null,
  createtime DATE not null,
  createby   NUMBER(10) not null,
  updatetime DATE not null,
  updateby   NUMBER(10) not null
); 
-- Add comments to the columns 
comment on column NETSALECONTROL.orgid
  is '所属机构';
comment on column NETSALECONTROL.netorgid
  is '网售机构';
comment on column NETSALECONTROL.scheduleid
  is '班次';
comment on column NETSALECONTROL.routeid
  is '线路';
--end--
@repeat{SELECT 1-COUNT(*)  FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('TICKETOUTLETSUNSELLSTATION') AND COLUMN_NAME = upper('STATIONID') AND NULLABLE = 'N'}
alter table TICKETOUTLETSUNSELLSTATION modify STATIONID null;