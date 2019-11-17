package cn.nova.bus.sale.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

import cn.nova.bus.bill.model.Billtype;


/**
 * <b>类名称：</b>TICKETPRICERETURN <br/>
 * <b>类描述：</b>网售自助机退款表<br/>
 * <b>创建人：</b>tianhb<br/>
 * <b>修改人：</b><br/>
 * <b>修改时间：</b>2018年6月12日 下午3:38:39<br/>
 * <b>修改备注：</b><br/>
 * <b>版本信息：</b>v1.0.0<br/>
 * <b>任务号：</b>2018年6月12日 下午3:38:39<br/>
 */
@Entity
@Table(name="TICKETPRICERETURN")
public class TicketpriceReturn implements Serializable {
	
	private static final long serialVersionUID = 1256656151L;	

	@Id
	@SequenceGenerator(name="TICKETPRICERETURN_ID_GENERATOR", sequenceName="SEQ_TICKETPRICERETURN",allocationSize=1)
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="TICKETPRICERETURN_ID_GENERATOR")
	@Column(unique=true, nullable=false, precision=10)
	private Long id;
	
	private Long sellid;//售票ID
	
	private String sellorgcode;//代售机构编码
	
	private String sellorgname;//代售机构名称
	
	private String netticketid;//电子票 ETICKETID
	
	private String orderno;//订单号
	
	private BigDecimal ticketprice;//票价
	
	private BigDecimal rate;//退票费率
	
	private BigDecimal charges;//手续费
	
	private BigDecimal insurefee;//退还旅客保险金额
	
	private BigDecimal returnamount;//退还旅客车票金额
	
	private Long billtypeid;//票据ID
	
	private Long returnby;//退款人
	
	@Temporal(TemporalType.TIMESTAMP)
	@Column(nullable = false)
	private Date returntime;//退款时间
	
	private Long ticketoutletsid;//退款点
	
	private String remarks;//备注
	
	private String returnip;//IP
	
	private String returnvoucherno;//退票凭证

	@Column(nullable = false, precision = 10)
	private Long createby;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(nullable = false)
	private Date createtime;
	
	@Column(nullable = false, precision = 10)
	private Long updateby;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(nullable = false)
	private Date updatetime;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Long getSellid() {
		return sellid;
	}

	public void setSellid(Long sellid) {
		this.sellid = sellid;
	}

	public String getSellorgcode() {
		return sellorgcode;
	}

	public void setSellorgcode(String sellorgcode) {
		this.sellorgcode = sellorgcode;
	}

	public String getSellorgname() {
		return sellorgname;
	}

	public void setSellorgname(String sellorgname) {
		this.sellorgname = sellorgname;
	}

	public String getNetticketid() {
		return netticketid;
	}

	public void setNetticketid(String netticketid) {
		this.netticketid = netticketid;
	}

	public BigDecimal getTicketprice() {
		return ticketprice;
	}

	public void setTicketprice(BigDecimal ticketprice) {
		this.ticketprice = ticketprice;
	}

	public BigDecimal getRate() {
		return rate;
	}

	public void setRate(BigDecimal rate) {
		this.rate = rate;
	}

	public BigDecimal getCharges() {
		return charges;
	}

	public void setCharges(BigDecimal charges) {
		this.charges = charges;
	}

	public BigDecimal getInsurefee() {
		return insurefee;
	}

	public void setInsurefee(BigDecimal insurefee) {
		this.insurefee = insurefee;
	}

	public BigDecimal getReturnamount() {
		return returnamount;
	}

	public void setReturnamount(BigDecimal returnamount) {
		this.returnamount = returnamount;
	}

	public Long getBilltypeid() {
		return billtypeid;
	}

	public void setBilltypeid(Long billtypeid) {
		this.billtypeid = billtypeid;
	}

	public Long getReturnby() {
		return returnby;
	}

	public void setReturnby(Long returnby) {
		this.returnby = returnby;
	}

	public Date getReturntime() {
		return returntime;
	}

	public void setReturntime(Date returntime) {
		this.returntime = returntime;
	}

	public Long getTicketoutletsid() {
		return ticketoutletsid;
	}

	public void setTicketoutletsid(Long ticketoutletsid) {
		this.ticketoutletsid = ticketoutletsid;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public Long getCreateby() {
		return createby;
	}

	public void setCreateby(Long createby) {
		this.createby = createby;
	}

	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	public Long getUpdateby() {
		return updateby;
	}

	public void setUpdateby(Long updateby) {
		this.updateby = updateby;
	}

	public Date getUpdatetime() {
		return updatetime;
	}

	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}

	public String getOrderno() {
		return orderno;
	}

	public void setOrderno(String orderno) {
		this.orderno = orderno;
	}

	public String getReturnip() {
		return returnip;
	}

	public void setReturnip(String returnip) {
		this.returnip = returnip;
	}

	public String getReturnvoucherno() {
		return returnvoucherno;
	}

	public void setReturnvoucherno(String returnvoucherno) {
		this.returnvoucherno = returnvoucherno;
	}
	
	 
}