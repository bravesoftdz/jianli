package cn.nova.bus.checkticket.action;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import cn.nova.bus.action.BaseAction;
import cn.nova.bus.archive.model.Customer;
import cn.nova.bus.base.model.Schedule;
import cn.nova.bus.base.service.PCTicketentranceService;
import cn.nova.bus.base.service.StationService;
import cn.nova.bus.base.service.TickettypeService;
import cn.nova.bus.base.service.impl.PCTicketentranceServiceImpl;
import cn.nova.bus.base.service.impl.StationServiceImpl;
import cn.nova.bus.base.service.impl.TickettypeServiceImpl;
import cn.nova.bus.bill.model.Billtype;
import cn.nova.bus.bill.service.BilltypeService;
import cn.nova.bus.bill.service.impl.BilltypeServiceImpl;
import cn.nova.bus.checkticket.model.Ledcontent;
import cn.nova.bus.checkticket.model.ScheduleStartCheck;
import cn.nova.bus.checkticket.remote.service.CheckTicketClientService;
import cn.nova.bus.checkticket.remote.service.impl.CheckTicketClientServiceImpl;
import cn.nova.bus.checkticket.service.BatchCheckticketService;
import cn.nova.bus.checkticket.service.CheckticketService;
import cn.nova.bus.checkticket.service.impl.BatchCheckticketServiceImpl;
import cn.nova.bus.checkticket.service.impl.CheckticketServiceImpl;
import cn.nova.bus.common.ParamterConst;
import cn.nova.bus.exception.BusinessException;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.price.model.Scheduleplan;
import cn.nova.bus.price.model.Scheduleseats;
import cn.nova.bus.sale.dao.TicketDao;
import cn.nova.bus.sale.model.Ticketsell;
import cn.nova.bus.sale.service.TicketService;
import cn.nova.bus.sale.service.impl.TicketServiceImpl;
import cn.nova.bus.security.Global;
import cn.nova.bus.system.service.ParameterService;
import cn.nova.bus.system.service.impl.ParameterServiceImpl;
import cn.nova.utils.commons.MethodResult;
import cn.nova.utils.commons.ParamCheckTicketIn;
import cn.nova.utils.commons.ParamCheckTicketOut;
import cn.nova.utils.web.ServletPropertyFilterUtil;
import models.RemoteTransaction;
import play.mvc.Http.Request;
import util.AppConstant;
import util.CurrentUtil;
import util.JsonUtil;
import util.TransactionUtil;
import util.TransactionUtil.TransactionType;

/**
 * @author lck
 * 
 */
public class CheckticketAction extends BaseAction{
	private Scheduleseats scheduleseats;
	private ScheduleStartCheck schedulestartcheck;
	private Long orgid;
	private String ip;
	private Date departdate;
	private Date departdate1;
	public Date getDepartdate1() {
		return departdate1;
	}

	public void setDepartdate1(Date departdate1) {
		this.departdate1 = departdate1;
	}

	private Long reportorgid;
	private Long checkstationid;
	private long scheduleplanid;
	private Short seatno;
	private long vehiclereportid;
	private String ticketno;
	private String certificateno;
	private String stratticketno;
	private String endticketno;
	private String ticketentrance;
	private boolean islazycheck;// 是否补检
	private Long ticketid;// 售票ID
	private Integer checktickets;// 检票数
	private Integer unchecktickets;//
	private Integer oneCardChecktickets;
	private Ticketsell ticketsell;
	private short newseatno;
	private List<Map<String, Object>> entrancelist;
	private List<Map<String, Object>> planlist;
	private List<Map<String, Object>> seatstatuslist;
	private List<Map<String, Object>> seatstatusdetail;
	private List<Map<String, Object>> reportvehiclelist;
	private List<Map<String, Object>> checkticketedlist;
	private List<Map<String, Object>> ticketlist;
	private List<Object> list2;
	private List<Object> list1;
	private boolean isdeparted;
	private String ticketids;
	private long scheduleid;
	private Ledcontent lc;
	private long reportid;// 报到车辆ID，用于检票后 返回流水班，定位到指定的报到车辆ID
	private int mixcheck;// 是否混检
	private String cardno;//卡号
	private long ticketsellid;//票号ID，用来获取唯一进行检票的车票
	private String id;
	private Integer verifystation;
	private String checktype; //检票类型
	private String vehicleno;
	
	public long getTicketsellid() {
		return ticketsellid;
	}

	public void setTicketsellid(long ticketsellid) {
		this.ticketsellid = ticketsellid;
	}

	private ParamCheckTicketIn inparam;
	private ParamCheckTicketOut outparam;
    private List<Map<String, Object>> sumticketlist;
    private List<Map<String, Object>> multicketdetiallist;
    
    public List<Map<String, Object>> getMulticketdetiallist() {
		return multicketdetiallist;
	}

	public void setMulticketdetiallist(List<Map<String, Object>> multicketdetiallist) {
		this.multicketdetiallist = multicketdetiallist;
	}

	private CheckticketService checkticketService;
	private CheckTicketClientService checkTicketClientService;
	private StationService stationService;
	private TicketService ticketservice;
	
	private Date departdateisnolyticket;//判断是否是唯一车票的发车日期
	private String ticketnoisonlyticket;//判读是否唯一车票的车票号
	
	public String qryIssamerep(){		
		checkticketService = new CheckticketServiceImpl();		
		try {
			Long result =checkticketService.qryIssamerep(vehiclereportid,ticketno,checkstationid, departdate);
			markSuccess();
			setMsg(result.toString());
		} catch (Exception e) {
			markFail();
			setMsg(e.getMessage());
			play.Logger.error(e.getMessage(), e);
		}		
		return "json";
	}
	public Date getDepartdateisnolyticket() {
		return departdateisnolyticket;
	}

	/**
	 * 通过票号和车辆ID 校验票是否属于这辆车
	 * @return
	 */
	public String checkisschedule(){
		try {
			checkticketService = new CheckticketServiceImpl();
				boolean b = checkticketService.checkisschedule(vehiclereportid, ticketno,departdate);
				if(b){
					markSuccess();
				}else{
					markFail();
					setMsg("该票不属于本班次,请检查!");
				}
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	public void setDepartdateisnolyticket(Date departdateisnolyticket) {
		this.departdateisnolyticket = departdateisnolyticket;
	}

	public String getTicketnoisonlyticket() {
		return ticketnoisonlyticket;
	}

	public void setTicketnoisonlyticket(String ticketnoisonlyticket) {
		this.ticketnoisonlyticket = ticketnoisonlyticket;
	}
	
	private long sellerid;
	private long departinvoicesid;
	private long departstationid;
	private boolean isbegincheck;
	
	private String c_name;
	private String c_sex;
	private String c_birth;
	private String c_address;
	private String c_nation;
	private String c_certificateno;
	private String c_certificatetype;
	private String c_schedulecode;
	private String c_departtime;
	private String c_ticketno;
	private boolean isshowCheckByCard;
	
	
	/**
	 * 
	 * <b>类描述：</b><br/>
	 * <b>类名称：</b>qyrcheckticket<br/>
	 * <b>创建人：</b><a href="mailto:jiangyingrui@nova.net.cn">姜蓥瑞</a><br/>
	 * <b>关键修改：将未开始检票的班次改变为可检状态</b><br/>
	 * <b>修改时间：</b>2016年3月18日11:14:07<br/>
	 * <b>修改人：</b>姜蓥瑞<br/>
	 * <b>任务号：</b><br/>
	 */
	public String changeticketstatus(){
		checkticketService = new CheckticketServiceImpl();	
		try {
			if(checkticketService.changeticketstatus(scheduleplanid,departstationid,isbegincheck) !=null){
				markSuccess();
			}else{
				markFail();
				setMsg("进入检票失败");
			}
		} catch (Exception e) {
			markFail();
			setMsg("进入检票失败");
		}	
		return "json";
	}
	
	/**
	 * 补开的时候保存售票员到结算单中
	 * @return
	 */
	public String saveseller(){
		try {
			checkticketService = new CheckticketServiceImpl();
			boolean b = checkticketService.saveseller(sellerid,departinvoicesid);
			markSuccess();
			setMsg("保存售票员成功");
		} catch (Exception e) {
			markFail();
			setMsg(e.getMessage());
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	/**
	 * 发班前进行检验操作
	 * @return
	 */
	public String saveschedulestartcheck(){
		try {
			Global global = CurrentUtil.getGlobal();
			checkticketService = new CheckticketServiceImpl();
			if(checkticketService.queryschedulestartcheck(schedulestartcheck,global.getOrganization().getId())){
				markSuccess();
				setMsg("该班次已经验证");
			}else{
			checkticketService.schedulestartcheck(schedulestartcheck,global.getUserinfo().getId(),global.getOrganization().getId());
			markSuccess();
			setMsg("保存发班前检验操作成功");
			}
		} catch (Exception e) {
			markFail();
			setMsg(e.getMessage());
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	// 查询车票信息，用于混检
	public String qryTicket() {
		try {
			checkticketService = new CheckticketServiceImpl();
			Global global = CurrentUtil.getGlobal();
			if ((ticketno == null || "".equals(ticketno))) {//&&(certificateno == null || "".equals(certificateno))
				setTicketlist(checkticketService.qryTicket(scheduleplanid,
						seatno));
			} else {
				setTicketlist(checkticketService.qryTicket(global, ticketno,certificateno));
			}
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String qryTicketentrance() {
		try {
			Global global = CurrentUtil.getGlobal();
			String orgids=global.getOrgIDs();
			PCTicketentranceService pcTicketentranceService = new PCTicketentranceServiceImpl();
			setEntrancelist(pcTicketentranceService
					.qryTicketentrance(ip, orgids));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String qryScheduleplan() {
		try {
			checkticketService = new CheckticketServiceImpl();
			Global global = CurrentUtil.getGlobal();
			if (departdate == null) {
				SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
				departdate = sf.parse(sf.format(new Date()));
				System.out.println("卡问题出现:综合检票中查询发车日期出现空值");
				System.out.println("校正后为:" + departdate);
			}
			if (reportorgid == null) {
				reportorgid = global.getOrganization().getId();
				System.out.println("卡问题出现:综合检票中查询机构ID出现空值");
				System.out.println("校正后为:" + reportorgid);
			}
			setPlanlist(checkticketService.qryScheduleplan(
					ServletPropertyFilterUtil.buildFromHttpRequest(), departdate, reportorgid,
					checkstationid));
		} catch (Exception e) {
			System.out.println("卡问题出现:综合检票中查询出现异常");
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	public String qryScheduleplanbyself() {
		checkticketService = new CheckticketServiceImpl();
		try {
			Global global = (Global) CurrentUtil.getGlobal();
			if (departdate == null) {
				SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
				departdate = sf.parse(sf.format(new Date()));
				System.out.println("卡问题出现:综合检票中查询发车日期出现空值");
				System.out.println("校正后为:" + departdate);
			}
			if (reportorgid == null) {
				reportorgid = global.getOrganization().getId();
				System.out.println("卡问题出现:综合检票中查询机构ID出现空值");
				System.out.println("校正后为:" + reportorgid);
			}
			setPlanlist(checkticketService.qryScheduleplanbyself(
					ServletPropertyFilterUtil.buildFromHttpRequest(), departdate, reportorgid,
					checkstationid,global));
		} catch (Exception e) {
			System.out.println("卡问题出现:综合检票中查询出现异常");
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	// 查询已检的车票信息
	public String queryCheckedticket() {
		try {
			checkticketService = new CheckticketServiceImpl();
			ticketlist = checkticketService
					.queryCheckedticket(ServletPropertyFilterUtil
							.buildFromHttpRequest());
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	public String queryschedulestartcheck() {
		try {
			Global global = CurrentUtil.getGlobal();
			long orgids=global.getOrganization().getId();
			checkticketService = new CheckticketServiceImpl();
			if(checkticketService
					.queryschedulestartcheck(schedulestartcheck,orgids)){
				setMsg("1");				
			}else{
				setMsg("0");
			}
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	// 检票界面查询流水班次的报到车辆信息
	public String qryReportvehicle() {
		try {
			checkticketService = new CheckticketServiceImpl();
			Global global = CurrentUtil.getGlobal();
			setReportvehiclelist(checkticketService.qryReportvehicle(
					scheduleplanid, isdeparted, global.getOrganization()
							.getId(), departdate));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	// 检票界面查询流水班次的报到车辆信息
	public String qryReportdriver() {
		try {
			checkticketService = new CheckticketServiceImpl();
			Global global = CurrentUtil.getGlobal();
			setReportvehiclelist(checkticketService.qryReportdriver(ServletPropertyFilterUtil.buildFromHttpRequest(),global.getOrganization()
					.getId()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	// 无票根检票检票界面查询班次的报到车辆信息
	public String qryReportvehicles() {
		try {
			checkticketService = new CheckticketServiceImpl();
			Global global = CurrentUtil.getGlobal();
			if (global != null) {
				setReportvehiclelist(checkticketService.qryReportvehicle(
						scheduleplanid, global.getOrganization().getId()));
			}
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	// 查询报到车辆的检票数
	public String qrycheckticketeds() {
		checkticketService = new CheckticketServiceImpl();
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		if (departdate == null) {
			try {
				Scheduleplan scheduleplan = checkticketService.getScheduleplan(scheduleplanid);
				departdate = scheduleplan.getDepartdate();
//				System.out.println("卡问题出现:综合检票中查询发车日期出现空值");
//				System.out.println("校正后为:" + departdate);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		try {
			checktickets = new Long(checkticketService.qryReportVechiletickets(
					scheduleplanid, vehiclereportid,departdate)).intValue();
		} catch (Exception e) {
			checktickets = 0;
			play.Logger.error(e.getMessage(), e);
		}
		try {
			oneCardChecktickets = new Long(
					checkticketService.qryOneCardReportVechiletickets(
							scheduleplanid, vehiclereportid,departdate)).intValue();
		} catch (Exception e) {
			oneCardChecktickets = 0;
			play.Logger.error(e.getMessage(), e);
		}
		try {
			unchecktickets = new Long(checkticketService.qryUnCheckTickets(
					scheduleplanid,departdate)).intValue();
		} catch (Exception e) {
			checktickets = 0;
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String qrycheckticketed() {
		checkticketService = new CheckticketServiceImpl();
		if (checkticketService == null) {
			System.out
					.println("qrycheckticketed EJB Service @InjectEJB DI fails^^^^^^^^^");
			return "json";
		}
		try {
			setCheckticketedlist(checkticketService.qryTicketsell(
					scheduleplanid, true));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String CheckByticketno() {
		checkticketService = new CheckticketServiceImpl();
		if (checkticketService == null) {
			System.out
					.println("CheckByticketno EJB Service @InjectEJB DI fails^^^^^^^^^");
			return "json";
		}
		Global global = CurrentUtil.getGlobal();
		String ticketsellno = "";
		try {
			stationService = new StationServiceImpl();
			ticketservice = new TicketServiceImpl();
			if (global != null && global.getUserinfo().getId() > 0) {
				//新增判断当前票号对应的卖票数量是一个还是多个
//				if(ticketservice.getTicketcout(ticketno, departdate1)!=null&&(ticketservice.getTicketcout(ticketno, departdate1).size()==1||ticketsellid!=0))
//				{
				ticketsell = checkticketService.checkByticketno(checkstationid,
						vehiclereportid, ticketno,
						global, islazycheck, ip,
						ticketentrance);
				if(ticketsell!=null && ticketsell.getVehiclereport()!=null){
				// 获取报到的车辆，用于流水班定位到该检票车辆上
					setReportid(ticketsell.getVehiclereport().getId());
					setScheduleplanid(ticketsell.getScheduleplanid());
				}else{
					setReportid(0);
					setScheduleplanid(0);
				}
				markSuccess();
				ticketsellno = checkticketService.isMixChange(ticketsell.getTicketno());
				if(ticketsellno.equals("")){
					ticketsellno = ticketsell.getTicketno();
				}
				if (!ticketsell.getTickettype().equals("Q")
						&& !ticketsell.getTickettype().equals("Z")) {
					TickettypeService tickettypeService = new TickettypeServiceImpl();
					setMsg(ticketsell.getSeatno()
							+ "号座检票成功，该票为"
							+ tickettypeService.qryTicketname(ticketsell
									.getTickettype()) + ",请检查相关证件！");

				} else {
					setMsg(stationService.findById(
							ticketsell.getReachstationid()).getName()
							+ ticketsell.getSeatno()
							+ "号座,票号："
							+ ticketsellno + "检票成功！");
				}
			}
				/*else
				{
						setFlag((long)2);
				}*/
//			}
		} catch (BusinessException se) {
			setScheduleplanid((long) -1);
			markFail();
			setMsg(se.getMessage());	
		} catch (ServiceException se) {
			setScheduleplanid((long) -1);
			markFail();
			setMsg(se.getMessage());
			setFlag(checkticketService.switchException(se.getExceptionCode()));
		} catch (Exception e) {
			markFail();
			setMsg("票号：" + ticketsellno + "检票失败！");
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	/* 
	 * 检查票号是否是该班次
	 */
	public String checkticketno() {
		try {
			Global global = CurrentUtil.getGlobal();
			checkticketService = new CheckticketServiceImpl();
			setId(checkticketService.checkticketno(ticketno, certificateno, global));
		} catch (Exception e) {
			markFail();
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	//	新增通过售票ID获取ticketsell对象
	public String CheckByticketId() {
		checkticketService = new CheckticketServiceImpl();
		if (checkticketService == null) {
			System.out
					.println("CheckByticketno EJB Service @InjectEJB DI fails^^^^^^^^^");
			return "json";
		}
		Global global = CurrentUtil.getGlobal();
		try {
			stationService = new StationServiceImpl();
			ticketservice = new TicketServiceImpl();
			if (global != null && global.getUserinfo().getId() > 0) {
				Ticketsell tt = new TicketDao().getonlyTicketsell(ticketsellid); 
				ticketsell = checkticketService.checkticket(checkstationid,
						vehiclereportid, tt,
						global, islazycheck, ip,
						ticketentrance,false,checktype);
				// 获取报到的车辆，用于流水班定位到该检票车辆上
				setReportid(ticketsell.getVehiclereport().getId());
				setScheduleplanid(ticketsell.getScheduleplanid());
				markSuccess();
				if (!ticketsell.getTickettype().equals("Q")
						&& !ticketsell.getTickettype().equals("Z")) {
					TickettypeService tickettypeService = new TickettypeServiceImpl();
					setMsg(ticketsell.getSeatno()
							+ "号座检票成功，该票为"
							+ tickettypeService.qryTicketname(ticketsell
									.getTickettype()) + ",请检查相关证件！");

				} else {
					setMsg(stationService.findById(
							ticketsell.getReachstationid()).getName()
							+ ticketsell.getSeatno()
							+ "号座,票号："
							+ ticketsell.getTicketno() + "检票成功！");
				}
			}
				/*else
				{
						setFlag((long)2);
				}*/
//			}
		} catch (BusinessException se) {
			setScheduleplanid((long) -1);
			markFail();
			setMsg(se.getMessage());	
		} catch (ServiceException se) {
			setScheduleplanid((long) -1);
			markFail();
			setMsg(se.getMessage());
			setFlag(checkticketService.switchException(se.getExceptionCode()));
		} catch (Exception e) {
			markFail();
			setMsg("票号：" + ticketno + "检票失败！");
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	//新增通过票号和发车日期判断当前车票是否唯一    ADD BY LIYI
	public String qryIsnolyTicketsell()
	{
		ticketservice = new TicketServiceImpl();
		setTicketlist(ticketservice.getTicketcout(ticketnoisonlyticket, departdateisnolyticket,certificateno));
		return "json";
	}
	//新增多个票号的显示信息
	public String qrymultiticketdetail()
	{
		ticketservice = new TicketServiceImpl();
		setMulticketdetiallist(ticketservice.getmulTicketlist(ticketno,departdate1,certificateno));
		return "json"; 
	}
	// 无票根检票
	public String CheckBynotickets() {
		checkticketService = new CheckticketServiceImpl();
		if (checkticketService == null) {
			System.out
					.println("CheckByticketno EJB Service @InjectEJB DI fails^^^^^^^^^");
			return "json";
		}
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				checkticketService.checkByticketid(checkstationid,
						vehiclereportid, ticketids,global, ip);
				markSuccess();
				setMsg("检票成功！");
			}
		} catch (ServiceException se) {
			markFail();
			setMsg(se.getMessage());
			setFlag(checkticketService.switchException(se.getExceptionCode()));
		} catch (Exception e) {
			markFail();
			setMsg("票号：" + ticketno + "检票失败！");
			play.Logger.error(e.getMessage(), e);
		}
		return "json";

	}

	// 按座位号检票
	public String checkBySeatno() {
		Global global = CurrentUtil.getGlobal();
		try {
			checkticketService = new CheckticketServiceImpl();
			stationService = new StationServiceImpl();
			if (global != null && global.getUserinfo().getId() > 0) {
				ticketsell = checkticketService.checkBySeatno(checkstationid,
						vehiclereportid, scheduleplanid, seatno, global, islazycheck, ip,
						ticketentrance);
				setScheduleplanid(ticketsell.getScheduleplanid());
				markSuccess();
				setMsg(stationService.findById(ticketsell.getReachstationid())
						.getName()
						+ ticketsell.getSeatno()
						+ "流水号,票号："
						+ ticketsell.getTicketno() + "检票成功！");
			}
		} catch (ServiceException se) {
			setScheduleplanid((long) -1);
			markFail();
			setMsg(se.getMessage());
			setFlag(checkticketService.switchException(se.getExceptionCode()));
		} catch (Exception e) {
			markFail();
			setMsg("座位号：" + ticketno + "检票失败！");
			play.Logger.error(e.getMessage(), e);
		}
		return "json";

	}

	// 按座位号特检
	public String checkAuthBySeatno() {
		Global global = CurrentUtil.getGlobal();
		String mixticketno = "";
		try {
			checkticketService = new CheckticketServiceImpl();
			stationService = new StationServiceImpl();
			if (global != null && global.getUserinfo().getId() > 0) {
				ticketsell = checkticketService.checkAuthBySeatno(
						checkstationid, vehiclereportid, scheduleplanid,
						seatno, global, islazycheck, ip,
						ticketentrance);
				setScheduleplanid(ticketsell.getScheduleplanid());
				markSuccess();
				mixticketno = checkticketService.isMixChange(ticketsell.getTicketno());
				if(mixticketno.equals("")){
					mixticketno = ticketsell.getTicketno();
				}
				setMsg(stationService.findById(ticketsell.getReachstationid())
						.getName()
						+ ticketsell.getSeatno()
						+ "号,票号："
						+ mixticketno + "特检成功！");
			}
		} catch (ServiceException se) {
			setScheduleplanid((long) -1);
			markFail();
			setMsg("座位号：" + seatno + "," + se.getMessage());
			setFlag(checkticketService.switchException(se.getExceptionCode()));
		} catch (Exception e) {
			markFail();
			setMsg("座位号：" + seatno + "特检失败！");
			play.Logger.error(e.getMessage(), e);
		}
		return "json";

	}

	public String cancelCheckticket() {
		Global global = CurrentUtil.getGlobal();
		String mixticketno = "";
		try {
			checkticketService = new CheckticketServiceImpl();
			if (global != null && global.getUserinfo().getId() > 0) {
				if(checkticketService.isRemoteTicketCheck(global, ticketno)){
					long scheduleplanid = checkticketService.cancleRemoteTicketCheck(checkstationid, global, ticketno);
					setScheduleplanid(scheduleplanid);
				}else{
					ticketsell = checkticketService.cancelCheckticket(
							checkstationid, ticketno, global, mixcheck);
					setScheduleplanid(ticketsell.getScheduleplanid());
				}
				mixticketno = checkticketService.isMixChange(ticketno);
				if(mixticketno.equals("")){
					setMsg("票号：" + ticketno + "退检成功！");
				}else{
					setMsg("票号：" + mixticketno + "退检成功！");
				}
				markSuccess();
				
			}
		} catch (ServiceException se) {
			setScheduleplanid((long) -1);
			markFail();
			setMsg(se.getMessage());
		} catch (BusinessException e) {
			markFail();
			setMsg(e.getMessage());
		}catch (Exception e) {
			markFail();
			setMsg("票号：" + ticketno + "退检失败！");
			play.Logger.error(e.getMessage(), e);
		}
		return "json";

	}

	// 实现按座位号(流水号)退检票过程
	public String cancelCheckBySeatno() {
		Global global = CurrentUtil.getGlobal();
		try {
			checkticketService = new CheckticketServiceImpl();
			if (global != null && global.getUserinfo().getId() > 0) {
				ticketsell = checkticketService.cancelCheckBySeatno(
						checkstationid, scheduleplanid, seatno, global,
						mixcheck);
				setScheduleplanid(ticketsell.getScheduleplanid());
				markSuccess();
				setMsg("票号：" + ticketno + "退检成功！");
			}
		} catch (ServiceException se) {
			setScheduleplanid((long) -1);
			markFail();
			setMsg(se.getMessage());
		} catch (Exception e) {
			markFail();
			setMsg("票号：" + ticketno + "退检失败！");
			play.Logger.error(e.getMessage(), e);
		}
		return "json";

	}

	public String cancelAllCheckticket() {
		Global global = CurrentUtil.getGlobal();
		try {
			checkticketService = new CheckticketServiceImpl();
			if (global != null && global.getUserinfo().getId() > 0) {
				checkticketService.cancelAllCheckticket(ServletPropertyFilterUtil.buildFromHttpRequest(),checkstationid,
						scheduleplanid, vehiclereportid, global);
				markSuccess();
				setMsg("选中发车站已检票,整车退检成功！");
			}
		} catch (ServiceException se) {
			setScheduleplanid((long) -1);
			markFail();
			setMsg(se.getMessage());
		} catch (Exception e) {
			markFail();
			setMsg("整车退检失败！");
			play.Logger.error(e.getMessage(), e);
		}
		return "json";

	}

	public String qrySeatstatus() {
		Global global = CurrentUtil.getGlobal();
		try {
			checkticketService = new CheckticketServiceImpl();
			if (global != null && global.getUserinfo().getId() > 0) {
				setSeatstatuslist(checkticketService
						.qrySeatstatus(scheduleplanid,global.getOrganization().getStation().getId()));
			}
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	public String qrySeatstatusdetail() {
		
		Global global = CurrentUtil.getGlobal();
		try {
			checkticketService = new CheckticketServiceImpl();
			if (global != null && global.getUserinfo().getId() > 0) {
				setSeatstatuslist(checkticketService
						.qrySeatstatusdetail(ServletPropertyFilterUtil
								.buildFromHttpRequest()));

			}
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
		
		
		
//		
//		
//		Global global = CurrentUtil.getGlobal();
//		try {
//			checkticketService = new CheckticketServiceImpl();
//			if (global != null && global.getUserinfo().getId() > 0) {
////				setSeatstatusdetail(checkticketService
////						.qrySeatstatusdetail(ServletPropertyFilterUtil
////								.buildFromHttpRequest()));
//				List list =checkticketService
//				.qrySeatstatusdetail(ServletPropertyFilterUtil
//						.buildFromHttpRequest());
//				list1 = new ArrayList<Object>();
//				list2 = new ArrayList<Object>();
//				for(int i = list.size()/2; i < list.size(); i++){
//					list2.add(list.get(i));
//					setList2(list2);
//				}
//				for(int i = 0; i < list.size()/2; i++){
//					list1.add(list.get(i));
//					setList1(list1);
//				}
//			}
//		} catch (Exception e) {
//			play.Logger.error(e.getMessage(), e);
//		}
//		return "json";
	}
	
	public String checkcontinueByticketnos() {
		Global global = CurrentUtil.getGlobal();
		try {
			checkticketService = new CheckticketServiceImpl();
			if (global != null && global.getUserinfo().getId() > 0) {
				setChecktickets(checkticketService.checkByticketno(ServletPropertyFilterUtil.buildFromHttpRequest(),
						checkstationid, vehiclereportid, stratticketno,
						endticketno, global, islazycheck,
						ip, ticketentrance));
				markSuccess();
				setMsg("连检成功！");
			}
		} catch (BusinessException se) {
			setChecktickets(0);
			markFail();
			setMsg(se.getMessage());
		} catch (ServiceException se) {
			setChecktickets(0);
			markFail();
			setMsg(se.getMessage());
			setFlag(checkticketService.switchException(se.getExceptionCode()));
		} catch (Exception e) {
			markFail();
			setMsg("连检失败！");
			play.Logger.error(e.getMessage(), e);
		}
		return "json";

	}
	//综合检票-混检
	public String mixCheckticket() {
		Global global = CurrentUtil.getGlobal();
		markSuccess();
		setMsg("混检失败！");
		String transactionid = UUID.randomUUID().toString();
		CurrentUtil.setFlash("transactionid",transactionid);
		try {
			ParameterService parameterService = new ParameterServiceImpl();
			RemoteTransaction remoteTransaction = new RemoteTransaction();
			remoteTransaction.id = transactionid;
			remoteTransaction.formip = Request.current().host;
			remoteTransaction.type = TransactionType.MIX_TICKET_CHECK.ordinal();
			StringBuilder sb = new StringBuilder();
			Map<String, String> requestMap = new HashMap<String, String>();
			requestMap.put("checkstationid", checkstationid + "");
			requestMap.put("scheduleplanid", scheduleplanid + "");
			requestMap.put("vehiclereportid", vehiclereportid + "");
			requestMap.put("ticketid", ticketid + "");
			requestMap.put("checkedby", global.getUserinfo().getId() + "");
			requestMap.put("newseatno", newseatno + "");
			remoteTransaction.requestjson = JsonUtil.toSimpleString(requestMap);
			remoteTransaction.save();
			
			TransactionUtil.commit();
			TransactionUtil.begin();
			
			remoteTransaction.status = AppConstant.REMOTE_TRANSACTION_ING;
			remoteTransaction.save();
			
			stationService = new StationServiceImpl();
			checkticketService = new CheckticketServiceImpl();
			ticketservice = new TicketServiceImpl();
			BilltypeService billtypeService = new BilltypeServiceImpl();
			Billtype bt = billtypeService.findByCode("Ticket");
			String currentticketno = ""; 
			int ticketlength=(int) bt.getTicketnolength();
			if (global != null && global.getUserinfo().getId() > 0) {
				TicketDao ticketDao = new TicketDao();
				Ticketsell ticketsell = ticketDao.getTicketsell(ticketid);
				// 如果是团体票主票混检 则整体混检
				if (ticketsell.getTickettype().endsWith("T") && ticketsell.getTicketno().length() == ticketlength) {
					String ticketno = ticketsell.getTicketno();
					// 团体票混检
					MethodResult result = checkticketService.mixCheckTuanTicket(checkstationid, scheduleplanid,
							vehiclereportid, global, newseatno, ticketentrance, false, ticketsell);
					setMsg(result.getResultMsg());
					if (result.getResult() == 0) {
						markFail();
					} else {
						markSuccess();
					}
				} else {
					String p3091 = parameterService.findParamValue(ParamterConst.Param_3091, global.getOrganization().getId());
					Ticketsell ticket = null;
					if((ticketsell.getSellway().equals("7")||ticketsell.getSellway().equals("10"))&&p3091.equals("1")){
						long ticketsellid = ticketsell.getId();
						Ticketsell newticket = checkticketService.createNewTicketSell(ticketsell.getId(),global);
						ticket = checkticketService.mixCheckticket(checkstationid, scheduleplanid,
								vehiclereportid, newticket.getId(), global, newseatno, ticketentrance, false);
						if(ticketsell.getScheduleplanid()!=scheduleplanid){
							currentticketno = checkticketService.addTicketMixChange(ticketsellid,ticket);
						}
					}else{
						ticket = checkticketService.mixCheckticket(checkstationid, scheduleplanid,
								vehiclereportid, ticketid, global, newseatno, ticketentrance, false);
						currentticketno = ticket.getTicketno();
					}
					
					
					if (ticket != null) {
						if (ticket.getIslinework()) {
							markSuccess();
							setMsg(stationService.findById(ticket.getReachstationid()).getName() + ticket.getSeatno()
									+ "流水号,票号：" + currentticketno + "混检成功！");
						} else {
							markSuccess();
							setMsg(stationService.findById(ticket.getReachstationid()).getName() + ticket.getSeatno()
									+ "号座,票号：" + currentticketno + "混检成功！");
						}
						
						String p3038 = parameterService.findParamValue(ParamterConst.Param_3038, ticket.getOrgid());
						Customer customer = ticket.getCustomer();
						Schedule schedule = checkticketService.getSchedule(ticket);
						setIsshowCheckByCard(false);
						//当开启实名制检票并且顾客信息不为空
						if("1".equals(p3038) && customer!=null){
							setC_name(customer.getName());
							setC_sex(customer.getSex());
							setC_birth(customer.getBirthday()!=null?customer.getBirthday().toString():"");
							setC_address(customer.getFamilyaddress());
							setC_nation(customer.getNation());
							setC_certificateno(customer.getCertificateno());
							setC_certificatetype(ticket.getCertificatetypename());
							setC_schedulecode(schedule.getCode());
							setC_departtime(ticket.getDeparttime());
							setC_ticketno(ticket.getTicketno());
							setIsshowCheckByCard(true);
						}
					} else {
						markFail();
						setMsg("混检失败！");
					}
				}
			}
		} catch (BusinessException se) {
			setChecktickets(0);
			markFail();
			setMsg(se.getMessage());
		} catch (ServiceException se) {
			setChecktickets(0);
			markFail();
			setMsg(se.getMessage());
			setFlag(checkticketService.switchException(se.getExceptionCode()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			
			TransactionUtil.setRollbackOnly();
			String remoteurl =  CurrentUtil.getFlash("remoteurl");
			if(transactionid != null && remoteurl != null){
				TransactionUtil.addUndoJob(transactionid, remoteurl);
			}
		}
		return "json";

	}

	//综合检票-全检  实现全检
	public String checkAlltickets() {
		Global global = CurrentUtil.getGlobal();
		markSuccess();
		setMsg("全检失败！");
		try {
			checkticketService = new CheckticketServiceImpl();
			if (global != null && global.getUserinfo().getId() > 0) {
				setChecktickets(checkticketService.checkAlltickets(ServletPropertyFilterUtil.buildFromHttpRequest(),
						checkstationid, scheduleplanid, vehiclereportid, global, islazycheck, ip,
						ticketentrance));
				markSuccess();
				setMsg("全检成功！");

			}
		} catch (BusinessException se) {
			setChecktickets(0);
			markFail();
			setMsg(se.getMessage());
		} catch (ServiceException se) {
			setChecktickets(0);
			markFail();
			setMsg(se.getMessage());
			setFlag(checkticketService.switchException(se.getExceptionCode()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";

	}

	public String queryMixInfo() {
		try {
			checkticketService = new CheckticketServiceImpl();
			msg = checkticketService.queryMixInfo(ticketid);
		} catch (Exception e) {
			msg = "查询混检信息异常！";
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String queryisMix() {
		Global global = CurrentUtil.getGlobal();
		markSuccess();
		try {
			checkticketService = new CheckticketServiceImpl();
			if (global != null && global.getUserinfo().getId() > 0) {
				if (checkticketService.isMixTicket(global, checkstationid,
						ticketno)) {
					mixcheck = 1;
				} else {
					mixcheck = 0;
				}
			}
		} catch (Exception e) {
			mixcheck = 0;
			msg = "查询混检信息异常！";
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String addMusicContent() {
		try {
			checkticketService = new CheckticketServiceImpl();
			markSuccess();
			msg = "发送成功！";
			checkticketService.addMusicContent(lc);
		} catch (Exception e) {
			msg = "发送失败！";
			markSuccess();
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	// 通检
	public String CheckByticketnos() {
		checkticketService = new CheckticketServiceImpl();
		if (checkticketService == null) {
			System.out
					.println("CheckByticketno EJB Service @InjectEJB DI fails^^^^^^^^^");
			return "json";
		}
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				BatchCheckticketService batchCheckticketService = new BatchCheckticketServiceImpl();
				String ms = batchCheckticketService.checkByticketnos(
						checkstationid, scheduleplanid, vehiclereportid,
						ticketno, global, islazycheck,
						ip, "");
				markSuccess();
				setMsg(ms);
			}

		} catch (ServiceException se) {
			setScheduleplanid((long) -1);
			markFail();
			setMsg(se.getMessage());
			setFlag(checkticketService.switchException(se.getExceptionCode()));
		} catch (Exception e) {
			markFail();
			setMsg("通检失败！");
			play.Logger.error(e.getMessage(), e);
		}
		return "json";

	}

	// 查询检远程票
	public String qrycheckRemoteticket() {
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				checkTicketClientService = new CheckTicketClientServiceImpl(); 
				outparam = checkTicketClientService.findTicketsell(inparam,
						global);
				markSuccess();
				setMsg("查询成功！");
			}
		} catch (ServiceException e) {
			markFail();
			setMsg("查询票号：" + inparam.getTicketno() + "失败！");
		}catch (Exception e) {
			outparam = new ParamCheckTicketOut();
			outparam.setResult(-1);
			markFail();
			setMsg("查询票号：" + inparam.getTicketno() + "失败！");
			play.Logger.error(e.getMessage(), e);
		}
		return "json";

	}

	// 检远程票
	public String checkRemoteticket() {
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				checkTicketClientService = new CheckTicketClientServiceImpl();
				outparam = checkTicketClientService.checkTicketsell(inparam,
						global);
			}
		} catch (Exception e) {
			if (outparam == null) {
				outparam = new ParamCheckTicketOut();
			}
			outparam.setResult(-1);
			outparam.setResultMsg("票号：" + inparam.getTicketno() + "检远检票失败！");

			play.Logger.error(e.getMessage(), e);
		}
		return "json";

	}	
	
	/**
	 * 检票界面双击班次获取 到站和票数信息
	 * @param scheduleplanid
	 * @param ischecked
	 * @return
	 */
	public String qrySumTickets(){
		checkticketService = new CheckticketServiceImpl();
		setSumticketlist(checkticketService.sumTickets(scheduleplanid));
		return "json";
	}
	
	public String qryOrgSells() {
		Global global = CurrentUtil.getGlobal();
		try {
			checkTicketClientService = new CheckTicketClientServiceImpl();
			msg=checkTicketClientService.qryOrgSell(departdate,scheduleid,global);
			markSuccess();
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			markSuccess();
		}
		return "json";
	}
	
	/**
	 * 刷卡开检
	 * @return
	 */
	
	public String setScheduleStatus(){
		
		checkticketService = new CheckticketServiceImpl();
		
		String[] str = checkticketService.setScheduleStatus(cardno, departdate);		
		
		if(str[1].equals("1")){
			msg = "开始检票";
			markSuccess();
			String s = str[2].trim();
			setScheduleplanid(Long.parseLong(s));
			setVehicleno(str[3].trim());
		}else{
			msg = str[0];
			String s = str[2].trim();
			setScheduleplanid(Long.parseLong(s));
			setVehicleno(str[3].trim());
			markFail();
		}
		
		return "json";
	}
	
	//校验需检票的发车站是否在输入的发车站范围内
	public String verifyDepartstation() {
		Global global = CurrentUtil.getGlobal();
		try {
			checkticketService = new CheckticketServiceImpl();
			if (global != null && global.getUserinfo().getId() > 0) {
				setVerifystation(checkticketService.verifyDepartstation(ServletPropertyFilterUtil.buildFromHttpRequest(),
						ticketno,departdate));
				markSuccess();
				setMsg("");
			}
		} catch (ServiceException se) {
			setChecktickets(0);
			markFail();
			setMsg(se.getMessage());
		} catch (Exception e) {
			markFail();
			setMsg("");
			play.Logger.error(e.getMessage(), e);
		}
		return "json";

	}
	
	/**
	 * 通过身份证获取车票信息
	 * @return
	 */
	public String qryTicketinfoByIDcard(){		
		checkticketService = new CheckticketServiceImpl();		
		setTicketlist(checkticketService.qryTicketinfoByIDcard(ServletPropertyFilterUtil.buildFromHttpRequest()));		
		return "json";
	}
	//根据电子票号的密文得到对应的电子票号
	
	private String encryptionticketno;
		public String qryEstationsellticket() {
			Global global = CurrentUtil.getGlobal();
			try {
				if (global != null && global.getUserinfo().getId() > 0) {
					checkticketService = new CheckticketServiceImpl();
					ticketno = checkticketService.qryEstationsellticket(encryptionticketno,
							global);
					markSuccess();
					setMsg("解密成功！");
				}
			}catch (Exception e) {
				outparam = new ParamCheckTicketOut();
				outparam.setResult(-1);
				markFail();
				setMsg("解密失败！");
				play.Logger.error(e.getMessage(), e);
			}
			return "json";

		}
	
	public String getEncryptionticketno() {
			return encryptionticketno;
		}

		public void setEncryptionticketno(String encryptionticketno) {
			this.encryptionticketno = encryptionticketno;
		}

	public long getScheduleid() {
		return scheduleid;
	}

	public void setScheduleid(long scheduleid) {
		this.scheduleid = scheduleid;
	}
	
	public List<Map<String, Object>> getSumticketlist() {
		return sumticketlist;
	}

	public void setSumticketlist(List<Map<String, Object>> sumticketlist) {
		this.sumticketlist = sumticketlist;
	}

	public Long getCheckstationid() {
		return checkstationid;
	}

	public void setCheckstationid(Long checkstationid) {
		this.checkstationid = checkstationid;
	}

	public long getVehiclereportid() {
		return vehiclereportid;
	}

	public void setVehiclereportid(long vehiclereportid) {
		this.vehiclereportid = vehiclereportid;
	}

	public String getTicketno() {
		return ticketno;
	}

	public void setTicketno(String ticketno) {
		this.ticketno = ticketno;
	}

	public List<Map<String, Object>> getPlanlist() {
		return planlist;
	}

	public void setPlanlist(List<Map<String, Object>> planlist) {
		this.planlist = planlist;
	}

	public Long getOrgid() {
		return orgid;
	}

	public void setOrgid(Long orgid) {
		this.orgid = orgid;
	}

	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

	public List<Map<String, Object>> getEntrancelist() {
		return entrancelist;
	}

	public void setEntrancelist(List<Map<String, Object>> entrancelist) {
		this.entrancelist = entrancelist;
	}

	public Date getDepartdate() {
		return departdate;
	}

	public void setDepartdate(Date departdate) {
		this.departdate = departdate;
	}

	public Long getReportorgid() {
		return reportorgid;
	}

	public void setReportorgid(Long reportorgid) {
		this.reportorgid = reportorgid;
	}

	public Long getScheduleplanid() {
		return scheduleplanid;
	}

	public void setScheduleplanid(Long scheduleplanid) {
		this.scheduleplanid = scheduleplanid;
	}

	public Short getSeatno() {
		return seatno;
	}

	public void setSeatno(Short seatno) {
		this.seatno = seatno;
	}

	public List<Map<String, Object>> getReportvehiclelist() {
		return reportvehiclelist;
	}

	public void setReportvehiclelist(List<Map<String, Object>> reportvehiclelist) {
		this.reportvehiclelist = reportvehiclelist;
	}

	public List<Map<String, Object>> getCheckticketedlist() {
		return checkticketedlist;
	}

	public void setCheckticketedlist(List<Map<String, Object>> checkticketedlist) {
		this.checkticketedlist = checkticketedlist;
	}

	public List<Map<String, Object>> getSeatstatuslist() {
		return seatstatuslist;
	}

	public void setSeatstatuslist(List<Map<String, Object>> seatstatuslist) {
		this.seatstatuslist = seatstatuslist;
	}

	public String getStratticketno() {
		return stratticketno;
	}

	public void setStratticketno(String stratticketno) {
		this.stratticketno = stratticketno;
	}

	public String getEndticketno() {
		return endticketno;
	}

	public void setEndticketno(String endticketno) {
		this.endticketno = endticketno;
	}

	public Integer getChecktickets() {
		return checktickets;
	}

	public void setChecktickets(Integer checktickets) {
		this.checktickets = checktickets;
	}

	public List<Map<String, Object>> getTicketlist() {
		return ticketlist;
	}

	public void setTicketlist(List<Map<String, Object>> ticketlist) {
		this.ticketlist = ticketlist;
	}

	public Long getTicketid() {
		return ticketid;
	}

	public void setTicketid(Long ticketid) {
		this.ticketid = ticketid;
	}

	public boolean isIslazycheck() {
		return islazycheck;
	}

	public void setIslazycheck(boolean islazycheck) {
		this.islazycheck = islazycheck;
	}

	public short getNewseatno() {
		return newseatno;
	}

	public void setNewseatno(short newseatno) {
		this.newseatno = newseatno;
	}

	public String getTicketentrance() {
		return ticketentrance;
	}

	public void setTicketentrance(String ticketentrance) {
		this.ticketentrance = ticketentrance;
	}

	public boolean isIsdeparted() {
		return isdeparted;
	}

	public void setIsdeparted(boolean isdeparted) {
		this.isdeparted = isdeparted;
	}

	public Ledcontent getLc() {
		return lc;
	}

	public void setLc(Ledcontent lc) {
		this.lc = lc;
	}

	public Integer getOneCardChecktickets() {
		return oneCardChecktickets;
	}

	public void setOneCardChecktickets(Integer oneCardChecktickets) {
		this.oneCardChecktickets = oneCardChecktickets;
	}

	public String getTicketids() {
		return ticketids;
	}

	public void setTicketids(String ticketids) {
		this.ticketids = ticketids;
	}

	public long getReportid() {
		return reportid;
	}

	public void setReportid(long reportid) {
		this.reportid = reportid;
	}

	public int getMixcheck() {
		return mixcheck;
	}

	public void setMixcheck(int mixcheck) {
		this.mixcheck = mixcheck;
	}

	public ParamCheckTicketOut getOutparam() {
		return outparam;
	}

	public void setOutparam(ParamCheckTicketOut outparam) {
		this.outparam = outparam;
	}

	public ParamCheckTicketIn getInparam() {
		return inparam;
	}

	public void setInparam(ParamCheckTicketIn inparam) {
		this.inparam = inparam;
	}
	public Integer getUnchecktickets() {
		return unchecktickets;
	}

	public void setUnchecktickets(Integer unchecktickets) {
		this.unchecktickets = unchecktickets;
	}

	public String getCardno() {
		return cardno;
	}

	public void setCardno(String cardno) {
		this.cardno = cardno;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public List<Map<String, Object>> getSeatstatusdetail() {
		return seatstatusdetail;
	}

	public void setSeatstatusdetail(List<Map<String, Object>> seatstatusdetail) {
		this.seatstatusdetail = seatstatusdetail;
	}

	public Scheduleseats getScheduleseats() {
		return scheduleseats;
	}

	public void setScheduleseats(Scheduleseats scheduleseats) {
		this.scheduleseats = scheduleseats;
	}

	public List<Object> getList2() {
		return list2;
	}

	public void setList2(List<Object> list2) {
		this.list2 = list2;
	}

	public List<Object> getList1() {
		return list1;
	}

	public void setList1(List<Object> list1) {
		this.list1 = list1;
	}

	public Integer getVerifystation() {
		return verifystation;
	}

	public void setVerifystation(Integer verifystation) {
		this.verifystation = verifystation;
	}

	public long getSellerid() {
		return sellerid;
	}

	public void setSellerid(long sellerid) {
		this.sellerid = sellerid;
	}

	public long getDepartinvoicesid() {
		return departinvoicesid;
	}

	public void setDepartinvoicesid(long departinvoicesid) {
		this.departinvoicesid = departinvoicesid;
	}

	public void setScheduleplanid(long scheduleplanid) {
		this.scheduleplanid = scheduleplanid;
	}

	public long getDepartstationid() {
		return departstationid;
	}

	public void setDepartstationid(long departstationid) {
		this.departstationid = departstationid;
	}

	public boolean isIsbegincheck() {
		return isbegincheck;
	}

	public void setIsbegincheck(boolean isbegincheck) {
		this.isbegincheck = isbegincheck;
	}

	public String getCertificateno() {
		return certificateno;
	}

	public void setCertificateno(String certificateno) {
		this.certificateno = certificateno;
	}

	public String getChecktype() {
		return checktype;
	}

	public void setChecktype(String checktype) {
		this.checktype = checktype;
	}

	public ScheduleStartCheck getSchedulestartcheck() {
		return schedulestartcheck;
	}

	public void setSchedulestartcheck(ScheduleStartCheck schedulestartcheck) {
		this.schedulestartcheck = schedulestartcheck;
	}

	public String getVehicleno() {
		return vehicleno;
	}

	public void setVehicleno(String vehicleno) {
		this.vehicleno = vehicleno;
	}

	public String getC_name() {
		return c_name;
	}

	public void setC_name(String c_name) {
		this.c_name = c_name;
	}

	public String getC_sex() {
		return c_sex;
	}

	public void setC_sex(String c_sex) {
		this.c_sex = c_sex;
	}

	public String getC_birth() {
		return c_birth;
	}

	public void setC_birth(String c_birth) {
		this.c_birth = c_birth;
	}

	public String getC_address() {
		return c_address;
	}

	public void setC_address(String c_address) {
		this.c_address = c_address;
	}

	public String getC_nation() {
		return c_nation;
	}

	public void setC_nation(String c_nation) {
		this.c_nation = c_nation;
	}

	public String getC_certificateno() {
		return c_certificateno;
	}

	public void setC_certificateno(String c_certificateno) {
		this.c_certificateno = c_certificateno;
	}

	public String getC_certificatetype() {
		return c_certificatetype;
	}

	public void setC_certificatetype(String c_certificatetype) {
		this.c_certificatetype = c_certificatetype;
	}

	public String getC_schedulecode() {
		return c_schedulecode;
	}

	public void setC_schedulecode(String c_schedulecode) {
		this.c_schedulecode = c_schedulecode;
	}

	public String getC_departtime() {
		return c_departtime;
	}

	public void setC_departtime(String c_departtime) {
		this.c_departtime = c_departtime;
	}

	public String getC_ticketno() {
		return c_ticketno;
	}

	public void setC_ticketno(String c_ticketno) {
		this.c_ticketno = c_ticketno;
	}

	public boolean isIsshowCheckByCard() {
		return isshowCheckByCard;
	}

	public void setIsshowCheckByCard(boolean isshowCheckByCard) {
		this.isshowCheckByCard = isshowCheckByCard;
	}
}
