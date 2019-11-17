package cn.nova.bus.sale.model;

import java.math.BigDecimal;
import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Payinfo entity. @author zhangqingfeng
 */
@Entity
@Table(name = "PAYINFO")
public class Payinfo implements java.io.Serializable {

	// Fields

	private long id;
	private String orderno;
	private String payorderno;//如果是支付服务器支付 则为商户订单号码 如果是POS机 则为 凭证号
	private String payno;//如果是支付服务器支付 则为订单号码 如果是POS机 则为交易参考号码
	private Double totalprice;
	private Integer gatewayid;
	private String alipaycode;
	private Integer paystatus;
	private String paymessage;
	private Double refundmoney;
	private String returnstatus;
	private String returnmessage;
	@Temporal(TemporalType.TIMESTAMP)
	private Date createtime;
	@Temporal(TemporalType.TIMESTAMP)
	private Date updatetime;
	private Long createby;
	private Long updateby;
	private Boolean isactive;
	private String paymethod;
	

	private Integer paytradename;
	private String paytradenameval;
	private String sellorgname;
	private boolean isbus365pay;
	private String bankcode;
	private String cardcode;
	private Integer terterminalcode;
	private Integer batchcode;
	private String paydate;
	private Integer paytime;
	private Integer authorizationcode;
	private Integer clearingdate;
	private Integer lrc;
	private Long discounts;
	private String respcode;
	private Boolean isreturnmoney;
	private Double returnmoneytotal;
	private String paygateway;
	private String orderstatus;
	private String ip;
	private String insurancestatus;
	// Constructors

	//增加 payinfo 售票数、售票金额；售保险数、售保险金额
	
	private BigDecimal tickets;
	
	private BigDecimal ticketprice;
	
	private BigDecimal insures;
	
	private BigDecimal insurefee;
	
	
	private String merchantpayorderno;//如果是支付服务器支付 则为商户订单号码 如果是POS机也是商户订单号码
	// Constructors

	/** default constructor */
	public Payinfo() {
	}

	/** minimal constructor */
	public Payinfo(long id, String orderno, String payorderno,
			Double totalprice, Integer topayinfoid) {
		this.id = id;
		this.orderno = orderno;
		this.payorderno = payorderno;
		this.totalprice = totalprice;
		this.gatewayid = topayinfoid;
	}

	
	public Payinfo(String orderno, String payorderno, Double totalprice, Integer gatewayid, Integer paystatus,
			Date createtime, Long createby, Boolean isactive, boolean isbus365pay, String paygateway,
			String orderstatus, String ip, BigDecimal tickets, BigDecimal ticketprice, BigDecimal insures,
			BigDecimal insurefee, String merchantpayorderno) {
		super();
		this.orderno = orderno;
		this.payorderno = payorderno;
		this.totalprice = totalprice;
		this.gatewayid = gatewayid;
		this.paystatus = paystatus;
		this.createtime = createtime;
		this.createby = createby;
		this.isactive = isactive;
		this.isbus365pay = isbus365pay;
		this.paygateway = paygateway;
		this.orderstatus = orderstatus;
		this.ip = ip;
		this.tickets = tickets;
		this.ticketprice = ticketprice;
		this.insures = insures;
		this.insurefee = insurefee;
		this.merchantpayorderno = merchantpayorderno;
	}

	// Property accessors
	@Id
	@SequenceGenerator(name="PAYINFO_ID_GENERATOR", sequenceName="SEQ_PAYINFO",allocationSize=1)
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="PAYINFO_ID_GENERATOR")
	@Column(name = "ID", unique = true, nullable = false, precision = 20, scale = 0)
	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	@Column(name = "ORDERNO", nullable = false, length = 36)
	public String getOrderno() {
		return this.orderno;
	}

	public void setOrderno(String orderno) {
		this.orderno = orderno;
	}

	@Column(name = "PAYORDERNO", nullable = false, length = 36)
	public String getPayorderno() {
		return this.payorderno;
	}

	public void setPayorderno(String payorderno) {
		this.payorderno = payorderno;
	}

	@Column(name = "PAYNO", length = 36)
	public String getPayno() {
		return this.payno;
	}

	public void setPayno(String payno) {
		this.payno = payno;
	}

	@Column(name = "TOTALPRICE", nullable = false, precision = 8)
	public Double getTotalprice() {
		return this.totalprice;
	}

	public void setTotalprice(Double totalprice) {
		this.totalprice = totalprice;
	}

	
	@Column(name = "GATEWAYID", nullable = false, precision = 8, scale = 0)
	public void setGatewayid(Integer gatewayid) {
		this.gatewayid = gatewayid;
	}
	public Integer getGatewayid() {
		return gatewayid;
	}

	
	@Column(name = "ALIPAYCODE", length = 16)
	public String getAlipaycode() {
		return this.alipaycode;
	}

	public void setAlipaycode(String alipaycode) {
		this.alipaycode = alipaycode;
	}

	@Column(name = "PAYSTATUS", precision = 3, scale = 0)
	public Integer getPaystatus() {
		return this.paystatus;
	}

	public void setPaystatus(Integer paystatus) {
		this.paystatus = paystatus;
	}

	@Column(name = "PAYMESSAGE", length = 50)
	public String getPaymessage() {
		return this.paymessage;
	}

	public void setPaymessage(String paymessage) {
		this.paymessage = paymessage;
	}

	@Column(name = "REFUNDMONEY", precision = 8)
	public Double getRefundmoney() {
		return this.refundmoney;
	}

	public void setRefundmoney(Double refundmoney) {
		this.refundmoney = refundmoney;
	}

	@Column(name = "RETURNSTATUS", length = 10)
	public String getReturnstatus() {
		return this.returnstatus;
	}

	public void setReturnstatus(String returnstatus) {
		this.returnstatus = returnstatus;
	}

	@Column(name = "RETURNMESSAGE", length = 50)
	public String getReturnmessage() {
		return this.returnmessage;
	}

	public void setReturnmessage(String returnmessage) {
		this.returnmessage = returnmessage;
	}

	public Date getCreatetime() {
		return this.createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	public Date getUpdatetime() {
		return this.updatetime;
	}

	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}

	@Column(name = "CREATEBY", precision = 8)
	public Long getCreateby() {
		return this.createby;
	}

	public void setCreateby(Long createby) {
		this.createby = createby;
	}

	@Column(name = "UPDATEBY", precision = 8)
	public Long getUpdateby() {
		return this.updateby;
	}

	public void setUpdateby(Long updateby) {
		this.updateby = updateby;
	}

	public Boolean getIsactive() {
		return isactive;
	}

	public void setIsactive(Boolean isactive) {
		this.isactive = isactive;
	}

	public String getPaymethod() {
		return paymethod;
	}

	public void setPaymethod(String paymethod) {
		this.paymethod = paymethod;
	}

	public Integer getPaytradename() {
		return paytradename;
	}

	public void setPaytradename(Integer paytradename) {
		this.paytradename = paytradename;
	}

	public String getPaytradenameval() {
		return paytradenameval;
	}

	public void setPaytradenameval(String paytradenameval) {
		this.paytradenameval = paytradenameval;
	}

	public String getSellorgname() {
		return sellorgname;
	}

	public void setSellorgname(String sellorgname) {
		this.sellorgname = sellorgname;
	}

	public boolean isIsbus365pay() {
		return isbus365pay;
	}

	public void setIsbus365pay(boolean isbus365pay) {
		this.isbus365pay = isbus365pay;
	}

	public String getBankcode() {
		return bankcode;
	}

	public void setBankcode(String bankcode) {
		this.bankcode = bankcode;
	}

	public String getCardcode() {
		return cardcode;
	}

	public void setCardcode(String cardcode) {
		this.cardcode = cardcode;
	}

	public Integer getTerterminalcode() {
		return terterminalcode;
	}

	public void setTerterminalcode(Integer terterminalcode) {
		this.terterminalcode = terterminalcode;
	}

	public Integer getBatchcode() {
		return batchcode;
	}

	public void setBatchcode(Integer batchcode) {
		this.batchcode = batchcode;
	}

	public String getPaydate() {
		return paydate;
	}

	public void setPaydate(String paydate) {
		this.paydate = paydate;
	}

	public Integer getPaytime() {
		return paytime;
	}

	public void setPaytime(Integer paytime) {
		this.paytime = paytime;
	}

	public Integer getAuthorizationcode() {
		return authorizationcode;
	}

	public void setAuthorizationcode(Integer authorizationcode) {
		this.authorizationcode = authorizationcode;
	}

	public Integer getClearingdate() {
		return clearingdate;
	}

	public void setClearingdate(Integer clearingdate) {
		this.clearingdate = clearingdate;
	}

	public Integer getLrc() {
		return lrc;
	}

	public void setLrc(Integer lrc) {
		this.lrc = lrc;
	}

	public Long getDiscounts() {
		return discounts;
	}

	public void setDiscounts(Long discounts) {
		this.discounts = discounts;
	}

	public String getRespcode() {
		return respcode;
	}

	public void setRespcode(String respcode) {
		this.respcode = respcode;
	}

	public Boolean getIsreturnmoney() {
		return isreturnmoney;
	}

	public void setIsreturnmoney(Boolean isreturnmoney) {
		this.isreturnmoney = isreturnmoney;
	}

	public Double getReturnmoneytotal() {
		return returnmoneytotal;
	}

	public void setReturnmoneytotal(Double returnmoneytotal) {
		this.returnmoneytotal = returnmoneytotal;
	}

	public String getPaygateway() {
		return paygateway;
	}

	public void setPaygateway(String paygateway) {
		this.paygateway = paygateway;
	}

	public String getOrderstatus() {
		return orderstatus;
	}

	public void setOrderstatus(String orderstatus) {
		this.orderstatus = orderstatus;
	}

	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

	public String getInsurancestatus() {
		return insurancestatus;
	}

	public void setInsurancestatus(String insurancestatus) {
		this.insurancestatus = insurancestatus;
	}

	public BigDecimal getTickets() {
		return tickets;
	}

	public void setTickets(BigDecimal tickets) {
		this.tickets = tickets;
	}

	public BigDecimal getTicketprice() {
		return ticketprice;
	}

	public void setTicketprice(BigDecimal ticketprice) {
		this.ticketprice = ticketprice;
	}

	public BigDecimal getInsures() {
		return insures;
	}

	public void setInsures(BigDecimal insures) {
		this.insures = insures;
	}

	public BigDecimal getInsurefee() {
		return insurefee;
	}

	public void setInsurefee(BigDecimal insurefee) {
		this.insurefee = insurefee;
	}

	public String getMerchantpayorderno() {
		return merchantpayorderno;
	}

	public void setMerchantpayorderno(String merchantpayorderno) {
		this.merchantpayorderno = merchantpayorderno;
	}

}