package cn.nova.bus.query.action;

import cn.nova.bus.action.BaseAction;

import java.util.Date;
import java.util.List;
import java.util.Map;

import util.CurrentUtil;
import cn.nova.bus.query.param.Qryparam;
import cn.nova.bus.query.service.TicketSellQryService;
import cn.nova.bus.query.service.impl.TicketSellQryServiceImpl;
import cn.nova.bus.security.Global;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.web.ServletPropertyFilterUtil;

/**
 * 售票查询 包括（ 售票情况查询，异站售本站票查询，本站售异站票查询，预售票查询 改签查询，留票查询，废票查询）
 * 
 * @author hhz
 * 
 */
public class TicketSellQryAction extends BaseAction{

	TicketSellQryService ticketsellService;
	// 返回结果
	private List<Map<String, Object>> ticketSellQrymap;
	private List<Map<String, Object>> sellLocaltickemap;
	private List<Map<String, Object>> sellOthertickemap;
	private List<Map<String, Object>> presellticketmap;
	private List<Map<String, Object>> ticketchangemap;
	private List<Map<String, Object>> reserveTicketmap;
	private List<Map<String, Object>> ticketReturnmap;
	private List<Map<String, Object>> billdamagedmap;
	private List<Map<String, Object>> resultmap;
	private List<Map<String, Object>> tickedetailmap;
	private List<Map<String, Object>> remoteticketsellmap;
	private List<Map<String, Object>> taketicketlogmap;
	private List<Map<String, Object>> changecancelticketmap;
	private String scheduleorgid;
	private String schedulecode;
	private Integer islocalticket;
	private Integer ischecked;
	private Integer isovertime;
	private String showfullidno;
	private Long routeid;
	private Qryparam qp;
	public Qryparam getQp() {
		return qp;
	}

	public void setQp(Qryparam qp) {
		this.qp = qp;
	}
	private String operatorgname;
	private String sellticketorgid;
	private String ticketoutletsid;
	private Date dtpstartdate;
	private Date dtpenddate;
	private String sign;
	private long customerid;
	private String certificateno;
	private String customername;
	private Date birthday;
	private String sex;
	private String ticketno;
	
	
	public String saveCustomerinfo(){
		try {
			ticketsellService = new TicketSellQryServiceImpl();
			boolean b = ticketsellService.saveCustomerinfo(certificateno,customerid,customername,birthday,sex,ticketno);
			markSuccess();
			setMsg("修改乘车人信息成功!");
		} catch (Exception e) {
			markFail();
			setMsg(e.getMessage());
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	/**
	 * 换票废票查询
	 * @return
	 */
	public String queryChangeCancelTicket(){
		List<PropertyFilter> propertyFilterList = ServletPropertyFilterUtil
				.buildFromHttpRequest();
		ticketsellService = new TicketSellQryServiceImpl();
		setChangecancelticketmap(ticketsellService.queryChangeCancelTicket(propertyFilterList,sign,dtpstartdate,dtpenddate));
		return "json";
	}
	
	/**
	 * 取票日志查询
	 * @return
	 */
	public String qryTakeTicketLog(){
		try {
			ticketsellService = new TicketSellQryServiceImpl();
			setTaketicketlogmap(ticketsellService.qryTaketicketlog(operatorgname,sellticketorgid,
					ticketoutletsid,dtpstartdate,dtpenddate));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	/**
	 * 售票情况查询，
	 * 
	 * @return
	 */
	public String findticketSellQry() {
		try {
			Global global = CurrentUtil.getGlobal();
			ticketsellService = new TicketSellQryServiceImpl();
			setTicketSellQrymap(ticketsellService.query(qp,global));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	/**
	 * 预售票查询
	 * 
	 * @return
	 */
	public String findPresellTicketQry() {
		try {
			List<PropertyFilter> propertyFilterList = ServletPropertyFilterUtil
					.buildFromHttpRequest();
			ticketsellService = new TicketSellQryServiceImpl();
			setPresellticketmap(ticketsellService
					.queryPersell(propertyFilterList));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	/**
	 * 改签查询
	 * 
	 * @return
	 */
	public String findTicketChangeQry() {
		try {
			List<PropertyFilter> propertyFilterList = ServletPropertyFilterUtil
					.buildFromHttpRequest();
			ticketsellService = new TicketSellQryServiceImpl();
			setTicketchangemap(ticketsellService
					.queryTicketchange(propertyFilterList));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	/**
	 * 留票查询
	 * 
	 * @return
	 */
	public String findReserveTicketQry() {
		try {
			List<PropertyFilter> propertyFilterList = ServletPropertyFilterUtil
					.buildFromHttpRequest();
			ticketsellService = new TicketSellQryServiceImpl();
			setReserveTicketmap(ticketsellService
					.queryReserveTicket(propertyFilterList));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	/**
	 * 退票查询
	 * 
	 * @return
	 */
	public String findTicketreturntQry() {
		try {
			List<PropertyFilter> propertyFilterList = ServletPropertyFilterUtil
					.buildFromHttpRequest();
			ticketsellService = new TicketSellQryServiceImpl();
			setTicketReturnmap(ticketsellService
					.queryTicketreturn(propertyFilterList,schedulecode,routeid,qp));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	/**
	 * 废票查询
	 * 
	 * @return
	 */
	public String findTicketCancelQry() {
		try {
			List<PropertyFilter> propertyFilterList = ServletPropertyFilterUtil
					.buildFromHttpRequest();
			ticketsellService = new TicketSellQryServiceImpl();
			setTicketReturnmap(ticketsellService
					.queryTickeCancle(propertyFilterList));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	/**
	 * 坏票登记情况查询
	 * 
	 * @return
	 */
	public String queryBilldamaged() {
		try {
			List<PropertyFilter> propertyFilterList = ServletPropertyFilterUtil
					.buildFromHttpRequest();
			ticketsellService = new TicketSellQryServiceImpl();
			setBilldamagedmap(ticketsellService
					.queryBilldamaged(propertyFilterList));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	/**
	 * 异站退本站票查询
	 * 
	 * @return
	 */
	public String findReturntLocal() {
		try {
			List<PropertyFilter> propertyFilterList = ServletPropertyFilterUtil
					.buildFromHttpRequest();
			ticketsellService = new TicketSellQryServiceImpl();
			setTicketReturnmap(ticketsellService
					.queryReturnLocal(propertyFilterList));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	/**
	 * 分布式、集中式异站售本站票查询
	 * 
	 * @return
	 */
	public String queryFocusSellLocakQry() {
		Global global = CurrentUtil.getGlobal();
		try {
			List<PropertyFilter> propertyFilterList = ServletPropertyFilterUtil
					.buildFromHttpRequest();
			ticketsellService = new TicketSellQryServiceImpl();
			setResultmap(ticketsellService
					.queryFocusSaleLocal(propertyFilterList,global,qp));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	/**
	 * 分布式、集中式本站售异站票查询
	 * 
	 * @return
	 */
	public String queryFocusSellOtherQry() {
		Global global = CurrentUtil.getGlobal();
		try {
			List<PropertyFilter> propertyFilterList = ServletPropertyFilterUtil
					.buildFromHttpRequest();
			ticketsellService = new TicketSellQryServiceImpl();
			setResultmap(ticketsellService.queryFocusSaleOther(
					propertyFilterList, scheduleorgid, global.getOrganization().getId()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	/**
	 * 电子票明细查询
	 * 
	 * @return
	 */
	public String queryTicketDetail() {
		try {
			ticketsellService = new TicketSellQryServiceImpl();
			setTickedetailmap(ticketsellService.queryTicketDetail(qp));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	/**
	 * 远程检票数据查询
	 * 
	 * @return
	 */
	public String queryrRemoteticketsell() {
		try {
			ticketsellService = new TicketSellQryServiceImpl();
			setRemoteticketsellmap(ticketsellService.queryrRemoteticketsell(ServletPropertyFilterUtil
					.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	public List<Map<String, Object>> getTicketSellQrymap() {
		return ticketSellQrymap;
	}

	public void setTicketSellQrymap(List<Map<String, Object>> ticketSellQrymap) {
		this.ticketSellQrymap = ticketSellQrymap;
	}

	public List<Map<String, Object>> getSellLocaltickemap() {
		return sellLocaltickemap;
	}

	public void setSellLocaltickemap(List<Map<String, Object>> sellLocaltickemap) {
		this.sellLocaltickemap = sellLocaltickemap;
	}

	public List<Map<String, Object>> getSellOthertickemap() {
		return sellOthertickemap;
	}

	public void setSellOthertickemap(List<Map<String, Object>> sellOthertickemap) {
		this.sellOthertickemap = sellOthertickemap;
	}

	public List<Map<String, Object>> getPresellticketmap() {
		return presellticketmap;
	}

	public void setPresellticketmap(List<Map<String, Object>> presellticketmap) {
		this.presellticketmap = presellticketmap;
	}

	public List<Map<String, Object>> getTicketchangemap() {
		return ticketchangemap;
	}

	public void setTicketchangemap(List<Map<String, Object>> ticketchangemap) {
		this.ticketchangemap = ticketchangemap;
	}

	public List<Map<String, Object>> getReserveTicketmap() {
		return reserveTicketmap;
	}

	public void setReserveTicketmap(List<Map<String, Object>> reserveTicketmap) {
		this.reserveTicketmap = reserveTicketmap;
	}

	public List<Map<String, Object>> getTicketReturnmap() {
		return ticketReturnmap;
	}

	public void setTicketReturnmap(List<Map<String, Object>> ticketReturnmap) {
		this.ticketReturnmap = ticketReturnmap;
	}

	public List<Map<String, Object>> getBilldamagedmap() {
		return billdamagedmap;
	}

	public void setBilldamagedmap(List<Map<String, Object>> billdamagedmap) {
		this.billdamagedmap = billdamagedmap;
	}

	public List<Map<String, Object>> getResultmap() {
		return resultmap;
	}

	public void setResultmap(List<Map<String, Object>> resultmap) {
		this.resultmap = resultmap;
	}

	public String getScheduleorgid() {
		return scheduleorgid;
	}

	public void setScheduleorgid(String scheduleorgid) {
		this.scheduleorgid = scheduleorgid;
	}

	public String getSchedulecode() {
		return schedulecode;
	}

	public void setSchedulecode(String schedulecode) {
		this.schedulecode = schedulecode;
	}

	public Integer getIslocalticket() {
		return islocalticket;
	}

	public void setIslocalticket(Integer islocalticket) {
		this.islocalticket = islocalticket;
	}

	public Integer getIsovertime() {
		return isovertime;
	}

	public Integer getIschecked() {
		return ischecked;
	}

	public void setIschecked(Integer ischecked) {
		this.ischecked = ischecked;
	}

	public void setIsovertime(Integer isovertime) {
		this.isovertime = isovertime;
	}

	public Long getRouteid() {
		return routeid;
	}

	public void setRouteid(Long routeid) {
		this.routeid = routeid;
	}

	public List<Map<String, Object>> getTickedetailmap() {
		return tickedetailmap;
	}

	public void setTickedetailmap(List<Map<String, Object>> tickedetailmap) {
		this.tickedetailmap = tickedetailmap;
	}

	public List<Map<String, Object>> getRemoteticketsellmap() {
		return remoteticketsellmap;
	}

	public void setRemoteticketsellmap(List<Map<String, Object>> remoteticketsellmap) {
		this.remoteticketsellmap = remoteticketsellmap;
	}

	public List<Map<String, Object>> getTaketicketlogmap() {
		return taketicketlogmap;
	}

	public void setTaketicketlogmap(List<Map<String, Object>> taketicketlogmap) {
		this.taketicketlogmap = taketicketlogmap;
	}

	public String getSellticketorgid() {
		return sellticketorgid;
	}

	public void setSellticketorgid(String sellticketorgid) {
		this.sellticketorgid = sellticketorgid;
	}

	public Date getDtpstartdate() {
		return dtpstartdate;
	}

	public void setDtpstartdate(Date dtpstartdate) {
		this.dtpstartdate = dtpstartdate;
	}

	public Date getDtpenddate() {
		return dtpenddate;
	}

	public void setDtpenddate(Date dtpenddate) {
		this.dtpenddate = dtpenddate;
	}

	public String getTicketoutletsid() {
		return ticketoutletsid;
	}

	public void setTicketoutletsid(String ticketoutletsid) {
		this.ticketoutletsid = ticketoutletsid;
	}

	public String getOperatorgname() {
		return operatorgname;
	}

	public void setOperatorgname(String operatorgname) {
		this.operatorgname = operatorgname;
	}

	public List<Map<String, Object>> getChangecancelticketmap() {
		return changecancelticketmap;
	}

	public void setChangecancelticketmap(List<Map<String, Object>> changecancelticketmap) {
		this.changecancelticketmap = changecancelticketmap;
	}

	public String getSign() {
		return sign;
	}

	public void setSign(String sign) {
		this.sign = sign;
	}

	public String getShowfullidno() {
		return showfullidno;
	}

	public void setShowfullidno(String showfullidno) {
		this.showfullidno = showfullidno;
	}

	
}
