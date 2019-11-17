package cn.nova.bus.common;


/**
 * <b>类名称：</b>TicketInsuranceConst <br/>
 * <b>类描述：</b>车票保险票种、状态、售票方式 常量定义<br/>
 * <b>创建人：</b>tianhb<br/>
 * <b>修改人：</b><br/>
 * <b>修改时间：</b>2018年7月13日 上午10:42:45<br/>
 * <b>修改备注：</b><br/>
 * <b>版本信息：</b>v1.0.0<br/>
 * <b>任务号：</b>2018年7月13日 上午10:42:45<br/>
 */
public class TicketInsuranceConst {
	
	/**
	 * <b>类名称：</b>TICKET_TYPE <br/>
	 * <b>类描述：</b>票种<br/>
	 * <b>创建人：</b>tianhb<br/>
	 * <b>修改人：</b><br/>
	 * <b>修改时间：</b>2018年7月13日 上午10:54:45<br/>
	 * <b>修改备注：</b><br/>
	 * <b>版本信息：</b>v1.0.0<br/>
	 * <b>任务号：</b>2018年7月13日 上午10:54:45<br/>
	 */
	public static class TICKET_TYPE{
		
		public static final String TICKET_FULL = "Q";//全票
		
		public static final String TICKET_HALF = "B";//半票
		
		public static final String TICKET_STU = "X";//学生票
		
		public static final String TICKET_TOP = "S";//上限价
		
		public static final String TICKET_CHILD = "E";//儿童票
		
		public static final String TICKET_SOL = "J";//残军票
		
		public static final String TICKET_DIS = "Z";//打折票
		
		public static final String TICKET_GROUP = "T";//团体票
		
		public static final String TICKET_HIRE = "H";//包车票
		
		public static final String TICKET_DISCOUNT = "Y";//优惠票
		
		public static final String TICKET_ROUND = "W";//往返票
		
		public static final String TICKET_CONNECT = "L";//联程票
		
		public static final String TICKET_ACTIVE = "G";//活动票
	}
	/**
	 * <b>类名称：</b>TICKETSELL_STATUS <br/>
	 * <b>类描述：</b>车票状态<br/>
	 * <b>创建人：</b>tianhb<br/>
	 * <b>修改人：</b><br/>
	 * <b>修改时间：</b>2018年7月13日 上午10:57:22<br/>
	 * <b>修改备注：</b><br/>
	 * <b>版本信息：</b>v1.0.0<br/>
	 * <b>任务号：</b>2018年7月13日 上午10:57:22<br/>
	 */
	public static class TICKETSELL_STATUS{
		
		public static final String TICKETSELL_SALE = "0";//车票状态：0 已售 1 已退 2 已废 
		
		public static final String TICKETSELL_RETURN = "1";//车票状态：0 已售 1 已退 2 已废 
		
		public static final String TICKETSELL_CANCEL = "2";//车票状态：0 已售 1 已退 2 已废 
		
	}
	/**
	 * <b>类名称：</b>insurance_status <br/>
	 * <b>类描述：</b>保险状态<br/>
	 * <b>创建人：</b>tianhb<br/>
	 * <b>修改人：</b><br/>
	 * <b>修改时间：</b>2018年7月13日 上午10:57:55<br/>
	 * <b>修改备注：</b><br/>
	 * <b>版本信息：</b>v1.0.0<br/>
	 * <b>任务号：</b>2018年7月13日 上午10:57:55<br/>
	 */
	public static class INSURANCE_STATUS{
		
		public static final String INSURANCE_SALE = "0";//保险状态：0 已售 1 已退 2 已废 
		
		public static final String INSURANCE_RETURN = "1";//保险状态：0 已售 1 已退 2 已废 
		
		public static final String INSURANCE_CANCEL = "2";//保险状态：0 已售 1 已退 2 已废 
	}
	/**
	 * <b>类名称：</b>TICKETSELL_SELLWAY <br/>
	 * <b>类描述：</b>车票售出方式<br/>
	 * <b>创建人：</b>tianhb<br/>
	 * <b>修改人：</b><br/>
	 * <b>修改时间：</b>2018年7月13日 上午11:47:35<br/>
	 * <b>修改备注：</b><br/>
	 * <b>版本信息：</b>v1.0.0<br/>
	 * <b>任务号：</b>2018年7月13日 上午11:47:35<br/>
	 */
	public static class TICKETSELL_SELLWAY{
		//0：窗口	7 ：网售；10：自助机售 11:邮政
		public static final String TICKETSELL_WINDOWSALE = "0";
		
		public static final String TICKETSELL_WEBSALE = "7";
		
		public static final String TICKETSELL_SELFSALE = "10";
		
		public static final String TICKETSELL_POSTSALE = "11";
	}
	/**
	 * <b>类名称：</b>INSURANCE_SELLWAY <br/>
	 * <b>类描述：</b>保险销售方式<br/>
	 * <b>创建人：</b>tianhb<br/>
	 * <b>修改人：</b><br/>
	 * <b>修改时间：</b>2018年7月13日 上午11:46:03<br/>
	 * <b>修改备注：</b><br/>
	 * <b>版本信息：</b>v1.0.0<br/>
	 * <b>任务号：</b>2018年7月13日 上午11:46:03<br/>
	 */
	public static class INSURANCE_SELLWAY{
		//售保险方式 0：窗口	7 ：网售；10：自助机售
		public static final String INSURANCE_WINDOWSALE = "0";
		
		public static final String INSURANCE_WEBSALE = "7";
		
		public static final String INSURANCE_SELFSALE = "10";
	}
	
	public static final String TICKETSELL_RETURNFEEMODE_YES = "1";//退票返还标识:0 车站垫付,1 原路返还
	
	public static final String TICKETSELL_RETURNFEEMODE_NO = "0";//退票返还标识:0 车站垫付,1 原路返还
	
}
