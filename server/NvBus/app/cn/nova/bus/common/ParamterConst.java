package cn.nova.bus.common;

public class ParamterConst { 
	/**
	 * 自动生成班次营运计划的天数
	 */
	public static final String Param_0009 = "0009";
	/**
	 * 是否启用加密2.0版，0否，1是，默认1”，此参数不可见不可编辑
	 */
	public static final String Param_1098 = "1098";
	/**
	 * 比特云加密SN
	 */
	public static final String Param_1099 = "1099";
	
	/**
	 * 是否限制线路停靠点前站里程必须小于后站里程
	 */
	public static final String Param_0012 = "0012";

	/**
	 * 硬调票价中的车型：0：只显示班次循环中的车型,1:显示所有车型
	 */
	public static final String Param_0014 = "0014";
	/**
	 * 燃油费设置是否生成到票价中（结算）1取票价公式组成项中设置的值，0燃油费设置中的值
	 */
	public static final String Param_0015 = "0015";
	/**
	 * 若硬调票价无对应的车型是否取其他车型票价生成营运计划
	 */
	public static final String Param_0016 = "0016";
	/**
	 * 生成半票对于全票的比例
	 */
	public static final String Param_0017 = "0017";

	/**
	 * 票价生成方式：0：线路票价，1：硬调票价 2: 公式票价
	 */
	public static final String Param_0021 = "0021";
	/**
	 * 是否查询其他站结算单,0,否，1：是
	 */
	public static final String Param_0022 = "0022";
	/**
	 * 集中式数据库A站用户是否能登陆B站的售票点
	 */
	public static final String Param_0029 = "0029";
	/**
	 * 是否开启密码复杂度校验, 0:不开启，1：开启  
	 */
	public static final String Param_0035 = "0035";
	
	/**
	 * 密码有效期天数,0 无限制, N表示天数
	 */
	public static final String Param_0036 = "0036";
	
	/**
	 * 登录次数限制  , 0  无限制 , N表示次数
	 */
	public static final String Param_0037 = "0037";
	
	/**
	 * 系统超时时间  , 0：无限制, N表示分钟
	 */
	public static final String Param_0038 = "0038";
	
	/**
	 * 心跳频率: N秒一次, 用于发送请求表明在线状态. 设置为0时不请求. 默认为10,单位秒
	 */
	public static final String Param_0040 = "0040";
	/**
	 * 车辆的里程限制公里数
	 */
	public static final String Param_0142 = "0142";
	/**
	 * 满座班次不要显示。
	 */
	public static final String Param_1001 = "1001";
	/**
	 * 只显示正常班次。
	 */
	public static final String Param_1002 = "1002";
	/**
	 * 将参数1012：班次最多免票带儿童占班次座位数的百分比，单位%，修改为：班次最多免票带儿童数，0固定个数，1班次座位数的百分比，默认为1。
	 */
	public static final String Param_1012 = "1012";

	/**
	 * 已开运量单不显示。
	 */
	public static final String Param_1003 = "1003";
	/**
	 * 普通购票锁位时长，单位为秒钟。
	 */
	public static final String Param_1008 = "1008";
	/**
	 * 订单购票锁位时长，单位为秒钟。
	 */
	public static final String Param_1009 = "1009";
	/**
	 * 补票截止时间。
	 */
	public static final String Param_1015 = "1015";
	/**
	 * 车票预售天数，默认为7天。
	 */
	public static final String Param_1017 = "1017";
	/**
	 * 车票预售天数，默认为7天。
	 */
	public static final String Param_1018 = "1018";
	/**
	 * 站外售票点售票截止时间（距离发班），单位为分钟。
	 */
	public static final String Param_1019 = "1019";
	/**
	 * 报到后才允许售票。
	 */
	public static final String Param_1020 = "1020";
	/**
	 * 是否启用售票机器控制。
	 */
	public static final String Param_1023 = "1023";
	/**
	 * 特权补票能否售已发班班次的车票。
	 */
	public static final String Param_1028 = "1028";
	/**
	 * 售联网票截止时间，到了售票截止时间不显示。
	 */
	public static final String Param_1029 = "1029";
	/**
	 * 过路班次提前多少分钟开始售票，0表示报到后开始售票。
	 */
	public static final String Param_1034 = "1034";
	/**
	 * 可售半票占班次总座位百分比。
	 */
	public static final String Param_1036 = "1036";
	/**
	 * 改签的车票是否允许普通退票。
	 */
	public static final String Param_1037 = "1037";
	/**
	 * 改签的车票是否允许普通废票。
	 */
	public static final String Param_1038 = "1038";
	/**
	 * 计算票种票价的进位规则：1四舍五入、2舍去、3入、4小于5角进到5角，高于5角进到1元。
	 */
	public static final String Param_1042 = "1042";
	/**
	 * 补票界面只显示售票截止时间之前的班次。0：否，1：是。
	 */
	public static final String Param_1047 = "1047";
	/**
	 * 江西全省联网票手续费。
	 */
	public static final String Param_1049 = "1049";
	/**
	 * 售票员缴款金额上限（达到金额后，必须缴款）。
	 */
	public static final String Param_1051 = "1051";
	/**
	 * 特权补票能补N天前的票，0表示当天。
	 */
	public static final String Param_1052 = "1052";
	/**
	 * 0：表示半票票价取全票一半，1：表示取执行票价中的半票。
	 */
	public static final String Param_1058 = "1058";
	/**
	 * 保险费是根据里程还是根据票价设置，0里程，1票价。
	 */
	public static final String Param_1060 = "1060";
	
	/**
	 * 班次最多免票带儿童数/班次最多带儿童占班次座位数的百分比。
	 */
	public static final String Param_1061 = "1061";
	
	/**
	 * 同一身份证当天购买多张票的时间间隔；单位小时
	 */
	public static final String Param_1064 = "1064";
	
	/**
	 * 改签是否打印手续费. 1打印 0不打印。
	 */
	public static final String Param_1066 = "1066";
	
	/**
	 * 补票是否打印手续费. 1打印 0不打印。
	 */
	public static final String Param_1069 = "1069";
	
	/**
	 * 实名制售票是否允许同一身份证购买同一班次的多张车票，0不允许，1允许，默认为0.
	 */
	public static final String Param_1076 = "1076";

	/**
	 * 是否启用流水班退票手续费率，1启用、0不启用。
	 */
	public static final String Param_1078 = "1078";
	
	/**
	 * 电子票取票可取N天前未取车票，0表示当天，N大于等于0；
	 */
	public static final String Param_1085 = "1085";
	
	/**
	 * 电子支付超时时间
	 */
	public static final String Param_1092 = "1092";
	
	/**
	 * 窗口是否售电子票及出票方式，0窗口不售电子票，1售电子票仅打印纸质小票，2售电子票仅打印纸质车票，
	 *					  3售电子票且打印（纸质小票+纸质车票），4售电子票但不打印（纸质小票+纸质车票），默认0
	 */
	public static final String Param_1096 = "1096";
	
	/**
	 * 票据入库时，不同批次号的票号段是否可以重复使用，0不可以，1可以，默认0
	 */
	public static final String Param_0089 = "0089";
	/**
	 * 退票是否打印凭证。
	 */
	public static final String Param_1101 = "1101";
	/**
	 * 退票凭证票据编码。
	 */
	public static final String Param_1102 = "1102";
	/**
	 * 发车前两小时外退票手续费率，单位是%。
	 */
	public static final String Param_1103 = "1103";
	/**
	 * 发车前两小时内退票手续费率，单位是%。
	 */
	public static final String Param_1104 = "1104";
	/**
	 * 退票手续费进位规则：1四舍五入、2舍去、3入、4小于5角进到5角，高于5角进到1元、5保留小数点。
	 */
	public static final String Param_1105 = "1105";
	/**
	 * 退票手续费计算方式，0表示票价*退票手续费率，1表示（票价-票价分项）*退票手续费率+票价分项，2表示票价*退票手续费率+票价分项，默认为0。
	 */
	public static final String Param_1107 = "1107";
	/**
	 * 多张退票手续费是否打印一张。
	 */
	public static final String Param_1108 = "1108";
	/**
	 * 当前售票站点只能售当前站及始发站发班的票，0不启用，1启用，默认为0.。
	 */
	public static final String Param_1112 = "1112";
	
	/**
	 * 停班班次普通退票时是否全额退票，0按普通退票规则进行退票，1全额退票，默认为1.
	 */
	public static final String Param_1116 = "1116";
	/**
	 * 当天退票手续费率：1表示开启，当天为20%，之前为10%。
	 */
	public static final String Param_1178 = "1178";
	/**
	 * 是否启用二连浩特退票公式：1表示启用，0表示不启用。
	 */
	public static final String Param_1179 = "1179";
	/**
	 * 订票销售时，是否自动选择记录,0：不选择，1：选择。
	 */
	public static final String Param_1307 = "1307";
	/**
	 * 普通废票限制时间（售票后多少分钟内允许废）。
	 */
	public static final String Param_1401 = "1401";
	
	/**
	 * 原班次已发班是否允许改签,0不允许，1允许，默认为0
	 */
	public static final String Param_1503 = "1503";
	
	/**
	 * 改签是否要求票价相同。
	 */
	public static final String Param_1504 = "1504";
	/**
	 * 改签是否要求上车点和下车点与原票一致。
	 */
	public static final String Param_1505 = "1505";
	/**
	 * 改签是否要求线路与原票一致。
	 */
	public static final String Param_1506 = "1506";
	/**
	 * 车票是否只允许改签一次。
	 */
	public static final String Param_1507 = "1507";
	/**
	 * 发车时间前N分钟内的车票不得改签。
	 */
	public static final String Param_1508 = "1508";
	/**
	 * 是否允许改签到低票价。
	 */
	public static final String Param_1509 = "1509";
	/**
	 * 是否开启OpenApi售票，0：否，1：是。
	 */
	public static final String Param_1998 = "1998";

	/**
	 * 提前报到分钟数
	 */
	public static final String Param_2001 = "2001";
	/**
	 * 每晚报到分钟数
	 */
	public static final String Param_2002 = "2002";
	/**
	 * 每晚报到罚款金额
	 */
	public static final String Param_2003 = "2003";
	/**
	 * 1按脱班计算违约金,0不按脱班计算违约金
	 */
	public static final String Param_2004 = "2004";
	/**
	 * 晚指定分钟数以上按脱班计算违约金
	 */
	public static final String Param_2005 = "2005";
	/**
	 * 0按脱班次计算违约金,1按最大营业额计算
	 */
	public static final String Param_2006 = "2006";
	/**
	 * 次脱班金额
	 */
	public static final String Param_2007 = "2007";
	/**
	 * 按定员数*全程票价*倍数计算违约金
	 */
	public static final String Param_2008 = "2008";
	/**
	 * 1为报到后自动为可检票,0为报到后不修改可检票状态
	 */
	public static final String Param_2009 = "2009";
	/**
	 * 始发站未报到，配客站是否允许报到,0：不允许，1：允许
	 */
	public static final String Param_2010 = "2010";
	/**
	 * 是否需要安检合格才报到，0：不需要，1：需要
	 */
	public static final String Param_2013 = "2013";

	/**
	 * 始发站停售，配载站是否也停售，0：不停售，1：停售
	 */
	public static final String Param_2017 = "2017";
	/**
	 * 行驶证、保险过期的车辆是否允许报到：0、否，1、是
	 */
	public static final String Param_2019 = "2019";
	/**
	 * 同一车牌多次报到最小时间间隔（分钟）
	 */
	public static final String Param_2020 = "2020";
	/**
	 * 是否只允许车辆报到在已指定的线路中
	 */
	public static final String Param_2021 = "2021";
	/**
	 * 已售座位数大于车辆的乘客座位数且小于该车辆核定座位数,是否允许报到,1:允许,0:不允许
	 */
	public static final String Param_2022 = "2022";
	/**
	 * 证件有效期到期提示天数
	 */
	public static final String Param_2024 = "2024";
	/**
	 * 驾驶员两次报班的最小时间间隔
	 */
	public static final String Param_2025 = "2025";
	/**
	 * 出站例检中,流水班是否需报到一次便可出站，1报到一次就可出站，0出站后需要再次报到
	 */
	public static final String Param_2029 = "2029";

	public static final String Param_2030 = "2030";
	
	public static final String Param_2035 = "2035";
	
	//		//同线路报班时间隔时间限制判断 p2037
	public static final String Param_2037 = "2037";
	/**
	 * 发车前n分钟开始检票,0则无限制
	 */
	public static final String Param_3001 = "3001";

	/**
	 * 不同线路的班次是否允许混检,0：不允许，1：允许
	 */
	public static final String Param_3003 = "3003";
	/**
	 * 流水班次是否允许混检到流水班次,0：不允许，1：允许！
	 */
	public static final String Param_3004 = "3004";
	/**
	 * 流水班次是否允许混检到非流水班次,0：不允许，1：允许！
	 */
	public static final String Param_3005 = "3005";
	/**
	 * 非流水班次是否允许混检到流水班次,0：不允许，1：允许！
	 */
	public static final String Param_3006 = "3006";
	/**
	 * 离发车前N分钟才允许发班打单,0:表示不限制
	 */
	public static final String Param_3008 = "3008";
	/**
	 * 0：表示混检满座时交换座位,1:表示满座时加座混检
	 */
	public static final String Param_3010 = "3010";
	/**
	 * 是否需要进行检票口控制，0：不需要，1：需要
	 */
	public static final String Param_3011 = "3011";
	/**
	 * 过了发车时间是否允许混检，0:不允许,1允许
	 */
	public static final String Param_3012 = "3012";
	/**
	 * 满座是否允许混检,0：不允许，1：允许
	 */
	public static final String Param_3015 = "3015";

	/**
	 * 过天的车票是否允许混检，0：表示不允许，1：表示允许
	 */
	public static final String Param_3016 = "3016";

	/**
	 * 发车时间后N分钟之内允许补检
	 */
	public static final String Param_3017 = "3017";

	/**
	 * 集中式环境中是否允许途径配载班次在异站检票
	 */
	public static final String Param_3020 = "3020";

	/**
	 * 综合检票中，是否显示停班班次
	 */
	public static final String Param_3021 = "3021";

	/**
	 * 综合检票中，是否显示被并班次
	 */
	public static final String Param_3022 = "3022";

	/**
	 * 综合检票中，是否显示脱班班次
	 */
	public static final String Param_3023 = "3023";

	/**
	 * 综合检票中，是否显示停售班次
	 */
	public static final String Param_3024 = "3024";

	/**
	 * 隔天车票，是否只能混检到车票当天的班次
	 */
	public static final String Param_3026 = "3026";

	/**
	 * 混检是否允许检不存在站点的检入，0：不允许，1：允许！
	 */
	public static final String Param_3027 = "3027";

	/**
	 * 站外售票点是否能检其他售票点售的票，0：不能检，1：可以检
	 */
	public static final String Param_3032 = "3032";

	/**
	 * 预售票是否允许混检，0：不允许,1:允许
	 */
	public static final String Param_3033 = "3033";
	/**
	 * 报班时已有计划车辆是否修改计划车辆信息，0否，1是，默认为0
	 */
	public static final String Param_3034 = "3034";

	/**
	 * 报到车辆座位数小于班次座位数时是否截掉后面的座位数，0否，1是，默认为1
	 */
	public static final String Param_3035 = "3035";
	
	/**
	 * 是否实名制检票 0不 1是 默认为0
	 */
	public static final String Param_3038 = "3038";

	/**
	 * 补开结算单的天数
	 */
	public static final String Param_3041 = "3041";

	/**
	 * 注销结算单的天数
	 */
	public static final String Param_3042 = "3042";
	
	/**
	 * 集中式环境下，始发站未按正常点发班是否修改下一个配客站发车时间，0不修改，1修改，默认为0.参数设置为1时，按始发站延时时长自动延长/缩短配客站计划发车时间。
	 */
	public static final String Param_3050 = "3050";
	
	/**
	 * 混检是否允许检到留位上，0：不允许，1：允许
	 */
	public static final String Param_3067 = "3067";

	/**
	 * 3091 参数，第三方代售票混检时，0：按原逻辑混检到新班次处理，1：混检按改签流程处理，默认为0
	 */
	public static final String Param_3091 = "3091";
	
	/**
	 * 隔天班次开运量时是否必须用补开
	 */
	public static final String Param_3101 = "3101";

	/**
	 * 闸机是否进行检票操作，0：不检票，1：检票
	 */
	public static final String Param_3102 = "3102";

	/**
	 * 闸机是否控制本系统外的票号，0：不控制，1：控制
	 */
	public static final String Param_3103 = "3103";

	/**
	 * 检票闸机允许重复刷票进行检票的最大次数
	 */
	public static final String Param_3105 = "3105";
	/**
	 * 联网售票结算费率
	 */
	public static final String Param_4002 = "4002";

	/**
	 * 0:结算通知单上不打印结算单打单时扣费项,1:结算通知单上打印结算单打单时扣费项
	 */
	public static final String Param_4005 = "4005";

	/**
	 * 结算时扣费明细取值，0：取扣费应用信息，:1取最近的一次扣费信息
	 */
	public static final String Param_4006 = "4006";
	/**
	 * 坏票登记是否需要核销
	 */
	public static final String Param_4011 = "4011";

	/**
	 * 结算时是否重新计算客运代理费，0：不计算，1：重新计算
	 */
	public static final String Param_4013 = "4013";
	/**
	 * 打印结算单时0:按[始站]止站距离票价分组打印1:按[始站]止站距离票价[票种]分组打印2:按止站距离票价分组打印3:按止站距离票价[票种]
	 * 分组打印
	 */
	public static final String Param_4015 = "4015";
	/**
	 * 0:表示结算单补录班次只取当天发班班次，1：取所有
	 */
	public static final String Param_4025 = "4025";
	/**
	 * 应结金额进位规则：1四舍五入、2舍去、3入、4小于等于5角进到5角，高于5角进到1元、5保留小数点
	 * 
	 */
	public static final String Param_4068 = "4068";
	/**
	 * 系统中是否启用票价差功能,0：不启用，1：启用
	 */
	public static final String Param_5001 = "5001";
	/**
	 * 系统中结算金额是否启用线路票价差功能,0：不启用，1：启用
	 */
	public static final String Param_5050 = "5050";

	/**
	 * 安检记录N分钟内允许注销。
	 */
	public static final String Param_6001 = "6001";
	/**
	 * 车辆安检时判断行驶证、保险的截止日期：0、否，1、是。
	 */
	public static final String Param_6002 = "6002";
	/**
	 * 车辆二期维护里程剩下多少公里,弹出提示。
	 */
	public static final String Param_6004 = "6004";
	/**
	 * 车辆二期维护有效期剩下多少天数,弹出提示。
	 */
	public static final String Param_6005 = "6005";
	/**
	 * 是否开启车辆二期维护有效期。
	 */
	public static final String Param_6006 = "6006";
	/**
	 * 激活车辆二期维护有效期默认月数。
	 */
	public static final String Param_6007 = "6007";
	/**
	 * 无安检计划时，是否需要安检才允许报到。
	 */
	public static final String Param_6008 = "6008";
	/**
	 * 车辆安检有效时间类型：0:当日内有效，1:24小时内有效。
	 */
	public static final String Param_6010 = "6010";
	/**
	 * 安检以后，车辆需要再次安检的行驶公里数,(0:不控制)。
	 */
	public static final String Param_6011 = "6011";
	
	public static final String Param_6015="6015";
	/**
	 * 安检24小时有效：当天发过班次，安检合格单是否只对当天有效，1：当天有效性，0：24小时有效。
	 */
	public static final String Param_6017 = "6017";
	/**
	 * 无安检计划时，0允许车辆进行安检，1不允许车辆进行安检。
	 */
	public static final String Param_6018 = "6018";
	/**
	 * 安检四证过期是否正常安检：0、否，1、是。
	 */
	public static final String Param_6022 = "6022";
	/**
	 * 安检明日车辆时间，格式如下：06:00:00。
	 */
	public static final String Param_6025 = "6025";
	/**
	 * 结算时，0：行包作为营收，1：行包作为扣费。
	 */
	//手工结算单是否进行结算扣费
	public static final String Param_3068 = "3068";
	
	public static final String Param_8020 = "8020";
	/**
	 * 行包送货费每公斤金额。
	 */
	public static final String Param_8022 = "8022";
	/**
	 * 综合检票中，发班时是否打印空结算单 0 :否 1：是。
	 */
	public static final String Param_8044 = "8044";
	/**
	 * 行包打印结算单时的扣费比率。
	 */
	public static final String Param_8083 = "8083";
	/**
	 * IC卡报班中打印结算单是否同时打印货运结算信息。
	 */
	public static final String Param_8084 = "8084";
	/**
	 * 结算金额比率。
	 */
	public static final String Param_8099 = "8099";
	/**
	 * 行包回收款有效日期。
	 */
	public static final String Param_9044 = "9044";
	/**
	 * 报班车型与计划车型不一致时，是否修改计划车型及对应票价 0否，1是，默认为0。
	 */
	public static final String Param_9050 = "9050";
	/**
	 * 综合检票中发班是否按售票站打印结算单，0：否，1：是。
	 */
	public static final String Param_9080 = "9080";
	/**
	 * 综合检票中，是否自动开检,0:否,1:是。
	 */
	public static final String Param_9099 = "9099";
	/**
	 * 配载班次停班时，是否以始发站为准。默认为1：以始发站为准。。
	 */
	public static final String Param_9999 = "9999";

	// 是否开启车辆里程限制
	public static final String Param_0143 = "0143";
	
	public static final String Param_2626 = "2626";
	
	//IC卡报班是否开启按车辆单位类型分配权限进行报到2045
	public static final String Param_2045 = "2045";
	/**
	 * 检票闸机是否允许预售票通过，0不允许，1允许，默认为0
	 */
	public static final String Param_3069 = "3069";
	
	/**
	 * 是否启用证件核查（林东）,0不启用(IC报班时驾乘人员取计划),1启用(IC卡报班时,驾乘人员指纹输入,并且校验司乘人员是否进站、五证三险一卡有效期检查是否通过、驾驶员是否进行安全学习,需要2033参数开启),默认为0
	 */
	public static final String Param_0030 = "0030";
	/**
	 * 平台售保险自助机或者网上售票退保控制0不控制1控制，默然0
	 */
	public static final String Param_2627 = "2627";
	
	/**
	 * 当参数设置为0时，需在IC卡报班手工执行脱班操作才算脱班；当参数设置为1时，过发车时间未报班，该班次状态自动修改为脱班
	 */
	public static final String Param_2046 = "2046";
	
	
	/**
	 * 晚点的定义，0车辆过发车时间报班，1车辆过发车时间发班，默认为0
	 */
	public static final String Param_2047 = "2047";
	/**
	 * IC卡报班时候验证2036参数，根据2036参数值及车牌管理中的进站协议控制报班车辆是否允许报班
	 */
	public static final String Param_2036 = "2036";
	
	/**
	 *参数2054: 车牌管理中未审核的车辆是否允许报班，0不允许，1允许
	 */
	public static final String Param_2054 = "2054";
	
	public static final String Param_2056 = "2056";

	/**
	 *参数2083: IC卡报班时是否开启线路标志牌有效期验证, 0:不校验,1:校验
	 */
	public static final String Param_2083 = "2083";
	
	/**
	 *参数2084: IC卡报班时是否开启经营许可证有效期验证, 0:不校验,1:校验
	 */
	public static final String Param_2084 = "2084";
	
	/**
	 * 参数1074: 免票儿童是否单独打印车票，0不打印，1打印
	 */
	public static final String Param_1074 = "1074";

	/**
	 * 参数9393:是否实名制售票：0否，1全局实名制，2固定线路实名制
	 */
	public static final String Param_9393 = "9393";

	/**
	 * 参数1090: 是否开启票价差额功能: 0否,1是;控制范围包含售票点票价差额,线路售票点票价差额,售票点票种差额
	 */
	public static final String Param_1090 = "1090";
	
	/**
	 * 参数6071: 安检通知单允许重新打印次数，若参数为0无限制次数，默认为0
	 */
	public static final String Param_6071 = "6071";


	/**
	 * 参数3070: 闸机报文格式 ,0新老格式都支持（默认）,1只支持新格式,2只支持老格式
	 */
	public static final String Param_3070 = "3070";

	/**
	 * 参数3071: 闸机是否进行身份证验票，0否，1是，默认为1
	 */
	public static final String Param_3071 = "3071";

	/**
	 * 参数3072: 班次发班之后，n分钟内允许通过闸机，小于0则不允许通过，0则不限制，大于0则限制；默认-1
	 */
	public static final String Param_3072 = "3072";

	/**
	 * 参数3073: 闸机是否检流水班的票，0否，1是，默认为0
	 */
	public static final String Param_3073 = "3073";

	/**
	 * 参数3074：发车前n允许通过闸机,0则不限制,默认为0
	 */
	public static final String Param_3074 = "3074";

	/**
	 * 参数4008，营运车辆违规结算模块，违规结算类型，0罚金，1暂扣款，默认为0
	 */
	public static final String Param_4008 = "4008";
	
	/**
	 * 结算单补录是否领用票据，0不领用，1领用，默认0
	 */
	public static final String Param_3089 = "3089";

	/**
	 * 4069 :结算单结算是否需要领用结算通知单，0不需要，1需要，默认0
	 */
	public static final String Param_4069 = "4069";
	
	/**
	 * 0091: 是否启用测试版，0不启用，1启用；默认为1
	 */
	public static final String Param_0091 = "0091";

	/**
	 * 6072 安检时，车辆或驾驶员证件有效期到期提醒天数，0表示不提醒，默认0
	 */
    public static final String Param_6072 = "6072";
    
    /**
     * ic卡报班，灭火器过期是否允许报班，0，不允许  1：允许，默认为1
     */
    public static final String Param_2093 = "2093";

    /**
     * 票号重置，票号重置时是否能跳号重置，0不能跳号重置，1能跳号重置，若参数值设为为1时，跳过的正常号做坏票处理
     */
    public static final String Param_0024 = "0024";
    /**
	 * 公用参数返回值
	 * 
	 * @author Mr.Jiang
	 */
	public static class COMMON_FLAG {
		public static final String FALG_YES = "1";
		public static final String FALG_NO = "0";
		public static final String FALG_ZERO = "0";
		public static final String FALG_ONE = "1";
		public static final String FALG_TWO = "2";
		public static final String FALG_THR = "3";
		public static final String FALG_FOU = "4";
		public static final String FALG_FIV = "5";

	}
	public static class VERSION_FLAG {
		public static final String FALG_ONE = "1.0";
		public static final String FALG_TWO = "2.0";
		public static final String FALG_THR = "3.0.0";

	}
	// /**
	// * 有特殊业务逻辑
	// * @author Mr.Jiang
	// */
	// public static class TICKETRETURN_FLAG{
	// public static final String FALG_ZERO = "0";
	// public static final String FALG_ONE = "1";
	// public static final String FALG_TWO = "2";
	// public static final String FALG_THR = "3";
	// public static final String FALG_FOU = "4";
	// public static final String FALG_FIV = "5";
	// public static final String FALG_SIX = "6";
	// public static final String FALG_SEV = "7";
	// }
	/**
	 * 应结金额进位规则：对结算金额进行四舍五入，根据参数规则，参照1105参数
	 */
	public static class BALANCE_FLAG {

		// 0原值
		public static final String FALG_ZERO = "0";
		// 1四舍五入、
		public static final String FALG_ONE = "1";
		// 2舍去、
		public static final String FALG_TWO = "2";
		// 3入、
		public static final String FALG_THR = "3";
		// 4小于等于5角进到5角，高于5角进到1元、
		public static final String FALG_FOU = "4";
		// 5保留小数点
		public static final String FALG_FIV = "5";
	}

	/**
	 * genScheduleplan方法 票价生成方式：0：线路票价，1：硬调票价 2: 公式票价 (是否使用线路票价)
	 */
	public static class ROUTEPRICE_FLAG {

		// 0：线路票价
		public static final String FALG_ZERO = "0";

		// 1：硬调票价
		public static final String FALG_ONE = "1";

		// 2: 公式票价
		public static final String FALG_TWO = "2";

	}

	/**
	 * 查询结算单明细信息 打印结算单时
	 */
	public static class DEPARTINVOICE_FLAG {
		// 0:相同（始站）相同止站相同距离相同票价分组打印;
		public static final String FALG_ZERO = "0";
		// 1:相同（始站）相同止站相同距离相同票价相同(票种)分组打印
		public static final String FALG_ONE = "1";
		// 2.相同止站相同距离相同票价分组打印
		public static final String FALG_TWO = "2";
		// 3:相同止站相同距离相同票价相同(票种)分组打印
		public static final String FALG_THR = "3";
		// 4:相同到站分组打印
		public static final String FALG_FOU = "4";
		// 5:相同到站相同票价分组打印
		public static final String FALG_FIVE = "5";
		// 6:相同到站相同票价相同站务费分组打印
		public static final String FALG_SIX = "6";

	}
}
