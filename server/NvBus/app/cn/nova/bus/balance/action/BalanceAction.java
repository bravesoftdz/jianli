package cn.nova.bus.balance.action;

import cn.nova.bus.action.BaseAction;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.Map;

import util.CurrentUtil;
import cn.nova.bus.balance.model.Balance;
import cn.nova.bus.balance.model.Balancedeductdetail;
import cn.nova.bus.balance.model.Balancestationdeduct;
import cn.nova.bus.balance.service.BalanceService;
import cn.nova.bus.balance.service.BalancedeductService;
import cn.nova.bus.balance.service.impl.BalanceServiceImpl;
import cn.nova.bus.balance.service.impl.BalancedeductServiceImpl;
import cn.nova.bus.balance.vo.OtherBalanceinfo;
import cn.nova.bus.checkticket.model.Departinvoices;
import cn.nova.bus.common.ParamterConst;
import cn.nova.bus.exception.BusinessException;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.pack.service.impl.PackServiceImpl;
import cn.nova.bus.security.Global;
import cn.nova.bus.system.service.impl.ParameterServiceImpl;
import cn.nova.utils.commons.MethodResult;
import cn.nova.utils.web.ServletPropertyFilterUtil;

/**
 * 
 * <p>
 * Title: 结算单结算
 * </p>
 * <p>
 * Description:
 * </p>
 * <p>
 * Copyright: Copyright (c) 2011
 * </p>
 * <p>
 * Company: nova
 * </p>
 * 
 * @author lanckun
 * @version 0.1
 */
public class BalanceAction extends BaseAction{
	private String invoicesids;
	private String otherinvoicesids;
	private String vehicleids;
	private Date fromdepart;
	private Date todepart;
	private long departinvoincesid;
	private String balanceobject;
	private long objectid;
	private List<Map<String, Object>> departinvoinceslist;
	private List<Map<String, Object>> invoincesdeductlist;
	private List<Map<String, Object>> unitvehicletree;
	private List<Map<String, Object>> busTransportlist;
	private List<Map<String, Object>> bilancemoneylist;
	private List<Balancedeductdetail> dds;
	private OtherBalanceinfo obi;
	private Long balanceid;
	private String orgids;
	private long orgid;
	private long balanceunitid;
	private String routename;
	private long routeid;
	private long vehicleid;
	private String vehicleno;
	private Balance balance;
	private String balanceno;
	private int balancetype;
	private int departinvoicestype;
	private String deductmoney;
	
	
	private String ticketsellid;
	private long departinvoicesid;
	private long fromstationid;
	private long reachstationid;
	private String tickettype;
	private BigDecimal price;
	private long ticketnum;
	private BigDecimal fueladditionfee;
	private BigDecimal stationservicefee;
	private BigDecimal totalamount;
	private BigDecimal othterfee;
	private BigDecimal balanceamount;
	private String param;
	private String ip;
	private String departinvoicesno;
	private String vehicleunitname;
	
	private Date qryfromdate;//结算单结算页面发车开始日期：生成扣费的开始日期
	private Date qrytodate;//结算单结算页面发车截止日期：生成扣费的截止日期
	
	private String leaveBalance;//前台传过来待转换的金额
	public String getLeaveBalance() {
		return leaveBalance;
	}

	public void setLeaveBalance(String leaveBalance) {
		this.leaveBalance = leaveBalance;
	}

	private String leaveBalanceresult;//新增应节金额四舍五入

	public String getLeaveBalanceresult() {
		return leaveBalanceresult;
	}

	public void setLeaveBalanceresult(String leaveBalanceresult) {
		this.leaveBalanceresult = leaveBalanceresult;
	}

	private BigDecimal otherdeductfee;
	private List<Map<String, Object>> balancedeductlist;
	private List<Map<String, Object>> balancedlist;
	private List<Map<String, Object>> maplist;
	private List<Map<String, Object>> vehiclemap;
	
	private List<Map<String, Object>> haveDepartinvoicelist;
	
	private Boolean isdeductbeforebalance;
	private List<Balancestationdeduct> bsds;
	private BigDecimal additionfee;
	private BigDecimal agentfee;
	private BigDecimal agentrate;
	private BalanceService balanceService;
	private BigDecimal rentprice;
	private String savemode;
	
	
	/**
	 * 从redis中获取缓存
	 * @return
	 */
	public String checktempfromredis() {
		try {
			balanceService = new BalanceServiceImpl();
			Global global = CurrentUtil.getGlobal();
			setBalancedlist(balanceService.checktempfromredis(global));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	
	/**
	 * 结算单结算 单据保存redis
	 * 孙越 2017年9月21日 10:28:46
	 * @return
	 */
	public String savetoredis() {
		try {
			balanceService = new BalanceServiceImpl();
			MethodResult mr = balanceService.savetoredis(departinvoicesid, savemode);
			markSuccess();
			
		} catch (Exception e) {
			markFail();
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
		
	}
	
	
	/**
	 * 查询 包车金额
	 * @return
	 */
	public String qryBaoChePrice(){
		try {
			balanceService = new BalanceServiceImpl();
			setRentprice(balanceService.qryBaoChePrice(otherinvoicesids));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	public String createBalanceUnitTree() {
		try {
			balanceService = new BalanceServiceImpl();
			Global global = CurrentUtil.getGlobal();
			setUnitvehicletree(balanceService.createTree(global
					.getOrganization().getId()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	/**
	 * 结算单结算  查询ac打印所需信息
	 * 孙越 2016年4月12日 15:00:19
	 * 
	 * @return
	 */
	public String qrybalanceACPrintinfo(){
		try {
			balanceService = new BalanceServiceImpl();
			setBalancedlist(balanceService.qrybalanceACPrintinfo(balanceid));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String genBalanceData() {
		try {
			balanceService = new BalanceServiceImpl();
			Global global = CurrentUtil.getGlobal();
//			balanceService.genBalanceData(fromdepart, todepart, invoicesids,
//					global.getUserinfo().getId());
			balanceService.genBalanceData(fromdepart, todepart, invoicesids,
					global);
			markSuccess();
			setMsg("生成成功！");
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			markFail();
			setMsg("生成失败！");
		}
		return "json";
	}

	public String delBalanceData() {
		try {
			balanceService = new BalanceServiceImpl();
			// balanceService.delBalanceData(invoicesids);
			balanceService.delBalanceData(fromdepart, todepart, invoicesids);
			markSuccess();
			setMsg("删除成功！");
		} catch (ServiceException se) {
			markFail();
			setMsg(se.getMessage());
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			markFail();
			setMsg("删除失败！");
		}
		return "json";
	}
	
	public String saveagentfee() {
		try {
			balanceService = new BalanceServiceImpl();
			// balanceService.delBalanceData(invoicesids);
			if(balanceService.saveagentfee(departinvoicesid,deductmoney,balanceamount)){
			markSuccess();
			setMsg("修改成功！");
			}
			else{
				markFail();
				setMsg("修改失败！");	
			}
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			markFail();
			setMsg("修改失败！");
		}
		return "json";
	}

	public String qryDepartinvoices() {
		try {
			balanceService = new BalanceServiceImpl();
			setDepartinvoinceslist(balanceService.qryDepartinvoices(
					ServletPropertyFilterUtil.buildFromHttpRequest(), invoicesids,orgids,departinvoicestype));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	public String qryagentfee() {
		try {
			String formula = null;
			Departinvoices departinvoices = null;
			BalancedeductService balancedeductservise = new BalancedeductServiceImpl();
			setAgentfee(balancedeductservise.replaceFormula(formula,departinvoices));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	public String editDepartinvoices(){
		try {
			balanceService = new BalanceServiceImpl();
			Departinvoices departinvoices =  balanceService.editDepartinvoices(ticketsellid,departinvoicesid,fromstationid,reachstationid,tickettype,price);
		    setTicketnum(departinvoices.getTicketnum());
		    setAgentfee(departinvoices.getAgentfee());
		    setTotalamount(departinvoices.getTotalamount());
		    setBalanceamount(departinvoices.getBalanceamount());
		    setFueladditionfee(departinvoices.getFueladditionfee());
		    setStationservicefee(departinvoices.getStationservicefee());
		    setOthterfee(departinvoices.getOthterfee());
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String qryDepartinvoicesByNo() {
		try {
			balanceService = new BalanceServiceImpl();
			setDepartinvoinceslist(balanceService
					.qryDepartinvoicesByNo(departinvoicesno));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	// 根据结算单ID查询
	public String qryInvoicesdeductdetail() {
		try {
			balanceService = new BalanceServiceImpl();
			setInvoincesdeductlist(balanceService
					.qryInvoicesdeductdetail(departinvoincesid));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	// 根据IDS查询手动扣费项目
	public String qryInvoicesdeductdetails() {
		try {
			balanceService = new BalanceServiceImpl();
			setInvoincesdeductlist(balanceService
					.qryInvoicesdeductdetail(invoicesids));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	
	public String schedulelosttreatmentIds;
	// 实现结算过程
	public String invoicesBalance() {
		try {
			balanceService = new BalanceServiceImpl();
			Global global = CurrentUtil.getGlobal();
			Balance balace = balanceService.invoicesBalance(balance,balancetype,
					invoicesids, vehicleids, dds, global,otherinvoicesids, qryfromdate, qrytodate, schedulelosttreatmentIds);
			balanceid = balace.getId();
			balanceno = balance.getBalanceno();
			vehicleunitname  = balanceService.getVehicleUnitname(balanceunitid);
			markSuccess();
			setMsg("结算成功！");
		} catch (ServiceException se) {
			markFail();
			setMsg(se.getMessage());
		} catch (BusinessException se) {
			markFail();
			setMsg(se.getMessage());
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			markFail();
			setMsg("结算失败！");
		}
		return "json";
	}

	// 查询其他结算信息
	public String qryOtherBalance() {
		try {
			balanceService = new BalanceServiceImpl();
			Global global = CurrentUtil.getGlobal();
			obi = balanceService.qryOtherBalance(global.getOrganization()
					.getId(), fromdepart, todepart, vehicleids, balanceobject,
					objectid, invoicesids,global);
			markSuccess();
			setMsg("查询成功！");
			setMsg(obi.getSltId());
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			markFail();
			setMsg("系统异常！");
			e.printStackTrace();
		}
		return "json";
	}
	//20151109 liyi 新增四舍五入应节金额的转换方法
	public String qryRoundBalance()
	{
		try {
			balanceService = new BalanceServiceImpl();
			Global global = CurrentUtil.getGlobal();
			leaveBalanceresult =  balanceService.roundLeaveBalance(global.getOrganization()
					.getId(),leaveBalance);
			markSuccess();
			setMsg("查询成功！");
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			markFail();
			setMsg("系统异常！");
			e.printStackTrace();
		}
		
		return "json";
	}
	// 根据IDS查询其他固定扣费
	public String qryOtherDeduct() {
		try {
			balanceService = new BalanceServiceImpl();
			Global global = CurrentUtil.getGlobal();
			//otherdeductfee = balanceService.getOtherDeduct(invoicesids);
			additionfee = balanceService.qryAdditionFee(invoicesids,
					vehicleids, global.getOrganization().getId());
			//4013参数结算时是否重新计算客运代理费，0：不计算，1：重新计算
			ParameterServiceImpl parameterService = new ParameterServiceImpl();
			if (parameterService.findParamValue(ParamterConst.Param_4013, global.getOrganization().getId()).equals(ParamterConst.COMMON_FLAG.FALG_YES)){
				agentrate=new BigDecimal(0);
				agentfee=balanceService.calDepartinvoices(fromdepart, todepart, invoicesids,
						 global);
			}else{
				agentrate = balanceService.qryAgentrate(vehicleids, global.getOrganization().getId());
			}
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	// 查询结算扣费明细信息
	public String qryBalanceDeduct() {
		try {
			balanceService = new BalanceServiceImpl();
			setBalancedeductlist(balanceService.qryBalanceDeduct(balanceid,
					isdeductbeforebalance));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	// 打印时查询结算扣费明细信息
	public String qryBalanceDeductPrint() {
		try {
			balanceService = new BalanceServiceImpl();
			setBalancedeductlist(balanceService
					.qryBalanceDeductDetail(balanceid));			
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	// 查询结算扣费明细信息
	public String qryBalanceDeductDetail() {
		try {
			balanceService = new BalanceServiceImpl();
			setBalancedeductlist(balanceService.qryBalanceDeduct(balancetype,orgid,
					balanceunitid, invoicesids, vehicleids));
			markSuccess();
			setMsg("查询成功");
		} catch (Exception e) {
			markFailure();
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	/**
	 * 已结算查询 by hhz
	 * 
	 * @return
	 */
	public String queryBalanced() {
		try {
			balanceService = new BalanceServiceImpl();
			setBalancedlist(balanceService
					.queryBalanced(ServletPropertyFilterUtil
							.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	// 结算单注销过程
	public String cancelBalance() {
		try {
			balanceService = new BalanceServiceImpl();
			Global global = CurrentUtil.getGlobal();
			balanceService.cancelBalanceno(balanceid, global.getUserinfo()
					.getId(), ip);
			markSuccess();
			setMsg("注销成功！");
		} catch (ServiceException se) {
			markFail();
			setMsg(se.getMessage());
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			markFail();
			setMsg("注销失败！");
		}
		return "json";
	}

	/**
	 * 查询已结算单号
	 * 
	 * @return
	 */
	public String qryBalanceByNo() {
		try {
			balanceService = new BalanceServiceImpl();
			msg = balanceService.qryBalanceByNo(departinvoicesno);
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String qryAdditionFee() {
		try {
			balanceService = new BalanceServiceImpl();
			balancedeductlist = balanceService.qryAdditionFee(invoicesids,
					vehicleid, orgid,otherinvoicesids);
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String udpateAdditionFee() {
		try {
			balanceService = new BalanceServiceImpl();
			Global global = CurrentUtil.getGlobal();
			if (balanceService.updateAdditionFee(bsds, global.getUserinfo()
					.getId())) {
				markSuccess();
				setMsg("保存成功！");
			} else {
				markFail();
				setMsg("保存失败！");
			}
		} catch (Exception e) {
			markFail();
			setMsg("保存失败！");
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String recalDepartinvoices() {
		try {
			balanceService = new BalanceServiceImpl();
			Global global = CurrentUtil.getGlobal();
			balanceService.recalDepartinvoices(fromdepart, todepart,
					invoicesids,otherinvoicesids, global.getUserinfo().getId(),global);
			markSuccess();
			setMsg("执行成功！");
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			markFail();
			setMsg("执行失败！");
		}
		return "json";
	}

	public String additionFeeIsSame() {
		try {
			balanceService = new BalanceServiceImpl();
			Global global = CurrentUtil.getGlobal();
			if (balanceService.additionFeeIsSame(vehicleids, global
					.getOrganization().getId())) {
				markSuccess();
				setMsg("扣费相同！");
			} else {
				markFail();
				setMsg("扣费不同！");
			}
		} catch (Exception e) {
			markFail();
			setMsg("系统异常！");
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
//	qryvehicleno
	public String qryvehicleno() {
		balanceService =  new BalanceServiceImpl();
		setVehiclemap(balanceService.qryvehicleno(param,
				ServletPropertyFilterUtil.buildFromHttpRequest()));
		return "json";
	
	}
	public String qryRoutename() {
		try {
			balanceService = new BalanceServiceImpl();
			routename=balanceService.qryRoutename(vehicleno);
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			markFail();
			setMsg("执行失败！");
		}
		return "json";
	}
	
	public String qryVehicleBalanced() {
		try {
			balanceService = new BalanceServiceImpl();
			balancedlist=balanceService.qryVehicleBalanced(fromdepart, todepart, orgids,
					vehicleid,balanceunitid);
			markSuccess();
			setMsg("查询成功！");
		}catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			markFail();
			setMsg("查询失败！");
		}
		return "json";
	}

	// 结算月报表
	public String queryBalancedMonth() {
		try {
			balanceService = new BalanceServiceImpl();
			setBilancemoneylist(balanceService.qryBalancedMonth(fromdepart, todepart));
			markSuccess();
			setMsg("查询成功！");
		}catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			markFail();
			setMsg("查询失败！");
		}
		return "json";
	}
	
	// 查询单车企业运输费
	public String qryBalancedBusTransport() {
		try {
			balanceService = new BalanceServiceImpl();
			busTransportlist=balanceService.qryBalancedBusTransport(ServletPropertyFilterUtil
					.buildFromHttpRequest());
			markSuccess();
			setMsg("查询成功！");
		}catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			markFail();
			setMsg("查询失败！");
		}
		return "json";
	}
	
	/**
	 * 查看是否有路单结算插件
	 * 
	 * @return
	 */
	public String isHaveDepartinvoicePlugin() {
		Global global = CurrentUtil.getGlobal();
		try {
			balanceService = new BalanceServiceImpl();
			setHaveDepartinvoicelist(balanceService
					.isHaveDepartinvoicePlugin(global));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	private List<Map<String, Object>> deductfeelist;
	public String qryCleanfee(){
		balanceService = new BalanceServiceImpl();
		deductfeelist = balanceService.qryCleanfee(balanceid);
		return "json";
	}
	
	
	public List<Map<String, Object>> getDeductfeelist() {
		return deductfeelist;
	}

	public void setDeductfeelist(List<Map<String, Object>> deductfeelist) {
		this.deductfeelist = deductfeelist;
	}

	public List<Map<String, Object>> getBalancedlist() {
		return balancedlist;
	}

	public void setBalancedlist(List<Map<String, Object>> balancedlist) {
		this.balancedlist = balancedlist;
	}

	public List<Map<String, Object>> getUnitvehicletree() {
		return unitvehicletree;
	}

	public void setUnitvehicletree(List<Map<String, Object>> unitvehicletree) {
		this.unitvehicletree = unitvehicletree;
	}

	public Date getFromdepart() {
		return fromdepart;
	}

	public void setFromdepart(Date fromdepart) {
		this.fromdepart = fromdepart;
	}

	public Date getTodepart() {
		return todepart;
	}

	public void setTodepart(Date todepart) {
		this.todepart = todepart;
	}

	public long getDepartinvoincesid() {
		return departinvoincesid;
	}

	public void setDepartinvoincesid(long departinvoincesid) {
		this.departinvoincesid = departinvoincesid;
	}

	public List<Map<String, Object>> getInvoincesdeductlist() {
		return invoincesdeductlist;
	}

	public void setInvoincesdeductlist(
			List<Map<String, Object>> invoincesdeductlist) {
		this.invoincesdeductlist = invoincesdeductlist;
	}

	public List<Map<String, Object>> getDepartinvoinceslist() {
		return departinvoinceslist;
	}

	public void setDepartinvoinceslist(
			List<Map<String, Object>> departinvoinceslist) {
		this.departinvoinceslist = departinvoinceslist;
	}

	public String getInvoicesids() {
		return invoicesids;
	}

	public void setInvoicesids(String invoicesids) {
		this.invoicesids = invoicesids;
	}

	public OtherBalanceinfo getObi() {
		return obi;
	}

	public void setObi(OtherBalanceinfo obi) {
		this.obi = obi;
	}

	public String getVehicleids() {
		return vehicleids;
	}

	public void setVehicleids(String vehicleids) {
		this.vehicleids = vehicleids;
	}

	public String getBalanceobject() {
		return balanceobject;
	}

	public void setBalanceobject(String balanceobject) {
		this.balanceobject = balanceobject;
	}

	public long getObjectid() {
		return objectid;
	}

	public void setObjectid(long objectid) {
		this.objectid = objectid;
	}

	public List<Balancedeductdetail> getDds() {
		return dds;
	}

	public void setDds(List<Balancedeductdetail> dds) {
		this.dds = dds;
	}

	public BigDecimal getOtherdeductfee() {
		return otherdeductfee;
	}

	public void setOtherdeductfee(BigDecimal otherdeductfee) {
		this.otherdeductfee = otherdeductfee;
	}

	public Long getBalanceid() {
		return balanceid;
	}

	public void setBalanceid(Long balanceid) {
		this.balanceid = balanceid;
	}

	public Balance getBalance() {
		return balance;
	}

	public void setBalance(Balance balance) {
		this.balance = balance;
	}

	public List<Map<String, Object>> getBalancedeductlist() {
		return balancedeductlist;
	}

	public void setBalancedeductlist(List<Map<String, Object>> balancedeductlist) {
		this.balancedeductlist = balancedeductlist;
	}

	public String getBalanceno() {
		return balanceno;
	}

	public void setBalanceno(String balanceno) {
		this.balanceno = balanceno;
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

	public String getOrgids() {
		return orgids;
	}

	public void setOrgids(String orgids) {
		this.orgids = orgids;
	}

	public long getRouteid() {
		return routeid;
	}

	public void setRouteid(long routeid) {
		this.routeid = routeid;
	}

	public long getVehicleid() {
		return vehicleid;
	}

	public void setVehicleid(long vehicleid) {
		this.vehicleid = vehicleid;
	}

	public void setIsdeductbeforebalance(Boolean isdeductbeforebalance) {
		this.isdeductbeforebalance = isdeductbeforebalance;
	}

	public Boolean getIsdeductbeforebalance() {
		return isdeductbeforebalance;
	}

	public long getOrgid() {
		return orgid;
	}

	public void setOrgid(long orgid) {
		this.orgid = orgid;
	}

	public long getBalanceunitid() {
		return balanceunitid;
	}

	public void setBalanceunitid(long balanceunitid) {
		this.balanceunitid = balanceunitid;
	}

	public List<Balancestationdeduct> getBsds() {
		return bsds;
	}

	public void setBsds(List<Balancestationdeduct> bsds) {
		this.bsds = bsds;
	}

	public BigDecimal getAdditionfee() {
		return additionfee;
	}

	public void setAdditionfee(BigDecimal additionfee) {
		this.additionfee = additionfee;
	}

	public BigDecimal getAgentrate() {
		return agentrate;
	}

	public void setAgentrate(BigDecimal agentrate) {
		this.agentrate = agentrate;
	}

	public String getRoutename() {
		return routename;
	}

	public void setRoutename(String routename) {
		this.routename = routename;
	}

	public String getVehicleno() {
		return vehicleno;
	}

	public void setVehicleno(String vehicleno) {
		this.vehicleno = vehicleno;
	}

	public int getBalancetype() {
		return balancetype;
	}

	public void setBalancetype(int balancetype) {
		this.balancetype = balancetype;
	}

	public List<Map<String, Object>> getBusTransportlist() {
		return busTransportlist;
	}

	public void setBusTransportlist(List<Map<String, Object>> busTransportlist) {
		this.busTransportlist = busTransportlist;
	}

	public List<Map<String, Object>> getMaplist() {
		return maplist;
	}

	public void setMaplist(List<Map<String, Object>> maplist) {
		this.maplist = maplist;
	}

	public List<Map<String, Object>> getBilancemoneylist() {
		return bilancemoneylist;
	}

	public void setBilancemoneylist(List<Map<String, Object>> bilancemoneylist) {
		this.bilancemoneylist = bilancemoneylist;
	}
	public BigDecimal getAgentfee() {
		return agentfee;
	}

	public void setAgentfee(BigDecimal agentfee) {
		this.agentfee = agentfee;
	}

	public int getDepartinvoicestype() {
		return departinvoicestype;
	}

	public void setDepartinvoicestype(int departinvoicestype) {
		this.departinvoicestype = departinvoicestype;
	}

	public String getTicketsellid() {
		return ticketsellid;
	}

	public void setTicketsellid(String ticketsellid) {
		this.ticketsellid = ticketsellid;
	}

	public long getDepartinvoicesid() {
		return departinvoicesid;
	}

	public void setDepartinvoicesid(long departinvoicesid) {
		this.departinvoicesid = departinvoicesid;
	}

	public long getFromstationid() {
		return fromstationid;
	}

	public void setFromstationid(long fromstationid) {
		this.fromstationid = fromstationid;
	}

	public long getReachstationid() {
		return reachstationid;
	}

	public void setReachstationid(long reachstationid) {
		this.reachstationid = reachstationid;
	}

	public String getTickettype() {
		return tickettype;
	}

	public void setTickettype(String tickettype) {
		this.tickettype = tickettype;
	}

	public long getTicketnum() {
		return ticketnum;
	}

	public void setTicketnum(long ticketnum) {
		this.ticketnum = ticketnum;
	}

	public BigDecimal getFueladditionfee() {
		return fueladditionfee;
	}

	public void setFueladditionfee(BigDecimal fueladditionfee) {
		this.fueladditionfee = fueladditionfee;
	}

	public BigDecimal getStationservicefee() {
		return stationservicefee;
	}

	public void setStationservicefee(BigDecimal stationservicefee) {
		this.stationservicefee = stationservicefee;
	}

	public BigDecimal getTotalamount() {
		return totalamount;
	}

	public void setTotalamount(BigDecimal totalamount) {
		this.totalamount = totalamount;
	}

	public BigDecimal getOthterfee() {
		return othterfee;
	}

	public void setOthterfee(BigDecimal othterfee) {
		this.othterfee = othterfee;
	}

	public BigDecimal getBalanceamount() {
		return balanceamount;
	}

	public void setBalanceamount(BigDecimal balanceamount) {
		this.balanceamount = balanceamount;
	}

	public BigDecimal getPrice() {
		return price;
	}

	public void setPrice(BigDecimal price) {
		this.price = price;
	}

	public String getOtherinvoicesids() {
		return otherinvoicesids;
	}

	public void setOtherinvoicesids(String otherinvoicesids) {
		this.otherinvoicesids = otherinvoicesids;
	}

	public String getParam() {
		return param;
	}

	public void setParam(String param) {
		this.param = param;
	}

	public List<Map<String, Object>> getVehiclemap() {
		return vehiclemap;
	}

	public void setVehiclemap(List<Map<String, Object>> vehiclemap) {
		this.vehiclemap = vehiclemap;
	}

	public List<Map<String, Object>> getHaveDepartinvoicelist() {
		return haveDepartinvoicelist;
	}

	public void setHaveDepartinvoicelist(
			List<Map<String, Object>> haveDepartinvoicelist) {
		this.haveDepartinvoicelist = haveDepartinvoicelist;
	}

	public String getDeductmoney() {
		return deductmoney;
	}

	public void setDeductmoney(String deductmoney) {
		this.deductmoney = deductmoney;
	}

	public Date getQryfromdate() {
		return qryfromdate;
	}

	public void setQryfromdate(Date qryfromdate) {
		this.qryfromdate = qryfromdate;
	}

	public Date getQrytodate() {
		return qrytodate;
	}

	public void setQrytodate(Date qrytodate) {
		this.qrytodate = qrytodate;
	}

	public String getVehicleunitname() {
		return vehicleunitname;
	}

	public void setVehicleunitname(String vehicleunitname) {
		this.vehicleunitname = vehicleunitname;
	}

	public BigDecimal getRentprice() {
		return rentprice;
	}

	public void setRentprice(BigDecimal rentprice) {
		this.rentprice = rentprice;
	}

	public String getSavemode() {
		return savemode;
	}

	public void setSavemode(String savemode) {
		this.savemode = savemode;
	}

	public String getSchedulelosttreatmentIds() {
		return schedulelosttreatmentIds;
	}

	public void setSchedulelosttreatmentIds(String schedulelosttreatmentIds) {
		this.schedulelosttreatmentIds = schedulelosttreatmentIds;
	}
	
	
}
