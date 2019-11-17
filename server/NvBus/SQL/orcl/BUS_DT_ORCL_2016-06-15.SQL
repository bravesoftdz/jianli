-- 2016年6月6日 09:56:24 tianhb 添加菜单 begin --
@repeat{SELECT count(*) FROM functionreg where id = 408}
insert into functionreg (ID, PACKAGENAME, NAME, FUNCTIONKEY, FUNCTIONDESCRIBE, PARAMETERDESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, INSTRUCTION)
values (408, 'DepartinvoicesotherTicketno.bpl', '结算单补录(票号)', '{58140F1E-2904-4A85-AF40-8F0C26DE8259}', '结算单补录(票号)', '',sysdate, 0, sysdate, 0, null);
@repeat{SELECT count(*) FROM menu where id = 408}
insert into menu (ID, NAME, FUNCTIONREGID, GRADE, ORDERNO, PARENTID, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, CLICKNUM, CLAZZ, URL, ICON, SYSTYPE, MENUTYPE)
values (408, '结算单补录(票号)', 408, 2, 5.00, 8, null, sysdate, 0, sysdate, 0, 0, null, null, null, '0', '1');
--end--

@repeat{SELECT count(*) FROM parameter where id = 20163000}
insert into parameter (ID, TYPE, CODE, VALUE, ISVISIBLE, ISEDITABLE, REMARK, UPDATETIME, UPDATEBY, UNIT)
values (20163000, '00', '0030', '0', 1, 1, '是否启用证件核查（林东）,0不启用(原逻辑),1启用(IC卡报班时,关闭指纹报班功能,驾乘人员指纹输入,并且校验司乘人员进站检查/证件核查/安全学习情况,需要2033参数开启),默认为0',sysdate, 0, '是否');