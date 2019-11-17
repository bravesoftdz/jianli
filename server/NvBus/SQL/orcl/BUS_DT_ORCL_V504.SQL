
----20150703 基于HTML的报表功能注册 
@repeat{SELECT COUNT(*) FROM functionreg where functionkey = '{272AF9DD-A82C-4357-8BEB-31460DAE10D3}' or id = 100100 }
INSERT INTO FUNCTIONREG (ID, PACKAGENAME, NAME, FUNCTIONKEY, FUNCTIONDESCRIBE, PARAMETERDESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, INSTRUCTION) VALUES (100100, 'PublicQry.bpl', '公共查询模块', '{272AF9DD-A82C-4357-8BEB-31460DAE10D3}', '公共查询模块', null, sysdate, 0, sysdate, 0, null);
--新增安检明日车辆参数 20150706 liyi
@repeat{SELECT COUNT(*) FROM parameter where code='6025' }
insert into parameter (ID, TYPE, CODE, VALUE, ISVISIBLE, ISEDITABLE, REMARK, UPDATETIME, UPDATEBY, UNIT)
values (601, '60', '6025', '05:00:00', 1, 1, '安检明日车辆时间，格式如下：06:00:00', sysdate,0, '时间');

--稽查管理改为出站检查登记表 张凤娇
@repeat{SELECT COUNT(*)-1 FROM menu where ID =461}
update menu set name='出站检查登记表' where id=461;
@repeat{SELECT COUNT(*) FROM functionreg where name='出站检查登记表'}
update functionreg set name='出站检查登记表' where id=510;
--售票情况查询，放开售票时间限制，通过参数控制，当前默认为31天  20150708 liyi
@repeat{SELECT COUNT(*) FROM parameter where code='0026' }
insert into parameter (ID, TYPE, CODE, VALUE, ISVISIBLE, ISEDITABLE, REMARK, UPDATETIME, UPDATEBY, UNIT)
values (288, '00', '0026', '15', 1, 1, '售票情况查询：售票日期最大可查询天数', sysdate,0, '天');
--20150710 liyi  新增安检项目检查不合格项目脚本
@repeat{SELECT COUNT(*) FROM Securitycheckitem where ID='42078' }
insert into Securitycheckitem (ID, CATEGORYCODE, NAME, DESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, ISROUTINECHECK)
values (42078, '0', '外观', '烤漆大量脱落', sysdate, 1, sysdate,0, 1);
@repeat{SELECT COUNT(*) FROM Securitycheckitem where ID='63624' }
insert into Securitycheckitem (ID, CATEGORYCODE, NAME, DESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, ISROUTINECHECK)
values (63624, '1', '指示灯', '指示灯故障', sysdate,0, sysdate,0, 0);
@repeat{SELECT COUNT(*) FROM Securitycheckitem where ID='63625' }
insert into Securitycheckitem (ID, CATEGORYCODE, NAME, DESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, ISROUTINECHECK)
values (63625, '2', '传动系统', '传动系统故障', sysdate,0, sysdate,0, 0);
@repeat{SELECT COUNT(*) FROM Securitycheckitem where ID='63251' }
insert into Securitycheckitem (ID, CATEGORYCODE, NAME, DESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, ISROUTINECHECK)
values (63251, '1', '照明', '照明故障', sysdate,0, sysdate,0, 0);
@repeat{SELECT COUNT(*) FROM Securitycheckitem where ID='63252' }
insert into Securitycheckitem (ID, CATEGORYCODE, NAME, DESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, ISROUTINECHECK)
values (63252, '4', '直拉杆', '前球头松旷', sysdate,0, sysdate,0, 1);
@repeat{SELECT COUNT(*) FROM Securitycheckitem where ID='63253' }
insert into Securitycheckitem (ID, CATEGORYCODE, NAME, DESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, ISROUTINECHECK)
values (63253, '3', '制动系统', '制动系统故障', sysdate,0, sysdate,0, 0);
@repeat{SELECT COUNT(*) FROM Securitycheckitem where ID='63627' }
insert into Securitycheckitem (ID, CATEGORYCODE, NAME, DESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, ISROUTINECHECK)
values (63627, '7', '证件', '驾驶证无', sysdate,0, sysdate,0, 0);
@repeat{SELECT COUNT(*) FROM Securitycheckitem where ID='65848' }
insert into Securitycheckitem (ID, CATEGORYCODE, NAME, DESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, ISROUTINECHECK)
values (65848, '5', '左转向轮', '左转向轮花纹小于3.2', sysdate,0, sysdate,0, 1);
@repeat{SELECT COUNT(*) FROM Securitycheckitem where ID='65858' }
insert into Securitycheckitem (ID, CATEGORYCODE, NAME, DESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, ISROUTINECHECK)
values (65858, '6', '悬架', '钢板断裂',sysdate,0,sysdate,0, 1);
@repeat{SELECT COUNT(*) FROM Securitycheckitem where ID='89382' }
insert into Securitycheckitem (ID, CATEGORYCODE, NAME, DESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, ISROUTINECHECK)
values (89382, '7', '证件3', '道路运输证无', sysdate,0, sysdate,0, 0);
@repeat{SELECT COUNT(*) FROM Securitycheckitem where ID='87602' }
insert into Securitycheckitem (ID, CATEGORYCODE, NAME, DESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, ISROUTINECHECK)
values (87602, '10', 'GPS', '2G不在线', sysdate, 0, sysdate,0, 0);
@repeat{SELECT COUNT(*) FROM Securitycheckitem where ID='87603' }
insert into Securitycheckitem (ID, CATEGORYCODE, NAME, DESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, ISROUTINECHECK)
values (87603, '10', 'GPS1', '3G不在线', sysdate, 0, sysdate,0, 0);
@repeat{SELECT COUNT(*) FROM Securitycheckitem where ID='65859' }
insert into Securitycheckitem (ID, CATEGORYCODE, NAME, DESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, ISROUTINECHECK)
values (65859, '6', '悬架1', '钢板U形卡断裂', sysdate,0, sysdate,0, 1);
@repeat{SELECT COUNT(*) FROM Securitycheckitem where ID='65831' }
insert into Securitycheckitem (ID, CATEGORYCODE, NAME, DESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, ISROUTINECHECK)
values (65831, '5', '内轮胎', '内轮胎花纹小于1.6', sysdate,0, sysdate,0, 1);
@repeat{SELECT COUNT(*) FROM Securitycheckitem where ID='65853' }
insert into Securitycheckitem (ID, CATEGORYCODE, NAME, DESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, ISROUTINECHECK)
values (65853, '5', '外轮胎', '外轮胎花纹小于1.6', sysdate,0, sysdate,0, 1);
@repeat{SELECT COUNT(*) FROM Securitycheckitem where ID='65854' }
insert into Securitycheckitem (ID, CATEGORYCODE, NAME, DESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, ISROUTINECHECK)
values (65854, '5', '右转向轮', '右转向轮花纹小于3.2', sysdate,0, sysdate,0, 1);
@repeat{SELECT COUNT(*) FROM Securitycheckitem where ID='65855' }
insert into Securitycheckitem (ID, CATEGORYCODE, NAME, DESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, ISROUTINECHECK)
values (65855, '4', '直拉杆1', '后球头松旷', sysdate,0, sysdate,0, 1);
@repeat{SELECT COUNT(*) FROM Securitycheckitem where ID='65856' }
insert into Securitycheckitem (ID, CATEGORYCODE, NAME, DESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, ISROUTINECHECK)
values (65856, '4', '横拉杆', '左球头松旷', sysdate,0, sysdate,0, 1);
@repeat{SELECT COUNT(*) FROM Securitycheckitem where ID='65857' }
insert into Securitycheckitem (ID, CATEGORYCODE, NAME, DESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, ISROUTINECHECK)
values (65857, '4', '横拉杆1', '右球头松旷', sysdate,0, sysdate,0, 1);
@repeat{SELECT COUNT(*) FROM Securitycheckitem where ID='65860' }
insert into Securitycheckitem (ID, CATEGORYCODE, NAME, DESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, ISROUTINECHECK)
values (65860, '3', '制动管路', '制动管路漏气', sysdate,0, sysdate,0, 1);
@repeat{SELECT COUNT(*) FROM Securitycheckitem where ID='89377' }
insert into Securitycheckitem (ID, CATEGORYCODE, NAME, DESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, ISROUTINECHECK)
values (89377, '7', '证件1', '从业资格证无', sysdate,0, sysdate,0, 0);
@repeat{SELECT COUNT(*) FROM Securitycheckitem where ID='89380' }
insert into Securitycheckitem (ID, CATEGORYCODE, NAME, DESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, ISROUTINECHECK)
values (89380, '7', '证件2', '行驶证无', sysdate,0, sysdate,0, 0);
@repeat{SELECT COUNT(*) FROM Securitycheckitem where ID='89384' }
insert into Securitycheckitem (ID, CATEGORYCODE, NAME, DESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, ISROUTINECHECK)
values (89384, '7', '证件4', '线路标志牌无', sysdate,0, sysdate,0, 0);
@repeat{SELECT COUNT(*) FROM Securitycheckitem where ID='89387' }
insert into Securitycheckitem (ID, CATEGORYCODE, NAME, DESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, ISROUTINECHECK)
values (89387, '7', '证件5', '线路标志牌过期', sysdate,0, sysdate,0, 0);
@repeat{SELECT COUNT(*) FROM Securitycheckitem where ID='1172524' }
insert into Securitycheckitem (ID, CATEGORYCODE, NAME, DESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, ISROUTINECHECK)
values (1172524, '9', '随车安全设备部分', '随车安全设备部分', sysdate,0, sysdate,0, 0);
@repeat{SELECT COUNT(*) FROM Securitycheckitem where ID='1172548' }
insert into Securitycheckitem (ID, CATEGORYCODE, NAME, DESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, ISROUTINECHECK)
values (1172548, '8', '其他部分', '其他部分', sysdate,0, sysdate,0, 0);

--end--


--插入行包收讫打印模板 代金岩 2015年7月11日 14:55:15
@repeat{SELECT COUNT(*) FROM printtemplate where ID='64002' }
insert into printtemplate (ID, PRINTTEMPLATETYPEID, NAME, HEIGHT, HEIGHTCORRECTION, WIDTH, LEFTMARGIN, TOP, BACKGROUNDIMAGE, ROWSPACE, ROWPERPAGE, PRINTERNAME, COLUMNSPERPAGE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (64002, 7, '到货收讫单', 760, 760, 1860, 0, 0, '', 50, 5, '', 1, sysdate, 0,sysdate,0);
@repeat{SELECT COUNT(*) FROM printtemplateitem where ID='64008' }
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (64008, 64002, 161, '包装方式', 1, '宋体', 11.0000, 534, 841, 159, 40, '2', '',sysdate, 0,sysdate,0);
@repeat{SELECT COUNT(*) FROM printtemplateitem where ID='64010' }
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (64010, 64002, 162, '发货站', 1, '宋体', 11.0000, 294, 376, 119, 40, '2', '',sysdate,0,sysdate,0);
@repeat{SELECT COUNT(*) FROM printtemplateitem where ID='64018' }
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (64018, 64002, 166, '车牌号', 1, '宋体', 11.0000, 294, 590, 119, 40, '2', '', sysdate, 0,sysdate,0);
@repeat{SELECT COUNT(*) FROM printtemplateitem where ID='64020' }
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (64020, 64002, 167, '发货日期', 1, '宋体', 11.0000, 294, 77, 159, 40, '5', 'yyyy-mm-dd',sysdate,0,sysdate,0);
@repeat{SELECT COUNT(*) FROM printtemplateitem where ID='64028' }
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (64028, 64002, 171, '件数', 1, '宋体', 11.0000, 534, 648, 79, 40, '2', '',sysdate,0,sysdate,0);
@repeat{SELECT COUNT(*) FROM printtemplateitem where ID='64096' }
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (64096, 64002, 190, '收货人电话', 1, '宋体', 12.0000, 534, 307, 212, 42, '2', '',sysdate,0,sysdate,0);
@repeat{SELECT COUNT(*) FROM printtemplateitem where ID='64097' }
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (64097, 64002, 150, '票号', 1, '宋体', 12.0000, 534, 1228, 85, 42, '2', '',sysdate,0,sysdate,0);
@repeat{SELECT COUNT(*) FROM printtemplateitem where ID='64098' }
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (64098, 64002, 338, '转运至', 1, '宋体', 12.0000, 294, 1270, 127, 42, '2', '',sysdate,0,sysdate,0);
@repeat{SELECT COUNT(*) FROM printtemplateitem where ID='64099' }
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (64099, 64002, 339, '存放地', 1, '宋体', 12.0000, 534, 1032, 127, 42, '2', '',sysdate,0,sysdate,0);
@repeat{SELECT COUNT(*) FROM printtemplateitem where ID='64036' }
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (64036, 64002, 175, '代收运费', 1, '宋体', 11.0000, 294, 847, 159, 40, '2', '',sysdate,0,sysdate,0);
@repeat{SELECT COUNT(*) FROM printtemplateitem where ID='64100' }
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (64100, 64002, 170, '收讫人', 1, '宋体', 12.0000, 294, 1474, 127, 42, '2', '',sysdate,0,sysdate,0);
@repeat{SELECT COUNT(*) FROM printtemplateitem where ID='64056' }
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (64056, 64002, 185, '代收货款', 1, '宋体', 11.0000, 294, 1080, 159, 40, '2', '',sysdate,0,sysdate,0);
@repeat{SELECT COUNT(*) FROM printtemplateitem where ID='64064' }
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (64064, 64002, 189, '收货人', 1, '宋体', 11.0000, 534, 111, 119, 40, '2', '',sysdate,0,sysdate,0);
@repeat{SELECT COUNT(*) FROM printtemplateitem where ID='64065' }
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (64065, 64002, -1, '收货人电话:', 1, '宋体', 11.0000, 1040, 0, 220, 40, '1', '',sysdate,0,sysdate,0);
@repeat{SELECT COUNT(*) FROM printtemplateitem where ID='64066' }
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (64066, 64002, 190, '收货人电话', 1, '宋体', 11.0000, 1040, 280, 198, 40, '2', '', sysdate, 0,sysdate,0);
@repeat{SELECT COUNT(*) FROM printtemplateitem where ID='64067' }
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (64067, 64002, -1, '收货人地址:', 1, '宋体', 11.0000, 1040, 521, 220, 40, '1', '', sysdate,0,sysdate,0);
@repeat{SELECT COUNT(*) FROM printtemplateitem where ID='64068' }
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (64068, 64002, 191, '收货人地址', 1, '宋体', 11.0000, 1119, 0, 198, 40, '2', '', sysdate,0,sysdate,0);
@repeat{SELECT COUNT(*) FROM printtemplateitem where ID='64069' }
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (64069, 64002, -1, '证件类型:', 1, '宋体', 11.0000, 1119, 241, 180, 40, '1', '', sysdate,0,sysdate,0);
@repeat{SELECT COUNT(*) FROM printtemplateitem where ID='64070' }
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (64070, 64002, 192, '证件类型', 1, '宋体', 11.0000, 1119, 479, 159, 40, '2', '', sysdate,0,sysdate,0);
@repeat{SELECT COUNT(*) FROM printtemplateitem where ID='64071' }
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (64071, 64002, -1, '证件号码:', 1, '宋体', 11.0000, 1119, 680, 180, 40, '1', '', sysdate,0,sysdate,0);
@repeat{SELECT COUNT(*) FROM printtemplateitem where ID='64072' }
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (64072, 64002, 193, '证件号码', 1, '宋体', 11.0000, 1201, 0, 159, 40, '2', '', sysdate,0,sysdate,0);
@repeat{SELECT COUNT(*) FROM printtemplateitem where ID='64073' }
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (64073, 64002, -1, '托运方式:', 1, '宋体', 11.0000, 1201, 201, 180, 40, '1', '', sysdate,0,sysdate,0);
@repeat{SELECT COUNT(*) FROM printtemplateitem where ID='64074' }
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (64074, 64002, 194, '托运方式', 1, '宋体', 11.0000, 1201, 439, 159, 40, '2', '', sysdate,0,sysdate,0);
@repeat{SELECT COUNT(*) FROM printtemplateitem where ID='64075' }
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (64075, 64002, -1, '付款方式:', 1, '宋体', 11.0000, 1201, 640, 180, 40, '1', '', sysdate,0,sysdate,0);
@repeat{SELECT COUNT(*) FROM printtemplateitem where ID='64076' }
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (64076, 64002, 195, '付款方式', 1, '宋体', 11.0000, 1281, 0, 159, 40, '2', '', sysdate,0,sysdate,0);
@repeat{SELECT COUNT(*) FROM printtemplateitem where ID='64077' }
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (64077, 64002, -1, '是否贵重物品:', 1, '宋体', 11.0000, 1281, 201, 259, 40, '1', '', sysdate,0,sysdate,0);
@repeat{SELECT COUNT(*) FROM printtemplateitem where ID='64078' }
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (64078, 64002, 196, '是否贵重物品', 1, '宋体', 11.0000, 1281, 521, 238, 40, '2', '', sysdate,0,sysdate,0);
@repeat{SELECT COUNT(*) FROM printtemplateitem where ID='64079' }
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (64079, 64002, -1, '打印时间:', 1, '宋体', 11.0000, 1360, 0, 180, 40, '1', '', sysdate,0,sysdate,0);
@repeat{SELECT COUNT(*) FROM printtemplateitem where ID='64080' }
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (64080, 64002, 197, '打印时间', 1, '宋体', 11.0000, 1360, 241, 159, 40, '2', '', sysdate,0,sysdate,0);
@repeat{SELECT COUNT(*) FROM printtemplateitem where ID='64081' }
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (64081, 64002, -1, '货物描述:', 1, '宋体', 11.0000, 1360, 439, 180, 40, '1', '', sysdate,0,sysdate,0);
@repeat{SELECT COUNT(*) FROM printtemplateitem where ID='64082' }
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (64082, 64002, 198, '货物描述', 1, '宋体', 11.0000, 1360, 680, 159, 40, '2', '', sysdate,0,sysdate,0);
@repeat{SELECT COUNT(*) FROM printtemplateitem where ID='64083' }
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (64083, 64002, -1, '受理时间:', 1, '宋体', 11.0000, 1439, 0, 180, 40, '1', '', sysdate,0,sysdate,0);
@repeat{SELECT COUNT(*) FROM printtemplateitem where ID='64084' }
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (64084, 64002, 199, '受理时间', 1, '宋体', 11.0000, 1439, 241, 159, 40, '2', '', sysdate,0,sysdate,0);
@repeat{SELECT COUNT(*) FROM printtemplateitem where ID='64085' }
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (64085, 64002, -1, '总收费:', 1, '宋体', 11.0000, 1439, 439, 140, 40, '1', '', sysdate,0,sysdate,0);
@repeat{SELECT COUNT(*) FROM printtemplateitem where ID='64086' }
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (64086, 64002, 334, '总收费', 1, '宋体', 11.0000, 1439, 640, 119, 40, '2', '', sysdate,0,sysdate,0);
--end--


--增加前台明细菜单 代金岩 2015年7月11日 16:55:15
@repeat{SELECT COUNT(*) FROM functionreg where functionkey = '{F7812D63-B29C-44EB-AD29-939A74B1E351}' or ID='1223280' }
insert into functionreg (ID, PACKAGENAME, NAME, FUNCTIONKEY, FUNCTIONDESCRIBE, PARAMETERDESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, INSTRUCTION)
values (1223280, 'QueryPackDetails.bpl', '前台明细统计', '{F7812D63-B29C-44EB-AD29-939A74B1E351}', '前台明细', '', sysdate, 0,sysdate, 0, '');
@repeat{SELECT COUNT(*)-1 FROM menu where ID =190}
update menu set functionregid='1223280' where id = '190';
--end--

@repeat{SELECT COUNT(*) FROM menu where ID =461 or name='出站检查登记表'}
insert into menu
  (id, name, functionregid, grade, orderno, parentid, parameter, createtime, createby, updatetime, updateby, clicknum, systype, menutype)
values
  (461, '出站检查登记表', 1223279, 2, 9.00, 8, '', sysdate, 0, sysdate, 0,0,'0','1');


--2015/07/11 赵怀虎  增加  行包签发单--货物结算单  打印模板  begin--
@repeat{SELECT COUNT(*) FROM printtemplate where ID=57578 }
insert into printtemplate (ID, PRINTTEMPLATETYPEID, NAME, HEIGHT, HEIGHTCORRECTION, WIDTH, LEFTMARGIN, TOP, BACKGROUNDIMAGE, ROWSPACE, ROWPERPAGE, PRINTERNAME, COLUMNSPERPAGE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (57578, 18, '货物结算单', 1510, 940, 940, 0, 0, '', 50, 4, '', 1, SYSDATE,0, SYSDATE,0);
@repeat{SELECT COUNT(*) FROM printtemplateitem where ID=60466 }
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (60466, 57578, 227, '托运单号', 1, '宋体', 12.0000, 331, 185, 169, 42, '2', '', SYSDATE,0, SYSDATE,0);
@repeat{SELECT COUNT(*) FROM printtemplateitem where ID=60530 }
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (60530, 57578, -1, 'No:', 1, '宋体', 12.0000, 680, 1053, 64, 42, '1', '', SYSDATE,0, SYSDATE,0);
@repeat{SELECT COUNT(*) FROM printtemplateitem where ID=66428 }
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (66428, 57578, 1117041, '结算金额', 1, '宋体', 12.0000, 331, 738, 177, 40, '2', '', SYSDATE,0, SYSDATE,0);
@repeat{SELECT COUNT(*) FROM printtemplateitem where ID=66429 }
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (66429, 57578, 1117040, '结算总金额', 1, '宋体', 12.0000, 680, 574, 212, 42, '7', '', SYSDATE,0, SYSDATE,0);
@repeat{SELECT COUNT(*) FROM printtemplateitem where ID=59441 }
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (59441, 57578, 218, '车牌号码', 1, '宋体', 12.0000, 193, 175, 169, 42, '2', '', SYSDATE,0, SYSDATE,0);
@repeat{SELECT COUNT(*) FROM printtemplateitem where ID=59442 }
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (59442, 57578, 224, '营运单位', 1, '宋体', 12.0000, 193, 534, 169, 42, '2', '', SYSDATE,0, SYSDATE,0);
@repeat{SELECT COUNT(*) FROM printtemplateitem where ID=59443 }
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (59443, 57578, 217, '班次号', 1, '宋体', 12.0000, 193, 915, 127, 42, '2', '', SYSDATE,0, SYSDATE,0);
@repeat{SELECT COUNT(*) FROM printtemplateitem where ID=59444 }
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (59444, 57578, 216, '发车日期', 1, '宋体', 12.0000, 193, 1357, 169, 42, '2', '', SYSDATE,0, SYSDATE,0);
@repeat{SELECT COUNT(*) FROM printtemplateitem where ID=59445 }
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (59445, 57578, 215, '签发单号', 1, '宋体', 12.0000, 680, 1119, 169, 42, '2', '', SYSDATE,0, SYSDATE,0);
@repeat{SELECT COUNT(*) FROM printtemplateitem where ID=59446 }
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (59446, 57578, 230, '到站', 1, '宋体', 12.0000, 331, 101, 85, 42, '2', '', SYSDATE,0, SYSDATE,0);
@repeat{SELECT COUNT(*) FROM printtemplateitem where ID=59447 }
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (59447, 57578, 234, '金额', 1, '宋体', 12.0000, 331, 527, 85, 42, '2', '', SYSDATE,0, SYSDATE,0);
@repeat{SELECT COUNT(*) FROM printtemplateitem where ID=59448 }
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (59448, 57578, 226, '总金额', 1, '宋体', 12.0000, 680, 315, 127, 42, '7', '', SYSDATE,0, SYSDATE,0);
@repeat{SELECT COUNT(*) FROM printtemplateitem where ID=59449 }
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (59449, 57578, 235, '签发人', 1, '宋体', 12.0000, 751, 558, 127, 42, '2', '', SYSDATE,0, SYSDATE,0);
@repeat{SELECT COUNT(*) FROM printtemplateitem where ID=59450 }
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (59450, 57578, 236, '打印时间', 1, '宋体', 12.0000, 751, 815, 169, 42, '2', '', SYSDATE,0, SYSDATE,0);
@repeat{SELECT COUNT(*) FROM printtemplateitem where ID=59451 }
insert into printtemplateitem (ID, PRINTTEMPLATEID, PRINTTEMPLATETYPEITEMID, TITLE, ISPRINT, FONTNAME, FONTSIZE, TOP, LEFTMARGIN, WIDTH, HEIGHT, VALUETYPE, PARAMETER, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (59451, 57578, 333, '签发站', 1, '宋体', 12.0000, 751, 423, 127, 42, '2', '', SYSDATE,0, SYSDATE,0);
--2015/07/11 赵怀虎  增加  行包签发单--货物结算单  打印模板  end--

--2015年7月13日 15:09:05 孙越 增加默认旅客信息 --
@repeat{SELECT COUNT(*) FROM customer where ID=1 }
insert into customer (ID, NAME, SEX, BIRTHDAY, CERTIFICATETYPE, CERTIFICATENO, EDUCATION, FAMILYADDRESS, FAMILYPHONE, MOBILEPHONE, ORGID, TICKETOUTLETSID, INPUTWAY, LASTBUYTICKETTIME, REMARKS, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, SYNCCODE, ISACTIVE, ISLOCALDELETE, EMAIL)
values (1, '旅客', '男', sysdate, '4', '15712965601', '', '', '', '15712965601', 1, 0, '3',sysdate, '',sysdate, 0,sysdate, 0, 'ed5589dd-abbb-4cd1-938b-2793eab9f1bca', 0, 1, '');
--end --

--begin 2015/07/13 杨志文   班次类型增加类型：中客、商务、快速、软座、沃尔沃、依维柯--
@repeat{SELECT COUNT(*) FROM DIGITALDICTIONARYDETAIL where ID=41371 }
insert into digitaldictionarydetail (ID,DIGITALDICTIONARYID,ORDERNO,CODE,VALUE,DESCRIBE,CREATETIME,CREATEBY,UPDATETIME,UPDATEBY)
values (41371, 16, 6, 6, '中客', '', sysdate, 0, sysdate, 0);
@repeat{SELECT COUNT(*) FROM DIGITALDICTIONARYDETAIL where ID=41372 }
insert into digitaldictionarydetail (ID,DIGITALDICTIONARYID,ORDERNO,CODE,VALUE,DESCRIBE,CREATETIME,CREATEBY,UPDATETIME,UPDATEBY)
values (41372, 16, 7, 7, '商务', '', sysdate,0, sysdate,0);
@repeat{SELECT COUNT(*) FROM DIGITALDICTIONARYDETAIL where ID=41373 }
insert into digitaldictionarydetail (ID,DIGITALDICTIONARYID,ORDERNO,CODE,VALUE,DESCRIBE,CREATETIME,CREATEBY,UPDATETIME,UPDATEBY)
values (41373, 16, 8, 8, '快速', '', sysdate,0, sysdate,0);
@repeat{SELECT COUNT(*) FROM DIGITALDICTIONARYDETAIL where ID=41374 }
insert into digitaldictionarydetail (ID,DIGITALDICTIONARYID,ORDERNO,CODE,VALUE,DESCRIBE,CREATETIME,CREATEBY,UPDATETIME,UPDATEBY)
values (41374, 16, 9, 9, '软座', '', sysdate,0, sysdate,0);
@repeat{SELECT COUNT(*) FROM DIGITALDICTIONARYDETAIL where ID=41375 }
insert into digitaldictionarydetail (ID,DIGITALDICTIONARYID,ORDERNO,CODE,VALUE,DESCRIBE,CREATETIME,CREATEBY,UPDATETIME,UPDATEBY)
values (41375, 16, 10, 10, '沃尔沃', '', sysdate,0, sysdate,0);
@repeat{SELECT COUNT(*) FROM DIGITALDICTIONARYDETAIL where ID=41376 }
insert into digitaldictionarydetail (ID,DIGITALDICTIONARYID,ORDERNO,CODE,VALUE,DESCRIBE,CREATETIME,CREATEBY,UPDATETIME,UPDATEBY)
values (41376, 16, 11, 11, '依维柯', '', sysdate,0, sysdate,0);
--end 2015/07/13 杨志文   班次类型增加类型：中客、商务、快速、软座、沃尔沃、依维柯--

--2015/07/13 张凤娇 增加 包车单打印模板 begin--
@repeat{SELECT COUNT(*) FROM printtemplatetype where ID=32 }
insert into printtemplatetype (ID, NAME) values (32, '包车单');
@repeat{SELECT COUNT(*) FROM printtemplatetypeitem where ID=1161567 }
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (1161567, 32, '实载人数', '3', 'actpeople', 0);
@repeat{SELECT COUNT(*) FROM printtemplatetypeitem where ID=1161571 }
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (1161571, 32, '包车运费', '1', 'basefee', 0);
@repeat{SELECT COUNT(*) FROM printtemplatetypeitem where ID=1161568 }
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (1161568, 32, '计费里程', '1', 'distance', 0);
@repeat{SELECT COUNT(*) FROM printtemplatetypeitem where ID=1161585 }
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (1161585, 32, '所属区域', '0', 'districtname', 0);
@repeat{SELECT COUNT(*) FROM printtemplatetypeitem where ID=1161563 }
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (1161563, 32, '运行区域', '0', 'districttype', 0);
@repeat{SELECT COUNT(*) FROM printtemplatetypeitem where ID=1161563 }
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (1161563, 32, '结束时间', '2', 'enddate', 0);
@repeat{SELECT COUNT(*) FROM printtemplatetypeitem where ID=1161565 }
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (1161565, 32, '包车到站', '0', 'endstation', 0);
@repeat{SELECT COUNT(*) FROM printtemplatetypeitem where ID=1161570 }
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (1161570, 32, '计费方式', '0', 'feetype', 0);
@repeat{SELECT COUNT(*) FROM printtemplatetypeitem where ID=1161579 }
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (1161579, 32, '包车单', '0', 'hirebusno', 0);
@repeat{SELECT COUNT(*) FROM printtemplatetypeitem where ID=1161561 }
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (1161561, 32, '用车日期', '2', 'hiredate', 0);
@repeat{SELECT COUNT(*) FROM printtemplatetypeitem where ID=1161557 }
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (1161557, 32, '包车单位', '0', 'hireunit', 0);
@repeat{SELECT COUNT(*) FROM printtemplatetypeitem where ID=1161572 }
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (1161572, 32, '保险费', '1', 'insurefee', 0);
@repeat{SELECT COUNT(*) FROM printtemplatetypeitem where ID=1161578 }
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (1161578, 32, '经办人', '0', 'operatername', 0);
@repeat{SELECT COUNT(*) FROM printtemplatetypeitem where ID=1161576 }
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (1161576, 32, '机构', '0', 'orgname', 0);
@repeat{SELECT COUNT(*) FROM printtemplatetypeitem where ID=1161573 }
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (1161573, 32, '其他费用', '1', 'otherfee', 0);
@repeat{SELECT COUNT(*) FROM printtemplatetypeitem where ID=1161575 }
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (1161575, 32, '备注', '0', 'remark', 0);
@repeat{SELECT COUNT(*) FROM printtemplatetypeitem where ID=1161562 }
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (1161562, 32, '开始时间', '2', 'startdate', 0);
@repeat{SELECT COUNT(*) FROM printtemplatetypeitem where ID=1161564 }
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (1161564, 32, '包车起点', '0', 'startstation', 0);
@repeat{SELECT COUNT(*) FROM printtemplatetypeitem where ID=1161582 }
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (1161582, 32, '售票点', '0', 'ticketoutletsname', 0);
@repeat{SELECT COUNT(*) FROM printtemplatetypeitem where ID=1161574 }
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (1161574, 32, '总费用', '1', 'totalfee', 0);
@repeat{SELECT COUNT(*) FROM printtemplatetypeitem where ID=1161581 }
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (1161581, 32, '包车类型', '0', 'typevalue', 0);
@repeat{SELECT COUNT(*) FROM printtemplatetypeitem where ID=1161559 }
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (1161559, 32, '车属单位', '0', 'unitname', 0);
@repeat{SELECT COUNT(*) FROM printtemplatetypeitem where ID=1161569 }
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (1161569, 32, '计费时间', '0', 'usehour', 0);
@repeat{SELECT COUNT(*) FROM printtemplatetypeitem where ID=1161560 }
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (1161560, 32, '车辆', '0', 'vehiclecode', 0);
@repeat{SELECT COUNT(*) FROM printtemplate where ID=1161592 }
insert into printtemplate (ID, PRINTTEMPLATETYPEID, NAME, HEIGHT, HEIGHTCORRECTION, WIDTH, LEFTMARGIN, TOP, BACKGROUNDIMAGE, ROWSPACE, ROWPERPAGE, PRINTERNAME, COLUMNSPERPAGE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (1161592, 32, '包车单', 800, 800, 1000, 0, 0, '', 50, 5, '', 1, sysdate,0,sysdate,0);

--2015/07/13 张凤娇 增加 包车单打印模板 end--

--增加前台明细菜单 代金岩 2015年7月11日 16:55:15
@repeat{SELECT COUNT(*) FROM Exceptioninfo where  ID='606' }
insert into Exceptioninfo (ID, CODE, MSG, MODULES)
values (606, '0606', '行包结算单号已经存在，请重新输入!', '行包结算单补录');
--end--

--begin 2015/07/14 杨志文 线路在该线路设置的时间间隔内部允许报班增加字段后设置为0--
UPDATE ROUTE SET REPORTINTERVAL=0 WHERE REPORTINTERVAL IS NULL; 
--end 2015/7/14 杨志文	线路在该线路设置的时间间隔内部允许报班增加字段后设置为0--
--begin 2015/07/14 加参数:同线路报班时间隔时间限制判断
@repeat{SELECT count(*) FROM PARAMETER p where p.id = 2037}
insert into parameter (ID,TYPE,CODE,VALUE,ISVISIBLE,ISEDITABLE,REMARK,UPDATETIME,UPDATEBY,UNIT)
values (2037,'20','2037','0',1,1,'是否开启同线路报班时间隔时间限制判断，0：否；1：是',sysdate,0,'是否');
--end 2015/07/14 加参数:同线路报班时间隔时间限制判断

--2015/07/14 张彪 更新结算单旧数据  begin--
update departinvoices d set d.driver1id=0 where d.driver1id is null;
update departinvoices d set d.driver2id=0 where d.driver2id is null;
update departinvoices d set d.steward1id=0 where d.steward1id is null;
--2015/07/14 张彪   end--

-- 2015/7/15 赵怀虎    IC卡报班的驾驶员是否必须是证件核查的驾驶员    begin --
@repeat{SELECT count(*) FROM PARAMETER p where p.id = 8085}
INSERT INTO PARAMETER (ID, TYPE, CODE, VALUE, ISVISIBLE, ISEDITABLE, REMARK, UPDATETIME, UPDATEBY, UNIT)
VALUES (8085, '80', '8085', '0', 1, 1, 'IC卡报班的驾驶员是否必须是证件核查通过的驾驶员，0：否，1：是', SYSDATE,0, '是否');
@repeat{SELECT count(*) FROM EXCEPTIONINFO p where p.id = 480}
INSERT INTO EXCEPTIONINFO (ID, CODE, MSG, MODULES)
VALUES (480, '0480', '该驾驶员没有通过证件核查，不允许报班！', 'IC卡报班');
-- 2015/7/15 赵怀虎   end --

--车票挂失表的车票状态  李电志  2015年7月15日 16:06:32 begin
@repeat{SELECT COUNT(*) FROM digitaldictionary where  ID=183 }
insert into digitaldictionary (ID, NAME, DESCRIBE, TABLENAME, COLUMNNAME, ISCANEDIT, UPDATETIME, UPDATEBY)
values (183, '挂失状态', '0：挂失取消  1：挂失', 'ticketloss', 'status', 0,sysdate, 0);
@repeat{SELECT COUNT(*) FROM digitaldictionarydetail where  ID=562 }
insert into digitaldictionarydetail (ID, DIGITALDICTIONARYID, ORDERNO, CODE, VALUE, DESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (562, 183, 0, '0', '挂失取消', '挂失状态',sysdate, 0,sysdate, 0);
@repeat{SELECT COUNT(*) FROM digitaldictionarydetail where  ID=563 }
insert into digitaldictionarydetail (ID, DIGITALDICTIONARYID, ORDERNO, CODE, VALUE, DESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (563, 183, 0, '1', '挂失', '挂失状态',sysdate, 0,sysdate, 0);
--李电志  2015年7月15日 16:07:02  end

-- 2015-07-16 赵怀虎  修改结算单生成扣费时行包扣费项是否作为扣费项8020参数 begin--
@repeat{SELECT COUNT(*)-1 FROM parameter where  ID=8020 }
update parameter p set p.value = '0' where p.id=8020 and p.code='8020';
-- 2015-07-16 赵怀虎  修改8020参数 end--
--20150715 liyi 新增数据源：结算单中添加只扣除站务费的结算单价，结算通知单添加扣除站务费的总金额
@repeat{SELECT count(*) FROM printtemplatetypeitem p where p.id = 1159377 or itemcode='nostationfeetotalmoney'}
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (1159377, 3, '只扣除站务费总金额', '0', 'nostationfeetotalmoney', 0);
@repeat{SELECT count(*) FROM printtemplatetypeitem p where p.id = 1199413 or itemcode='nostationtotalbalanceprice'}
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (1199413, 4, '只扣除站务费结算总金额', '0', 'nostationtotalbalanceprice', 0);
@repeat{SELECT count(*) FROM printtemplatetypeitem p where p.id = 1160505 or itemcode='nostationbalanceprice'}
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (1160505, 4, '只扣除站务费结算单价', '0', 'nostationbalanceprice', 0);

--2015-07-16 代金岩 新增数据源
@repeat{SELECT count(*) FROM Digitaldictionary where id = 42}
insert into Digitaldictionary (ID, NAME, DESCRIBE, TABLENAME, COLUMNNAME, ISCANEDIT, UPDATETIME, UPDATEBY)
values (42, '票价公式组成项相关类型', '车型相关/公路等级相关/车型公路等级相关/客运站等级相关/班次相关/线路相关/线路停靠点相关/票价区间相关/公里区间相关/固定值相关/表达式相关', 'ticketpriceformulaitem', 'relatetype', 0, sysdate,0);
--end

-- 2015-07-17 张凤娇 参数8044修正 begin
@repeat{SELECT count(*)-1 FROM parameter where code=8044}
update parameter set remark='综合检票中，发班时是否打印空结算单 0 :否 1：是' where code=8044;
--end
--2015 07-20 liyi 新增营收缴款和实际售票营收不一致记录
@repeat{SELECT count(*) FROM exceptioninfo where code='1000'}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values (1000, '1000', '营收缴款和实际售票营收不一致，请重新查询！', '营收缴款');
--添加车辆座位类型  李电志  2015年7月30日 04:32:22
@repeat{SELECT count(*) FROM digitaldictionary where id = 501}
insert into digitaldictionary (ID, NAME, DESCRIBE, TABLENAME, COLUMNNAME, ISCANEDIT, UPDATETIME, UPDATEBY)
values (501, '座位类型', '0：豪华硬座、1：豪华软座、2：豪华飞天、3：卧铺、4：卧铺上、5：卧铺下、6：商务座、7：高级座', 'vehicle', 'seattype', 0,sysdate, 0);
@repeat{SELECT count(*) FROM digitaldictionarydetail where id = 59486}
insert into digitaldictionarydetail (ID, DIGITALDICTIONARYID, ORDERNO, CODE, VALUE, DESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (59486, 501, 0, '0', '豪华硬座', '豪华硬座', sysdate, 0,sysdate, 0);
@repeat{SELECT count(*) FROM digitaldictionarydetail where id = 59487}
insert into digitaldictionarydetail (ID, DIGITALDICTIONARYID, ORDERNO, CODE, VALUE, DESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (59487, 501, 1, '1', '豪华软座', '豪华软座',sysdate, 0,sysdate, 0);
@repeat{SELECT count(*) FROM digitaldictionarydetail where id = 59488}
insert into digitaldictionarydetail (ID, DIGITALDICTIONARYID, ORDERNO, CODE, VALUE, DESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (59488, 501, 2, '2', '豪华飞天', '豪华飞天',sysdate, 0,sysdate, 0);
@repeat{SELECT count(*) FROM digitaldictionarydetail where id = 59489}
insert into digitaldictionarydetail (ID, DIGITALDICTIONARYID, ORDERNO, CODE, VALUE, DESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (59489, 501, 3, '3', '卧铺', '卧铺',sysdate, 0,sysdate, 0);
@repeat{SELECT count(*) FROM digitaldictionarydetail where id = 59490}
insert into digitaldictionarydetail (ID, DIGITALDICTIONARYID, ORDERNO, CODE, VALUE, DESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (59490, 501, 4, '4', '卧铺上', '卧铺上',sysdate, 0,sysdate, 0);
@repeat{SELECT count(*) FROM digitaldictionarydetail where id = 59491}
insert into digitaldictionarydetail (ID, DIGITALDICTIONARYID, ORDERNO, CODE, VALUE, DESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (59491, 501, 5, '5', '卧铺下', '卧铺下',sysdate, 0,sysdate, 0);
@repeat{SELECT count(*) FROM digitaldictionarydetail where id = 59492}
insert into digitaldictionarydetail (ID, DIGITALDICTIONARYID, ORDERNO, CODE, VALUE, DESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (59492, 501, 6, '6', '商务座', '商务座',sysdate, 0,sysdate, 0);
@repeat{SELECT count(*) FROM digitaldictionarydetail where id = 59493}
insert into digitaldictionarydetail (ID, DIGITALDICTIONARYID, ORDERNO, CODE, VALUE, DESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (59493, 501, 7, '7', '高级座', '高级座',sysdate, 0,sysdate, 0);
--添加车辆座位类型  李电志  2015年7月30日 04:32:22  end
--  begin 姜蓥瑞 2015年8月3日17:40:34 异常表增加 6115---
@repeat{SELECT count(*) FROM exceptioninfo where id = 6115}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values (6115, '6115', '被并班次无被并信息，并班无法恢复售票！', '并班恢复售票');
--end
--  begin 姜蓥瑞 2015年8月19日14:00:44 异常表增加 6117---
@repeat{SELECT count(*) FROM exceptioninfo where id = 6117}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values (6117, '6117', '报到车辆座位数小于该班次已售座位号，不允许报到！', '车辆报到');
--end

--begin 2015/8/27   添加数据源  addby daijy
@repeat{SELECT count(*) FROM printtemplatetypeitem where id = 1199415}
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (1199415, 3, '本月上交', '0', 'bysj', 0);
@repeat{SELECT count(*) FROM printtemplatetypeitem where id = 1199416}
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (1199416, 3, '上月欠交', '0', 'syqj', 0);
@repeat{SELECT count(*) FROM printtemplatetypeitem where id = 1199414}
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values (1199414, 3, '总扣费1', '0', 'deductifee1', 0);
--end
--begin 2015年9月1日 15:57:04  李电志  修改售票打印车票的票价多一位小数点问题
@repeat{SELECT count(*)-1 FROM printtemplateitem where id=1154074}
update printtemplateitem pp set pp.parameter = '%s',pp.updatetime = sysdate where pp.id = 1154074;
@repeat{SELECT count(*)-1 FROM printtemplateitem where id=1154065}
update printtemplateitem pp set pp.parameter = '%s',pp.updatetime = sysdate where pp.id = 1154065;
--end 

@repeat{select count(*)-1 from  user_tab_columns t where t.TABLE_NAME=upper('ticketoutlets') and t.COLUMN_NAME=upper('startstationid')}
update ticketoutlets t
   set t.startstationid = (select o.stationid
                             from organization o
                            where t.orgid = o.id
                            and o.islocal=1
                            and o.isactive=1)
   where t.type=0 and t.id>0 and t.startstationid is null;