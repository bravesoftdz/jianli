--begin 
@repeat{SELECT COUNT(*) FROM Packfeetype where ID=1}
insert into Packfeetype (ID, CODE, NAME, ORGID) values (1, 'ZXF', '装卸费', 1158012);
@repeat{SELECT COUNT(*) FROM Packfeetype where ID=2}
insert into Packfeetype (ID, CODE, NAME, ORGID) values (2, 'TYF', '托运费', 1158012);
@repeat{SELECT COUNT(*) FROM Packfeetype where ID=3}
insert into Packfeetype (ID, CODE, NAME, ORGID) values (3, 'BXF', '保险费', 1158012);
COMMIT;
--end
--begin 删除菜单中，电子票取票，客运收支平衡表-赣州，单位营收统计表-赣州三个显示菜单   李毅 
@repeat{SELECT COUNT(*)-1 FROM menu where ID =240}
delete from menu where id =240;
@repeat{SELECT COUNT(*)-1 FROM menu where ID =241}
delete from menu  where id =241;
@repeat{SELECT COUNT(*)-1 FROM menu where ID =223477}
delete from menu  where id=223477;
commit;
--end
--begin 票据类型  李毅
@repeat{SELECT COUNT(*) FROM BILLTYPE where ID =13}
insert into BILLTYPE (ID, CODE, NAME, PRINTNAME, DESCRIPTION, TICKETNOLENGTH, MEDIUM, PARVALUE, NUMPERBOX, ISACTIVE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (13, 'PackBill', '行包托运单', '行包托运单', '', 8, '0', 0.000, 10000, 1, sysdate, 0, sysdate, 0);
@repeat{SELECT COUNT(*) FROM BILLTYPE where ID =15}
insert into BILLTYPE (ID, CODE, NAME, PRINTNAME, DESCRIPTION, TICKETNOLENGTH, MEDIUM, PARVALUE, NUMPERBOX, ISACTIVE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (15, 'PackSgBill', '行包签发单', '行包签发单', '', 8, '0', 0.000, 1000, 1, sysdate, 0, sysdate, 0);
@repeat{SELECT COUNT(*) FROM BILLTYPE where ID =16}
insert into BILLTYPE (ID, CODE, NAME, PRINTNAME, DESCRIPTION, TICKETNOLENGTH, MEDIUM, PARVALUE, NUMPERBOX, ISACTIVE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (16, 'PackReBill', '行包提领单', '行包提领单', '', 8, '0', 0.000, 1000, 1, sysdate, 0, sysdate, 0);
@repeat{SELECT COUNT(*) FROM BILLTYPE where ID =17}
insert into BILLTYPE (ID, CODE, NAME, PRINTNAME, DESCRIPTION, TICKETNOLENGTH, MEDIUM, PARVALUE, NUMPERBOX, ISACTIVE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (17, 'GoodsBill', '小件寄存单', '小件寄存单', '', 8, '0', 0.000, 1000, 1, sysdate, 0, sysdate, 0);
@repeat{SELECT COUNT(*) FROM BILLTYPE where ID =18}
insert into BILLTYPE (ID, CODE, NAME, PRINTNAME, DESCRIPTION, TICKETNOLENGTH, MEDIUM, PARVALUE, NUMPERBOX, ISACTIVE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (18, 'PackArrivalBill', '行包到货收讫单', '行包到货收讫单', '', 8, '0', 0.000, 10000, 1, sysdate, 1158013, sysdate, 1158013);
--end

-- 菜单  行包客户档案管理   liyi
@repeat{SELECT COUNT(*)-1 FROM functionreg where functionkey = '{BC99C9F0-E0C6-4A1B-8AB1-B259ED8913F6}'}
delete from functionreg where functionkey='{BC99C9F0-E0C6-4A1B-8AB1-B259ED8913F6}';
commit;
@repeat{SELECT COUNT(*) FROM functionreg where ID =148}
insert into functionreg (ID, PACKAGENAME, NAME, FUNCTIONKEY, FUNCTIONDESCRIBE, PARAMETERDESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, INSTRUCTION)
values (148, 'Client.bpl', '行包客户档案管理', '{BC99C9F0-E0C6-4A1B-8AB1-B259ED8913F6}', '客户档案管理', '', sysdate, 1126281, sysdate, 1126281, null);
-- 票据类型  包车单 2014/04/21 李毅
@repeat{SELECT COUNT(*) FROM BILLTYPE where ID = 1152798 or code ='HirebusBill'}
insert into BILLTYPE (ID, CODE, NAME, PRINTNAME, DESCRIPTION, TICKETNOLENGTH, MEDIUM, PARVALUE, NUMPERBOX, ISACTIVE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (1152798, 'HirebusBill', '包车单', '包车单', '', 8, '0', 10.000, 12, 1, sysdate, 1000002, sysdate, 1000002);

--begin 删除功能列表中 赣州相关的两个菜单，电子票取票菜单， 2014/04/22 liyi
@repeat{SELECT COUNT(*)-1 FROM functionreg where ID =149}
delete from functionreg  where id = 149;
@repeat{SELECT COUNT(*)-1 FROM functionreg where ID =150}
delete from functionreg  where id = 150;
@repeat{SELECT COUNT(*)-1 FROM functionreg where ID =6766}
delete from functionreg  where id = 6766;
--end 
--begin 是否启用流水班退票手续费率 参数控制
@repeat{SELECT COUNT(*) FROM Parameter where code = '1078'}
insert into Parameter (ID, TYPE, CODE, VALUE, ISVISIBLE, ISEDITABLE, REMARK, UPDATETIME, UPDATEBY, UNIT)
values (1259612, '11', '1078', '0', 1, 1, '是否启用流水班退票手续费率，1启用、0不启用', sysdate, 1158013, '是否');
--end
--begin
@repeat{SELECT count(*)-1 FROM functionreg fr where fr.functionkey = '{3C42EA90-3A01-42D0-82F7-1D3B1273535C}'}
delete from functionreg fr where fr.functionkey = '{3C42EA90-3A01-42D0-82F7-1D3B1273535C}';
@repeat{SELECT count(*) FROM functionreg fr where fr.functionkey = '{3C42EA90-3A01-42D0-82F7-1D3B1273535C}'}
insert into functionreg (ID, PACKAGENAME, NAME, FUNCTIONKEY, FUNCTIONDESCRIBE, PARAMETERDESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, INSTRUCTION)
values (325, 'RouteChecktime.bpl', '检票时间设置', '{3C42EA90-3A01-42D0-82F7-1D3B1273535C}', '检票时间设置', '', sysdate, 1158013, sysdate, 1158013, null);
@repeat{SELECT count(*)-1 FROM functionreg fr where fr.functionkey = '{64FF9C1A-B00F-4881-B1FE-4D697CFEDEE8}'}
delete from functionreg fr where fr.functionkey = '{64FF9C1A-B00F-4881-B1FE-4D697CFEDEE8}';
@repeat{SELECT count(*) FROM functionreg fr where fr.functionkey = '{64FF9C1A-B00F-4881-B1FE-4D697CFEDEE8}'}
insert into functionreg (ID, PACKAGENAME, NAME, FUNCTIONKEY, FUNCTIONDESCRIBE, PARAMETERDESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, INSTRUCTION)
values (519, 'SelfDepartinvoices.bpl', '自助发班', '{64FF9C1A-B00F-4881-B1FE-4D697CFEDEE8}', '自助发班', '', sysdate, 1158013, sysdate, 1158013, null);
@repeat{SELECT count(*)-1 FROM functionreg fr where fr.functionkey = '{7051F3FB-E600-4ED0-AF1E-C7241EA565F7}'}
delete from functionreg fr where fr.functionkey = '{7051F3FB-E600-4ED0-AF1E-C7241EA565F7}';

--end
--begin 报班单是否打印脚本
@repeat{SELECT count(*) FROM parameter p where p.id=6565}
insert into parameter (ID, TYPE, CODE, VALUE, ISVISIBLE, ISEDITABLE, REMARK, UPDATETIME, UPDATEBY, UNIT) 
values (6565, '20', '2888', '1', 1, 1, '报班是否打印营运车辆报班单', sysdate, 1158013, '是否');
--end 
--begin 报班打印脚本  2015-05-20  by liyi
@repeat{SELECT count(*) FROM printtemplatetype p where p.id=31}
insert into printtemplatetype (ID, NAME) values (31, '营运客车报班单');
@repeat{SELECT count(*) FROM printtemplatetypeitem p where p.id=1166373}
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (1166373, 31, '发车日期', '0', 'departdate', 0);
@repeat{SELECT count(*) FROM printtemplatetypeitem p where p.id=1166265}
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (1166265, 31, '发车时间', '2', 'departtime', 0);
@repeat{SELECT count(*) FROM printtemplatetypeitem p where p.id=1166268}
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (1166268, 31, '驾驶员1', '0', 'drivername1', 0);
@repeat{SELECT count(*) FROM printtemplatetypeitem p where p.id=1166283}
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (1166283, 31, '驾驶员2', '0', 'drivername2', 0);
@repeat{SELECT count(*) FROM printtemplatetypeitem p where p.id=1166276}
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (1166276, 31, '到达站', '0', 'reachstation', 0);
@repeat{SELECT count(*) FROM printtemplatetypeitem p where p.id=1166266}
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (1166266, 31, '车次', '0', 'schedulecode', 0);
@repeat{SELECT count(*) FROM printtemplatetypeitem p where p.id=1166267}
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (1166267, 31, '座位', '0', 'seatno', 0);
@repeat{SELECT count(*) FROM printtemplatetypeitem p where p.id=1166282}
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (1166282, 31, '签发人', '0', 'signname', 0);
@repeat{SELECT count(*) FROM printtemplatetypeitem p where p.id=1166281}
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (1166281, 31, '签发单位', '0', 'signunit', 0);
@repeat{SELECT count(*) FROM printtemplatetypeitem p where p.id=1166275}
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (1166275, 31, '出发站', '0', 'startstation', 0);
@repeat{SELECT count(*) FROM printtemplatetypeitem p where p.id=1166264}
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (1166264, 31, '牌照号', '0', 'vehicleno', 0);
@repeat{SELECT count(*) FROM printtemplatetypeitem p where p.id=1166372}
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (1166372, 31, '车属单位', '0', 'vehicleunit', 0);
--end
--begin 从vehiclereport表同步driverid1,driverid2,stewardid1,三个字段到departinvoices表中
update departinvoices d
set d.driver1id = (select v.driver1id from vehiclereport v where v.id=d.reportid) 
where exists (select v.driver1id from vehiclereport v where v.id=d.reportid);

update departinvoices d
set d.driver2id = (select v.driver2id from vehiclereport v where v.id=d.reportid) 
where exists (select v.driver2id from vehiclereport v where v.id=d.reportid);


update departinvoices d
set d.steward1id = (select v.steward1id from vehiclereport v where v.id=d.reportid) 
where exists (select v.steward1id from vehiclereport v where v.id=d.reportid);
--end
--begin  四证有效期过期参数
@repeat{SELECT count(*) FROM PARAMETER p where p.ID=228} 
insert into parameter (ID, TYPE, CODE, VALUE, ISVISIBLE, ISEDITABLE, REMARK, UPDATETIME, UPDATEBY, UNIT)
values (228, '60', '6022', '1', 1, 1, '安检四证过期是否正常安检：0、否，1、是', sysdate, 1158013, '');
--end
--begin--检票闸机参数设置--20150525--杨志文
@repeat{SELECT count(*) FROM PARAMETER p where p.ID=3103}
insert into PARAMETER (ID, TYPE, CODE, VALUE, ISVISIBLE, ISEDITABLE, REMARK, UPDATETIME, UPDATEBY, UNIT)
values (3103, '31', '3103', '1', 1, 1, '闸机是否控制本系统外的票号，0：不控制，1：控制', sysdate, 0, '是否');
@repeat{SELECT count(*) FROM PARAMETER p where p.ID=3102}
insert into PARAMETER (ID, TYPE, CODE, VALUE, ISVISIBLE, ISEDITABLE, REMARK, UPDATETIME, UPDATEBY, UNIT)
values (3102, '31', '3102', '1', 1, 1, '闸机是否进行检票操作，0：不检票，1：检票', sysdate, 0, '是否');
@repeat{SELECT count(*) FROM PARAMETERORGDETAIL p where p.PARAMETERID=3103}
insert into Parameterorgdetail (ID, ORGID, PARAMETERID, VALUE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (1223366, 1125399, 3103, '1', to_date('25-05-2015', 'dd-mm-yyyy'), 0,sysdate,0);
@repeat{SELECT count(*) FROM PARAMETERORGDETAIL p where p.PARAMETERID=3102}
insert into Parameterorgdetail (ID, ORGID, PARAMETERID, VALUE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (11223367, 1125399, 3102, '0',sysdate,0,sysdate,0);
--end

@repeat{SELECT COUNT(*) FROM billtype where ID=21}
insert into billtype (ID, CODE, NAME, PRINTNAME, DESCRIPTION, TICKETNOLENGTH, MEDIUM, PARVALUE, NUMPERBOX, ISACTIVE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (21, 'PackBalanceBill', '行包结算通知单', '行包结算通知单', '', 8, '0', 0.000, 1000, 1, sysdate, 0, sysdate, 0);

@repeat{SELECT COUNT(*) FROM Exceptioninfo where ID=502}
insert into Exceptioninfo (id,code,Msg,Modules) 
values(502,'0502','单号状态异常','出库结算/前台结算');

@repeat{SELECT COUNT(*) FROM Exceptioninfo where ID=503}
insert into Exceptioninfo (id,code,Msg,Modules) 
values(503,'0503','运费或货款与记录不符','出库结算/前台结算');

@repeat{SELECT COUNT(*) FROM digitaldictionary where ID=1127}
insert into digitaldictionary  (id,name,describe,tablename,columnname,iscanedit,updatetime,updateby)
values(1127,'行包出库结算状态','状态：0：未结算；1：已注销：2：已结算 ','packarriver','status',0,sysdate,0);

@repeat{SELECT COUNT(*) FROM digitaldictionarydetail where ID=689}
insert into digitaldictionarydetail  (id,digitaldictionaryid,orderno,code,value,describe,createtime,createby,updatetime,updateby )
values(689,1127,0,'0','未结算','',sysdate,0,sysdate,0);

@repeat{SELECT COUNT(*) FROM digitaldictionarydetail where ID=690}
insert into digitaldictionarydetail  (id,digitaldictionaryid,orderno,code,value,describe,createtime,createby,updatetime,updateby )
values(690,1127,1,'1','已注销','',sysdate,0,sysdate,0);

@repeat{SELECT COUNT(*) FROM digitaldictionarydetail where ID=691}
insert into digitaldictionarydetail  (id,digitaldictionaryid,orderno,code,value,describe,createtime,createby,updatetime,updateby )
values(691,1127,2,'2','已结算','',sysdate,0,sysdate,0);


@repeat{SELECT COUNT(*) FROM exceptioninfo where ID=506}
 insert into exceptioninfo values(506,'0506','该行包单号不存在！','行包签发');
 @repeat{SELECT COUNT(*) FROM exceptioninfo where ID=507}
  insert into exceptioninfo values(507,'0507','该行包已提领出库！','行包签发');
  @repeat{SELECT COUNT(*) FROM exceptioninfo where ID=508}
 insert into exceptioninfo values(508,'0508','该行包已作废！','行包签发');
  @repeat{SELECT COUNT(*) FROM exceptioninfo where ID=509}
 insert into exceptioninfo values(509,'0509','该行包是到货库存！','行包签发');
  @repeat{SELECT COUNT(*) FROM exceptioninfo where ID=510}
insert into exceptioninfo values(510,'0510','该行包已退票！','行包签发');  
@repeat{SELECT COUNT(*) FROM exceptioninfo where ID=511}
insert into exceptioninfo values(511,'0511','该行包已中转出库！','行包签发'); 
@repeat{SELECT COUNT(*) FROM exceptioninfo where ID=512}
insert into exceptioninfo values(512,'0512','该行包已转至它站！','行包签发');
@repeat{SELECT COUNT(*) FROM exceptioninfo where ID=513}
insert into exceptioninfo values(513,'0513','该行包已签发出库！','行包签发');

-- Add comments to the columns 
comment on column PACK.PAYMETHOD
  is '付款方式（现付、对付）取数据字典';
comment on column PACK.COLLECTSTATUS
  is '代售货款:0 代收 1已代收 （暂不用）'; 
  @repeat{SELECT COUNT(*) FROM exceptioninfo where ID=515}
  insert into exceptioninfo values(515,'0515','该行包货款还未回收，不允许签发！','行包签发'); 
  
-- 出库结算->行包结算,添加状态 2015年5月21日 孙越 开始 --  
@repeat{SELECT COUNT(*) FROM digitaldictionary where ID=1128}
insert into digitaldictionary  (id,name,describe,tablename,columnname,iscanedit,updatetime,updateby)
values(1128,'行包结算状态','结算单状态(0正常, 1注销) ','packbalance','status',0,sysdate,0);

@repeat{SELECT COUNT(*) FROM digitaldictionarydetail where ID=692}
insert into digitaldictionarydetail  (id,digitaldictionaryid,orderno,code,value,describe,createtime,createby,updatetime,updateby )
values(692,1128,0,'0','未结算','',sysdate,0,sysdate,0);

@repeat{SELECT COUNT(*) FROM digitaldictionarydetail where ID=693}
insert into digitaldictionarydetail  (id,digitaldictionaryid,orderno,code,value,describe,createtime,createby,updatetime,updateby )
values(693,1128,1,'1','已注销','',sysdate,0,sysdate,0);
-- 2015年5月21日 孙越 结束 --

-- 2015/05/20 张彪 开始--
@repeat{SELECT COUNT(*) FROM digitaldictionary where ID=1121}
insert into digitaldictionary (ID, NAME, DESCRIBE, TABLENAME, COLUMNNAME, ISCANEDIT, UPDATETIME, UPDATEBY)
values (1121, '行包营收缴款明细表数据来源', '0：发货、1：到货', 'packtturnoverdetail', 'datafrom', 1, sysdate, 0);
@repeat{SELECT COUNT(*) FROM digitaldictionarydetail where ID=8111}
insert into digitaldictionarydetail (ID, DIGITALDICTIONARYID, ORDERNO, CODE, VALUE, DESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (8111, 1121, 0, '0', '发货', '', sysdate, 0, sysdate, 0);
@repeat{SELECT COUNT(*) FROM digitaldictionarydetail where ID=8121}
insert into digitaldictionarydetail (ID, DIGITALDICTIONARYID, ORDERNO, CODE, VALUE, DESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (8121, 1121, 1, '1', '到货', '',sysdate, 0, sysdate, 0);
@repeat{SELECT COUNT(*) FROM digitaldictionary where ID=1125}
insert into digitaldictionary (ID, NAME, DESCRIBE, TABLENAME, COLUMNNAME, ISCANEDIT, UPDATETIME, UPDATEBY)
values (1125, '行包信息表结算状态', '0：未结算、1：已结算', 'pack', 'balancestatus', 1, sysdate, 0);
@repeat{SELECT COUNT(*) FROM digitaldictionarydetail where ID=8115}
insert into digitaldictionarydetail (ID, DIGITALDICTIONARYID, ORDERNO, CODE, VALUE, DESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (8115, 1125, 0, '0', '未结算', '', sysdate, 0, sysdate, 0);
@repeat{SELECT COUNT(*) FROM digitaldictionarydetail where ID=8126}
insert into digitaldictionarydetail (ID, DIGITALDICTIONARYID, ORDERNO, CODE, VALUE, DESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (8126, 1125, 1, '1', '已结算', '',sysdate, 0, sysdate, 0);

delete from digitaldictionarydetail dl where dl.digitaldictionaryid =83;


insert into digitaldictionarydetail (ID, DIGITALDICTIONARYID, ORDERNO, CODE, VALUE, DESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (464, 83, 0, '0', '发货库存', '行包', sysdate, 0,sysdate , 0);

insert into digitaldictionarydetail (ID, DIGITALDICTIONARYID, ORDERNO, CODE, VALUE, DESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (465, 83, 1, '1', '签发出库', '行包', sysdate, 0, sysdate, 0);

insert into digitaldictionarydetail (ID, DIGITALDICTIONARYID, ORDERNO, CODE, VALUE, DESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (466, 83, 2, '2', '提领出库', '行包', sysdate, 0, sysdate, 0);

insert into digitaldictionarydetail (ID, DIGITALDICTIONARYID, ORDERNO, CODE, VALUE, DESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (467, 83, 3, '3', '作废', '行包', sysdate, 0, sysdate, 0);

insert into digitaldictionarydetail (ID, DIGITALDICTIONARYID, ORDERNO, CODE, VALUE, DESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (485, 83, 4, '4', '到货库存', '行包', sysdate, 0, sysdate, 0);

insert into digitaldictionarydetail (ID, DIGITALDICTIONARYID, ORDERNO, CODE, VALUE, DESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (587, 83, 5, '5', '已退票', '行包', sysdate, 0, sysdate, 0);


INSERT INTO DIGITALDICTIONARYDETAIL(ID, DIGITALDICTIONARYID, ORDERNO, CODE, VALUE, DESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY) 
VALUES('687','83','6','6','中转库存','行包',sysdate,'0',sysdate,'0');


INSERT INTO DIGITALDICTIONARYDETAIL(ID, DIGITALDICTIONARYID, ORDERNO, CODE, VALUE, DESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY) 
VALUES(727,'83','7','7','转至它站','行包',sysdate,'0',sysdate,'0');

@repeat{SELECT COUNT(*) FROM digitaldictionary where ID=1126}
insert into digitaldictionary (ID, NAME, DESCRIBE, TABLENAME, COLUMNNAME, ISCANEDIT,  UPDATETIME, UPDATEBY)
values (1126, '货物状态', '0：完好、1：破损、2：打湿', 'pack', 'goodsstatus', 1,  sysdate, 0);
@repeat{SELECT COUNT(*) FROM digitaldictionarydetail where ID=1118297}
insert into digitaldictionarydetail (ID, DIGITALDICTIONARYID, ORDERNO, CODE, VALUE,  DESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (1118297, 1126, 0, '0', '完好', '', sysdate, 0, sysdate, 0);
@repeat{SELECT COUNT(*) FROM digitaldictionarydetail where ID=1118298}
insert into digitaldictionarydetail (ID, DIGITALDICTIONARYID, ORDERNO, CODE, VALUE,  DESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (1118298, 1126, 1, '1', '破损', '', sysdate, 0, sysdate, 0);
@repeat{SELECT COUNT(*) FROM digitaldictionarydetail where ID=1118299}
insert into digitaldictionarydetail (ID, DIGITALDICTIONARYID, ORDERNO, CODE, VALUE,  DESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (1118299, 1126, 2, '2', '打湿', '', sysdate, 0, sysdate, 0);
@repeat{SELECT COUNT(*) FROM exceptioninfo where ID=503}
insert into exceptioninfo values(503,'0503','未收代收费，不能签发！','行包签发');
@repeat{SELECT COUNT(*) FROM exceptioninfo where ID=504}
insert into exceptioninfo values(504,'0504','该货物已经结算，不能签发！','行包签发');
@repeat{SELECT COUNT(*) FROM exceptioninfo where ID=505}
insert into exceptioninfo values(505,'0505','未收取运费，不能签发！','行包签发');
@repeat{SELECT COUNT(*) FROM exceptioninfo where ID=506}
insert into exceptioninfo values(506,'0506','该行包单号不存在！','行包签发');
@repeat{SELECT COUNT(*) FROM functionreg where ID=1126}
insert into functionreg (ID, PACKAGENAME, NAME, FUNCTIONKEY, FUNCTIONDESCRIBE, PARAMETERDESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, INSTRUCTION)
values (1126, 'PackDepartinvoicesManager.bpl', '行包结算单管理', '{761EBB2F-A4A4-49C5-9E0D-C474EE02866A}', '行包结算单管理', '', sysdate, 1126281, sysdate, 1126281, null);
@repeat{SELECT COUNT(*) FROM menu where ID=926}
insert into menu (ID, NAME, FUNCTIONREGID, GRADE, ORDERNO, PARENTID, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, URL, ICON, CLICKNUM, CLAZZ)
values (926, '行包结算单管理', 1126, 2, 7.00, 20, '', sysdate, 0, sysdate, 0, '', '', 0, '');
@repeat{SELECT COUNT(*) FROM digitaldictionary where ID=2121}
insert into digitaldictionary (ID, NAME, DESCRIBE, TABLENAME, COLUMNNAME, ISCANEDIT, UPDATETIME, UPDATEBY)
values (2121, '行包结算单数据来源', '0：微机单、1：手工单', 'packdepartinvoices', 'datatype', 1, sysdate, 0);
@repeat{SELECT COUNT(*) FROM digitaldictionarydetail where ID=8811}
insert into digitaldictionarydetail (ID, DIGITALDICTIONARYID, ORDERNO, CODE, VALUE, DESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (8811, 2121, 0, '0', '微机单', '', sysdate, 0, sysdate, 0);
@repeat{SELECT COUNT(*) FROM digitaldictionarydetail where ID=8821}
insert into digitaldictionarydetail (ID, DIGITALDICTIONARYID, ORDERNO, CODE, VALUE, DESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (8821, 2121, 1, '1', '手工单', '',sysdate, 0, sysdate, 0);
@repeat{SELECT COUNT(*) FROM digitaldictionary where ID=3121}
insert into digitaldictionary (ID, NAME, DESCRIBE, TABLENAME, COLUMNNAME, ISCANEDIT, UPDATETIME, UPDATEBY)
values (3121, '行包结算单打印结算单方式', '0：发班打印、1：补开、2：重打', 'packdepartinvoices', 'printway', 1, sysdate, 0);
@repeat{SELECT COUNT(*) FROM digitaldictionarydetail where ID=8911}
insert into digitaldictionarydetail (ID, DIGITALDICTIONARYID, ORDERNO, CODE, VALUE, DESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (8911, 3121, 0, '0', '发班打印', '', sysdate, 0, sysdate, 0);
@repeat{SELECT COUNT(*) FROM digitaldictionarydetail where ID=8921}
insert into digitaldictionarydetail (ID, DIGITALDICTIONARYID, ORDERNO, CODE, VALUE, DESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (8921, 3121, 1, '1', '补开', '',sysdate, 0, sysdate, 0);
@repeat{SELECT COUNT(*) FROM digitaldictionarydetail where ID=8931}
insert into digitaldictionarydetail (ID, DIGITALDICTIONARYID, ORDERNO, CODE, VALUE, DESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (8931, 3121, 2, '2', '重打', '', sysdate, 0, sysdate, 0);

@repeat{SELECT count(*) FROM printtemplatetype p where p.id=18}
insert into printtemplatetype (ID, NAME) values (18, '行包签发单');

@repeat{SELECT COUNT(*) FROM printtemplatetypeitem where ID=17042}
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (17042, 18, '补开', '0', 'fillopen', 0);
@repeat{SELECT COUNT(*) FROM parameter where ID=9033}
insert into parameter (ID, TYPE, CODE, VALUE, ISVISIBLE, ISEDITABLE, REMARK, UPDATETIME, UPDATEBY, UNIT)
values (9033, '30', '9033', '0', 1, 1, '客票结算单打印时，是否需要根据行包回收款有效日期来判断：0，不需要，1：需要', sysdate, 1, '');
@repeat{SELECT COUNT(*) FROM parameter where ID=9044}
insert into parameter (ID, TYPE, CODE, VALUE, ISVISIBLE, ISEDITABLE, REMARK, UPDATETIME, UPDATEBY, UNIT)
values (9044, '80', '9044', '7', 1, 1, '行包回收款有效日期', sysdate, 1, '天');
-- 2015/05/20 张彪 结束--

-- 发班结算->行包货物结算,添加状态 2015年5月21日 孙越 开始 --
@repeat{SELECT COUNT(*) FROM digitaldictionary where ID=1129}
insert into digitaldictionary  (id,name,describe,tablename,columnname,iscanedit,updatetime,updateby)
values(1129,'行包货物结算状态','运量单状态: 0正常、 1注销、 2已结算， 取数据字典  ','packdepartinvoices','status',0,sysdate,0);

@repeat{SELECT COUNT(*) FROM digitaldictionarydetail where ID=694}
insert into digitaldictionarydetail  (id,digitaldictionaryid,orderno,code,value,describe,createtime,createby,updatetime,updateby )
values(694,1129,0,'0','未结算','',sysdate,0,sysdate,0);

@repeat{SELECT COUNT(*) FROM digitaldictionarydetail where ID=695}
insert into digitaldictionarydetail  (id,digitaldictionaryid,orderno,code,value,describe,createtime,createby,updatetime,updateby )
values(695,1129,1,'1','已注销','',sysdate,0,sysdate,0);

@repeat{SELECT COUNT(*) FROM digitaldictionarydetail where ID=696}
insert into digitaldictionarydetail  (id,digitaldictionaryid,orderno,code,value,describe,createtime,createby,updatetime,updateby )
values(696,1129,2,'2','已结算','',sysdate,0,sysdate,0);

@repeat{SELECT COUNT(*) FROM digitaldictionarydetail where ID=697}
insert into digitaldictionarydetail  (id,digitaldictionaryid,orderno,code,value,describe,createtime,createby,updatetime,updateby )
values(697,1129,3,'3','待结算','',sysdate,0,sysdate,0);
-- 2015年5月21日  孙越 结束 --

-- 行包受理->包装列表，添加列表项: 泡沫箱、配件、木箱、蛇皮袋  2015-05-08 赵怀虎  开始--
@repeat{SELECT COUNT(*)-1 FROM DIGITALDICTIONARYDETAIL where ID='463'}
DELETE FROM DIGITALDICTIONARYDETAIL where value='兑付' and ID='463';

@repeat{SELECT COUNT(*) FROM DIGITALDICTIONARYDETAIL where ID='463'}
INSERT INTO DIGITALDICTIONARYDETAIL(ID,DIGITALDICTIONARYID,ORDERNO,CODE,VALUE,DESCRIBE,CREATETIME,CREATEBY,UPDATETIME,UPDATEBY) VALUES('463','82','1','1','对付','行包',sysdate,'0',sysdate,'0');

@repeat{SELECT COUNT(*)-1 FROM DIGITALDICTIONARYDETAIL where ID='457'}
DELETE FROM DIGITALDICTIONARYDETAIL where value ='纸箱' and ID='457';

@repeat{SELECT COUNT(*)-1 FROM DIGITALDICTIONARYDETAIL where ID='458'}
DELETE FROM DIGITALDICTIONARYDETAIL where value ='塑料袋' and ID='458';

@repeat{SELECT COUNT(*)-1 FROM DIGITALDICTIONARYDETAIL where ID='459'}
DELETE FROM DIGITALDICTIONARYDETAIL where value ='无' and ID='459';

@repeat{SELECT COUNT(*) FROM DIGITALDICTIONARYDETAIL where ID='10001'}
INSERT INTO DIGITALDICTIONARYDETAIL(ID,DIGITALDICTIONARYID,ORDERNO,CODE,VALUE,DESCRIBE,CREATETIME,CREATEBY,UPDATETIME,UPDATEBY) VALUES('10001','80','0','0','其他','行包',sysdate,'0',sysdate,'0');

@repeat{SELECT COUNT(*) FROM DIGITALDICTIONARYDETAIL where ID='10002'}
INSERT INTO DIGITALDICTIONARYDETAIL(ID,DIGITALDICTIONARYID,ORDERNO,CODE,VALUE,DESCRIBE,CREATETIME,CREATEBY,UPDATETIME,UPDATEBY) VALUES('10002','80','1','1','纸箱','行包',sysdate,'0',sysdate,'0');

@repeat{SELECT COUNT(*) FROM DIGITALDICTIONARYDETAIL where ID='10003'}
INSERT INTO DIGITALDICTIONARYDETAIL(ID,DIGITALDICTIONARYID,ORDERNO,CODE,VALUE,DESCRIBE,CREATETIME,CREATEBY,UPDATETIME,UPDATEBY) VALUES('10003','80','2','2','塑料袋','行包',sysdate,'0',sysdate,'0');
@repeat{SELECT COUNT(*) FROM DIGITALDICTIONARYDETAIL where ID='10004'}
INSERT INTO DIGITALDICTIONARYDETAIL(ID,DIGITALDICTIONARYID,ORDERNO,CODE,VALUE,DESCRIBE,CREATETIME,CREATEBY,UPDATETIME,UPDATEBY) VALUES('10004','80','3','3','泡沫箱','行包',sysdate,'0',sysdate,'0');
@repeat{SELECT COUNT(*) FROM DIGITALDICTIONARYDETAIL where ID='10005'}
INSERT INTO DIGITALDICTIONARYDETAIL(ID,DIGITALDICTIONARYID,ORDERNO,CODE,VALUE,DESCRIBE,CREATETIME,CREATEBY,UPDATETIME,UPDATEBY) VALUES('10005','80','4','4','配件','行包',sysdate,'0',sysdate,'0');
@repeat{SELECT COUNT(*) FROM DIGITALDICTIONARYDETAIL where ID='10006'}
INSERT INTO DIGITALDICTIONARYDETAIL(ID,DIGITALDICTIONARYID,ORDERNO,CODE,VALUE,DESCRIBE,CREATETIME,CREATEBY,UPDATETIME,UPDATEBY) VALUES('10006','80','5','5','木箱','行包',sysdate,'0',sysdate,'0');
@repeat{SELECT COUNT(*) FROM DIGITALDICTIONARYDETAIL where ID='10007'}
INSERT INTO DIGITALDICTIONARYDETAIL(ID,DIGITALDICTIONARYID,ORDERNO,CODE,VALUE,DESCRIBE,CREATETIME,CREATEBY,UPDATETIME,UPDATEBY) VALUES('10007','80','6','6','蛇皮袋','行包',sysdate,'0',sysdate,'0');
@repeat{SELECT COUNT(*) FROM DIGITALDICTIONARY where ID='611'}
INSERT INTO DIGITALDICTIONARY(ID,NAME,DESCRIBE,TABLENAME,COLUMNNAME,ISCANEDIT,UPDATETIME,UPDATEBY) VALUES('611','对付款回收状态','对付款回收状态:0未回收 1已回收','pack','recyclestatus','0',sysdate,'0');
@repeat{SELECT COUNT(*) FROM DIGITALDICTIONARYDETAIL where ID='21001'}
INSERT INTO DIGITALDICTIONARYDETAIL (ID,DIGITALDICTIONARYID,ORDERNO,CODE,VALUE,DESCRIBE,CREATETIME,CREATEBY,UPDATETIME,UPDATEBY) VALUES('21001','611','0','0','未回收','对付款回收状态:0未回收',sysdate,'0',sysdate,'0');
@repeat{SELECT COUNT(*) FROM DIGITALDICTIONARYDETAIL where ID='21002'}
INSERT INTO DIGITALDICTIONARYDETAIL (ID,DIGITALDICTIONARYID,ORDERNO,CODE,VALUE,DESCRIBE,CREATETIME,CREATEBY,UPDATETIME,UPDATEBY) VALUES('21002','611','1','1','已回收','对付款回收状态:1已回收',sysdate,'0',sysdate,'0');
-- 行包受理->包装列表，添加列表项: 泡沫箱、配件、木箱、蛇皮袋  2015-05-08 赵怀虎  2015-05-08 赵怀虎  结束--

--李电志 begin 2015年5月21日 18:21:31 删除exceptioninfo表中中转出库的异常信息  
@repeat{SELECT COUNT(*)-1 FROM exceptioninfo where ID=511}
delete from exceptioninfo ex where ex.id = 511;
--李电志 end
--孙越 begin 2015年5月22日 15:46:17 添加重置行包结算通知单号 --
@repeat{SELECT COUNT(*) FROM menu where ID=322}
insert into menu (ID, NAME, FUNCTIONREGID, GRADE, ORDERNO, PARENTID, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, URL, ICON, CLICKNUM, CLAZZ)
values (322, '重置行包结算通知单号', 2, 2, 11.00, 20, 'PackBalanceBill', sysdate, 0, sysdate, 0, '', '', 0, '');
--孙越 end--

--孙越 begin 2015年5月23日 11:10:44 添加重置行包收讫单号 --
@repeat{SELECT COUNT(*) FROM menu where ID=323}
insert into menu (ID, NAME, FUNCTIONREGID, GRADE, ORDERNO, PARENTID, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, URL, ICON, CLICKNUM, CLAZZ)
values (323, '重置行包收讫单号', 2, 2, 11.00, 20, 'PackArrivalBill', sysdate, 0, sysdate, 0, '', '', 0, '');
--孙越 end--
--李电志 begin 2015年5月25日 18:17:03 增加exceptioninfo表中货款回收判断信息
@repeat{SELECT COUNT(*) FROM exceptioninfo where ID=514}
insert into exceptioninfo values(514,'0514','该行包货款还未回收，不允许签发！','行包签发');
--李电志 end

-- 赵怀虎 begin 2015年5月26日  行包参数:修改8031参数，添加8023参数 --
@repeat{SELECT COUNT(*)-1 FROM PARAMETER where ID=43}
DELETE FROM PARAMETER where ID='43';

@repeat{SELECT COUNT(*) FROM PARAMETER where ID=43}
INSERT INTO PARAMETER (ID, TYPE, CODE, VALUE, ISVISIBLE, ISEDITABLE, REMARK, UPDATETIME, UPDATEBY, UNIT)
VALUES ('43', '80', '8013', '1', '1', '1', '到货行包最大免费保管天数', SYSDATE, '1126281', '天');

@repeat{SELECT COUNT(*) FROM PARAMETER where ID=13031}
INSERT INTO PARAMETER (ID, TYPE, CODE, VALUE, ISVISIBLE, ISEDITABLE, REMARK, UPDATETIME, UPDATEBY, UNIT)
VALUES ('13031', '80', '8023', '5', '1', '1', '行包基本保管费', SYSDATE, '1126281', '元');
-- 赵怀虎 end 2015年5月26日 --

--姜蓥瑞 begin 2015年5月23日 添加前台，出库，对付，发货 明细统计， --
@repeat{SELECT COUNT(*) FROM functionreg where ID=132}
INSERT INTO FUNCTIONREG(ID, PACKAGENAME, NAME, FUNCTIONKEY, FUNCTIONDESCRIBE, PARAMETERDESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, INSTRUCTION)
VALUES('132', 'QueryPackDetails.bpl', '前台明细统计', '{F7812D63-B29C-44EB-AD29-939A74B1E351}', '前台明细', '', sysdate, '132', sysdate , '132', ''); 
@repeat{SELECT COUNT(*) FROM menu where ID=190}
INSERT INTO MENU(ID, NAME, FUNCTIONREGID, GRADE, ORDERNO, PARENTID, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, URL, ICON, CLICKNUM, CLAZZ)
VALUES(190,'前台明细统计', '132',  '3', '4.00', 27, null, sysdate, 0, sysdate, 0, null, null, 0, null);
@repeat{SELECT COUNT(*) FROM functionreg where ID=350}
INSERT INTO FUNCTIONREG(ID, PACKAGENAME, NAME, FUNCTIONKEY, FUNCTIONDESCRIBE, PARAMETERDESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, INSTRUCTION)
VALUES('350', 'QryLibraryDetails.bpl', '出库明细统计', '{0D62BFFB-F2D0-4E57-8EEA-D931A05CEE39}', '出库明细统计', '', sysdate, '350', sysdate , '350', '');
@repeat{SELECT COUNT(*) FROM menu where ID=191}
INSERT INTO MENU(ID, NAME, FUNCTIONREGID, GRADE, ORDERNO, PARENTID, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, URL, ICON, CLICKNUM, CLAZZ)
VALUES(191,'出库明细统计', '350',  '3', '5.00', 27, null, sysdate, 0, sysdate, 0, null, null, 0, null);    
@repeat{SELECT COUNT(*) FROM functionreg where ID=351}
INSERT INTO FUNCTIONREG(ID, PACKAGENAME, NAME, FUNCTIONKEY, FUNCTIONDESCRIBE, PARAMETERDESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, INSTRUCTION)
VALUES('351', 'QueryCollectDetail.bpl', '对付明细统计', '{C2E4AAD9-4BAF-45BF-B5E1-5F629C9501FA}', '对付明细统计', '', sysdate, '351', sysdate , '351', '');
@repeat{SELECT COUNT(*) FROM menu where ID=192}
INSERT INTO MENU(ID, NAME, FUNCTIONREGID, GRADE, ORDERNO, PARENTID, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, URL, ICON, CLICKNUM, CLAZZ)
VALUES(192,'对付明细统计', '351',  '3', '6.00', 27, null, sysdate, 0, sysdate, 0, null, null, 0, null); 
@repeat{SELECT COUNT(*) FROM functionreg where ID=352}
INSERT INTO FUNCTIONREG(ID, PACKAGENAME, NAME, FUNCTIONKEY, FUNCTIONDESCRIBE, PARAMETERDESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, INSTRUCTION)
VALUES('352', 'QuerySendGoodsdGetails.bpl', '发货明细统计', '{03256AAC-2FB9-4A12-993C-29D4C971DC04}', '发货明细统计', '', sysdate, '352', sysdate , '352', '');
@repeat{SELECT COUNT(*) FROM menu where ID=193}
INSERT INTO MENU(ID, NAME, FUNCTIONREGID, GRADE, ORDERNO, PARENTID, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, URL, ICON, CLICKNUM, CLAZZ)
VALUES(193,'发货明细统计', '352',  '3', '8.00', 27, null, sysdate, 0, sysdate, 0, null, null, 0, null);
-- 姜蓥瑞 end 2015年5月26日 --

-- 孙越 begin 2015年5月27日 09:09:48 插入出库结算和前台结算菜单 --
@repeat{SELECT COUNT(*) FROM functionreg where ID=152}
insert into functionreg (ID, PACKAGENAME, NAME, FUNCTIONKEY, FUNCTIONDESCRIBE, PARAMETERDESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, INSTRUCTION)
values (152, 'Balance.bpl', '出库结算', '{87C00312-6B3F-41D5-BEAA-E5E222EC5094}', '出库结算', '', sysdate, 0, sysdate, 0, '');
@repeat{SELECT COUNT(*) FROM functionreg where ID=153}
insert into functionreg (ID, PACKAGENAME, NAME, FUNCTIONKEY, FUNCTIONDESCRIBE, PARAMETERDESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, INSTRUCTION)
values (153, 'Balance.bpl', '前台结算', '{74322CD5-873C-4F96-87EE-0A022796025E}', '前台结算', '', sysdate, 0,sysdate, 0, '');
@repeat{SELECT COUNT(*) FROM menu where ID=932772}
insert into menu (ID, NAME, FUNCTIONREGID, GRADE, ORDERNO, PARENTID, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, URL, ICON, CLICKNUM, CLAZZ)
values (932772, '前台结算', 153, 2, 5.00, 20, '', sysdate, 1158013, sysdate, 1158013, '', '', 0, '');
@repeat{SELECT COUNT(*) FROM menu where ID=932771}
insert into menu (ID, NAME, FUNCTIONREGID, GRADE, ORDERNO, PARENTID, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, URL, ICON, CLICKNUM, CLAZZ)
values (932771, '出库结算', 152, 2, 4.00, 20, '', sysdate, 1158013, sysdate, 1158013, '', '', 0, '');
-- 孙越 end --

-- 孙越 begin 添加出库/结算 打印模板信息 --
@repeat{SELECT COUNT(*) FROM printtemplatetype where ID=201531}
insert into printtemplatetype (ID, NAME)
values (201531, '行包结算单');

@repeat{SELECT COUNT(*) FROM printtemplatetypeitem where ID=932846}
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (932846, 201531, '结算人', '0', 'balanceby', 0);

@repeat{SELECT COUNT(*) FROM printtemplatetypeitem where ID=932863}
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (932863, 201531, '结算日期', '2', 'balancetime', 0);

@repeat{SELECT COUNT(*) FROM printtemplatetypeitem where ID=932845}
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (932845, 201531, '结算单位', '0', 'balanceunitname', 0);

@repeat{SELECT COUNT(*) FROM printtemplatetypeitem where ID=932844}
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (932844, 201531, '结算金额', '1', 'packbalancemoney', 0);

@repeat{SELECT COUNT(*) FROM printtemplatetypeitem where ID=932864}
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (932864, 201531, '结算单号', '0', 'packbalanceno', 0);

@repeat{SELECT COUNT(*) FROM printtemplatetypeitem where ID=932842}
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (932842, 201531, '运费', '1', 'packfee', 0);

@repeat{SELECT COUNT(*) FROM printtemplatetypeitem where ID=932841}
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (932841, 201531, '票据张数', '1', 'packnos', 0);

@repeat{SELECT COUNT(*) FROM printtemplatetypeitem where ID=932843}
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (932843, 201531, '货款', '1', 'packprice', 0);

@repeat{SELECT COUNT(*) FROM printtemplatetypeitem where ID=932996}
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (932996, 201531, '件数', '1', 'pieces', 0);

@repeat{SELECT COUNT(*) FROM printtemplate where ID=932865}
insert into printtemplate (ID, PRINTTEMPLATETYPEID, NAME, HEIGHT, HEIGHTCORRECTION, WIDTH, LEFTMARGIN, TOP, BACKGROUNDIMAGE, ROWSPACE, ROWPERPAGE, PRINTERNAME, COLUMNSPERPAGE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (932865, 201531, '行包出库结算', 1000, 1000, 1000, 0, 0, '', 50, 5, '', 1,  sysdate, 1158013, sysdate, 1158013);

@repeat{SELECT COUNT(*) FROM printtemplate where ID=932968}
insert into printtemplate (ID, PRINTTEMPLATETYPEID, NAME, HEIGHT, HEIGHTCORRECTION, WIDTH, LEFTMARGIN, TOP, BACKGROUNDIMAGE, ROWSPACE, ROWPERPAGE, PRINTERNAME, COLUMNSPERPAGE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (932968, 201531, '行包前台结算', 1000, 1000, 1000, 0, 0, '', 50, 5, '', 1, sysdate, 1158013, sysdate, 1158013);


@repeat{SELECT COUNT(*) FROM printtemplateitem where ID=932997}
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (932997, 932968, 932996, '件数', 1, '宋体', 11.0000, 505, 1254, 79, 40, '2', '', sysdate, 1158013, sysdate, 1158013);

@repeat{SELECT COUNT(*) FROM printtemplateitem where ID=932985}
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (932985, 932968, -2, '画线', 1, '宋体', 1.0000, 577, 370, 1540, 3, '0', '',sysdate, 1158013, sysdate, 1158013);

@repeat{SELECT COUNT(*) FROM printtemplateitem where ID=932881}
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (932881, 932865, 932843, '货款', 1, '宋体', 11.0000, 542, 1310, 79, 40, '2', '', sysdate, 1158013, sysdate, 1158013);

@repeat{SELECT COUNT(*) FROM printtemplateitem where ID=932882}
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (932882, 932865, -2, '画线', 1, '宋体', 83.0000, 352, 450, 1471, 294, '0', '', sysdate, 1158013, sysdate, 1158013);

@repeat{SELECT COUNT(*) FROM printtemplateitem where ID=932883}
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (932883, 932865, -2, '画线', 1, '宋体', 50.0000, 466, 450, 1471, 180, '0', '', sysdate, 1158013, sysdate, 1158013);

@repeat{SELECT COUNT(*) FROM printtemplateitem where ID=932884}
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (932884, 932865, -2, '画线', 1, '宋体', 84.0000, 352, 783, 392, 294, '0', '', sysdate, 1158013, sysdate, 1158013);

@repeat{SELECT COUNT(*) FROM printtemplateitem where ID=932885}
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (932885, 932865, -2, '画线', 1, '宋体', 83.0000, 352, 1498, 421, 294, '0', '', sysdate, 1158013, sysdate, 1158013);

@repeat{SELECT COUNT(*) FROM printtemplateitem where ID=932886}
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (932886, 932865, -1, '宜昌交运代收、代付结算表', 1, '宋体', 22.0000, 148, 651, 921, 77, '1', '', sysdate, 1158013, sysdate, 1158013);

@repeat{SELECT COUNT(*) FROM printtemplateitem where ID=932887}
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (932887, 932865, -1, '制表人:', 1, '宋体', 11.0000, 664, 489, 140, 40, '1', '',sysdate, 1158013, sysdate, 1158013);

@repeat{SELECT COUNT(*) FROM printtemplateitem where ID=932888}
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (932888, 932865, -1, '审核人:', 1, '宋体', 11.0000, 664, 1048, 140, 40, '1', '', sysdate, 1158013, sysdate, 1158013);

@repeat{SELECT COUNT(*) FROM printtemplateitem where ID=932889}
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (932889, 932865, -1, '签字:', 1, '宋体', 11.0000, 664, 1635, 101, 40, '1', '', sysdate, 1158013, sysdate, 1158013);

@repeat{SELECT COUNT(*) FROM printtemplateitem where ID=932890}
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (932890, 932865, 932846, '结算人', 1, '宋体', 11.0000, 664, 661, 119, 40, '2', '', sysdate, 1158013, sysdate, 1158013);

@repeat{SELECT COUNT(*) FROM printtemplateitem where ID=932998}
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (932998, 932968, -1, '件数', 1, '宋体', 11.0000, 392, 1249, 79, 40, '1', '', sysdate, 1158013, sysdate, 1158013);

@repeat{SELECT COUNT(*) FROM printtemplateitem where ID=932970}
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (932970, 932968, 932846, '结算人', 1, '宋体', 11.0000, 725, 579, 119, 40, '2', '', sysdate, 1158013, sysdate, 1158013);

@repeat{SELECT COUNT(*) FROM printtemplateitem where ID=932868}
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (932868, 932865, -1, '结算日期:', 1, '宋体', 11.0000, 291, 1445, 180, 40, '1', '', sysdate, 1158013, sysdate, 1158013);

@repeat{SELECT COUNT(*) FROM printtemplateitem where ID=932869}
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (932869, 932865, 932863, '结算日期', 1, '宋体', 11.0000, 291, 1685, 159, 40, '2', '', sysdate, 1158013, sysdate, 1158013);

@repeat{SELECT COUNT(*) FROM printtemplateitem where ID=932870}
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (932870, 932865, -1, '结算单位:', 1, '宋体', 11.0000, 291, 500, 180, 40, '1', '', sysdate, 1158013, sysdate, 1158013);

@repeat{SELECT COUNT(*) FROM printtemplateitem where ID=932871}
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (932871, 932865, 932845, '结算单位', 1, '宋体', 11.0000, 291, 741, 159, 40, '2', '', sysdate, 1158013, sysdate, 1158013);

@repeat{SELECT COUNT(*) FROM printtemplateitem where ID=932872}
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (932872, 932865, -1, '结算金额', 1, '宋体', 11.0000, 397, 1603, 180, 40, '1', '', sysdate, 1158013, sysdate, 1158013);

@repeat{SELECT COUNT(*) FROM printtemplateitem where ID=932873}
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (932873, 932865, 932844, '结算金额', 1, '宋体', 11.0000, 542, 1614, 159, 40, '2', '',sysdate, 1158013, sysdate, 1158013);

@repeat{SELECT COUNT(*) FROM printtemplateitem where ID=932874}
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (932874, 932865, -1, '结算单号:', 1, '宋体', 11.0000, 93, 1566, 180, 40, '1', '',sysdate, 1158013, sysdate, 1158013);

@repeat{SELECT COUNT(*) FROM printtemplateitem where ID=932875}
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (932875, 932865, 932864, '结算单号', 1, '宋体', 11.0000, 93, 1754, 159, 40, '2', '', sysdate, 1158013, sysdate, 1158013);

@repeat{SELECT COUNT(*) FROM printtemplateitem where ID=932876}
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (932876, 932865, -1, '运费', 1, '宋体', 11.0000, 397, 918, 101, 40, '1', '', sysdate, 1158013, sysdate, 1158013);

@repeat{SELECT COUNT(*) FROM printtemplateitem where ID=932877}
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (932877, 932865, 932842, '运费', 1, '宋体', 11.0000, 542, 918, 79, 40, '2', '',sysdate, 1158013, sysdate, 1158013);

@repeat{SELECT COUNT(*) FROM printtemplateitem where ID=932878}
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (932878, 932865, -1, '票据张数', 1, '宋体', 11.0000, 397, 521, 180, 40, '1', '', sysdate, 1158013, sysdate, 1158013);

@repeat{SELECT COUNT(*) FROM printtemplateitem where ID=932879}
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (932879, 932865, 932841, '票据张数', 1, '宋体', 11.0000, 542, 532, 159, 40, '2', '', sysdate, 1158013, sysdate, 1158013);

@repeat{SELECT COUNT(*) FROM printtemplateitem where ID=932880}
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (932880, 932865, -1, '货款', 1, '宋体', 11.0000, 397, 1299, 101, 40, '1', '', sysdate, 1158013, sysdate, 1158013);

@repeat{SELECT COUNT(*) FROM printtemplateitem where ID=932971}
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (932971, 932968, -1, '结算日期:', 1, '宋体', 11.0000, 288, 1220, 180, 40, '1', '', sysdate, 1158013, sysdate, 1158013);

@repeat{SELECT COUNT(*) FROM printtemplateitem where ID=932972}
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (932972, 932968, 932863, '结算日期', 1, '宋体', 11.0000, 288, 1460, 159, 40, '2', '', sysdate, 1158013, sysdate, 1158013);

@repeat{SELECT COUNT(*) FROM printtemplateitem where ID=932973}
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (932973, 932968, -1, '结算单位:', 1, '宋体', 11.0000, 288, 407, 180, 40, '1', '', sysdate, 1158013, sysdate, 1158013);

@repeat{SELECT COUNT(*) FROM printtemplateitem where ID=932974}
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (932974, 932968, 932845, '结算单位', 1, '宋体', 11.0000, 288, 648, 159, 40, '2', '', sysdate, 1158013, sysdate, 1158013);

@repeat{SELECT COUNT(*) FROM printtemplateitem where ID=932975}
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (932975, 932968, -1, '结算金额', 1, '宋体', 11.0000, 397, 1603, 159, 40, '1', '', sysdate, 1158013, sysdate, 1158013);

@repeat{SELECT COUNT(*) FROM printtemplateitem where ID=932976}
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (932976, 932968, 932844, '结算金额', 1, '宋体', 11.0000, 513, 1609, 159, 40, '2', '', sysdate, 1158013, sysdate, 1158013);

@repeat{SELECT COUNT(*) FROM printtemplateitem where ID=932977}
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (932977, 932968, -1, '结算单号:', 1, '宋体', 11.0000, 111, 1527, 180, 40, '1', '', sysdate, 1158013, sysdate, 1158013);

@repeat{SELECT COUNT(*) FROM printtemplateitem where ID=932978}
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (932978, 932968, 932864, '结算单号', 1, '宋体', 11.0000, 111, 1767, 159, 40, '2', '', sysdate, 1158013, sysdate, 1158013);

@repeat{SELECT COUNT(*) FROM printtemplateitem where ID=932999}
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (932999, 932968, 932844, '结算金额', 1, '宋体', 11.0000, 622, 778, 159, 40, '7', '', sysdate, 1158013, sysdate, 1158013);

@repeat{SELECT COUNT(*) FROM printtemplateitem where ID=933077}
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (933077, 932968, -2, '画线', 1, '宋体', 96.0000, 347, 370, 1548, 341, '0', '', sysdate, 1158013, sysdate, 1158013);

@repeat{SELECT COUNT(*) FROM printtemplateitem where ID=932981}
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (932981, 932968, -1, '票据张数', 1, '宋体', 11.0000, 397, 812, 159, 40, '1', '', sysdate, 1158013, sysdate, 1158013);

@repeat{SELECT COUNT(*) FROM printtemplateitem where ID=932982}
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (932982, 932968, 932841, '票据张数', 1, '宋体', 11.0000, 511, 818, 159, 40, '2', '', sysdate, 1158013, sysdate, 1158013);

@repeat{SELECT COUNT(*) FROM printtemplateitem where ID=932986}
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (932986, 932968, -2, '画线', 1, '宋体', 65.0000, 347, 1101, 3, 228, '0', '', sysdate, 1158013, sysdate, 1158013);

@repeat{SELECT COUNT(*) FROM printtemplateitem where ID=932987}
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (932987, 932968, -2, '画线', 1, '宋体', 1.0000, 468, 370, 1543, 3, '0', '', sysdate, 1158013, sysdate, 1158013);

@repeat{SELECT COUNT(*) FROM printtemplateitem where ID=932988}
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (932988, 932968, -2, '画线', 1, '宋体', 64.0000, 347, 1490, 3, 225, '0', '', sysdate, 1158013, sysdate, 1158013);

@repeat{SELECT COUNT(*) FROM printtemplateitem where ID=932989}
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (932989, 932968, -2, '画线', 1, '宋体', 97.0000, 347, 741, 3, 339, '0', '', sysdate, 1158013, sysdate, 1158013);

@repeat{SELECT COUNT(*) FROM printtemplateitem where ID=933082}
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (933082, 932968, -1, '宜昌中心客运站货物托运结算单', 1, '宋体', 15.0000, 116, 738, 791, 53, '1', '',sysdate, 1158013, sysdate, 1158013);

@repeat{SELECT COUNT(*) FROM printtemplateitem where ID=932991}
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (932991, 932968, -1, '制表人:', 1, '宋体', 11.0000, 725, 400, 140, 40, '1', '', sysdate, 1158013, sysdate, 1158013);

@repeat{SELECT COUNT(*) FROM printtemplateitem where ID=932992}
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (932992, 932968, -1, '审核人:', 1, '宋体', 11.0000, 725, 945, 140, 40, '1', '',sysdate, 1158013, sysdate, 1158013);

@repeat{SELECT COUNT(*) FROM printtemplateitem where ID=932993}
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (932993, 932968, -1, '车主签名:', 1, '宋体', 11.0000, 725, 1463, 180, 40, '1', '',sysdate, 1158013, sysdate, 1158013);

@repeat{SELECT COUNT(*) FROM printtemplateitem where ID=932994}
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (932994, 932968, -1, '合计金额(大写)', 1, '宋体', 11.0000, 616, 415, 280, 40, '1', '', sysdate, 1158013, sysdate, 1158013);

-- 孙越 end -- 

 -- 赵怀虎 begin 行包受理单/到货收讫单 打印模板信息 2015/05/28--
@repeat{SELECT COUNT(*)-1 FROM PRINTTEMPLATETYPEITEM where ID=161}
UPDATE PRINTTEMPLATETYPEITEM P SET P.ITEMNAME='包装方式' ,P.ITEMCODE='packed' WHERE ID=161;
@repeat{SELECT COUNT(*)-1 FROM PRINTTEMPLATEITEM where ID=64008}
UPDATE PRINTTEMPLATEITEM P SET P.TITLE='包装方式' WHERE P.ID=64008;
--赵怀虎 end 2015/05/28 --
@repeat{SELECT COUNT(*) FROM menu where ID=1775}
insert into menu (ID, NAME, FUNCTIONREGID, GRADE, ORDERNO, PARENTID, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, URL, ICON, CLICKNUM, CLAZZ)
values (1775, '行包提领', 64615, 2, 3.50, 20, '', sysdate, 0, sysdate, 1, '', '', 0, '');

--孙越 begin 添加行包已结算查询的功能和菜单 --
@repeat{SELECT COUNT(*) FROM functionreg where ID=66666}
insert into functionreg (ID, PACKAGENAME, NAME, FUNCTIONKEY, FUNCTIONDESCRIBE, PARAMETERDESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, INSTRUCTION)
values (66666, 'QueryBalanced.bpl', '行包已结账管理', '{BF5B8885-7473-4AC8-AA8A-75B50D84A58A}', '行包已结算查询', '', sysdate, 0, sysdate, 0, '');

@repeat{SELECT COUNT(*) FROM menu where ID=35666}
insert into menu (ID, NAME, FUNCTIONREGID, GRADE, ORDERNO, PARENTID, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, URL, ICON, CLICKNUM, CLAZZ)
values (35666, '行包已结账管理', 66666, 2, 11.00, 20, '', sysdate, 0, sysdate, 0, '', '', 0, '');

@repeat{SELECT COUNT(*)-1 FROM digitaldictionarydetail where ID=692}
update digitaldictionarydetail set value = '正常' where id = 692;

@repeat{SELECT COUNT(*)-1 FROM digitaldictionarydetail where ID=693}
update digitaldictionarydetail set value = '注销' where id = 693;
--孙越 end --
-- 赵怀虎 begin 行包管理/货物月结算表 2015/06/01--
@repeat{SELECT COUNT(*) FROM menu where ID=65159}
INSERT INTO MENU(ID, NAME, FUNCTIONREGID, GRADE, ORDERNO, PARENTID, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, URL, ICON, CLICKNUM, CLAZZ)
VALUES (65159, '货物月结算表', '65159', '2', '30.5', '20', '', SYSDATE, 0, SYSDATE, 0, NULL, NULL, 0, NULL);
@repeat{SELECT COUNT(*) FROM functionreg where ID=65159}
INSERT INTO FUNCTIONREG(ID, PACKAGENAME, NAME, FUNCTIONKEY, FUNCTIONDESCRIBE, PARAMETERDESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, INSTRUCTION)
VALUES (65159, 'QryPackMonthBalance.bpl', '货物月结算表', '{464497EE-5F74-4875-9E91-1DB4A20B928E}', '货物月结算表', '', SYSDATE, 0, SYSDATE, 0, '');
--赵怀虎 end 2015/06/01 --
@repeat{SELECT COUNT(*) from  parameter WHERE code='1058' }
insert into parameter values(1058,'10','1058','1',1,1,'0：表示半票票价取全票一半，1：表示取执行票价中的半票',sysdate,0,'');
-- 姜蓥瑞 begin 行包管理/货物日结算表 2015/06/02--
@repeat{SELECT COUNT(*) FROM functionreg where ID=65160} 
INSERT INTO FUNCTIONREG(ID, PACKAGENAME, NAME, FUNCTIONKEY, FUNCTIONDESCRIBE, PARAMETERDESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, INSTRUCTION)
VALUES(65160, 'QryPackDayBalance.bpl', '货物日结算表', '{74939874-26D5-406B-9394-E10EB90C07BC}', '货物日结算表', '', SYSDATE, 0, SYSDATE, 0, '');	
@repeat{SELECT COUNT(*) FROM menu where ID=65160}		
INSERT INTO MENU(ID, NAME, FUNCTIONREGID, GRADE, ORDERNO, PARENTID, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, URL, ICON, CLICKNUM, CLAZZ)
VALUES(65160, '货物日结算表', '65160', '2', '30.00', '20', '', SYSDATE, 0, SYSDATE, 0, NULL, NULL, 0, NULL);
@repeat{SELECT COUNT(*) FROM functionreg where ID=65555} 
INSERT INTO FUNCTIONREG(ID, PACKAGENAME, NAME, FUNCTIONKEY, FUNCTIONDESCRIBE, PARAMETERDESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, INSTRUCTION)
VALUES('65555', 'PackManualMakeup.bpl', '行包结算单补录', '{2A8831D1-C851-44FB-A4F2-F6E7BAE70838}', '行包结算单补录', '', sysdate, 0, sysdate , 0, '');
@repeat{SELECT COUNT(*) FROM menu where ID=35636} 
INSERT INTO MENU(ID, NAME, FUNCTIONREGID, GRADE, ORDERNO, PARENTID, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, URL, ICON, CLICKNUM, CLAZZ)
VALUES(35636,'行包结算单补录', '65555',  '2', '10.00', 20, null, sysdate, 0, sysdate, 0, null, null, 0, null);
--姜蓥瑞 end 2015/06/02 --

--营收缴款打印模板新增改签数 liyi 
@repeat{SELECT COUNT(*) from  printtemplatetypeitem WHERE id=7812 }
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (7812, 6546, '改签数', '1', 'changenum', 0);

--同步改签数到营收缴款表中的改签数字段
update ticketturnoverdetail td set td.changenum = (select count(*) from ticketchange t where t.newticketno >= td.ticketstartno 
and t.newticketno <= td.ticketendno and td.seller = t.changeby and td.moneydate = trunc(t.changetime))
--4.5版本升级缺少的脚本
--parameter begin
@repeat{SELECT COUNT(*) from  parameter WHERE id=90999 }
insert into parameter (ID, TYPE, CODE, VALUE, ISVISIBLE, ISEDITABLE, REMARK, UPDATETIME, UPDATEBY, UNIT)
values (90999, '20', '9099', '0', 1, 1, '综合检票中，是否自动开检,0:否,1:是', sysdate, 1158013, '是否');
@repeat{SELECT COUNT(*) from  parameter WHERE id=57276 }
insert into parameter (ID, TYPE, CODE, VALUE, ISVISIBLE, ISEDITABLE, REMARK, UPDATETIME, UPDATEBY, UNIT)
values (57276, '30', '8080', '1', 1, 1, '综合检票中发班是否打印货物结算单，0：不打印，1：打印', sysdate, 1158013, '是否');
@repeat{SELECT COUNT(*) from  parameter WHERE id=1055 }
insert into parameter (ID, TYPE, CODE, VALUE, ISVISIBLE, ISEDITABLE, REMARK, UPDATETIME, UPDATEBY, UNIT)
values (1055, '10', '1055', '0', 1, 1, '售票界面是否经过座位图，0：不经过，1：经过', sysdate, 1158013, '');
@repeat{SELECT COUNT(*) from  parameter WHERE id=57288 }
insert into parameter (ID, TYPE, CODE, VALUE, ISVISIBLE, ISEDITABLE, REMARK, UPDATETIME, UPDATEBY, UNIT)
values (57288, '30', '9080', '1', 1, 1, '综合检票中发班是否按售票站打印结算单，0：否，1：是', sysdate, 1158013, '是否');
@repeat{SELECT COUNT(*) from  parameter WHERE id=1117041 }
insert into parameter (ID, TYPE, CODE, VALUE, ISVISIBLE, ISEDITABLE, REMARK, UPDATETIME, UPDATEBY, UNIT)
values (1117041, '30', '8044', '1', 1, 1, '综合检票中，发班时是否打印空结算单', sysdate, 1158013, '是否');
@repeat{SELECT COUNT(*) from  parameter WHERE id=2032 }
insert into parameter (ID, TYPE, CODE, VALUE, ISVISIBLE, ISEDITABLE, REMARK, UPDATETIME, UPDATEBY, UNIT)
values (2032, '20', '2032', '1', 1, 1, '0:ID卡报班，1：IC卡报班', sysdate, 1158013, '');
@repeat{SELECT COUNT(*) from  parameter WHERE id=1056 }
insert into parameter (ID, TYPE, CODE, VALUE, ISVISIBLE, ISEDITABLE, REMARK, UPDATETIME, UPDATEBY, UNIT)
values (1056, '10', '1056', '1', 1, 1, '售票时全票是否默认一张,0:零张，1：一张', sysdate, 1158013, '');
@repeat{SELECT COUNT(*) from  parameter WHERE id=5050 }
insert into parameter (ID, TYPE, CODE, VALUE, ISVISIBLE, ISEDITABLE, REMARK, UPDATETIME, UPDATEBY, UNIT)
values (5050, '50', '5050', '0', 1, 1, '系统中结算金额是否启用线路票价差功能,0：不启用，1：启用', sysdate, 1158013, '是否');
@repeat{SELECT COUNT(*) from  parameter WHERE id=1057 }
insert into parameter (ID, TYPE, CODE, VALUE, ISVISIBLE, ISEDITABLE, REMARK, UPDATETIME, UPDATEBY, UNIT)
values (1057, '10', '1057', '0', 1, 1, '售票员是否可以查看营收F1,0：不能，1：能', sysdate, 1158013, '是否');
@repeat{SELECT COUNT(*) from  parameter WHERE id=2033 }
insert into parameter(id,type,code,value,isvisible,iseditable,remark,updatetime,updateby,unit)
values(2033,'20','2033',0,1,1,'是否开启指纹报班功能,0：不开启，1：开启',sysdate,0,'是否');
--end
--出站检查登记表  新增菜单

@repeat{SELECT COUNT(*) from  functionreg WHERE id=1223279 }
insert into functionreg (ID, PACKAGENAME, NAME, FUNCTIONKEY, FUNCTIONDESCRIBE, PARAMETERDESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, INSTRUCTION)
values (1223279, 'Outstationcheck.bpl', '出站检查登记表', '{7051F3FB-E600-4ED0-AF1E-C7241EA565F7}', '出站检查登记表', '', sysdate,0, sysdate,0, null);

@repeat{SELECT COUNT(*) from  menu WHERE id=1223280 }
insert into menu (ID, NAME, FUNCTIONREGID, GRADE, ORDERNO, PARENTID, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, CLAZZ, URL, ICON, CLICKNUM)
values (1223280, '出站检查登记表', 1223279, 2, 9.00, 8, '', sysdate,0,sysdate,0, '', '', '', 0);
-- 孙越 2015年6月4日 14:57:35 取票日志查询 新增菜单和功能 --
@repeat{SELECT COUNT(*) from  functionreg WHERE id=60401 }
insert into functionreg (ID, PACKAGENAME, NAME, FUNCTIONKEY, FUNCTIONDESCRIBE, PARAMETERDESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, INSTRUCTION)
values (60401, 'QueryBalanceitem.bpl', '取票日志查询', '{F8699BEC-4720-4F15-876F-8006C014F7D6}', '取票日志查询', '', sysdate, 0, sysdate, 0, '');

@repeat{SELECT COUNT(*) from  menu WHERE id=60401 }
insert into menu (ID, NAME, FUNCTIONREGID, GRADE, ORDERNO, PARENTID, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, CLICKNUM, CLAZZ, URL, ICON)
values (60401, '取票日志查询', 60401, 2, 2.00, 9, '', sysdate, 0, sysdate, 0, 0, '', '', '');

@repeat{SELECT COUNT(*) from  digitaldictionary WHERE id=6041 }
insert into digitaldictionary (ID, NAME, DESCRIBE, TABLENAME, COLUMNNAME, ISCANEDIT, UPDATETIME, UPDATEBY)
values (6041, '取票操作日志状态', ' 取票操作状态: 0取票成功、1取票失败， 取数据字典  ', 'taketicketlog', 'status', 0,sysdate, 0);

@repeat{SELECT COUNT(*) from  digitaldictionarydetail WHERE id=6041 }
insert into digitaldictionarydetail (ID, DIGITALDICTIONARYID, ORDERNO, CODE, VALUE, DESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (6041, 6041, 0, '0', '取票成功', '', sysdate, 0,sysdate, 0);

@repeat{SELECT COUNT(*) from  digitaldictionarydetail WHERE id=6042 }
insert into digitaldictionarydetail (ID, DIGITALDICTIONARYID, ORDERNO, CODE, VALUE, DESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (6042, 6041, 1, '1', '取票失败', '', sysdate, 0,sysdate, 0);
-- end --

--   孙越 2015年6月5日 14:31:37 营收缴款添加参数 -- 
@repeat{SELECT COUNT(*) from  parameter WHERE id=60501 }
insert into parameter (ID, TYPE, CODE, VALUE, ISVISIBLE, ISEDITABLE, REMARK, UPDATETIME, UPDATEBY, UNIT)
values (60501, '40', '4014', '1', 1, 1, '营收缴款,上次欠款是否累计到本期应缴款中，0否，1是，默认为1', sysdate, 0, '是否');
-- end --
--李电志 2015年6月8日 10:54:24 增加IC卡 报班是否修改计划车辆信息 参数控制 0：不修改，1：修改 begin
@repeat{SELECT COUNT(*) from  parameter WHERE id=184 }
insert into parameter
  (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values
  (184, '30', '3034', 1, 1, 1, 'IC卡报班中取消报到是否修改计划车辆信息，0：不修改，1：修改', sysdate , 0, '是否');
@repeat{SELECT COUNT(*) from  parameter WHERE id=185 } 
insert into parameter
  (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values
  (185, '30', '3035', 1, 1, 1, 'IC卡报班的车辆报到中锁座留位参数，0：不修改，1：修改', sysdate , 0, '是否');
  --end
-- 修改营收缴款的参数4003显示问题
@repeat{SELECT COUNT(*)-1 FROM PARAMETER where code='4003'}
update parameter p set remark ='营收缴款的实缴款自动赋值：0，允许、1，不允许' where p.code ='4003';
--   孙越 2015年6月5日 14:31:37 营收缴款添加参数 -- 
@repeat{SELECT COUNT(*) FROM exceptioninfo where id=6111}
insert into exceptioninfo (id,code,msg,modules)
values(6111,'0611','该车站的票价区间段不能交叉,请重新输入!','保险类型票价相关');
-- end -- 

-- 孙越 2015年6月12日 09:53:19 车辆安检费统计表  begin  --
@repeat{SELECT COUNT(*) FROM functionreg where id=61201}
insert into functionreg (ID, PACKAGENAME, NAME, FUNCTIONKEY, FUNCTIONDESCRIBE, PARAMETERDESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, INSTRUCTION)
values (61201, 'Securitycheck.bpl', '车辆安检费统计表', '{304BBD15-6049-442F-86EE-68DB33490C65}', '车辆安检费统计表', '', sysdate, 0, sysdate, 0, null);

@repeat{SELECT COUNT(*) FROM menu where id=61201}
insert into menu (ID, NAME, FUNCTIONREGID, GRADE, ORDERNO, PARENTID, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, CLICKNUM, CLAZZ, URL, ICON)
values (61201, '车辆安检费统计表', 61201, 3, 15.00, 31, '', sysdate, 0, sysdate, 0, 0, '', '', '');
--end --
--李电志  2015年6月12日 18:51:46：增加售团体票是否可修改车票应收的值参数控制，0否，1是，默认为1----
@repeat{SELECT COUNT(*) FROM parameter where id=1059}
insert into parameter
  (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values
  (1059, '10', '1059', 1, 1, 1, '售团体票是否可修改车票应收的值，0否，1是，默认为1', to_date ( '2015-06-12 14:11:34' , 'YYYY-MM-DD HH24:MI:SS' ) , 0, '是否');
--end----
--李电志 2015年6月23日 16:25:22 ：取消并班相关脚本  begin 
@repeat{SELECT COUNT(*) FROM exceptioninfo where id=6112} 
insert into exceptioninfo values(6112,'6112','该班次车票已检，无法取消并班！','取消并班');
@repeat{SELECT COUNT(*) FROM exceptioninfo where id=6113} 
insert into exceptioninfo values(6113,'6113','被并班次座位不为空，无法取消并班！','取消并班');
@repeat{SELECT COUNT(*) FROM exceptioninfo where id=6114} 
insert into exceptioninfo values(6114,'6114','被并班次无被并信息，无法取消并班！','取消并班');
alter table scheduleseats enable row movement;
alter table scheduleseats disable row movement;


 --姜蓥瑞  begin 2015年6月23日  2.14	清分结算标准化 湖北清分结算管理系统实施提出
  @repeat{SELECT COUNT(*)-1 FROM menu where ID=139}
 update menu a set a.name  = '本售异明细表' where a.id= '139';
 @repeat{SELECT COUNT(*)-1 FROM menu where ID=138}
 update menu a set a.name  = '异售本明细表' where a.id= '138';
 @repeat{SELECT COUNT(*)-1 FROM menu where ID=13555}
 update menu a set a.name  = '本售异汇总表' where a.id= '13555';
 @repeat{SELECT COUNT(*)-1 FROM menu where ID=13572}
 update menu a set a.name  = '异售本汇总表' where a.id= '13572';
 @repeat{SELECT COUNT(*)-1 FROM digitaldictionary where ID=52}
 update digitaldictionary a set a.describe = '已售、已退、已废' where a.id = '52';
 @repeat{SELECT COUNT(*)-1 FROM digitaldictionarydetail where ID=265}
 update digitaldictionarydetail a set a.value = '已售' where a.id = '265';
 @repeat{SELECT COUNT(*)-1 FROM digitaldictionarydetail where ID=266}
 update digitaldictionarydetail a set a.value = '已退' where a.id = '266';
 @repeat{SELECT COUNT(*)-1 FROM digitaldictionarydetail where ID=267}
 update digitaldictionarydetail a set a.value = '已废' where a.id = '267';
 --姜蓥瑞   end 2015年6月23日  2.14	清分结算标准化 湖北清分结算管理系统实施提出
--end--
 --begin 姜蓥瑞  begin 2015年6月25日  保险类型票价 基础票价
@repeat{SELECT COUNT(*) FROM EXCEPTIONINFO WHERE ID=9}
INSERT INTO EXCEPTIONINFO (ID,CODE,MSG,MODULES)  VALUES(9,'0009','该停靠点已经添加','添加班次停靠点');
@repeat{SELECT COUNT(*) FROM exceptioninfo where ID=431}
INSERT INTO EXCEPTIONINFO (ID,CODE,MSG,MODULES)  VALUES(431,'0431','分段票价不能交叉','线路票价');
@repeat{SELECT COUNT(*) FROM EXCEPTIONINFO WHERE ID=469}
INSERT INTO EXCEPTIONINFO (ID,CODE,MSG,MODULES)  VALUES(469,'0469','起止时间有交叉，请修改后重试','路线票价');
@repeat{SELECT COUNT(*) FROM EXCEPTIONINFO WHERE ID=516}
INSERT INTO EXCEPTIONINFO (ID,CODE,MSG,MODULES)  values(516,'0516','该车站的票价区间段不能交叉，请重新输入！','保险类型票价');
@repeat{SELECT COUNT(*) FROM MENU WHERE ID=233}
INSERT INTO MENU(ID, NAME, FUNCTIONREGID, GRADE, ORDERNO, PARENTID, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, URL, ICON, CLICKNUM, CLAZZ)
VALUES(233, '保险类型票价', '230', 2, '10.00', 2, null, sysdate, 0, sysdate, 0, null, null, 0, null);
@repeat{SELECT COUNT(*) FROM FUNCTIONREG WHERE ID=230}
INSERT INTO FUNCTIONREG(ID, PACKAGENAME, NAME, FUNCTIONKEY, FUNCTIONDESCRIBE, PARAMETERDESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, INSTRUCTION)
VALUES(230, 'InsuranceTypeFares.bpl', '保险类型票价 ', '{D13DD21F-DA91-46F5-920E-F921A2DEE7A9}', '保险类型票价', null, sysdate, 0, sysdate, 0, null);
--end --begin 姜蓥瑞  begin 2015年6月25日  保险类型票价 基础票价--
--李电志  报班时已有计划车辆是否修改计划车辆信息参数更新  2015年6月26日 16:21:20
@repeat{SELECT COUNT(*)-1 FROM parameter WHERE ID=184}
update parameter p set p.remark = '报班时已有计划车辆是否修改计划车辆信息，0否，1是，默认为0',p.value = '0' where p.id = 184;
@repeat{SELECT COUNT(*)-1 FROM parameter WHERE ID=185}
update parameter p set p.remark = '报到车辆座位数小于班次座位数时是否截掉后面的座位数，0否，1是，默认为1' where p.id = 185;
--end
--张凤娇  2015年7月1日 11:10:46：是否根据票价售保险 0否，1是，默认为1---
@repeat{SELECT COUNT(*) FROM parameter where id=1164800}
 insert into parameter (ID, TYPE, CODE, VALUE, ISVISIBLE, ISEDITABLE, REMARK, UPDATETIME, UPDATEBY, UNIT)
values (1164800, '10', '1060', '1', 1, 1, '是否根据票价售保险 0:否 1：是', sysdate, 0, '是否');
--begin 孟健 20150702 BUG #4837 参数设置—1010、1022是否售保险默认不可编辑，请改为默认可编辑
@repeat{SELECT COUNT(*)-1 FROM parameter WHERE code=1010}
update parameter p set p.iseditable = 1 where p.code = 1010;
@repeat{SELECT COUNT(*)-1 FROM parameter WHERE code=1022}
update parameter p set p.iseditable = 1 where p.code = 1022;
--end
--begin 杨志文 报班时异常提示信息   2015年7月3日
@repeat{SELECT COUNT(*) FROM EXCEPTIONINFO WHERE ID=400}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values (400, '0400', '该车辆行驶证、责任险、强险、营运证日期未设置完整，请先设置有效日期！', '车辆安检');
--end
--begin 李电志  2015年7月3日 09:26:28 修改1060参数、增加3036参数
@repeat{SELECT COUNT(*)-1 FROM parameter WHERE code=1060}
update parameter p set p.remark = '保险费是根据里程还是根据票价设置，0里程，1票价' where p.id = 1164800;
@repeat{SELECT COUNT(*)-1 FROM parameter WHERE ID=60501}
update parameter p set p.remark = '售票员营收缴款，上次欠款是否累计到本期应缴款中，0否，1是，默认为1' where p.id = 60501;
@repeat{SELECT COUNT(*) FROM parameter where id=1164811}
insert into parameter (ID, TYPE, CODE, VALUE, ISVISIBLE, ISEDITABLE, REMARK, UPDATETIME, UPDATEBY, UNIT)
values (1164811, '30', '3036', '1', 1, 1, '检票时扫描的票号所属班次跟当前选中班次不一致时，是否允许检票，0否，1是，默认为0', sysdate, 1, ''); 
--end

--车辆安检打印安检合格通知单打印模板增加行驶证，运输证
@repeat{SELECT COUNT(*) from  printtemplatetype WHERE id=6224 }
insert into printtemplatetype (ID, NAME) values (6224, '安检合格通知单');
@repeat{SELECT COUNT(*) from  printtemplatetypeitem WHERE id=100000 }
INSERT INTO PRINTTEMPLATETYPEITEM(ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
VALUES(100000, 6224, '行驶证', 0, 'driverlicense', 0);
@repeat{SELECT COUNT(*) from  printtemplatetypeitem WHERE id=100001 }
INSERT INTO PRINTTEMPLATETYPEITEM(ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
VALUES(100001, 6224, '运输证', 0, 'workno', 0);

--begin 驾驶员非本车驾驶员是否允许安检通过
@repeat{SELECT COUNT(*) FROM Parameter where code = '6027'}
insert into Parameter (ID, TYPE, CODE, VALUE, ISVISIBLE, ISEDITABLE, REMARK, UPDATETIME, UPDATEBY, UNIT)
values (1259612, '10', '6027', '1', 1, 1, '驾驶员非本车驾驶员是否允许安检通过，1允许、0不允许，默认为1', sysdate, 1158013, '是否');
--end
