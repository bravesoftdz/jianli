--begin addby daijiy 2016-8-12  增加ic卡报班路单打印数据源  
@repeat{SELECT count(*) FROM printtemplatetypeitem where id = 337041490}
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (337041490, 6, '发车日期', '2', 'departdate', 0);
--end
@repeat{SELECT count(*) FROM Digitaldictionary where id = 6100}
insert into Digitaldictionary (ID, NAME, DESCRIBE, TABLENAME, COLUMNNAME, ISCANEDIT, UPDATETIME, UPDATEBY, ISCANADD)
values (6100, '检票日志中检票类型', '0：条码检票、1：全检、2：补检、3：混检、4：连检、5：实名制检票、6：条码实名制检票。其中直接扫描票号进行检票的记录为0，直接刷身份证或输入证件号检票的记录为5，先扫描票号查询出车票和证件信息的记录为6', 'checkticketlog', 'checktype', 0, sysdate, 1158013, 0);
@repeat{SELECT count(*) FROM Digitaldictionary where id = 6101}
insert into Digitaldictionary (ID, NAME, DESCRIBE, TABLENAME, COLUMNNAME, ISCANEDIT, UPDATETIME, UPDATEBY, ISCANADD)
values (6101, '检票日志中操作类型', '0：检票，1退检。', 'checkticketlog', 'operationtype', 0, sysdate, 1158013, 0);
@repeat{SELECT count(*) FROM Digitaldictionarydetail where id = 63090522}
insert into Digitaldictionarydetail (ID, DIGITALDICTIONARYID, ORDERNO, CODE, VALUE, DESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (63090522, 6101, 0, '0', '检票', '', sysdate, 1158013, sysdate, 1158013);
@repeat{SELECT count(*) FROM Digitaldictionarydetail where id = 63090523}
insert into Digitaldictionarydetail (ID, DIGITALDICTIONARYID, ORDERNO, CODE, VALUE, DESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (63090523, 6101, 1, '1', '退检', '', sysdate, 1158013, sysdate, 1158013);
@repeat{SELECT count(*) FROM Digitaldictionarydetail where id = 63090515}
insert into Digitaldictionarydetail (ID, DIGITALDICTIONARYID, ORDERNO, CODE, VALUE, DESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (63090515, 6100, 0, '0', '条码检票', '', sysdate, 1158013, sysdate, 1158013);
@repeat{SELECT count(*) FROM Digitaldictionarydetail where id = 63090516}
insert into Digitaldictionarydetail (ID, DIGITALDICTIONARYID, ORDERNO, CODE, VALUE, DESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (63090516, 6100, 1, '1', '全检', '', sysdate, 1158013, sysdate, 1158013);
@repeat{SELECT count(*) FROM Digitaldictionarydetail where id = 63090517}
insert into Digitaldictionarydetail (ID, DIGITALDICTIONARYID, ORDERNO, CODE, VALUE, DESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (63090517, 6100, 2, '2', '补检', '', sysdate, 1158013, sysdate, 1158013);
@repeat{SELECT count(*) FROM Digitaldictionarydetail where id = 63090518}
insert into Digitaldictionarydetail (ID, DIGITALDICTIONARYID, ORDERNO, CODE, VALUE, DESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (63090518, 6100, 3, '3', '混检', '', sysdate, 1158013, sysdate, 1158013);
@repeat{SELECT count(*) FROM Digitaldictionarydetail where id = 63090519}
insert into Digitaldictionarydetail (ID, DIGITALDICTIONARYID, ORDERNO, CODE, VALUE, DESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (63090519, 6100, 4, '4', '连检', '', sysdate, 1158013, sysdate, 1158013);
@repeat{SELECT count(*) FROM Digitaldictionarydetail where id = 63090520}
insert into Digitaldictionarydetail (ID, DIGITALDICTIONARYID, ORDERNO, CODE, VALUE, DESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (63090520, 6100, 5, '5', '实名制检票', '', sysdate, 1158013, sysdate, 1158013);
@repeat{SELECT count(*) FROM Digitaldictionarydetail where id = 63090521}
insert into Digitaldictionarydetail (ID, DIGITALDICTIONARYID, ORDERNO, CODE, VALUE, DESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (63090521, 6100, 6, '6', '条码实名制检票', '', sysdate, 1158013, sysdate, 1158013);

--begin 孙越 2016年8月18日 14:12:38 插入菜单 --
@repeat{SELECT count(*) FROM functionreg where id = 16081801}
insert into functionreg (ID, PACKAGENAME, NAME, FUNCTIONKEY, FUNCTIONDESCRIBE, PARAMETERDESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, INSTRUCTION)
values (16081801, 'QryCheckLog.bpl', '检票日志查询', '{4FEDACCB-2F4F-4C7A-A1E7-B1EFE14D6AA2}', '检票日志查询', '', sysdate, 0,sysdate, 0, '');
@repeat{SELECT count(*) FROM menu where id = 16081801}
insert into menu (ID, NAME, FUNCTIONREGID, GRADE, ORDERNO, PARENTID, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, CLICKNUM, CLAZZ, URL, ICON, SYSTYPE, MENUTYPE)
values (16081801, '检票日志查询', 16081801, 2, 8.99, 9, null, sysdate, 0,sysdate, 0, 0, null, null, null, '0', '1');
--end--
--begin  孙越 2016年8月19日 14:50   添加参数6021 --
@repeat{SELECT count(*) FROM parameter where code = '6021'}
insert into parameter (id,type,code,value,isvisible,iseditable,remark,updatetime,updateby,unit)
values(16081901,'60','6021','0',1,1,'安检合格通知单打印模板，0安检合格通知单模板，1包含安检项目明细的固定模板，默认为0',sysdate,0,'是否');
--end--
--begin 赵明亮2016年9月5日  将资金结算中的修改进行分配权限
@repeat{SELECT count(*) FROM functionpermissionreg where  PERMISSIONKEY='{F0727407-582C-4ED7-885A-64ADBF3226FE}'}
insert into functionpermissionreg (ID, FUNCTIONREGID, PERMISSIONNAME, PERMISSIONKEY, PERMISSIONDESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values ('145332', '59', '修改', '{F0727407-582C-4ED7-885A-64ADBF3226FE}', '修改', sysdate, 0,sysdate, 0);
--end

--begin zhaohh	2016-09-04 打印结算单时是否打印车票明细
@repeat{SELECT count(*) FROM parameter where code = '3088'}
insert into parameter (ID, TYPE, CODE, VALUE, ISVISIBLE, ISEDITABLE, REMARK, UPDATETIME, UPDATEBY, UNIT)
values (3088, '30', '3088', '0', 1, 1, '打印结算单时是否打印车票明细，0不打印(即模板打印)，1打印(即AcReport打印)；默认为0', SYSDATE, 0, '是否');
--end zhaohh	2016-09-04 打印结算单时是否打印车票明细

--begin孙越 2016年9月5日 14:43:51 补脚本
@repeat{SELECT count(*) FROM digitaldictionary where id= 4 }
insert into digitaldictionary (ID, NAME, DESCRIBE, TABLENAME, COLUMNNAME, ISCANEDIT, UPDATETIME, UPDATEBY)
values (4, '打印模板类型项目数据类型', '打印模板类型项目数据类型，如：项目数据类型（0普通、1数值、2日期、3纯数字）', 'printtemplatetypeitem', 'itemtype', 0, to_date('21-02-2011 10:37:01', 'dd-mm-yyyy hh24:mi:ss'), 1031532);
--end --


--begin 增加参数3039 by maxiao
@repeat{SELECT count(*) FROM parameter where code = '3039'}
insert into parameter (ID, TYPE, CODE, VALUE, ISVISIBLE, ISEDITABLE, REMARK, UPDATETIME, UPDATEBY, UNIT)
values (3039, '30', '3039', '0', 1, 1, '综合检票中，发班前是否验证驾驶员身份，0不验证，1验证，默认0', sysdate, 0, '是否');
--end


--begin 马潇 2016年8月30日14:29:51 
--增加ic卡报班权限控制
@repeat{SELECT count(*) FROM functionpermissionreg where id = 229}
insert into functionpermissionreg (ID, FUNCTIONREGID, PERMISSIONNAME, PERMISSIONKEY, PERMISSIONDESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (229, 53, '手动输入驾驶证号', '{52A064A5-6232-41CE-A850-6DFE0DACE25C}', '报班时，是否可手动输入驾驶证号进行报班', sysdate, 0,sysdate, 0);
--增加参数2046
@repeat{SELECT count(*) FROM parameter where id = 2046}
insert into parameter (ID, TYPE, CODE, VALUE, ISVISIBLE, ISEDITABLE, REMARK, UPDATETIME, UPDATEBY, UNIT)
values (2046, '00', '2046', '0', 1, 1, '脱班的定义，0车辆当天有营运计划但未发班，1车辆过发车时间未报班，默认为0', sysdate, 0, '是否');
--增加参数2047
@repeat{SELECT count(*) FROM parameter where id = 2047}
insert into parameter (ID, TYPE, CODE, VALUE, ISVISIBLE, ISEDITABLE, REMARK, UPDATETIME, UPDATEBY, UNIT)
values (2047, '00', '2047', '0', 1, 1, '晚点的定义，0车辆过发车时间报班，1车辆过发车时间发班，默认为0', sysdate, 0, '是否');
--end

--begin zhaohh 2016-09-08 结算单打印增加数据源
@repeat{SELECT count(*)-1 FROM parameter t where t.code = '3088'}
update parameter t set t.remark = '打印结算单时是否打印车票明细，0不打印(即模板打印)，1打印(即AcReport打印)，2打印（结算单模板打印车票明细），默认为0', t.unit = '' where t.code = '3088';
@repeat{SELECT count(*) FROM printtemplatetypeitem where id = 90601}
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (90601, 4, '车牌颜色', '0', 'vehiclecolor', 0);
@repeat{SELECT count(*) FROM printtemplatetypeitem where id = 90602}
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (90602, 4, '补票人数', '0', 'bupiaonum', 0);
@repeat{SELECT count(*) FROM printtemplatetypeitem where id = 90701}
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (90701, 4, '座号_明细', '0', 'seatno_detail', 1);
@repeat{SELECT count(*) FROM printtemplatetypeitem where id = 90702}
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (90702, 4, '票号_明细', '0', 'ticketno_detail', 1);
@repeat{SELECT count(*) FROM printtemplatetypeitem where id = 90703}
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (90703, 4, '到达站_明细', '0', 'reachstationname_detail', 1);
@repeat{SELECT count(*) FROM printtemplatetypeitem where id = 90704}
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (90704, 4, '票价_明细', '0', 'price_detail', 1);
@repeat{SELECT count(*) FROM printtemplatetypeitem where id = 90705}
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (90705, 4, '售票员_明细', '0', 'seller_detail', 1);
--end zhaohh 2016-09-08 结算单打印增加数据源\
--begin jyr 2016-9-20 16:17:24 车票增加打印项所属区域
@repeat{SELECT count(*) FROM printtemplatetypeitem t where t.id = '2981641'}
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (2981641, 1, '所属区域', '0', 'departstationdis', 0);
--end

--begin 2016-09-20 zhaohuaihu 给Ticketsell增加顾客姓名等冗余字段的Job
@repeat{SELECT COUNT(*) FROM jobconfig where id=822 }
insert into jobconfig (ID, ORGID, JOBNAME, FULLCLASSNAME, PARAMETERS, INTERVALTYPE, INTERVALS, STARTTIME, ENDTIME, LASTRUNTIME, REMARKS, ISACTIVE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, TYPE)
values (822, 1158012, 'UpdateTicketsellJob', 'cn.nova.bus.job.UpdateTicketsellJob', 'null', 4, 1, '00:00', '23:59', to_date('2016-08-20','yyyy-mm-dd'), '给Ticketsell增加顾客姓名等冗余字段的Job', 1, sysdate, 0, sysdate, 0, 1);
--end 2016-09-20 zhaohuaihu

--增加结算通知单车属单位数据源
@repeat{SELECT COUNT(*) FROM printtemplatetypeitem where id=337042490 }
 insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (337042490, 3, '车属单位全称', '0', 'vehicleunitname', 0);
--end

--begin 2016-09-21 zhaohuaihu 综合检票增加启用IC卡权限控制
@repeat{SELECT COUNT(*) FROM functionpermissionreg where id=6918 }
insert into functionpermissionreg (ID, FUNCTIONREGID, PERMISSIONNAME, PERMISSIONKEY, PERMISSIONDESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (6918, 54, '综合检票启用IC卡', '{A1330B4C-BA8C-48AC-AA15-4CC4CBE40D36}', '综合检票启用IC卡权限控制', sysdate, 0, sysdate, 0);
--end 2016-09-21 zhaohuaihu
--begin 2016-09-21 zhaomingliang 增加参数1115，退票时能退N天前未检车票，0表示当天
@repeat{SELECT COUNT(*) from  parameter  WHERE ID=1115 }
insert into parameter(ID,TYPE,code,value,isvisible,iseditable,remark,updatetime,updateby,unit) 
values(1115,'11','1115','0',1,1,'退票时能退N天前未检车票，0表示当天,N的值大于等于零',sysdate,0,'天');
--end
--begin jyr 2016年9月22日15:03:01  0020参数改为可见 可编辑
@repeat{SELECT count(*)-1 FROM parameter t where t.code = '0020'}
update parameter p set p.isvisible = 1 ,p.iseditable = 1  where p.code = '0020';
--end

--BEGIN 遥路 票据类型的保险单改成保险票 2016年9月22日  
update Billtype B set B.NAME='保险票' where B.Name = '保险单';
update Billtype B set B.PRINTNAME='保险票' where B.PRINTNAME = '保险单';
--END