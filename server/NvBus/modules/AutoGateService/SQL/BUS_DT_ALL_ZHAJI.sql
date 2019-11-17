--begin 闸机相关的参数
@repeat{SELECT count(*) FROM parameter where CODE = 3069}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (3069, '30', '3069', '0', 1, 1, '检票闸机是否允许预售票通过，0不允许，1允许，默认为0', sysdate, 0, '是否');

@repeat{SELECT COUNT(*) FROM parameter where CODE = 3070}
insert into parameter (ID, TYPE, CODE, VALUE, ISVISIBLE, ISEDITABLE, REMARK, UPDATETIME, UPDATEBY, UNIT)
values (3070, '30', '3070', '0', 1, 1, '闸机报文格式 ,0新老格式都支持,1只支持新格式,2只支持老格式',sysdate, 0, null);

@repeat{SELECT COUNT(*) FROM parameter where CODE = 3071}
insert into parameter (ID, TYPE, CODE, VALUE, ISVISIBLE, ISEDITABLE, REMARK, UPDATETIME, UPDATEBY, UNIT)
values (3071, '30', '3071', '1', 1, 1, '闸机是否进行身份证验票，0否，1是，默认为1',sysdate, 0, '是否');

@repeat{SELECT count(*) FROM parameter where CODE = 3102}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (3102, '31', '3102', '0', 1, 1, '闸机是否进行检票操作，0：不检票，1：检票', sysdate, 1158013, '是否');

@repeat{SELECT count(*) FROM parameter where CODE = 3103}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (3103, '31', '3103', '1', 1, 1, '闸机是否控制本系统外的票号，0：不控制，1：控制', sysdate, 1158013, '是否');

@repeat{SELECT count(*) FROM parameter where CODE = 3105}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (3105, '31', '3105', '3', 1, 1, '检票闸机允许重复刷票进行检票的最大次数', sysdate, 1158013, '次数');

@repeat
update PARAMETER set isvisible=1 where code=3103;

@repeat{SELECT COUNT(*) FROM parameter where CODE = 3072}
insert into parameter (ID, TYPE, CODE, VALUE, ISVISIBLE, ISEDITABLE, REMARK, UPDATETIME, UPDATEBY, UNIT)
values (3072, '30', '3072', '-1', 1, 1, '发班之后，n分钟内允许通过闸机，小于0则不允许通过，0则不限制，大于0则限制；默认-1',sysdate, 0, '分钟');

@repeat{SELECT COUNT(*) FROM parameter where CODE = 3073}
insert into parameter (ID, TYPE, CODE, VALUE, ISVISIBLE, ISEDITABLE, REMARK, UPDATETIME, UPDATEBY, UNIT)
values (3073, '30', '3073', '0', 1, 1, '闸机是否检流水班的票，0否，1是，默认为0',sysdate, 0, '是否');

@repeat{SELECT COUNT(*) FROM parameter where CODE = 3074}
insert into parameter (ID, TYPE, CODE, VALUE, ISVISIBLE, ISEDITABLE, REMARK, UPDATETIME, UPDATEBY, UNIT)
values (3074, '30', '3074', '0', 1, 1, '发班之前，n分钟内能通过闸机；0则不限制；默认为0',sysdate, 0, '分钟');

@repeat{SELECT COUNT(*) FROM parameter where CODE = 3075}
insert into parameter (ID, TYPE, CODE, VALUE, ISVISIBLE, ISEDITABLE, REMARK, UPDATETIME, UPDATEBY, UNIT)
values (3075, '30', '3075', '0', 1, 1, '发班之前，n分钟内能通过侯车室进站闸机；0则不限制；默认为0',sysdate, 0, '分钟');
@repeat{SELECT COUNT(*) FROM parameter where CODE = 3076}
insert into parameter (ID, TYPE, CODE, VALUE, ISVISIBLE, ISEDITABLE, REMARK, UPDATETIME, UPDATEBY, UNIT)
values (3076, '30', '3076', '1', 1, 1, '侯车室进站闸机是否进行身份证验票，0否，1是，默认为1',sysdate, 0, '是否');
--end--
@repeat{SELECT COUNT(*)-1 FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('TICKETSELLOTHER') AND COLUMN_NAME = upper('ETICKETNO')}
alter table TICKETSELLOTHER modify ETICKETNO VARCHAR2(22);

@repeat{SELECT COUNT(*)-1 FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('ENTRYTICKET') AND COLUMN_NAME = upper('TICKETNO')}
alter table ENTRYTICKET modify TICKETNO VARCHAR2(22);