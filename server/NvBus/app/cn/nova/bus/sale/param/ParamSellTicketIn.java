/**
 * 
 */
package cn.nova.bus.sale.param;


/**
 * @author ice
 * 售票参数类
 */
public class ParamSellTicketIn extends cn.nova.bus.sale.remote.param.ParamSellTicketIn {

	private static final long serialVersionUID = -8054629844048025291L;

	private long ticketpriceId;
	    
    private Long handticketoutletsid;
	private Long customerid;
	
	public ParamSellTicketIn(cn.nova.bus.sale.remote.param.ParamSellTicketIn paramSellTicketIn){
		setDepartDate(paramSellTicketIn.getDepartDate());
		setSchedulecode(paramSellTicketIn.getSchedulecode());
		setSchedulesynccode(paramSellTicketIn.getSchedulesynccode());
		setSeattypeCode(paramSellTicketIn.getSeattypeCode());
		setTickettypeCode(paramSellTicketIn.getTickettypeCode());
		setDepartStationCode(paramSellTicketIn.getDepartStationCode());
		setReachStationCode(paramSellTicketIn.getReachStationCode());
		setDeparttime(paramSellTicketIn.getDeparttime());
		setPrice(paramSellTicketIn.getPrice());
		setSeatno(paramSellTicketIn.getSeatno());
		setSeatnostr(paramSellTicketIn.getSeatnostr());
		setCarrychildnum(paramSellTicketIn.getCarrychildnum());
		setCertificatetype(paramSellTicketIn.getCertificatetype());
		setCertificateno(paramSellTicketIn.getCertificateno());
		setServicefee(paramSellTicketIn.getServicefee());		
	}
	
	/**
	 * @return the ticketpriceId
	 */
	public long getTicketpriceId() {
		return ticketpriceId;
	}
	/**
	 * @param ticketpriceId the ticketpriceId to set
	 */
	public void setTicketpriceId(long ticketpriceId) {
		this.ticketpriceId = ticketpriceId;
	}
	/**
	 * @return the handticketoutletsid
	 */
	public Long getHandticketoutletsid() {
		return handticketoutletsid;
	}
	/**
	 * @param handticketoutletsid the handticketoutletsid to set
	 */
	public void setHandticketoutletsid(Long handticketoutletsid) {
		this.handticketoutletsid = handticketoutletsid;
	}
	/**
	 * @return the customerid
	 */
	public Long getCustomerid() {
		return customerid;
	}
	/**
	 * @param customerid the customerid to set
	 */
	public void setCustomerid(Long customerid) {
		this.customerid = customerid;
	}
		 
}
