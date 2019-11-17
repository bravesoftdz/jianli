package cn.nova.bus.netsale.model;

import java.io.Serializable;


/**
 * 用于车站与中心交互的车票信息
 * @author Administrator
 *
 */
public class TicketInfo implements Serializable {
	private static final long serialVersionUID = 1L;

//	@Transient
//	@Transient
	private String orderno;
	//电子票ID
	private String eticketid;
	private String batchno;
	private String ticketno;
	private boolean isselfschedule;
	private String schplansynccode;
	private String remarks;
	
	public String getOrderno() {
		return orderno;
	}
	public void setOrderno(String orderno) {
		this.orderno = orderno;
	}
	public String getEticketid() {
		return eticketid;
	}
	public void setEticketid(String eticketid) {
		this.eticketid = eticketid;
	}
	/**
	 * @return 批次号
	 */
	public String getBatchno() {
		return batchno;
	}
	/**
	 * @param 批次号
	 */
	public void setBatchno(String batchno) {
		this.batchno = batchno;
	}
	/**
	 * @return 车票号
	 */
	public String getTicketno() {
		return ticketno;
	}
	/**
	 * @param 车票号
	 */
	public void setTicketno(String ticketno) {
		this.ticketno = ticketno;
	}
	/**
	 * @return the remarks
	 */
	public String getRemarks() {
		return remarks;
	}
	/**
	 * @param remarks the remarks to set
	 */
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	/**
	 * @return the 是否本站班次,争对操作站的对方站而言
	 */
	public boolean getIsselfschedule() {
		return isselfschedule;
	}
	/**
	 * @param isselfschedule the isselfschedule to set
	 */
	public void setIsselfschedule(boolean isselfschedule) {
		this.isselfschedule = isselfschedule;
	}
	public String getSchplansynccode() {
		return schplansynccode;
	}
	public void setSchplansynccode(String schplansynccode) {
		this.schplansynccode = schplansynccode;
	}

	
}