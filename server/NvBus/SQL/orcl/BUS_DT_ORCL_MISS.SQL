@repeat{SELECT count(*) FROM Parameter where code ='6027'}
insert into Parameter (ID, TYPE, CODE, VALUE, ISVISIBLE, ISEDITABLE, REMARK, UPDATETIME, UPDATEBY, UNIT)
values (1259600, '10', '6027', '1', 1, 1, '驾驶员非本车驾驶员是否允许安检通过，1允许、0不允许，默认为1', sysdate, 1158013, '是否');

@repeat{SELECT count(*) FROM Parameter where code ='2030'}
insert into parameter values(183,20,2030,1,1,1,'驾驶员证件过期是否允许报班:1允许，0不允许',sysdate,0,'是否');

@repeat{SELECT count(*) FROM Parameter where code ='6013'}
insert into parameter values(219,60,6013,0,1,1,'是否默认打印安检通知单，0不打印，1打印，默认为1',sysdate,0,'是否');