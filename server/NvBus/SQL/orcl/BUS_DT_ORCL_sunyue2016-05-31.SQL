-- 2016年5月31日 09:56:24 孙越 添加菜单 begin --
@repeat{SELECT count(*) FROM functionreg where id = 16052301}
insert into functionreg (ID, PACKAGENAME, NAME, FUNCTIONKEY, FUNCTIONDESCRIBE, PARAMETERDESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, INSTRUCTION)
values (16052301, 'TicketUseDetail.bpl', '票证使用明细表', '{8D1CA4E9-C702-439E-9692-26D4B509224B}', '票证使用明细表', '',sysdate, 0, sysdate, 0, null);
@repeat{SELECT count(*) FROM menu where id = 16052301}
insert into menu (ID, NAME, FUNCTIONREGID, GRADE, ORDERNO, PARENTID, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, CLICKNUM, CLAZZ, URL, ICON, SYSTYPE, MENUTYPE)
values (16052301, '票证使用明细表', 16052301, 3, 6.00, 18500, null, sysdate, 0, sysdate, 0, 0, null, null, null, '0', '1');
--end--