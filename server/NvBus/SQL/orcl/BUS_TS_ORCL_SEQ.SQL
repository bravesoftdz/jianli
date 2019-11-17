@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('SEQNAME')}
create table SEQNAME
(
  id        NUMBER(5),
  tablename VARCHAR2(50),
  isexec    NUMBER(2)
);

@repeat{SELECT COUNT(*) FROM SEQNAME WHERE tablename='unit'}
insert into SEQNAME (id, tablename, isexec) values (1, 'unit', 0);
@repeat{SELECT COUNT(*) FROM SEQNAME WHERE tablename='station'}
insert into SEQNAME (id, tablename, isexec) values (2, 'station', 0);
@repeat{SELECT COUNT(*) FROM SEQNAME WHERE tablename='route'}
insert into SEQNAME (id, tablename, isexec) values (3, 'route', 0);
@repeat{SELECT COUNT(*) FROM SEQNAME WHERE tablename='vehicle'}
insert into SEQNAME (id, tablename, isexec) values (4, 'vehicle', 0);
@repeat{SELECT COUNT(*) FROM SEQNAME WHERE tablename='schedule'}
insert into SEQNAME (id, tablename, isexec) values (5, 'schedule', 0);
@repeat{SELECT COUNT(*) FROM SEQNAME WHERE tablename='schedulestop'}
insert into SEQNAME (id, tablename, isexec) values (6, 'schedulestop', 0);
@repeat{SELECT COUNT(*) FROM SEQNAME WHERE tablename='schedulelongstop'}
insert into SEQNAME (id, tablename, isexec) values (7, 'schedulelongstop', 0);
@repeat{SELECT COUNT(*) FROM SEQNAME WHERE tablename='scheduleseatreserve'}
insert into SEQNAME (id, tablename, isexec) values (8, 'scheduleseatreserve', 0);
@repeat{SELECT COUNT(*) FROM SEQNAME WHERE tablename='routestop'}
insert into SEQNAME (id, tablename, isexec) values (9, 'routestop', 0);
@repeat{SELECT COUNT(*) FROM SEQNAME WHERE tablename='Customer'}
insert into SEQNAME (id, tablename, isexec) values (10, 'Customer', 0);
@repeat{SELECT COUNT(*) FROM SEQNAME WHERE tablename='Ticketoutlets'}
insert into SEQNAME (id, tablename, isexec) values (11, 'Ticketoutlets', 0);
@repeat{SELECT COUNT(*) FROM SEQNAME WHERE tablename='Ticketentrance'}
insert into SEQNAME (id, tablename, isexec) values (12, 'Ticketentrance', 0);
@repeat{SELECT COUNT(*) FROM SEQNAME WHERE tablename='Schedulecycle'}
insert into SEQNAME (id, tablename, isexec) values (13, 'Schedulecycle', 0);
@repeat{SELECT COUNT(*) FROM SEQNAME WHERE tablename='Cycleschemesvehicle'}
insert into SEQNAME (id, tablename, isexec) values (14, 'Cycleschemesvehicle', 0);
@repeat{SELECT COUNT(*) FROM SEQNAME WHERE tablename='Cycleschemesdriver'}
insert into SEQNAME (id, tablename, isexec) values (15, 'Cycleschemesdriver', 0);
@repeat{SELECT COUNT(*) FROM SEQNAME WHERE tablename='Cycleschemessteward'}
insert into SEQNAME (id, tablename, isexec) values (16, 'Cycleschemessteward', 0);
@repeat{SELECT COUNT(*) FROM SEQNAME WHERE tablename='Cycleschemesschedule'}
insert into SEQNAME (id, tablename, isexec) values (17, 'Cycleschemesschedule', 0);
@repeat{SELECT COUNT(*) FROM SEQNAME WHERE tablename='Cycleschemes'}
insert into SEQNAME (id, tablename, isexec) values (18, 'Cycleschemes', 0);
@repeat{SELECT COUNT(*) FROM SEQNAME WHERE tablename='Standardprice'}
insert into SEQNAME (id, tablename, isexec) values (19, 'Standardprice', 0);
@repeat{SELECT COUNT(*) FROM SEQNAME WHERE tablename='Handholidayprice'}
insert into SEQNAME (id, tablename, isexec) values (20, 'Handholidayprice', 0);
@repeat{SELECT COUNT(*) FROM SEQNAME WHERE tablename='Handprice'}
insert into SEQNAME (id, tablename, isexec) values (21, 'Handprice', 0);


--beginblock
CREATE OR REPLACE FUNCTION FNGETseq(iv_tablename in varchar2) return number IS
  lv_maxcount number(10);
  lv_maxid   number(10);
  lv_sql      varchar2(4000);
  my_cursor   CURSORTYPE.newCursor;
begin
  lv_maxcount := 1;
  
  lv_sql:='select max(id)  from  '||iv_tablename;
  
  OPEN my_cursor FOR lv_sql;
  LOOP
    FETCH my_cursor
      INTO lv_maxid;
    EXIT WHEN my_cursor%NOTFOUND;
  END LOOP;
  CLOSE my_cursor;  
  
  if lv_maxid<1000000 then
      return lv_maxid+100;
  end if;
  
  
  lv_sql      := '
select nvl(max(less), 1) 
   from(
select (id2 - id1)as less , id1, id2
  from (select sum(id1) as id1, sum(id2) as id2
          from (select id, id1, id2
                  from (select rownum as id, id as id1, 0 as id2
                          from ' || iv_tablename || '
                         order by id)
                union
                select id, id1, id2
                  from (select rownum - 1 as id, 0 as id1, id as id2
                          from ' || iv_tablename || '
                         order by id))
         group by id)
 where id2 - id1 > 1000000 and id2<100000000)';

  OPEN my_cursor FOR lv_sql;
  LOOP
    FETCH my_cursor
      INTO lv_maxcount;
    EXIT WHEN my_cursor%NOTFOUND;
  END LOOP;
  CLOSE my_cursor;

  return lv_maxcount;
end;;
--endblock

--beginblock
CREATE OR REPLACE PROCEDURE sp_updateseq IS
  lv_execcount  integer;
  lv_id         number(10);
  lv_record     integer;
  lv_tablename  varchar(100);
  lv_sql        varchar2(4000);
  lv_seqname    varchar2(100);
  lv_jobid      number(10);
  lv_runstatus  number;
  lv_begintime  date;
  lv_curendtime date;
  lv_endtime    date;
  lv_runminute  number(10);
  lv_isfirstrun number;
  lv_msg        varchar2(600);
  lv_ISEXEC     number(2);
  lv_tableid    number(10);
  CURSOR qryseqname IS
    select id, upper(tablename), isexec from seqname;
begin

  delete joblogdetail t where t.runtime <= trunc(sysdate - 60);
  lv_runminute := 0;
  lv_jobid     := 20;
  select count(*)
    into lv_record
    from JOBLOG t
   where upper(t.name) = upper('sp_updateseq');
  if lv_record = 0 then
    insert into joblog
      (id, name, runstatus, isfirstrun, runnum, runminute, runtime)
    values
      (20, 'sp_updateseq', 0, 1, 0, 0, sysdate);
    commit;
  end if;
  select t.id, t.runstatus, t.isfirstrun
    into lv_jobid, lv_runstatus, lv_isfirstrun
    from JOBLOG t
   where upper(t.name) = upper('sp_updateseq')
     FOR UPDATE;
  if lv_runstatus = 1 then
    insert into joblogdetail
      (id, jobid, runminute, runtime, runstatus, msg)
    values
      (SEQ_joblog.Nextval, lv_jobid, 0, sysdate, 0, '正在运行，返回！');
    commit;
    return;
  end if;
  update JOBLOG t set t.runstatus = 1 where t.id = lv_jobid;
  commit;
  select sysdate into lv_begintime from dual;
  lv_execcount := 0;
  OPEN qryseqname;
  LOOP
    FETCH qryseqname
      INTO lv_tableid, lv_tablename, lv_ISEXEC;
    EXIT WHEN qryseqname%NOTFOUND;
    if lv_ISEXEC = 0 then
    
      lv_seqname := 'SEQ_' || lv_tablename;
    
      begin
        select count(*)
          into lv_record
          from SYS.USER_OBJECTS t
         where t.OBJECT_NAME = lv_seqname;
        if lv_record > 0 then
          lv_sql := 'drop sequence ' || lv_seqname;
          execute immediate lv_sql;
        end if;
      end;
    
      select FNGETseq(lv_tablename) into lv_id from dual;
      lv_id  := 100;
      lv_sql := 'create sequence SEQ_' || lv_tablename || ' minvalue ' ||
                lv_id || ' maxvalue 1000000000 start with ' || lv_id ||
                ' increment by 1 cache 20';
      execute immediate lv_sql;
    
      update seqname t set t.isexec = 1 where t.id = lv_tableid;
    
      select sysdate into lv_curendtime from dual;
      lv_runminute := trunc((lv_curendtime - lv_begintime) * 24 * 60 * 60);
      insert into joblogdetail
        (id, jobid, runminute, runtime, runstatus, msg)
      values
        (seq_joblog.nextval,
         lv_jobid,
         lv_runminute,
         sysdate,
         1,
         lv_seqname || '序列创建成功');
      lv_execcount := lv_execcount + 1;
    else
      insert into joblogdetail
        (id, jobid, runminute, runtime, runstatus, msg)
      values
        (seq_joblog.nextval,
         lv_jobid,
         lv_runminute,
         sysdate,
         0,
         lv_seqname || '序列已经创建，本次允许不再创建');
    end if;
  END LOOP;
  CLOSE qryseqname;
  select sysdate into lv_endtime from dual;

  lv_runminute := trunc((lv_endtime - lv_begintime) * 24 * 60 * 60);
  if lv_isfirstrun = 1 then
    update JOBLOG t
       set t.runstatus  = 0,
           t.runnum     = t.runnum + 1,
           t.isfirstrun = 0,
           t.runminute  = lv_runminute,
           t.runtime    = sysdate
     where t.id = lv_jobid;
  else
    update JOBLOG t
       set t.runstatus = 0,
           t.runnum    = t.runnum + 1,
           t.runminute = lv_runminute,
           t.runtime   = sysdate
     where t.id = lv_jobid;
  end if;

  if lv_execcount = 0 then
    insert into joblogdetail
      (id, jobid, runminute, runtime, runstatus, msg)
    values
      (seq_joblog.nextval,
       lv_jobid,
       lv_runminute,
       sysdate,
       0,
       '本次执行无需要创建的序列');
  end if;

  commit;
  --  ov_flag := 1;
  --ov_res  := '执行成功';
EXCEPTION
  WHEN OTHERS THEN
    lv_msg := SUBSTR(SQLERRM, 1, 600);
    ROLLBACK;
    update JOBLOG t set t.runstatus = 0 where t.id = lv_jobid;
    insert into joblogdetail
      (id, jobid, runminute, runtime, runstatus, msg)
    values
      (seq_joblog.nextval, lv_jobid, 0, sysdate, 0, lv_msg);
    commit;
END;;

--endblock