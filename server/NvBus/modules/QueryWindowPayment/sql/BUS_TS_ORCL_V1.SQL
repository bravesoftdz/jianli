@repeat{SELECT COUNT(1) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('PAYINFO') AND COLUMN_NAME = upper('tickets') }
alter table PAYINFO add tickets NUMBER(6) default 0;
@repeat{SELECT COUNT(1) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('PAYINFO') AND COLUMN_NAME = upper('ticketprice') }
alter table PAYINFO add ticketprice NUMBER(10,2) default 0 ;
@repeat{SELECT COUNT(1) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('PAYINFO') AND COLUMN_NAME = upper('insures') }
alter table PAYINFO add insures NUMBER(6) default 0;
@repeat{SELECT COUNT(1) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('PAYINFO') AND COLUMN_NAME = upper('insurefee') }
alter table PAYINFO add insurefee NUMBER(10,2) default 0 ;
-- Add comments to the columns 
@repeat{SELECT 1 - COUNT(1) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('PAYINFO') AND COLUMN_NAME = upper('tickets') }
comment on column PAYINFO.tickets
  is '售票数';
@repeat{SELECT 1 - COUNT(1) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('PAYINFO') AND COLUMN_NAME = upper('ticketprice') }
comment on column PAYINFO.ticketprice
  is '售票金额';
@repeat{SELECT 1 - COUNT(1) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('PAYINFO') AND COLUMN_NAME = upper('insures') }
comment on column PAYINFO.insures
  is '售保数';
@repeat{SELECT 1 - COUNT(1) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('PAYINFO') AND COLUMN_NAME = upper('insurefee') }
comment on column PAYINFO.insurefee
  is '售保金额';


@repeat{SELECT COUNT(1) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('payinfodetail') AND COLUMN_NAME = upper('tickets') }
alter table payinfodetail add tickets NUMBER(6) default 0 ;
@repeat{SELECT COUNT(1) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('payinfodetail') AND COLUMN_NAME = upper('ticketprice') }
alter table payinfodetail add ticketprice NUMBER(10,2) default 0 ;
@repeat{SELECT COUNT(1) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('payinfodetail') AND COLUMN_NAME = upper('insures') }
alter table payinfodetail add insures NUMBER(6) default 0 ;
@repeat{SELECT COUNT(1) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('payinfodetail') AND COLUMN_NAME = upper('insurefee') }
alter table payinfodetail add insurefee NUMBER(10,2) default 0 ;
-- Add comments to the columns 
@repeat{SELECT 1-COUNT(1) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('payinfodetail') AND COLUMN_NAME = upper('tickets') }
comment on column payinfodetail.tickets is '退票数';
@repeat{SELECT 1-COUNT(1) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('payinfodetail') AND COLUMN_NAME = upper('ticketprice') }
comment on column payinfodetail.ticketprice is '退票金额';
@repeat{SELECT 1-COUNT(1) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('payinfodetail') AND COLUMN_NAME = upper('insures') }
comment on column payinfodetail.insures is '退保数';
@repeat{SELECT 1-COUNT(1) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('payinfodetail') AND COLUMN_NAME = upper('insurefee') }
comment on column payinfodetail.insurefee is '退保金额';

@repeat{select count(1) from user_indexes  u where u.index_name = upper('idx_ticketorderno')}
create index idx_ticketorderno on TICKETSELL (orderno);