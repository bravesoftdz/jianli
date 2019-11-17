package cn.nova.bus.query.param;

import java.io.Serializable;
import java.util.Date;

/**
 * 
 * <b>类描述：当前类作为查询的参数类，其他查询也可以使用该类，只能往这里添加属性，不可删除属性</b><br/>
 * <b>类名称：</b>Qryparam<br/>
 * <b>创建人：</b><a href="mailto:lanchengkun@nova.net.cn">兰成坤</a><br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 * 
 */
public class Qryparam implements Serializable {
	/**
	 * serialVersionUID:
	 */
	private static final long serialVersionUID = -1674490519990353813L;
	private Date departSdate;
	private Date departEdate;
	private Date sellSdate;
	private Date sellEdate;
	private String schorgids;
	private String saleorgids;
	private String printorgids;
	private Long scheduleid;
	private String schcode;
	private Long routeid;
	private String routename;
	private Long ticketoutletsid;
	private String sellway;
	private String paymethod;
	private Long departstationid;
	private Long reachstationid;
	private String isovertime;
	private String islinework;
	private String ischecked;
	private String islocalticket;
	private String isdepartinvoices;
	private Long sellby;
	private String returnby;
	private String ticketstatus;
	private String ticketno;
	private String tickettype;
	private Date taketimeSdate;
	private Date taketimeEdate;
	private String customername;
	private String certificateno;
	private String mobilephone;
	private Long vehicleid;
	private Boolean isolddate;
	private String orderno; 
	private Long istaked;
	private String showfullidno;
	private String isred;
	private String iseticketsell;//只看电子票
	private String returnmethod;//退票方式   车站垫付,原路返还
	private String isShield;//团体票显示主票号
	private Long ticketlength;//票号长度
	
	private String takeby;
	
	public String getReturnmethod() {
		return returnmethod;
	}

	public void setReturnmethod(String returnmethod) {
		this.returnmethod = returnmethod;
	}

	public Long getIstaked() {
		return istaked;
	}

	public void setIstaked(Long istaked) {
		this.istaked = istaked;
	}

	public Date getDepartSdate() {
		return departSdate;
	}

	public void setDepartSdate(Date departSdate) {
		this.departSdate = departSdate;
	}

	public Date getDepartEdate() {
		return departEdate;
	}

	public void setDepartEdate(Date departEdate) {
		this.departEdate = departEdate;
	}

	public Date getSellSdate() {
		return sellSdate;
	}

	public void setSellSdate(Date sellSdate) {
		this.sellSdate = sellSdate;
	}

	public Date getSellEdate() {
		return sellEdate;
	}

	public void setSellEdate(Date sellEdate) {
		this.sellEdate = sellEdate;
	}

	public String getSchorgids() {
		return schorgids;
	}

	public void setSchorgids(String schorgids) {
		this.schorgids = schorgids;
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

	public Long getScheduleid() {
		return scheduleid;
	}

	public void setScheduleid(Long scheduleid) {
		this.scheduleid = scheduleid;
	}

	public String getSchcode() {
		return schcode;
	}

	public void setSchcode(String schcode) {
		this.schcode = schcode;
	}

	public Long getRouteid() {
		return routeid;
	}

	public void setRouteid(Long routeid) {
		this.routeid = routeid;
	}

	public String getRoutename() {
		return routename;
	}

	public void setRoutename(String routename) {
		this.routename = routename;
	}

	public Long getTicketoutletsid() {
		return ticketoutletsid;
	}

	public void setTicketoutletsid(Long ticketoutletsid) {
		this.ticketoutletsid = ticketoutletsid;
	}

	public String getSellway() {
		return sellway;
	}

	public void setSellway(String sellway) {
		this.sellway = sellway;
	}

	public String getPaymethod() {
		return paymethod;
	}

	public void setPaymethod(String paymethod) {
		this.paymethod = paymethod;
	}

	public Long getDepartstationid() {
		return departstationid;
	}

	public void setDepartstationid(Long departstationid) {
		this.departstationid = departstationid;
	}

	public Long getReachstationid() {
		return reachstationid;
	}

	public void setReachstationid(Long reachstationid) {
		this.reachstationid = reachstationid;
	}

	public Long getSellby() {
		return sellby;
	}

	public void setSellby(Long sellby) {
		this.sellby = sellby;
	}

	public String getReturnby() {
		return returnby;
	}

	public void setReturnby(String returnby) {
		this.returnby = returnby;
	}

	public String getTicketstatus() {
		return ticketstatus;
	}

	public void setTicketstatus(String ticketstatus) {
		this.ticketstatus = ticketstatus;
	}

	public String getTicketno() {
		return ticketno;
	}

	public void setTicketno(String ticketno) {
		this.ticketno = ticketno;
	}

	public String getTickettype() {
		return tickettype;
	}

	public void setTickettype(String tickettype) {
		this.tickettype = tickettype;
	}

	public String getIsovertime() {
		return isovertime;
	}

	public void setIsovertime(String isovertime) {
		this.isovertime = isovertime;
	}

	public String getIslinework() {
		return islinework;
	}

	public void setIslinework(String islinework) {
		this.islinework = islinework;
	}

	public String getIschecked() {
		return ischecked;
	}

	public void setIschecked(String ischecked) {
		this.ischecked = ischecked;
	}

	public String getIsdepartinvoices() {
		return isdepartinvoices;
	}

	public void setIsdepartinvoices(String isdepartinvoices) {
		this.isdepartinvoices = isdepartinvoices;
	}

	public String getIslocalticket() {
		return islocalticket;
	}

	public void setIslocalticket(String islocalticket) {
		this.islocalticket = islocalticket;
	}

	public Date getTaketimeSdate() {
		return taketimeSdate;
	}

	public void setTaketimeSdate(Date taketimeSdate) {
		this.taketimeSdate = taketimeSdate;
	}

	public Date getTaketimeEdate() {
		return taketimeEdate;
	}

	public void setTaketimeEdate(Date taketimeEdate) {
		this.taketimeEdate = taketimeEdate;
	}

	public String getCustomername() {
		return customername;
	}

	public void setCustomername(String customername) {
		this.customername = customername;
	}

	public String getCertificateno() {
		return certificateno;
	}

	public void setCertificateno(String certificateno) {
		this.certificateno = certificateno;
	}

	public String getMobilephone() {
		return mobilephone;
	}

	public void setMobilephone(String mobilephone) {
		this.mobilephone = mobilephone;
	}

	public Long getVehicleid() {
		return vehicleid;
	}

	public void setVehicleid(Long vehicleid) {
		this.vehicleid = vehicleid;
	}

	public Boolean getIsolddate() {
		return isolddate;
	}

	public void setIsolddate(Boolean isolddate) {
		this.isolddate = isolddate;
	}

	public String getOrderno() {
		return orderno;
	}

	public void setOrderno(String orderno) {
		this.orderno = orderno;
	}

	public String getShowfullidno() {
		return showfullidno;
	}

	public void setShowfullidno(String showfullidno) {
		this.showfullidno = showfullidno;
	}

	public String getIsred() {
		return isred;
	}

	public void setIsred(String isred) {
		this.isred = isred;
	}
//新添加的--start--
	public String getIseticketsell() {
		return iseticketsell;
	}

	public void setIseticketsell(String iseticketsell) {
		this.iseticketsell = iseticketsell;
	}
	//新添加的--end--
	public Long getTicketlength() {
		return ticketlength;
	}

	public void setTicketlength(Long ticketlength) {
		this.ticketlength = ticketlength;
	}

	public String getIsShield() {
		return isShield;
	}

	public void setIsShield(String isShield) {
		this.isShield = isShield;
	}

	public String getTakeby() {
		return takeby;
	}

	public void setTakeby(String takeby) {
		this.takeby = takeby;
	}

	
}
