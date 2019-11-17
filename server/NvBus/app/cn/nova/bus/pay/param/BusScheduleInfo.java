package cn.nova.bus.pay.param;

public class BusScheduleInfo {

	private static final long serialVersionUID = -8326667493922283590L;
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
		tostationname	到达车站名称	String 	到达车站名称	可选	杭州总站
		tostationprovincename	到达车站省份	String 	到达车站省份	可选	浙江
		terminal	终点站名称	String 	终点站名称	可选	宁波
		busnumber	车次编号	String 	车次编号	可选	PT222
		startstationaddress	车站地址	String 	车站地址	可选	xxx
	 */
	private String deptime;
	private Integer distance;
	private String lastplacename;
	private String startcityname;
	private String startprovincename;
	private String startstationid;
	private String startstationname;
	private String tostationcityname;
	private String tostationid;
	private String tostationname;
	private String tostationprovincename;
	private String terminal;
	private String busnumber;
	private String startstationaddress;
	private long scheduleplanid;

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

	public String getStartstationid() {
		return startstationid;
	}

	public void setStartstationid(String startstationid) {
		this.startstationid = startstationid;
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

	public String getTostationid() {
		return tostationid;
	}

	public void setTostationid(String tostationid) {
		this.tostationid = tostationid;
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

	public long getScheduleplanid() {
		return scheduleplanid;
	}

	public void setScheduleplanid(long scheduleplanid) {
		this.scheduleplanid = scheduleplanid;
	}

}
