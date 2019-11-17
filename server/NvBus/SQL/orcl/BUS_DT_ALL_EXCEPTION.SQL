@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0001}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('1', '0001', '该班次号已经存在', '添加班次信息');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0002}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('2', '0002', '班次编码生成失败', '添加班次信息');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0003}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('3', '0003', '班次信息删除失败', '删除失败班次信息');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0004}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('4', '0004', '该线路停靠点已存在', '添加、修改线路停靠点');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0005}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('5', '0005', '该线路已经被班次使用', '删除线路');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0006}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('6', '0006', '品牌+型号已存在', '添加、修改车辆品牌型号');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0007}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('7', '0007', '该车辆品牌型号已经被车牌引用', '删除车辆品牌型号');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0008}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('8', '0008', '该空间名称已存在', '添加、修改车辆内部空间');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0009}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('9', '0009', '该停靠点已经添加', '添加班次停靠点');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0010}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('10', '0010', '非本站添加的共享数据不允许编辑', '编辑共享数据');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0011}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('11', '0011', '车辆座位图为空不能保存', '编辑车辆座位图');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0012}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('12', '0012', '长停日期段不交叉或者重复', '添加班次长停信息');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0013}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('13', '0013', '该车站的检票口已经被使用', '删除检票口信息');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0014}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('14', '0014', '该车站的检票口已经存在', '添加检票口信息');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0015}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('15', '0015', '该上车卡位已被班次停靠点使用', '删除上车卡位');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0016}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('16', '0016', '该代码已经存在，请重新输入', '添加票价公式组成项');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0017}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('17', '0017', '该驾驶员已经安排进运行计划，不能删除!', '删除驾驶员档案');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0018}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('18', '0018', '该车型已添加，请重新选择车型！', '添加车型相关的票价公式组成项');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0019}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('19', '0019', '该线路的计算值已经存在', '添加线路相关的票价公式组成项');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0020}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('20', '0020', '该打印模板类型名称已经存在', '添加、修改打印模板类型');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0021}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('21', '0021', '该打印模板类型明细名称已经存在', '添加、修改打印模板类型明细');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0022}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('22', '0022', '该打印模板类型明细编码已经存在', '添加、修改打印模板类型明细');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0023}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('23', '0023', '该打印模板类型已经被使用', '删除打印模板类型');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0024}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('24', '0024', '该打印模板类型明细已经被使用', '删除打印模板类型明细');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0025}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('25', '0025', '该打印模板名称已经存在', '添加、修改打印模板');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0026}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('26', '0026', '该线路停靠点的计算值已经存在', '添加、修改票价公式项目');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0027}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('27', '0027', '该票价公式项目已经被使用，不允许删除', '删除票价公式项目');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0028}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('28', '0028', '里程区间不能交叉', '添加票价公式项目');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0029}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('29', '0029', '票价区间不能交叉', '添加票价公式项目票价');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0030}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('30', '0030', '该客运站等级的计算值已经添加', '添加票价公式项目票价');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0031}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('31', '0031', '该公路等级的计算值已经存在', '添加票价公式项目票价');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0032}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('32', '0032', '该车型公路等级的计算值已经存在', '添加票价公式项目票价');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0033}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('33', '0033', '该工号已经存在，请重新输入!', '添加驾乘人员档案信息');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0034}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('34', '0034', '该班次的计算值已经存在', '添加票价公式项目票价');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0035}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('35', '0035', '票价公式日期段不能交叉', '添加或修改票价公式');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0036}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('36', '0036', '票价公式组成项目表达式相关不能再引用表达式', '添加或修改票价公式组成项目');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0037}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('37', '0037', '该车属单位班次的计算费用已经存在', '添加票价公式组成项目车属单位班次相关');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0038}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('38', '0038', '移动电话已经存在，请重新输入', '添加顾客信息');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0039}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('39', '0039', '该循环组还存在循环明细信息不允许删除', '删除循环组信息');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0040}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('40', '0040', '该循环的班次已经添加', '添加循环班次');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0041}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('41', '0041', '该循环的班次在其他组的同样日期中已经添加', '添加循环班次');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0042}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('42', '0042', '该车辆循环信息已经添加', '添加循环车辆信息');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0043}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('43', '0043', '该机构的电脑IP已经存在，如要操作请选中后，对其进行修改', '添加检票控制 ，售票控制');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0044}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('44', '0044', '该机构的全票票价公式未设置或者已过期', '生成标准票价');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0045}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('45', '0045', '该机构的半票票价公式未设置或者已过期', '生成标准票价');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0046}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('46', '0046', '该机构的学生票票价公式未设置或者已过期', '生成标准票价');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0047}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('47', '0047', '该票价公式的组成项不存在！', '生成标准票价');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0048}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('48', '0048', '票价项目中该公里区间未设置！', '生成标准票价');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0049}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('49', '0049', '票价公式中的表达式除数不能为零！', '生成标准票价');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0050}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('50', '0050', '票价公式中有且仅能包含一项基础运价项目', '添加票价公式');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0051}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('51', '0051', '该机构的上限票价公式未设置或者已过期', '生成标准票价');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0052}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('52', '0052', '您当前没有可用的票据，请先领用', '初始化当前票据');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0053}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('53', '0053', '你输入的票号与正在使用的票号不一致，当前票号为：', '初始化当前票据');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0054}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('54', '0054', '生成计划的开始日期不能大于结束日期', '生成营运计划');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0055}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('55', '0055', '生成计划的开始日期不能小于当天', '生成营运计划');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0056}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('56', '0056', '节日日期不能交叉！', '添加节日信息');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0057}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('57', '0057', '该节日名称已经存在！', '添加节日信息');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0058}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('58', '0058', '该空间已经被座位图引用', '删除空间');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0059}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('59', '0059', '该名称的票种已经存在', '添加、修改票种信息');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0060}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('60', '0060', '该代码的票种已经存在', '添加、修改票种信息');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0061}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('61', '0061', '已经是第一条记录了！', '上移票种');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0062}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('62', '0062', '已经是最后一条记录了！', '下移票种');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0063}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('63', '0063', '节日票价日期不能交叉！', '添加节日票价');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0064}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('64', '0064', '该班次已经报到！', '班次报到');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0065}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('65', '0065', '该班次已经报停，不许报到！', '班次报到');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0066}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('66', '0066', '该班次已经被并，不许报到！', '班次报到');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0067}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('67', '0067', '该班次始发站还未报到，配客站不许报到！', '班次报到');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0068}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('68', '0068', '报到车辆座位数小于该班次座位数，不许报到！', '班次报到');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0069}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('69', '0069', '报到车辆座位数小于该班次已售座位数，不许报到！', '班次报到');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0070}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('70', '0070', '该班次已经取消报到', '取消报到');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0071}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('71', '0071', '该班次已经发班，不允许取消报到', '取消报到');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0072}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('72', '0072', '该班次已有检票记录，不允许取消报到', '取消报到');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0073}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('73', '0073', '不允许取消其他机构的报到班次', '取消报到');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0074}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('74', '0074', '该晚点违约金已经结算，不允许取消报到', '取消报到');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0075}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('75', '0075', '该班次已经报到不允许进行脱班操作', '脱班操作');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0076}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('76', '0076', '流水班不需要进行脱班操作', '脱班操作');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0077}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('77', '0077', '计划车辆与脱班车辆不一样，不需要进行脱班操作', '脱班操作');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0078}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('78', '0078', '计划营运单位与脱班车辆的营运单位不一样，不需要进行脱班操作', '脱班操作');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0079}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('79', '0079', '流水班不需要进行顶班操作', '顶班操作');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0080}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('80', '0080', '该班次已经报到不允许进行顶班操作', '顶班操作');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0081}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('81', '0081', '当前营运单位、车辆与原计划一样，无需进行顶班操作', '顶班操作');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0082}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('82', '0082', '操作的二个班次不是同一线路，不能进行并班！', '班次并班');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0083}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('83', '0083', '两个班次的发车站和终点站不完全相同，不能进行并班！', '班次并班');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0084}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('84', '0084', '计划并入班次的剩余座位数小于被并班次的已售座位数，不能进行并班！', '班次并班');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0085}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('85', '0085', '原班次已经报到，不能进行并班！', '班次并班');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0086}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('86', '0086', '计划并入班次与原班次价格不一致，不能进行并班！', '班次并班');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0087}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('87', '0087', '被并的班次已经过了发车时间，不能进行并班！', '班次并班');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0088}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('88', '0088', '该车辆与对应的日期找不到相应的计划车辆！', '班次并班');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0089}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('89', '0089', '该计划车辆还没有生成相应的座位号', '售票座位号');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0090}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('90', '0090', '该班次已经报到不允许进行停售操作', '停售操作');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0091}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('91', '0091', '该计划班次还没有售票', '车票销售');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0092}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('92', '0092', '不能操作以前的业务数据', '综合调度操作');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0093}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('93', '0093', '该班次状态已经改变，请重新查询！', '综合调度操作');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0094}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('94', '0094', '不允许对其他机构的班次进行停班操作！', '停班操作');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0095}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('95', '0095', '该班次已经报到不允许进行报停操作！', '报停操作');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0096}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('96', '0096', '该班次已经售票不允许进行报停操作！', '报停操作');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0097}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('97', '0097', '该班次已经报停！', '发售、顶班、脱班、发售、操作');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0098}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('98', '0098', '该班次已经报停无需进行停售操作！', '停售操作');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0099}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('99', '0099', '计划并入班次已经过了发车时间，不能并入！', '班次并班');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0100}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('100', '0100', '该班次本站已有售票，不允许放空', '放空操作');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0101}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('101', '0101', '对不起，新班次已检票，不能取消并班！', '班次并班');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0102}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('102', '0102', '对不起，新班次已经发车，不能取消并班！', '班次并班');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0103}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('103', '0103', '该班次还没设置班次循环', '生成标准票价');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0104}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('104', '0104', '你输入的站点已经存在', '组织机构');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0105}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('105', '0105', '你输入的车属单位已经存在', '组织机构');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0106}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('106', '0106', '该机构对应的角色已经存在，请重新输入', '添加，修改角色');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0107}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('107', '0107', '该角色已经被使用，不能删除！', '删除角色');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0108}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('108', '0108', '您输入的用户或者密码有误，请重新输入！', '用户登录');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0109}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('109', '0109', '您的账号已被锁定，请与系统管理员联系！', '用户登录');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0110}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('110', '0110', '该编码已经存在，请重新输入', '部门');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0111}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('111', '0111', '该名称已经存在，请重新输入', '部门');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0112}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('112', '0112', '证件类型和证件号已经存在，请重新输入!', '添加顾客信息');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0113}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('113', '0113', '该身份证号已经存在，请重新输入!', '添加驾乘人员档案信息');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0114}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('114', '0114', '该IC卡号已经存在，请重新输入!', '添加驾乘人员档案信息');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0115}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('115', '0115', '该机构的工号已经存在，请重新输入!', '添加员工档案信息');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0116}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('116', '0116', '该车票不存在！', '获取车票信息');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0117}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('117', '0117', '该车票已检！', '检票操作');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0118}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('118', '0118', '该班次还未报到，请稍等！', '检票操作');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0119}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('119', '0119', '该班次还未开始检票，请稍等！', '检票操作');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0120}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('120', '0120', '该班次还未到检票时间，请稍等！', '检票操作');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0121}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('121', '0121', '该车票已退！', '检票操作');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0122}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('122', '0122', '该车票已作废！', '检票操作');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0123}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('123', '0123', '该险种已找到子记录，所以不能删除', '险种');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0124}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('124', '0124', '该送票ID与票号已经存在，请重新输入', '送票明细');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0125}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('125', '0125', '该车票已经打结算单，不能取消检票', '取消检票');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0126}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('126', '0126', '不能取消它站检的车票！', '取消检票');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0127}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('127', '0127', '该用户已经在线！', '	用户登录');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0128}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('128', '0128', '该送票记录已有明细，所以不能删除', '送票登记');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0129}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('129', '0129', '该票号不存在，请重新输入', '送票明细');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0130}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('130', '0130', '该票号已送，请重新输入', '送票明细');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0131}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('131', '0131', '该日期没有班次营运计划！', '综合调度/车辆报到');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0132}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('132', '0132', '该车票还未检！', '退检操作');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0133}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('133', '0133', '该车票已过期', '混检操作');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0134}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('134', '0134', '不同线路的班次不允许混检,', '混检操作');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0135}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('135', '0135', '检入班次没有该车票的停靠站点！', '混检操作');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0136}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('136', '0136', '检入班次不允许混检！', '混检操作');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0137}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('137', '0137', '检入班次已经没有空位可检！', '混检操作');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0138}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('138', '0138', '检入班次的座位信息已经发生变化，请重新检入！', '混检操作');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0139}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('139', '0139', '流水班次不允许混检到流水班次！', '混检操作');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0140}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('140', '0140', '流水班次不允许混检到非流水班次！', '混检操作');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0141}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('141', '0141', '非流水班次不允许检可混检到流水班次！', '混检操作');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0142}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('142', '0142', '免费带儿童数已经超出该班次限定的人数！', '混检操作');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0143}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('143', '0143', '您的票据已经用完！', '发班打印结算单');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0144}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('144', '0144', '您的票据当前号码与系统的号码不一致，请重置票号！', '发班打印结算单');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0145}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('145', '0145', '请选择你要打单的报到车辆！', '发班打印结算单');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0146}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('146', '0146', '该扣费项目名称已经存在，请重新输入！', '添加、修改扣费项目名称');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0147}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('147', '0147', '该扣费项目已经审核通过不允许删除！', '删除扣费项目名称');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0148}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('148', '0148', '该班次运行计划为空', '调度留位');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0149}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('149', '0149', '该班次已发车，不能进行留位', '调度留位');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0150}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('150', '0150', '该座位号的状态不能进行预留位', '调度留位座位状态');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0151}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('151', '0151', '该班次运行计划下面还没有班次状态', '调度留位、班次状态');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0152}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('152', '0152', '该扣费项目已被使用，不允许删除！', '删除结算固定扣费项目');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0153}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('153', '0153', '所属扣费项目不能为自身！', '添加、修改结算固定扣费项目');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0154}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('154', '0154', '对不起你登记的结束票号不能大于领用的结束票号', '坏票登记');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0155}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('155', '0155', '里程区间不能交叉', '添加、修改固定相关扣费项目');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0156}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('156', '0156', '票价区间不能交叉', '添加、修改固定相关扣费项目');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0157}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('157', '0157', '已经存在票价相关扣费，不能再添加其他相关！', '添加固定相关扣费项目');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0158}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('158', '0158', '已经存在里程相关扣费，不能再添加其他相关！', '添加固定相关扣费项目');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0159}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('159', '0159', '座位号不是你锁定的，所以不能将其进行留位，请重新选择', '调度留位');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0160}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('160', '0160', '应用的日期段不能交叉！', '添加结算固定扣费项目应用');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0161}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('161', '0161', '该扣费应用已经审核，不能删除', '删除结算固定扣费项目应用');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0162}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('162', '0162', '你输入的车票类型可售权限控制信息已经存在，请重新输入！', '车票类型可售权限控制');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0163}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('163', '0163', '该扣费应用已经审核过！', '审核结算固定扣费项目应用');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0164}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('164', '0164', '该扣费应用还未审核！', '取消审核结算固定扣费项目应用');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0165}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('165', '0165', '你输入的公式有误，请检查！', '添加、修改结算公式');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0166}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('166', '0166', '该结算公式已经审核，不能删除！', '删除结算公式');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0167}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('167', '0167', '你要签手续费率的车票不存在', '签票');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0168}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('168', '0168', '你要签手续费率的车票已经退票', '签票');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0169}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('169', '0169', '你要签手续费率的车票已经废票', '签票');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0170}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('170', '0170', '要打印的当前票号与数据库不一致', '打印');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0171}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('171', '0171', '当前票段剩余票数不够打印', '打印');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0172}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('172', '0172', '找不到对应的保险单', '退保险');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0173}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('173', '0173', '该保险单状态为已退，不允许退保险', '退保险');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0174}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('174', '0174', '该保险单状态为已废，不允许退保险', '退保险');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0175}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('175', '0175', '找不到对应的车票', '退票');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0176}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('176', '0176', '该车票状态为已退，不允许退票', '退票');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0177}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('177', '0177', '该车票状态为已废，不允许退票', '退票');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0178}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('178', '0178', '该车票已经检票，不允许退票', '退票');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0179}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('179', '0179', '该车票所在的班次已经发班，不允许普通退票。请先签定手续费率或使用其它退票方式', '退票');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0180}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('180', '0180', '该公式扣费名称已经存在，请重新输入！', '添加、修改公式扣费项目');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0181}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('181', '0181', '对不起，该结算单补录子表还存有记录，不能删除！', '结算单补录');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0182}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('182', '0182', '当前站点不是发班站点，不能进行发班操作！', '发班操作');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0183}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('183', '0183', '该班次已经发班！', '发班操作');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0184}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('184', '0184', '找不到对应的保险单', '废保险');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0185}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('185', '0185', '该保险单状态为已退，不允许废保险', '废保险');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0186}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('186', '0186', '该保险单状态为已废，不允许废保险', '废保险');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0187}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('187', '0187', '找不到对应的车票', '废票');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0188}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('188', '0188', '该车票状态为已退，不允许废票', '废票');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0189}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('189', '0189', '该车票状态为已废，不允许废票', '废票');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0190}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('190', '0190', '该车票已经检票，不允许废票', '废票');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0191}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('191', '0191', '废票时间已过，不允许普通废票。请使用特权废票', '废票');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0192}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('192', '0192', '废票不能同时废不同售票员售出的车票', '废票');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0193}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('193', '0193', '该报到车辆已经发班！', '发班操作');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0194}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('194', '0194', '该班次已经检满！', '检票操作');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0195}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('195', '0195', '该班次已发班，请使用补检功能进行检票', '检票操作');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0196}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('196', '0196', '传入的当前票号与数据库不一致', '售票');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0197}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('197', '0197', '当前票段剩余票数不够', '售票');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0198}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('198', '0198', '该班次已发班', '售票');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0199}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('199', '0199', '该班次班次已报停', '售票');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0200}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('200', '0200', '该班次班次已被并', '售票');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0201}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('201', '0201', '该班次班次已脱班', '售票');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0202}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('202', '0202', '该班次班次已停售', '售票');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0203}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('203', '0203', '班次状态记录不存在', '售票');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0204}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('204', '0204', '班次座位记录不存在', '售票');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0205}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('205', '0205', '座位不是锁定状态,请刷新页面重新卖票', '售票');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0206}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('206', '0206', '锁位记录不存在', '售票');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0207}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('207', '0207', '留座位记录不存在,无法售出留座。', '售票');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0208}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('208', '0208', '留座位记录状态为已取消,无法售出留座。', '售票');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0209}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('209', '0209', '留座位记录状态为已售,无法售出留座。', '售票');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0210}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('210', '0210', '票价不同不允许改签', '改签');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0211}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('211', '0211', '改签要求上车点和下车点与原票一致', '改签');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0212}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('212', '0212', '改签要求线路与原票一致', '改签');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0213}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('213', '0213', '原车票所在班次已发班不允许改签', '改签');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0214}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('214', '0214', '找不到对应要改签的车票', '退票');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0215}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('215', '0215', '原车票状态为已退，不允许改签', '退票');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0216}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('216', '0216', '原车票状态为已废，不允许改签', '退票');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0217}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('217', '0217', '原车票已经检票，不允许改签', '退票');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0218}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('218', '0218', '该结算单已经结算不能删除其扣费信息！', '删除结算单扣费明细');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0219}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('219', '0219', '该功能名称已经存在', '添加、修改功能');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0220}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('220', '0220', '该功能GUID已经存在', '添加、修改功能');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0221}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('221', '0221', '该子功能GUID已经存在', '添加、修改子功能');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0222}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('222', '0222', '该功能存在子功能，请先删除子功能', '删除功能');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0223}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('223', '0223', '废保险票不能同时废不同售票员售出的保险票', '废保险票');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0224}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('224', '0224', '该IC卡号已经被使用！', '添加、修改车辆信息');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0225}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('225', '0225', '班次保底数不能大于车辆核定座位数！', '班次保底数设置');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0226}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('226', '0226', ' 该车票缴款起始号这条记录已经缴款，不能再进行缴款！', '售票员缴款');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0227}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('227', '0227', ' 该保险缴款起始号这条记录已经缴款，不能再进行缴款！', '售票员缴款');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0228}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('228', '0228', '该车牌号码已经存在！', '添加车辆信息');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0229}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('229', '0229', '您输入的车辆IC卡不存在，请重新输入！', '添加车辆信息');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0230}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('230', '0230', '您输入的车辆IC卡已经挂失，请重新输入！', '添加车辆信息');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0231}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('231', '0231', '您输入的车辆IC卡已经作废，请重新输入！', '添加车辆信息');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0232}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('232', '0232', '您输入的车辆IC卡已经过期，请重新输入！', '添加、修改车辆信息');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0233}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('233', '0233', '该IC卡没有对应的车辆信息！', '车辆IC卡报到');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0234}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('234', '0234', '该车辆当天没有营运信息！', '车辆IC卡报到');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0235}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('235', '0235', '该车辆已经注销不能报到！', '车辆IC卡报到');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0236}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('236', '0236', '系统不存在该IC卡信息！', '车辆IC卡报到');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0237}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('237', '0237', '该IC卡已经挂失，不能报到！', '车辆IC卡报到');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0238}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('238', '0238', '该IC卡已经作废，不能报到！', '车辆IC卡报到');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0239}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('239', '0239', '该IC卡已经过期，不能报到！', '车辆IC卡报到');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0240}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('240', '0240', '您输入的车辆IC卡已经被使用，请重新输入！', '添加、修改车辆信息');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0241}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('241', '0241', '找不到对应的售票点，登录失败', '登录');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0242}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('242', '0242', '用户所属机构与售票点所属机构不一致，不允许登录', '登录');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0243}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('243', '0243', '与对应的类型已经存在，请重新输入！', '智能卡初始化');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0244}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('244', '0244', '该智能卡IC卡硬件序列号已经存在，请重新输入', '智能卡初始化');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0245}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('245', '0245', '该对象名称已经发卡，请重新选择！', '智能卡管理');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0246}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('246', '0246', '已经存在交叉票号，请重新设置！', '票据入库');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0247}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('247', '0247', '该线路名称已存在', '添加、修改线路');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0248}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('248', '0248', '该机构名称已经存在！', '添加、修改机构');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0249}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('249', '0249', '该机构编码已经存在！', '添加、修改机构');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0250}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('250', '0250', '该用户帐号已使用，请更换！', '添加用户');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0251}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('251', '0251', '该票库名称已经存在，请重新输入！', '添加票库');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0252}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('252', '0252', '该票库编码已经存在，请重新输入！', '添加票库');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0253}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('253', '0253', '已设置了可售类型为全部，不必再单独设置！', '添加售票控制');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0254}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('254', '0254', '对不起，你输入的车辆信息在安检计划中不存在，请重新输入！', '车辆安检');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0255}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('255', '0255', '该站点已被使用，不能被删除！', '删除站点');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0256}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('256', '0256', '车辆安检计划的日期段不能交叉，请重新输入！', '安检计划');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0257}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('257', '0257', '对不起，你所在的机构下面已经有相同的保险公司了', '添加保险公司');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0258}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('258', '0258', '该险种的产品编码已经存在！', '添加保险类型明细');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0259}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('259', '0259', '该险种的保险责任名称已经存在！', '添加保险类型明细');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0260}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('260', '0260', '相同的车站不能存在相同的产品编码！', '添加保险类型');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0261}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('261', '0261', '该车站已经存在相同的保险公司和产品名称！', '添加保险类型');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0262}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('262', '0262', '该保险公司已找到关联的记录，不能被删除！', '删除保险公司');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0263}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('263', '0263', '座位不是售出状态', '退票废票');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0264}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('264', '0264', '该票对应的班次已发班，不能再送票', '送票登记');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0265}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('265', '0265', '该车票所在的班次已过发车时间，不允许普通退票。请先签定手续费率或使用其它退票方式', '退票');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0266}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('266', '0266', '在指定合同期内该承包车已经被其他人承包,请重新输入', '添加或修改承包者档案');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0267}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('267', '0267', '该合同编码已经存在，请重新输入!', '添加后修改档案信息');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0268}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('268', '0268', '该模版班次不存在该车型的硬调票价！', '加班操作');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0269}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('269', '0269', '该模版班次不存在该车型的公式票价！', '加班操作');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0270}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('270', '0270', '该班次带儿童数量超过最大允许带儿童数量', '售票');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0271}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('271', '0271', '原班次已经处于被并状态，不能再进行并班！', '班次并班');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0272}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('272', '0272', '该乘务员已经安排进运行计划，不能删除!', '删除乘务员档案');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0273}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('273', '0273', '该票据类型名称已经存在，请重新输入！', '票据类型增加');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0274}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('274', '0274', '该票据类型编码已经存在，请重新输入！', '票据类型增加');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0275}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('275', '0275', '该机构的机器已经添加控制！', '添加售票控制');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0276}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('276', '0276', '该编码已经存在，请重新输入！', '添加车型');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0277}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('277', '0277', '该名称已经存在，请重新输入！', '添加车型');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0278}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('278', '0278', '该类型、级别对应的座位数已经存在，请重新输入！', '添加车型');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0279}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('279', '0279', '该车票已过检票时间，请使用补检功能进行检票！', '检票');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0280}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('280', '0280', '该班次还未报到！', '补开结算单');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0281}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('281', '0281', '对不起，你输入的编码已经存在，请重新输入！', '添加区域');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0282}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('282', '0282', '对不起，你输入的名称已经存在，请重新输入！', '添加区域');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0283}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('283', '0283', '对不起，你输入的全称已经存在，请重新输入！', '添加区域');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0284}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('284', '0284', '同一班次同一车型的日期段不能交叉！', '添加班次固定留位');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0285}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('285', '0285', '同线路的其他班次该车型的日期段已经存在固定留位信息！', '添加班次固定留位');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0286}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('286', '0286', '乘客座位数与该厂牌的座位数不一致，请重新输入！', '添加、修改车辆信息');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0287}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('287', '0287', ' 系统还未设置或者应用客运代理费公式！', '发班操作');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0288}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('288', '0288', '票号已被使用', '小件寄存');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0289}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('289', '0289', '该线路路段信息还未添加！', '生成公式票价');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0290}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('290', '0290', '该车票非本日发车！', '综合检票');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0291}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('291', '0291', '该日期段已经有营运计划，请先删除！', '添加、修改长停信息');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0292}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('292', '0292', '该车辆还未安检，不允许报到！', 'IC卡报班');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0293}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('293', '0293', '该车辆安检不合格，不允许报到！', 'IC卡报班');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0294}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('294', '0294', '该车辆没有安检计划，不允许报到！', 'IC卡报班');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0295}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('295', '0295', '该已经发班，不允许退检！', '退检操作');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0296}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('296', '0296', '该座位已经售出，不能锁定', '售票');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0297}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('297', '0297', '该座位已被他人锁定，不能锁定', '售票');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0298}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('298', '0298', '剩余座位数不够', '售票');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0299}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('299', '0299', '该班次已开结算单，不允许取消发班！', '取消发班');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0300}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('300', '0300', '该班次已结算，不允许取消发班！', '取消发班');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0301}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('301', '0301', '该班次还未发班，不需要取消发班！', '取消发班');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0302}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('302', '0302', '该班次未来还有营运计划，不允许删除！', '删除班次信息');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0303}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('303', '0303', '未到发班时间，不允许发班！', '发班打单');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0304}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('304', '0304', '报到车辆的座位数小于该班次最大的非空座座位号，不允许报到！', '车辆报到');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0305}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('305', '0305', '该班次未设置下车停靠站点！', '生成公式票价');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0306}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('306', '0306', '该车辆该项目的打印设置已经添加！', '添加、修改打印项目打印设置');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0307}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('307', '0307', '该车票已检票，不能再售保险', '单独售保险');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0308}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('308', '0308', '计划并入班次已经发班，不能进行并班！', '班次并班');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0309}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('309', '0309', '对不起，该班次已经结算，不能补开！', '注销结算单');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0310}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('310', '0310', '该结算单已结算，不允许换车重打！', '换车重打');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0311}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('311', '0311', '该结算单已注销，不允许换车重打！', '换车重打');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0312}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('312', '0312', '新车辆座位数小于已售座位数，不允许更换！', '换车重打');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0313}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('313', '0313', '新车辆座位数小于该班次最大的非空座座位号，不允许更换！', '换车重打');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0314}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('314', '0314', '还没有做营运计划，不能进行调整！', '营运计划调整');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0315}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('315', '0315', '车辆预缴款金额发生变动，请重新查询！', '结算单结算');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0316}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('316', '0316', '补录金额发生变动，请重新查询后结算！', '结算单结算');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0317}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('317', '0317', '该扣费项目已经应用不允许删除！', '删除固定扣费项目');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0318}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('318', '0318', '该线路停靠点已经在班次停靠点中使用', '删除线路停靠点');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0319}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('319', '0319', '该班次已经设置了班次循环，不允许删除！', '删除班次');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0320}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('320', '0320', '该车辆品牌型号已经被车辆循环引用', '删除车辆品牌型号');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0321}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('321', '0321', '该票价组成项已经生成了公式票价分项，不允许删除！', '删除票价公式组成项');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0322}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('322', '0322', '票价公式中包含该票价分项，不允许删除！', '删除票价公式组成项');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0323}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('323', '0323', '调整后的座位数不能小于已售座位数+留位数！', '座位数调整');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0324}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('324', '0324', '调整后的票价不能小于票价分项的总和！', '票价调整');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0325}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('325', '0325', '停靠点的里程和结算里程在停靠点列表中的序号不一致', '添加停靠点');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0326}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('326', '0326', '停靠点的里程或结算里程设置不允许大于后站里程且不能小于前站里程', '修改线路停靠点');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0327}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('327', '0327', '该售票点名称已经存在，请重新输入！', '添加售票点');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0328}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('328', '0328', '一个机构只能有一个站内售票点，该机构站内售票点已经存在！', '添加售票点');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0329}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('329', '0329', '新添加的停靠点里程不能小于始发站里程', '添加停靠点');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0330}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('330', '0330', '新添加的停靠点结算里程不能小于始发站结算里程', '添加停靠点');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0331}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('331', '0331', '新添加的停靠点里程不能大于始发站里程', '添加停靠点');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0332}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('332', '0332', '新添加的停靠点结算里程不能大于始发站结算里程', '添加停靠点');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0333}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('333', '0333', '电子票不存在', '电子票取票');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0334}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('334', '0334', '该电子票已经取票，不能再取', '电子票取票');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0335}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('335', '0335', '检入班次的座位已检！', '混检操作');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0336}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('336', '0336', '同班次的座位号不允许混检！', '混检操作');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0337}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('337', '0337', '本班次被交换车票的到达站点在检入车票的班次中不存在！', '混检操作');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0338}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('338', '0338', '已过发车时间，不允许混检！', '混检操作');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0339}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('339', '0339', '该班次已经发班，不允许换车报到！', '换车报到');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0340}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('340', '0340', '不存该流水号的车票！', '流水号检票');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0341}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('341', '0341', '该车票不在此检票！', '检票');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0342}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('342', '0342', '该库存已被使用，不能删除 ！', '删除库存');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0343}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('343', '0343', '该票据已经使用过，不能删除！', '删除库存');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0344}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('344', '0344', '换票号重打车票不允许重打他人售出的车票', '重打车票');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0345}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('345', '0345', '该车辆不是营运状态，不允许报到！', '车辆报班');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0346}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('346', '0346', '该电子票还没有取票，不允许重打车票', '重打车票');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0347}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('347', '0347', '系统设置为不打印退票凭证，不允许使用换票号重打退票凭证功能', '重打退票凭证');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0348}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('348', '0348', '原退票没有打印退票凭证,不允许重打', '重打退票凭证');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0349}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('349', '0349', '换票号重打退票凭证不允许重打他人退的车票', '重打退票凭证');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0350}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('350', '0350', '电子票换票号重打车票不允许重打他人取出的电子票', '重打车票');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0351}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('351', '0351', '该班次为发车站专营班次，不允许售联网票', '售票');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0352}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('352', '0352', '该车型没有对应的车辆品牌型号，请先设置品牌型号。', '调整车型');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0353}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('353', '0353', '该车型不存在节日票价和硬调票价，请设计节日票价或者硬调票价！', '调整车型');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0354}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('354', '0354', '流水班次不允许使用补检！', '补检操作');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0355}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('355', '0355', '应缴款金额不是最新金额，请查询后继续缴款。', '售票员营收缴款');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0356}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('356', '0356', '该班次已没有空位，不允许混检！', '混检');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0357}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('357', '0357', '该班次不在本站内运行，不能补开结算单。', '补开结算单');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0358}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('358', '0358', '费率不能小于前一个时间点的费率', '添加、修改退票手续费设置');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0359}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('359', '0359', '费率不能大于后一个时间点的费率', '添加、修改退票手续费设置');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0360}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('360', '0360', '时间点为发车时间的记录不允许删除', '删除退票手续费设置');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0361}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('361', '0361', '该时间点已经存在', '添加、修改退票手续费设置');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0362}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('362', '0362', '超过系统规定的补检时间！', '补检');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0363}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('363', '0363', '找不到该票据领用记录', '票据退领');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0364}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('364', '0364', '退票起始号码不能小于当前号码', '票据退领');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0365}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('365', '0365', '退票结束号码不能大于领用结束号码', '票据退领');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0366}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('366', '0366', '退票起始号码不能大于退票结束号码', '票据退领');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0367}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('367', '0367', '已超过补开结算单天数！', '补开结算单');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0368}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('368', '0368', '已超过注销结算单天数！', '补开结算单');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0369}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('369', '0369', '该车票不在本站检票！', '检票');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0370}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('370', '0370', '该班次报到车辆已发生变化，请重新查询', '发班打印');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0371}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('371', '0371', '已售半票数超出设定比例', '售票');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0372}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('372', '0372', '改签的车票不允许普通退票', '退票');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0373}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('373', '0373', '改签的车票不允许普通废票', '废票');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0374}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('374', '0374', '该停靠点不可售', '售票');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0375}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('375', '0375', '报到车辆未找到可改签的空座，不允许报到！', 'IC卡报到');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0376}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('376', '0376', '报到车辆未找到可固定留位的空座，不允许报到！', 'IC卡报到');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0377}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('377', '0377', '报到车辆未找到自动取消留位的空座，不允许报到！', 'IC卡报到');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0378}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('378', '0378', '报到车辆未找到不自动取消留位的空座，不允许报到！', 'IC卡报到');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0379}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('379', '0379', '报到车辆的座位数小于该班次非空座位数，不允许报到！', 'IC卡报到');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0380}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('380', '0380', '已过安检记录注销时间！', '注销安检记录');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0381}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('381', '0381', '该线路结算对象协议已经设置', '添加、修改结算分层协议');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0382}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('382', '0382', '该班次状态不是正常状态，不能做晚点处理	', '班次晚点处理');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0383}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('383', '0383', '改班次已经报到，不能做晚点处理', '班次晚点处理');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0384}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('384', '0384', '该数据已经添加！', '添加班次预售天数(票种)控制');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0385}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('385', '0385', '该运量单号已经存在！', '发班打印、手工运量');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0386}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('386', '0386', '已经添加其他班线控制,不能添加全部班次,请先删除其他班线', '添加全部班次控制');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0387}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('387', '0387', '车辆违规处理通知单号已经存在，请重新保存！', '添加营运车辆违规处理');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0388}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('388', '0388', '该车辆违规处理通知单已经处理或结算，不能删除！', '删除营运车辆违规处理');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0389}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('389', '0389', '该车辆违规处理通知单已经处理或结算，不能修改！', '修改营运车辆违规处理');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0390}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('390', '0390', '该车辆违规处理通知单已经处理，不需要再次处理！', '处理车辆违规通知单');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0391}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('391', '0391', '该结算单补录信息已经结算，请选择其它信息进行处理！', '结算单补录');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0392}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('392', '0392', '该结算通知单号已经存在！', '结算单结算');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0393}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('393', '0393', '该车站的上车卡位已经存在！', '添加上车卡位信息');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0394}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('394', '0394', '该班次不在预售期内', '售票、锁位');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0395}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('395', '0395', '车辆违规罚金发生变动，请重新查询!', '结算单结算');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0396}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('396', '0396', '该车辆行驶证日期已过期，不能进行安检！', '车辆安检');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0397}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('397', '0397', '该车辆责任险日期已过期，不能进行安检！', '车辆安检');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0398}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('398', '0398', '该车辆交强险日期已过期，不能进行安检！', '车辆安检');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0399}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('399', '0399', '该车辆营运证日期已过期，不能进行安检！', '车辆安检');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0400}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('400', '0400', '该车辆行驶证、责任险、强险、营运证日期未设置完整，请先设置有效日期！', '车辆安检');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0401}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('401', '0401', '该车辆行驶证日期已过期，不允许报班！', 'IC卡报班');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0402}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('402', '0402', '该车辆责任险日期已过期，不允许报班！', 'IC卡报班');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0403}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('403', '0403', '该车辆交强险日期已过期，不允许报班！', 'IC卡报班');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0404}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('404', '0404', '该车辆营运证日期已过期，不允许报班！', 'IC卡报班');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0405}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('405', '0405', '该档次的油价区间已经添加！', '添加油价区间');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0406}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('406', '0406', '营运里程不能交叉！', '添燃油费营运里程');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0407}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('407', '0407', '应用日期不能交叉！', '燃油费应用');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0408}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('408', '0408', '该活动名称已存在，请重新输入！', '添加或修改充值优惠活动管理');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0409}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('409', '0409', '您输入的礼物名称已存在，请重新输入!', '添加或修改会员礼物类型管理');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0410}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('410', '0410', '会员卡充值已经享受了该充值优惠活动，不允许删除!', '删除充值优惠活动');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0411}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('411', '0411', '根据卡号找不到VIP卡信息', 'VIP查找');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0412}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('412', '0412', 'VIP卡当前状态异常', 'VIP使用');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0413}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('413', '0413', 'VIP卡号不允许为空', 'VIP使用');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0414}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('414', '0414', '退票传入的VIP卡号与售票时使用的VIP卡不一致', 'VIP退票');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0415}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('415', '0415', '该VIP卡号已经发给旅客，请选择其它VIP卡', 'VIP发卡');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0416}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('416', '0416', '该会员卡已持车票登记进入贵宾室,不许再登记!', '会员卡登记进入贵宾室');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0417}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('417', '0417', '该卡已经发放过了，请确认！', 'VIP发卡');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0418}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('418', '0418', '选择的班线存在日期交叉，请重新选择', '添加或修改一卡通参与班次');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0419}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('419', '0419', '已经存在,或日期已经交叉，请确认后重新输入！', '添加折扣管理');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0420}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('420', '0420', '你输入的发车时间格式不对，请重新输入！', '加班');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0421}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('421', '0421', '该车站的里程区间段不能交叉，请重新输入！', '保险类型里程相关');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0422}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('422', '0422', '该结算单已经结账，不允许重打！', '重打结算单');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0423}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('423', '0423', '该结算单已经注销，不允许重打！', '重打结算单');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0424}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('424', '0424', '该班次还未打印结算单，不能重打！', '重打结算单');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0425}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('425', '0425', '已超过重打结算单天数！', '重打结算单');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0426}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('426', '0426', '该到达站的平时票价已经添加，请重新输入！', '添加站点平时票价');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0427}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('427', '0427', '该卡已经被使用过，不能再次使用！', '初始化卡/挂失补卡');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0428}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('428', '0428', '系统中存在2辆以上的车与该卡对应，请先修改！', '刷IC卡');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0429}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('429', '0429', '该班次对应车辆已经添加过班次保底数，不允许重复！', '添加或修改班次保底数');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0430}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('430', '0430', '该车辆只能报到车辆指定的线路', '车辆报到');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0431}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('431', '0431', '分段票价不能交叉', '线路票价');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0432}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('432', '0432', '该公式已经在结算扣费公式应用中应用了，不能删除！', '删除结算扣费公式');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0433}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('433', '0433', '隔天班次开运量时必须用补开', '隔天班次开运量');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0434}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('434', '0434', '隔天车票，只能混检到车票当天！', '混检隔天车票');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0435}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('435', '0435', '该车辆的发班里程已大于限制里程,请激活该车辆的里程限制!', '车辆安检或报到');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0436}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('436', '0436', '该车辆还有 ', '剩余公里数或天数提醒');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0437}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('437', '0437', '该车辆已经过了二维有效期! ', '车辆安检或报到');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0438}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('438', '0438', '计划并入班次已经处于被并状态，不能再进行并班！ ', '班次并班');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0439}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('439', '0439', '班次在选择的发车日期当天无班次计划 ', '班次并班');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0440}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('440', '0440', '该车票不存在，或过了补开天数', '正常检过期车票');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0441}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('441', '0441', '检入的班次未报到，不能混检', '车票混检');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0442}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('442', '0442', '要签发的行包站点在该班次线路中不存在', '行包库存');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0443}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('443', '0443', '该设置的里程区间段不能交叉，请重新输入！', '行包收费标准设置');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0444}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('444', '0444', '该行包单号已存在，请重新输入', '到货入仓');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0445}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('445', '0445', '该保管牌号已被使用', '小件寄存');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0446}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('446', '0446', '驾驶证已过期，不允许报班！', '驾驶员报班');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0447}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('447', '0447', '从业资格证已过期，不允许报班！', '驾驶员报班');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0448}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('448', '0448', '准驾证已过期，不允许报班！', '驾驶员报班');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0449}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('449', '0449', '原班次座位已售出且该班次已无空座', '退检');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0450}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('450', '0450', '班次的已售座位发车变化，请重新选择', '班次并班');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0451}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('451', '0451', '并入班次已经报停，不能并班', '班次并班');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0452}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('452', '0452', '并入班次已经脱班，不能并班', '班次并班');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0453}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('453', '0453', '车票已经改签过，只允许改签一次', '改签');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0454}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('454', '0454', '超过允许改签的时间', '改签');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0455}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('16011901', '0455', '该站点已经有营运计划,不允许修改!', '机构管理');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0456}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('456', '0456', '该会员等级已经设置了订票自动取消时间!', '会员订票时间设置');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0457}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('457', '0457', '该站点可售张数已经售完', '售票');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0458}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('458', '0458', '票种可售票数大于系统设定的购卖张数', '售票');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0459}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('459', '0459', '团体票不允许混检！', '混检');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0460}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('460', '0460', '该操作码已经存在，请重新输入！', '添加站点');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0461}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('461', '0461', '未缴款金额达到上限，请先缴款！', '售票员售票');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0462}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('462', '0462', '联网配载班次不允许混检', '混检');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0463}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('463', '0463', '该车辆无安检计划，不允许安检!', '车辆安检');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0464}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('464', '0464', '该车辆出站信息已保存！', '稽查管理');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0465}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('465', '0465', '已过发车时间', '售票');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0466}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('466', '0466', '安检不合格，不打印结算单!', '车辆安检');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0467}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('467', '0467', '基本运价不允许为负数！', '票价');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0468}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('468', '0468', '起始时间不能大于终止时间', '路线票价');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0469}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('469', '0469', '起止时间有交叉，请修改后重试', '路线票价');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0470}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('470', '0470', '不允许改签到低票价班次！', '改签');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0471}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('471', '0471', '该车票已经挂失，不能检票', '检票');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0473}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('473', '0473', '该班次已经有售票记录，不能从跨区配载修改为单营', '修改班次计划');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0474}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('474', '0474', '远程调用失败', '远程调用');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0475}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('475', '0475', '预售车票不允许混检的今天的班次!', '混检');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0476}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('476', '0476', '跨区配载不允许并班', '并班');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0480}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('480', '0480', '该驾驶员没有通过证件核查，不允许报班！', 'IC卡报班');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0481}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('16012901', '0481', '该车辆还未报到！', '出站检查登记表');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0482}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('482', '0482', '售票未上缴金额大于售票站点最大金额，请上缴以后再售票！', '售票');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0483}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('2483', '0483', '要并入的班次已经发班，不能进行并班！', '删除驾驶员档案');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0484}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('484', '0484', 'bus365售保险服务器没有启动，不能售票！', '售票');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0485}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('16111001', '0485', '该车辆进站协议号、有效期未设置完整，请先设置有效期！', 'IC卡报班');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0486}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('16111002', '0486', '该车辆进站协议已过期，不允许报班！', 'IC卡报班');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0499}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('112401', '0499', '第三者责任险已过期,无法进行后续操作！', '报班');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0500}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('112601', '0500', '售票记录密文错误！', '校验售票加密');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0502}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('502', '0502', '单号状态异常', '出库结算/前台结算');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0503}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('503', '0503', '运费或货款与记录不符', '出库结算/前台结算');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0504}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('504', '0504', '该货物已经结算，不能签发！', '行包签发');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0505}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('505', '0505', '未收取运费，不能签发！', '行包签发');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0506}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('506', '0506', '该行包单号不存在！', '行包签发');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0507}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('507', '0507', '该行包已提领出库！', '行包签发');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0508}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('508', '0508', '该行包已作废！', '行包签发');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0509}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('509', '0509', '该行包是到货库存！', '行包签发');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0510}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('510', '0510', '该行包已退票！', '行包签发');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0512}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('512', '0512', '该行包已转至它站！', '行包签发');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0513}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('513', '0513', '该行包已签发出库！', '行包签发');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0514}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('514', '0514', '该行包货款还未回收，不允许签发！', '行包签发');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0515}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('515', '0515', '该行包货款还未回收，不允许签发！', '行包签发');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0516}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('516', '0516', '该车站的票价区间段不能交叉，请重新输入！', '保险类型票价');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0517}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('517', '0517', '自助机或者网站售保,不允许退保险', '退保险');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0518}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('16071501', '0518', '车辆一天只能安检合格一次!', '车辆安检');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0606}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('606', '0606', '行包结算单号已经存在，请重新输入!', '行包结算单补录');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0611}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('6111', '0611', '该车站的票价区间段不能交叉,请重新输入!', '保险类型票价相关');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0617}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('617', '0617', '该车票所属班次不是当前班次，不允许检票！', '混检操作');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0618}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('618', '0618', '当前座位票价与锁位时票价不一致，请重新售票', '售票');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0666}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('666', '0666', '有线路与售票点已经添加过,不允许重复添加!请检查后重新添加!', '售票截止时间控制');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0690}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('690', '0690', '该班次号在此日期段内已经存在班次计划！', '添加班次信息');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0756}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('756', '0756', '该班次剩余未检座位小于连检票数！', '检票操作');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0757}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('757', '0757', '时间段重复或交叉，请重新设置！', '票价差额设置');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0758}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('758', '0758', '同一线路报班间隔不能小于线路中规定的时间', '报班');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0759}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('759', '0759', '驾驶员报班间隔不能小于系统中规定的时间', '报班');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0760}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('760', '0760', '该车辆必须通过GPS安检合格才能报到！', '报班');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0818}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('818', '0818', '要减少的座位在中心存在售票/留位记录，不允许调整！', '综合调度、修改座位数');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0905}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('905', '0905', '该车辆第三者责任险日期已过期，不允许报班！', 'IC卡报班');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 1000}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('1000', '1000', '营收缴款和实际售票营收不一致，请重新查询！', '营收缴款');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 1011}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('10111', '1011', '改班次已关联了其他班次或者被其他班次关联，不能修改！', '修改班次营运类别');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 1012}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('1012', '1012', '编码已存在,请检查！', '数据字典');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 1013}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('10113', '1013', '班次已存在关联班次，不能删除该班次！', '删除班次');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 1014}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('10114', '1014', '班次已经关联了始发站班次，不能进行固定留位！', '固定留位');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 1568}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('1568', '1568', '该帐号不属于该机构不允许登录!', '系统登录');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 6112}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('6112', '6112', '该班次车票已检，无法取消并班！', '取消并班');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 6113}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('6113', '6113', '被并班次座位不为空，无法取消并班！', '取消并班');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 6114}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('6114', '6114', '被并班次无被并信息，无法取消并班！', '取消并班');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 6115}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('6115', '6115', '被并班次无被并信息，并班无法恢复售票！', '并班恢复售票');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 6116}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('6116', '6116', '该单号为异常订单，无法进行退、取、检、废操作!', '异常订单登记');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 6117}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('6117', '6117', '报到车辆座位数小于该班次已售座位号，不允许报到！', '车辆报到');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 6118}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('6118', '6118', '报到车辆相同座位类型小于已售座位类型，不允许报到', '车辆报到');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 6119}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('6119', '6119', '当前机构没有设置上级所属机构！', '登录');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 6120}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('6120', '6120', '当前版本与服务器版本不一致，请升级后重新登录！', '登录');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 91023}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values ('91023', '91023', '数据加密失败', '售票');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0560}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values (560, '0560', '多种座位类型的班次不允许混检！', '综合检票');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0478}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values (0478, '0478', '驾驶员的诚信考核已过期，不允许报班!', 'IC卡报班');
@repeat{SELECT count(*) FROM exceptioninfo where CODE = 0479}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values (0479, '0479', '驾驶员的继续教育考核已过期，不允许报班!', 'IC卡报班');
@repeat{SELECT count(*)-1 FROM exceptioninfo where  code = '0136'}
update exceptioninfo e set e.msg = '检入班次在班次管理中设置了不允许混检!' where e.code = '0136';

