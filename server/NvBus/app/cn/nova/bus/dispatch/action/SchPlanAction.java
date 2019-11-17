package cn.nova.bus.dispatch.action;

import cn.nova.bus.action.BaseAction;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.Map;

import util.CurrentUtil;
import util.NvException;
import cn.nova.bus.dispatch.service.SchPlanService;
import cn.nova.bus.dispatch.service.impl.SchPlanServiceImpl;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.price.model.Schedulestatus;
import cn.nova.bus.price.model.Ticketprice;
import cn.nova.bus.security.Global;

public class SchPlanAction extends BaseAction{
	private List<Map<String, Object>> pricemap;
	private List<Ticketprice> ticketprices;// 批量调票价
	private List<Schedulestatus> sslist;// 批量发车时间
	private Date fromdate;
	private Date enddate;
	private long scheduleplanid;
	private long departstationid;
	private long reachstationid;
	private String departstationids;
	private List<Map<String, Object>> datamap;
	private String scheduleids;
	private Date departdate;

	private Schedulestatus schedulestatus;
	private long routeid;
	private BigDecimal fullprice;
	private int distance;
	private boolean iscopytostation;
	private BigDecimal halfprice;
	private BigDecimal studentprice;
	private BigDecimal moreprice;
	private String worktype;	
	private BigDecimal topprice;	
	private String workways;
	private String remark;	
	private boolean isworkline;
	private String childnum;

	SchPlanService schPlanService;
	
	
	/**
	 * 根据班次计划ID查询携童数
	 * @return
	 */
	public String qryChildNum(){
		try {
			schPlanService = new SchPlanServiceImpl();
			pricemap = schPlanService.qryChildNum(scheduleplanid);
		} catch (Exception e) {
			System.out.println(e.getMessage());
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	// 查询班次的票价
	public String qryticketprices() {
		try {
			schPlanService = new SchPlanServiceImpl();
			pricemap = schPlanService.qryTicketprice(scheduleplanid);
		} catch (Exception e) {
			System.out.println(e.getMessage());
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String batchstopstation() {// 批量调整停靠点
		Global global = CurrentUtil.getGlobal();
		try {
			schPlanService = new SchPlanServiceImpl();
			schPlanService.batchsaveticketprice(scheduleids,iscopytostation, ticketprices,
					fromdate, enddate, global.getUserinfo().getId(),
					global.getIpAddress());
			ticketprices=null;
			msg = "保存成功！";
			markSuccess();
		} catch (ServiceException ex) {
			setMsg(ex.getMessage());
			markFail();
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			msg = "保存失败！";
			markFail();
		}

		return "json";
	}

	// 查询同线路的班次
	public String qrySameRouteSch() {
		try {
			schPlanService = new SchPlanServiceImpl();
			datamap = schPlanService.qrySameRouteSch(departdate, routeid,
					departstationid,scheduleplanid);
		} catch (Exception e) {
			System.out.println(e.getMessage());
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	// 批量检票口、上车位、发车时间
	public String updateScheduleplan() {
		Global global = CurrentUtil.getGlobal();
		try {
			StringBuffer resultInfo = new StringBuffer();//修改营运类别返回信息
			schPlanService = new SchPlanServiceImpl();
			boolean bresult = schPlanService.updateScheduleplan(fromdate, enddate, schedulestatus,
					scheduleids, global.getIpAddress(),workways,remark,worktype,isworkline,childnum, resultInfo);
			if(bresult){
				msg = "保存成功！" + "\n" + resultInfo.toString();
				markSuccess();
			}else{
				msg = "保存失败！剩余携童数不够!";
				markFail();
			}
		}catch(NvException e){
			setMsg(e.getNvMsg());
			markFail();			
		}catch (ServiceException ex) {
			setMsg(ex.getMessage());
			markFail();
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			msg = "保存失败！";
			markFail();
		}

		return "json";
	}
	
	// 查询站点票价
	public String qryStationprice() {
		try {
			schPlanService = new SchPlanServiceImpl();
			datamap = schPlanService.qryStationprice(departstationid,
					reachstationid);
		} catch (Exception e) {
			System.out.println(e.getMessage());
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	private BigDecimal discountprice;
	private BigDecimal roundprice;  
	private BigDecimal connectprice; 
	// 添加停靠点票价
	public String addStationprice() {
		Global global = CurrentUtil.getGlobal();
		try {
			schPlanService = new SchPlanServiceImpl();
			schPlanService.addStationprice(scheduleplanid, departstationids, reachstationid,
					fullprice, halfprice,studentprice,moreprice,topprice,distance,
					global,discountprice,roundprice,connectprice);
			msg = "保存成功！";
			markSuccess();
		} catch (ServiceException ex) {
			setMsg(ex.getMessage());
			markFail();
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			msg = "保存失败！";
			markFail();
		}

		return "json";
	}
	// 查询配客站点的发车时间
	public String qryDepartTime() {
		try {
			schPlanService = new SchPlanServiceImpl();
			datamap = schPlanService.qryDepartTime(scheduleplanid,departstationid,
					fromdate);
		} catch (Exception e) {
			System.out.println(e.getMessage());
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	// 批量保存配客站点的发车时间
	public String saveDepartTimes() {
		Global global = CurrentUtil.getGlobal();
		try {
			schPlanService = new SchPlanServiceImpl();
			schPlanService.saveDepartTimes(fromdate, enddate,departstationid,sslist,global);
			msg = "保存成功！";
			markSuccess();
		} catch (ServiceException ex) {
			setMsg(ex.getMessage());
			markFail();
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			msg = "保存失败！";
			markFail();
		}

		return "json";
	}
	
	public List<Map<String, Object>> getPricemap() {
		return pricemap;
	}

	public void setPricemap(List<Map<String, Object>> pricemap) {
		this.pricemap = pricemap;
	}

	public List<Ticketprice> getTicketprices() {
		return ticketprices;
	}

	public void setTicketprices(List<Ticketprice> ticketprices) {
		this.ticketprices = ticketprices;
	}

	public Date getFromdate() {
		return fromdate;
	}

	public void setFromdate(Date fromdate) {
		this.fromdate = fromdate;
	}

	public Date getEnddate() {
		return enddate;
	}

	public void setEnddate(Date enddate) {
		this.enddate = enddate;
	}

	public long getScheduleplanid() {
		return scheduleplanid;
	}

	public void setScheduleplanid(long scheduleplanid) {
		this.scheduleplanid = scheduleplanid;
	}

	public String getScheduleids() {
		return scheduleids;
	}

	public void setScheduleids(String scheduleids) {
		this.scheduleids = scheduleids;
	}

	public long getDepartstationid() {
		return departstationid;
	}

	public void setDepartstationid(long departstationid) {
		this.departstationid = departstationid;
	}

	public List<Map<String, Object>> getDatamap() {
		return datamap;
	}

	public void setDatamap(List<Map<String, Object>> datamap) {
		this.datamap = datamap;
	}

	public Date getDepartdate() {
		return departdate;
	}

	public void setDepartdate(Date departdate) {
		this.departdate = departdate;
	}

	public long getRouteid() {
		return routeid;
	}

	public void setRouteid(long routeid) {
		this.routeid = routeid;
	}

	public Schedulestatus getSchedulestatus() {
		return schedulestatus;
	}

	public void setSchedulestatus(Schedulestatus schedulestatus) {
		this.schedulestatus = schedulestatus;
	}
	public long getReachstationid() {
		return reachstationid;
	}

	public void setReachstationid(long reachstationid) {
		this.reachstationid = reachstationid;
	}
	public String getDepartstationids() {
		return departstationids;
	}

	public void setDepartstationids(String departstationids) {
		this.departstationids = departstationids;
	}

	public BigDecimal getFullprice() {
		return fullprice;
	}

	public void setFullprice(BigDecimal fullprice) {
		this.fullprice = fullprice;
	}

	public BigDecimal getHalfprice() {
		return halfprice;
	}

	public void setHalfprice(BigDecimal halfprice) {
		this.halfprice = halfprice;
	}

	public BigDecimal getStudentprice() {
		return studentprice;
	}

	public void setStudentprice(BigDecimal studentprice) {
		this.studentprice = studentprice;
	}

	public BigDecimal getMoreprice() {
		return moreprice;
	}

	public void setMoreprice(BigDecimal moreprice) {
		this.moreprice = moreprice;
	}

	public BigDecimal getTopprice() {
		return topprice;
	}

	public void setTopprice(BigDecimal topprice) {
		this.topprice = topprice;
	}	

	public int getDistance() {
		return distance;
	}

	public void setDistance(int distance) {
		this.distance = distance;
	}
	public boolean isIscopytostation() {
		return iscopytostation;
	}

	public void setIscopytostation(boolean iscopytostation) {
		this.iscopytostation = iscopytostation;
	}	
	public String getWorkways() {
		return workways;
	}

	public void setWorkways(String workways) {
		this.workways = workways;
	}
	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getWorktype() {
		return worktype;
	}

	public void setWorktype(String worktype) {
		this.worktype = worktype;
	}

	public List<Schedulestatus> getSslist() {
		return sslist;
	}
	public void setSslist(List<Schedulestatus> sslist) {
		this.sslist = sslist;
	}
	public boolean isIsworkline() {
		return isworkline;
	}

	public void setIsworkline(boolean isworkline) {
		this.isworkline = isworkline;
	}

	public String getChildnum() {
		return childnum;
	}

	public void setChildnum(String childnum) {
		this.childnum = childnum;
	}
	public BigDecimal getDiscountprice() {
		return discountprice;
	}

	public void setDiscountprice(BigDecimal discountprice) {
		this.discountprice = discountprice;
	}

	public BigDecimal getConnectprice() {
		return connectprice;
	}

	public void setConnectprice(BigDecimal connectprice) {
		this.connectprice = connectprice;
	}

	public BigDecimal getRoundprice() {
		return roundprice;
	}

	public void setRoundprice(BigDecimal roundprice) {
		this.roundprice = roundprice;
	}
}
