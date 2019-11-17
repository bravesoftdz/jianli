package cn.nova.bus.checkticket.socket;

public class Message {
	// 主机IP|主机端口|闸机设备号|验票设备|车票号码|END
	//新的修改为:主机IP|主机端口| 闸机设备号|验票设备|检票条件1|检票条件2|检票条件3|校验值|END
	private String ip;

	private int port;

	private String gatesno; //闸机设备号 / 通道号

	private String equipment; //验票设备  
	//验票设备的定义为 0 条码设备验票，1 二代身份证设备验票 2 员工卡设备验票(拓展证件类型等)
	//条码设备支持一维条码和二维条码，票务系统后台应考虑二维条码的兼容性。


	private String ticketno;
	
	private String certificateno;
	
	private String checkconditiont;
	
	private String checkconditionth;
	
	private String errcode;// 返回码

	private String errmsg;// 返回信息

	private String schcode;

	// 票种：0 全票，1童票，2军残票，3优惠票
	private String ticketype;

	private String seatno;

	private int peoples;// 通过人数

	private String remask;// 备用

	public long checkstationid;

	public long checkby;

	public String getSendmsg() {
		// SU|班次|票种|座位号|闸机设备号|通过人数|备用0|END
		// FL|失败原因|备用0|备用0|备用0|备用0|备用0|END
		if ("0".equals(errcode)) {
			return "SU|" + schcode + "|" + ticketype + "|" + seatno + "|"
					+ equipment + "|" + peoples + "|0" + "|END";
		} 
		else if("25".equals(errcode)){
			return "FL|" + errcode + "|"+certificateno+"|0|0|0|0" + "|END";
		}else {
			return "FL|" + errcode + "|0|0|0|0|0" + "|END";
		}
	}

	public String nvl(Object object) {
		if (object == null) {
			return "";
		} else {
			return object.toString();
		}
	}

	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

	public int getPort() {
		return port;
	}

	public void setPort(int port) {
		this.port = port;
	}

	public String getGatesno() {
		return gatesno;
	}

	public void setGatesno(String gatesno) {
		this.gatesno = gatesno;
	}

	public String getEquipment() {
		return equipment;
	}

	public void setEquipment(String equipment) {
		this.equipment = equipment;
	}

	public String getTicketno() {
		return ticketno;
	}

	public void setTicketno(String ticketno) {
		this.ticketno = ticketno;
	}

	public String getErrcode() {
		return errcode;
	}

	public void setErrcode(String errcode) {
		this.errcode = errcode;
	}

	public String getErrmsg() {
		return errmsg;
	}

	public void setErrmsg(String errmsg) {
		this.errmsg = errmsg;
	}

	public String getSchcode() {
		return schcode;
	}

	public void setSchcode(String schcode) {
		this.schcode = schcode;
	}

	public String getTicketype() {
		return ticketype;
	}

	public void setTicketype(String ticketype) {
		this.ticketype = ticketype;
	}

	public String getSeatno() {
		return seatno;
	}

	public void setSeatno(String seatno) {
		this.seatno = seatno;
	}

	public int getPeoples() {
		return peoples;
	}

	public void setPeoples(int peoples) {
		this.peoples = peoples;
	}

	public String getRemask() {
		return remask;
	}

	public void setRemask(String remask) {
		this.remask = remask;
	}

	public long getCheckstationid() {
		return checkstationid;
	}

	public void setCheckstationid(long checkstationid) {
		this.checkstationid = checkstationid;
	}

	public long getCheckby() {
		return checkby;
	}

	public void setCheckby(long checkby) {
		this.checkby = checkby;
	}

	public String getCertificateno() {
		return certificateno;
	}

	public void setCertificateno(String certificateno) {
		this.certificateno = certificateno;
	}


	public String getCheckconditiont() {
		return checkconditiont;
	}

	public void setCheckconditiont(String checkconditiont) {
		this.checkconditiont = checkconditiont;
	}

	public String getCheckconditionth() {
		return checkconditionth;
	}

	public void setCheckconditionth(String checkconditionth) {
		this.checkconditionth = checkconditionth;
	}
	
}
