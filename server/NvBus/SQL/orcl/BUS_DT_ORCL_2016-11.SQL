--begin 孙越 2016年11月2日 17:11:12 添加燃油类型 --
@repeat{SELECT count(*) FROM digitaldictionary where id = 16110201}
insert into digitaldictionary values(
16110201,'燃料类型','0:汽油,1:柴油,2:天然气,3:电动','vehicle','fueltype',0,sysdate,0,1);

@repeat{SELECT count(*) FROM digitaldictionarydetail where id = 16110201}
insert into digitaldictionarydetail values(16110201,16110201,0,'0','汽油','',sysdate,0,sysdate,0);

@repeat{SELECT count(*) FROM digitaldictionarydetail where id = 16110202}
insert into digitaldictionarydetail values(16110202,16110201,1,'1','天然气','',sysdate,0,sysdate,0);

@repeat{SELECT count(*) FROM digitaldictionarydetail where id = 16110203}
insert into digitaldictionarydetail values(16110203,16110201,2,'2','柴油','',sysdate,0,sysdate,0);

@repeat{SELECT count(*) FROM digitaldictionarydetail where id = 16110204}
insert into digitaldictionarydetail values(16110204,16110201,3,'3','电动','',sysdate,0,sysdate,0);
--end--

--begin addby daijy 2016年11月3日
@repeat{SELECT count(*) FROM parameter where CODE = 1076}
insert into parameter (ID, TYPE, CODE, VALUE, ISVISIBLE, ISEDITABLE, REMARK, UPDATETIME, UPDATEBY, UNIT)
values (1076, '10', '1076', '0', 1, 1, '售票是否允许同一证件类型相同证件号购买同一班次的多张车票，0不允许，1允许，默认为0.该参数的前提是开启售保或实名制', sysdate, 0, '是否');
--end

--begin 孙越  2016年11月8日 11:03:26 添加菜单--
@repeat{SELECT count(*) FROM functionreg where id = 16110801}
insert into functionreg (ID, PACKAGENAME, NAME, FUNCTIONKEY, FUNCTIONDESCRIBE, PARAMETERDESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, INSTRUCTION)
values (16110801, 'RouteTicketoutletsPrice.bpl', '线路售票点票价差额', '{345600E0-B805-4D61-AC7A-1F21830D6E4A}', '线路售票点票价差额', '', sysdate, 0,sysdate, 0, '');

@repeat{SELECT count(*) FROM menu where id = 16110801}
insert into menu (ID, NAME, FUNCTIONREGID, GRADE, ORDERNO, PARENTID, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, CLICKNUM, CLAZZ, URL, ICON, SYSTYPE, MENUTYPE)
values (16110801, '线路售票点票价差额', 16110801, 4, 24.00, 1060019, null,sysdate, 0, sysdate, 0, 0, null, null, null, '0', '1');
--end--

--begin 更新字典表，修改为上下铺
update  Digitaldictionarydetail dd set dd.value='上铺' where 
       digitaldictionaryid =(select d.id from  Digitaldictionary d where  d.tablename='handprice' and columnname='seattype')
       and value = '普通卧';     
update  Digitaldictionarydetail dd set dd.value='下铺' where 
       digitaldictionaryid =(select d.id from  Digitaldictionary d where  d.tablename='handprice' and columnname='seattype')
       and value = '商务卧';  
--end

--begin zhaomingliang 2016年11月8日
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 6120}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('6120', '6120', '当前版本与服务器版本不一致，请升级后重新登录！', '登录');
--end
--begin 孙越 2016年11月10日 11:37:00 添加异常提示 --
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0485}
insert into exceptioninfo (id,code,msg,modules)
values(16111001,'0485','该车辆进站协议号、有效期未设置完整，请先设置有效期！','IC卡报班');

@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0486}
insert into exceptioninfo (id,code,msg,modules)
values(16111002,'0486','该车辆进站协议已过期，不允许报班！','IC卡报班');

@repeat{SELECT count(*) FROM parameter where code = 2036}
insert into parameter (ID, TYPE, CODE, VALUE, ISVISIBLE, ISEDITABLE, REMARK, UPDATETIME, UPDATEBY, UNIT)
values (16111001, '20', '2036', '1', 1, 1, '车辆报班是否校验进站协议有效期，0校验，1不校验，默认为1', sysdate, 0, '是否');
--end--
--start zhangqingfeng 平台服务器保险险种同步
@repeat{SELECT count(*) FROM jobconfig where id = 20161111}
insert into jobconfig (ID, ORGID, JOBNAME, FULLCLASSNAME, PARAMETERS, INTERVALTYPE, INTERVALS, STARTTIME, ENDTIME, LASTRUNTIME, REMARKS, ISACTIVE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, TYPE)
values (20161111, 0, 'AutoSyncInsureJob', 'cn.nova.bus.job.AutoSyncInsureJob', 'null', 3, 1, '00:00', '23:59', sysdate, null, 1, to_date('29-07-2016 10:53:12', 'dd-mm-yyyy hh24:mi:ss'), 0, sysdate, 0, 1);
--end start zhangqingfeng 平台服务器保险险种同步
--begin zhaomingliang 增加打印模版字段
@repeat{SELECT count(*) FROM printtemplatetypeitem where ID = 1175903}
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values ('1175903', '4', '到站总人数', '0', 'reachstationpeople', '1');
--end

--begin zhaohuaihu 2016-11-14 增加参数0032 相关票价管理模块是否显示上限票价和下限票价
@repeat{SELECT count(*) FROM parameter where code = '0032'}
insert into parameter (ID, TYPE, CODE, VALUE, ISVISIBLE, ISEDITABLE, REMARK, UPDATETIME, UPDATEBY, UNIT)
values (110032, '00', '0032', '1', 1, 1, '相关票价管理模块是否显示上限票价和下限票价，0不显示，1显示，默认为1.当参数值设为0时，不显示上限票价和下限票价则不控制票价是否超过上限或低于下限', sysdate, 0, '是否');
--end zhaohuaihu 2016-11-14 增加参数0032 相关票价管理模块是否显示上限票价和下限票价 

-- 2016年11月11日 16:21:24 刘岩 唯一索引修改为非唯一 begin --
@repeat{select count(*) from user_indexes T where table_name='DRIVER' and t.index_name='IDX_DRIVERIDCARD' and t.uniqueness='NONUNIQUE'}
drop index IDX_DRIVERIDCARD;
@repeat{select count(*) from user_indexes T where table_name='DRIVER' and t.index_name='IDX_DRIVERIDCARD'}
Create index IDX_DRIVERIDCARD on driver (idcard); 
--end--

--begin 2016-11-15 zhaohuaihu 添加2054参数
@repeat{SELECT count(*) FROM parameter where code = '2054'}
insert into parameter (ID, TYPE, CODE, VALUE, ISVISIBLE, ISEDITABLE, REMARK, UPDATETIME, UPDATEBY, UNIT)
values (2054, '20', '2054', '1', 1, 1, '车牌管理中未审核的车辆是否允许报班，0不允许，1允许，默认为1', sysdate, 0, '是否');
@repeat{SELECT count(*) FROM exceptioninfo where code = '2054'}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values (2054, '2054', '该车牌未审核，且2054参数值为0，不允许报班。', 'IC卡报班');
--end 2016-11-15 zhaohuaihu 添加2054参数
--begin 2016年10月21日11:52:53 菜单南陵电子票取票改为电子票取票
@repeat{SELECT 1-COUNT(*) FROM menupermission where menuid=227477 }
update menupermission p  set p.menuid = 699171 where  p.menuid = 227477;
@repeat{SELECT 1-COUNT(*) FROM menu where functionregid=227477 }
update menu mn  set mn.name  = '电子票取票' where mn.functionregid = 227477;
--end
--begin 2016年11月23日 zhaomingliang 添加退废保险菜单和退废保险权限控制
@repeat{SELECT count(*) FROM menu where id=303}
insert into menu (ID, NAME, FUNCTIONREGID, GRADE, ORDERNO, PARENTID, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, URL, ICON, CLICKNUM, CLAZZ, SYSTYPE, MENUTYPE)
values (303, '退废保险', 284, 2, 1.35, 3, '',sysdate, 618619,sysdate , 618619, '', '', 0, '', '0', '1');
@repeat{SELECT count(*) FROM functionreg where id=284}
insert into functionreg (ID, PACKAGENAME, NAME, FUNCTIONKEY, FUNCTIONDESCRIBE, PARAMETERDESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (284, 'InsureReturn.bpl', '退废保险', '{B968208D-BE9E-4272-9CE3-C56DF44658F2}', '退废保险', '',sysdate, 1158013,sysdate, 1158013);
@repeat{SELECT count(*) FROM functionpermissionreg where  PERMISSIONKEY='{A16D1895-793F-4922-A0F4-9ADE35882F8C}'}
insert into functionpermissionreg (ID, FUNCTIONREGID, PERMISSIONNAME, PERMISSIONKEY, PERMISSIONDESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values ('140', '284', '普通退保', '{A16D1895-793F-4922-A0F4-9ADE35882F8C}', null,sysdate, '1158013', sysdate, '1158013');
@repeat{SELECT count(*) FROM functionpermissionreg where  PERMISSIONKEY='{2622C6F8-7A91-4209-96AD-30FAE085DFCB}'}
insert into functionpermissionreg (ID, FUNCTIONREGID, PERMISSIONNAME, PERMISSIONKEY, PERMISSIONDESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values ('141', '284', '普通废保', '{2622C6F8-7A91-4209-96AD-30FAE085DFCB}', null, sysdate, '1158013', sysdate, '1158013');
@repeat{SELECT count(*) FROM functionpermissionreg where  PERMISSIONKEY='{ABB6541D-1D63-4418-9983-6D4F442EEBF2}'}
insert into functionpermissionreg (ID, FUNCTIONREGID, PERMISSIONNAME, PERMISSIONKEY, PERMISSIONDESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values ('142', '284', '特权废保', '{ABB6541D-1D63-4418-9983-6D4F442EEBF2}', null, sysdate, '1158013', sysdate, '1158013');
@repeat{SELECT count(*) FROM functionpermissionreg where  PERMISSIONKEY='{78703805-F960-48D7-864C-5BA4786EFB1C}'}
insert into functionpermissionreg (ID, FUNCTIONREGID, PERMISSIONNAME, PERMISSIONKEY, PERMISSIONDESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values ('143', '284', '特权退保', '{78703805-F960-48D7-864C-5BA4786EFB1C}', null, sysdate, '1158013', sysdate, '1158013');
--end

-- 2016年11月18日 刘岩 更改行包前台结算打印模版 begin --
@repeat{select count(*) from printtemplatetypeitem where id=933006}
insert into printtemplatetypeitem (id, printtemplatetypeid, itemname, itemtype, itemcode, islist) values ('933006', '201531', '发货起止日期', '1', 'dptbgenddate', '0');
@repeat{select count(*) from printtemplatetypeitem where id=933003}
insert into printtemplatetypeitem (id, printtemplatetypeid, itemname, itemtype, itemcode, islist) values ('933003', '201531', '结算车辆', '1', 'vehicleno', '0');
@repeat{select count(*) from printtemplatetypeitem where id=933004}
insert into printtemplatetypeitem (id, printtemplatetypeid, itemname, itemtype, itemcode, islist) values ('933004', '201531', '货代费比例', '1', 'agentrate', '0');
@repeat{select count(*) from printtemplatetypeitem where id=933005}
insert into printtemplatetypeitem (id, printtemplatetypeid, itemname, itemtype, itemcode, islist) values ('933005', '201531', '行包代理费', '1', 'agent', '0');

delete from printtemplateitem where printtemplateid = 932968;

@repeat{select count(*) from printtemplateitem where id = 932997}
insert into printtemplateitem (id, printtemplateid, printtemplatetypeitemid, title, isprint, fontname, fontsize, top, leftmargin, width, height, valuetype, parameter, createtime, createby, updatetime, updateby, printpicture ) values ('932997', '932968', '932996', '件数', '1', '宋体', '11', '497', '1767', '79', '40', '2', null, to_date('2015-07-23 11:54:41', 'syyyy-mm-dd hh24:mi:ss'), '0', to_date('2016-11-18 16:32:55', 'syyyy-mm-dd hh24:mi:ss'), '1158013', null);
@repeat{select count(*) from printtemplateitem where id = 932985}
insert into printtemplateitem (id, printtemplateid, printtemplatetypeitemid, title, isprint, fontname, fontsize, top, leftmargin, width, height, valuetype, parameter, createtime, createby, updatetime, updateby, printpicture ) values ('932985', '932968', '-2', '画线', '1', '宋体', '1', '577', '299', '1754', '3', '0', null, to_date('2015-07-23 11:54:41', 'syyyy-mm-dd hh24:mi:ss'), '0', to_date('2016-11-18 16:22:01', 'syyyy-mm-dd hh24:mi:ss'), '1158013', null);
@repeat{select count(*) from printtemplateitem where id = 932998}
insert into printtemplateitem (id, printtemplateid, printtemplatetypeitemid, title, isprint, fontname, fontsize, top, leftmargin, width, height, valuetype, parameter, createtime, createby, updatetime, updateby, printpicture ) values ('932998', '932968', '-1', '件数', '1', '宋体', '11', '384', '1759', '79', '40', '1', null, to_date('2015-07-23 11:54:41', 'syyyy-mm-dd hh24:mi:ss'), '0', to_date('2016-11-18 16:25:32', 'syyyy-mm-dd hh24:mi:ss'), '1158013', null);
@repeat{select count(*) from printtemplateitem where id = 932970}
insert into printtemplateitem (id, printtemplateid, printtemplatetypeitemid, title, isprint, fontname, fontsize, top, leftmargin, width, height, valuetype, parameter, createtime, createby, updatetime, updateby, printpicture ) values ('932970', '932968', '932846', '结算人', '1', '宋体', '11', '725', '579', '119', '40', '2', null, to_date('2015-07-23 11:54:41', 'syyyy-mm-dd hh24:mi:ss'), '0', to_date('2015-07-23 11:54:41', 'syyyy-mm-dd hh24:mi:ss'), '0', null);
@repeat{select count(*) from printtemplateitem where id = 932971}
insert into printtemplateitem (id, printtemplateid, printtemplatetypeitemid, title, isprint, fontname, fontsize, top, leftmargin, width, height, valuetype, parameter, createtime, createby, updatetime, updateby, printpicture ) values ('932971', '932968', '-1', '结算日期:', '1', '宋体', '11', '278', '1402', '180', '40', '1', null, to_date('2015-07-23 11:54:42', 'syyyy-mm-dd hh24:mi:ss'), '0', to_date('2016-11-18 15:56:29', 'syyyy-mm-dd hh24:mi:ss'), '1158013', null);
@repeat{select count(*) from printtemplateitem where id = 932972}
insert into printtemplateitem (id, printtemplateid, printtemplatetypeitemid, title, isprint, fontname, fontsize, top, leftmargin, width, height, valuetype, parameter, createtime, createby, updatetime, updateby, printpicture ) values ('932972', '932968', '932863', '结算日期', '1', '宋体', '11', '280', '1627', '159', '40', '2', null, to_date('2015-07-23 11:54:42', 'syyyy-mm-dd hh24:mi:ss'), '0', to_date('2016-11-18 15:56:29', 'syyyy-mm-dd hh24:mi:ss'), '1158013', null);
@repeat{select count(*) from printtemplateitem where id = 932973}
insert into printtemplateitem (id, printtemplateid, printtemplatetypeitemid, title, isprint, fontname, fontsize, top, leftmargin, width, height, valuetype, parameter, createtime, createby, updatetime, updateby, printpicture ) values ('932973', '932968', '-1', '结算单位:', '1', '宋体', '11', '288', '407', '180', '40', '1', null, to_date('2015-07-23 11:54:42', 'syyyy-mm-dd hh24:mi:ss'), '0', to_date('2015-07-23 11:54:42', 'syyyy-mm-dd hh24:mi:ss'), '0', null);
@repeat{select count(*) from printtemplateitem where id = 932974}
insert into printtemplateitem (id, printtemplateid, printtemplatetypeitemid, title, isprint, fontname, fontsize, top, leftmargin, width, height, valuetype, parameter, createtime, createby, updatetime, updateby, printpicture ) values ('932974', '932968', '932845', '结算单位', '1', '宋体', '11', '288', '648', '159', '40', '2', null, to_date('2015-07-23 11:54:42', 'syyyy-mm-dd hh24:mi:ss'), '0', to_date('2015-07-23 11:54:42', 'syyyy-mm-dd hh24:mi:ss'), '0', null);
@repeat{select count(*) from printtemplateitem where id = 932975}
insert into printtemplateitem (id, printtemplateid, printtemplatetypeitemid, title, isprint, fontname, fontsize, top, leftmargin, width, height, valuetype, parameter, createtime, createby, updatetime, updateby, printpicture ) values ('932975', '932968', '-1', '结算金额', '1', '宋体', '11', '384', '1886', '159', '40', '1', null, to_date('2015-07-23 11:54:42', 'syyyy-mm-dd hh24:mi:ss'), '0', to_date('2016-11-18 16:25:32', 'syyyy-mm-dd hh24:mi:ss'), '1158013', null);
@repeat{select count(*) from printtemplateitem where id = 932976}
insert into printtemplateitem (id, printtemplateid, printtemplatetypeitemid, title, isprint, fontname, fontsize, top, leftmargin, width, height, valuetype, parameter, createtime, createby, updatetime, updateby, printpicture ) values ('932976', '932968', '932844', '结算金额', '1', '宋体', '11', '500', '1889', '159', '40', '2', null, to_date('2015-07-23 11:54:42', 'syyyy-mm-dd hh24:mi:ss'), '0', to_date('2016-11-18 16:25:32', 'syyyy-mm-dd hh24:mi:ss'), '1158013', null);
@repeat{select count(*) from printtemplateitem where id = 932977}
insert into printtemplateitem (id, printtemplateid, printtemplatetypeitemid, title, isprint, fontname, fontsize, top, leftmargin, width, height, valuetype, parameter, createtime, createby, updatetime, updateby, printpicture ) values ('932977', '932968', '-1', '结算单号:', '1', '宋体', '11', '111', '1527', '180', '40', '1', null, to_date('2015-07-23 11:54:42', 'syyyy-mm-dd hh24:mi:ss'), '0', to_date('2015-07-23 11:54:42', 'syyyy-mm-dd hh24:mi:ss'), '0', null);
@repeat{select count(*) from printtemplateitem where id = 932978}
insert into printtemplateitem (id, printtemplateid, printtemplatetypeitemid, title, isprint, fontname, fontsize, top, leftmargin, width, height, valuetype, parameter, createtime, createby, updatetime, updateby, printpicture ) values ('932978', '932968', '932864', '结算单号', '1', '宋体', '11', '111', '1767', '159', '40', '2', null, to_date('2015-07-23 11:54:42', 'syyyy-mm-dd hh24:mi:ss'), '0', to_date('2015-07-23 11:54:42', 'syyyy-mm-dd hh24:mi:ss'), '0', null);
@repeat{select count(*) from printtemplateitem where id = 932999}
insert into printtemplateitem (id, printtemplateid, printtemplatetypeitemid, title, isprint, fontname, fontsize, top, leftmargin, width, height, valuetype, parameter, createtime, createby, updatetime, updateby, printpicture ) values ('932999', '932968', '932844', '结算金额', '1', '宋体', '11', '622', '778', '159', '40', '7', null, to_date('2015-07-23 11:54:42', 'syyyy-mm-dd hh24:mi:ss'), '0', to_date('2015-07-23 11:54:42', 'syyyy-mm-dd hh24:mi:ss'), '0', null);
@repeat{select count(*) from printtemplateitem where id = 933077}
insert into printtemplateitem (id, printtemplateid, printtemplatetypeitemid, title, isprint, fontname, fontsize, top, leftmargin, width, height, valuetype, parameter, createtime, createby, updatetime, updateby, printpicture ) values ('933077', '932968', '-2', '画线', '1', '宋体', '96', '349', '299', '1759', '341', '0', null, to_date('2015-07-23 11:54:42', 'syyyy-mm-dd hh24:mi:ss'), '0', to_date('2016-11-18 16:22:01', 'syyyy-mm-dd hh24:mi:ss'), '1158013', null);
@repeat{select count(*) from printtemplateitem where id = 932981}
insert into printtemplateitem (id, printtemplateid, printtemplatetypeitemid, title, isprint, fontname, fontsize, top, leftmargin, width, height, valuetype, parameter, createtime, createby, updatetime, updateby, printpicture ) values ('932981', '932968', '-1', '票据张数', '1', '宋体', '11', '384', '1543', '159', '40', '1', null, to_date('2015-07-23 11:54:42', 'syyyy-mm-dd hh24:mi:ss'), '0', to_date('2016-11-18 16:25:32', 'syyyy-mm-dd hh24:mi:ss'), '1158013', null);
@repeat{select count(*) from printtemplateitem where id = 932982}
insert into printtemplateitem (id, printtemplateid, printtemplatetypeitemid, title, isprint, fontname, fontsize, top, leftmargin, width, height, valuetype, parameter, createtime, createby, updatetime, updateby, printpicture ) values ('932982', '932968', '932841', '票据张数', '1', '宋体', '11', '500', '1550', '159', '40', '2', null, to_date('2015-07-23 11:54:42', 'syyyy-mm-dd hh24:mi:ss'), '0', to_date('2016-11-18 16:32:55', 'syyyy-mm-dd hh24:mi:ss'), '1158013', null);
@repeat{select count(*) from printtemplateitem where id = 932986}
insert into printtemplateitem (id, printtemplateid, printtemplatetypeitemid, title, isprint, fontname, fontsize, top, leftmargin, width, height, valuetype, parameter, createtime, createby, updatetime, updateby, printpicture ) values ('932986', '932968', '-2', '画线', '1', '宋体', '64', '352', '1720', '3', '228', '0', null, to_date('2015-07-23 11:54:42', 'syyyy-mm-dd hh24:mi:ss'), '0', to_date('2016-11-18 16:42:37', 'syyyy-mm-dd hh24:mi:ss'), '1158013', null);
@repeat{select count(*) from printtemplateitem where id = 932987}
insert into printtemplateitem (id, printtemplateid, printtemplatetypeitemid, title, isprint, fontname, fontsize, top, leftmargin, width, height, valuetype, parameter, createtime, createby, updatetime, updateby, printpicture ) values ('932987', '932968', '-2', '画线', '1', '宋体', '1', '468', '299', '1754', '3', '0', null, to_date('2015-07-23 11:54:42', 'syyyy-mm-dd hh24:mi:ss'), '0', to_date('2016-11-18 16:42:37', 'syyyy-mm-dd hh24:mi:ss'), '1158013', null);
@repeat{select count(*) from printtemplateitem where id = 932988}
insert into printtemplateitem (id, printtemplateid, printtemplatetypeitemid, title, isprint, fontname, fontsize, top, leftmargin, width, height, valuetype, parameter, createtime, createby, updatetime, updateby, printpicture ) values ('932988', '932968', '-2', '画线', '1', '宋体', '64', '352', '1879', '3', '228', '0', null, to_date('2015-07-23 11:54:42', 'syyyy-mm-dd hh24:mi:ss'), '0', to_date('2016-11-18 16:42:37', 'syyyy-mm-dd hh24:mi:ss'), '1158013', null);
@repeat{select count(*) from printtemplateitem where id = 932989}
insert into printtemplateitem (id, printtemplateid, printtemplatetypeitemid, title, isprint, fontname, fontsize, top, leftmargin, width, height, valuetype, parameter, createtime, createby, updatetime, updateby, printpicture ) values ('932989', '932968', '-2', '画线', '1', '宋体', '95', '352', '759', '3', '339', '0', null, to_date('2015-07-23 11:54:42', 'syyyy-mm-dd hh24:mi:ss'), '0', to_date('2016-11-18 16:42:37', 'syyyy-mm-dd hh24:mi:ss'), '1158013', null);
@repeat{select count(*) from printtemplateitem where id = 933082}
insert into printtemplateitem (id, printtemplateid, printtemplatetypeitemid, title, isprint, fontname, fontsize, top, leftmargin, width, height, valuetype, parameter, createtime, createby, updatetime, updateby, printpicture ) values ('933082', '932968', '-1', '宜昌中心客运站货物托运结算单', '1', '宋体', '15', '116', '738', '741', '53', '1', null, to_date('2015-07-23 11:54:42', 'syyyy-mm-dd hh24:mi:ss'), '0', to_date('2016-11-18 15:29:20', 'syyyy-mm-dd hh24:mi:ss'), '1158013', null);
@repeat{select count(*) from printtemplateitem where id = 932991}
insert into printtemplateitem (id, printtemplateid, printtemplatetypeitemid, title, isprint, fontname, fontsize, top, leftmargin, width, height, valuetype, parameter, createtime, createby, updatetime, updateby, printpicture ) values ('932991', '932968', '-1', '制表人:', '1', '宋体', '11', '725', '400', '140', '40', '1', null, to_date('2015-07-23 11:54:42', 'syyyy-mm-dd hh24:mi:ss'), '0', to_date('2015-07-23 11:54:42', 'syyyy-mm-dd hh24:mi:ss'), '0', null);
@repeat{select count(*) from printtemplateitem where id = 932992}
insert into printtemplateitem (id, printtemplateid, printtemplatetypeitemid, title, isprint, fontname, fontsize, top, leftmargin, width, height, valuetype, parameter, createtime, createby, updatetime, updateby, printpicture ) values ('932992', '932968', '-1', '审核人:', '1', '宋体', '11', '725', '945', '140', '40', '1', null, to_date('2015-07-23 11:54:42', 'syyyy-mm-dd hh24:mi:ss'), '0', to_date('2015-07-23 11:54:42', 'syyyy-mm-dd hh24:mi:ss'), '0', null);
@repeat{select count(*) from printtemplateitem where id = 932993}
insert into printtemplateitem (id, printtemplateid, printtemplatetypeitemid, title, isprint, fontname, fontsize, top, leftmargin, width, height, valuetype, parameter, createtime, createby, updatetime, updateby, printpicture ) values ('932993', '932968', '-1', '车主签名:', '1', '宋体', '11', '725', '1463', '180', '40', '1', null, to_date('2015-07-23 11:54:42', 'syyyy-mm-dd hh24:mi:ss'), '0', to_date('2015-07-23 11:54:42', 'syyyy-mm-dd hh24:mi:ss'), '0', null);
@repeat{select count(*) from printtemplateitem where id = 932994}
insert into printtemplateitem (id, printtemplateid, printtemplatetypeitemid, title, isprint, fontname, fontsize, top, leftmargin, width, height, valuetype, parameter, createtime, createby, updatetime, updateby, printpicture ) values ('932994', '932968', '-1', '合计金额(大写)', '1', '宋体', '11', '611', '378', '280', '40', '1', null, to_date('2015-07-23 11:54:42', 'syyyy-mm-dd hh24:mi:ss'), '0', to_date('2016-11-18 15:29:20', 'syyyy-mm-dd hh24:mi:ss'), '1158013', null);
@repeat{select count(*) from printtemplateitem where id = 1178812}
insert into printtemplateitem (id, printtemplateid, printtemplatetypeitemid, title, isprint, fontname, fontsize, top, leftmargin, width, height, valuetype, parameter, createtime, createby, updatetime, updateby, printpicture ) values ('1178812', '932968', '-1', '发货起止日期', '1', '宋体', '11', '384', '415', '238', '40', '1', null, to_date('2016-11-18 15:29:18', 'syyyy-mm-dd hh24:mi:ss'), '1158013', to_date('2016-11-18 15:56:29', 'syyyy-mm-dd hh24:mi:ss'), '1158013', null);
@repeat{select count(*) from printtemplateitem where id = 1178813}
insert into printtemplateitem (id, printtemplateid, printtemplatetypeitemid, title, isprint, fontname, fontsize, top, leftmargin, width, height, valuetype, parameter, createtime, createby, updatetime, updateby, printpicture ) values ('1178813', '932968', '933006', '发货起止日期', '1', '宋体', '11', '500', '310', '238', '40', '2', null, to_date('2016-11-18 15:29:20', 'syyyy-mm-dd hh24:mi:ss'), '1158013', to_date('2016-11-18 16:38:18', 'syyyy-mm-dd hh24:mi:ss'), '1158013', null);
@repeat{select count(*) from printtemplateitem where id = 1178814}
insert into printtemplateitem (id, printtemplateid, printtemplatetypeitemid, title, isprint, fontname, fontsize, top, leftmargin, width, height, valuetype, parameter, createtime, createby, updatetime, updateby, printpicture ) values ('1178814', '932968', '933003', '结算车辆', '1', '宋体', '11', '500', '773', '159', '40', '2', null, to_date('2016-11-18 15:29:20', 'syyyy-mm-dd hh24:mi:ss'), '1158013', to_date('2016-11-18 16:34:33', 'syyyy-mm-dd hh24:mi:ss'), '1158013', null);
@repeat{select count(*) from printtemplateitem where id = 1178815}
insert into printtemplateitem (id, printtemplateid, printtemplatetypeitemid, title, isprint, fontname, fontsize, top, leftmargin, width, height, valuetype, parameter, createtime, createby, updatetime, updateby, printpicture ) values ('1178815', '932968', '-2', '画线', '1', '宋体', '64', '352', '1519', '3', '228', '0', null, to_date('2016-11-18 15:29:20', 'syyyy-mm-dd hh24:mi:ss'), '1158013', to_date('2016-11-18 16:42:37', 'syyyy-mm-dd hh24:mi:ss'), '1158013', null);
@repeat{select count(*) from printtemplateitem where id = 1178816}
insert into printtemplateitem (id, printtemplateid, printtemplatetypeitemid, title, isprint, fontname, fontsize, top, leftmargin, width, height, valuetype, parameter, createtime, createby, updatetime, updateby, printpicture ) values ('1178816', '932968', '-2', '画线', '1', '宋体', '64', '352', '1299', '3', '228', '0', null, to_date('2016-11-18 15:29:20', 'syyyy-mm-dd hh24:mi:ss'), '1158013', to_date('2016-11-18 16:42:37', 'syyyy-mm-dd hh24:mi:ss'), '1158013', null);
@repeat{select count(*) from printtemplateitem where id = 1178817}
insert into printtemplateitem (id, printtemplateid, printtemplatetypeitemid, title, isprint, fontname, fontsize, top, leftmargin, width, height, valuetype, parameter, createtime, createby, updatetime, updateby, printpicture ) values ('1178817', '932968', '-2', '画线', '1', '宋体', '64', '352', '1074', '3', '228', '0', null, to_date('2016-11-18 15:29:20', 'syyyy-mm-dd hh24:mi:ss'), '1158013', to_date('2016-11-18 16:42:37', 'syyyy-mm-dd hh24:mi:ss'), '1158013', null);
@repeat{select count(*) from printtemplateitem where id = 1178818}
insert into printtemplateitem (id, printtemplateid, printtemplatetypeitemid, title, isprint, fontname, fontsize, top, leftmargin, width, height, valuetype, parameter, createtime, createby, updatetime, updateby, printpicture ) values ('1178818', '932968', '933004', '货代费比例', '1', '宋体', '11', '503', '1087', '198', '40', '2', null, to_date('2016-11-18 15:34:11', 'syyyy-mm-dd hh24:mi:ss'), '1158013', to_date('2016-11-18 16:25:32', 'syyyy-mm-dd hh24:mi:ss'), '1158013', null);
@repeat{select count(*) from printtemplateitem where id = 1178819}
insert into printtemplateitem (id, printtemplateid, printtemplatetypeitemid, title, isprint, fontname, fontsize, top, leftmargin, width, height, valuetype, parameter, createtime, createby, updatetime, updateby, printpicture ) values ('1178819', '932968', '933005', '行包代理费', '1', '宋体', '11', '503', '1312', '198', '40', '2', null, to_date('2016-11-18 15:34:11', 'syyyy-mm-dd hh24:mi:ss'), '1158013', to_date('2016-11-18 15:56:29', 'syyyy-mm-dd hh24:mi:ss'), '1158013', null);
@repeat{select count(*) from printtemplateitem where id = 1178820}
insert into printtemplateitem (id, printtemplateid, printtemplatetypeitemid, title, isprint, fontname, fontsize, top, leftmargin, width, height, valuetype, parameter, createtime, createby, updatetime, updateby, printpicture ) values ('1178820', '932968', '-1', '结算车辆', '1', '宋体', '11', '384', '844', '159', '40', '1', null, to_date('2016-11-18 15:34:11', 'syyyy-mm-dd hh24:mi:ss'), '1158013', to_date('2016-11-18 16:32:55', 'syyyy-mm-dd hh24:mi:ss'), '1158013', null);
@repeat{select count(*) from printtemplateitem where id = 1178821}
insert into printtemplateitem (id, printtemplateid, printtemplatetypeitemid, title, isprint, fontname, fontsize, top, leftmargin, width, height, valuetype, parameter, createtime, createby, updatetime, updateby, printpicture ) values ('1178821', '932968', '-1', '货代费比例', '1', '宋体', '11', '384', '1090', '198', '40', '1', null, to_date('2016-11-18 15:34:11', 'syyyy-mm-dd hh24:mi:ss'), '1158013', to_date('2016-11-18 16:25:32', 'syyyy-mm-dd hh24:mi:ss'), '1158013', null);
@repeat{select count(*) from printtemplateitem where id = 1178822}
insert into printtemplateitem (id, printtemplateid, printtemplatetypeitemid, title, isprint, fontname, fontsize, top, leftmargin, width, height, valuetype, parameter, createtime, createby, updatetime, updateby, printpicture ) values ('1178822', '932968', '-1', '行包代理费', '1', '宋体', '11', '384', '1315', '198', '40', '1', null, to_date('2016-11-18 15:34:11', 'syyyy-mm-dd hh24:mi:ss'), '1158013', to_date('2016-11-18 16:25:32', 'syyyy-mm-dd hh24:mi:ss'), '1158013', null);

--end --

--2016年11月29日 马潇 小件寄存打印模版中新增小件存放时间数据源 begin --
@repeat{select count(*) from printtemplatetypeitem where itemname = '存放日期' and printtemplatetypeid = 13}
insert into printtemplatetypeitem(id, printtemplatetypeid, itemname, itemtype, itemcode, islist) values(867041490, 13, '存放日期', '1', 'depositdate', '0');
--end --