package cn.nova.bus.pack.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EntityListeners;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import cn.nova.utils.orm.listener.AuditLogListener;
import cn.nova.utils.orm.listener.SyncCodeGenerate;

@Entity
@Table(name = "PACK")
@EntityListeners({ SyncCodeGenerate.class, AuditLogListener.class })
public class Pack implements Serializable, Cloneable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name = "PACK_ID_GENERATOR", sequenceName = "SEQ_PUB", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "PACK_ID_GENERATOR")
	@Column(unique = true, nullable = false, precision = 6)
	private long id;// ;//number(10) n

	private String packtype;// ;//varchar2(10) y 行包类型（0：发货，1：到货
	private String goodtype;// 货物类别
	private long sendstationid;// number(10) y 发货站
	private long tostationid;// number(10) n 目的地
	private String name;// varchar2(50) n 货物名称
	private Long scheduleid;// number(10) y 班次
	private Long vehicleid;// number(10) n 车牌号

	@Temporal(TemporalType.DATE)
	private Date departdate;// date ;//date y 发货、到货日期

	private String packno;// varchar2(20) y 行包单号
	private String invoiceno;// varchar2(20) y 发票号
	private long sellby;// number(10) y 办理员
	private short pieces;// number(3) y 件数
	@Column(precision = 10, scale = 2)
	private BigDecimal weight;// number(10,2) y 重量
	private String volume;// varchar2(20) y 体积
	private String packed;// varchar2(10) y 包装（纸箱、塑料袋、无）

	@Column(nullable = true, precision = 6, scale = 2)
	private BigDecimal shipprice;// number(6,2) y 托运费

	@Column(precision = 6, scale = 2)
	private BigDecimal packfee;// number(6,2) y 包装费

	@Column(nullable = true, precision = 6, scale = 2)
	private BigDecimal handfee;// number(6,2) y 发货装卸费

	@Column(nullable = true, precision = 6, scale = 2)
	private BigDecimal unloadfee;// number(6,2) y 到货装卸费
	  
	@Column(nullable = true, precision = 6, scale = 2)
	private BigDecimal custodial;// number(6,2) y 保管费

	@Column(nullable = true, precision = 6, scale = 2)
	private BigDecimal transitfee;// number(6,2) y 中转费

	@Column(nullable = true, precision = 8, scale = 2)
	private BigDecimal insuredamount;// number(8,2) y 保价金额

	@Column(nullable = true, precision = 6, scale = 2)
	private BigDecimal insurancefee;// number(6,2) y 保价费

	@Column(nullable = true, precision = 6, scale = 2)
	private BigDecimal deliveryfee;// 送货费

	@Column(nullable = true, precision = 6, scale = 2)
	private BigDecimal insurance;// number(6,2) y 保险费
	@Column(nullable = true, precision = 6, scale = 2)
	private BigDecimal servicefee;// number(6,2) y 保险费

	@Column(nullable = true, precision = 6, scale = 2)
	private BigDecimal otherfee;// number(6,2) y 其他费用

	@Column(nullable = true, precision = 6, scale = 2)
	private BigDecimal totalfee;// number(6,2) y 合计金额

	private String location;// varchar2(60) y 存放位置

	@Column(nullable = true, precision = 8, scale = 2)
	private BigDecimal packprice;// number(8,2) y 代收货款

	private String sender;// varchar2(30) y 托运人
	private String senderphone;// varchar2(20) y 托运人电话
	private String senderaddress;// varchar2(100) y 托运人地址
	private String consignee;// varchar2(30) y 收货人
	private String consigneephone;// varchar2(20) y 收货人电话
	private String consigneeaddress;// varchar2(100) y 收货人地址
	private String certificatetype;// varchar2(10) y
									// 证件类型：0：身份证，1：学生证，2：军官证，3：教师证 取数据字典
	private String certificateno;// varchar2(30) y 证件号码
	private String shiptype;// varchar2(10) y 托运方式（随车自提、收获人提领）取数据字典
	private String paymethod;// varchar2(10) y 付款方式（现付、提付）取数据字典
	private boolean valuables;// number(1) y 是否贵重物品
	private String status;// varchar2(10) y 状态(0：库存、1：签发、2：提领、3：作废)
	private BigDecimal integraterprice;//抵扣积分金额
	
	private Long packtturnoverid;// number(10) y 缴款id
	
	private String remak;// varchar2(150) y 备注
	
	
	private String takename;
	


	private String takecertificateno;
	
	
	
//	@SyncField(foreignClass=Organization.class)
	private long orgid;// number(10) y
	
	private Long signby;//number(10) y签发/提领人
	private String recyclestatus;	// 对付款回收状态  0未对付1已对付
	private String collectstatus;	//0未结算 1已结算 2已回收

	private Long collectbalanceid;
	private Long collectby;
	private Date collectdate;
	private BigDecimal collectmoney;
	
	private Long recycleby;
	private Date recycledate;
	private String goodsstatus;	//货物状态: 0 完好，1破损，2打湿  取数据字典   李电志 2015年5月14日 11:13:39
	private String balancestatus;//结算状态：0未结算 1已结算         李电志 2015年5月20日 15:36:32


	private Long vehiclereportid;
	private String entrypacker; //到货入仓操作员
	
	private Long departinvoicesid;// number(10)
	private String sendercertificatetype;// varchar2(10)  
	                                     // 托运人证件类型：0：身份证，1：学生证，2：军官证，3：教师证 取数据字典
    private String sendercertificateno;// varchar2(30)  托运人证件号码
	
	public Long getDepartinvoicesid() {
		return departinvoicesid;
	}

	public void setDepartinvoicesid(Long departinvoicesid) {
		this.departinvoicesid = departinvoicesid;
	}
	
	public Long getVehiclereportid() {
		return vehiclereportid;
	}

	public void setVehiclereportid(Long vehiclereportid) {
		this.vehiclereportid = vehiclereportid;
	}

	public String getTakename() {
		return takename;
	}

	public void setTakename(String takename) {
		this.takename = takename;
	}

	public String getTakecertificateno() {
		return takecertificateno;
	}

	public void setTakecertificateno(String takecertificateno) {
		this.takecertificateno = takecertificateno;
	}
	
	public BigDecimal getIntegraterprice() {
		return integraterprice;
	}

	public void setIntegraterprice(BigDecimal integraterprice) {
		this.integraterprice = integraterprice;
	}

	@Temporal(TemporalType.TIMESTAMP)
	private Date signtime;//date 签发/提领时间

	@Temporal(TemporalType.TIMESTAMP)
	private Date createtime;// date n sys;//date

	@Column(nullable=false)
	
	private Long createby;// number(10) n

	@Temporal(TemporalType.TIMESTAMP)
	private Date updatetime;// date n sys;//date

	@Column(nullable=false)
	
	private Long updateby;// number(10) n

	private String onlycode;
	
	@Column(nullable = false, length = 40)
	private String synccode;

	private Long clientid;
	
	
	private Long  balanceid;
	
	private Long  balanceorgid;
	
	private Long  balanceby;
	
	private Date  balancedate;
	
	private String singbillno;
	
	private Long zhuanyuntostationid;
	
	private BigDecimal agentfee;
	
	public Pack() {
		// TODO Auto-generated constructor stub
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getPacktype() {
		return packtype;
	}

	public void setPacktype(String packtype) {
		this.packtype = packtype;
	}

	public String getGoodtype() {
		return goodtype;
	}

	public void setGoodtype(String goodtype) {
		this.goodtype = goodtype;
	}

	public long getSendstationid() {
		return sendstationid;
	}

	public void setSendstationid(long sendstationid) {
		this.sendstationid = sendstationid;
	}

	public long getTostationid() {
		return tostationid;
	}

	public void setTostationid(long tostationid) {
		this.tostationid = tostationid;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Long getScheduleid() {
		return scheduleid;
	}

	public void setScheduleid(Long scheduleid) {
		this.scheduleid = scheduleid;
	}

	public Long getVehicleid() {
		return vehicleid;
	}

	public void setVehicleid(Long vehicleid) {
		this.vehicleid = vehicleid;
	}

	public Date getDepartdate() {
		return departdate;
	}

	public void setDepartdate(Date departdate) {
		this.departdate = departdate;
	}

	public String getPackno() {
		return packno;
	}

	public void setPackno(String packno) {
		this.packno = packno;
	}

	public String getInvoiceno() {
		return invoiceno;
	}

	public void setInvoiceno(String invoiceno) {
		this.invoiceno = invoiceno;
	}

	public long getSellby() {
		return sellby;
	}

	public void setSellby(long sellby) {
		this.sellby = sellby;
	}

	public short getPieces() {
		return pieces;
	}

	public void setPieces(short pieces) {
		this.pieces = pieces;
	}

	public BigDecimal getWeight() {
		return weight;
	}

	public void setWeight(BigDecimal weight) {
		this.weight = weight;
	}

	public String getVolume() {
		return volume;
	}

	public void setVolume(String volume) {
		this.volume = volume;
	}

	public String getPacked() {
		return packed;
	}

	public void setPacked(String packed) {
		this.packed = packed;
	}

	public BigDecimal getShipprice() {
		return shipprice;
	}

	public void setShipprice(BigDecimal shipprice) {
		this.shipprice = shipprice;
	}

	public BigDecimal getPackfee() {
		return packfee;
	}

	public void setPackfee(BigDecimal packfee) {
		this.packfee = packfee;
	}

	public BigDecimal getHandfee() {
		return handfee;
	}

	public void setHandfee(BigDecimal handfee) {
		this.handfee = handfee;
	}

	
	public BigDecimal getUnloadfee() {
		return unloadfee;
	}

	public void setUnloadfee(BigDecimal unloadfee) {
		this.unloadfee = unloadfee;
	}

	public BigDecimal getCustodial() {
		return custodial;
	}

	public void setCustodial(BigDecimal custodial) {
		this.custodial = custodial;
	}

	public BigDecimal getTransitfee() {
		return transitfee;
	}

	public void setTransitfee(BigDecimal transitfee) {
		this.transitfee = transitfee;
	}

	public BigDecimal getInsuredamount() {
		return insuredamount;
	}

	public void setInsuredamount(BigDecimal insuredamount) {
		this.insuredamount = insuredamount;
	}

	public BigDecimal getInsurancefee() {
		return insurancefee;
	}

	public void setInsurancefee(BigDecimal insurancefee) {
		this.insurancefee = insurancefee;
	}

	public BigDecimal getDeliveryfee() {
		return deliveryfee;
	}

	public void setDeliveryfee(BigDecimal deliveryfee) {
		this.deliveryfee = deliveryfee;
	}

	public BigDecimal getInsurance() {
		return insurance;
	}

	public void setInsurance(BigDecimal insurance) {
		this.insurance = insurance;
	}

	public BigDecimal getOtherfee() {
		return otherfee;
	}

	public void setOtherfee(BigDecimal otherfee) {
		this.otherfee = otherfee;
	}

	public BigDecimal getTotalfee() {
		return totalfee;
	}

	public void setTotalfee(BigDecimal totalfee) {
		this.totalfee = totalfee;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public BigDecimal getPackprice() {
		return packprice;
	}

	public void setPackprice(BigDecimal packprice) {
		this.packprice = packprice;
	}

	public String getSender() {
		return sender;
	}

	public void setSender(String sender) {
		this.sender = sender;
	}

	public String getSenderphone() {
		return senderphone;
	}

	public void setSenderphone(String senderphone) {
		this.senderphone = senderphone;
	}

	public String getSenderaddress() {
		return senderaddress;
	}

	public void setSenderaddress(String senderaddress) {
		this.senderaddress = senderaddress;
	}

	public String getConsignee() {
		return consignee;
	}

	public void setConsignee(String consignee) {
		this.consignee = consignee;
	}

	public String getConsigneephone() {
		return consigneephone;
	}

	public void setConsigneephone(String consigneephone) {
		this.consigneephone = consigneephone;
	}

	public String getConsigneeaddress() {
		return consigneeaddress;
	}

	public void setConsigneeaddress(String consigneeaddress) {
		this.consigneeaddress = consigneeaddress;
	}

	public String getCertificatetype() {
		return certificatetype;
	}

	public void setCertificatetype(String certificatetype) {
		this.certificatetype = certificatetype;
	}

	public String getCertificateno() {
		return certificateno;
	}

	public void setCertificateno(String certificateno) {
		this.certificateno = certificateno;
	}

	public String getShiptype() {
		return shiptype;
	}

	public void setShiptype(String shiptype) {
		this.shiptype = shiptype;
	}

	public String getPaymethod() {
		return paymethod;
	}

	public void setPaymethod(String paymethod) {
		this.paymethod = paymethod;
	}

	public boolean isValuables() {
		return valuables;
	}

	public void setValuables(boolean valuables) {
		this.valuables = valuables;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Long getPacktturnoverid() {
		return packtturnoverid;
	}

	public void setPacktturnoverid(Long packtturnoverid) {
		this.packtturnoverid = packtturnoverid;
	}

	public String getRemak() {
		return remak;
	}

	public void setRemak(String remak) {
		this.remak = remak;
	}

	public long getOrgid() {
		return orgid;
	}

	public void setOrgid(long orgid) {
		this.orgid = orgid;
	}

	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	public Long getCreateby() {
		return createby;
	}

	public void setCreateby(Long createby) {
		this.createby = createby;
	}

	public Date getUpdatetime() {
		return updatetime;
	}

	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}

	public Long getUpdateby() {
		return updateby;
	}

	public void setUpdateby(Long updateby) {
		this.updateby = updateby;
	}

	public Long getSignby() {
		return signby;
	}

	public void setSignby(Long signby) {
		this.signby = signby;
	}

	public Date getSigntime() {
		return signtime;
	}

	public void setSigntime(Date signtime) {
		this.signtime = signtime;
	}
	
	public String getOnlycode() {
		return onlycode;
	}

	public void setOnlycode(String onlycode) {
		this.onlycode = onlycode;
	}

	public String getSynccode() {
		return synccode;
	}

	public void setSynccode(String synccode) {
		this.synccode = synccode;
	}

	public Long getClientid() {
		return clientid;
	}

	public void setClientid(Long clientid) {
		this.clientid = clientid;
	}

	@Override
	public Object clone() {
		Object o = null;
		try {
			o = super.clone();
		} catch (CloneNotSupportedException e) {
			// TODO Auto-generated catch block
			play.Logger.error(e.getMessage(), e);
		}
		return o;
	}
	public Long getBalanceid() {
		return balanceid;
	}

	public void setBalanceid(Long balanceid) {
		this.balanceid = balanceid;
	}

	public Long getBalanceorgid() {
		return balanceorgid;
	}

	public void setBalanceorgid(Long balanceorgid) {
		this.balanceorgid = balanceorgid;
	}

	public Long getBalanceby() {
		return balanceby;
	}

	public void setBalanceby(Long balanceby) {
		this.balanceby = balanceby;
	}

	public Date getBalancedate() {
		return balancedate;
	}

	public void setBalancedate(Date balancedate) {
		this.balancedate = balancedate;
	}

	public BigDecimal getServicefee() {
		return servicefee;
	}

	public void setServicefee(BigDecimal servicefee) {
		this.servicefee = servicefee;
	}

	public String getSingbillno() {
		return singbillno;
	}

	public void setSingbillno(String singbillno) {
		this.singbillno = singbillno;
	}

	public Long getZhuanyuntostationid() {
		return zhuanyuntostationid;
	}

	public void setZhuanyuntostationid(Long zhuanyuntostationid) {
		this.zhuanyuntostationid = zhuanyuntostationid;
	}

	public String getCollectstatus() {
		return collectstatus;
	}

	public void setCollectstatus(String collectstatus) {
		this.collectstatus = collectstatus;
	}

	public Long getCollectbalanceid() {
		return collectbalanceid;
	}

	public void setCollectbalanceid(Long collectbalanceid) {
		this.collectbalanceid = collectbalanceid;
	}

	public Long getCollectby() {
		return collectby;
	}

	public void setCollectby(Long collectby) {
		this.collectby = collectby;
	}

	public Date getCollectdate() {
		return collectdate;
	}

	public void setCollectdate(Date collectdate) {
		this.collectdate = collectdate;
	}

	public BigDecimal getCollectmoney() {
		return collectmoney;
	}

	public void setCollectmoney(BigDecimal collectmoney) {
		this.collectmoney = collectmoney;
	}

	public Long getRecycleby() {
		return recycleby;
	}

	public void setRecycleby(Long recycleby) {
		this.recycleby = recycleby;
	}

	public Date getRecycledate() {
		return recycledate;
	}

	public void setRecycledate(Date recycledate) {
		this.recycledate = recycledate;
	}

	public String getRecyclestatus() {
		return recyclestatus;
	}

	public void setRecyclestatus(String recyclestatus) {
		this.recyclestatus = recyclestatus;
	}
	
	public String getGoodsstatus() {
		return goodsstatus;
	}

	public void setGoodsstatus(String goodsstatus) {
		this.goodsstatus = goodsstatus;
	}
	
	public String getBalancestatus() {
		return balancestatus;
	}

	public void setBalancestatus(String balancestatus) {
		this.balancestatus = balancestatus;
	}

	public String getEntrypacker() {
		return entrypacker;
	}

	public void setEntrypacker(String entrypacker) {
		this.entrypacker = entrypacker;
	}

	public BigDecimal getAgentfee() {
		return agentfee;
	}

	public void setAgentfee(BigDecimal agentfee) {
		this.agentfee = agentfee;
	}

	public String getSendercertificatetype() {
		return sendercertificatetype;
	}

	public void setSendercertificatetype(String sendercertificatetype) {
		this.sendercertificatetype = sendercertificatetype;
	}

	public String getSendercertificateno() {
		return sendercertificateno;
	}

	public void setSendercertificateno(String sendercertificateno) {
		this.sendercertificateno = sendercertificateno;
	}
	

	
	
	
	
}
