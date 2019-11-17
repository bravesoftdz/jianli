@repeat{SELECT COUNT(*) FROM functionpermissionreg WHERE id=1010}
insert into functionpermissionreg values(1010,13,'原票号重打他人车票','{ABB9C812-710D-4037-948C-0B925BBE1F47}','',sysdate,0,sysdate,0);
@repeat{SELECT COUNT(*) FROM functionpermissionreg WHERE id=1011}
insert into functionpermissionreg values(1011,13,'换票号重打他人车票','{CCF8DE9B-3AE5-4518-8713-36C73166CE6B}','',sysdate,0,sysdate,0);

--begin 2017-03-02 yeqiming 自助发班增加发班打印权限按钮
@repeat{SELECT COUNT(*) FROM functionpermissionreg WHERE id=1012}
insert into functionpermissionreg values(1012,519,'发班打印','{BF1F07F5-B615-4147-A0EF-CF624DD650E8}','',sysdate,0,sysdate,0);
--end 2017-03-02 yeqiming 自助发班增加发班打印权限按钮

--begin孙越 2017年3月27日 11:15:46 --
@repeat{SELECT COUNT(*) FROM functionreg where id=17032701 }
insert into functionreg (ID, PACKAGENAME, NAME, FUNCTIONKEY, FUNCTIONDESCRIBE, PARAMETERDESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (17032701, 'CustomerBuyTicketSituation.bpl', '旅客购票情况统计', '{0E737AAE-E961-45AA-A2D5-79851DD50091}', '旅客购票情况统计', null, sysdate, '0',sysdate, '0');
@repeat{SELECT COUNT(*) FROM menu where id=17032701 }
insert into menu (ID, NAME, FUNCTIONREGID, GRADE, ORDERNO, PARENTID, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, CLICKNUM, CLAZZ, URL, ICON, SYSTYPE, MENUTYPE)
values (17032701, '旅客购票情况统计', 17032701, 3, 33.00, 300, null, sysdate, 0, sysdate, 0, 0, null, null, null, '0', '1');
--end--

--begin maxiao 2017年3月31日 11:15:46 --
@repeat{SELECT COUNT(*) FROM functionpermissionreg where id=411655 }
insert into functionpermissionreg (ID, FUNCTIONREGID, PERMISSIONNAME, PERMISSIONKEY, PERMISSIONDESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (411655, 98, '身份证信息是否显示全部', '{D5D6855E-FBF8-4CB6-BF8C-B198C1169769}', '', sysdate, 0, sysdate, 0);
@repeat{SELECT COUNT(*) FROM functionpermissionreg where id=411657 }
insert into functionpermissionreg (ID, FUNCTIONREGID, PERMISSIONNAME, PERMISSIONKEY, PERMISSIONDESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (411657, 85, '删除按钮权限', '{F1A6D504-7E1D-479B-B295-4821B3332786}', '', sysdate, 0, sysdate, 0);
@repeat{SELECT COUNT(*) FROM functionpermissionreg where id=411656 }
insert into functionpermissionreg (ID, FUNCTIONREGID, PERMISSIONNAME, PERMISSIONKEY, PERMISSIONDESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (411656, 145, '身份证信息是否显示全部', '{C274233F-954C-45D1-BF63-A974D9366CF9}', '', sysdate, 0, sysdate, 0);
@repeat{SELECT COUNT(*) FROM functionpermissionreg where id=411658 }
insert into functionpermissionreg (ID, FUNCTIONREGID, PERMISSIONNAME, PERMISSIONKEY, PERMISSIONDESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (411658, 80, '添加', '{4B878C87-242F-402D-9994-7B4C7F6E65DD}', '', sysdate, 0, sysdate, 0);
@repeat{SELECT COUNT(*) FROM functionpermissionreg where id=411659 }
insert into functionpermissionreg (ID, FUNCTIONREGID, PERMISSIONNAME, PERMISSIONKEY, PERMISSIONDESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (411659, 80, '修改', '{C1CC4C7C-7904-4AA5-A77D-290F63B47A92}', '', sysdate, 0, sysdate, 0);
@repeat{SELECT COUNT(*) FROM functionpermissionreg where id=411660 }
insert into functionpermissionreg (ID, FUNCTIONREGID, PERMISSIONNAME, PERMISSIONKEY, PERMISSIONDESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (411660, 80, '删除', '{0A5A8C39-BFA4-4238-8B43-EF191AB2CF71}', '', sysdate, 0, sysdate, 0);
@repeat{SELECT COUNT(*) FROM functionpermissionreg where id=411661 }
insert into functionpermissionreg (ID, FUNCTIONREGID, PERMISSIONNAME, PERMISSIONKEY, PERMISSIONDESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (411661, 80, '导出excel', '{D513BB80-C8F3-4903-A836-DC27E0AA1059}', '', sysdate, 0, sysdate, 0);
@repeat{SELECT COUNT(*) FROM functionpermissionreg where id=411662 }
insert into functionpermissionreg (ID, FUNCTIONREGID, PERMISSIONNAME, PERMISSIONKEY, PERMISSIONDESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (411662, 80, '打印', '{39F011C1-4AB7-4053-A56A-42E82EDE800A}', '', sysdate, 0, sysdate, 0);
@repeat{SELECT COUNT(*) FROM functionpermissionreg where id=411663 }
insert into functionpermissionreg (ID, FUNCTIONREGID, PERMISSIONNAME, PERMISSIONKEY, PERMISSIONDESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (411663, 80, '身份证信息是否显示全部', '{EBB2B7AF-64C0-4C77-B029-01CD3ABC2610}', '', sysdate, 0, sysdate, 0);
--end--
--begin 孙越 2017年3月28日 15:10:16 添加按钮权限--
@repeat{SELECT COUNT(*) FROM functionpermissionreg where id=17032801 }
insert into functionpermissionreg t (id, functionregid, permissionname, permissionkey, permissiondescribe, createtime, createby, updatetime, updateby )
values(17032801,36,'登记他人票据','{FAEC8175-9C13-4FD5-B771-F1CEC36665F8}','登记他人票据',sysdate,0,sysdate,0);
@repeat{SELECT COUNT(*) FROM functionpermissionreg where id=17032802 }
insert into functionpermissionreg t (id, functionregid, permissionname, permissionkey, permissiondescribe, createtime, createby, updatetime, updateby )
values(17032802,36,'登记之前坏票','{1F46D72F-4578-4096-A009-6CD221612C06}','登记之前坏票',sysdate,0,sysdate,0);
--end--

--更新9898参数默认是0
@repeat{SELECT COUNT(*) FROM parameter where id=0 }
update   parameter t set t.value='0'  where t.code='9898';
@repeat{SELECT COUNT(*) FROM parameter where id=0 }
update   parameterorgdetail t set t.value='0' where t.parameterid=9898;

@repeat{SELECT 1-COUNT(*) FROM menu where name like '%网售机构不可售班次控制%' }
delete from menupermission t where t.menuid in (select id from menu where name like '%网售机构不可售班次控制%');
@repeat{SELECT 1-COUNT(*) FROM menu where name like '%网售机构不可售班次控制%' }
delete from menu where name like '%网售机构不可售班次控制%';

--add by tianhb-begin 2017年4月28日 结算单模板增加打印方式(补录单子打印时显示补录字样)
@repeat{SELECT COUNT(*) FROM printtemplatetypeitem where id=410 }
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (410, 4, '打印方式', '0', 'printway', 0);
--add by tianhb-end 2017年4月28日 结算单模板增加打印方式(补录单子打印时显示补录字样)
--begin 孙越  2017年5月8日 10:33:33 增加打印项 --
@repeat{SELECT COUNT(*) FROM printtemplatetypeitem where id=17050801 }
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (17050801, 1, '改签原票号', '0', 'oldticketno', 0);
@repeat{SELECT COUNT(*) FROM printtemplatetypeitem where id=17050802 }
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (17050802, 1, '改签原班次号', '0', 'oldschedulecode', 0);
--end--

--begin 孙越 2017年5月24日 10:55:49 增加权限 --
@repeat{SELECT COUNT(*) FROM functionpermissionreg where id=17052401 }
insert into functionpermissionreg (ID, FUNCTIONREGID, PERMISSIONNAME, PERMISSIONKEY, PERMISSIONDESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (17052401, 98, '打印权限', '{7A89423F-9747-4C53-9114-1EAA4F55D67F}', '', sysdate, 0, sysdate, 0);

@repeat{SELECT COUNT(*) FROM functionpermissionreg where id=17052402 }
insert into functionpermissionreg (ID, FUNCTIONREGID, PERMISSIONNAME, PERMISSIONKEY, PERMISSIONDESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (17052402, 98, '导出Excel权限', '{9BD7A68A-6BD8-44E5-BA38-69EF267126F6}', '', sysdate, 0, sysdate, 0);

@repeat{SELECT COUNT(*) FROM functionpermissionreg where id=17052403 }
insert into functionpermissionreg (ID, FUNCTIONREGID, PERMISSIONNAME, PERMISSIONKEY, PERMISSIONDESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (17052403, 145, '打印权限', '{35C8EB7F-35CF-4695-B2CF-35E9EEF98E1A}', '', sysdate, 0, sysdate, 0);

@repeat{SELECT COUNT(*) FROM functionpermissionreg where id=17052404 }
insert into functionpermissionreg (ID, FUNCTIONREGID, PERMISSIONNAME, PERMISSIONKEY, PERMISSIONDESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (17052404, 145, '导出Excel权限', '{1B2D3614-6FDD-4ADF-B083-22A1A1B3FCE2}', '', sysdate, 0, sysdate, 0);
--end--