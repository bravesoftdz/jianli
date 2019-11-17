@repeat{SELECT count(*) FROM parameter where CODE = 0001}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (1, '00', '0001', '300', 1, 1, '连续输入间隔时间，默认为1秒', sysdate, 1158013, '毫秒');
@repeat{SELECT count(*) FROM parameter where CODE = 0002}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (2, '00', '0002', '0', 0, 0, '自动检票', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 0003}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (3, '00', '0003', '20', 1, 1, '座位图默认列数', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 0004}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (4, '00', '0004', '40', 1, 1, '座位图默认列宽', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 0005}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (5, '00', '0005', '55', 1, 1, '座位图默认行高', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 0006}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (130, '00', '0006', '31', 1, 1, '综合查询功能,最大可查询天数', sysdate, 1158013, '天');
@repeat{SELECT count(*) FROM parameter where CODE = 0007}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (136, '00', '0007', '31', 1, 1, '所有报表查询,最大可查询天数', sysdate, 1158013, '天');
@repeat{SELECT count(*) FROM parameter where CODE = 0008}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (8, '00', '0008', '1', 0, 0, '系统是否在联网环境中', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 0009}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (18, '00', '0009', '8', 1, 1, '自动生成班次营运计划的天数', sysdate, 1158013, '天');
@repeat{SELECT count(*) FROM parameter where CODE = 0010}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (20, '00', '0010', '1', 0, 0, '售票员自己缴款', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 0011}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (1020, '00', '0011', '0', 1, 1, '是否显示广播按钮', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 0012}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (1200, '00', '0012', '1', 1, 1, '设置硬调票价时：是否限制线路停靠点前站里程必须小于后站里程，0不限制，1限制，默认为1(控制线路管理中线路停靠点添加时里程的限制)', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 0013}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (1300, '00', '0013', '0', 1, 0, '本系统是否支持会员卡', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 0014}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (35, '00', '0014', '0', 1, 1, '硬调票价中的车型：0：只显示班次循环中的车型,1:显示所有车型', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 0015}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (218, '00', '0015', '0', 1, 1, '燃油费设置是否生成到票价中：0取票价公式组成项中设置的值，1燃油费设置中的值', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 0016}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (524, '00', '0016', '0', 1, 1, '若硬调票价无对应的车型是否取其他车型票价生成营运计划', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 0017}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (37, '00', '0017', '0.55', 1, 1, '生成半票对于全票的比例', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 0018}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (530, '00', '0018', '0', 1, 1, '领用票证时是否打印票据领用单', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 0019}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (5001, '00', '0019', '0', 1, 1, '坏票登记是否允许登记其他人的票据', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 0020}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (1220, '00', '0020', '0', 1, 1, '长停班次是否生成班次计划', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 0021}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (1021, '00', '0021', '1', 1, 1, '票价生成方式：0：线路票价，1：硬调票价 2: 公式票价', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 0022}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (1022, '00', '0022', '0', 0, 0, '是否查询其他站结算单,0,否，1：是', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 0023}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (20160317, '00', '0023', '0', 1, 1, '票据入库后是否需要审核才能领用，0不需要，1需要，默认为0', sysdate, 0, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 0024}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (1024, '00', '0024', '0', 1, 1, '票号重置时是否能跳号重置，0不能跳号重置，1能跳号重置，若参数值设为为1时，跳过的正常号做坏票处理', sysdate, 0, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 0025}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (10001, '10', '0025', '0', 1, 1, '售保险是否需要录入保险单号', sysdate, 0, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 0026}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (288, '00', '0026', '15', 1, 1, '售票情况查询：售票日期最大可查询天数', sysdate, 1158013, '天');
@repeat{SELECT count(*) FROM parameter where CODE = 0029}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (12512, '00', '0029', '1', 1, 1, '集中式数据库A站用户是否可以在B站下的售票点登录,参数值为0则不允许登录，参数值为1则允许登录,默认为 1', sysdate, 0, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 0030}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (20163000, '00', '0030', '0', 1, 1, '是否启用证件核查（林东）,0不启用(原逻辑),1启用(IC卡报班时,关闭指纹报班功能,驾乘人员指纹输入,并且校验司乘人员进站检查/证件核查/安全学习情况,需要2033参数开启),默认为0', sysdate, 0, '是否');
@repeat{SELECT 1-count(*) FROM parameter where CODE = 0030}
update PARAMETER set remark='是否启用证件核查（林东）,0不启用(原逻辑),1启用(IC卡报班时,驾乘人员指纹输入,并且校验司乘人员证件核查/安全学习情况,需要2033参数开启),默认为0' where code='0030';
@repeat{SELECT count(*) FROM parameter where CODE = 0031}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (20160624, '00', '0031', '1', 1, 1, '配载班次停班时，是否以始发站为准。1:以始发站为准，0:不以始发站为准;默认为1：以始发站为准。', sysdate, 0, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 0066}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (366, '00', '0066', '0', 1, 1, '班次预售票申请提示框是否弹出：1，弹出，0不弹', sysdate, 0, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 0088}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (1166812, '00', '0088', '0', 1, 1, '是否开启点对点配载模式（吉林售票模式）默认不开启。', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 0142}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (142, '60', '0142', '800', 1, 1, '车辆的里程限制公里数', sysdate, 1158013, '公里');
@repeat{SELECT count(*) FROM parameter where CODE = 0143}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (143, '60', '0143', '0', 1, 1, '是否开启车辆里程限制', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 0144}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (1440, '00', '0144', '1', 1, 1, '是启用副屏程序，0：否，1：是', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 1001}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (101, '10', '1001', '1', 1, 1, '' || chr(9) || '满座班次不要显示', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 1002}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (102, '10', '1002', '1', 1, 1, '售票问询，售票界面是否显示全部班次，0：显示全部班次；1：显示正常班次', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 1003}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (103, '10', '1003', '1', 1, 1, '' || chr(9) || '已开运量单不显示；', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 1004}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (104, '10', '1004', '1', 0, 1, '' || chr(9) || '到了售票截止时间不显示；', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 1005}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (105, '10', '1005', '1', 1, 1, '票号初始化自动填写当前车票票号，0不填写，1填写，默认为1', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 1006}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (106, '10', '1006', '1', 1, 1, '售票是否自动选位', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 1007}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (107, '10', '1007', '1', 1, 1, '售票是否自动选择连号座位', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 1008}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (108, '10', '1008', '180', 1, 1, '普通购票锁位时长，单位为秒钟', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 1009}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (109, '10', '1009', '360', 1, 1, '订单购票锁位时长，单位为秒钟', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 1010}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (110, '10', '1010', '1', 1, 1, '自动售保险', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 1011}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (111, '10', '1011', '1', 1, 1, '自动实收', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 1012}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (112, '10', '1012', '1', 1, 1, '班次最多免票带儿童数，0固定个数，1班次座位数的百分比，默认为1() 提示:设置此参数后需设置参数1061才生效', sysdate, 1158013, '%');
@repeat{SELECT count(*) FROM parameter where CODE = 1013}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (113, '10', '1013', '10000', 1, 1, '' || chr(9) || '余票少于N张时醒目提示售票员', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 1014}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (114, '10', '1014', '1', 1, 1, '' || chr(9) || '屏幕上的找零信息应保留至下次新售票操作', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 1015}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (115, '10', '1015', '-300', 1, 1, '补票截止时间为发车前N分钟，正数为发车前，负数为发车后，默认为300分钟', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 1016}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (116, '10', '1016', '5', 1, 1, ' 一次性售票超过N张时提示用户', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 1017}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (117, '10', '1017', '7', 1, 1, ' 车票预售天数，默认为7天', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 1018}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (118, '10', '1018', '5', 1, 1, '站内售票点售票截止时间（距离发班），单位为分钟', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 1019}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (119, '10', '1019', '5', 1, 1, '站外售票点售票截止时间（距离发班），单位为分钟', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 1020}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (120, '10', '1020', '0', 1, 1, '报到后才允许售票', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 1021}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (121, '10', '1021', '2', 1, 1, '补票手续费', sysdate, 1158013, '元');
@repeat{SELECT count(*) FROM parameter where CODE = 1022}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (122, '10', '1022', '0', 1, 1, '是否售保险', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 1023}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (123, '10', '1023', '0', 1, 1, '是否启用售票机器控制', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 1024}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (124, '10', '1024', '1', 1, 1, '流水班次是否打印座位号', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 1025}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (125, '10', '1025', '1', 1, 1, '售联网票是否延迟加载最新座位及票价信息', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 1026}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (126, '10', '1026', '1', 1, 1, '是否开启“输入序号定位班次“功能', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 1027}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (127, '10', '1027', '1', 1, 1, '是否开启“在到站处用上下键修改发车日期“功能', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 1028}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (128, '10', '1028', '0', 1, 1, '特权补票能否售已发班班次的车票', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 1029}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (129, '10', '1029', '30', 1, 1, '售联网票截止时间，到了售票截止时间不显示', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 1030}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (1030, '10', '1030', '1', 1, 1, '售本地票时，是否默认发车站为当前登录机构', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 1031}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (1031, '10', '1031', '1', 1, 1, '流水班是否打印发车时间', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 1032}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (1032, '10', '1032', '15', 1, 1, '自助售票机锁位时长，单位为分钟', sysdate, 1158013, '分钟');
@repeat{SELECT count(*) FROM parameter where CODE = 1033}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (1033, '10', '1033', '1', 1, 1, '售票是否允许人工选择座位', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 1034}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (1034, '10', '1034', '0', 1, 1, '过路班次提前多少分钟开始售票，0表示报到后开始售票', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 1035}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (1035, '10', '1035', '0', 1, 1, '是否开放邮政退票功能', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 1036}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (1036, '10', '1036', '100', 1, 1, '可售半票占班次总座位百分比', sysdate, 1158013, '%');
@repeat{SELECT count(*) FROM parameter where CODE = 1037}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (1037, '10', '1037', '0', 1, 1, '改签的车票是否允许普通退票', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 1038}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (1038, '10', '1038', '0', 1, 1, '改签的车票是否允许普通废票', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 1039}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (1039, '10', '1039', ' ', 1, 1, '不带儿童车票打印信息', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 1040}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (1040, '10', '1040', '1', 1, 1, '是否允许自助售票机售票', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 1041}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (1041, '10', '1041', '1', 1, 1, '是否只有全票才允许带儿童', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 1042}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (207, '10', '1042', '1', 1, 1, '计算票种票价的进位规则：1四舍五入、2舍去、3入、4小于5角进到5角，高于5角进到1元', sysdate, 1158013, null);
@repeat{SELECT 1-count(*) FROM parameter where CODE = 1042}
update PARAMETER set remark='计算票种票价的进位规则：1:四舍五入，2:舍去，3:入，4:小于等于5角进到5角、大于5角进到1元，5:小于五角舍去、等于五角保留为五角、大于五角进到1元，默认为1' where code='1042';
@repeat{SELECT count(*) FROM parameter where CODE = 1043}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (1043, '10', '1043', '1', 1, 1, '售保险是否弹出顾客信息录入框（不需要时默认顾客ID为0）', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 1044}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (1044, '10', '1044', '0', 1, 1, '售保险是否默认填写顾客信息（默认顾客ID为0）', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 1045}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (1045, '10', '1045', '0', 1, 0, '(退票、废票、营收缴款页面)是否显示保险信息，0不显示，1显示，默认为0', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 1046}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (1046, '10', '1046', '0', 1, 1, '全票时,票价小于上限价,车票类型就打印折，0：否，1：是', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 1047}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (1047, '10', '1047', '1', 1, 1, '补票界面是否显示售票截止时间之前的班次，0不显示，1显示，默认为0', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 1048}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (1048, '10', '1048', '0', 1, 1, '联网票手续费', sysdate, 1158013, '元');
@repeat{SELECT count(*) FROM parameter where CODE = 1049}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (1049, '10', '1049', '3', 1, 1, '江西全省联网票手续费', sysdate, 1158013, '元');
@repeat{SELECT count(*) FROM parameter where CODE = 1050}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (1050, '10', '1050', '1', 1, 1, '特权补票是否允许售留位(非固定留位)，0不允许，1允许，默认为0', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 1051}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (182, '10', '1051', '100000', 1, 1, '售票员缴款金额上限（达到金额后，必须缴款）', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 1052}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (1052, '10', '1052', '0', 1, 1, '特权补票能补N天前的票，0表示当天', sysdate, 1158013, '天');
@repeat{SELECT count(*) FROM parameter where CODE = 1053}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (1053, '10', '1053', '1', 1, 0, '售票界面F1显示内容，0：营收缴款，1：退票', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 1054}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (1054, '10', '1054', '1', 0, 0, '售票界面F6显示内容，0：自动实收，1：改签', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 1055}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (1055, '10', '1055', '0', 1, 1, '售票界面是否经过座位图，0：不经过，1：经过', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 1056}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (1056, '10', '1056', '1', 1, 1, '售票时全票是否默认一张,0:零张，1：一张', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 1057}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (1057, '10', '1057', '0', 1, 1, '售票员是否可以查看营收F1,0：不能，1：能', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 1058}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (1058, '10', '1058', '0', 1, 1, '半票票价取值方式，0取全票票价的一半，1取执行票价中的半票票价，默认为0,参考0017参数硬调票价半价的取值方式', sysdate, 0, null);
@repeat{SELECT count(*) FROM parameter where CODE = 1059}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (1059, '10', '1059', '1', 1, 1, '售团体票是否可修改车票应收的值，0否，1是，默认为1', sysdate, 0, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 1060}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (1164800, '10', '1060', '1', 1, 1, '保险费是根据里程还是根据票价设置，0里程，1票价', sysdate, 1012127, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 1061}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (1061, '10', '1061', '5', 1, 1, '班次最多免票带儿童数/班次最多带儿童占班次座位数的百分比。提示：设置此参数前需先设置参数1012', sysdate, 0, '个数/%');
@repeat{SELECT count(*) FROM parameter where CODE = 1062}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (1062, '10', '1062', '10', 1, 1, '单次售票张数大于参数1062设置的N张，不允许售票！', sysdate, 0, '张数');
@repeat{SELECT count(*) FROM parameter where CODE = 1063}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (1167812, '10', '1063', '0', 1, 1, '同一身份证当天是否可以购买多张票，0：可以购买多张；1：购买单张', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 1064}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (1167813, '10', '1064', '1', 1, 1, '同一身份证当天购买多张票的时间间隔；单位小时', sysdate, 1158013, '小时');
@repeat{SELECT count(*) FROM parameter where CODE = 1065}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (1065, '10', '1065', '1', 1, 1, '退票界面站务是否能够修改，0不可修改，1可以修改，2取固定值1.6，默认0', sysdate, 0, null);
@repeat{SELECT 1-count(*) FROM parameter where CODE = 1065}
update PARAMETER set isvisible='0' where CODE = 1065;
@repeat{SELECT count(*) FROM parameter where CODE = 1066}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (120101, '10', '1066', '1', 1, 1, '改签是否打印手续费. 1打印 0不打印', sysdate, 0, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 1067}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (16031401, '10', '1067', '0', 1, 1, '出站检查登记表添加界面是否使用结算单号查询车辆信息，0不使用，1使用，默认为0', sysdate, 0, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 1068}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (16031402, '10', '1068', '0', 1, 1, '退票是否实名制退票，0不实名制退票，1实名制退票，默认为0', sysdate, 0, '是否');
@repeat{SELECT 1-count(*) FROM parameter where CODE = 1068}
update PARAMETER set isvisible='0' where CODE = 1068;
@repeat{SELECT count(*) FROM parameter where CODE = 1069}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
alues (20162317, '10', '1069', '1', 1, 1, '(特权)补票是否打印凭证，0不打印，1打印，默认为1', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 1071}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (1071, '10', '1071', '0', 1, 1, '半票站务取值，0：取全票站务费，1：取全票站务费一半', sysdate, 0, null);
@repeat{SELECT count(*) FROM parameter where CODE = 1072}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (1072, '10', '1072', '0', 1, 1, '半票站务费的小数点取值问题保留一位小数(0表示保持原值，1：舍掉，2：四舍五入，3：进位)', sysdate, 0, null);
@repeat{SELECT count(*) FROM parameter where CODE = 1073}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (1073, '00', '1073', '0', 1, 1, '售票员营收缴款页面参数设为1时，显示现金支付部分和电子支付部分，参数值设为0时，只显示现金支付部分', sysdate, 0, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 1075}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (1075, '10', '1075', '0', 1, 1, '是否启用购物车功能，0不启用，1启用，默认为1', sysdate, 0, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 1076}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (1076, '10', '1076', '0', 1, 1, '实名制售票是否允许同一身份证购买同一班次的多张车票，0不允许，1允许，默认为0.该参数的前提是参数9393设置为1,9494设置为1', sysdate, 0, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 1078}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (6098, '11', '1078', '0', 1, 1, '是否启用流水班退票手续费率，1启用、0不启用', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 1079}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (1079, '11', '1079', '1', 1, 1, '过发车时间是否允许普通退票，0不允许普通退票，1允许普通退票', sysdate, 0, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 1080}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (1165812, '10', '1080', '0', 1, 1, '售票时，站务费是否根据票价公式设置取值。默认为0：不根据票价公式设置取值。', sysdate, 0, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 1082}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (1082, '10', '1082', '1', 1, 0, '是否输出保险文本，0不输出，1输出，默认为1', sysdate, 0, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 1088}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (1088, '10', '1088', '10', 1, 1, '流水班发车前退票手续费率，前提是1078参数设置为1，1178参数设置为0', sysdate, 0, '%');
@repeat{SELECT count(*) FROM parameter where CODE = 1101}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (201, '11', '1101', '1', 1, 1, '退票是否打印凭证', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 1102}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (202, '11', '1102', 'Ticket', 1, 1, '退票凭证票据编码', sysdate, 1158013, null);
@repeat{SELECT 1-count(*) FROM parameter where CODE = 1102}
update PARAMETER set isvisible='0' where CODE = 1102;
@repeat{SELECT count(*) FROM parameter where CODE = 1103}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (203, '11', '1103', '20', 1, 1, '发车前两小时外退票手续费率，单位是%', sysdate, 1158013, '%');
@repeat{SELECT count(*) FROM parameter where CODE = 1104}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (204, '11', '1104', '40', 1, 1, '发车前两小时内退票手续费率，单位是%', sysdate, 1158013, '%');
@repeat{SELECT count(*) FROM parameter where CODE = 1105}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (1105, '11', '1105', '1', 1, 1, '退票手续费进位规则：1四舍五入、2舍去、3入、4小于5角进到5角，高于5角进到1元、5保留小数点,6保留一位小数四舍五入', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 1106}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (1106, '11', '1106', '0', 1, 1, '集中式环境下，本站能否退它站售它站票', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 1107}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (1107, '11', '1107', '0', 1, 1, '退票手续费计算方式，0表示票价*退票手续费率，1表示（票价-站务费）*退票手续费率+站务费，2表示票价*退票手续费率+站务费，3（票价-4）*退票手续费率+4，默认为0', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 1108}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (1151576, '11', '1108', '1', 1, 1, '多张退票手续费是否打印一张', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 1110}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (1110, '11', '1110', '1', 1, 1, '退票手续费为0是否打印退票凭证，0：不打印，1：打印', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 1111}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (60789, '10', '1111', '10', 1, 1, '售票问询刷新频率：秒。', sysdate, 0, '秒');
@repeat{SELECT count(*) FROM parameter where CODE = 1112}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (656, '10', '1112', '0', 1, 1, '当前售票站点只能售当前站及始发站发班的票，0不启用，1启用，默认为0.', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 1113}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (1113, '11', '1113', '1', 1, 1, '退票界面过期车票是否允许退票，0表示不允许，1表示允许', sysdate, 0, null);
@repeat{SELECT count(*) FROM parameter where CODE = 1115}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (1115, '11', '1115', '0', 1, 1, '退票时能退N天前未检车票，0表示当天,N的值大于等于零', sysdate, 0, '天');
@repeat{SELECT count(*) FROM parameter where CODE = 1116}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (1116, '11', '1116', '1', 1, 1, '停班班次普通退票时是否全额退票，0按普通退票规则进行退票，1全额退票，默认为1', sysdate, 0, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 1166}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (120701, '11', '1166', '1', 1, 1, '退票是否需要审核，0否，1是，默认为0', sysdate, 0, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 1178}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (60800, '11', '1178', '1', 1, 1, '当天退票手续费率：1表示开启，当天为20%，之前为10%', sysdate, 0, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 1179}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (60880, '11', '1179', '0', 1, 1, '是否启用二连浩特退票公式：1表示启用，0表示不启用', sysdate, 0, '是否');
@repeat{SELECT 1-count(*) FROM parameter where CODE = 1179}
update PARAMETER set isvisible='0' where CODE = 1179;
@repeat{SELECT count(*) FROM parameter where CODE = 1301}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (131, '13', '1301', '0', 1, 1, '订票服务费收取方式，0固定金额，1比例，默认为0需要设置1302参数的值', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 1302}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (132, '13', '1302', '5', 1, 1, '订票服务费 /订票服务费比例%', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 1303}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (133, '13', '1303', '24', 1, 1, '默认自动取消留位小时数', sysdate, 1158013, '小时');
@repeat{SELECT count(*) FROM parameter where CODE = 1304}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (134, '13', '1304', '5', 1, 1, '省内班次发车前N小时自动取消留位', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 1305}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (135, '13', '1305', '5', 1, 1, '省外班次发车前N小时自动取消留位', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 1306}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (1306, '13', '1306', '0', 1, 1, '一年内超过N次订票不取票，再订时提示订票员是否允许订票', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 1307}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (1307, '13', '1307', '1', 1, 1, '订票销售时，是否自动选择记录,0：不选择，1：选择', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 1401}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (141, '14', '1401', '10', 1, 1, '普通废票限制时间（售票后多少分钟内允许废）', sysdate, 1158013, '分钟');
@repeat{SELECT count(*) FROM parameter where CODE = 1501}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (151, '15', '1501', '0', 1, 1, '改签服务费收取方式 0固定金额 1比例', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 1502}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (152, '15', '1502', '5', 1, 1, '改签服务费 /改签服务费比例%', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 1503}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (153, '15', '1503', '0', 1, 1, '原班次已发班是否允许改签', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 1504}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (154, '15', '1504', '0', 1, 1, '改签是否要求票价相同', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 1505}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (155, '15', '1505', '0', 1, 1, '改签是否要求上车点和下车点与原票一致', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 1506}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (156, '15', '1506', '0', 1, 1, '改签是否要求线路与原票一致', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 1507}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (1507, '15', '1507', '1', 1, 1, '车票是否只允许改签一次', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 1508}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (1508, '15', '1508', '60', 1, 1, '发车时间前N分钟内的车票不得改签', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 1509}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (1509, '15', '1509', '0', 1, 1, '是否允许改签到低票价', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 1511}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (157, '15', '1511', '0', 1, 1, '改入班次已发班是否允许改签，0不允许，1允许，默认为0', sysdate, 0, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 1518}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (189, '15', '1518', '0', 1, 1, '已存在发班记录流水线是否允许改签,1:允许；0：不允许', sysdate, 0, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 1601}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (161, '16', '1601', '1', 1, 1, '联网售票问讯是否延迟加载最新座位及票价信息', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 1819}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (1819, '20', '1819', '1', 1, 1, 'IC报班-界面中是否显示"结算单号码"', sysdate, 0, null);
@repeat{SELECT count(*) FROM parameter where CODE = 1998}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (1998, '30', '1998', '0', 1, 1, '是否开启OpenApi售票，0：否，1：是', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 2001}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (500, '20', '2001', '10', 1, 1, '车辆提前报班分钟数，0表示不限制。未在设置的时间前报到则为晚点（如班次A发车时间为9:30，此参数设置的提前报到' || chr(10) || '' || chr(10) || '时间为30分钟，则车辆9:01报到即为晚点）', sysdate, 1158013, '分钟');
@repeat{SELECT count(*) FROM parameter where CODE = 2002}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (501, '20', '2002', '5', 1, 1, '每晚报到分钟数', sysdate, 1158013, '分钟');
@repeat{SELECT count(*) FROM parameter where CODE = 2003}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (502, '20', '2003', '2', 1, 1, '每晚报到罚款金额', sysdate, 1158013, '元');
@repeat{SELECT count(*) FROM parameter where CODE = 2004}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (503, '20', '2004', '1', 1, 1, '1按脱班计算违约金,0不按脱班计算违约金', sysdate, 1158013, ' ');
@repeat{SELECT count(*) FROM parameter where CODE = 2005}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (504, '20', '2005', '30', 1, 1, '晚指定分钟数以上按脱班计算违约金', sysdate, 1158013, '分钟');
@repeat{SELECT count(*) FROM parameter where CODE = 2006}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (505, '20', '2006', '0', 1, 1, '0按脱班次计算违约金,1按最大营业额计算', sysdate, 1158013, ' ');
@repeat{SELECT count(*) FROM parameter where CODE = 2007}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (506, '20', '2007', '50', 1, 1, '次脱班金额', sysdate, 1158013, '元');
@repeat{SELECT count(*) FROM parameter where CODE = 2008}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (507, '20', '2008', '0.02', 1, 1, '按定员数*全程票价*倍数计算违约金', sysdate, 1158013, '倍数');
@repeat{SELECT count(*) FROM parameter where CODE = 2009}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (508, '20', '2009', '1', 1, 1, '1为报到后自动为可检票,0为报到后不修改可检票状态', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 2010}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (509, '20', '2010', '0', 1, 1, '始发站未报到，配客站是否允许报到,0：不允许，1：允许', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 2011}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (510, '20', '2011', '1', 1, 1, '报到车辆座位数小于班次座位数，是否允许报到', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 2012}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (511, '20', '2012', '1', 1, 1, '始发站报到后，配客站是否自动报到，0：否，1：是', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 2013}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (512, '60', '2013', '0', 1, 1, '是否需要安检合格才报到，0：不需要，1：需要', sysdate, 1158013, '是否');
@repeat{SELECT 1-count(*) FROM parameter where CODE = 2013}
update PARAMETER set remark='车辆是否需要安检合格才能报班，0不需要可直接报班，1需要安检合格才能报班，2未安检或安检不合格给出提示选择是否继续报班，默认为0' where CODE = 2013;
@repeat{SELECT count(*) FROM parameter where CODE = 2014}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (513, '20', '2014', '1', 1, 1, '并班时是否可以并相同站点不同票价的班次，0：否，1：是', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 2015}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (514, '20', '2015', '0', 1, 1, '加班时是否自动生成班次运行计划,0:不自动生成，1：自动生成', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 2016}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (516, '20', '2016', '0', 1, 1, '加班班次是否显示代理费应用，0：不显示，1：显示', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 2017}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (523, '20', '2017', '1', 1, 1, '始发站停售，配载站是否也停售，0：不停售，1：停售', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 2018}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (34, '20', '2018', '1', 1, 1, '综合调度线路改变后是否自动查询，0：否，1：是', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 2019}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (210, '20', '2019', '1', 1, 1, '行驶证、保险过期的车辆是否允许报到：0、否，1、是', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 2020}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (2020, '20', '2020', '0', 1, 1, '同一车牌多次报到最小时间间隔(发班时间间隔)，单位：分钟，0表示不限制', sysdate, 1158013, '分钟');
@repeat{SELECT count(*) FROM parameter where CODE = 2021}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (177, '20', '2021', '0', 1, 1, '是否只允许车辆报到在已指定的线路中（车牌管理、车辆可营运线路、当天排车的班次）,0允许报到所有线路，1只允许报到指定线路，默认为0', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 2022}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (29, '20', '2022', '0', 0, 1, '报到车辆座位数小于已售座位数是否允许报到，0:不允许，1：允许', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 2023}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (60, '20', '2023', '600', 1, 1, '2个司机的线路公里数定义', sysdate, 1158013, '公里');
@repeat{SELECT count(*) FROM parameter where CODE = 2024}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (178, '20', '2024', '5', 1, 1, '证件有效期到期提示天数', sysdate, 1158013, '天');
@repeat{SELECT count(*) FROM parameter where CODE = 2025}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (179, '20', '2025', '10', 1, 1, '驾驶员两次报班的最小时间间隔', sysdate, 1158013, '分钟');
@repeat{SELECT count(*) FROM parameter where CODE = 2026}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (707, '20', '2026', '0', 1, 1, '是否必须输入驾驶员才能报到，0否，1是', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 2027}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (100, '20', '2027', '1', 1, 1, '自助报班中，是否允许使用强制身份识别:1允许，0不允许', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 2028}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (99, '20', '2028', '1', 1, 1, '出站例检中,没有报到的车辆,是否允许车辆出站，1允许，0不允许', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 2029}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (98, '20', '2029', '0', 1, 1, '出站例检中,流水班是否需报到一次便可出站，1报到一次就可出站，0出站后需要再次报到', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 2030}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (183, '20', '2030', '1', 1, 1, '驾驶员证件过期是否允许报班:1允许，0不允许', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 2031}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (2031, '20', '2031', '1', 1, 1, '车辆报班时是否改变座位数，0：不改变，1：改变', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 2032}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (2032, '20', '2032', '1', 1, 1, '0:ID卡报班，1：IC卡报班', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 2033}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (2033, '20', '2033', '0', 1, 1, '是否开启指纹报班功能,0：不开启，1：开启', sysdate, 0, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 2034}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (2034, '20', '2034', '0', 1, 1, '模版加班输入计划车辆是否自动报班，0不自动报班，1自动报班，默认为0。', sysdate, 0, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 2035}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (2035, '20', '2035', '0', 1, 1, 'IC卡报班时流水班是否只显示一条记录，0报到n个车辆显示n条记录，1只显示一条记录，默认为0', sysdate, 0, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 2037}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (2037, '20', '2037', '0', 1, 1, '是否开启同线路报班时间隔时间限制判断，0：否；1：是', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 2038}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (2038, '20', '2038', '0', 1, 1, 'IC卡报班时是否允许通过车牌号获取驾驶员的信息，0否，1是', sysdate, 0, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 2040}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (2040, '20', '2040', '0', 1, 1, '省际线路发车前N分钟报班', sysdate, 0, '分钟');
@repeat{SELECT count(*) FROM parameter where CODE = 2041}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (2041, '20', '2041', '0', 1, 1, '省内线路发车前N分钟报班', sysdate, 0, '分钟');
@repeat{SELECT count(*) FROM parameter where CODE = 2043}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (2043, '30', '2043', '0', 1, 1, '出站检查时，出站驾驶员跟报到驾驶员不一致是否允许出站，0不允许，1允许，默认为0', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 2044}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (2044, '30', '2044', '0', 1, 1, '出站检查时，出站乘务员跟报到乘务员不一致是否允许出站，0不允许，1允许，默认为0', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 2045}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (20160817, '20', '2045', '0', 1, 1, 'IC卡报班是否开启按车辆单位类型分配权限进行报到，0不开启，1开启，默认为0', sysdate, 0, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 2046}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (2046, '00', '2046', '0', 1, 1, '脱班的定义，0车辆当天有营运计划但未发班，1车辆过发车时间未报班，默认为0', sysdate, 0, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 2047}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (2047, '00', '2047', '0', 1, 1, '晚点的定义，0车辆过发车时间报班，1车辆过发车时间发班，默认为0', sysdate, 0, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 2056}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (2056, '00', '2056', '1', 1, 1, '驾驶员诚信考核、继续教育日期过期是否允许报班，0不允许，1允许，默认为1.', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 2060}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (160071791, '20', '2060', '0', 1, 1, '是否开启指纹报班暂存功能，0:不开启;1:开启，默认为0;需要加载证件核查插件', sysdate, 0, null);
@repeat{SELECT count(*) FROM parameter where CODE = 2082}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (812, '20', '2082', '0', 0, 1, '是否判断车辆营运班次，不是营运班次则不允许报班 1:判断 0:不判断 默认为0', sysdate, 0, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 2098}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (2098, '10', '2098', '49000', 1, 1, '特捷网上售票金额限制', sysdate, 1158013, '元');
@repeat{SELECT count(*) FROM parameter where CODE = 2626}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (16060101, '10', '2626', '0', 1, 1, '是否使用bus365平台售保险，0不适用，1使用，默认0', sysdate, 0, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 2627}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (160070701, '10', '2627', '0', 1, 1, '平台售保险自助机或者网上售票退保控制0不控制1控制，默然0', sysdate, 0, '是否');
@repeat{SELECT 1-count(*) FROM parameter where CODE = 2627}
update PARAMETER set isvisible='0' where CODE = 2627;
@repeat{SELECT count(*) FROM parameter where CODE = 2888}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (6565, '20', '2888', '1', 1, 1, '报班是否打印营运车辆报班单', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 3001}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (6, '30', '3001', '0', 1, 1, '发车前n分钟开始检票,0则无限制', sysdate, 1158013, '分钟');
@repeat{SELECT count(*) FROM parameter where CODE = 3002}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (7, '30', '3002', '1', 1, 1, '是否允许使用鼠标点击检票，0：不允许，1：允许！', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 3003}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (9, '30', '3003', '1', 1, 1, '不同线路的班次是否允许混检,0：不允许，1：允许', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 3004}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (10, '30', '3004', '0', 1, 1, '流水班次是否允许混检到流水班次,0：不允许，1：允许！', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 3005}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (11, '30', '3005', '1', 1, 1, '流水班次是否允许混检到非流水班次,0：不允许，1：允许！', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 3006}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (12, '30', '3006', '1', 1, 1, '非流水班次是否允许混检到流水班次,0：不允许，1：允许！', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 3007}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (16, '30', '3007', '60', 1, 1, '检票界面的刷新时间，单位:秒', sysdate, 1158013, '秒');
@repeat{SELECT count(*) FROM parameter where CODE = 3008}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (17, '30', '3008', '2', 1, 1, '离发车前N分钟才允许发班打单,0:表示不限制', sysdate, 1158013, '分钟');
@repeat{SELECT count(*) FROM parameter where CODE = 3009}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (19, '30', '3009', '0', 1, 1, '检票模块是否自动刷新班次信息', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 3010}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (21, '30', '3010', '0', 1, 1, '0：表示混检满座时交换座位,1:表示满座时加座混检', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 3011}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (22, '30', '3011', '0', 1, 1, '是否需要进行检票口控制，0：不需要，1：需要', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 3012}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (23, '30', '3012', '0', 1, 1, '过了发车时间是否允许混检，0:不允许,1允许', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 3013}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (24, '30', '3013', '0', 1, 1, '综合检票界面是否显示结算单号，0：不显示，1：显示', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 3014}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (30, '30', '3014', '0', 1, 1, '座位图中是否显示售票提示信息，0：不显示，1：显示', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 3015}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (517, '30', '3015', '1', 1, 1, '满座是否允许混检,0：不允许，1：允许', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 3016}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (31, '30', '3016', '0', 1, 1, '过天的车票是否允许混检，0：表示不允许，1：表示允许', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 3017}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (32, '30', '3017', '20', 1, 1, '发车时间后N分钟之内允许补检', sysdate, 1158013, '分钟');
@repeat{SELECT count(*) FROM parameter where CODE = 3018}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (33, '30', '3018', '0', 1, 1, '正常检票结束时间：发车时间前N分钟，若为负数则为发车时间后N分钟', sysdate, 1158013, '分钟');
@repeat{SELECT count(*) FROM parameter where CODE = 3019}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (520, '30', '3019', '3', 1, 1, '重打结算单的天数', sysdate, 1158013, '天');
@repeat{SELECT count(*) FROM parameter where CODE = 3020}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (521, '30', '3020', '1', 1, 1, '集中式环境中是否允许途径配载班次在异站检票', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 3021}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (171, '30', '3021', '1', 1, 1, '综合检票中，是否显示停班班次', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 3022}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (172, '30', '3022', '1', 1, 1, '综合检票中，是否显示被并班次', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 3023}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (173, '30', '3023', '1', 1, 1, '综合检票中，是否显示脱班班次', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 3024}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (174, '30', '3024', '1', 1, 1, '综合检票中，是否显示停售班次', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 3025}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (525, '30', '3025', '0', 1, 1, '重打运量单是否跳号，若是跳号，则原来单号做注销处理,0:为不跳号，1：为跳号', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 3026}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (175, '30', '3026', '0', 1, 1, '隔天车票，是否只能混检到车票当天的班次', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 3027}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (61, '30', '3027', '0', 1, 1, '混检是否允许检不存在站点的检入，0：不允许，1：允许！', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 3028}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (3028, '30', '3028', '1', 1, 1, '综合检票中发班是否打印结算单，0：不打印，1：打印', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 3029}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (3029, '30', '3029', '11', 1, 1, '检票中座位图列数', sysdate, 1158013, '列');
@repeat{SELECT count(*) FROM parameter where CODE = 3030}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (3030, '30', '3030', '64', 1, 1, '检票中座位图宽度', sysdate, 1158013, '像素');
@repeat{SELECT count(*) FROM parameter where CODE = 3031}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (3031, '30', '3031', '56', 1, 1, '检票中座位图高度', sysdate, 1158013, '像素');
@repeat{SELECT count(*) FROM parameter where CODE = 3032}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (3032, '30', '3032', '1', 1, 1, '站外售票点是否能检其他售票点售的票，0：不能检，1：可以检', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 3033}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (3033, '30', '3033', '1', 1, 1, '预售票是否允许混检，0：不允许,1:允许', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 3034}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (184, '30', '3034', '0', 1, 1, '报班时已有计划车辆是否修改计划车辆信息，0否，1是，默认为0', sysdate, 0, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 3035}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (185, '30', '3035', '1', 1, 1, '报到车辆座位数小于班次座位数时是否截掉后面的座位数，0否，1是，默认为1', sysdate, 0, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 3036}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (1164811, '30', '3036', '0', 1, 1, '检票时扫描的票号所属班次跟当前选中班次不一致时，是否允许检票，0否，1是，默认为0', sysdate, 1, null);
@repeat{SELECT count(*) FROM parameter where CODE = 3037}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (3037, '30', '3037', '10', 1, 1, '结算单重打的次数(若为0，则不允许重打，否则，参数设置N，就允许重打N次)', sysdate, 0, null);
@repeat{SELECT count(*) FROM parameter where CODE = 3038}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (160070791, '30', '3038', '0', 1, 1, '是否实名制检票，0不实名制，1实名制，默认为0。', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 3039}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (3039, '30', '3039', '0', 1, 1, '综合检票中，发班前是否验证驾驶员身份，0不验证，1验证，默认0', sysdate, 0, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 3040}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (3040, '30', '3040', '0', 1, 1, '集中式环境中的配载班次在打印结算单时，0只打印本站发车并已检的车票，1始发站不打结算单、配载站打印本班次所有已检车票的结算单，默认为0' || chr(10) || '', sysdate, 0, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 3041}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (3041, '30', '3041', '3', 1, 1, '补开结算单的天数', sysdate, 0, '天');
@repeat{SELECT count(*) FROM parameter where CODE = 3042}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (3042, '30', '3042', '3', 1, 1, '注销结算单的天数', sysdate, 0, '天');
@repeat{SELECT count(*) FROM parameter where CODE = 3045}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (345, '30', '3045', '0', 1, 1, '综合检票界面是否显示初检单号，0：不显示，1：显示', sysdate, 0, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 3046}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (16102702, '30', '3046', '0', 1, 1, '综合检票界面实名制检票成功后是否弹出乘车人信息框，0不弹出，1弹出，默认为0', sysdate, 0, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 3047}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (16102701, '30', '3047', '3', 1, 1, '综合检票界面实名制检票成功后弹出的乘车人信息框显示时间,默认为3', sysdate, 0, '秒');
@repeat{SELECT count(*) FROM parameter where CODE = 3066}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (120702, '30', '3066', '0', 1, 1, '补开结算单是否填写售票员，0否，1是，默认为0', sysdate, 0, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 3067}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (3067, '30', '3067', '0', 1, 1, '混检是否允许检到留位上，0：不允许，1：允许', sysdate, 0, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 3068}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (3068, '30', '3068', '0', 1, 1, '手工结算单是否进行结算扣费 0:不开启扣费,1:开启扣费 默认为0', sysdate, 0, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 3069}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (3069, '30', '3069', '0', 1, 1, '检票闸机是否允许预售票通过，0不允许，1允许，默认为0', sysdate, 0, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 3087}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (817, '30', '3087', '0', 1, 1, '综合检票中发班是否打印初检单，0否，1是，默认为0', sysdate, 0, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 3088}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (3088, '30', '3088', '0', 1, 1, '打印结算单时是否打印车票明细，0不打印(即模板打印)，1打印(即AcReport打印)，2打印（结算单模板打印车票明细），默认为0', sysdate, 0, null);
@repeat{SELECT count(*) FROM parameter where CODE = 3101}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (176, '31', '3101', '0', 1, 1, '隔天班次开运量时是否必须用补开', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 3102}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (3102, '31', '3102', '0', 1, 1, '闸机是否进行检票操作，0：不检票，1：检票', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 3103}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (3103, '31', '3103', '0', 1, 1, '闸机是否控制本系统外的票号，0：不控制，1：控制', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 3105}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (3105, '31', '3105', '3', 1, 1, '检票闸机允许重复刷票进行检票的最大次数', sysdate, 1158013, '次数');
@repeat{SELECT count(*) FROM parameter where CODE = 3106}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (3106, '31', '3106', '0', 1, 1, '退票、检票、重打/补开结算截至日期，如，20，则表示20（含）号之前的票不允许退票、检票、重打/补开结算，0则表示不控制', sysdate, 0, '号');
@repeat{SELECT count(*) FROM parameter where CODE = 4001}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (15, '40', '4001', '0', 1, 1, '0:表示使用公里区间设置站务费，1：表示使用票价区间设置站务费', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 4002}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (25, '40', '4002', '0.08', 1, 1, '联网售票结算费率', sysdate, 1158013, '数字');
@repeat{SELECT count(*) FROM parameter where CODE = 4003}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (515, '40', '4003', '1', 1, 1, '营收缴款的实缴款自动赋值：0，不允许、1，允许', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 4004}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (404, '40', '4004', '0.08', 1, 1, '客运站结算汇总表客代费（劳务费）比例', sysdate, 0, '数字');
@repeat{SELECT count(*) FROM parameter where CODE = 4005}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (518, '40', '4005', '0', 1, 1, '0:结算通知单上不打印结算单打单时扣费项,1:结算通知单上打印结算单打单时扣费项', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 4006}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (13, '40', '4006', '1', 1, 1, '结算时扣费明细取值，0：取扣费应用信息，:1取最近的一次扣费信息', sysdate, 1158013, '数值');
@repeat{SELECT count(*) FROM parameter where CODE = 4007}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (205, '40', '4007', '30', 1, 1, '营运车辆违规处理：N分钟内创建的数据可以修改、删除', sysdate, 1158013, '分钟');
@repeat{SELECT count(*) FROM parameter where CODE = 4008}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (206, '40', '4008', '0', 1, 1, '营运车辆违规结算违规结算类型:0、罚金，1、暂扣款', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 4009}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (213, '40', '4009', '1', 1, 1, '会员卡缴款时,应缴款是否自动赋值，0、否，1、是', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 4010}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (36, '40', '4010', '1', 1, 1, '售票员缴款后是否自动打印缴款单：1、自动打印，0、不打印', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 4011}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (4011, '40', '4011', '0', 1, 0, '坏票登记是否需要核销', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 4012}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (4012, '40', '4012', '0', 1, 1, '0：结算时扣费项目作为数据集，1：扣费项目作为打印项目', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 4013}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (4013, '80', '4013', '0', 1, 1, '结算时是否重新计算客运代理费，0：不计算，1：重新计算', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 4014}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (60501, '40', '4014', '1', 1, 1, '售票员营收缴款，上次欠款是否累计到本期应缴款中，0否，1是，默认为1', sysdate, 0, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 4015}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (4015, '40', '4015', '0', 1, 1, '打印结算单时0:按[始站]止站距离票价分组打印1:按[始站]止站距离票价[票种]分组打印2:按止站距离票价分组打印3:按止站距离票价[票种]分组打印4:相同到站分组打印', sysdate, 0, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 4016}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (1164812, '40', '4016', '0', 1, 1, '注销天数限制，0不限制注销天数，其他为value天内的结算单可以注销', sysdate, 1158013, '天');
@repeat{SELECT count(*) FROM parameter where CODE = 4017}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (16041201, '40', '4017', '0', 1, 1, '结算通知单打印模板，0结算通知单模板，1包含线路、车牌号明细的固定模板，默认为0', sysdate, 0, null);
@repeat{SELECT count(*) FROM parameter where CODE = 4025}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (60788, '40', '4025', '1', 1, 1, '0:表示结算单补录班次只取当天发班班次，1：取所有', sysdate, 0, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 4038}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (388, '40', '4038', '0', 1, 1, '0:营收缴款统计表使用普通模板；1：英山模板', sysdate, 0, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 4046}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (162401, '40', '4046', '0', 1, 1, '结算单管理导出DBF版本,0:北郊版本,库尔勒版本', sysdate, 0, null);
@repeat{SELECT count(*) FROM parameter where CODE = 4050}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (299, '40', '4050', '1', 1, 1, '手工单结算是否需要审核：1，需要；0，不需要', sysdate, 0, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 4068}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (868, '40', '4068', '0', 1, 1, '应结金额进位规则：1四舍五入、2舍去、3入、4小于5角进到5角，高于5角进到1元、5保留小数点', sysdate, 0, null);
@repeat{SELECT count(*) FROM parameter where CODE = 5001}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (26, '50', '5001', '1', 1, 1, '系统中是否启用票价差功能,0：不启用，1：启用', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 5003}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (1167913, '50', '5003', '0', 1, 1, '班次计划生产时：0 ——按原班次循环生成，1——按车辆循环生成，2——如果有车辆循环数据，取车辆循环。如果没有则去班次循环进行生成', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 5050}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (5050, '50', '5050', '0', 1, 1, '系统中结算金额是否启用线路票价差功能,0：不启用，1：启用', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 6001}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (522, '60', '6001', '10', 1, 1, '安检记录N分钟内允许注销', sysdate, 1158013, '分钟');
@repeat{SELECT count(*) FROM parameter where CODE = 6002}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (208, '60', '6002', '0', 1, 1, '车辆安检时判断行驶证、保险的截止日期：0、否，1、是', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 6004}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (144, '60', '6004', '800', 1, 1, '车辆二期维护里程剩下多少公里,弹出提示', sysdate, 1158013, '公里');
@repeat{SELECT count(*) FROM parameter where CODE = 6005}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (145, '60', '6005', '3', 1, 1, '车辆二期维护有效期剩下多少天数,弹出提示', sysdate, 1158013, '天');
@repeat{SELECT count(*) FROM parameter where CODE = 6006}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (146, '60', '6006', '0', 1, 1, '是否开启二维有效期和第三者责任险有效期判断', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 6007}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (147, '60', '6007', '90', 1, 1, '激活车辆二期维护有效期默认月数', sysdate, 1158013, '月');
@repeat{SELECT count(*) FROM parameter where CODE = 6008}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (50, '60', '6008', '0', 1, 1, '无安检计划时，是否需要安检才允许报到', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 6009}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (51, '60', '6009', '0', 1, 1, '安检时，安检员是否允许修改', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 6010}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (180, '60', '6010', '1', 1, 1, '车辆安检有效时间类型：0:当日内有效，1:24小时内有效', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 6011}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (181, '60', '6011', '1000', 1, 1, '安检以后，车辆需要再次安检的行驶公里数,(0:不控制)', sysdate, 1158013, '公里');
@repeat{SELECT count(*) FROM parameter where CODE = 6012}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (706, '60', '6012', '0', 1, 1, '是否打印安检不合格通知单：1打印，0不打印', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 6013}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (219, '60', '6013', '0', 1, 1, '是否默认打印安检通知单：0不打印，1打印通知单', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 6014}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (220, '60', '6014', '1', 1, 1, '车辆是否必须先安检，才能进行GPS检查：0否，1是', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 6015}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (221, '60', '6015', '0', 1, 1, '车辆GPS检查是否必须合格才能进行报班：0否，1是', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 6016}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (225, '60', '6016', '0', 1, 1, '安检时是否要刷安检员卡,0：不需要，1：需要', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 6017}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (226, '60', '6017', '0', 1, 1, '安检24小时有效：当天发过班次，安检合格单是否只对当天有效，1：当天有效性，0：24小时有效', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 6018}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (62, '60', '6018', '0', 1, 1, '无安检计划时，0允许车辆进行安检，1不允许车辆进行安检', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 6019}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (6019, '60', '6019', '1', 1, 1, '安检时，是否进行安检有效期判断，0：不判断，1：要判断', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 6020}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (6020, '60', '6020', '1', 1, 1, '车辆出站是否检查相关证件是否合格！，0：不检查，1：检查', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 6021}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (16081901, '60', '6021', '0', 1, 1, '安检合格通知单打印模板，0安检合格通知单模板，1包含安检项目明细及三联单确认的固定模板，2包含安检项目明细的固定模板，默认为0 国标插件仅支持1,2 普通安检仅支持0', sysdate, 0, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 6022}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (228, '60', '6022', '1', 1, 1, '安检四证过期是否正常安检：0、否，1、是', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 6025}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (601, '60', '6025', '05:00:00', 1, 1, '安检明日车辆时间，格式如下：06:00:00', sysdate, 1158013, '时间');
@repeat{SELECT count(*) FROM parameter where CODE = 6026}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (6026, '60', '6026', '0', 1, 1, '车辆安检是否必须输入安检费，0否，1是，默认为0', sysdate, 0, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 6027}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (6027, '60', '6027', '1', 1, 1, '出站检查登记表是否打印安检单，0不打印，1打印，默认为0', sysdate, 0, null);
@repeat{SELECT count(*) FROM parameter where CODE = 6060}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (688, '60', '6060', '1', 1, 1, '车辆安检是否安检灭火器，1：安检，0：不检查', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 6070}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (655, '60', '6070', '1', 1, 1, '安检不合格能否打印结算单，0不能，1能，默认为0', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 7001}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (211, '70', '7001', '10', 1, 1, '会员卡发卡时,卡的成本费', sysdate, 1158013, '元');
@repeat{SELECT count(*) FROM parameter where CODE = 7002}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (212, '70', '7002', '0', 1, 1, '会员卡发卡或补卡时,卡的成本费是否可编辑，0、否，1、是', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 7003}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (703, '70', '7003', '0', 1, 1, '一卡通是否可以在窗口购票', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 7004}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (704, '70', '7004', '0', 1, 1, '一卡通是否允许退检退票', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 7005}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (705, '70', '7005', '10', 1, 1, '会员卡补卡时,卡的成本费', sysdate, 1158013, '元');
@repeat{SELECT count(*) FROM parameter where CODE = 8001}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (52, '80', '8001', '0.1', 1, 1, '保险费比率', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 8002}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (53, '80', '8002', '0.1', 1, 1, '保价费比率', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 8003}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (54, '80', '8003', '1', 1, 1, '保险费是否显示控件及计算费用 0否 1是 ', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 8004}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (55, '80', '8004', '1', 1, 1, '保价费是否显示控件及计算费用 0否 1是 ', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 8005}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (14, '80', '8005', '0', 1, 1, '行包受理是否打印发票  0不打印 1打印', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 8006}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (27, '80', '8006', '0', 1, 1, '行包签发是否打印签发单 0否 1是', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 8007}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (28, '80', '8007', '0', 1, 1, '行包提领是否打印提领单 0否 1是', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 8008}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (38, '80', '8008', '10', 1, 1, '(行包提领)行包每天保管费', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 8009}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (39, '80', '8009', '10', 1, 1, '小件寄存基本费用', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 8010}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (40, '80', '8010', '5', 1, 1, '小件寄存超出提货日期时每天的滞纳金', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 8012}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (42, '80', '8012', '1', 1, 1, '营收缴款的应缴款自动赋值1允许  0不允许', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 8013}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (43, '80', '8013', '1', 1, 1, '到货行包最大免费保管天数', sysdate, 1126281, '天');
@repeat{SELECT count(*) FROM parameter where CODE = 8015}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (45, '80', '8015', '0.1', 1, 1, '行包车辆返款比例', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 8016}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (70, '80', '8016', '0', 1, 1, '行包托运是否打印托运单，0不打印，1打印，默认为0。参数值设置为1生效的前提需参数8017设置为1.', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 8017}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (71, '80', '8017', '0', 1, 1, '行包托运是否需领托运单?', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 8018}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (72, '80', '8018', '0', 1, 1, '行包N分钟内可以取消签发，0表示不允许取消签发', sysdate, 1158013, '分钟');
@repeat{SELECT count(*) FROM parameter where CODE = 8019}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (73, '80', '8019', '0', 1, 1, '行包N分钟内可以取消提领，0表示不允许取消提领', sysdate, 1158013, '分钟');
@repeat{SELECT count(*) FROM parameter where CODE = 8020}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (8020, '80', '8020', '0', 1, 1, '结算时，0：行包作为营收，1：行包作为扣费', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 8021}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (8021, '80', '8021', '1', 1, 1, '结算时：固定扣费是否可以修改,0：不允许修改，1：可以修改', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 8022}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (8022, '80', '8022', '3', 1, 1, '行包送货费每公斤金额', sysdate, 1158013, '是否');



@repeat{SELECT count(*) FROM parameter where CODE = 8023}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (13031, '80', '8023', '5', 1, 1, '(行包提领)行包基本保管费', sysdate, 1126281, '元');
@repeat{SELECT count(*) FROM parameter where CODE = 8044}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (1117041, '30', '8044', '1', 1, 1, '综合检票中，发班时是否打印空结算单 0 :否 1：是', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 8068}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (8068, '80', '8068', '1', 1, 1, '到货入仓是否需领行包到货收讫单?', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 8080}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (57276, '30', '8080', '1', 1, 1, '综合检票中发班是否打印货物结算单，0：不打印，1：打印', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 8083}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (8083, '80', '8083', '0.3', 1, 1, '行包打印结算单时的扣费比率', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 8084}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (8084, '80', '8084', '1', 1, 1, 'IC卡报班中打印结算单是否同时打印货运结算信息', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 8085}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (8085, '31', '8085', '0', 1, 1, 'IC卡报班的驾驶员是否必须是证件核查通过的驾驶员，0不是，1是，默认为0', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 8088}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (1151574, '30', '8088', '1', 1, 1, '综合检票中发班打印货物结算单时，单号是否取结算单号，0：不取，1：取', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 8099}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (57899, '80', '8099', '0.7', 1, 1, '结算金额比率', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 8888}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (162, '00', '8888', '30', 1, 1, ' 班次基本利用率', sysdate, 0, '%');
@repeat{SELECT count(*) FROM parameter where CODE = 8979}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (8979, '11', '8979', '1', 1, 1, '已检的票是否可以退票： 0不可、1 可以', sysdate, 0, null);
@repeat{SELECT 1-count(*) FROM parameter where CODE = 8979}
update PARAMETER set isvisible='0' where CODE = 8979;
@repeat{SELECT count(*) FROM parameter where CODE = 9033}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (9033, '30', '9033', '0', 1, 1, '客票结算单打印时，是否需要根据行包回收款有效日期来判断：0，不需要，1：需要', sysdate, 1, null);
@repeat{SELECT count(*) FROM parameter where CODE = 9044}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (9044, '80', '9044', '7', 1, 1, '行包回收款有效日期', sysdate, 1, '天');
@repeat{SELECT count(*) FROM parameter where CODE = 9050}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (950, '10', '9050', '0', 1, 1, '报班车型与计划车型不一致时，是否修改计划车型及对应票价    0否，1是，默认为0', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 9080}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (57288, '30', '9080', '1', 1, 1, '综合检票中发班是否按售票站打印结算单，0：否，1：是', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 9099}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (90999, '20', '9099', '0', 1, 1, '综合检票中，是否自动开检,0:否,1:是', sysdate, 1158013, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 9393}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (9393, '10', '9393', '0', 1, 1, '是否实名制售票：0否，1全局实名制，2固定线路实名制', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 9494}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (9494, '10', '9494', '0', 1, 1, '实名制售票是否弹出乘客信息录入框：0否，1是', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 9595}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (9595, '10', '9595', '0', 1, 1, '线路是否实名制售票：0否，1是', sysdate, 0, null);
@repeat{SELECT count(*) FROM parameter where CODE = 9797}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (9797, '10', '9797', '3', 1, 1, '实名制售票或售保险，0只输入姓名，1只输入身份证号，2姓名和身份证号输入其中一种，3必须同时输入姓名和身份证号，默认为3', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 9898}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (9898, '10', '9898', '0', 1, 1, '实名制售票是否默认填写乘客信息：0否，1是', sysdate, 1158013, null);
@repeat{SELECT count(*) FROM parameter where CODE = 9999}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (9999, '20', '9999', '1', 1, 1, '配载班次停班时，是否以始发站为准。默认为1：以始发站为准。', sysdate, 0, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 0035}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (17020901, '00', '0035', '0', 1, 1, '是否开启密码复杂度校验, 0:不开启，1：开启. 默认为 0 ', sysdate, 0, '是否');
@repeat{SELECT count(*) FROM parameter where CODE = 0036}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (17020902, '00', '0036', '0', 1, 1, '密码有效期天数，0：无限制，N表示天数. 默认为 0 ', sysdate, 0, '天数');
@repeat{SELECT count(*) FROM parameter where CODE = 0037}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (17020903, '00', '0037', '0', 1, 1, '登录次数限制 0，无限制， N表示次数. 默认为 0 ', sysdate, 0, '次数');
@repeat{SELECT count(*) FROM parameter where CODE = 0038}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (17020904, '00', '0038', '0', 1, 1, '系统超时时间 0：无限制, N表示分钟. 默认为 0 ', sysdate, 0, '分钟');
--begin 2017-02-15 zhaohuaihu
@repeat{select count(*) from parameter where code='1117'}
insert into parameter (ID, TYPE, CODE, VALUE, ISVISIBLE, ISEDITABLE, REMARK, UPDATETIME, UPDATEBY, UNIT)
values (1117, '11', '1117', '0', 1, 1, '退票手续费率为100%时是否允许退票，0不允许，1允许，默认为0', sysdate, 0, '是否');
--end 2017-02-15 zhaohuaihu
--begin 孙越  2017年2月23日 09:36:47--
update PARAMETER set remark='实名制售票是否允许同一证件购买同一班次的多张车票，0不允许，1允许，默认为0.此参数设置为0的前提是参数9393设置为1或2，9494设置为1' where code='1076';
--end--
--begin 2017-03-02 zhaohuaihu
@repeat{SELECT COUNT(*) FROM parameter where code='1074' }
insert into parameter (ID, TYPE, CODE, VALUE, ISVISIBLE, ISEDITABLE, REMARK, UPDATETIME, UPDATEBY, UNIT)
values (1074, '10', '1074', '0', 1, 1, '免票儿童是否单独打印车票，0不打印，1打印，默认为0', sysdate, 0, '是否');
--end 2017-03-02 zhaohuaihu
--2017年3月6日 13:58:25    孙越 --
update parameter t set t.remark='流水班次,同一证件重复购票的时间间隔，单位：小时' where t.code='1064';
--end--
--begin update 实名制参数  孙越 2017年3月16日 10:02:24---
update parameter t set t.isvisible = 1 , t.iseditable = 1 where t.code = '8022';
update parameter t set t.value =1, t.isvisible = 0 , t.iseditable = 0 where t.code = '9494';
update parameter t set t.value =1, t.isvisible = 0 , t.iseditable = 0 where t.code = '9797';
update parameter t set t.value =1, t.isvisible = 0 , t.iseditable = 0 where t.code = '1077';
--end--
--begin  孙越 2017年3月30日 17:44:57 增加 参数 --
@repeat{SELECT COUNT(*) FROM parameter where code='1086' }
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (17033001, '10', '1086', '0', 1, 1, '乘客信息录入框点击关闭按钮是否允许进收款页面，0不允许，1允许，默认为0', sysdate, 0, '是否');
--end--
--孙越 2017年4月5日 10:33:49--
update parameter p set p.remark = '集中式配载环境中,始发站报到后，配客站是否自动报到，0：否，1：是' where p.code = '2012';
--begin maxiao
@repeat{SELECT count(*) FROM parameter where CODE = 1085}
insert into PARAMETER (id, type, code, value, isvisible, iseditable, remark, updatetime, updateby, unit)
values (1085, '00', '1085', '7', 1, 1, '电子票取票可取N天前未取车票，0表示当天，N大于等于0；', sysdate, 1158013, null);
--end
@repeat{SELECT 1-count(*) FROM parameter where CODE = 9595}
update parameter p set p.isvisible=0 where p.code = '9595';
@repeat{SELECT 1-count(*) FROM parameter where CODE = 1030}
update parameter p set p.remark = '售本地票时，0发车站默认为空，1发车站默认为当前机构，2不清空发车站（发车站非当前站的情况），默认为1' where p.code = '1030';
@repeat{SELECT 1-count(*) FROM parameter where CODE = 0030}
update parameter p set p.remark = '是否启用证件核查（林东）,0不启用(原逻辑),1启用(IC卡报班时,关闭指纹报班功能,驾乘人员指纹输入,并且校验司乘人员进站检查/证件核查/安全学习情况,需要2033,2026参数开启),默认为0' where p.code = '0030';


@repeat{SELECT 1-count(*) FROM parameter where CODE = '1034'}
update parameter p set p.remark  = '过路班次提前N分钟开始售票,0表是不可售' where p.code = '1034';

-- begin 孙越 2017年6月26日 11:07:21更新参数--
@repeat{SELECT 1-count(*) FROM parameter where CODE = '1998'}
update parameter t set t.type = '10' where t.code = '1998';
--end--

@repeat{SELECT count(*) FROM parameter where CODE = '3050'}
insert into parameter (ID, TYPE, CODE, VALUE, ISVISIBLE, ISEDITABLE, REMARK, UPDATETIME, UPDATEBY, UNIT)
values (17061601, '30', '3050', '0', 1, 1, '集中式环境下，始发站未按正常点发班是否修改下一个配客站发车时间，0不修改，1修改，默认为0.参数设置为1时，按始发站延时时长自动延长/缩短配客站计划发车时间。', sysdate, 0, '发班');

-- begin 孙越 2017年7月19日 17:08:20 更新参数--
@repeat{SELECT 1-count(*) FROM parameter where CODE = '4013'}
update parameter t set t.remark = '结算时是否重新计算客运代理费，0：不计算，1：重新计算' where t.code = '4013';
--end--
--begin zhaomingliang 2017年8月3日17:21:23 隐藏参数
@repeat{SELECT 1-count(*) FROM parameter where CODE = '8085'}
update parameter t set t.isvisible = 0 where t.code = '8085';
--end
--begin 孙越 2017年8月7日 14:51:07 增加参数--
@repeat{SELECT count(*) FROM parameter where CODE = '1090'}
insert into parameter (ID, TYPE, CODE, VALUE, ISVISIBLE, ISEDITABLE, REMARK, UPDATETIME, UPDATEBY, UNIT)
values (17080701, '10', '1090', '0', 1, 1, '是否开启票价差额功能: 0否,1是;控制范围包含售票点票价差额,线路售票点票价差额,售票点票种差额', sysdate, 0, '');
--end--
--增加参数 孙越 2017年8月17日 13:57:15 --
@repeat{SELECT count(*) FROM parameter where CODE = '0040'}
insert into parameter (ID, TYPE, CODE, VALUE, ISVISIBLE, ISEDITABLE, REMARK, UPDATETIME, UPDATEBY, UNIT)
values (17081701, '00', '0040', '5', 0, 0, '心跳频率: N秒一次,设置为0时不请求. 默认为5,单位秒,修改本参数后重新登陆客户端才会生效', sysdate, 0, '');
--end--

--begin zhaohuaihu 20170824 #11365 增加参数
@repeat{SELECT count(*) FROM parameter where CODE = '6071'}
insert into parameter (ID, TYPE, CODE, VALUE, ISVISIBLE, ISEDITABLE, REMARK, UPDATETIME, UPDATEBY, UNIT)
values (82471, '60', '6071', '0', 1, 1, '安检通知单允许重新打印次数。若参数为0则不限制重打次数，默认值为0。', sysdate, 0, '次');
--end  zhaohuaihu 20170824 增加参数
--begin 孙越  2017年9月5日 09:53:31 增加参数
@repeat{SELECT count(*) FROM parameter where CODE = '8028'}
insert into parameter (ID, TYPE, CODE, VALUE, ISVISIBLE, ISEDITABLE, REMARK, UPDATETIME, UPDATEBY, UNIT)
values (17090501, '80', '8028', '0', 1, 1, '小件寄存打印寄存单存单联，默认为0，0：不打印存单联，1：打印存单联', sysdate, 0, '次');
--end --
--begin 孙越 2017年10月10日 16:56:13 隐藏参数
@repeat{SELECT 1-count(*) FROM parameter where CODE = '3018'}
update parameter t set t.isvisible = 0 where t.code = '3018';
--end
--begin 孙越 2017年10月18日 10:04:57 隐藏参数
@repeat{SELECT 1-count(*) FROM parameter where CODE = '1107'}
update parameter t set t.REMARK = '退票手续费计算方式，0表示票价*退票手续费率，1表示（票价-票价分项和）*退票手续费率+票价分项和，2表示票价*退票手续费率+票价分项和，3（票价-4）*退票手续费率+4，默认为0' where t.code = '1107';
--end
--begin 孙越  2017年10月30日 09:14:16  增加参数
@repeat{SELECT count(*) FROM parameter where CODE = '2083'}
insert into parameter (ID, TYPE, CODE, VALUE, ISVISIBLE, ISEDITABLE, REMARK, UPDATETIME, UPDATEBY, UNIT)
values (17103001, '20', '2083', '0', 1, 1, 'IC卡报班时是否开启线路标志牌有效期验证, 0:不校验,1:校验 ,默认为0', sysdate, 0, '');
@repeat{SELECT count(*) FROM parameter where CODE = '2084'}
insert into parameter (ID, TYPE, CODE, VALUE, ISVISIBLE, ISEDITABLE, REMARK, UPDATETIME, UPDATEBY, UNIT)
values (17103002, '20', '2084', '0', 1, 1, 'IC卡报班时是否开启经营许可证有效期验证, 0:不校验,1:校验,默认值为0', sysdate, 0, '');
--end  孙越  2017年10月30日 09:14:11 增加参数
--begin 仉喜宝  2017年11月8日   增加参数
@repeat{SELECT count(*) FROM parameter where CODE = '2085'}
insert into parameter (ID, TYPE, CODE, VALUE, ISVISIBLE, ISEDITABLE, REMARK, UPDATETIME, UPDATEBY, UNIT)
values (17103003, '20', '2085', '0', 1, 1, 'IC卡报班的手工报班时是否开启证件扫码校验，0：不需要校验，1：需要校验，默认为0', sysdate, 0, '');
--end  仉喜宝  2017年11月8日   增加参数
--begin 仉喜宝  2017年11月15日   增加参数
@repeat{SELECT count(*) FROM parameter where CODE = '3089'}
insert into parameter (ID, TYPE, CODE, VALUE, ISVISIBLE, ISEDITABLE, REMARK, UPDATETIME, UPDATEBY, UNIT)
values (17103004, '30', '3089', '0', 1, 1, '结算单补录是否领用票据，0不领用，1领用，默认0', sysdate, 0, '');
--end  仉喜宝  2017年11月15日   增加参数

--begin 仉喜宝  2017年12月18日17:23:24 增加参数
@repeat{SELECT count(*) FROM parameter where CODE = '8037'}
insert into parameter (ID, TYPE, CODE, VALUE, ISVISIBLE, ISEDITABLE, REMARK, UPDATETIME, UPDATEBY, UNIT)
values (171218, '80', '8037', '0', 1, 1, '行包受理时是否打印粘帖单，0：不打印，1：打印，默认为0', sysdate, 0, '是否');
--end --

--begin dongy 2018年1月10日 18:12:20增加参数 4069 :结算单结算是否需要领用结算通知单，0不需要，1需要，默认0
@repeat{SELECT count(*) FROM parameter where CODE = '4069'}
insert into parameter (ID, TYPE, CODE, VALUE, ISVISIBLE, ISEDITABLE, REMARK, UPDATETIME, UPDATEBY, UNIT)
values (18011001, '40', '4069', '0', 1, 1, '结算单结算是否需要领用结算通知单，0不需要，1需要，默认0', sysdate, 0, '');
--end --
--begin zqf 2018年2月8日16:18:55 结算单补录中站务费的取值方式 start
@repeat{SELECT count(*) FROM parameter where CODE = '3080'}
insert into parameter (ID, TYPE, CODE, VALUE, ISVISIBLE, ISEDITABLE, REMARK, UPDATETIME, UPDATEBY, UNIT)
values (3080, '30', '3080', '0', 1, 1, '结算单补录中站务费的取值方式：0：表示来源位现金或者手工时取票价分项中的站务，1：表示任何来源都取票价分项中的站务费,默认为0', sysdate, 0, null);
--begin zqf 2018年2月8日16:18:55 结算单补录中站务费的取值方式 end