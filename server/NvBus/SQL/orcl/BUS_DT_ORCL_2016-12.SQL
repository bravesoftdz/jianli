--begin 更新菜单名称
update menu set name='特殊退款' where id=20160810;
update functionreg set name='特殊退款' where id=20160810;
--begin 更新菜单名称

--begin 孙越 2016年12月8日 11:40:23 添加支付方式 --
@repeat{SELECT count(*) FROM digitaldictionarydetail t where t.id = '16120801'}
insert into digitaldictionarydetail (ID, DIGITALDICTIONARYID, ORDERNO, CODE, VALUE, DESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (16120801, 50, 6, '6', '公务卡', '公务卡支付', sysdate, 0, sysdate, 0);
@repeat{SELECT count(*) FROM parameter t where t.id = '20161223'}
insert into parameter (ID, TYPE, CODE, VALUE, ISVISIBLE, ISEDITABLE, REMARK, UPDATETIME, UPDATEBY, UNIT)
values (20161223, '10', '1083', '2', 1, 1, '售票时收款页面支持的第三种支付方式，1银联卡，2贵宾卡，3公务卡，默认为2', sysdate, 0, '');
--end--

--begin 增加权限控制
@repeat{SELECT count(*) FROM functionpermissionreg t where t.id = 8264}
insert into functionpermissionreg (ID, FUNCTIONREGID, PERMISSIONNAME, PERMISSIONKEY, PERMISSIONDESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (8264, 41, '加班并报班', '{DD63F7F7-373A-4BD0-9D3D-4AEA97C3C13B}', '',sysdate, 0, sysdate, 0);
--end

--begin 孙越 2016年12月20日 15:07:26 --
@repeat{SELECT count(*) FROM functionreg t where t.id = 16122001}
insert into functionreg (ID, PACKAGENAME, NAME, FUNCTIONKEY, FUNCTIONDESCRIBE, PARAMETERDESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, INSTRUCTION)
values (16122001, 'NetSaleControl.bpl', '网售机构不可售班次控制', '{F0D4EBEC-8B9C-4D14-9F27-833AF8968352}', '网售机构不可售班次控制', '', sysdate, 0,sysdate, 0, '');

@repeat{SELECT count(*) FROM menu t where t.id = 16122001}
insert into menu (ID, NAME, FUNCTIONREGID, GRADE, ORDERNO, PARENTID, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, CLICKNUM, CLAZZ, URL, ICON, SYSTYPE, MENUTYPE)
values (16122001, '网售机构不可售班次控制', 16122001, 4, 25.00, 1060019, null, sysdate, 0, sysdate, 0, 0, null, null, null, '0', '1');
--end--
--begin  F9重售功能增加权限控制
@repeat{SELECT count(*) FROM functionpermissionreg t where t.id = 1239935}
insert into functionpermissionreg (ID, FUNCTIONREGID, PERMISSIONNAME, PERMISSIONKEY, PERMISSIONDESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (1239935, 6, 'F9功能', '{CA494249-A914-443E-B58C-3F7FA365729F}', '',SYSDATE, 0, SYSDATE, 0);
--end--
--begin--
@repeat{SELECT count(*) FROM jobconfig where id = 6115}
insert into jobconfig (ID, ORGID, JOBNAME, FULLCLASSNAME, PARAMETERS, INTERVALTYPE, INTERVALS, STARTTIME, ENDTIME, LASTRUNTIME, REMARKS, ISACTIVE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, TYPE)
values (6115, 1158012, 'AutoUpdatePackVehicleJob', 'cn.nova.bus.job.AutoUpdatePackVehicleJob', 'cn.nova.datasync.model.SyncDeleteEntity', 2, 10, '00:00', '23:59', to_date('29-12-2016 11:13:03', 'dd-mm-yyyy hh24:mi:ss'), '更新行包车辆', 1, to_date('01-01-2011', 'dd-mm-yyyy'), 1012127, to_date('01-01-2011', 'dd-mm-yyyy'), 1012127, 1);
--end--


--begin  2017-01-13 maxiao 修改小件行包打印模板支持条码 --
--行包受理单    行包单号 
@repeat{SELECT 1-COUNT(*) FROM printtemplatetypeitem where id=168 }
update printtemplatetypeitem t set t.itemtype=3 where t.id=168;
--行包签发单    签发单号
@repeat{SELECT 1-COUNT(*) FROM printtemplatetypeitem where id=215 }
update printtemplatetypeitem t set t.itemtype=3 where t.id=215;
--行包签发单    托运单号
@repeat{SELECT 1-COUNT(*) FROM printtemplatetypeitem where id=227 }
update printtemplatetypeitem t set t.itemtype=3 where t.id=227;                 
--小件寄存    寄存单号
@repeat{SELECT 1-COUNT(*) FROM printtemplatetypeitem where id=222 }
update printtemplatetypeitem t set t.itemtype=3 where t.id=222;
--行包结算单 结算单号
@repeat{SELECT 1-COUNT(*) FROM printtemplatetypeitem where id=932864 }
update printtemplatetypeitem t set t.itemtype=3 where t.id=932864; 
--受理结算 结算单号
@repeat{SELECT 1-COUNT(*) FROM printtemplatetypeitem where id=92906 }
update printtemplatetypeitem t set t.itemtype=3 where t.id=92906;
--行包提领 行包单号
@repeat{SELECT 1-COUNT(*) FROM printtemplatetypeitem where id=238 }
update printtemplatetypeitem t set t.itemtype=3 where t.id=238;
--行包提领 行包提领单号 
@repeat{SELECT 1-COUNT(*) FROM printtemplatetypeitem where id=904 }
update printtemplatetypeitem t set t.itemtype=3 where t.id=904;
--行包收讫单号  
@repeat{SELECT COUNT(*) FROM printtemplatetypeitem where id=98621 }
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)values (98621, 12, '行包收讫单号', '3', 'P_NO', 0);             
--end--
--begin 2017-1-13 zhaomingliang
@repeat{SELECT COUNT(*) FROM printtemplatetypeitem where id=94020 }
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values ('94020', '4', '车属单位编号', '0', 'unitcode', '0');
--end
@repeat{select count(*)-1 FROM parameter t where t.code = '1068'}
update parameter p set p.isvisible = 1 ,p.iseditable = 1 where p.code = '1068';

--begin 2017-02-08 zhaohuaihu 综合调度增加同步班次权限按钮
@repeat{select count(*) FROM functionpermissionreg t where t.PERMISSIONKEY = '{31AEA24E-0425-4DEF-A275-2F01283F997A}'}
insert into functionpermissionreg (ID, FUNCTIONREGID, PERMISSIONNAME, PERMISSIONKEY, PERMISSIONDESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (170208, 41, '同步班次', '{31AEA24E-0425-4DEF-A275-2F01283F997A}', '综合调度-同步班次计划', sysdate, 0, sysdate, 0);
--end 2017-02-08 zhaohuaihu 综合调度增加同步班次权限按钮
--begin 孙越 2017年2月27日 18:00:54 增加打印项--
@repeat{select count(*) from printtemplatetypeitem where id=17022702}
insert into printtemplatetypeitem (id,printtemplatetypeid,itemname,itemtype,itemcode,islist)
values(17022702,4,'结算单位编号',0,'balanceunitcode',0);
