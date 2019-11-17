/**
 * 
 */
package cn.nova.bus.sale.remote.param;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
 * @author ice
 * 售票参数类
 */
public class ParamSellTicketIn implements Serializable {

	private static final long serialVersionUID = 3049166739002168813L;
	private Date departDate; //非空
	 //schedulecode或schedulesynccode非空
	private String schedulecode;
	private String schedulesynccode;
	    
    private String seattypeCode; //非空
    private String tickettypeCode; //非空

	private String departStationCode; //非空
	private String reachStationCode; //非空
	private String departtime;
	
    private BigDecimal price;
	    
    private int seatno; 
    private String seatnostr;
    private byte carrychildnum;
	
	private String certificatetype;
	private String certificateno;
	
	private BigDecimal Servicefee=new BigDecimal(0);//服务费 默认为0
	
	/**
	 * @return the departDate
	 */
	public Date getDepartDate() {
		return departDate;
	}
	/**
	 * @param departDate the departDate to set
	 */
	public void setDepartDate(Date departDate) {
		this.departDate = departDate;
	}
	/**
	 * @return the schedulecode
	 */
	public String getSchedulecode() {
		return schedulecode;
	}
	/**
	 * @param schedulecode the schedulecode to set
	 */
	public void setSchedulecode(String schedulecode) {
		this.schedulecode = schedulecode;
	}
	/**
	 * @return the schedulesynccode
	 */
	public String getSchedulesynccode() {
		return schedulesynccode;
	}
	/**
	 * @param schedulesynccode the schedulesynccode to set
	 */
	public void setSchedulesynccode(String schedulesynccode) {
		this.schedulesynccode = schedulesynccode;
	}
	/**
	 * @return the seattypeCode
	 */
	public String getSeattypeCode() {
		return seattypeCode;
	}
	/**
	 * @param seattypeCode the seattypeCode to set
	 */
	public void setSeattypeCode(String seattypeCode) {
		this.seattypeCode = seattypeCode;
	}
	/**
	 * @return the tickettypeCode
	 */
	public String getTickettypeCode() {
		return tickettypeCode;
	}
	/**
	 * @param tickettypeCode the tickettypeCode to set
	 */
	public void setTickettypeCode(String tickettypeCode) {
		this.tickettypeCode = tickettypeCode;
	}
	/**
	 * @return the departStationCode
	 */
	public String getDepartStationCode() {
		return departStationCode;
	}
	/**
	 * @param departStationCode the departStationCode to set
	 */
	public void setDepartStationCode(String departStationCode) {
		this.departStationCode = departStationCode;
	}
	/**
	 * @return the reachStationCode
	 */
	public String getReachStationCode() {
		return reachStationCode;
	}
	/**
	 * @param reachStationCode the reachStationCode to set
	 */
	public void setReachStationCode(String reachStationCode) {
		this.reachStationCode = reachStationCode;
	}
	/**
	 * @return the departtime
	 */
	public String getDeparttime() {
		return departtime;
	}
	/**
	 * @param departtime the departtime to set
	 */
	public void setDeparttime(String departtime) {
		this.departtime = departtime;
	}
	/**
	 * @return the price
	 */
	public BigDecimal getPrice() {
		return price;
	}
	/**
	 * @param price the price to set
	 */
	public void setPrice(BigDecimal price) {
		this.price = price;
	}
	/**
	 * @return the seatno
	 */
	public int getSeatno() {
		return seatno;
	}
	/**
	 * @param seatno the seatno to set
	 */
	public void setSeatno(int seatno) {
		this.seatno = seatno;
	}
	/**
	 * @return the seatnostr
	 */
	public String getSeatnostr() {
		return seatnostr;
	}
	/**
	 * @param seatnostr the seatnostr to set
	 */
	public void setSeatnostr(String seatnostr) {
		this.seatnostr = seatnostr;
	}
	/**
	 * @return the carrychildnum
	 */
	public byte getCarrychildnum() {
		return carrychildnum;
	}
	/**
	 * @param carrychildnum the carrychildnum to set
	 */
	public void setCarrychildnum(byte carrychildnum) {
		this.carrychildnum = carrychildnum;
	}
	/**
	 * @return the certificatetype
	 */
	public String getCertificatetype() {
		return certificatetype;
	}
	/**
	 * @param certificatetype the certificatetype to set
	 */
	public void setCertificatetype(String certificatetype) {
		this.certificatetype = certificatetype;
	}
	/**
	 * @return the certificateno
	 */
	public String getCertificateno() {
		return certificateno;
	}
	/**
	 * @param certificateno the certificateno to set
	 */
	public void setCertificateno(String certificateno) {
		this.certificateno = certificateno;
	}
	public BigDecimal getServicefee() {
		return Servicefee;
	}
	public void setServicefee(BigDecimal servicefee) {
		Servicefee = servicefee;
	}
		 
}
