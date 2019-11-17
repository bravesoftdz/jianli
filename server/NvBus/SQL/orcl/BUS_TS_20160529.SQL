@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('DEPARTINVOICESOTHER') AND COLUMN_NAME = upper('OTHTERFEE')}
alter table DEPARTINVOICESOTHER add OTHTERFEE NUMBER(10,2) default 0;    
-- Add comments to the columns 
comment on column DEPARTINVOICESOTHER.OTHTERFEE
  is '其它开运量单时预扣票价分项金额';
  
@repeat{SELECT COUNT(*) FROM parameter where ID=3068}
insert into parameter  values(3068,'30','3068','0',1,1,'手工结算单是否进行结算扣费',sysdate,0,'是否');

@repeat{SELECT COUNT(*) - 1 FROM PARAMETER where code = '3068'}
update parameter t set t.remark = '手工结算单是否进行结算扣费; 0:不开启扣费,1:开启扣费; 默认为0' where t.code = '3068';