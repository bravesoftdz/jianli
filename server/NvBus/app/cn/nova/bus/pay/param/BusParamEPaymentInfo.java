/**
 * 
 */
package cn.nova.bus.pay.param;

import java.math.BigDecimal;
import java.util.List;

import cn.nova.bus.security.Global;
/**
 *	电子支付参数类
 */
public class BusParamEPaymentInfo {

	private static final long serialVersionUID = -8326667493922283590L;
	private String version;//版本 暂时没有 
	private String gateway;//1 支付宝 2微信
	private String orderno; //站务订单
	private String payorderno;//商户订单号(需要获取)
	private BigDecimal totalprice;//本次需要支付的金额
	private String payCode;//支付码 暂时不支持 非支付宝,微信的的支付方式
	private Long  payuserby;//收款人id
	private String payipby; //收款IP
	private Long orgid;//机构
	private String orgname; //机构名称
	private Integer tickets;//车票张数
	private BigDecimal ticketprice;//车票金额
	private Integer insures;//保险张数
	private BigDecimal insurefee;//保险金额
	private String paymethod;//支付方式
	private Global global;//
	private List<BusScheduleInfo> scinfo;//班次信息
	private List<BusRider> rider;//乘客
	private boolean bookticketsuccess;//出票是否成功 退款用
	private BigDecimal refundmoney;//退款
	private long payinfoid;
	private String  ids;// detailids
	
	public String getVersion() {
		return version;
	}
	public void setVersion(String version) {
		this.version = version;
	}
	public String getOrderno() {
		return orderno;
	}
	public void setOrderno(String orderno) {
		this.orderno = orderno;
	}
	public String getGateway() {
		return gateway;
	}
	public void setGateway(String gateway) {
		this.gateway = gateway;
	}
	public String getPayorderno() {
		return payorderno;
	}
	public void setPayorderno(String payorderno) {
		this.payorderno = payorderno;
	}
	public BigDecimal getTotalprice() {
		return totalprice;
	}
	public void setTotalprice(BigDecimal totalprice) {
		this.totalprice = totalprice;
	}
	public String getPayCode() {
		return payCode;
	}
	public void setPayCode(String payCode) {
		this.payCode = payCode;
	}
	public Long getPayuserby() {
		return payuserby;
	}
	public void setPayuserby(Long payuserby) {
		this.payuserby = payuserby;
	}
	public String getPayipby() {
		return payipby;
	}
	public void setPayipby(String payipby) {
		this.payipby = payipby;
	}
	public Integer getTickets() {
		return tickets;
	}
	public void setTickets(Integer tickets) {
		this.tickets = tickets;
	}
	public BigDecimal getTicketprice() {
		return ticketprice;
	}
	public void setTicketprice(BigDecimal ticketprice) {
		this.ticketprice = ticketprice;
	}
	public Integer getInsures() {
		return insures;
	}
	public void setInsures(Integer insures) {
		this.insures = insures;
	}
	public BigDecimal getInsurefee() {
		return insurefee;
	}
	public void setInsurefee(BigDecimal insurefee) {
		this.insurefee = insurefee;
	}
	public Long getOrgid() {
		return orgid;
	}
	public void setOrgid(Long orgid) {
		this.orgid = orgid;
	}
	public String getPaymethod() {
		return paymethod;
	}
	public void setPaymethod(String paymethod) {
		this.paymethod = paymethod;
	}
	public String getOrgname() {
		return orgname;
	}
	public void setOrgname(String orgname) {
		this.orgname = orgname;
	}

	public List<BusScheduleInfo> getScinfo() {
		return scinfo;
	}
	public void setScinfo(List<BusScheduleInfo> scinfo) {
		this.scinfo = scinfo;
	}
	public List<BusRider> getRider() {
		return rider;
	}
	public void setRider(List<BusRider> rider) {
		this.rider = rider;
	}
	public Global getGlobal() {
		return global;
	}
	public void setGlobal(Global global) {
		this.global = global;
	}
	public BigDecimal getRefundmoney() {
		return refundmoney;
	}
	public void setRefundmoney(BigDecimal refundmoney) {
		this.refundmoney = refundmoney;
	}
	public boolean isBookticketsuccess() {
		return bookticketsuccess;
	}
	public void setBookticketsuccess(boolean bookticketsuccess) {
		this.bookticketsuccess = bookticketsuccess;
	}
	public long getPayinfoid() {
		return payinfoid;
	}
	public void setPayinfoid(long payinfoid) {
		this.payinfoid = payinfoid;
	}
	public String getIds() {
		return ids;
	}
	public void setIds(String ids) {
		this.ids = ids;
	}
	
}
