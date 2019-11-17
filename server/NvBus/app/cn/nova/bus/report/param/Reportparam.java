package cn.nova.bus.report.param;

import java.io.Serializable;
import java.util.Date;
/**
 * 
 * <b>类描述：报表参数类</b><br/>
 * <b>类名称：</b>Reportparam<br/>
 * <b>创建人：</b><a href="mailto:lanchengkun@nova.net.cn">兰成坤</a><br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 *
 */
public class Reportparam implements Serializable {
	/**
	 * serialVersionUID:
	 */
	private static final long serialVersionUID = -4434431847696073283L;
	private Date startdate;
	private Date enddate;
	private String orgids;
	private String saleorgids;
	private String printorgids;
	private long scheduleid;
	private String schedulecode;//发班code
	private long routeid;
	private int balancetype;
	private int schtype;
	private long unitid;
	private String unitids;
	private long balanceunitid;
	private String balanceunitids;
	private String workways;
	private String handflag; //手工单、微机单标记
	private String agentcaltype;     //劳务费取值方式,0: 原单据取值，1：0.1计算，2：0.08计算
	private String type;             //单位类型，包括全部、本司、本集团外司、外司
	
	public String getSchedulecode() {
		return schedulecode;
	}

	public void setSchedulecode(String schedulecode) {
		this.schedulecode = schedulecode;
	}

	public String getAgentcaltype() {
		return agentcaltype;
	}

	public void setAgentcaltype(String agentcaltype) {
		this.agentcaltype = agentcaltype;
	}

	public String getBalanceunitids() {
		return balanceunitids;
	}

	public void setBalanceunitids(String balanceunitids) {
		this.balanceunitids = balanceunitids;
	}

	private long vehicleid;
    private boolean isshowzerotickets;
	public boolean isIsshowzerotickets() {
		return isshowzerotickets;
	}

	public String getUnitids() {
		return unitids;
	}

	public void setUnitids(String unitids) {
		this.unitids = unitids;
	}

	public void setIsshowzerotickets(boolean isshowzerotickets) {
		this.isshowzerotickets = isshowzerotickets;
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

	public String getOrgids() {
		return orgids;
	}

	public void setOrgids(String orgids) {
		this.orgids = orgids;
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

	public long getScheduleid() {
		return scheduleid;
	}

	public void setScheduleid(long scheduleid) {
		this.scheduleid = scheduleid;
	}

	public long getRouteid() {
		return routeid;
	}

	public void setRouteid(long routeid) {
		this.routeid = routeid;
	}

	public int getBalancetype() {
		return balancetype;
	}

	public void setBalancetype(int balancetype) {
		this.balancetype = balancetype;
	}

	public int getSchtype() {
		return schtype;
	}

	public void setSchtype(int schtype) {
		this.schtype = schtype;
	}

	public long getUnitid() {
		return unitid;
	}

	public void setUnitid(long unitid) {
		this.unitid = unitid;
	}

	public long getBalanceunitid() {
		return balanceunitid;
	}

	public void setBalanceunitid(long balanceunitid) {
		this.balanceunitid = balanceunitid;
	}

	public long getVehicleid() {
		return vehicleid;
	}

	public void setVehicleid(long vehicleid) {
		this.vehicleid = vehicleid;
	}

	public String getWorkways() {
		return workways;
	}

	public void setWorkways(String workways) {
		this.workways = workways;
	}

	public String getHandflag() {
		return handflag;
	}

	public void setHandflag(String handflag) {
		this.handflag = handflag;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	
	
}
