package cn.nova.bus.checkticket.action;

import cn.nova.bus.action.BaseAction;
import java.util.Date;
import java.util.List;
import java.util.Map;

import util.CurrentUtil;
import cn.nova.bus.balance.service.BalancedeductService;
import cn.nova.bus.balance.service.impl.BalancedeductServiceImpl;
import cn.nova.bus.checkticket.model.Departinvoices;
import cn.nova.bus.checkticket.service.DepartinvoiceService;
import cn.nova.bus.checkticket.service.impl.DepartinvoiceServiceImpl;
import cn.nova.bus.checkticket.vo.DepartinvoicesVo;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;
import cn.nova.utils.orm.jpa.ListUtil;
import cn.nova.utils.web.ServletPropertyFilterUtil;

/**
 * @author lck
 * 
 */
public class DepartinvoiceAction extends BaseAction{
	private String departinvoicesno;
	private String ip;
	private Long departstationid;
	private Long scheduleplanid;
	private Long vehiclereportid;
	private Long departinvoicesid;
	private DepartinvoicesVo dnv;
	private List<Map<String, Object>> invoiceslist; 
	private List<Map<String, Object>> invoicesdetaillist;
	private boolean isreprint;
	private String othersells;

	private long printpermission;
	private Long scheduleid;
	
	private Date departdate;
	private boolean iscomputeno;
	private boolean isprintbynewticketno;
	private String msg1;
	private long balanceid;
	private boolean islinework;
	private String cardno;
	private long reportorgid;
	private List<Map<String, Object>> ticketsDetail;
	private String reporttime;
	private long vehicleid;
	private Long firstcheckid;
	

	private String isByprice;//判断当前打印结算通知单是否按照到达站票价在进行分组
	public String getIsByprice() {
		return isByprice;
	}

	public void setIsByprice(String isByprice) {
		this.isByprice = isByprice;
	}
	private List<Map<String,Object>> balancedetailprintlist;
	private List<Map<String,Object>> balanceStationdetailprintlist;
	public List<Map<String, Object>> getBalanceStationdetailprintlist() {
		return balanceStationdetailprintlist;
	}

	public void setBalanceStationdetailprintlist(
			List<Map<String, Object>> balanceStationdetailprintlist) {
		this.balanceStationdetailprintlist = balanceStationdetailprintlist;
	}

	private List<Map<String,Object>> balancedetaillist;
	


	public String getMsg1() {
		return msg1;
	}

	public void setMsg1(String msg1) {
		this.msg1 = msg1;
	}

	private DepartinvoiceService departinvoiceService;
	
	public String qryBalancedetailPrint(){
		departinvoiceService = new DepartinvoiceServiceImpl();
		setBalancedetailprintlist(departinvoiceService.qryBalancedetailPrint(balanceid));		
		return "json";
	}
	
	public String qryBalanceStationdetailPrint()
	{
		departinvoiceService = new DepartinvoiceServiceImpl();
		setBalanceStationdetailprintlist(departinvoiceService.qryBalanceStationdetailPrint(balanceid,isByprice));
			
		return "json";
	}
	
	/**
	 * 自助发班查询班次计划
	 * @return
	 */
	public String qryScheduleReport(){
		departinvoiceService = new DepartinvoiceServiceImpl();
		try {
			setInvoiceslist(departinvoiceService.qryScheduleReport(cardno, reportorgid));
		} catch (ServiceException e) {
			play.Logger.error(e.getMessage(), e);
		}		
		return "json";
	}
	
	//查询结算单汇总明细
	public String qryBalancedetail(){
		departinvoiceService = new DepartinvoiceServiceImpl();
		setBalancedetaillist(departinvoiceService.qryBalancedetail(balanceid));		
		return "json";
	}
	
	public String queryFirstCheck(){
		try {
			departinvoiceService = new DepartinvoiceServiceImpl();
			invoicesdetaillist = departinvoiceService
					.queryFirstCheck(scheduleplanid,departstationid,vehiclereportid,islinework,firstcheckid);
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	private String originaldepartinvoicesno;// 自助打单时选中的结算单(原)单号
	
	// 自助打单结算单打印

	public String getOriginaldepartinvoicesno() {
		return originaldepartinvoicesno;
	}

	public void setOriginaldepartinvoicesno(String originaldepartinvoicesno) {
		this.originaldepartinvoicesno = originaldepartinvoicesno;
	}

	public String selfVehicleDepartinvoice() {
		departinvoiceService = new DepartinvoiceServiceImpl();
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				if (isreprint) {
					invoiceslist = departinvoiceService.reprintDepartinvoice(departstationid, scheduleplanid,
							vehiclereportid, ip, global.getUserinfo().getId(), departinvoicesno, isprintbynewticketno,
							originaldepartinvoicesno);
					markSuccess();
					setMsg("重打成功！");
				} else {
					invoiceslist = departinvoiceService.schDepartinvoice(global, scheduleplanid, vehiclereportid, ip,
							departinvoicesno, "0", iscomputeno);

					boolean re = departinvoiceService.isSecurityQualify(vehiclereportid);
					markSuccess();
					if (!re) {
						setMsg1("securityisfalse");
					}
					setMsg("发班成功！");
				}
			}
		} catch (ServiceException se) {
			markFail();
			setMsg(se.getMessage());
			invoiceslist = ListUtil.listToMap(new Object[] { DepartinvoicesVo.class }, null,
					new Object[] { DepartinvoicesVo.class });
			;
		} catch (Exception e) {
			markFail();
			if (isreprint) {
				if (e.getMessage().length() > 0) {
					setMsg(e.getMessage());
				} else {
					setMsg("重打失败！");
				}
			} else {
				setMsg("发班失败！");
			}
			e.printStackTrace();
			play.Logger.error(e.getMessage(), e);
			invoiceslist = ListUtil.listToMap(new Object[] { DepartinvoicesVo.class }, null,
					new Object[] { DepartinvoicesVo.class });
			;
		}
		return "json";

	}

	/**
	 * 查询发班结算单的结算人 进行权限控制
	 * 
	 * @return
	 */
	
	public String reprintPermission() {
		try {
			Global global = CurrentUtil.getGlobal();
			departinvoiceService = new DepartinvoiceServiceImpl();
			Departinvoices ds = departinvoiceService.findDepartinvoice(vehiclereportid,departdate,scheduleplanid,scheduleid);
			if(ds==null){
				printpermission=-1; //不存在结算单
			}else{
				if(global.getUserinfo().getId()==ds.getPrintby()){
					printpermission=1;//为自己的结算单 可以重打操作
				}else{
					printpermission=0;//别人的结算单，需要权限
				}
			}
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	//新增判断报班车辆安检是否合格，返回结果到前台
	public String vehicleSecurityIsTure()
	{
		departinvoiceService = new DepartinvoiceServiceImpl();
		boolean re = departinvoiceService.isSecurityQualify(vehiclereportid);
		if(!re)
		{
			setMsg1("securityisfalse");
		}
		return "json";
	}
	/**
	 * 自助发班检查同一天同一车前前一个报到班次是否发班
	 * @return
	 */
	public String checkPreDepart() {
		departinvoiceService = new DepartinvoiceServiceImpl();
		try {
			boolean re = departinvoiceService.checkPreDepart(vehicleid,departdate,reporttime);
			if(re){
				markSuccess();	
			}else{
				markFail();
				setMsg("不允许发班打单");
			}
		} catch (ServiceException se) {
			markFail();
			setMsg(se.getMessage());
		}
		return "json";
	}
	public String vehicleDepartinvoice() {
		departinvoiceService = new DepartinvoiceServiceImpl();
		Global global = CurrentUtil.getGlobal();
		play.Logger.info("--------------------自助发班打印结算单开始----------------------");
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				if (isreprint) {
					play.Logger.info("--------------------自助发班打印结算单重打----------------------");
					invoiceslist = departinvoiceService.reprintDepartinvoice(
							departstationid, scheduleplanid, vehiclereportid, ip,
							global.getUserinfo().getId(), departinvoicesno,isprintbynewticketno);
					markSuccess();
					setMsg("重打成功！");
				} else {
					play.Logger.info("--------------------自助发班打印结算单发班打印----------------------");
					invoiceslist = departinvoiceService.schDepartinvoice(global,
							 scheduleplanid, vehiclereportid,ip, departinvoicesno,
							"0", iscomputeno);
					
					boolean re = departinvoiceService.isSecurityQualify(vehiclereportid);
					markSuccess();
					if(!re){
						setMsg1("securityisfalse");
					}
					setMsg("发班成功！");
					
				}
			}
		} catch (ServiceException se) {
			markFail();
			setMsg(se.getMessage());
			invoiceslist= ListUtil.listToMap( new Object[]{DepartinvoicesVo.class},null, new Object[]{DepartinvoicesVo.class});;
		} catch (Exception e) {
			markFail();
			if (isreprint) {
				setMsg("重打失败！");
			}else{
				setMsg("发班失败！");
			}
			e.printStackTrace();
			play.Logger.error(e.getMessage(), e);
			invoiceslist= ListUtil.listToMap( new Object[]{DepartinvoicesVo.class},null, new Object[]{DepartinvoicesVo.class});;			
		}
		return "json";

	}

	public String schDepartinvoice() {
		Global global = CurrentUtil.getGlobal();
		try {
			departinvoiceService = new DepartinvoiceServiceImpl();
			if (global != null && global.getUserinfo().getId() > 0) {
				departinvoiceService.schDepartinvoice(global, scheduleplanid, vehiclereportid);
					markSuccess();
					setMsg("发班成功！");
			}
		} catch (ServiceException se) {
			markFail();
			setMsg(se.getMessage());
		} catch (Exception e) {
			markFail();
			setMsg("发班失败！");
			play.Logger.error(e.getMessage(), e);
		}
		return "json";

	}

	// 取消发班
	public String cancelDepartinvoices() {
		departinvoiceService = new DepartinvoiceServiceImpl();
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				departinvoiceService.cancelDepartinvoices(departstationid,
						scheduleplanid, vehiclereportid, global.getUserinfo()
								.getId());
				markSuccess();
				setMsg("取消成功！");
			}
		} catch (ServiceException se) {
			markFail();
			setMsg(se.getMessage());
		} catch (Exception e) {
			markFail();
			setMsg("取消失败！");
			play.Logger.error(e.getMessage(), e);
		}
		return "json";

	}
	private long id;	
	public String departinvoicesapproveing() {
		departinvoiceService = new DepartinvoiceServiceImpl();
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
			 	departinvoiceService.departinvoicesapproveing(id,global);
				markSuccess();
				setMsg("审核成功！");
			}
		} catch (Exception e) {
			markFail();
			setMsg("审核失败！");
			play.Logger.error(e.getMessage(), e);
		}
		return "json";

	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	//
	public String qryInvoicesDetailPrintInfo() {
		try {
			departinvoiceService = new DepartinvoiceServiceImpl();
			invoicesdetaillist = departinvoiceService
					.qryInvoicesDetailPrintInfo(departinvoicesid);
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	public String qryDeductfees() {
		try {
			departinvoiceService = new DepartinvoiceServiceImpl();
			BalancedeductService balancedeductService = new BalancedeductServiceImpl();
			invoicesdetaillist = balancedeductService
					.qryDeductfee(departinvoicesid);
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	/**
	 * 根据运量单ID发车日期，获取该单的他站售票情况
	 * @return
	 */
	public String qryOthersellmessage() {
		try {
			departinvoiceService = new DepartinvoiceServiceImpl();
			othersells = departinvoiceService.getOthersellmessage(departinvoicesid,departdate);
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	/**
	 * 查询AcReport打印结算单时的车票明细和结算单明细
	 * @return
	 */
	public String queryTicketDetail(){
		try {
			departinvoiceService = new DepartinvoiceServiceImpl();
			setInvoicesdetaillist(departinvoiceService
					.queryTicketDetail(ServletPropertyFilterUtil
							.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	/**
	 * 打印结算单:只查询检到该结算单上的车票，包括：【座号】、【票号】、【到达站】、【票价】、【售票员】
	 * @return
	 */
	public String qryDptTicketdetail(){
		try {
			departinvoiceService = new DepartinvoiceServiceImpl();
			setTicketsDetail(departinvoiceService
					.qryDptTicketdetail(ServletPropertyFilterUtil
							.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	/**
	 * 补开初检单查询
	 * @return
	 */
	public String queryOpenFirstCheck(){
		try {
			departinvoiceService = new DepartinvoiceServiceImpl();
			invoicesdetaillist = departinvoiceService
					.queryOpenFirstCheck(scheduleplanid,departstationid,vehiclereportid,islinework);
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	
	/**
	 * 查询手工单打印明细
	 * @return
	 */
	private Long departinvoicesotherid;

	public String qryDepartInvoicesOtherDetailPrintInfo() {
		try {
			departinvoiceService = new DepartinvoiceServiceImpl();
			invoicesdetaillist = departinvoiceService.qryDepartInvoicesOtherDetailPrintInfo(departinvoicesotherid);
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	/**
	 * 26035 内蒙古+音德尔+结算通知单打印加入司机姓名变量
	 * @return
	 */
	private String vehicleids;
	public String qryDriverName() {
		try {
			departinvoiceService = new DepartinvoiceServiceImpl();
			 String driverName = departinvoiceService.qryDriverName(vehicleids);
			 setMsg(driverName);
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	
	public Long getDepartinvoicesotherid() {
		return departinvoicesotherid;
	}

	public void setDepartinvoicesotherid(Long departinvoicesotherid) {
		this.departinvoicesotherid = departinvoicesotherid;
	}
	
	public String getDepartinvoicesno() {
		return departinvoicesno;
	}

	public void setDepartinvoicesno(String departinvoicesno) {
		this.departinvoicesno = departinvoicesno;
	}

	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

	public Long getDepartstationid() {
		return departstationid;
	}

	public void setDepartstationid(Long departstationid) {
		this.departstationid = departstationid;
	}

	public Long getScheduleplanid() {
		return scheduleplanid;
	}

	public void setScheduleplanid(Long scheduleplanid) {
		this.scheduleplanid = scheduleplanid;
	}

	public Long getVehiclereportid() {
		return vehiclereportid;
	}

	public void setVehiclereportid(Long vehiclereportid) {
		this.vehiclereportid = vehiclereportid;
	}

	public Long getDepartinvoicesid() {
		return departinvoicesid;
	}

	public void setDepartinvoicesid(Long departinvoicesid) {
		this.departinvoicesid = departinvoicesid;
	}

	public DepartinvoicesVo getDnv() {
		return dnv;
	}

	public void setDnv(DepartinvoicesVo dnv) {
		this.dnv = dnv;
	}

	public List<Map<String, Object>> getInvoicesdetaillist() {
		return invoicesdetaillist;
	}

	public void setInvoicesdetaillist(
			List<Map<String, Object>> invoicesdetaillist) {
		this.invoicesdetaillist = invoicesdetaillist;
	}

	public Date getDepartdate() {
		return departdate;
	}

	public void setDepartdate(Date departdate) {
		this.departdate = departdate;
	}

	public boolean isIscomputeno() {
		return iscomputeno;
	}

	public void setIscomputeno(boolean iscomputeno) {
		this.iscomputeno = iscomputeno;
	}

	public String getOthersells() {
		return othersells;
	}

	public void setOthersells(String othersells) {
		this.othersells = othersells;
	}
	public boolean isIsreprint() {
		return isreprint;
	}

	public void setIsreprint(boolean isreprint) {
		this.isreprint = isreprint;
	}
			
	public boolean isIsprintbynewticketno() {
		return isprintbynewticketno;
	}

	public void setIsprintbynewticketno(boolean isprintbynewticketno) {
		this.isprintbynewticketno = isprintbynewticketno;
	}

	public List<Map<String, Object>> getInvoiceslist() {
		return invoiceslist;
	}

	public void setInvoiceslist(List<Map<String, Object>> invoiceslist) {
		this.invoiceslist = invoiceslist;
	}
	public long getPrintpermission() {
		return printpermission;
	}

	public void setPrintpermission(long printpermission) {
		this.printpermission = printpermission;
	}

	public Long getScheduleid() {
		return scheduleid;
	}

	public void setScheduleid(Long scheduleid) {
		this.scheduleid = scheduleid;
	}

	public List<Map<String,Object>> getBalancedetailprintlist() {
		return balancedetailprintlist;
	}

	public void setBalancedetailprintlist(List<Map<String,Object>> balancedetailprintlist) {
		this.balancedetailprintlist = balancedetailprintlist;
	}

	public long getBalanceid() {
		return balanceid;
	}

	public void setBalanceid(long balanceid) {
		this.balanceid = balanceid;
	}

	public List<Map<String, Object>> getBalancedetaillist() {
		return balancedetaillist;
	}

	public void setBalancedetaillist(List<Map<String, Object>> balancedetaillist) {
		this.balancedetaillist = balancedetaillist;
	}

	public boolean isIslinework() {
		return islinework;
	}

	public void setIslinework(boolean islinework) {
		this.islinework = islinework;
	}

	public String getCardno() {
		return cardno;
	}

	public void setCardno(String cardno) {
		this.cardno = cardno;
	}

	public long getReportorgid() {
		return reportorgid;
	}

	public void setReportorgid(long reportorgid) {
		this.reportorgid = reportorgid;
	}

	public List<Map<String, Object>> getTicketsDetail() {
		return ticketsDetail;
	}

	public void setTicketsDetail(List<Map<String, Object>> ticketsDetail) {
		this.ticketsDetail = ticketsDetail;
	}

	public String getReporttime() {
		return reporttime;
	}

	public void setReporttime(String reporttime) {
		this.reporttime = reporttime;
	}

	public long getVehicleid() {
		return vehicleid;
	}

	public void setVehicleid(long vehicleid) {
		this.vehicleid = vehicleid;
	}

	public Long getFirstcheckid() {
		return firstcheckid;
	}

	public void setFirstcheckid(Long firstcheckid) {
		this.firstcheckid = firstcheckid;
	}

	public String getVehicleids() {
		return vehicleids;
	}

	public void setVehicleids(String vehicleids) {
		this.vehicleids = vehicleids;
	}

}
