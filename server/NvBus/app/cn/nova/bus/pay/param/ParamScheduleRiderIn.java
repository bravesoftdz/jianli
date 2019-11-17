package cn.nova.bus.pay.param;

import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Id;

import cn.nova.utils.orm.jpa.DelphiDS;

@DelphiDS
public class ParamScheduleRiderIn {

	private static final long serialVersionUID = -8326667493922283590L;
	@Id
	private long id;
	/**
	 *  fullprice	全票价	Integer	全票价	必填	分 20000
		haschildren	是否带儿童	Boolean	是否带儿童	可选	false
		ridercertnumber	证件号码	String	证件号码	可选	1111
		ridercerttype	证件类型	String	证件类型	可选	01
		ridername	姓名	String	姓名	可选	张三
		seatnumber	座位号	String	座位号	可选	46
		servicecharge	服务费	Integer	服务费	可选	分 300
		ticketprice	该张票价	Integer	该张票价	必填	分9000

	 */
	private BigDecimal fullprice;
	private Boolean haschildren;
	private Integer customerid;
	private String seatnumber;
	private BigDecimal servicecharge;
	private BigDecimal ticketprice;
	private BigDecimal premium;
	
	/**
    deptime	出发时间	String 	出发时间	必填	yyyy-mm-dd HH:mm:ss
	distance	距离	Integer	距离	可选	km 
	lastplacename	到达目的地	String	到达目的地	必填	上海
	startcityname	出发城市	String	出发城市	必填	杭州
	startprovincename	出发省份	String	出发省份	可选	上海
	startstationid	出发车站ID 	String	出发车站ID 	可选	1111
	startstationname	出发车站名称	String 	出发车站名称	必填	上海虹桥车站
	tostationcityname 	到达车站城市名称	String 	到达车站城市名称	可选	杭州
	tostationid	到达车站ID	String 	到达车站ID	可选	111
	tostationprovincename	到达车站名称	String 	到达车站名称	可选	杭州总站
	tostationprovincename	到达车站省份	String 	到达车站省份	可选	浙江
	terminal	终点站名称	String 	终点站名称	可选	宁波
	busnumber	车次编号	String 	车次编号	可选	PT222
	startstationaddress	车站地址	String 	车站地址	可选	xxx

 */
	private Date departdate;
	private String deptime;
	private Integer distance;
	private String lastplacename;
	private String startcityname;
	private String startprovincename;
	private Long startstationid;
	private String startstationname;
	private String tostationcityname;
	private Long tostationid;
	private String tostationname;
	private String tostationprovincename;
	private String terminal;
	private String busnumber;
	private String startstationaddress;
	private long scheduleplanid;

	
	public Boolean getHaschildren() {
		return haschildren;
	}
	public void setHaschildren(Boolean haschildren) {
		this.haschildren = haschildren;
	}
	
	
	public Integer getCustomerid() {
		return customerid;
	}
	public void setCustomerid(Integer customerid) {
		this.customerid = customerid;
	}
	public String getSeatnumber() {
		return seatnumber;
	}
	public void setSeatnumber(String seatnumber) {
		this.seatnumber = seatnumber;
	}
	public String getDeptime() {
		return deptime;
	}
	public void setDeptime(String deptime) {
		this.deptime = deptime;
	}
	public Integer getDistance() {
		return distance;
	}
	public void setDistance(Integer distance) {
		this.distance = distance;
	}
	public String getLastplacename() {
		return lastplacename;
	}
	public void setLastplacename(String lastplacename) {
		this.lastplacename = lastplacename;
	}
	public String getStartcityname() {
		return startcityname;
	}
	public void setStartcityname(String startcityname) {
		this.startcityname = startcityname;
	}
	public String getStartprovincename() {
		return startprovincename;
	}
	public void setStartprovincename(String startprovincename) {
		this.startprovincename = startprovincename;
	}

	public String getStartstationname() {
		return startstationname;
	}
	public void setStartstationname(String startstationname) {
		this.startstationname = startstationname;
	}
	public String getTostationcityname() {
		return tostationcityname;
	}
	public void setTostationcityname(String tostationcityname) {
		this.tostationcityname = tostationcityname;
	}

	public String getTostationname() {
		return tostationname;
	}
	public void setTostationname(String tostationname) {
		this.tostationname = tostationname;
	}
	public String getTostationprovincename() {
		return tostationprovincename;
	}
	public void setTostationprovincename(String tostationprovincename) {
		this.tostationprovincename = tostationprovincename;
	}
	public String getTerminal() {
		return terminal;
	}
	public void setTerminal(String terminal) {
		this.terminal = terminal;
	}
	public String getBusnumber() {
		return busnumber;
	}
	public void setBusnumber(String busnumber) {
		this.busnumber = busnumber;
	}
	public String getStartstationaddress() {
		return startstationaddress;
	}
	public void setStartstationaddress(String startstationaddress) {
		this.startstationaddress = startstationaddress;
	}
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public BigDecimal getFullprice() {
		return fullprice;
	}
	public void setFullprice(BigDecimal fullprice) {
		this.fullprice = fullprice;
	}
	public BigDecimal getServicecharge() {
		return servicecharge;
	}
	public void setServicecharge(BigDecimal servicecharge) {
		this.servicecharge = servicecharge;
	}
	public BigDecimal getTicketprice() {
		return ticketprice;
	}
	public void setTicketprice(BigDecimal ticketprice) {
		this.ticketprice = ticketprice;
	}
	public Long getStartstationid() {
		return startstationid;
	}
	public void setStartstationid(Long startstationid) {
		this.startstationid = startstationid;
	}
	public Long getTostationid() {
		return tostationid;
	}
	public void setTostationid(Long tostationid) {
		this.tostationid = tostationid;
	}
	public Date getDepartdate() {
		return departdate;
	}
	public void setDepartdate(Date departdate) {
		this.departdate = departdate;
	}
	public BigDecimal getPremium() {
		return premium;
	}
	public void setPremium(BigDecimal premium) {
		this.premium = premium;
	}
	public long getScheduleplanid() {
		return scheduleplanid;
	}
	public void setScheduleplanid(long scheduleplanid) {
		this.scheduleplanid = scheduleplanid;
	}
	
}
