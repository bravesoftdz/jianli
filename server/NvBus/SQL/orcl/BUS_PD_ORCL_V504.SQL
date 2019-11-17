
--begin 2016-12-16 zhaohh 售票员售票情况日报表增加字段： 改签数、  补票，特权补票凭证数、 退票凭证数、 当日售当日票并且是正常票的营收（当日当班营收）
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('TICKETSELLBYSALERDAY') AND COLUMN_NAME = upper('ticketoutletsid')} 
alter table TICKETSELLBYSALERDAY add ticketoutletsid number(10);

@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('TICKETSELLBYSALERDAY') AND COLUMN_NAME = upper('paymethod')} 
alter table TICKETSELLBYSALERDAY add paymethod varchar2(10) default '0';

@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('TICKETSELLBYSALERDAY') AND COLUMN_NAME = upper('changenum')} 
alter table TICKETSELLBYSALERDAY add changenum NUMBER(5) default 0;
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('TICKETSELLBYSALERDAY') AND COLUMN_NAME = upper('adjustnum')} 
alter table TICKETSELLBYSALERDAY add adjustnum NUMBER(5) default 0;
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('TICKETSELLBYSALERDAY') AND COLUMN_NAME = upper('returnbillnum')} 
alter table TICKETSELLBYSALERDAY add returnbillnum NUMBER(5) default 0;
@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('TICKETSELLBYSALERDAY') AND COLUMN_NAME = upper('datescheduleincome')} 
alter table TICKETSELLBYSALERDAY add datescheduleincome NUMBER(10,2) default 0;

@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('TICKETSELLBYSALERDAY') AND COLUMN_NAME = upper('takeeticketnum')} 
alter table TICKETSELLBYSALERDAY add takeeticketnum NUMBER(5) default 0;
 

-- Create sequence 
@repeat{select count(*) from user_sequences t  where upper（t.sequence_name）='SEQ_JOBLOG'}
create sequence SEQ_JOBLOG
minvalue 1
maxvalue 9999999999
start with 100
increment by 1
cache 20;

@repeat{select count(*) from user_tables where table_name=upper('JOBLOG')}
create table JOBLOG
(
  id         NUMBER(10) not null,
  name       VARCHAR2(100) not null,
  runstatus  NUMBER(1) default 0 not null,
  isfirstrun NUMBER(1) default 1 not null,
  runnum     NUMBER(10) default 0 not null,
  runminute  NUMBER(10) default 0 not null,
  runtime    DATE default sysdate
);
-- Add comments to the columns 
comment on column JOBLOG.runstatus
  is '运行状态，未运行：0，正在运行：1';
comment on column JOBLOG.isfirstrun
  is '是否规定时间内的第一次运行';
comment on column JOBLOG.runnum
  is '运行次数';
comment on column JOBLOG.runminute
  is '本次执行分钟数';
comment on column JOBLOG.runtime
  is '本次运行时间';
-- Create/Recreate indexes 
@repeat{select count(*) from user_indexes t where t.table_name = 'JOBLOG' and t.index_name = 'IDXJOBLOGNAME' }
create unique index IDXJOBLOGNAME on JOBLOG (NAME);

@repeat{select count(*) from user_constraints t where t.table_name = 'JOBLOG' and t.constraint_type = 'P' }
alter table JOBLOG  add constraint PK_JOBLOGID primary key (ID);


@repeat{select count(*) from user_tables where table_name=upper('JOBLOGDETAIL')}
create table JOBLOGDETAIL
(
  id        NUMBER(10) not null,
  jobid     NUMBER(10) not null,
  selldate  DATE,
  runminute NUMBER(10) not null,
  runtime   DATE not null,
  runstatus NUMBER(1) default 0 not null,
  msg       VARCHAR2(1000)
);
-- Add comments to the columns 
comment on column JOBLOGDETAIL.runstatus
  is '运行状态，未运行：0，正在运行：1';
@repeat{select count(*) from user_indexes t where t.table_name = 'JOBLOGDETAIL' and t.index_name = 'IDX_JOBRUNTIME' }
create index IDX_JOBRUNTIME on JOBLOGDETAIL (RUNTIME);
@repeat{select count(*) from user_constraints t where t.table_name = 'JOBLOGDETAIL' and t.constraint_type = 'P' }
alter table JOBLOGDETAIL  add constraint PKJOBLOGDETAILID primary key (ID);


--beginblock
CREATE OR REPLACE PROCEDURE "DELOVERTIMESCHEDULE" IS
  lv_cycleschemesid number(10);
  lv_scheduleid     number(10);
  lv_userinfoid     number(10);
  CURSOR getovertimescheduleid IS
    select s.id, cs.id
      from cycleschemes cs, schedule s, cycleschemesschedule cd
     where cs.id = cd.cycleschemesid
       and s.id = cd.scheduleid
       and s.isovertime = 1
       and cs.enddate < trunc(sysdate)
     group by cs.id, s.id
    union all
    select s.id, 0
      from schedule s
     where s.id not in
           (select s.id
              from cycleschemes cs, schedule s, cycleschemesschedule cd
             where cs.id = cd.cycleschemesid
               and s.id = cd.scheduleid
               and s.isovertime = 1
               and cs.enddate > trunc(sysdate)
             group by cs.id, s.id)
       and s.isovertime = 1
    ;
  lv_recordcount number(10);
begin
  lv_userinfoid := 0;
  begin
    select u.id into lv_userinfoid from userinfo u where u.code = 'ADMIN';
  EXCEPTION
    WHEN OTHERS THEN
      lv_userinfoid := 0;
  end;
  OPEN getovertimescheduleid;
  LOOP
    FETCH getovertimescheduleid
      INTO lv_scheduleid, lv_cycleschemesid;
    EXIT WHEN getovertimescheduleid%NOTFOUND;
  
    select count(*)
      into lv_recordcount
      from scheduleplan sp
     where sp.scheduleid = lv_scheduleid
       and sp.departdate >= trunc(sysdate);
    if lv_recordcount = 0 then
      update schedule s
         set s.isactive   = 0,
             s.isdelete   = 1,
             s.updatetime = sysdate,
             s.updateby   = lv_userinfoid
       where s.id = lv_scheduleid;
      delete cycleschemesschedule t
       where t.cycleschemesid = lv_cycleschemesid;
      delete cycleschemesdriver t
       where t.cycleschemesid = lv_cycleschemesid;
      delete cycleschemessteward t
       where t.cycleschemesid = lv_cycleschemesid;
      delete cycleschemesvehicle t
       where t.cycleschemesid = lv_cycleschemesid;
      delete schedulecycle t where t.schemesid = lv_cycleschemesid;
      delete cycleschemes t where t.id = lv_cycleschemesid;
      COMMIT;
    end if;
  END LOOP;
  CLOSE getovertimescheduleid;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
END;;
--endblock

--beginblock
CREATE OR REPLACE PROCEDURE "GENTICKETSELLBYSALERDAY" IS
  lv_saledate    date;
  lv_maxsaledate date;
  i              integer;
  recordcount    integer;
  rate           number(5, 3);
  jobid number(10);
  lv_runstatus number;
  lv_begintime date;
  lv_curendtime date;
  lv_endtime date;
  lv_runminute number(10);
  lv_isfirstrun number;
  --lv_curtime varchar2(5);
  lv_msg  varchar2(1000);
begin
  delete  joblogdetail t where t.runtime<=trunc(sysdate-60);
  commit;
  begin
    select to_number(value)
      into rate
      from parameter p
     where p.code = '4002';
  exception
    when others then
      rate := 0.08;
  end;
  lv_runminute:=0;
  jobid:=0;
   select count(*)
       into recordcount  from
     JOBLOG t where upper(t.name)=upper('GENTICKETSELLBYSALERDAY');
  if recordcount=0 then
    insert into joblog
      (id, name, runstatus, isfirstrun, runnum, runminute, runtime)
    values
      (1, 'GENTICKETSELLBYSALERDAY',0,1,0,0,sysdate);
     commit;
  end if;
  select t.id ,t.runstatus,t.isfirstrun
         into  jobid,lv_runstatus,lv_isfirstrun
  from JOBLOG t where upper(t.name)=upper('GENTICKETSELLBYSALERDAY')  FOR UPDATE;
  if lv_runstatus=1 then
     insert into joblogdetail
       (id, jobid, runminute, runtime, runstatus,msg)
     values
       (SEQ_joblog.Nextval, jobid,  0, sysdate, 0,'正在运行，返回！');
     commit;
     return;
  end if;
  update JOBLOG t set t.runstatus=1 where t.id=jobid;
  commit;

  select sysdate
  into lv_begintime from dual;

  select count(*) into recordcount from ticketsellbysalerday;

  lv_maxsaledate := to_date(to_char(sysdate, 'yyyy-mm-dd'), 'yyyy-mm-dd');
  if recordcount > 0 then
    select  to_date(to_char(max(t.selldate-1), 'yyyy-mm-dd'), 'yyyy-mm-dd') into lv_saledate from ticketsellbysalerday t;
  else
    select  to_date(to_char(nvl(trunc(min(s.selltime-1)),sysdate), 'yyyy-mm-dd'), 'yyyy-mm-dd')
       into lv_saledate from ticketsell s;
  end if;

  i := trunc(lv_maxsaledate - lv_saledate);
  if (lv_isfirstrun=1)then
     /*select to_char(sysdate,'hh24:mi')
        into lv_curtime from  dual;
     if (lv_curtime>'05:00' and lv_curtime<'20:00') then
       lv_isfirstrun:=0;
       insert into joblogdetail
         (id, jobid, selldate,  runminute, runtime, runstatus,msg)
       values
         (SEQ_joblog.Nextval, jobid,to_date(to_char(lv_saledate,'yyyymmdd'),'yyyymmdd'),  0, sysdate, 0,'第一次运行但不是规定的时间！');
     else
         if(i<100)then
           lv_saledate:=trunc(sysdate-100);
           i := lv_maxsaledate - lv_saledate;
         end if;*/
   
     select  to_date(to_char(min(s.selltime),'yyyy-mm-dd'), 'yyyy-mm-dd')
       into lv_saledate from ticketsell s;
     
       insert into joblogdetail
         (id, jobid, selldate,  runminute, runtime, runstatus,msg)
       values
         (SEQ_joblog.Nextval, jobid,to_date(to_char(lv_saledate,'yyyymmdd'),'yyyymmdd'),  0, sysdate, 0,'第一次运行！');
      i := trunc(lv_maxsaledate - lv_saledate);
  end if;

  while (i >= 0) loop
    delete ticketsellbysalerday t where t.selldate = lv_saledate;
    insert into ticketsellbysalerday
      (id,
       orgid,
       selldate,
       sellby,
       sellnum,
       totalprice,
       stationservicefee,
       computefee,
       coolairfee,
       additionfee,
       returnnum,
       returnprice,
       returnfee,
       cancelnum,
       cancelmoeny,
       badnum,
       scheduleorgid,
       createdtime,
       synreturnsynnum,
       synreturnsynprice,
       synreturnsynfee,
       synreturnlocnum,
       synreturnlocprice,
       synreturnlocfee,
       totalfee,
       baseprice,
       localincome,
       divideprice,
       servicefee,
       fueladditionfee,
       moreprice,
       waterfee,
       insurefee,
       otherfee,
       ticketoutletsid,
       paymethod,
       changenum,
       adjustnum,
       returnbillnum,
       DATESCHEDULEINCOME,
     takeeticketnum)
      select seq_report.nextval,
             orgid,
             lv_saledate,
             sellby,
             sellnum,
             totalprice,
             stationservicefee,
             computefee,
             coolairfee,
             additionfee,
             returnnum,
             returnprice,
             returnfee,
             cancelnum,
             cancelmoeny,
             badnum,
             scheduleorgid,
             sysdate,
             synreturnsynnum,
             synreturnsynprice,
             synreturnsynfee,
             synreturnlocnum,
             synreturnlocprice,
             synreturnlocfee,
             (stationservicefee + computefee + coolairfee + additionfee +
             fueladditionfee + moreprice + waterfee + insurefee + otherfee),
             (totalprice - returnprice - cancelmoeny - synreturnsynprice -
             stationservicefee - computefee - coolairfee - additionfee -
             fueladditionfee),
             (totalprice - returnprice - cancelmoeny - synreturnsynprice -
             stationservicefee - computefee - coolairfee - additionfee -
             fueladditionfee) * rate + computefee,
             (totalprice - returnprice - cancelmoeny),
             servicefee, fueladditionfee,
             moreprice,
             waterfee,
             insurefee,
             otherfee,
             ticketoutletsid,
             paymethod,
             changenum,
             adjustnum,
             returnbillnum,
             DATESCHEDULEINCOME,
       takeeticketnum
        from (select orgid,
                     sellby,
                     sum(sellnum) sellnum,
                     sum(totalprice) totalprice,
                     sum(stationservicefee) stationservicefee,
                     sum(computefee) computefee,
                     sum(coolairfee) coolairfee,
                     sum(additionfee) additionfee,
                     sum(returnnum) returnnum,
                     sum(returnprice) returnprice,
                     sum(returnfee) returnfee,
                     sum(cancelnum) cancelnum,
                     sum(cancelmoeny) cancelmoeny,
                     sum(badnum) badnum,
                     scheduleorgid,
                     sum(synreturnsynnum) synreturnsynnum,
                     sum(synreturnsynprice) synreturnsynprice,
                     sum(synreturnsynfee) synreturnsynfee,
                     sum(synreturnlocnum) synreturnlocnum,
                     sum(synreturnlocprice) synreturnlocprice,
                     sum(synreturnlocfee) synreturnlocfee,
                     sum(servicefee) servicefee， sum(fueladditionfee) fueladditionfee,
                     sum(moreprice) moreprice,
                     sum(waterfee) waterfee,
                     sum(insurefee) insurefee,
                     sum(otherfee) otherfee,
                     ticketoutletsid,
                     paymethod,
                     sum(changenum) changenum,
                     sum(adjustnum) adjustnum,
                     sum(returnbillnum) returnbillnum,
                     sum(datescheduleincome) DATESCHEDULEINCOME,
           sum(takeeticketnum) takeeticketnum --电子票换票张数
                from (--按售票机构进行统计，只查自助机售票中自助机用户为非车站机构的售票记录
                      --先注释自助机的，赣州版本单独升级
                      /*select t.orgid,
                             t.sellby,
                             count(t.id) sellnum, --售票张数：
                             sum(price) totalprice,
                             sum(t.stationservicefee) stationservicefee,
                             sum(t.computefee) computefee,
                             sum(t.coolairfee) coolairfee,
                             sum(t.additionfee) additionfee,
                             0 returnnum,
                             0 returnprice,
                             0 returnfee,
                             0 cancelnum,
                             0 cancelmoeny,
                             0 badnum,
                             s.orgid scheduleorgid,
                             0 synreturnsynnum,
                             0 synreturnsynprice,
                             0 synreturnsynfee,
                             0 synreturnlocnum,
                             0 synreturnlocprice,
                             0 synreturnlocfee,
                             sum(t.servicefee) servicefee,
                             sum(t.fueladditionfee) fueladditionfee,
                             sum(t.moreprice) moreprice,
                             sum(t.waterfee) waterfee,
                             sum(t.insurefee) insurefee,
                             sum(t.otherfee) otherfee,
                             t.ticketoutletsid,
                             t.paymethod,
                             0 changenum,
                             0 adjustnum,
                             0 returnbillnum,
                             0 datescheduleincome,
                             0 takeeticketnum
                        from ticketsell t, schedule s, userinfo u
                       where t.selltime between lv_saledate and
                             lv_saledate + 0.99999
                         and t.scheduleid = s.id
                         and t.sellway = '10'
                         and t.sellby = u.id and t.orgid <> u.orgid
                       group by t.orgid,
                                t.sellby,
                                s.orgid,
                                t.ticketoutletsid,
                                t.paymethod
                      union all*/
                      select t.orgid,
                             t.sellby,
                             count(distinct(case when (t.tickettype = 'T') then (t.orderno) else to_char(t.id) end)) sellnum, --售票张数：团体票按一张票统计
                             sum(price) totalprice,
                             sum(t.stationservicefee) stationservicefee,
                             sum(t.computefee) computefee,
                             sum(t.coolairfee) coolairfee,
                             sum(t.additionfee) additionfee,
                             0 returnnum,
                             0 returnprice,
                             0 returnfee,
                             0 cancelnum,
                             0 cancelmoeny,
                             0 badnum,
                             nvl(org.id,s.orgid) scheduleorgid,
                             0 synreturnsynnum,
                             0 synreturnsynprice,
                             0 synreturnsynfee,
                             0 synreturnlocnum,
                             0 synreturnlocprice,
                             0 synreturnlocfee,
                             sum(t.servicefee) servicefee,
                             sum(t.fueladditionfee) fueladditionfee,
                             sum(t.moreprice) moreprice,
                             sum(t.waterfee) waterfee,
                             sum(t.insurefee) insurefee,
                             sum(t.otherfee) otherfee,
                             t.ticketoutletsid,
                             t.paymethod,
                             0 changenum,
                             0 adjustnum,
                             0 returnbillnum,
                             0 datescheduleincome,
                             0 takeeticketnum
                        from ticketsell t, schedule s ,organization org,userinfo u
                       where t.selltime between lv_saledate and
                             lv_saledate + 0.99999
                         and t.scheduleid = s.id
                         and t.sellby=u.id
                         and t.departstationid=org.stationid(+)-- and org.islocal=1
                       group by t.orgid,
                                t.sellby,
                                nvl(org.id,s.orgid),
                                t.ticketoutletsid,
                                t.paymethod
                      union all

                      select u.orgid,
                             t.sellby,
                             count(distinct(case when (t.tickettype = 'T') then (t.orderno) else to_char(t.id) end)) sellnum, --售票张数：团体票按一张票统计
                             sum(price) totalprice,
                             sum(t.stationservicefee) stationservicefee,
                             sum(t.computefee) computefee,
                             sum(t.coolairfee) coolairfee,
                             sum(t.additionfee) additionfee,
                             0 returnnum,
                             0 returnprice,
                             0 returnfee,
                             0 cancelnum,
                             0 cancelmoeny,
                             0 badnum,
                             t.orgid scheduleorgid,
                             0 synreturnsynnum,
                             0 synreturnsynprice,
                             0 synreturnsynfee,
                             0 synreturnlocnum,
                             0 synreturnlocprice,
                             0 synreturnlocfee,
                             0 servicefee,
                             sum(t.fueladditionfee) fueladditionfee,
                             sum(t.moreprice) moreprice,
                             sum(t.waterfee) waterfee,
                             sum(t.insurefee) insurefee,
                             sum(t.otherfee) otherfee,
                             t.ticketoutletsid,
                             t.paymethod,
                             0 changenum,
                             0 adjustnum,
                             0 returnbillnum,
                             0 datescheduleincome,
                             0 takeeticketnum
                        from ticketsellagent t, userinfo u
                       where t.sellby = u.id
                         and t.selltime between lv_saledate and
                             lv_saledate + 0.99999
                       group by u.orgid,
                                t.sellby,
                                t.orgid,
                                t.ticketoutletsid,
                                t.paymethod
                      union all
                      --本数据库退票
                      select decode(u.id,0,t.orgid,u.orgid) orgid,
                             tt.returnby,
                             0 sellnum,
                             0 totalprice,
                             -sum(t.stationservicefee) stationservicefee,
                             -sum(t.computefee) computefee,
                             -sum(t.coolairfee) coolairfee,
                             -sum(t.additionfee) additionfee,
                             count(tt.id) returnnum,
                             sum(tt.ticketprice) returnprice,
                             sum(tt.charges) returnfee,
                             0 cancelnum,
                             0 cancelmoeny,
                             0 badnum,
                             nvl(org.id,s.orgid) scheduleorgid,
                             0 synreturnsynnum,
                             0 synreturnsynprice,
                             0 synreturnsynfee,
                             0 synreturnlocnum,
                             0 synreturnlocprice,
                             0 synreturnlocfee,
                             0 servicefee,
                             -sum(t.fueladditionfee) fueladditionfee,
                             -sum(t.moreprice) moreprice,
                             -sum(t.waterfee) waterfee,
                             -sum(t.insurefee) insurefee,
                             -sum(t.otherfee) otherfee,
                             t.ticketoutletsid,
                             decode(tt.returnfeemode,1,t.paymethod,0) paymethod,
                             0 changenum,
                             0 adjustnum,
                             sum(case when length(tt.returnvoucherno)>2  then 1 else 0 end ) returnbillnum,
                             0 datescheduleincome,
                             0 takeeticketnum
                        from ticketsell   t,
                             ticketreturn tt,
                             schedule     s,
                             userinfo     u,
                             organization org
                       where t.id = tt.sellid
                         and tt.isselfschedule = 1
                         and t.scheduleid = s.id
                         and t.departstationid=org.stationid(+)
                         and tt.returnby = u.id
                         and tt.returntime between lv_saledate and
                             lv_saledate + 0.99999
                       group by  decode(u.id,0,t.orgid,u.orgid),
                                tt.returnby,
                                nvl(org.id,s.orgid),
                                t.ticketoutletsid,
                                decode(tt.returnfeemode,1,t.paymethod,0)
                   union all

                      --联网票退票
                      select decode(u.id,0,t.orgid,u.orgid) orgid,
                             tt.returnby,
                             0 sellnum,
                             0 totalprice,
                             -sum(t.stationservicefee) stationservicefee,
                             -sum(t.computefee) computefee,
                             -sum(t.coolairfee) coolairfee,
                             -sum(t.additionfee) additionfee,
                             count(tt.id) returnnum,
                             sum(tt.ticketprice) returnprice,
                             sum(tt.charges) returnfee,
                             0 cancelnum,
                             0 cancelmoeny,
                             0 badnum,
                             t.orgid scheduleorgid,
                             0 synreturnsynnum,
                             0 synreturnsynprice,
                             0 synreturnsynfee,
                             0 synreturnlocnum,
                             0 synreturnlocprice,
                             0 synreturnlocfee,
                             0 servicefee,
                             -sum(t.fueladditionfee) fueladditionfee,
                             -sum(t.moreprice) moreprice,
                             -sum(t.waterfee) waterfee,
                             -sum(t.insurefee) insurefee,
                             -sum(t.otherfee) otherfee,
                             t.ticketoutletsid,
                             decode(tt.returnfeemode,1,t.paymethod,0) paymethod,
                             0 changenum,
                             0 adjustnum,
                             sum(case when length(tt.returnvoucherno)>2  then 1 else 0 end ) returnbillnum,
                             0 datescheduleincome,
                             0 takeeticketnum
                        from ticketsellagent t, ticketreturn tt, userinfo u
                       where t.id = tt.sellid
                         and tt.isselfschedule = 0
                         and tt.returnby = u.id
                         and tt.returntime between lv_saledate and
                             lv_saledate + 0.99999
                       group by decode(u.id,0,t.orgid,u.orgid),
                                tt.returnby,
                                t.orgid,
                                t.ticketoutletsid,
                                decode(tt.returnfeemode,1,t.paymethod,0)                  
            union all
                      select t.orgid,
                             t.sellby,
                             0 sellnum,
                             0 totalprice,
                             -sum(t.stationservicefee) stationservicefee,
                             -sum(t.computefee) computefee,
                             -sum(t.coolairfee) coolairfee,
                             -sum(t.additionfee) additionfee,
                             0 returnnum,
                             0 returnprice,
                             0 returnfee,
                             count(tc.id) cancelnum,
                             sum(t.price) cancelmoeny,
                             0 badnum,
                             nvl(org.id,s.orgid) scheduleorgid,
                             0 synreturnsynnum,
                             0 synreturnsynprice,
                             0 synreturnsynfee,
                             0 synreturnlocnum,
                             0 synreturnlocprice,
                             0 synreturnlocfee,
                             -sum(servicefee) servicefee,
                             -sum(t.fueladditionfee) fueladditionfee,
                             -sum(t.moreprice) moreprice,
                             -sum(t.waterfee) waterfee,
                             -sum(t.insurefee) insurefee,
                             -sum(t.otherfee) otherfee,
                             t.ticketoutletsid,
                             t.paymethod,
                             0 changenum,
                             0 adjustnum,
                             0 returnbillnum,
                             0 datescheduleincome,
                             0 takeeticketnum
                        from ticketsell t, ticketcancel tc, schedule s,organization org
                       where t.id = tc.sellid
                         and t.scheduleid = s.id
                         and t.departstationid=org.stationid(+) --and org.islocal=1
                         and tc.isselfschedule = 1
                         and tc.canceltime between lv_saledate and
                             lv_saledate + 0.99999
                       group by t.orgid,
                                t.sellby,
                                nvl(org.id,s.orgid),
                                t.ticketoutletsid,
                                t.paymethod

                      union all
                      select u.orgid,
                             tc.cancelby,
                             0 sellnum,
                             0 totalprice,
                             -sum(t.stationservicefee) stationservicefee,
                             -sum(t.computefee) computefee,
                             -sum(t.coolairfee) coolairfee,
                             -sum(t.additionfee) additionfee,
                             0 returnnum,
                             0 returnprice,
                             0 returnfee,
                             count(tc.id) cancelnum,
                             sum(t.price) cancelmoeny,
                             0 badnum,
                             t.orgid scheduleorgid,
                             0 synreturnsynnum,
                             0 synreturnsynprice,
                             0 synreturnsynfee,
                             0 synreturnlocnum,
                             0 synreturnlocprice,
                             0 synreturnlocfee,
                             -sum(servicefee) servicefee,
                             -sum(t.fueladditionfee) fueladditionfee,
                             -sum(t.moreprice) moreprice,
                             -sum(t.waterfee) waterfee,
                             -sum(t.insurefee) insurefee,
                             -sum(t.otherfee) otherfee,
                             t.ticketoutletsid,
                             t.paymethod,
                             0 changenum,
                             0 adjustnum,
                             0 returnbillnum,
                             0 datescheduleincome,
                             0 takeeticketnum
                        from ticketsellagent t, ticketcancel tc, userinfo u
                       where t.id = tc.sellid
                         and tc.isselfschedule = 0
                         and tc.cancelby = u.id
                         and tc.canceltime between lv_saledate and
                             lv_saledate + 0.99999
                       group by u.orgid,
                                tc.cancelby,
                                t.orgid,
                                t.ticketoutletsid,
                                t.paymethod
                      union all
                      select t.orgid,
                             t.sellby,
                             0 sellnum,
                             0 totalprice,
                             0 stationservicefee,
                             0 computefee,
                             0 coolairfee,
                             0 additionfee,
                             0 returnnum,
                             0 returnprice,
                             0 returnfee,
                             0 cancelnum,
                             0 cancelmoeny,
                             0 badnum,
                             s.orgid scheduleorgid,
                             0 synreturnsynnum,
                             0 synreturnsynprice,
                             0 synreturnsynfee,
                             0 synreturnlocnum,
                             0 synreturnlocprice,
                             0 synreturnlocfee,
                             0 servicefee,
                             0 fueladditionfee,
                             0 moreprice,
                             0 waterfee,
                             0 insurefee,
                             0 otherfee,
                             t.ticketoutletsid,
                             t.paymethod,
                             sum(decode(tc.changeticketno, null, 0,0,0, 1)) changenum,
                             0 adjustnum,
                             0 returnbillnum,
                             0 datescheduleincome,
                             0 takeeticketnum
                        from ticketsell t, userinfo u, schedule s,ticketchange tc
                       where t.selltime >= lv_saledate
                         and tc.newticketsellid = t.id
                         and t.scheduleid = s.id
                         and t.selltime <= lv_saledate + 0.99999
                         and t.sellway = '4'
                         and t.sellby = u.id
                       group by t.orgid,
                                t.sellby,
                                s.orgid,
                                t.ticketoutletsid,
                                t.paymethod
                      union all
                      select t.orgid,
                             t.sellby,
                             0 sellnum,
                             0 totalprice,
                             0 stationservicefee,
                             0 computefee,
                             0 coolairfee,
                             0 additionfee,
                             0 returnnum,
                             0 returnprice,
                             0 returnfee,
                             0 cancelnum,
                             0 cancelmoeny,
                             0 badnum,
                             s.orgid scheduleorgid,
                             0 synreturnsynnum,
                             0 synreturnsynprice,
                             0 synreturnsynfee,
                             0 synreturnlocnum,
                             0 synreturnlocprice,
                             0 synreturnlocfee,
                             0 servicefee,
                             0 fueladditionfee,
                             0 moreprice,
                             0 waterfee,
                             0 insurefee,
                             0 otherfee,
                             t.ticketoutletsid,
                             t.paymethod,
                             0 changenum,
                             count(distinct t.orderno) adjustnum,
                             0 returnbillnum,
                             0 datescheduleincome,
                             0 takeeticketnum
                        from ticketsell t, schedule s
                       where t.selltime between lv_saledate and
                             lv_saledate + 0.99999
                         and t.sellway in ('1', '2')
                         and t.servicefee > 0
                         and t.scheduleid = s.id
                       group by t.orgid,
                                t.sellby,
                                s.orgid,
                                t.ticketoutletsid,
                                t.paymethod
                      union all
                      select t.orgid,
                             t.sellby,
                             0 sellnum,
                             0 totalprice,
                             0 stationservicefee,
                             0 computefee,
                             0 coolairfee,
                             0 additionfee,
                             0 returnnum,
                             0 returnprice,
                             0 returnfee,
                             0 cancelnum,
                             0 cancelmoeny,
                             0 badnum,
                             s.orgid scheduleorgid,
                             0 synreturnsynnum,
                             0 synreturnsynprice,
                             0 synreturnsynfee,
                             0 synreturnlocnum,
                             0 synreturnlocprice,
                             0 synreturnlocfee,
                             0 servicefee,
                             0 fueladditionfee,
                             0 moreprice,
                             0 waterfee,
                             0 insurefee,
                             0 otherfee,
                             t.ticketoutletsid,
                             t.paymethod,
                             0 changenum,
                             0 adjustnum,
                             0 returnbillnum,
                             sum(t.price) datescheduleincome,
                             0 takeeticketnum
                        from ticketsell t, schedule s, userinfo u
                       where t.selltime between lv_saledate and
                             lv_saledate + 0.99999
                         and t.departdate = trunc(t.selltime)
                         and t.ticketstatus = '0'
                         and t.scheduleid = s.id
                         and t.sellway = '10'
                         and t.sellby = u.id and t.orgid <> u.orgid
                       group by t.orgid,
                                t.sellby,
                                s.orgid,
                                t.ticketoutletsid,
                                t.paymethod
                      union all
                      select u.orgid,
                             t.sellby,
                             0 sellnum,
                             0 totalprice,
                             0 stationservicefee,
                             0 computefee,
                             0 coolairfee,
                             0 additionfee,
                             0 returnnum,
                             0 returnprice,
                             0 returnfee,
                             0 cancelnum,
                             0 cancelmoeny,
                             0 badnum,
                             s.orgid scheduleorgid,
                             0 synreturnsynnum,
                             0 synreturnsynprice,
                             0 synreturnsynfee,
                             0 synreturnlocnum,
                             0 synreturnlocprice,
                             0 synreturnlocfee,
                             0 servicefee,
                             0 fueladditionfee,
                             0 moreprice,
                             0 waterfee,
                             0 insurefee,
                             0 otherfee,
                             t.ticketoutletsid,
                             t.paymethod,
                             0 changenum,
                             0 adjustnum,
                             0 returnbillnum,
                             sum(t.price) datescheduleincome,
                             0 takeeticketnum
                        from ticketsell t, schedule s
                             , userinfo u, organization o
                       where t.selltime between lv_saledate and
                             lv_saledate + 0.99999
                         and t.departdate = trunc(t.selltime)
                         and t.ticketstatus = '0'
                         and t.scheduleid = s.id
                         and t.sellby = u.id and u.orgid = o.id
                       group by u.orgid,
                                t.sellby,
                                s.orgid,
                                t.ticketoutletsid,
                                t.paymethod
                      union all
                      select u.orgid,
                             t.sellby,
                             0 sellnum,
                             0 totalprice,
                             0 stationservicefee,
                             0 computefee,
                             0 coolairfee,
                             0 additionfee,
                             0 returnnum,
                             0 returnprice,
                             0 returnfee,
                             0 cancelnum,
                             0 cancelmoeny,
                             0 badnum,
                             t.orgid scheduleorgid,
                             0 synreturnsynnum,
                             0 synreturnsynprice,
                             0 synreturnsynfee,
                             0 synreturnlocnum,
                             0 synreturnlocprice,
                             0 synreturnlocfee,
                             0 servicefee,
                             0 fueladditionfee,
                             0 moreprice,
                             0 waterfee,
                             0 insurefee,
                             0 otherfee,
                             t.ticketoutletsid,
                             t.paymethod,
                             0 changenum,
                             0 adjustnum,
                             0 returnbillnum,
                             sum(t.price) datescheduleincome,
                             0 takeeticketnum
                        from ticketsellagent t, userinfo u
                       where t.selltime between lv_saledate and
                             lv_saledate + 0.99999
                         and t.sellby = u.id
                         and t.departdate = trunc(t.selltime)
                         and t.ticketstatus = '0'
                       group by u.orgid,
                                t.sellby,
                                t.orgid,
                                t.ticketoutletsid,
                                t.paymethod

            union all
            select o.id orgid,
               ts.printby sellby,
               0 sellnum,
               0 totalprice,
               0 stationservicefee,
               0 computefee,
               0 coolairfee,
               0 additionfee,
               0 returnnum,
               0 returnprice,
               0 returnfee,
               0 cancelnum,
               0 cancelmoeny,
               0 badnum,
               s.orgid scheduleorgid,
               0 synreturnsynnum,
               0 synreturnsynprice,
               0 synreturnsynfee,
               0 synreturnlocnum,
               0 synreturnlocprice,
               0 synreturnlocfee,
               0 servicefee,
               0 fueladditionfee,
               0 moreprice,
               0 waterfee,
               0 insurefee,
               0 otherfee,
               ttl.id ticketoutletsid,
               '0' paymethod,
               0 changenum,
               0 adjustnum,
               0 returnbillnum,
               0 datescheduleincome,
               count(ts.id) takeeticketnum
            from ticketsellother ts, ticketsell t, schedule s, userinfo u, organization o, ticketoutlets ttl
            where ts.ticketsellid = t.id and ts.istaked = 1
                and ts.taketime  between lv_saledate and
                lv_saledate + 0.99999
               and ts.printby = u.id
               and t.scheduleid = s.id
               and u.orgid = o.id
               and o.stationid = ttl.startstationid
             group by o.id,
                ts.printby,
                s.orgid,
                ttl.id
          )
               group by orgid,
                        sellby,
                        scheduleorgid,
                        ticketoutletsid,
                        paymethod);
    i           := i - 1;
    
    update ticketsellbysalerday t
       set t.payprice  =
           (t.totalprice - t.returnprice - t.cancelmoeny - t.totalfee) * rate + t.computefee,
           t.syncincome = t.totalprice - t.cancelmoeny - t.returnprice -
                          ((t.totalprice - t.returnprice -t.cancelmoeny  - t.totalfee) * rate +
                          t.computefee)
     where t.selldate=lv_saledate
     and t.orgid in (select id  from  organization org
     where org.type<>'0');
     
    update ticketsellbysalerday t
       set t.payprice  = t.totalprice - t.cancelmoeny - t.returnprice,
           t.syncincome =0
     where t.selldate=lv_saledate 
     and t.orgid in (select id  from  organization org
     where org.type='0');
     
    select sysdate
        into lv_curendtime from dual;
    lv_runminute:= trunc((lv_curendtime-lv_begintime)*24*60*60);
     insert into joblogdetail
       (id, jobid, selldate, runminute, runtime, runstatus,msg)
     values
       (seq_joblog.nextval, jobid, to_date(to_char(lv_saledate,'yyyymmdd'),'yyyymmdd'), lv_runminute, sysdate, 1,'执行成功！');
    lv_saledate := lv_saledate + 1;

    COMMIT;
  end loop;

  select sysdate
  into lv_endtime from dual;

  lv_runminute:= trunc((lv_endtime-lv_begintime)*24*60*60);
  if lv_isfirstrun=1 then
    update JOBLOG t set t.runstatus=0,t.runnum=t.runnum+1,
    t.isfirstrun=0,t.runminute=lv_runminute,t.runtime=sysdate
     where t.id=jobid;
  else
    update JOBLOG t set t.runstatus=0,t.runnum=t.runnum+1,
        t.runminute=lv_runminute,t.runtime=sysdate
     where t.id=jobid;
  end if;
  commit;
EXCEPTION
  WHEN OTHERS THEN
    lv_msg := SUBSTR(SQLERRM, 1, 600);
    ROLLBACK;
    update JOBLOG t set t.runstatus=0 where t.id=jobid;
    insert into joblogdetail
       (id, jobid,  runminute, runtime, runstatus,msg)
     values
       (seq_joblog.nextval, jobid,  lv_runminute, sysdate, 0,lv_msg);
    commit;
end;
;
--endblock

--beginblock
CREATE OR REPLACE PROCEDURE "UPDATECUSTOMERISACTIVE" is
begin

  UPDATE CUSTOMER C
     SET C.ISACTIVE = 1
   WHERE C.ISACTIVE = 0
     AND NOT EXISTS (select *
            from CUSTOMER C1
           WHERE C1.CERTIFICATETYPE = C.CERTIFICATETYPE
             AND C1.CERTIFICATENO = C.CERTIFICATENO
             AND C1.ISACTIVE = 1);
  COMMIT;

end;;
--endblock
--beginblock
CREATE OR REPLACE PROCEDURE "DELETEJOBSPROCEDURE"(WHATNAME IN VARCHAR2) is
begin
  for v in (select job
              from user_jobs
             where upper(what) = upper(WHATNAME)) loop
    dbms_job.remove(v.job);
  end loop;
  commit;
end;
;
--endblock

--begin 2017年12月25日19:38:26  更新customer表中的售票信息冗余字段
--beginblock
CREATE OR REPLACE PROCEDURE refreshcustomer IS
  lv_departdate    date;
  lv_maxdepartdate date;
  i                integer;
  CURSOR c_getticketsellinfo IS
    select t.id,
           s1.name      as departstationname,
           s2.name      as reachstationname,
           s3.name      as endstationname,
           sch.code     as schcode,
           v.vehicleno  as planvehicleno,
		   t.ticketno     as ticketno,
           t.departdate   as departdate,
           t.departtime   as departtime,
           t.ticketstatus as ticketstatus,
           t.seatno       as seatno,
           t.customerid
      from ticketsell t
      left join station s1
        on t.departstationid = s1.id
      left join station s2
        on t.reachstationid = s2.id
      left join schedule sch
        on t.scheduleid = sch.id
      left join route r
        on sch.routeid = r.id
      left join station s3
        on r.endstationid = s3.id
      left join vehiclereport vr
        on t.vehiclereportid = vr.id
      left join vehicle v
        on vr.vehicleid = v.id
     where t.customerid > 1
       and t.departdate = lv_departdate
     order by t.selltime;
  c_row c_getticketsellinfo%rowtype;
begin
  lv_departdate    := to_date(to_char(sysdate - 60, 'yyyy-mm-dd'),
                              'yyyy-mm-dd');
  lv_maxdepartdate := to_date(to_char(sysdate, 'yyyy-mm-dd'), 'yyyy-mm-dd');
  i                := lv_maxdepartdate - lv_departdate;

  while (i > 0) loop
    open c_getticketsellinfo;
    loop
      fetch c_getticketsellinfo
        into c_row;
      exit when c_getticketsellinfo%notfound;
      update customer c
         set c.departstationname = c_row.departstationname,
             c.reachstationname  = c_row.reachstationname,
             c.endstationname    = c_row.endstationname,
             c.schcode           = c_row.schcode,
             c.planvehicleno     = c_row.planvehicleno,
			 c.ticketno          = c_row.ticketno,
             c.departdate        = c_row.departdate,
             c.departtime        = c_row.departtime,
             c.ticketstatus      = c_row.ticketstatus,
             c.seatno            = c_row.seatno
       where c.id = c_row.customerid;
    end loop;
    close c_getticketsellinfo;
  
    commit;
    i             := i - 1;
    lv_departdate := lv_departdate + 1;
  end loop;
exception
  when others THEN
    rollback;
end;
;
--endblock
--end  zhangxibao 2017年12月25日19:39:10