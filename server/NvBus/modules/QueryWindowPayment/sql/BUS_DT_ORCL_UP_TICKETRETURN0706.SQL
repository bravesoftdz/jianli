--窗口现金售票，退票返款模式存为了1
@repeat{select count(*) from user_tables where table_name=upper('ticketreturn_bak_180706')}
create table ticketreturn_bak_180706 as 
select 
	-- tr.returnfeemode, tr.returntime,
       tr.*
  from ticketsell t, ticketreturn tr
 where t.id = tr.sellid
   and t.sellway = '0'
   and t.paymethod = 0
   and tr.returnfeemode = 1
   and t.departdate > to_date('20180501','yyyymmdd') 
   order by tr.returntime;

--修复ticketreturn记录   
@repeat{select count(*) - 1 from user_tables where table_name=upper('ticketreturn_bak_180706')}
update ticketreturn tr set tr.returnfeemode = '0' where tr.id in (select t.id from ticketreturn_bak_180706 t where t.updateby > 0);

--修改备份退票表数据更新人为0
@repeat{select count(*) - 1 from user_tables where table_name=upper('ticketreturn_bak_180706')}
update ticketreturn_bak_180706 t set t.updateby = 0;



--begin 现金售保险，返款模式存为了1
@repeat{select count(*) from user_tables where table_name=upper('insurancereturn_bak_20180706')}
create table insurancereturn_bak_20180706 as 
select * from insurancereturn t  where t.paymethod = '0' and t.returnfeemode = '1';

@repeat{select count(*) - 1 from user_tables where table_name=upper('insurancereturn_bak_20180706')}
update insurancereturn t set t.returnfeemode = '0' where t.insuranceid in (select b.insuranceid from insurancereturn_bak_20180706 b where b.updateby > 0);

@repeat{select count(*) - 1 from user_tables where table_name=upper('insurancereturn_bak_20180706')}
update insurancereturn_bak_20180706 t set t.updateby = 0;
--end