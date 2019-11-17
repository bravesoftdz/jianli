
-- 2016年1月29日 王远媛 添加票价差额设置日期交叉异常提示 begin --
@repeat{SELECT count(*) FROM exceptioninfo where id = 757}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values (757, '0757', '时间段重复或交叉，请重新设置！', '票价差额设置');
--添加票价差额设置日期交叉异常提示 end --

@repeat{select 1-count(*) from user_tables where table_name=upper('printtemplate')}
update  printtemplate t set t.updateby=0,t.createby=0;
@repeat{select 1-count(*) from user_tables where table_name=upper('printtemplateitem')}
update printtemplateitem t set t.createby=0,t.updateby=0;


@repeat{SELECT count(*) FROM exceptioninfo where id = 6115}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values (6115, '6115', '被并班次无被并信息，并班无法恢复售票！', '并班恢复售票');

@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('driver') AND COLUMN_NAME = upper('nativeplace') }
alter table driver modify nativeplace varchar2(100);

-- 2015年8月3日 11:21:47 孙越 检票员工作月报 --
@repeat{SELECT COUNT(*) FROM functionreg where ID=80301}
insert into functionreg (ID, PACKAGENAME, NAME, FUNCTIONKEY, FUNCTIONDESCRIBE, PARAMETERDESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, INSTRUCTION)
values (80301, 'QryCheckWorkMonth.bpl', '检票员工作月报', '{36435346-832D-446F-A668-E6728A82E9A7}', '检票员工作月报', '',sysdate, 0, sysdate, 0, null);

@repeat{SELECT COUNT(*) FROM menu where ID=12412399}
insert into menu (ID, NAME, FUNCTIONREGID, GRADE, ORDERNO, PARENTID, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, URL, ICON, CLICKNUM, CLAZZ)
values (12412399, '检票员工作月报', 80301, 3, 14.00, 34, '',sysdate, 1, sysdate, 1, '', '', 0, '');
--end --
--2015-08-06 liyi 新增车辆报到后的座位类型
@repeat{SELECT COUNT(*) FROM printtemplatetypeitem where ID=1164510}
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (1164510, 1, '报到车座位类型', '0', 'vcleseattypename', 0);
--2015年8月6日 17:57:06 灭火器是否检验
@repeat{SELECT COUNT(*) FROM parameter where ID=688 or code = '6060'}
insert into parameter (ID, TYPE, CODE, VALUE, ISVISIBLE, ISEDITABLE, REMARK, UPDATETIME, UPDATEBY, UNIT)
values (688, '60', '6060', '0', 1, 1, '车辆安检是否安检灭火器，1：安检，0：不检查', sysdate, 1158013, '');
--begin 2015年8月5日  杨志文 售票点结算汇总表创建菜单 --
@repeat{SELECT COUNT(*) FROM MENU where ID=439}
insert into menu (ID, NAME, FUNCTIONREGID, GRADE, ORDERNO, PARENTID, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY,CLICKNUM, CLAZZ, URL, ICON, SYSTYPE, MENUTYPE)
values (439, '售票点结算汇总表', 439, 3, 16.00, 31, '', sysdate, 0, sysdate, 0, 0, '', '', '', 0, 1);
@repeat{SELECT COUNT(*) FROM FUNCTIONREG where ID=439}
insert into functionreg (ID, PACKAGENAME, NAME, FUNCTIONKEY, FUNCTIONDESCRIBE, PARAMETERDESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, INSTRUCTION)
values (439, 'QuerySellBalanceSummary.bpl', '售票点结算汇总表', '{1AB86E83-B17C-4DCD-92E9-A204C8C312FC}', '售票点结算汇总表', '', sysdate, 0, sysdate, 0, 
'1.售票张数=打单人数+漏乘人数+退票张数+废票张数；2.售票金额=票款金额+漏乘金额+退票金额+废票金额；3.运量金额=结算金额+固定扣费小计+客运代理费；
4.手续费=退票手续费+改签费+补票服务费；5.营收金额=票款金额-结算金额+漏乘金额+手续费。');
--end --
--begin 2015年8月10日  杨志文  参数3019将重打、补开、注销结算单的天数分开设置 --
@repeat{SELECT COUNT(*)-1 FROM PARAMETER where ID =3019}
update PARAMETER set REMARK='重打结算单的天数' where id=520 and code='3019';
@repeat{SELECT COUNT(*) FROM PARAMETER where ID=3041}
insert into PARAMETER (ID, TYPE, CODE, VALUE, ISVISIBLE, ISEDITABLE, REMARK, UPDATETIME, UPDATEBY, UNIT)
values (3041, '30', '3041', '3', 1, 1, '补开结算单的天数', SYSDATE, 0, '天');
@repeat{SELECT COUNT(*) FROM PARAMETER where ID=3042}
insert into PARAMETER (ID, TYPE, CODE, VALUE, ISVISIBLE, ISEDITABLE, REMARK, UPDATETIME, UPDATEBY, UNIT)
values (3042, '30', '3042', '3', 1, 1, '注销结算单的天数', SYSDATE, 0, '天');
--end  2015年8月10日  杨志文  参数3019将重打、补开、注销结算单的天数分开设置 --
--孙越 2015年8月11日 09:49:30  添加打印项 --
@repeat{SELECT COUNT(*) FROM printtemplatetypeitem where ID=1164796}
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (1164796, 4, '车属单位全名', '0', 'unitfullname', 0);
--end --
--begin 2015年8月11日  杨志文  增加混检时参数3036抛出的异常信息 --
@repeat{SELECT COUNT(*) FROM EXCEPTIONINFO where ID=617}
insert into EXCEPTIONINFO (ID,CODE,MSG,MODULES) values(617,'0617','该车票所属班次不是当前班次，不允许检票！','混检操作');
--end 2015年8月11日  杨志文  增加混检时参数3036抛出的异常信息 --
--20150811  liyi 新增废票废隔天票功能权限
@repeat{SELECT COUNT(*) FROM functionpermissionreg where ID=1164821}
insert into functionpermissionreg (ID, FUNCTIONREGID, PERMISSIONNAME, PERMISSIONKEY, PERMISSIONDESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (1164821, 68, '废票废隔天票', '{D28A82BB-CDD2-444A-8789-D9ADBAEE8CD3}', null, sysdate, 0, sysdate, 0);
--20150813 sunyue  是否判断车辆营运班次
@repeat{SELECT COUNT(*) FROM parameter where code='2082' }
insert into parameter (id,type,code,value,isvisible,iseditable,remark,updatetime,updateby,unit)
values(812,20,2082,0,1,1,'是否判断车辆营运班次，不是营运班次则不允许报班 1:判断 0:不判断 默认为0',sysdate,0,'是否');
--20150814 liyi  红安需求：如果车票中含有燃油费，则打印出来的车票要有（含燃补）字样
@repeat{SELECT COUNT(*) FROM printtemplatetypeitem where id=1160688}
insert into printtemplatetypeitem(id,printtemplatetypeid,itemname,itemtype,itemcode,islist) values(1160688,1,'含燃补标识','0','containfuelsign','0');

--2015年8月17日 11:07:35 孙越 添加参数 --
@repeat{SELECT COUNT(*) FROM parameter where code='3087'}
insert into parameter (id,type,code,value,isvisible,iseditable,remark,updatetime,updateby,unit)
values(817,30,3087,0,1,1,'综合检票中发班是否打印初检单，0否，1是，默认为0',sysdate,0,'是否');

@repeat{SELECT COUNT(*) FROM printtemplatetype where id=817}
insert into printtemplatetype(id,name) values(817,'初检单');

@repeat{SELECT COUNT(*) FROM printtemplatetypeitem where id=1165692}
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (1165692, 817, '发车日期', '2', 'departdate', 0);

@repeat{SELECT COUNT(*) FROM printtemplatetypeitem where id=1165694}
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (1165694, 817, '站点', '0', 'reachstation', 1);

@repeat{SELECT COUNT(*) FROM printtemplatetypeitem where id=1165693}
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (1165693, 817, '人数', '0', 'ticketnum', 1);

@repeat{SELECT COUNT(*) FROM printtemplatetypeitem where id=1165704}
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (1165704, 817, '总人数', '0', 'totalnum', 0);

@repeat{SELECT COUNT(*) FROM printtemplatetypeitem where id=1165691}
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (1165691, 817, '车牌号', '0', 'vehicleno', 0);

@repeat{SELECT COUNT(*) FROM printtemplate where id=1165695}
insert into printtemplate (ID, PRINTTEMPLATETYPEID, NAME, HEIGHT, HEIGHTCORRECTION, WIDTH, LEFTMARGIN, TOP, BACKGROUNDIMAGE, ROWSPACE, ROWPERPAGE, PRINTERNAME, COLUMNSPERPAGE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (1165695, 817, '初检单', 800, 800, 500, 0, 0, '', 50, 5, '', 1, sysdate, 0, sysdate, 0);

@repeat{SELECT COUNT(*) FROM functionpermissionreg where id=1165715}
insert into functionpermissionreg (ID, FUNCTIONREGID, PERMISSIONNAME, PERMISSIONKEY, PERMISSIONDESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (1165715, 54, '打印初检单', '{4F9C7945-472A-447E-8950-72C9A4DA7C1D}', '', sysdate, 0, sysdate, 0);
--end --

--begin 张彪 2015-08-19 修改后台任务配置表自动解锁job时间间隔--
@repeat{SELECT COUNT(*)-1 FROM jobconfig where ID=151}
update jobconfig jb set jb.intervals=3 where jb.id=151 and jb.intervals<3;
--end 张彪 2015-08-19 修改后台任务配置表自动解锁job时间间隔--
--begin 杨志文 2015-08-19 IC卡报班时是否允许通过车牌号获取驾驶员的信息--
@repeat{SELECT COUNT(*) FROM PARAMETER WHERE ID=2038}
insert into PARAMETER (ID, TYPE, CODE, VALUE, ISVISIBLE, ISEDITABLE, REMARK, UPDATETIME, UPDATEBY, UNIT) 
values (2038, 20, 2038, 0, 1, 1, 'IC卡报班时是否允许通过车牌号获取驾驶员的信息，0否，1是', sysdate, 0, '是否');
--end 杨志文 2015-08-19 IC卡报班时是否允许通过车牌号获取驾驶员的信息--
--begin 杨志文 2015-08-24 打印结算单时是否按相同站点相同距离相同票种分组打印--
@repeat{SELECT COUNT(*) FROM PARAMETER WHERE ID=4015}
insert into PARAMETER (ID, TYPE, CODE, VALUE, ISVISIBLE, ISEDITABLE, REMARK, UPDATETIME, UPDATEBY, UNIT) values
(4015, 40, 4015, 0, 1, 1, '打印结算单时0:按[始站]止站距离票价分组打印;1:按[始站]止站距离票价[票种]分组打印;2:按止站距离票价分组打印;3:按止站距离票价[票种]分组打印',	sysdate, 0,	'是否');
--end 杨志文 2015-08-24 打印结算单时是否按相同站点相同距离相同票种分组打印--


--新增参数 0066 判断有班次预售票审批权限的角色是否进行提示框弹出和音乐提醒
@repeat{SELECT 1-COUNT(*) FROM parameterorgdetail where parameterid = 267}
delete from  parameterorgdetail pd where pd.parameterid = 267;
--@repeat{SELECT 1-COUNT(*) FROM PARAMETER WHERE ID=267 or code ='0036'}
--delete from parameter where code ='0036';
--@repeat{SELECT COUNT(*) FROM PARAMETER WHERE ID=267 or code ='0036'}
--insert into parameter (ID, TYPE, CODE, VALUE, ISVISIBLE, ISEDITABLE, REMARK, UPDATETIME, UPDATEBY, UNIT)
--values (267, '00', '0036', '0', 1, 1, '生成营运计划是否开启班次预售票申请功能，1：开启；0：不开启', sysdate, 0, '是否');
@repeat{SELECT COUNT(*) FROM PARAMETER WHERE ID=366 or code ='0066'}
insert into parameter (ID, TYPE, CODE, VALUE, ISVISIBLE, ISEDITABLE, REMARK, UPDATETIME, UPDATEBY, UNIT)
values (366, '00', '0066', '0', 1, 1, '班次预售票申请提示框是否弹出：1，弹出，0不弹', sysdate, 0, '是否');
--20150827 liyi 新增昌都需求
@repeat{SELECT COUNT(*) FROM PARAMETER WHERE ID=60800 or code ='1178'}
insert into parameter (ID, TYPE, CODE, VALUE, ISVISIBLE, ISEDITABLE, REMARK, UPDATETIME, UPDATEBY, UNIT)
values (60800, '11', '1178', '0', 1, 1, '当天退票手续费率：1表示开启，当天为20%，之前为10%',sysdate, 0, '是否');

--begin 姜蓥瑞 增加 exceptioninfo 2015年8月27日14:34:44--
@repeat{SELECT COUNT(*) FROM exceptioninfo WHERE ID=756}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values (756, '0756', '该班次剩余未检座位小于连检票数！', '检票操作');
--end-- 


--20150829 结算通知单数据源：总扣费1：不包含战务费的总扣费 addby daijy
@repeat{SELECT COUNT(*) FROM printtemplatetypeitem where printtemplatetypeid=3 and itemname='总扣费1' }
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (1208711, 3, '总扣费1', '0', 'deductifee1', 0);
@repeat{SELECT COUNT(*) FROM printtemplatetypeitem where printtemplatetypeid=3 and itemname='本月上交' }
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (1208712, 3, '本月上交', '0', 'bysj', 0);
@repeat{SELECT COUNT(*) FROM printtemplatetypeitem where printtemplatetypeid=3 and itemname='上月欠交' }
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (1208713, 3, '上月欠交', '0', 'syqj', 0);
--end

--20150829 增加重打他们结算单权限脚本（补）addby daijy
@repeat{SELECT COUNT(*) FROM functionpermissionreg where ID=1208713 }
insert into functionpermissionreg (ID, FUNCTIONREGID, PERMISSIONNAME, PERMISSIONKEY, PERMISSIONDESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (1208713, 54, '重打他人结算单权限', '{44610C75-EEE4-4AFE-90E9-10137361857E}', '重打他人结算单权限', sysdate, 1158013, sysdate, 1158013);


--20150831新增参数4016 标记结算单注销时间控制 addby daijy
@repeat{SELECT COUNT(*) FROM PARAMETER WHERE ID=1164812 or code ='4016'}
insert into parameter (ID, TYPE, CODE, VALUE, ISVISIBLE, ISEDITABLE, REMARK, UPDATETIME, UPDATEBY, UNIT)
values (1164812, '40', '4016', '0', 1, 1, '注销天数限制，0不限制注销天数，其他为value天内的结算单可以注销', sysdate, 1158013, '天');
--end

--20150831 新增参数1518，用来控制已经发班的流水线班次是否可以进行改签，发班流水班包括该对应站的所有流水班次 by liyi
@repeat{SELECT COUNT(*) FROM PARAMETER WHERE ID=189 or code ='1518'}
insert into parameter (ID, TYPE, CODE, VALUE, ISVISIBLE, ISEDITABLE, REMARK, UPDATETIME, UPDATEBY, UNIT)
values (189, '15', '1518', '0', 1, 1, '流水线是否允许改签,1:允许；0：不允许', sysdate, 0, '是否');
--20150901 by liyi 新增结算单补录表字段isaudit对应的数据字典，审核状态为：未审核，审核  
@repeat{SELECT COUNT(*) FROM digitaldictionary WHERE ID=125 }
insert into digitaldictionary (ID, NAME, DESCRIBE, TABLENAME, COLUMNNAME, ISCANEDIT, UPDATETIME, UPDATEBY, ISCANADD)
values (125, '手工单补录审核状态', '0：未审核，1：审核', 'departinvoicesother', 'isaudit', 0, sysdate, 0, 0);
@repeat{SELECT COUNT(*) FROM digitaldictionarydetail WHERE ID=590 }
insert into digitaldictionarydetail (ID, DIGITALDICTIONARYID, ORDERNO, CODE, VALUE, DESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (590, 125, 0, '0', '未审核', '', sysdate, 0, sysdate, 0);
@repeat{SELECT COUNT(*) FROM digitaldictionarydetail WHERE ID=591 }
insert into digitaldictionarydetail (ID, DIGITALDICTIONARYID, ORDERNO, CODE, VALUE, DESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (591, 125, 1, '1', '审核', '', sysdate, 0, sysdate, 0);
--20150901 liyi 新增结算单补录权限控制审核和取消审核
@repeat{SELECT COUNT(*) FROM functionpermissionreg WHERE ID=1166144 }
insert into functionpermissionreg (ID, FUNCTIONREGID, PERMISSIONNAME, PERMISSIONKEY, PERMISSIONDESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (1166144, 69, '取消审核', '{CF46C104-B4CF-4D2B-AA0B-FD200821A6CD}', '结算单补录取消审核', sysdate, 0, sysdate, 0);
@repeat{SELECT COUNT(*) FROM functionpermissionreg WHERE ID=1166143 }
insert into functionpermissionreg (ID, FUNCTIONREGID, PERMISSIONNAME, PERMISSIONKEY, PERMISSIONDESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (1166143, 69, '审核', '{2E6D45A1-815D-43EB-AD91-5D756B7E4B47}', '结算单补录审核表通过审核', sysdate, 0, sysdate, 0);
-- 20150902 liyi  新增参数判断手工单是否需要审核才可进行结算
@repeat{SELECT COUNT(*) FROM parameter WHERE ID=299 or code ='4050' }
insert into parameter (ID, TYPE, CODE, VALUE, ISVISIBLE, ISEDITABLE, REMARK, UPDATETIME, UPDATEBY, UNIT)
values (299, '40', '4050', '0', 1, 1, '手工单结算是否需要审核：1，需要；0，不需要',sysdate, 0, '是否');
--20150906 liyi 新增参数判断结算单补录班次是否取当天发班班次 1：取，0：不取，不取表示所有
@repeat{SELECT COUNT(*) FROM parameter WHERE ID=60788 or code ='4025' }
insert into parameter (ID, TYPE, CODE, VALUE, ISVISIBLE, ISEDITABLE, REMARK, UPDATETIME, UPDATEBY, UNIT)
values (60788, '40', '4025', '1', 1, 1, '0:表示结算单补录班次只取当天发班班次，1：取所有', sysdate, 0, '是否');

--20150906 Daijy 新增参数控制售票问询自动刷新频率 
@repeat{SELECT COUNT(*) FROM parameter WHERE ID=60789 or code ='1111' }
insert into parameter (ID, TYPE, CODE, VALUE, ISVISIBLE, ISEDITABLE, REMARK, UPDATETIME, UPDATEBY, UNIT)
values (60789, '10', '1111', '10', 1, 1, '售票问询刷新频率：秒。', sysdate, 0, '秒');
--end


--20150908 改签凭证打印增加改签票号 addby daijy
@repeat{SELECT COUNT(*) FROM printtemplatetypeitem where ID=1199417 }
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (1199417, 1, '改签票号', '3', 'changeticketno', 0);
--end

--增加行车路单打印项  BUG #5918 【未发补丁】来凤强发客运站+打印路单+01 李电志  2015年9月8日 14:55:43 begin 
@repeat{SELECT COUNT(*) FROM printtemplatetypeitem where ID=1165688 } 
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (1165688, 6, '始发站', '0', 'beginstation', 0);
@repeat{SELECT COUNT(*) FROM printtemplatetypeitem where ID=1165691 } 
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (1165691, 6, '终点车站', '0', 'zdstation', 0);
@repeat{SELECT COUNT(*) FROM printtemplatetypeitem where ID=1165696 } 
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (1165696, 6, '测试公里', '0', 'testdistance', 0);
@repeat{SELECT COUNT(*) FROM printtemplatetypeitem where ID=1165700 } 
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (1165700, 6, '测试人次', '0', 'testseatnum', 0);
@repeat{SELECT COUNT(*) FROM printtemplatetypeitem where ID=1165702 } 
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (1165702, 6, '测试人公里', '0', 'testpeopledistance', 0);
@repeat{SELECT COUNT(*) FROM printtemplate where ID=2 } 
insert into printtemplate (ID, PRINTTEMPLATETYPEID, NAME, HEIGHT, HEIGHTCORRECTION, WIDTH, LEFTMARGIN, TOP, BACKGROUNDIMAGE, ROWSPACE, ROWPERPAGE, PRINTERNAME, COLUMNSPERPAGE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, AUTOPAGES, PRINTHEIGHTTYPE)
values (2, 6, '行车路单号', 1400, 1000, 1000, 0, 0, null, 50, 5, 'EPSON LQ-300K+II ESC/P2', 1, sysdate, 0, sysdate, 0, 0, 0);
@repeat{SELECT COUNT(*) FROM printtemplateitem where ID=1165689 } 
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (1165689, 2, 1165688, '始发站', 1, '宋体', 11.0000, 220, 119, 119, 40, '2', '', sysdate, 0, sysdate, 0);
@repeat{SELECT COUNT(*) FROM printtemplateitem where ID=1165692 } 
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (1165692, 2, 1165691, '终点车站', 1, '宋体', 11.0000, 220, 273, 159, 40, '2', '', sysdate, 0, sysdate, 0);
@repeat{SELECT COUNT(*) FROM printtemplateitem where ID=1165697 } 
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (1165697, 2, 1165696, '测试公里', 1, '宋体', 11.0000, 220, 476, 159, 40, '2', '', sysdate, 0, sysdate, 0);
@repeat{SELECT COUNT(*) FROM printtemplateitem where ID=1165701 } 
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (1165701, 2, 1165700, '测试人次', 1, '宋体', 11.0000, 220, 680, 159, 40, '2', '', sysdate, 0, sysdate, 0);
@repeat{SELECT COUNT(*) FROM printtemplateitem where ID=1165703 } 
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (1165703, 2, 1165702, '测试人公里', 1, '宋体', 11.0000, 220, 860, 198, 40, '2', '', sysdate, 0, sysdate, 0);
--增加行车路单打印项  BUG #5918 【未发补丁】来凤强发客运站+打印路单+01 李电志  2015年9月8日 14:55:43 end 

--begin 姜蓥瑞 2015年9月9日14:41:17 增加参数 6070--
@repeat{SELECT COUNT(*) FROM parameter where ID=655 }
insert into parameter (ID, TYPE, CODE, VALUE, ISVISIBLE, ISEDITABLE, REMARK, UPDATETIME, UPDATEBY, UNIT)
values (655, '60', '6070', '1', 1, 1, '安检不合格能否打印结算单，0不能，1能，默认为0', sysdate, 1158013, '');
---end--
--begin 杨志文 2015-09-09 结算单打印模板增加结算单位全称
@repeat{SELECT COUNT(*) FROM PRINTTEMPLATETYPEITEM where ID=10142 } 
insert into printtemplatetypeitem (id, printtemplatetypeid, itemname, itemtype, itemcode, islist)
values(10142, 4, '结算单位全称', '0', 'balanceunitfullname', 0);
--end 杨志文 2015-09-09 结算单打印模板增加结算单位全称
--begin 杨志文 2015-09-09 保险单打印模板增加打印项
@repeat{SELECT COUNT(*) FROM PRINTTEMPLATETYPEITEM where ID=346 } 
insert into printtemplatetypeitem (id, printtemplatetypeid, itemname, itemtype, itemcode, islist)
values(346, 2, '意外伤害保险金额', '1', 'emoney', 0);
@repeat{SELECT COUNT(*) FROM PRINTTEMPLATETYPEITEM where ID=347 } 
insert into printtemplatetypeitem (id, printtemplatetypeid, itemname, itemtype, itemcode, islist)
values(347, 2, '意外伤害医疗保险金额', '1', 'emmoney', 0);
@repeat{SELECT COUNT(*) FROM PRINTTEMPLATETYPEITEM where ID=348 } 
insert into printtemplatetypeitem (id, printtemplatetypeid, itemname, itemtype, itemcode, islist)
values(348, 2, '保险票出票时间', '2', 'reprintdatetime', 0);
--end 杨志文 2015-09-09 保险单打印模板增加打印项
@repeat{SELECT COUNT(*) FROM PARAMETER where code ='3067'}
insert into parameter values (3067,'30','3067','0','1','1','混检是否允许检到留位上，0：不允许，1：允许',sysdate,0,'是否');
--begin 20150910 addby daijy  增加参数 1112--
@repeat{SELECT COUNT(*) FROM parameter where ID=656 }
insert into parameter (ID, TYPE, CODE, VALUE, ISVISIBLE, ISEDITABLE, REMARK, UPDATETIME, UPDATEBY, UNIT)
values (656, '10', '1112', '0', 1, 1, '当前售票站点只能售当前站及始发站发班的票，0不启用，1启用，默认为0.', sysdate, 1158013, '');
---end--

--孙越 2015年9月16日 09:42:05 线路停靠点售票统计表中统计方式数据字典脚本 --
@repeat{SELECT COUNT(*) FROM digitaldictionary where id =111}
insert into digitaldictionary (ID, NAME, DESCRIBE, TABLENAME, COLUMNNAME, ISCANEDIT, UPDATETIME, UPDATEBY)
values (111, '统计方式', '1站点、2路线、3售票员', 'routesaleticketreport', 'grouptype', 0, sysdate, 618619);

@repeat{SELECT COUNT(*) FROM digitaldictionarydetail where id =2277}
insert into digitaldictionarydetail (ID, DIGITALDICTIONARYID, ORDERNO, CODE, VALUE, DESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (2277, 111, 1, '1', '站点', '', sysdate, 0, sysdate, 0);

@repeat{SELECT COUNT(*) FROM digitaldictionarydetail where id =2278}
insert into digitaldictionarydetail (ID, DIGITALDICTIONARYID, ORDERNO, CODE, VALUE, DESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (2278, 111, 2, '2', '路线', '', sysdate, 0, sysdate, 0);

@repeat{SELECT COUNT(*) FROM digitaldictionarydetail where id =2279}
insert into digitaldictionarydetail (ID, DIGITALDICTIONARYID, ORDERNO, CODE, VALUE, DESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (2279, 111, 3, '3', '售票员', '', sysdate, 0, sysdate, 0);

--end--
--begin 姜蓥瑞 2015年9月16日07:32:34  安检不合格，不打印结算单--
@repeat{SELECT COUNT(*) FROM exceptioninfo where id =466}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values (466, '0466', '安检不合格，不打印结算单!', '车辆安检');
---end--
--begin 姜蓥瑞 2015-9-17 18:26:20   9059--
@repeat{SELECT COUNT(*) FROM parameter where id =950}
insert into parameter (ID, TYPE, CODE, VALUE, ISVISIBLE, ISEDITABLE, REMARK, UPDATETIME, UPDATEBY, UNIT)
values (950, '10', '9050', '0', 1, 1, '报班车型与计划车型不一致时，是否修改计划车型及对应票价    0否，1是，默认为0', sysdate, 1158013, '是否');
---end--

--begin 张彪 2015-09-18 实名制售票相关参数--

@repeat{SELECT COUNT(*) FROM parameter WHERE ID=9393 or code ='9393' }
insert into parameter (ID, TYPE, CODE, VALUE, ISVISIBLE, ISEDITABLE, REMARK, UPDATETIME, UPDATEBY, UNIT)
values (9393, '10', '9393', '0', 1, 1, '是否实名制售票：0否，1是', sysdate, 1158013, '');

@repeat{SELECT COUNT(*) FROM parameter WHERE ID=9494 or code ='9494' }
insert into parameter (ID, TYPE, CODE, VALUE, ISVISIBLE, ISEDITABLE, REMARK, UPDATETIME, UPDATEBY, UNIT)
values (9494, '10', '9494', '0', 1, 1, '实名制售票是否弹出乘客信息录入框：0否，1是', sysdate, 1158013, '');


@repeat{SELECT COUNT(*) FROM parameter WHERE ID=9797 or code ='9797' }
insert into parameter (ID, TYPE, CODE, VALUE, ISVISIBLE, ISEDITABLE, REMARK, UPDATETIME, UPDATEBY, UNIT)
values (9797, '10', '9797', '0', 1, 1, '实名制售票是否必须输入乘客姓名：0否，1是', sysdate, 1158013, '');

@repeat{SELECT COUNT(*) FROM parameter WHERE ID=9898 or code ='9898' }
insert into parameter (ID, TYPE, CODE, VALUE, ISVISIBLE, ISEDITABLE, REMARK, UPDATETIME, UPDATEBY, UNIT)
values (9898, '10', '9898', '0', 1, 1, '实名制售票是否默认填写乘客信息：0否，1是', sysdate, 1158013, '');


@repeat{SELECT COUNT(*) FROM printtemplatetypeitem WHERE ID=1227029  }
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (1227029, 1, '乘客姓名', '0', 'customername', 0);

@repeat{SELECT COUNT(*) FROM printtemplatetypeitem WHERE ID=1337029 }
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (1337029, 1, '乘客身份证号', '0', 'certificateno', 0);

--end 张彪 2015-09-18 实名制售票相关参数--

--孙越 2015年9月19日 13:25:59 修改参数--
@repeat{SELECT COUNT(*)-1 FROM parameter WHERE code='0021'  }
update parameter p set p.REMARK = '票价生成方式：0：线路票价，1：硬调票价; 2: 公式票价' where p.code = '0021';
--end--
--修改参数4003备注内容 20150928 liyi
@repeat{SELECT COUNT(*)-1 FROM parameter WHERE code='4003'  }
update parameter p set p.REMARK = '营收缴款的实缴款自动赋值：0，不允许、1，允许' where p.code = '4003';
--新增二连浩特需求，退票手续费公式的计算 20150929 Liyi
@repeat{SELECT COUNT(*) FROM parameter WHERE code='1179'  }
insert into parameter (ID, TYPE, CODE, VALUE, ISVISIBLE, ISEDITABLE, REMARK, UPDATETIME, UPDATEBY, UNIT)
values (60880, '11', '1179', '0', 1, 1, '是否启用二连浩特退票公式：1表示启用，0表示不启用', sysdate, 0, '是否');
--修改参数3027的类型，20151009 liyi 
@repeat{SELECT 1-COUNT(*) FROM parameter WHERE code='3027'  }
update parameter p set p.type ='30' where p.code ='3027';

--新增综合调度座位信息，取消并班，恢复可售票权限  20151013 liyi
@repeat{SELECT COUNT(*) FROM functionpermissionreg WHERE ID=350  }
insert into functionpermissionreg (ID, FUNCTIONREGID, PERMISSIONNAME, PERMISSIONKEY, PERMISSIONDESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (350, 41, '座位信息', '{2B3BF9FD-4280-46AD-A10C-6B15452682E9}', '', sysdate, 0, sysdate, 0);
@repeat{SELECT COUNT(*) FROM functionpermissionreg WHERE ID=351  }
insert into functionpermissionreg (ID, FUNCTIONREGID, PERMISSIONNAME, PERMISSIONKEY, PERMISSIONDESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (351, 41, '取消并班', '{6B49FC01-E576-4801-ABC7-5A93FBB1B2B4}', '', sysdate, 0, sysdate, 0);
@repeat{SELECT COUNT(*) FROM functionpermissionreg WHERE ID=352  }
insert into functionpermissionreg (ID, FUNCTIONREGID, PERMISSIONNAME, PERMISSIONKEY, PERMISSIONDESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (352, 41, '恢复售票', '{8D3533AD-C69F-4CF7-A50E-2A3954E8B4C8}', '', sysdate, 0, sysdate, 0);
--END
--begin 2015年10月12日  杨志文 驾驶员驾驶车辆设置创建菜单 --
@repeat{SELECT COUNT(*) FROM MENU where ID=443}
insert into menu (ID, NAME, FUNCTIONREGID, GRADE, ORDERNO, PARENTID, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY,CLICKNUM, CLAZZ, URL, ICON, SYSTYPE, MENUTYPE)
values (443, '驾驶员驾驶车辆设置', 443, 2, 12.00, 1, '', sysdate, 0, sysdate, 0, 0, '', '', '', 0, 1);
@repeat{SELECT COUNT(*) FROM FUNCTIONREG where ID=443}
insert into functionreg (ID, PACKAGENAME, NAME, FUNCTIONKEY, FUNCTIONDESCRIBE, PARAMETERDESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, INSTRUCTION)
values (443, 'SetDriverVehicle.bpl', '驾驶员驾驶车辆设置', '{322B24DC-07B5-4F91-ADD8-C70B1221B0C7}', '驾驶员驾驶车辆设置', '', sysdate, 0, sysdate, 0, 
'报班时选取驾驶员的优先顺序：a班次循环的驾驶员b【驾驶员驾驶车辆设置】c驾驶员档案管理中的建制车号d手动填写');
--end --
--新增IC卡报班的可控权限，20151014 liyi
@repeat{SELECT COUNT(*) FROM functionpermissionreg WHERE ID=330  }
insert into functionpermissionreg (ID, FUNCTIONREGID, PERMISSIONNAME, PERMISSIONKEY, PERMISSIONDESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (330, 53, '报到', '{27EFFFDD-929A-4B1A-9CF3-79D347AD878D}', '', sysdate, 0, sysdate, 0);
@repeat{SELECT COUNT(*) FROM functionpermissionreg WHERE ID=331  }
insert into functionpermissionreg (ID, FUNCTIONREGID, PERMISSIONNAME, PERMISSIONKEY, PERMISSIONDESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (331, 53, '取消报到', '{303388F8-8C91-4045-AF8F-C77BB831906E}', '', sysdate, 0, sysdate, 0);
@repeat{SELECT COUNT(*) FROM functionpermissionreg WHERE ID=332  }
insert into functionpermissionreg (ID, FUNCTIONREGID, PERMISSIONNAME, PERMISSIONKEY, PERMISSIONDESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (332, 53, '晚点处理', '{70C32B77-2605-4948-A55E-03F802DFED7B}', '', sysdate, 0,sysdate, 0);
@repeat{SELECT COUNT(*) FROM functionpermissionreg WHERE ID=333  }
insert into functionpermissionreg (ID, FUNCTIONREGID, PERMISSIONNAME, PERMISSIONKEY, PERMISSIONDESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (333, 53, '换车报到', '{C0D62F22-A4BD-4563-8E95-6DD82623837D}', '', sysdate, 0, sysdate, 0);
--end
--新增只扣除站务费的结算单价，分组显示的  20151016 liyi
@repeat{SELECT COUNT(*) FROM printtemplatetypeitem WHERE ID=1164303  }
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (1164303, 4, '分组只扣除站务费结算单价', '0', 'noservicestationfee', 1);
--end
---begin  姜蓥瑞 2015年10月19日11:36:32 -- 
@repeat{SELECT COUNT(*) FROM functionreg where ID=8121 }
insert into functionreg (ID, PACKAGENAME, NAME, FUNCTIONKEY, FUNCTIONDESCRIBE, PARAMETERDESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, INSTRUCTION)
values (8121, 'VehicleRouteSetting.bpl', '车辆运营线路设置', '{C1591827-4528-429E-B027-29EA6495ED4C}', '车辆运营线路设置', '', sysdate, 0, sysdate, 0, null);
@repeat{SELECT COUNT(*) FROM menu where ID=1164826 }
insert into menu (ID, NAME, FUNCTIONREGID, GRADE, ORDERNO, PARENTID, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, CLICKNUM, CLAZZ, URL, ICON, SYSTYPE, MENUTYPE)
values (1164826, '车辆运营线路设置', 8121, 3, 12.50, 6, '', sysdate, 0, sysdate, 0, 0, '', '', '', '0', '1');
@repeat{SELECT COUNT(*) FROM parameter where ID=5678 }
insert into parameter (id,type,code,value,isvisible,iseditable,remark,updatetime,updateby,unit)
values(5678,20,5678,0,1,1,'IC卡报班是否自动报班，0否，1是',sysdate,0,'');
--end
---begin 姜蓥瑞 2015年10月30日04:22:21
@repeat{SELECT COUNT(*) FROM functionpermissionreg where PERMISSIONKEY='{4146270C-1A10-4320-BF91-79415EF50779}' }
insert into functionpermissionreg (ID, FUNCTIONREGID, PERMISSIONNAME, PERMISSIONKEY, PERMISSIONDESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (1239825, 15, '是否查询他人营收', '{4146270C-1A10-4320-BF91-79415EF50779}', '是否查询他人营收权限', sysdate, 0, sysdate, 0);
--end--

--孙越2015年10月30日 16:44:02修改异常信息描述--
update exceptioninfo set msg = '座位不是锁定状态,请刷新页面重新卖票' where code = '0205';
--end--
--begin liyi 20151030
@repeat{SELECT COUNT(*) FROM printtemplatetypeitem where ID=73786305 }
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (73786305, 6, '核定座位数', '0', 'rationseatnum1', 0);
--end
--begin liyi 20151104  营收缴款新增 网购票号和废票号
@repeat{SELECT COUNT(*) FROM printtemplatetypeitem where ID=739859 }
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (739859, 6546, '网购票号', '0', 'ticketnoOnline', 0);
@repeat{SELECT COUNT(*) FROM printtemplatetypeitem where ID=739860 }
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (739860, 6546, '废票号', '0', 'ticketnoCancel', 0);
--end
--end=======
--end

--孙越 2015年11月2日 11:04:44 增加按钮权限 --
@repeat{SELECT COUNT(*) FROM functionpermissionreg where ID=110201 }
insert into functionpermissionreg (id,functionregid,permissionname,permissionkey,permissiondescribe,createtime,createby,updatetime,updateby)
values(110201,115,'路单明细','{D6261953-A6D0-4B47-BB44-D08B87A2356D}','',sysdate,0,sysdate,0);
@repeat{SELECT COUNT(*) FROM functionpermissionreg where ID=110202 }
insert into functionpermissionreg (id,functionregid,permissionname,permissionkey,permissiondescribe,createtime,createby,updatetime,updateby)
values(110202,115,'路单明细打印','{9D9DDDA1-FCCF-4862-9BB5-4CDE85B26A1B}','',sysdate,0,sysdate,0);
--end--

@repeat{SELECT COUNT(*) FROM digitaldictionarydetail where id=8131 }
insert into digitaldictionarydetail (ID, DIGITALDICTIONARYID, ORDERNO, CODE, VALUE, DESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (8131, 1121, 2, '2', '小件寄存', '', sysdate, 0, sysdate, 0);
@repeat{SELECT COUNT(*) FROM functionpermissionreg where id=10021 }
insert into functionpermissionreg (ID, FUNCTIONREGID, PERMISSIONNAME, PERMISSIONKEY, PERMISSIONDESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (10021, 123, '行包退票', '{08E2D2A8-C225-437C-BC74-914E7E7D0351}', '', sysdate, 0, sysdate, 0);
@repeat{SELECT COUNT(*) FROM functionpermissionreg where id=10022 }
insert into functionpermissionreg (ID, FUNCTIONREGID, PERMISSIONNAME, PERMISSIONKEY, PERMISSIONDESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (10022, 123, '行包作废', '{95A0F1EE-000D-48E3-8F55-93B422E5E2F9}', '', sysdate, 0, sysdate, 0);
--20151110 liyi  处理结算单结算中的应结金额，是否进行四舍五入
update parameter p set p.REMARK='应结金额进位规则：1四舍五入、2舍去、3入、4小于5角进到5角，高于5角进到1元、5保留小数点' where p.code = '4068';

--end--
--begin 20151111  liyi 新增综合检票补开权限
@repeat{SELECT COUNT(*) FROM functionpermissionreg where id=1239783 }
insert into functionpermissionreg (ID, FUNCTIONREGID, PERMISSIONNAME, PERMISSIONKEY, PERMISSIONDESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (1239783, 54, '补开', '{7D99A6FC-846D-492D-99FD-507F67692F18}', '补开结算单', sysdate, 0, sysdate, 0);
--end
--begin  20151113 liyi  新增初检单菜单
@repeat{SELECT COUNT(*) FROM menu where id=358 }
insert into menu (ID, NAME, FUNCTIONREGID, GRADE, ORDERNO, PARENTID, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, CLICKNUM, CLAZZ, URL, ICON, SYSTYPE, MENUTYPE)
values (358, '重置初检单号', 2, 2, 3.50, 8, 'FirstBalanceBill', sysdate, 0,sysdate, 0, 0, '', '', '', '0', '1');
--end
--begin 20151113 liyi 新增初检单打印和重打初检单权限
@repeat{SELECT COUNT(*) FROM functionpermissionreg where id=1165715 }
insert into functionpermissionreg (ID, FUNCTIONREGID, PERMISSIONNAME, PERMISSIONKEY, PERMISSIONDESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (1165715, 54, '打印初检单', '{4F9C7945-472A-447E-8950-72C9A4DA7C1D}', '', sysdate, 0, sysdate, 0);
@repeat{SELECT COUNT(*) FROM functionpermissionreg where id=1239824 }
insert into functionpermissionreg (ID, FUNCTIONREGID, PERMISSIONNAME, PERMISSIONKEY, PERMISSIONDESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (1239824, 54, '重打初检单', '{3B139970-A8A5-4E53-963B-015E13FEDE65}', '重打初检单', sysdate, 0, sysdate, 0);
--end--
--begin 20151116 liyi 新增初检单票价类型
@repeat{SELECT COUNT(*) FROM billtype where id=1239803 }
insert into billtype (ID, CODE, NAME, PRINTNAME, DESCRIPTION, TICKETNOLENGTH, MEDIUM, PARVALUE, NUMPERBOX, ISACTIVE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (1239803, 'FirstBalanceBill', '初检单', '初检单', '', 8, '0', 1.000, 100, 1, sysdate, 0, sysdate, 0);
@repeat{SELECT COUNT(*) FROM parameter where id=345 }
insert into parameter (ID, TYPE, CODE, VALUE, ISVISIBLE, ISEDITABLE, REMARK, UPDATETIME, UPDATEBY, UNIT)
values (345, '30', '3045', '0', 1, 1, '综合检票界面是否显示初检单号，0：不显示，1：显示', sysdate, 0, '是否');

--新增初检单打印项，打单人姓名和打单人工号  20151116 liyi 
@repeat{SELECT COUNT(*) FROM printtemplatetypeitem where id=1276531 }
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (1276531, 817, '打单人姓名', '0', 'printName', 0);
@repeat{SELECT COUNT(*) FROM printtemplatetypeitem where id=1276532 }
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (1276532, 817, '打单人工号', '0', 'printcode', 0);
--end
--begin   打印结算单添加行包件数和行包结算金额
@repeat{SELECT COUNT(*) FROM printtemplatetypeitem where id=581 }
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (581, 4, '件数', '0', 'packes', 0);
@repeat{SELECT COUNT(*) FROM printtemplatetypeitem where id=582 }
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (582, 4, '行包结算金额', '0', 'packbalanceprice', 0);
--end
--begin  新增初检单单号打印项 20151117 2015年11月17日20:16:06
@repeat{SELECT COUNT(*) FROM printtemplatetypeitem where id=1172252 }
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (1172252, 817, '初检单号', '0', 'firstcheckinvoicesno', 0);
--end
--begin姜蓥瑞 2015年11月16日18:10:07 
﻿@repeat{SELECT COUNT(*)-1 FROM PARAMETER where ID =9393}
update parameter a set a.remark = '是否实名制售票：0否，1全局实名制，2固定线路实名制' where a.id = 9393;
﻿@repeat{SELECT COUNT(*)-1 FROM PARAMETER where ID =218}
update parameter a set a.remark = '燃油费设置是否生成到票价中（结算）0取票价公式组成项中设置的值，1取燃油费设置中的值' where a.id = 218;
--end

--begin addby daijy 2015年11月25 
@repeat{SELECT COUNT(*) FROM functionreg where id=1224279 }
insert into functionreg (ID, PACKAGENAME, NAME, FUNCTIONKEY, FUNCTIONDESCRIBE, PARAMETERDESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, INSTRUCTION)
values (1224279, 'SellerTaskReport.bpl', '售票员任务表', '{53AA1AEE-9976-4A8D-AFC1-8D776B6E16ED}', '售票员任务表', '', sysdate, 0, sysdate, 0, null);
@repeat{SELECT COUNT(*) FROM menu where id=1224279 }
insert into menu (ID, NAME, FUNCTIONREGID, GRADE, ORDERNO, PARENTID, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, CLAZZ, URL, ICON, CLICKNUM, SYSTYPE, MENUTYPE)
values (1224279, '售票员任务表', 1224279, 3, 31.00, 300, '', sysdate, 0, sysdate, 0, '', '', '', 0, '0', '1');
@repeat{SELECT COUNT(*) FROM parameter where id=1819 }
insert into parameter (ID, TYPE, CODE, VALUE, ISVISIBLE, ISEDITABLE, REMARK, UPDATETIME, UPDATEBY, UNIT)
values (1819, '20', '1819', '1', 1, 1, 'IC报班-界面中是否显示"结算单号码"', sysdate, 0, '');
--end
--孙越 2015年12月1日 14:50:55 添加换票废票查询 菜单功能 --
@repeat{SELECT COUNT(*) FROM functionreg where id=120101 }
insert into functionreg (id,packagename,name,functionkey,functiondescribe,parameterdescribe,createtime,createby,updatetime,updateby,instruction)
values(120101,'QueryChangeCancelTicket.bpl','换票废票查询','{5FA703FB-935F-4905-B6AF-2810B18567BD}','换票废票查询','',sysdate,0,sysdate,0,'');
@repeat{SELECT COUNT(*) FROM menu where id=120101 }
insert into menu (ID, NAME, FUNCTIONREGID, GRADE, ORDERNO, PARENTID, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, CLICKNUM, CLAZZ, URL, ICON, SYSTYPE, MENUTYPE)
values (120101, '换票废票查询', 120101, 3, 27.00, 30, '',sysdate, 1158013,sysdate, 0, 0, '', '', '', '0', '1');
--end--
--孙越 2015年12月1日 17:23:52 改签是否打印手续费--
@repeat{SELECT COUNT(*) FROM parameter where code='1066' }
insert into parameter (id,type,code,value,isvisible,iseditable,remark,updatetime,updateby,unit)
values(120101,'10','1066','1',1,1,'改签是否打印手续费. 1打印 0不打印',sysdate,0,'是否');
--end--
--孙越 2015年11月26日 10:52:57 第三者责任险异常 --
@repeat{SELECT COUNT(*) FROM exceptioninfo where id=112401 }
insert into exceptioninfo (id,code,msg,modules)
values(112401,'0499','第三者责任险已过期,不允许报班！','报班');
--end--

--begin addby daijy 2015年12月3 
@repeat{SELECT COUNT(*) FROM parameter where id=9999 }
insert into parameter (ID, TYPE, CODE, VALUE, ISVISIBLE, ISEDITABLE, REMARK, UPDATETIME, UPDATEBY, UNIT)
values (9999, '20', '9999', '1', 1, 1, '配载班次停班时，是否以始发站为准。默认为1：以始发站为准。',sysdate, 0, '是否');
--end
--孙越 2015年12月7日 20:56:23 补开结算单是否添写售票员参数控制 --


@repeat{SELECT COUNT(*) FROM parameter where code='3066' }
insert into parameter(id,type,code,value,isvisible ,iseditable,remark,updatetime,updateby,unit)
values(120702,'30','3066','0',1,1,'补开结算单是否填写售票员，0否，1是，默认为0',sysdate,0,'是否');

--end--
--孙越 2015年12月8日 15:41:19 添加售票员结算单查询--
@repeat{SELECT COUNT(*) FROM functionreg where id='120801' }
insert into functionreg(id, packagename, name, functionkey, parameterdescribe, createtime, createby, updatetime, updateby, instruction)
values(120801,'SellerDepartinvoices.bpl','售票员结算单查询','{2A57C5B6-A16A-41D5-A39F-0A2CDDBAB3AC}','售票员结算单查询',sysdate,0,sysdate,0,'');

@repeat{SELECT COUNT(*) FROM menu where id='120801' }
insert into menu (ID, NAME, FUNCTIONREGID, GRADE, ORDERNO, PARENTID, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, CLICKNUM, CLAZZ, URL, ICON, SYSTYPE, MENUTYPE)
values (120801, '售票员结算单查询', 120801, 3, 23.50, 6851, '',  sysdate, 0,sysdate, 0, 0, '', '', '', '0', '1');

@repeat{SELECT COUNT(*) FROM printtemplatetypeitem where id='120801' }
insert into printtemplatetypeitem(id,printtemplatetypeid,itemname,itemtype,itemcode,islist)
values(120801,4,'售票员',0,'seller',0);
--end--
--孙越 2015年12月7日 15:05:24 增加参数控制--
@repeat{SELECT COUNT(*) FROM parameter where id=120701 }
insert into parameter(id,type,code,value,isvisible ,iseditable,remark,updatetime,updateby,unit)
values(120701,'11','1166','0',1,1,'退票是否需要审核，0否，1是，默认为0',sysdate,0,'是否');
--end
--孙越 2015年12月7日 15:52:10 退票审核权限 --
@repeat{SELECT COUNT(*) FROM functionpermissionreg where id=120701 }
insert into functionpermissionreg(id,functionregid,permissionname,permissionkey,permissiondescribe,createtime,createby,updatetime,updateby)
values(120701,67,'退票审核授权','{5B5B2395-1382-4CD9-80A2-BF30201CD2E4}','',sysdate,0,sysdate,0);
--end --
--begin addby daijy 2015年12月8日
@repeat{SELECT COUNT(*) FROM parameter where id=1165812 or code ='1080' }
insert into parameter (ID, TYPE, CODE, VALUE, ISVISIBLE, ISEDITABLE, REMARK, UPDATETIME, UPDATEBY, UNIT)
values (1165812, '10', '1080', '0', 1, 1, '售票时，站务费是否根据票价公式设置取值。默认为0：不根据票价公式设置取值。',sysdate, 0, '是否');
--end

--孙越 2015年12月9日 18:44:21 添加菜单--
@repeat{SELECT COUNT(*) FROM functionreg where id=120901 }
insert into functionreg(id, packagename, name, functionkey, parameterdescribe, createtime, createby, updatetime, updateby, instruction)
values(120901,'StationUnitBalance.bpl','车站各经营单位核算表','{921B5570-13B6-4059-8462-D8BBAF71C2BD}','',sysdate,0,sysdate,0,'');

@repeat{SELECT COUNT(*) FROM menu where id=120901 }
insert into menu (ID, NAME, FUNCTIONREGID, GRADE, ORDERNO, PARENTID, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, CLICKNUM, CLAZZ, URL, ICON, SYSTYPE, MENUTYPE)
values (120901, '车站各经营单位核算表', 120901, 3,17.00, 31, '',  sysdate, 0,sysdate, 0, 0, '', '', '', '0', '1');
--end--
--begin 2015年12月4日15:46:36 liyi 修改6006参数备注
@repeat{select count(1)-1 from parameter p where p.code ='6006' }
update parameter p set p.remark ='是否开启二维有效期和第三者责任险有效期判断' where p.code ='6006';
--end
--begin  2015年12月11日 15:23:44--  liyi  新增营收缴款的模板控制参数 英山模板
@repeat{select count(1) from parameter p where p.code ='4038' }
insert into parameter (ID, TYPE, CODE, VALUE, ISVISIBLE, ISEDITABLE, REMARK, UPDATETIME, UPDATEBY, UNIT)
values (388, '40', '4038', '0', 1, 1, '0:营收缴款统计表使用普通模板；1：英山模板', sysdate, 0, '是否');
--end
--begin 2015年12月15日  18:31:21-- SunYangyang  温泉客运站【湖北】         综合检票，结算单管理    打印结算单增加补开两个字
@repeat{SELECT COUNT(*) FROM printtemplatetypeitem where id=740156 }
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (740156, 4, '补开', '0', 'reopen', 0);

@repeat{SELECT COUNT(*) FROM printtemplateitem where id=740167 }
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (740167, 228070, 740156, '补开', 1, '宋体', 11.0000, 651, 566, 79, 40, '2', '', to_date('15-12-2015 16:43:19', 'dd-mm-yyyy hh24:mi:ss'), 1126281, to_date('15-12-2015 16:43:19', 'dd-mm-yyyy hh24:mi:ss'), 1126281);
--end
--begin 2015年12月18日温泉客运站    IC卡报班，自动报班改由界面复选框控制  杨志文（yzw）
@repeat{SELECT COUNT(*)-1 FROM PARAMETERORGDETAIL where parameterid=5678 }
delete from PARAMETERORGDETAIL where parameterid=5678;
@repeat{SELECT COUNT(*)-1 FROM PARAMETER where id=5678 }
delete from parameter p where p.id=5678 and code='5678' and remark like '%IC卡报班是否自动报班%'; 
--end  2015年12月18日温泉客运站    IC卡报班，自动报班改由界面复选框控制  杨志文（yzw）
--begin 2015.12.18  营收缴款缴款票号段数据源新增
@repeat{SELECT COUNT(*) FROM printtemplatetypeitem where id=1165854 }
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (1165854, 6546, '缴款起止票号段', '0', 'ticketnostartandend', 0);
--end--

--begin 孙越  2015年12月25日 15:47:12 更新所有站点distance为null的记录为0
@repeat{select 1-count(*) from user_tables where table_name=upper('station')}
update station s set s.distance = 0 where s.distance is null;
--end--

--begin 孙越  2015年12月31日 10:32:12 更新0015参数说明 --
@repeat{select count(1)-1 from parameter p where p.code ='0015' }
update parameter t set t.remark = '燃油费设置是否生成到票价中：0取票价公式组成项中设置的值，1燃油费设置中的值' where t.code = '0015';
--end --

--begin 李春  2015-12-31 售票员手工单营收汇总表
@repeat{SELECT COUNT(*) FROM menu where id=800 }
insert into menu (ID, NAME, FUNCTIONREGID, GRADE, ORDERNO, PARENTID, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, URL, ICON, CLICKNUM, CLAZZ)
values (800, '售票员手工单营收汇总表', 800, 3, 7.00, 31, '', sysdate, 0, sysdate, 0, '', '', 0, '');

@repeat{SELECT COUNT(*) FROM functionreg where id=800 }
insert into FUNCTIONREG (ID, PACKAGENAME, NAME, FUNCTIONKEY, FUNCTIONDESCRIBE, PARAMETERDESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, INSTRUCTION)
values (800, 'TicketSellerSumReport.bpl', '售票员手工单营收汇总表', '{1C276159-AA52-4387-BB8B-E5274BD7D158}', '售票员手工单营收汇总表', '', sysdate, 0, sysdate, 0, null);
--end 李春 2015-12-31  售票员手工单营收汇总表

--begin 赵怀虎 2015-12-30  洮阳客运站 结算单补录（精简）
@repeat{select count(*) from menu where id=2312401}
insert into menu (ID, NAME, FUNCTIONREGID, GRADE, ORDERNO, PARENTID, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, URL, ICON, CLICKNUM, CLAZZ)
values (2312401, '结算单补录（精简）', 2312401, 2, 4.10, 8, '', sysdate, 0, sysdate, 0, '', '', 0, '');
@repeat{select count(*) from functionreg where id=2312401}
insert into functionreg (ID, PACKAGENAME, NAME, FUNCTIONKEY, FUNCTIONDESCRIBE, PARAMETERDESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, INSTRUCTION)
values (2312401, 'DepartinvoicesotherSimple.bpl', '结算单补录（精简）', '{E70496A0-86C6-4736-BD20-69FD1B9435D0}', '结算单补录（精简）', '', sysdate, 0, sysdate, 0, null);
--end 赵怀虎 2015-12-30  洮阳客运站 结算单补录（精简）
--20160106 liyi 修改安检合格通知单 数据源名称
@repeat{select 1-count(*) from printtemplatetypeitem where id=100001 and printtemplatetypeid=6224}
update printtemplatetypeitem t set t.itemname='营运证编号' where t.printtemplatetypeid=6224 and t.id =100001;
--end
@repeat{select count(*) from functionreg where id=146}
insert into functionreg (ID, PACKAGENAME, NAME, FUNCTIONKEY, FUNCTIONDESCRIBE, PARAMETERDESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, INSTRUCTION)
values (146, 'hirebusaccept.bpl', '包车信息', '{F39823A8-D66C-4422-BF13-C79E8E2ECFE0}', '包车信息', '', sysdate, 1158013, sysdate, 1158013, null);


@repeat{SELECT count(*) FROM exceptioninfo where id = 757}
insert into exceptioninfo (ID, CODE, MSG, MODULES) values(757,'0757','该车辆必须通过GPS安检合格才能报到！','IC卡报班');
--20160128 liyi  修改2022参数备注
@repeat{select 1-count(*) from parameter where code='2022'}
update parameter p set p.remark = '报到车辆座位数小于已售座位数是否允许报到，0:不允许，1：允许',p.value='0',p.isvisible='0' where p.code ='2022';
--end


@repeat{SELECT count(*) FROM exceptioninfo where id = 6119}
insert into exceptioninfo values(6119,6119,'当前机构没有设置上级所属机构！','登录');
--删除0036功能 2016年2月17日 16:56:03 李毅
--@repeat{SELECT 1-count(*) FROM parameter where code='0036'}
--delete from parameter p where p.code ='0036';
--end


--begin addby daijy 20160224  密文加密错误提示
@repeat{SELECT COUNT(*) FROM exceptioninfo where id=112601 }
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values (112601, '0500', '售票记录密文错误！', '校验售票加密');
--end
--20160226  liyi 1105参数增加参数6进位规则新增保留一位小数四舍五入  
@repeat{select 1-count(*) from parameter where code='1105'}
update parameter p set p.remark ='退票手续费进位规则：1四舍五入、2舍去、3入、4小于5角进到5角，高于5角进到1元、5保留小数点,6保留一位小数四舍五入' where id =1105;
--end
--20160227 liyi 新增参数1110，用来判断当手续费为0时，是否打印退票凭证
@repeat{select count(*) from parameter where code='1110'}
insert into PARAMETER (ID, TYPE, CODE, VALUE, ISVISIBLE, ISEDITABLE, REMARK, UPDATETIME, UPDATEBY, UNIT)
values (1110, '11', '1110', '1', 1, 1, '退票手续费为0是否打印退票凭证，0：不打印，1：打印', sysdate, 1158013, '');
--end
--20160229  liyi 修改1002显示班次的备注，售票问询，售票显示
@repeat{select 1-count(*) from parameter where code='1002'}
update parameter p set p.remark ='售票问询，售票界面是否显示全部班次，0：显示全部班次；1：显示正常班次' where code='1002';
--end
--liyi 2016年3月1日16:58:53 修改数据源名称，身份证号改成证件号，为了满足不同类型的证件号
@repeat{select 1-count(*) from printtemplatetypeitem where id = 1337029}
update printtemplatetypeitem t set t.itemname='乘客证件号' where t.itemcode='certificateno' and t.id = 1337029;
--end

--daijinyan  2016-3-8  修改商业险提示改为第三者责任险
@repeat{select 1-count(*) from exceptioninfo where code ='0905'}
update exceptioninfo set msg='该车辆第三者责任险日期已过期，不允许报班！'  where code ='0905';
@repeat{select 1-count(*) from exceptioninfo where code ='0499'}
update exceptioninfo set msg='第三者责任险已过期,不允许报班！'  where code ='0499';
--end

--daijy 2016-3-22 增加参数1069，补票是否打印凭证，0不打印，1打印，
@repeat{select count(*) from parameter where code='1069' or id=20162317}
insert into parameter (ID, TYPE, CODE, VALUE, ISVISIBLE, ISEDITABLE, REMARK, UPDATETIME, UPDATEBY, UNIT)
values (20162317, '10', '1069', '1', 1, 1, '(特权)补票是否打印凭证，0不打印，1打印，默认为1', sysdate, 1158013, '是否');
--end

update  parameter t set t.unit='是否' where t.unit='boolean';

update   parameter t  set t.isvisible=0 where t.code='1004';
update   parameter t  set t.isvisible=0 where t.code='2082';

update   parameter t  set t.remark='是否只允许车辆报到在已指定的线路中（车牌管理、车辆可营运线路、当天排车的班次）,0允许报到所有线路，1只允许报到指定线路，默认为0' where t.code='2021';


update parameter set remark='同一车牌多次报到最小时间间隔(发班时间间隔)，单位：分钟，0表示不限制'  where code = '2020';

update parameter set remark='补票截止时间为发车前N分钟，正数为发车前，负数为发车后，默认为300秒'  where code = '1015';

@repeat{SELECT COUNT(*) FROM parameter where id=1061 }
insert into parameter (ID, TYPE, CODE, VALUE, ISVISIBLE, ISEDITABLE, REMARK, UPDATETIME, UPDATEBY, UNIT)
values (1061, '10', '1061', '5', 1, 1, '班次最多免票带儿童数/班次最多带儿童占班次座位数的百分比。提示：设置此参数前需先设置参数1012', sysdate, 0, '个数/%');

update parameter set remark='补票界面是否显示售票截止时间之前的班次，0不显示，1显示，默认为0'  where code = '1047';

delete   digitaldictionarydetail  t where t.digitaldictionaryid=17 and t.orderno>1;

@repeat{SELECT COUNT(*) FROM parameter where id=2035 }
insert into parameter (ID, TYPE, CODE, VALUE, ISVISIBLE, ISEDITABLE, REMARK, UPDATETIME, UPDATEBY, UNIT)
values (2035, '20', '2035', '0', 1, 1, 'IC卡报班时流水班是否只显示一条记录，0报到n个车辆显示n条记录，1只显示一条记录，默认为0', sysdate, 0,'是否');


@repeat{SELECT COUNT(*) FROM printtemplatetypeitem where id=615}
insert into printtemplatetypeitem
  (id, printtemplatetypeid, itemname, itemtype, itemcode, islist)
values
  (615, 22, '安检员', '0', 'checker', 0);
@repeat{SELECT COUNT(*) FROM printtemplatetypeitem where id=616}
insert into printtemplatetypeitem
  (id, printtemplatetypeid, itemname, itemtype, itemcode, islist)
values
  (616, 22, '安检员工工号', '0', 'checkercode', 0);  
@repeat{SELECT COUNT(*) FROM printtemplatetypeitem where id=617}  
insert into printtemplatetypeitem
  (id, printtemplatetypeid, itemname, itemtype, itemcode, islist)
values
  (617, 22, '安检车站', '0', 'checkorg', 0);
@repeat{SELECT COUNT(*) FROM printtemplatetypeitem where id=618}    
  insert into printtemplatetypeitem
  (id, printtemplatetypeid, itemname, itemtype, itemcode, islist)
values
  (618, 22, '安检时间', '2', 'checktime', 0);    
@repeat{SELECT COUNT(*) FROM printtemplatetypeitem where id=620}    
  insert into printtemplatetypeitem
  (id, printtemplatetypeid, itemname, itemtype, itemcode, islist)
values
  (620, 22, '驾驶员', '0', 'drivername', 0);
@repeat{SELECT COUNT(*) FROM printtemplatetypeitem where id=620}      
  insert into printtemplatetypeitem
  (id, printtemplatetypeid, itemname, itemtype, itemcode, islist)
values
  (621, 22, '维修项目分项', '0', 'needmaintenance', 0);
@repeat{SELECT COUNT(*) FROM printtemplatetypeitem where id=621} 
  insert into printtemplatetypeitem
  (id, printtemplatetypeid, itemname, itemtype, itemcode, islist)
values
  (623, 22, '车牌号', '0', 'vehicleno', 0);
@repeat{SELECT COUNT(*) FROM printtemplatetypeitem where id=623}
  insert into printtemplatetypeitem
  (id, printtemplatetypeid, itemname, itemtype, itemcode, islist)
values
  (907, 22, '复检日期', '0', 'rechecktime', 0);
@repeat{SELECT COUNT(*) FROM printtemplatetypeitem where id=80882} 
  insert into printtemplatetypeitem
  (id, printtemplatetypeid, itemname, itemtype, itemcode, islist)
values
  (80882, 22, '营运线路', '0', 'routename', 0);
@repeat{SELECT COUNT(*) FROM printtemplatetypeitem where id=80883} 
  insert into printtemplatetypeitem
  (id, printtemplatetypeid, itemname, itemtype, itemcode, islist)
values
  (80883, 22, '终点站', '0', 'endstation', 0);

--begin addby daijy  20160329
@repeat{SELECT COUNT(*) FROM exceptioninfo where id=16012901 or code='0481'}  
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values (16012901, '0481', '该车辆还未报到！', '出站检查登记表');
--end

@repeat{SELECT COUNT(*)-1 FROM parameter where code = '1005'}
update parameter t set  t.remark='票号初始化自动填写当前车票票号，0不填写，1填写，默认为1' where t.code='1005';

@repeat{SELECT COUNT(*)-1 FROM exceptioninfo where code = '0499'}
update exceptioninfo set msg ='第三者责任险已过期,无法进行后续操作！'  where code = '0499';

@repeat{SELECT COUNT(*)-1 FROM parameter where code = '1301'}
update parameter t set  t.remark='订票服务费收取方式，0固定金额，1比例，默认为0;需要设置1302参数的值' where t.code='1301';


@repeat{SELECT COUNT(*)-1 FROM parameter where code = '1058'}
update parameter t set  t.remark='半票票价取值方式，0取全票票价的一半，1取执行票价中的半票票价，默认为0,参考0017参数硬调票价半价的取值方式' where t.code='1058';

@repeat{SELECT COUNT(*)-1 FROM parameter where code = '8008'}
update parameter t set  t.remark='(行包提领)行包每天保管费' where t.code='8008';

@repeat{SELECT COUNT(*)-1 FROM parameter where code = '8023'}
update parameter t set  t.remark='(行包提领)行包基本保管费' where t.code='8023';



--begin addby daijy 20160108 添加行包受理单数据源：服务费
@repeat{SELECT COUNT(*) FROM Printtemplatetypeitem where id=73786405 }  
insert into Printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (73786405, 7, '服务费', '0', 'servicefeemoney', 0);

--end

@repeat{SELECT COUNT(*)-1 FROM parameter where code = '0012'}
update parameter set remark='设置硬调票价时：是否限制线路停靠点前站里程必须小于后站里程，0不限制，1限制，默认为1(控制线路管理中线路停靠点添加时里程的限制)' where code='0012';

update vehicle v set v.nextmaintaindistance=0 where v.nextmaintaindistance is null;

@repeat{SELECT COUNT(*)-1 FROM parameter where code = '8085'}
update parameter p set p.type='31',p.remark='IC卡报班的驾驶员是否必须是证件核查通过的驾驶员，0不是，1是，默认为0' where code='8085';
@repeat{SELECT COUNT(*)-1 FROM parameter where code = '8086'}
update parameter p set p.type='60',p.remark='证件过期是否允许核查通过，0不允许，1允许，默认为0' where code='8086';

--begin 孙越 2016年4月12日 18:30:58 添加参数4017 --
@repeat{SELECT COUNT(*) FROM PARAMETER where code='4017' } 
insert into parameter (ID, TYPE, CODE, VALUE, ISVISIBLE, ISEDITABLE, REMARK, UPDATETIME, UPDATEBY, UNIT)
values (16041201, '80', '4017', '0', 1, 1, '结算通知单打印模板，0结算通知单模板，1包含线路、车牌号明细的固定模板，默认为0', sysdate, 0, '');
--end--

@repeat{select count(*) from exceptioninfo where code ='0758'}
insert into exceptioninfo values(0758,'0758','同一线路报班间隔不能小于线路中规定的时间','报班');
@repeat{select count(*) from exceptioninfo where code ='0759'}
insert into exceptioninfo values(0759,'0759','驾驶员报班间隔不能小于系统中规定的时间','报班');
@repeat{select count(*) from exceptioninfo where code ='0760'}
insert into exceptioninfo values(0760,'0760','该车辆必须通过GPS安检合格才能报到！','报班');

@repeat{SELECT count(*) FROM printtemplatetypeitem where id = 13701 or itemcode='noItemAndagentdeduct'}
insert into printtemplatetypeitem
  (id, printtemplatetypeid, itemname, itemtype, itemcode, islist)
values
  (13701, 3, '除票价分项客代费的扣费', '0', 'noItemAndagentdeduct',0);


--begin addby daijy 添加自定义异常
@repeat{SELECT COUNT(*) FROM exceptioninfo where ID=818 or code = '0818'} 
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values (818, '0818', '要减少的座位在中心存在售票/留位记录，不允许调整！', '综合调度、修改座位数');

@repeat{SELECT COUNT(*)-1 FROM parameter where code = '1045'}
update parameter t set  t.remark='(退票、废票、营收缴款页面)是否显示保险信息，0不显示，1显示，默认为0' where t.code='1045';
--end

--begin zhaohuaihu 2016-04-23 修改1015参数备注
@repeat{SELECT COUNT(*)-1 FROM parameter where code = '1015'}
update parameter t set t.remark = '补票截止时间为发车前N分钟，正数为发车前，负数为发车后，默认为300分钟', t.value = '-300' where t.code = '1015';
--end zhaohuaihu 2016-04-23 修改1015参数备注

@repeat{SELECT COUNT(*)-1 FROM parameter where code = '1107'}
update parameter t set  t.remark='退票手续费计算方式，0表示票价*退票手续费率，1表示（票价-站务费）*退票手续费率+站务费，2表示票价*退票手续费率+站务费，3（票价-4）*退票手续费率+4，默认为0' where t.code='1107';


--begin yzw 2016年4月21日 运费结算明细表(动态展现)
--@repeat{SELECT 0 FROM menupermission where menuid=373758 }
--delete from  menupermission t where t.menuid=373758;
--@repeat{SELECT COUNT(*)-1 FROM menu where id=373758 }
--delete from menu t where t.id=373758 and t.name='运费结算明细表';
--原sql:insert into menu (ID, NAME, FUNCTIONREGID, GRADE, ORDERNO, PARENTID, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, CLICKNUM, CLAZZ, URL, ICON, SYSTYPE, MENUTYPE)
--values (373758, '运费结算明细表', 207, 3, 12.00, 31, null, sysdate, 618619, sysdate, 618619, 0, null, null, null, '0', '1');
@repeat{SELECT COUNT(*) FROM menu where id=220101 }
insert into menu (ID, NAME, FUNCTIONREGID, GRADE, ORDERNO, PARENTID, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, CLICKNUM, CLAZZ, URL, ICON, SYSTYPE, MENUTYPE)
values (220101, '运费结算明细表(网页版)', 100100, 3, 13.00, 31, 'ui/report/queryBalanceItem', sysdate, 0, sysdate, 0, 0, null, 'ui/report/queryBalanceItem', null, '0', '1');
--end yzw 2016年4月21日 运费结算明细表(动态展现)

--begin  马潇  2016年5月4日日 10:22:05   -- 
@repeat{SELECT COUNT(*) FROM menu  where ID=225 }
insert into menu (ID, NAME, FUNCTIONREGID, GRADE, ORDERNO, PARENTID, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, URL, ICON, CLICKNUM, CLAZZ)
values (225, '保险销售汇总表', 225, 3, '26.01', 30, '',sysdate , 0, sysdate, 0, '', '', null, '');

@repeat{SELECT COUNT(*) FROM functionreg  where ID=225 }
insert into functionreg (ID, PACKAGENAME, NAME, FUNCTIONKEY, FUNCTIONDESCRIBE, PARAMETERDESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, INSTRUCTION) 
values(225, 'QueryInsurance.bpl', '保险销售汇总表', '{03FCF2FF-7B6A-48A9-8E15-FE6C27551726}', '保险销售汇总表', '', sysdate, 0, sysdate, 0, null);

@repeat{SELECT COUNT(*)-1 from  Menu  WHERE ID=220 }  
UPDATE Menu m SET Name = '保险销售明细表' where m.id=220;
--end--


--begin add by daijy 还原原有运费结算明细表
@repeat{SELECT COUNT(*) FROM menu  where ID=373758 or name='运费结算明细表' }
insert into menu (ID, NAME, FUNCTIONREGID, GRADE, ORDERNO, PARENTID, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, CLICKNUM, CLAZZ, URL, ICON, SYSTYPE, MENUTYPE)
values (373758, '运费结算明细表', 207, 3, 12.00, 31, null, sysdate, 618619, sysdate, 618619, 0, null, null, null, '0', '1');
@repeat{SELECT COUNT(*) FROM printtemplatetypeitem  where ID=73786505 }
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (73786505, 3, '货运代理费', '0', 'hydlffee', 0);
@repeat{SELECT COUNT(*)-1 from  Menu  WHERE ID=220101 }  
UPDATE Menu m SET Name = '运费结算明细表(网页版)' where m.id=220101;
@repeat{SELECT COUNT(*) FROM printtemplatetypeitem  where ID=73786605 }
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (73786605, 3, '车属单位', '0', 'vehicleunit', 0);
--end

--begin  接口售票的支付方式现在新增了【4：支付宝5：微信】--
@repeat{SELECT COUNT(*) FROM digitaldictionarydetail where id=1001 }
insert into digitaldictionarydetail values(1001,50,4,4,'支付宝','支付宝支付',sysdate,0,sysdate,0);
@repeat{SELECT COUNT(*) FROM digitaldictionarydetail where id=1002 }
insert into digitaldictionarydetail values(1002,50,5,5,'微信','微信支付',sysdate,0,sysdate,0);
--end--

--start addby zhangqingfeng  保险服务器对接
@repeat{SELECT count(*) FROM parameter where id = 16060101}
insert into parameter (ID, TYPE, CODE, VALUE, ISVISIBLE, ISEDITABLE, REMARK, UPDATETIME, UPDATEBY, UNIT)
values (16060101, '10', '2626', '0', 1, 1, '是否使用bus365平台售保险，0不适用，1使用，默认0', sysdate, 0, '是否');
@repeat{SELECT count(*) FROM jobconfig where id = 154}
insert into jobconfig (ID, ORGID, JOBNAME, FULLCLASSNAME, PARAMETERS, INTERVALTYPE, INTERVALS, STARTTIME, ENDTIME, LASTRUNTIME, REMARKS, ISACTIVE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, TYPE)
values (154, 1158012, 'AutoPlatformInsuranceJob', 'cn.nova.bus.job.AutoPlatformInsuranceJob', 'null', 2, 1, '00:00', '23:59', sysdate, null, 1, sysdate, 1158013, sysdate, 1158013, 1);
--end addby zhangqingfeng  保险服务器对接

--begin addby daijy  修改4017参数类型说明
@repeat{SELECT COUNT(*)-1 from  parameter  WHERE code='4017' }  
update parameter p  set p.type='40' where p.code='4017';
--end

--begin zhaohuaihu 2016-06-13 增加3069参数
@repeat{SELECT COUNT(*) FROM parameter where code='3069' }
insert into parameter (ID, TYPE, CODE, VALUE, ISVISIBLE, ISEDITABLE, REMARK, UPDATETIME, UPDATEBY, UNIT)
values (3069, '30', '3069', '0', 1, 1, '检票闸机是否允许预售票通过，0不允许，1允许，默认为0', sysdate, 0, '是否');
--end

--start addby zhangqingfeng 打印模板增加图片
@repeat{SELECT count(*) FROM digitaldictionarydetail where id = 20160526}
insert into digitaldictionarydetail (ID, DIGITALDICTIONARYID, ORDERNO, CODE, VALUE, DESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (20160526, 5, 8, '8', '图片', '打印图片', sysdate, 0, sysdate, 0);
@repeat{SELECT count(*) FROM printtemplatetypeitem where id = -6}
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (-6, -1, '图片', '0', 'printpicture', 0);
--end addby zhangqingfeng 打印模板增加图片

--start addby maxiao 售票点售票控制
@repeat{SELECT COUNT(*) FROM functionreg  where ID=521 }
insert into functionreg (ID, PACKAGENAME, NAME, FUNCTIONKEY, FUNCTIONDESCRIBE, PARAMETERDESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, INSTRUCTION) 
values(521, 'TicketoutletStr.bpl', '售票点售票控制', '{089F3486-716C-4E4B-80CF-4D66F9F2AC9F}', '售票点售票控制', '', sysdate, 0, sysdate, 0, null);
@repeat{SELECT COUNT(*) FROM menu  where ID=521}

insert into menu (ID, NAME, FUNCTIONREGID, GRADE, ORDERNO, PARENTID, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, URL, ICON, CLICKNUM, CLAZZ)
values (521, '售票点售票控制', 521, 2, '0.89', 1, '',sysdate , 0, sysdate, 0, '', '', null, '');

@repeat{SELECT COUNT(*) FROM exceptioninfo  where ID=482}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values (482, '0482', '售票未上缴金额大于售票站点最大金额，请上缴以后再售票！', '售票');
--end addby maxiao 售票点售票控制 

--start addby zhangqingfeng 20160708 平台售保险管理
@repeat{SELECT COUNT(*) FROM parameter  where ID=160070701}
insert into parameter (ID, TYPE, CODE, VALUE, ISVISIBLE, ISEDITABLE, REMARK, UPDATETIME, UPDATEBY, UNIT)
values (160070701, '10', '2627', '0', 1, 1, '平台售保险自助机或者网上售票退票退保控制0不控制1控制，默然0', sysdate, 0, '是否');
@repeat{SELECT COUNT(*) FROM exceptioninfo  where ID=517}                                        
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values (517, '0517', '自助机或者网站售保,不允许退票退保险', '退保险');   
@repeat{SELECT COUNT(*) FROM exceptioninfo  where ID=484} 
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values (484, '0484', 'bus365售保险服务器没有启动，不能售票！', '售票'); 
--end addby zhangqingfeng 平台售保险管理

--start addby maxiao 20160801 路单打印模板添加线路名称、报班乘务员数据源
@repeat{SELECT COUNT(*) from  printtemplatetypeitem  WHERE ID=700 }
insert into printtemplatetypeitem  values (700,6,'线路名称',0,'routename',0);
@repeat{SELECT COUNT(*) from  printtemplatetypeitem  WHERE ID=701 }
insert into printtemplatetypeitem  values (701,6,'报班乘务员',0,'stewardname',0);
--end addby maxiao 平台售保险管理

--begin zhaohuaihu 20160804 车辆证件过期，自动停班。时间间隔为1天
@repeat{SELECT COUNT(*) FROM jobconfig  where ID=1084}
insert into jobconfig (ID, ORGID, JOBNAME, FULLCLASSNAME, PARAMETERS, INTERVALTYPE, INTERVALS, STARTTIME, ENDTIME, LASTRUNTIME, REMARKS, ISACTIVE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, TYPE)
values (1084, 1158012, 'AutoStopScheduleplanJob', 'cn.nova.bus.job.AutoStopScheduleplanJob', null, 4, 1, '00:00', '23:59', sysdate, '自动停班', 0, sysdate, 0, sysdate, 0, 1);
--end zhaohuaihu 20160804

--begin zhaohuaihu 20160810 增加车辆停车费(手工)扣费项
@repeat{SELECT COUNT(*) FROM Balancedeductitem  where ID=1608}
insert into Balancedeductitem (ID, ORGID, NAME, PARENTID, ISDEDUCTBEFOREBALANCE, DEDUCTTYPE, DEDUCTMONEY, DESCRIPTION, ISAUDITED, ISAUDITPASS, ISACTIVE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, ISTICKETPRICEITEM, CODE, ISEXPRESS, FORMULA)
values (1608, 1158012, '车辆停车费', 0, 0, '6', 0.000, '', 0, 0, 1, sysdate, 0, sysdate, 0, 0, 'cltcffee', 0, '');
--end zhaohuaihu 20160810 增加车辆停车费(手工)扣费项

--add by zhangqingfeng 20160824 IC卡报班增加车属单位功能权限控制 start
@repeat{SELECT COUNT(*) FROM Functionpermissionreg  where ID=334}
insert into Functionpermissionreg (ID, FUNCTIONREGID, PERMISSIONNAME, PERMISSIONKEY, PERMISSIONDESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (334, 53, '只能报本司车辆', '{C73196CC-F7DE-4217-BB51-DA26BE9074A7}', '只能报本司车辆', sysdate, 0, sysdate, 0);
@repeat{SELECT COUNT(*) FROM Functionpermissionreg  where ID=335}
insert into Functionpermissionreg (ID, FUNCTIONREGID, PERMISSIONNAME, PERMISSIONKEY, PERMISSIONDESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (335, 53, '只能报外司车辆', '{C9D132C1-724D-446F-92FA-84B7A17039B6}', '只能报外司车辆', sysdate, 0, sysdate, 0);
@repeat{SELECT COUNT(*) FROM parameter  where ID=20160818 or code='2045'}
insert into parameter (ID, TYPE, CODE, VALUE, ISVISIBLE, ISEDITABLE, REMARK, UPDATETIME, UPDATEBY, UNIT)
values (20160818, '20', '2045', '0', 1, 1, 'IC卡报班是否开启按车辆单位类型分配权限进行报到，0不开启，1开启，默认为0', sysdate, 0, 'boolean');

--add by zhangqingfeng 20160824 IC卡报班增加车属单位功能权限控制 end

--add by zqf 电子支付 start 
@repeat{SELECT COUNT(*) from  menu  WHERE ID=20160810 } 
insert into menu (ID, NAME, FUNCTIONREGID, GRADE, ORDERNO, PARENTID, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, CLAZZ, URL, ICON, CLICKNUM, SYSTYPE, MENUTYPE)
values (20160810, '特殊退款', 20160810, 2, 4.51, 3, null, sysdate, 1012127, sysdate, 1012127, null, null, null, 0, '0', '1');
@repeat{SELECT COUNT(*) from  functionreg  WHERE ID=20160810 } 
insert into functionreg (ID, PACKAGENAME, NAME, FUNCTIONKEY, FUNCTIONDESCRIBE, PARAMETERDESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, INSTRUCTION)
values (20160810, 'TicketEPayReturn.bpl', '特殊退款', '{C6CD425E-DFEE-423D-A40C-E6DBAD499B68}', '特殊退款', null,sysdate, 0, sysdate, 0, '<CLOB>');
--add by zqf 电子支付 end

--add by maxiao 增加参数1073 start 
@repeat{SELECT count(*) FROM parameter where id = 1073}
insert into parameter (ID, TYPE, CODE, VALUE, ISVISIBLE, ISEDITABLE, REMARK, UPDATETIME, UPDATEBY, UNIT)
values (1073, '00', '1073', '0', 1, 1, '售票员营收缴款页面参数设为1时，显示现金支付部分和电子支付部分，参数值设为0时，只显示现金支付部分',sysdate, 0, '是否');
--add by maxiao 增加参数 end

--begin  2016-09-02 zhaohh 增加打印出站登记表按钮权限
@repeat{SELECT count(*) FROM functionpermissionreg where id = 16902}
insert into functionpermissionreg (ID, FUNCTIONREGID, PERMISSIONNAME, PERMISSIONKEY, PERMISSIONDESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (16902, 510, '打印出站登记表', '{2488E5F8-3366-44F3-80AE-69CC26890AE7}', '出站检查登记表AcReport打印出站登记表', sysdate, 0, sysdate, 0);
--end 2016-09-02 zhaohh

@repeat{SELECT count(*) FROM menu where id = 309}
insert into menu (ID, NAME, FUNCTIONREGID, GRADE, ORDERNO, PARENTID, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (309, '外站缴款单', 238, 2, 17.90, 4, '', to_date('06-01-2014 10:33:04', 'dd-mm-yyyy hh24:mi:ss'), 0, to_date('06-01-2014 10:33:04', 'dd-mm-yyyy hh24:mi:ss'), 0);
@repeat{SELECT count(*) FROM menu where id = 400}
insert into menu (ID, NAME, FUNCTIONREGID, GRADE, ORDERNO, PARENTID, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (400, '单车结算查询', 300, 2, 11.00, 4, '', to_date('06-01-2014 10:33:04', 'dd-mm-yyyy hh24:mi:ss'), 0, to_date('06-01-2014 10:33:04', 'dd-mm-yyyy hh24:mi:ss'), 0);

-- begin孙越 2017年8月3日 10:35:17 添加脱班罚金打印数据源--
@repeat{SELECT count(*) FROM printtemplatetypeitem where id = 17080301}
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (17080301, 4, '脱班罚金', '0', 'lostfee', 0);
--end--

-- begin孙越  2017年8月12日 16:58:51 菜单--
@repeat{SELECT count(*) FROM functionreg where id = 17080101}
insert into functionreg (ID, PACKAGENAME, NAME, FUNCTIONKEY, FUNCTIONDESCRIBE, PARAMETERDESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, INSTRUCTION)
values (17080101, 'RouteTicketTypePrice.bpl', '售票点票种差额', '{B444AB03-BF09-4853-86AD-16AE2860392F}', '售票点票种差额', '',sysdate, 0, sysdate, 0, null);
@repeat{SELECT count(*) FROM menu where id=17081201 }
insert into menu (ID, NAME, FUNCTIONREGID, GRADE, ORDERNO, PARENTID, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, CLICKNUM, CLAZZ, URL, ICON, SYSTYPE, MENUTYPE)
values (17081201, '售票点票种差额', 17080101, '4', '25.00', '1060019', null,sysdate, '0',sysdate, '0', '0', null, null, null, '0', '1');
--end--
--begin 孙越 2017年8月18日 09:13:55 心跳包功能--
@repeat{SELECT count(*) FROM functionreg where id = 17081601}
insert into functionreg (ID, PACKAGENAME, NAME, FUNCTIONKEY, FUNCTIONDESCRIBE, PARAMETERDESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, INSTRUCTION)
values (17081601, 'HeartBeat.bpl', '心跳包', '{624DD1FA-8898-4563-B80C-F0646AACBECE}', '心跳包', '',sysdate, 0, sysdate, 0, null);
--end--

--begin zhaohuaihu 20170823 #11356 行车路单增加打印项；  #11365 安检单通知增加重打权限
@repeat{SELECT count(*) FROM printtemplatetypeitem where ITEMCODE = 'begindate'}
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (60801, 6, '开始日期', '2', 'begindate', 0);
@repeat{SELECT count(*) FROM printtemplatetypeitem where ITEMCODE = 'enddate'}
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (60802, 6, '截止日期', '2', 'enddate', 0);
@repeat{SELECT count(*) FROM printtemplatetypeitem where ITEMCODE = 'vehicleloadnum'}
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (60803, 6, '车载人数', '1', 'vehicleloadnum', 0);

@repeat{SELECT count(*) FROM functionpermissionreg where id = 10825}
insert into functionpermissionreg (ID, FUNCTIONREGID, PERMISSIONNAME, PERMISSIONKEY, PERMISSIONDESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (10825, 10, '重打', '{DBA1A3E1-CBC2-4DE9-A9E2-336C96F57BF6}', '重打安检单通知', sysdate, 0, sysdate, 0);
--end zhaohuaihu 20170823 行车路单增加打印项

--begin 孙越 2017年9月5日 10:56:33  路单增加打印项 --
@repeat{SELECT COUNT(*) FROM printtemplatetypeitem where ID=17090501}
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (17090501, 6, '已检人数', '1', 'checkednum', 0);
@repeat{SELECT COUNT(*) FROM printtemplatetypeitem where ID=17090502}
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (17090502, 6, '线路标志牌号', '1', 'roadno', 0);
@repeat{SELECT COUNT(*) FROM printtemplatetypeitem where ID=17090503}
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (17090503, 6, '道路运输证号', '1', 'workno', 0);
--end--


--begin
@repeat{SELECT COUNT(*) FROM exceptioninfo where code='0761'}
insert into exceptioninfo values(761,'0761','同一结算单号只能补录一个班次，请重新选择班次','补录');

--end--
--begin 孙越 2017年10月9日 17:10:47  车票增加打印项 --
@repeat{SELECT COUNT(*) FROM printtemplatetypeitem where ID=17100901}
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (17100901, 1, '取票点', '1', 'takestationname', 0);
--end--

--begin 仉喜宝 2017年10月25日  新增行包粘贴单 打印
@repeat{SELECT COUNT(*) FROM PRINTTEMPLATETYPE where ID=25}
insert into PRINTTEMPLATETYPE (ID, NAME)
values (25,'行包粘贴单');

@repeat{SELECT COUNT(*) FROM PRINTTEMPLATETYPEITEM where ID=1500}
insert into PRINTTEMPLATETYPEITEM (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (1500,25,'线路名称',0,'packpasteroute',0);
@repeat{SELECT COUNT(*) FROM PRINTTEMPLATETYPEITEM where ID=1501}
insert into PRINTTEMPLATETYPEITEM (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (1501,25,'单号',0,'packpastepackno',0);
@repeat{SELECT COUNT(*) FROM PRINTTEMPLATETYPEITEM where ID=1502}
insert into PRINTTEMPLATETYPEITEM (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (1502,25,'到站',0,'packpastearrive',0);
@repeat{SELECT COUNT(*) FROM PRINTTEMPLATETYPEITEM where ID=1503}
insert into PRINTTEMPLATETYPEITEM (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (1503,25,'发货人',0,'packpasteconsignor',0);
@repeat{SELECT COUNT(*) FROM PRINTTEMPLATETYPEITEM where ID=1504}
insert into PRINTTEMPLATETYPEITEM (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (1504,25,'发货人电话',0,'packpasteconsignorphone',0);
@repeat{SELECT COUNT(*) FROM PRINTTEMPLATETYPEITEM where ID=1505}
insert into PRINTTEMPLATETYPEITEM (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (1505,25,'收货人',0,'packpasteconsignee',0);
@repeat{SELECT COUNT(*) FROM PRINTTEMPLATETYPEITEM where ID=1506}
insert into PRINTTEMPLATETYPEITEM (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (1506,25,'收货人电话',0,'packpasteonsigneephone',0);
@repeat{SELECT COUNT(*) FROM PRINTTEMPLATETYPEITEM where ID=1507}
insert into PRINTTEMPLATETYPEITEM (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (1507,25,'车号',0,'packpastewagonno',0);
@repeat{SELECT COUNT(*) FROM PRINTTEMPLATETYPEITEM where ID=1508}
insert into PRINTTEMPLATETYPEITEM (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (1508,25,'件数',0,'packpastepacknumber',0);
@repeat{SELECT COUNT(*) FROM PRINTTEMPLATETYPEITEM where ID=1509}
insert into PRINTTEMPLATETYPEITEM (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (1509,25,'是否安检',0,'packpasteissecuritycheck',0);
@repeat{SELECT COUNT(*) FROM PRINTTEMPLATETYPEITEM where ID=1510}
insert into PRINTTEMPLATETYPEITEM (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (1510,25,'受理日期',0,'packpasteacceptdate',0);
@repeat{SELECT COUNT(*) FROM PRINTTEMPLATETYPEITEM where ID=1511}
insert into PRINTTEMPLATETYPEITEM (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (1511,25,'发车日期',0,'packpastedeparturedate',0);
--end
--孙越 2017年10月26日 14:59:34 综合调度报班按钮权限
@repeat{SELECT COUNT(*) FROM functionpermissionreg where PERMISSIONKEY='{CB37EB69-2CAF-45DD-B971-5E2486D35406}'}
insert into functionpermissionreg values(353,41,'报班','{CB37EB69-2CAF-45DD-B971-5E2486D35406}','',sysdate,0,sysdate,0);
--end--

--begin  仉喜宝  2017-11-02  默认行车路单  增加打印项
@repeat{SELECT COUNT(*) FROM PRINTTEMPLATETYPEITEM where ID=566}
insert into PRINTTEMPLATETYPEITEM (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (566,6,'司乘旅客人数',0,'driverstewardpassengernum',0);
@repeat{SELECT COUNT(*) FROM PRINTTEMPLATETYPEITEM where ID=567}
insert into PRINTTEMPLATETYPEITEM (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (567,6,'路单编号',0,'waybillnumber',0);
@repeat{SELECT COUNT(*) FROM PRINTTEMPLATETYPEITEM where ID=568}
insert into PRINTTEMPLATETYPEITEM (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (568,6,'驾驶员1姓名全拼',0,'driverquanpin',0);
--end

--begin 20171103 by 仉喜宝 新增营运车辆违规情况处理  状态isaudit对应的数据字典，状态为：已打单   
@repeat{SELECT COUNT(*) FROM DIGITALDICTIONARYDETAIL WHERE ID=417 }
insert into digitaldictionarydetail (ID, DIGITALDICTIONARYID, ORDERNO, CODE, VALUE, DESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (417, 77, 4, '4', '已打单', '已打单', sysdate, 1158013, sysdate, 1158013);

@repeat{SELECT COUNT(*)-1 FROM DIGITALDICTIONARY where ID =77}
update DIGITALDICTIONARY set DESCRIBE='0：未结算，1、已罚款，2、已暂扣，3：已返还，4：已打单' where id=77;
--end

--begin  仉喜宝  2017-11-03  结算单  增加打印项 违规罚金
@repeat{SELECT COUNT(*) FROM PRINTTEMPLATETYPEITEM where ID=10145}
insert into PRINTTEMPLATETYPEITEM (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (10145,4,'违规罚金',0,'debit',0);
--end

--begin zhangxb  2018年1月29日14:21:53  增加营收缴款打印项
@repeat{SELECT COUNT(*) FROM printtemplatetypeitem where ID=18012901}
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (18012901, 6546, '保险现金应缴', '0', 'insurecashmoneypayable', 0);
@repeat{SELECT COUNT(*) FROM printtemplatetypeitem where ID=18012902}
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (18012902, 6546, '保险非现金凭证部分', '0', 'insurenoncashmoney', 0);
--end

--begin 2018年2月1日17:18:50 zhangxibao 增加job
@repeat{SELECT count(*) FROM jobconfig where id = 180201}
insert into jobconfig (ID, ORGID, JOBNAME, FULLCLASSNAME, PARAMETERS, INTERVALTYPE, INTERVALS, STARTTIME, ENDTIME, LASTRUNTIME, REMARKS, ISACTIVE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, TYPE)
values (180201, 1158012, 'AutoUpdateCustomerJob', 'cn.nova.datasync.client.lazy.job.DefaultEntitySyncJob', 'null', 4, 1, '21:00', '23:59', sysdate, null, 1, sysdate, 0, sysdate, 0, 1);
--end

--begin 2018年2月1日17:18:50 zhangxibao 增加job调用存储过程
@repeat{SELECT count(*) FROM jobconfig where id = 180202}
insert into jobconfig (ID, ORGID, JOBNAME, FULLCLASSNAME, PARAMETERS, INTERVALTYPE, INTERVALS, STARTTIME, ENDTIME, LASTRUNTIME, REMARKS, ISACTIVE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, TYPE)
values (180202, 1158012, 'AutoRefreshCustomerProcedureJob', 'cn.nova.datasync.client.lazy.job.DefaultEntitySyncJob', 'null', 4, 1, '21:00', '23:59', sysdate, null, 1, sysdate, 0, sysdate, 0, 1);
--end
--begin 2018年2月5日10:47:05 zqf 增加job发班后自动 N 分钟自动加座，加座 后的座位数不超过核定座位数 start
@repeat{SELECT count(*) FROM parameter where code = '3109'}
insert into parameter (ID, TYPE, CODE, VALUE, ISVISIBLE, ISEDITABLE, REMARK, UPDATETIME, UPDATEBY, UNIT)
values (180202, '30', '3109', '0', 1, 1, '发班后N分钟自动加座，加座数小于该班次漏乘人数并且小于(车辆核对座位数-乘客座位数),若为0则不加座，默认为0', sysdate, 0, '分钟');
@repeat{SELECT count(*) FROM jobconfig where id = 180205}
insert into jobconfig (ID, ORGID, JOBNAME, FULLCLASSNAME, PARAMETERS, INTERVALTYPE, INTERVALS, STARTTIME, ENDTIME, LASTRUNTIME, REMARKS, ISACTIVE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, TYPE)
values (180205, 1158012, 'AutoAddSeatAfterReportJob', 'cn.nova.bus.job.AutoAddSeatAfterReport', 'null', 2, 5, '00:00', '23:59', sysdate, null, 1, sysdate, 0, sysdate, 0, 1);
--begin 2018年2月5日10:47:05 zqf 增加job发班后自动 N 分钟自动加座，加座 后的座位数不超过核定座位数 start
-- begin 张清风 2017年11月20日15:24:20增加支付超时处理job--
@repeat{SELECT COUNT(*) FROM jobconfig where id=20171120 }
insert into jobconfig (ID, ORGID, JOBNAME, FULLCLASSNAME, PARAMETERS, INTERVALTYPE, INTERVALS, STARTTIME, ENDTIME, LASTRUNTIME, REMARKS, ISACTIVE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, TYPE)
values (20171120, 1158012, 'AutoQryOrderEpayJob', 'cn.nova.bus.job.AutoQryOrderEpayJob', 'null', 2, 5, '00:00', '23:59', sysdate, null, 1, sysdate, 1158013, sysdate, 1158013, 1);
-- end 张清风 2017年11月20日15:24:20增加支付超时处理job--