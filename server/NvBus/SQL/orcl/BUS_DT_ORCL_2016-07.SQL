--begin addby daijiy 2016-7-16 
@repeat{SELECT COUNT(*) FROM exceptioninfo where ID=690} 
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values (690, '0690', '该班次号在此日期段内已经存在班次计划！', '添加班次信息');
@repeat{SELECT COUNT(*) FROM parameter where ID=160070791} 
insert into parameter (ID, TYPE, CODE, VALUE, ISVISIBLE, ISEDITABLE, REMARK, UPDATETIME, UPDATEBY, UNIT)
values (160070791, '30', '3038', '0', 1, 1, '是否实名制检票，0不实名制，1实名制，默认为0。', sysdate, 1158013, '是否');

--end