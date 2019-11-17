package cn.nova.bus.report.action;

import cn.nova.bus.action.BaseAction;
import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.report.service.IncomeDepartivoiceSerivce;
import cn.nova.bus.report.service.impl.IncomeDepartivoiceSerivceImpl;

/**
 * <b>类描述：营收运量统计表</b><br/>
 * <b>类名称：</b>IncomeDepartivoiceAction.java<br/>
 * <b>创建人：</b><a href="mailto:huanghaoze@nova.net.cn">黄浩泽</a><br/>
 * <b>创建时间：</b>2012-05-03  <br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
public class IncomeDepartivoiceAction extends BaseAction{

	// 返回结果
	private List<Map<String, Object>> resultmap;
	private Date month;
	private String checkstationid;
	private Long routeid;
	private Long unitid;
	private String orgid;
	private Date startdate;
	private Date enddate;
	private long vehicleid;
	private String sign;
	
	
	/**
	 * 车站各经营单位核算表
	 * @return
	 */
	public String qryStationUnitBalance(){
		try {
			IncomeDepartivoiceSerivce incomeDepartivoiceservice = new IncomeDepartivoiceSerivceImpl();
			setResultmap(
					incomeDepartivoiceservice.qryStationUnitBalance(
							orgid,startdate,enddate,vehicleid,unitid,sign));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			e.getMessage();
		}
		return "json";
	}
	
	
	/**
	 * 营收运量统计表
	 * @return
	 */
	public String query() {
		try {
			IncomeDepartivoiceSerivce incomeDepartivoiceservice = new IncomeDepartivoiceSerivceImpl();
			setResultmap(
					incomeDepartivoiceservice.queryIncomeDepartivoice(
							orgid,month,checkstationid,routeid,unitid));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			e.getMessage();
		}
		return "json";
	}

	public List<Map<String, Object>> getResultmap() {
		return resultmap;
	}

	public void setResultmap(List<Map<String, Object>> resultmap) {
		this.resultmap = resultmap;
	}

	public Date getMonth() {
		return month;
	}

	public void setMonth(Date month) {
		this.month = month;
	}

	public String getCheckstationid() {
		return checkstationid;
	}

	public void setCheckstationid(String checkstationid) {
		this.checkstationid = checkstationid;
	}

	public Long getRouteid() {
		return routeid;
	}

	public void setRouteid(Long routeid) {
		this.routeid = routeid;
	}

	public Long getUnitid() {
		return unitid;
	}

	public void setUnitid(Long unitid) {
		this.unitid = unitid;
	}

	public String getOrgid() {
		return orgid;
	}

	public void setOrgid(String orgid) {
		this.orgid = orgid;
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

	public long getVehicleid() {
		return vehicleid;
	}

	public void setVehicleid(long vehicleid) {
		this.vehicleid = vehicleid;
	}


	public String getSign() {
		return sign;
	}


	public void setSign(String sign) {
		this.sign = sign;
	}
	

}
