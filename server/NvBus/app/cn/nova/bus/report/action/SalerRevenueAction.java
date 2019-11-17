package cn.nova.bus.report.action;

import cn.nova.bus.action.BaseAction;
import java.util.Date;
import java.util.List;
import java.util.Map;

import util.CurrentUtil;
import cn.nova.bus.report.param.Reportparam;
import cn.nova.bus.report.service.SalerRevenueService;
import cn.nova.bus.report.service.impl.SalerRevenueServiceImpl;
import cn.nova.bus.security.Global;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.web.ServletPropertyFilterUtil;

public class SalerRevenueAction extends BaseAction{
	SalerRevenueService salerRevenueService;
	// 返回结果
	private List<Map<String, Object>> resultmap;

	private String orgids;
	private String saleorgids;
	private Long seller;
	private String printorgids;
	private Date startdate;
	private Date enddate;
	private long orgid;
	private int type;
	private Date month;
	private Boolean isSellLocal;// 是否本站售本站票	
	private Boolean isovertime;//是否加班
	private String schedulestatus;
	private Boolean issellgroup;//是否按售票员分组
	private Boolean isstationgroup;//是否按停靠站点分组
	private Boolean isroutegroup;//是否按线路分组
	private String sellerids; 
	private String ticketoutletid;
	private Date departstartdate;
	private Date departenddate;
	private long sellerid;
	private Date olddepartSdate;
	private Date olddepartEdate;
	private Boolean isolddate;
	private String paymethod;
	private Boolean isgroupbyday;
	private Reportparam rp;
	private String besaleorgids;
	
	private String datetype;
	public String getDatetype() {
		return datetype;
	}

	public void setDatetype(String datetype) {
		this.datetype = datetype;
	}

	/**
	 * 售票员结算单查询
	 * @return
	 */
	public String qrysellerdepartinvoices(){
		try {
			salerRevenueService = new SalerRevenueServiceImpl();
			resultmap = salerRevenueService.qrysellerdepartinvoices(sellerid,orgids,departstartdate,departenddate);
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	/**
	 * 查询本数据库所有机构
	 * 
	 * @return
	 */
	public String queryLocalOrg() {
		Global global = CurrentUtil.getGlobal();
		try {
			salerRevenueService = new SalerRevenueServiceImpl();
			resultmap = salerRevenueService.queryLocalOrg(global.getOrgIDs());
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	/**
	 * 查询异站机构
	 * 
	 * @return
	 */
	public String querySyncOrg() {
		try {
			salerRevenueService = new SalerRevenueServiceImpl();
			resultmap = salerRevenueService.querySyncOrg(orgid);
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	//售票情况报表中的统计方式；按售票日期，售票员统计
	private boolean isbyseller;
	private boolean isbyselldate;
	/**
	 * 售票员售票情况日报表
	 * 
	 * @return
	 */
	public String querySalerdayRevenue() {
		try {
			salerRevenueService = new SalerRevenueServiceImpl();
			resultmap = salerRevenueService.querySalerdayRevenue(orgids,
					startdate, enddate,isbyseller,isbyselldate,sellerids,ticketoutletid,paymethod);
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	/**
	 * 本站售异站汇总表
	 * 
	 * @return
	 */
	public String querySalerSyncOrgRevenue() {
		Global global = CurrentUtil.getGlobal();
		try {
			salerRevenueService = new SalerRevenueServiceImpl();
			resultmap = salerRevenueService.querySalerSyncOrgRevenue(orgids,
					startdate, enddate, orgid,datetype,global.getOrganization().getId(),isgroupbyday,besaleorgids);
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	/**
	 * 异站售本站汇总表
	 * 
	 * @return
	 */
	public String querySyncSaleLocal() {
		Global global = CurrentUtil.getGlobal();
		try {
			salerRevenueService = new SalerRevenueServiceImpl();
			resultmap = salerRevenueService.querySyncSaleLocal(saleorgids,
					startdate, enddate, orgids,datetype,global.getOrganization().getId(),isolddate,isgroupbyday);
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			e.printStackTrace();
		}
		return "json";
	}

	/**
	 * 客运站划拨明细表
	 * 
	 * @return
	 */
	public String queryInvoincesDetail() {
		try {
			List<PropertyFilter> propertyFilterList = ServletPropertyFilterUtil
					.buildFromHttpRequest();

			salerRevenueService = new SalerRevenueServiceImpl();
			resultmap = salerRevenueService.queryInvoincesDetail(orgids,
					propertyFilterList);
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	/**
	 * 各分公司划拨汇总表
	 * 
	 * @param
	 * @return
	 */
	public String queryBalanceUnitInvoinces() {
		try {
			List<PropertyFilter> propertyFilterList = ServletPropertyFilterUtil
					.buildFromHttpRequest();
			salerRevenueService = new SalerRevenueServiceImpl();
			resultmap = salerRevenueService.queryBalanceUnitInvoinces(orgids,
					type, propertyFilterList);
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	/**
	 * 客运站结算汇总表
	 * 
	 * @param
	 * @return
	 */
	public String queryStationBalanceInvoinces() {
		try {
			salerRevenueService = new SalerRevenueServiceImpl();
			resultmap = salerRevenueService.queryStationBalanceInvoinces(rp);
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	/**
	 * 长途站预售票查询情况表（跨月汇总）
	 * 
	 * @param Date
	 *            month
	 * @return
	 */
	public String queryPresellMonthRevenue() {
		try {
			salerRevenueService = new SalerRevenueServiceImpl();
			resultmap = salerRevenueService.queryPresellMonthRevenue(orgids,
					month, isSellLocal);
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	/**
	 * 车辆划拨汇总表
	 * 
	 * @param
	 * @return
	 */
	public String queryVehicleIncome() {
		try {
			List<PropertyFilter> propertyFilterList = ServletPropertyFilterUtil
					.buildFromHttpRequest();
			salerRevenueService = new SalerRevenueServiceImpl();
			resultmap = salerRevenueService.queryVehicleIncome(orgids,
					startdate, enddate, propertyFilterList, printorgids);
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	/**
	 * 客运每日班次营收汇总
	 * 
	 * @param
	 * @return
	 */
	public String queryDayScheduleIncome() {
		try {
			salerRevenueService = new SalerRevenueServiceImpl();
			resultmap = salerRevenueService.queryDayScheduleIncome(orgids,
					startdate, enddate,isovertime,schedulestatus);
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	/**
	 * 售票每日营收统计表
	 * 
	 * @return
	 */
	public String queryDayIncome() {
		try {
			salerRevenueService = new SalerRevenueServiceImpl();
			resultmap = salerRevenueService.queryDayIncome(orgids,
					startdate, enddate,seller);
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	public List<Map<String, Object>> getResultmap() {
		return resultmap;
	}

	public void setResultmap(List<Map<String, Object>> resultmap) {
		this.resultmap = resultmap;
	}

	public String getOrgids() {
		return orgids;
	}

	public void setOrgids(String orgids) {
		this.orgids = orgids;
	}

	public Date getStartdate() {
		return startdate;
	}

	public void setStartdate(Date startdate) {
		this.startdate = startdate;
	}

	public Date getEnddate() {
		return enddate;
	}

	public void setEnddate(Date enddate) {
		this.enddate = enddate;
	}

	public long getOrgid() {
		return orgid;
	}

	public void setOrgid(long orgid) {
		this.orgid = orgid;
	}

	public Date getMonth() {
		return month;
	}

	public void setMonth(Date month) {
		this.month = month;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public Boolean getIsSellLocal() {
		return isSellLocal;
	}

	public void setIsSellLocal(Boolean isSellLocal) {
		this.isSellLocal = isSellLocal;
	}

	public String getSaleorgids() {
		return saleorgids;
	}

	public void setSaleorgids(String saleorgids) {
		this.saleorgids = saleorgids;
	}

	public String getPrintorgids() {
		return printorgids;
	}

	public void setPrintorgids(String printorgids) {
		this.printorgids = printorgids;
	}

	public Long getSeller() {
		return seller;
	}

	public void setSeller(Long seller) {
		this.seller = seller;
	}

	public Boolean getIsovertime() {
		return isovertime;
	}

	public void setIsovertime(Boolean isovertime) {
		this.isovertime = isovertime;
	}

	public String getSchedulestatus() {
		return schedulestatus;
	}

	public void setSchedulestatus(String schedulestatus) {
		this.schedulestatus = schedulestatus;
	}

	public boolean isIsbyseller() {
		return isbyseller;
	}

	public void setIsbyseller(boolean isbyseller) {
		this.isbyseller = isbyseller;
	}

	public boolean isIsbyselldate() {
		return isbyselldate;
	}

	public void setIsbyselldate(boolean isbyselldate) {
		this.isbyselldate = isbyselldate;
	}

	public Boolean getIssellgroup() {
		return issellgroup;
	}

	public void setIssellgroup(Boolean issellgroup) {
		this.issellgroup = issellgroup;
	}

	public Boolean getIsstationgroup() {
		return isstationgroup;
	}

	public void setIsstationgroup(Boolean isstationgroup) {
		this.isstationgroup = isstationgroup;
	}

	public Boolean getIsroutegroup() {
		return isroutegroup;
	}

	public void setIsroutegroup(Boolean isroutegroup) {
		this.isroutegroup = isroutegroup;
	}
	public Reportparam getRp() {
		return rp;
	}

	public void setRp(Reportparam rp) {
		this.rp = rp;
	}

	public String getSellerids() {
		return sellerids;
	}

	public void setSellerids(String sellerids) {
		this.sellerids = sellerids;
	}

	public String getTicketoutletid() {
		return ticketoutletid;
	}

	public void setTicketoutletid(String ticketoutletid) {
		this.ticketoutletid = ticketoutletid;
	}

	public Date getDepartstartdate() {
		return departstartdate;
	}

	public void setDepartstartdate(Date departstartdate) {
		this.departstartdate = departstartdate;
	}

	public Date getDepartenddate() {
		return departenddate;
	}

	public void setDepartenddate(Date departenddate) {
		this.departenddate = departenddate;
	}

	public long getSellerid() {
		return sellerid;
	}

	public void setSellerid(long sellerid) {
		this.sellerid = sellerid;
	}

	public Date getOlddepartSdate() {
		return olddepartSdate;
	}

	public void setOlddepartSdate(Date olddepartSdate) {
		this.olddepartSdate = olddepartSdate;
	}

	public Date getOlddepartEdate() {
		return olddepartEdate;
	}

	public void setOlddepartEdate(Date olddepartEdate) {
		this.olddepartEdate = olddepartEdate;
	}

	public Boolean getIsolddate() {
		return isolddate;
	}

	public void setIsolddate(Boolean isolddate) {
		this.isolddate = isolddate;
	}

	public String getPaymethod() {
		return paymethod;
	}

	public void setPaymethod(String paymethod) {
		this.paymethod = paymethod;
	}

	public Boolean getIsgroupbyday() {
		return isgroupbyday;
	}

	public void setIsgroupbyday(Boolean isgroupbyday) {
		this.isgroupbyday = isgroupbyday;
	}

	public String getBesaleorgids() {
		return besaleorgids;
	}

	public void setBesaleorgids(String besaleorgids) {
		this.besaleorgids = besaleorgids;
	}
	
	
}
