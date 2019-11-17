/**
 * 
 */
package cn.nova.bus.sale.remote.param;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Transient;

/**
 * @author ice
 *
 */
@Entity
public class ParamTicketReturnQryOut implements Serializable {
	private static final long serialVersionUID = 18863851881117249L;
	@Id
	private long id;//售票ID
	private String ticketstatus;//票状态 0正常/1已销/2已退
	private String tickettype;//票类型	Q全/B半
//	@Transient
	private BigDecimal rate;//退票费率
//	@Transient
	private BigDecimal charges;//退票费	
	private BigDecimal ticketprice;//票价
	private String orderno;//订单号
	private String ticketno;//原票号
	private Date departdate;//发车日期
	private String departtime;//发车时间
	private short seatno;//座位号
	private String departstationname;//始发站名称
	private String reachstationname;//到达站名称
	private Date selltime;//售票时间
	private String ticketoutletscode;//原票点代码	
	private String ticketoutletsidname;//原票点名称	
	private boolean ischecked;//是否已检票
	private boolean isdepartinvoices;//是否已发班
	private byte carrychildnum;
	
	/**
	 * @return the ticketstatus
	 */
	public String getTicketstatus() {
		return ticketstatus;
	}
	/**
	 * @param ticketstatus the ticketstatus to set
	 */
	public void setTicketstatus(String ticketstatus) {
		this.ticketstatus = ticketstatus;
	}
	/**
	 * @return the tickettype
	 */
	public String getTickettype() {
		return tickettype;
	}
	/**
	 * @param tickettype the tickettype to set
	 */
	public void setTickettype(String tickettype) {
		this.tickettype = tickettype;
	}
	/**
	 * @return the rate
	 */
	public BigDecimal getRate() {
		return rate;
	}
	/**
	 * @param rate the rate to set
	 */
	public void setRate(BigDecimal rate) {
		this.rate = rate;
	}
	/**
	 * @return the charges
	 */
	public BigDecimal getCharges() {
		return charges;
	}
	/**
	 * @param charges the charges to set
	 */
	public void setCharges(BigDecimal charges) {
		this.charges = charges;
	}
	/**
	 * @return the ticketprice
	 */
	public BigDecimal getTicketprice() {
		return ticketprice;
	}
	/**
	 * @param ticketprice the ticketprice to set
	 */
	public void setTicketprice(BigDecimal ticketprice) {
		this.ticketprice = ticketprice;
	}
	/**
	 * @return the orderno
	 */
	public String getOrderno() {
		return orderno;
	}
	/**
	 * @param orderno the orderno to set
	 */
	public void setOrderno(String orderno) {
		this.orderno = orderno;
	}
	/**
	 * @return the ticketno
	 */
	public String getTicketno() {
		return ticketno;
	}
	/**
	 * @param ticketno the ticketno to set
	 */
	public void setTicketno(String ticketno) {
		this.ticketno = ticketno;
	}
	/**
	 * @return the departdate
	 */
	public Date getDepartdate() {
		return departdate;
	}
	/**
	 * @param departdate the departdate to set
	 */
	public void setDepartdate(Date departdate) {
		this.departdate = departdate;
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
	 * @return the seatno
	 */
	public short getSeatno() {
		return seatno;
	}
	/**
	 * @param seatno the seatno to set
	 */
	public void setSeatno(short seatno) {
		this.seatno = seatno;
	}
	/**
	 * @return the departstationname
	 */
	public String getDepartstationname() {
		return departstationname;
	}
	/**
	 * @param departstationname the departstationname to set
	 */
	public void setDepartstationname(String departstationname) {
		this.departstationname = departstationname;
	}
	/**
	 * @return the reachstationname
	 */
	public String getReachstationname() {
		return reachstationname;
	}
	/**
	 * @param reachstationname the reachstationname to set
	 */
	public void setReachstationname(String reachstationname) {
		this.reachstationname = reachstationname;
	}
	/**
	 * @return the selltime
	 */
	public Date getSelltime() {
		return selltime;
	}
	/**
	 * @param selltime the selltime to set
	 */
	public void setSelltime(Date selltime) {
		this.selltime = selltime;
	}
	/**
	 * @return the ticketoutletscode
	 */
	public String getTicketoutletscode() {
		return ticketoutletscode;
	}
	/**
	 * @param ticketoutletscode the ticketoutletscode to set
	 */
	public void setTicketoutletscode(String ticketoutletscode) {
		this.ticketoutletscode = ticketoutletscode;
	}
	/**
	 * @return the ticketoutletsidname
	 */
	public String getTicketoutletsidname() {
		return ticketoutletsidname;
	}
	/**
	 * @param ticketoutletsidname the ticketoutletsidname to set
	 */
	public void setTicketoutletsidname(String ticketoutletsidname) {
		this.ticketoutletsidname = ticketoutletsidname;
	}
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public boolean getIschecked() {
		return ischecked;
	}
	public void setIschecked(boolean ischecked) {
		this.ischecked = ischecked;
	}
	public boolean getIsdepartinvoices() {
		return isdepartinvoices;
	}
	public void setIsdepartinvoices(boolean isdepartinvoices) {
		this.isdepartinvoices = isdepartinvoices;
	}
	public byte getCarrychildnum() {
		return carrychildnum;
	}
	public void setCarrychildnum(byte carrychildnum) {
		this.carrychildnum = carrychildnum;
	}

}
