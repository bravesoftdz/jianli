package cn.nova.bus.balance.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

import cn.nova.bus.checkticket.model.Departinvoicesdeductdetail;
import cn.nova.bus.system.model.Userinfo;

/**
 * The persistent class for the BALANCE database table.
 * 
 */
@Entity
public class Balance implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name = "BALANCE_ID_GENERATOR", sequenceName = "SEQ_BALANCE", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "BALANCE_ID_GENERATOR")
	private long id;

	private long balancby;

	private String balanceip;

	private BigDecimal balancemoney;

	private String balanceno;

	private String balanceobject;

	@Temporal(TemporalType.TIMESTAMP)
	private Date balancetime;

	@JoinColumn(name = "CANCELBY", nullable = true)
	@ManyToOne(cascade = { CascadeType.REFRESH, CascadeType.PERSIST })
	private Userinfo cancelby;

	private String cancelip;

	@Temporal(TemporalType.TIMESTAMP)
	private Date cleartime;

	private long createby;

	@Temporal(TemporalType.TIMESTAMP)
	private Date createtime;

	private BigDecimal deratemoney;

	private BigDecimal diagentfee;

	private BigDecimal dibalanceablemoney;

	private BigDecimal dibalancemoney;

	private BigDecimal dideductmoney;

	private BigDecimal diotherpredeductifee;

	private long dipersonkilometre;

	private BigDecimal distationservicefee;

	private BigDecimal ditotalmoney;

	private int ditotalnum;

	private BigDecimal fueladditionfee;

	private BigDecimal lastlost;

	private BigDecimal lateforfeit;

	private BigDecimal lost;

	private BigDecimal lostforfeit;

	private long objectid;

	private long orgid;

	private String remarks;

	private BigDecimal returnmoney;

	private String status;

	private long updateby;

	@Temporal(TemporalType.TIMESTAMP)
	private Date updatetime;

	private BigDecimal preupmoney;

	private String vehicleno;

	private long invoicesnum;

	private BigDecimal packmoney;

	private BigDecimal ticketincome;

	private Date departenddate;

	private Date departstartdate;

	private BigDecimal additionfee;

	private Long balancedividevehicleid;

	private BigDecimal divide;

	private BigDecimal packprice;
	
	private BigDecimal rentmoney;
	
	private BigDecimal rentprice;
	
	private BigDecimal debit;
	
	private BigDecimal backmoney;//返还金额
	
	private BigDecimal packamount;//货票金额
	
	private BigDecimal bysj; //本月上交
	
	private BigDecimal syqj;//上月欠交
	
	private BigDecimal goodsagent;//货运代理费
	public BigDecimal getBackmoney() {
		return backmoney;
	}

	public void setBackmoney(BigDecimal backmoney) {
		this.backmoney = backmoney;
	}

	public BigDecimal getDebit() {
		return debit;
	}

	public void setDebit(BigDecimal debit) {
		this.debit = debit;
	}

	
	@Transient
	private BigDecimal agentrate;
	
	public BigDecimal getAgentrate() {
		return agentrate;
	}

	public void setAgentrate(BigDecimal agentrate) {
		this.agentrate = agentrate;
	}

	public BigDecimal getPackprice() {
		return packprice;
	}

	public void setPackprice(BigDecimal packprice) {
		this.packprice = packprice;
	}

	@OneToMany(cascade = { CascadeType.ALL }, fetch = FetchType.LAZY, mappedBy = "balance")
	private List<Balancedeductdetail> balancedeductdetaillist;

	public List<Balancedeductdetail> getBalancedeductdetaillist() {
		return balancedeductdetaillist;
	}

	public void setBalancedeductdetaillist(
			List<Balancedeductdetail> balancedeductdetaillist) {
		this.balancedeductdetaillist = balancedeductdetaillist;
	}

	public Date getDepartenddate() {
		return departenddate;
	}

	public void setDepartenddate(Date departenddate) {
		this.departenddate = departenddate;
	}

	public Date getDepartstartdate() {
		return departstartdate;
	}

	public void setDepartstartdate(Date departstartdate) {
		this.departstartdate = departstartdate;
	}

	public BigDecimal getTicketincome() {
		return ticketincome;
	}

	public void setTicketincome(BigDecimal ticketincome) {
		this.ticketincome = ticketincome;
	}

	public BigDecimal getPackmoney() {
		return packmoney;
	}

	public void setPackmoney(BigDecimal packmoney) {
		this.packmoney = packmoney;
	}

	public long getInvoicesnum() {
		return invoicesnum;
	}

	public void setInvoicesnum(long invoicesnum) {
		this.invoicesnum = invoicesnum;
	}

	public String getVehicleno() {
		return vehicleno;
	}

	public void setVehicleno(String vehicleno) {
		this.vehicleno = vehicleno;
	}

	private String routename;

	public String getRoutename() {
		return routename;
	}

	public void setRoutename(String routename) {
		this.routename = routename;
	}

	@OneToMany(cascade = { CascadeType.ALL }, fetch = FetchType.LAZY, mappedBy = "balance")
	private List<Departinvoicesdeductdetail> Departinvoicesdeductdetails;

	public List<Departinvoicesdeductdetail> getDepartinvoicesdeductdetails() {
		return Departinvoicesdeductdetails;
	}

	public void setDepartinvoicesdeductdetails(
			List<Departinvoicesdeductdetail> departinvoicesdeductdetails) {
		Departinvoicesdeductdetails = departinvoicesdeductdetails;
	}

	private BigDecimal vipscoremoney;

	public Balance() {
	}

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public long getBalancby() {
		return this.balancby;
	}

	public void setBalancby(long balancby) {
		this.balancby = balancby;
	}

	public String getBalanceip() {
		return this.balanceip;
	}

	public void setBalanceip(String balanceip) {
		this.balanceip = balanceip;
	}

	public BigDecimal getBalancemoney() {
		return this.balancemoney;
	}

	public void setBalancemoney(BigDecimal balancemoney) {
		this.balancemoney = balancemoney;
	}

	public String getBalanceno() {
		return this.balanceno;
	}

	public void setBalanceno(String balanceno) {
		this.balanceno = balanceno;
	}

	public String getBalanceobject() {
		return this.balanceobject;
	}

	public void setBalanceobject(String balanceobject) {
		this.balanceobject = balanceobject;
	}

	public Date getBalancetime() {
		return this.balancetime;
	}

	public void setBalancetime(Date balancetime) {
		this.balancetime = balancetime;
	}

	public Userinfo getCancelby() {
		return this.cancelby;
	}

	public void setCancelby(Userinfo cancelby) {
		this.cancelby = cancelby;
	}

	public String getCancelip() {
		return this.cancelip;
	}

	public void setCancelip(String cancelip) {
		this.cancelip = cancelip;
	}

	public Date getCleartime() {
		return this.cleartime;
	}

	public void setCleartime(Date cleartime) {
		this.cleartime = cleartime;
	}

	public long getCreateby() {
		return this.createby;
	}

	public void setCreateby(long createby) {
		this.createby = createby;
	}

	public Date getCreatetime() {
		return this.createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	public BigDecimal getDeratemoney() {
		return this.deratemoney;
	}

	public void setDeratemoney(BigDecimal deratemoney) {
		this.deratemoney = deratemoney;
	}

	public BigDecimal getDiagentfee() {
		return this.diagentfee;
	}

	public void setDiagentfee(BigDecimal diagentfee) {
		this.diagentfee = diagentfee;
	}

	public BigDecimal getDibalanceablemoney() {
		return this.dibalanceablemoney;
	}

	public void setDibalanceablemoney(BigDecimal dibalanceablemoney) {
		this.dibalanceablemoney = dibalanceablemoney;
	}

	public BigDecimal getDibalancemoney() {
		return this.dibalancemoney;
	}

	public void setDibalancemoney(BigDecimal dibalancemoney) {
		this.dibalancemoney = dibalancemoney;
	}

	public BigDecimal getDideductmoney() {
		return this.dideductmoney;
	}

	public void setDideductmoney(BigDecimal dideductmoney) {
		this.dideductmoney = dideductmoney;
	}

	public BigDecimal getDiotherpredeductifee() {
		return this.diotherpredeductifee;
	}

	public void setDiotherpredeductifee(BigDecimal diotherpredeductifee) {
		this.diotherpredeductifee = diotherpredeductifee;
	}

	public long getDipersonkilometre() {
		return this.dipersonkilometre;
	}

	public void setDipersonkilometre(long dipersonkilometre) {
		this.dipersonkilometre = dipersonkilometre;
	}

	public BigDecimal getDistationservicefee() {
		return this.distationservicefee;
	}

	public void setDistationservicefee(BigDecimal distationservicefee) {
		this.distationservicefee = distationservicefee;
	}

	public BigDecimal getDitotalmoney() {
		return this.ditotalmoney;
	}

	public void setDitotalmoney(BigDecimal ditotalmoney) {
		this.ditotalmoney = ditotalmoney;
	}

	public int getDitotalnum() {
		return this.ditotalnum;
	}

	public void setDitotalnum(int ditotalnum) {
		this.ditotalnum = ditotalnum;
	}

	public BigDecimal getFueladditionfee() {
		return this.fueladditionfee;
	}

	public void setFueladditionfee(BigDecimal fueladditionfee) {
		this.fueladditionfee = fueladditionfee;
	}

	public BigDecimal getLastlost() {
		return this.lastlost;
	}

	public void setLastlost(BigDecimal lastlost) {
		this.lastlost = lastlost;
	}

	public BigDecimal getLateforfeit() {
		return this.lateforfeit;
	}

	public void setLateforfeit(BigDecimal lateforfeit) {
		this.lateforfeit = lateforfeit;
	}

	public BigDecimal getLost() {
		return this.lost;
	}

	public void setLost(BigDecimal lost) {
		this.lost = lost;
	}

	public BigDecimal getLostforfeit() {
		return this.lostforfeit;
	}

	public void setLostforfeit(BigDecimal lostforfeit) {
		this.lostforfeit = lostforfeit;
	}

	public long getObjectid() {
		return this.objectid;
	}

	public void setObjectid(long objectid) {
		this.objectid = objectid;
	}

	public long getOrgid() {
		return this.orgid;
	}

	public void setOrgid(long orgid) {
		this.orgid = orgid;
	}

	public String getRemarks() {
		return this.remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public BigDecimal getReturnmoney() {
		return this.returnmoney;
	}

	public void setReturnmoney(BigDecimal returnmoney) {
		this.returnmoney = returnmoney;
	}

	public String getStatus() {
		return this.status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public long getUpdateby() {
		return this.updateby;
	}

	public void setUpdateby(long updateby) {
		this.updateby = updateby;
	}

	public Date getUpdatetime() {
		return this.updatetime;
	}

	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}

	public BigDecimal getVipscoremoney() {
		return this.vipscoremoney;
	}

	public void setVipscoremoney(BigDecimal vipscoremoney) {
		this.vipscoremoney = vipscoremoney;
	}

	public BigDecimal getPreupmoney() {
		return preupmoney;
	}

	public void setPreupmoney(BigDecimal preupmoney) {
		this.preupmoney = preupmoney;
	}

	public BigDecimal getAdditionfee() {
		return additionfee;
	}

	public void setAdditionfee(BigDecimal additionfee) {
		this.additionfee = additionfee;
	}


	public Long getBalancedividevehicleid() {
		return balancedividevehicleid;
	}

	public void setBalancedividevehicleid(Long balancedividevehicleid) {
		this.balancedividevehicleid = balancedividevehicleid;
	}

	public BigDecimal getDivide() {
		return divide;
	}

	public void setDivide(BigDecimal divide) {
		this.divide = divide;
	}
	public BigDecimal getRentmoney() {
		return rentmoney;
	}

	public void setRentmoney(BigDecimal rentmoney) {
		this.rentmoney = rentmoney;
	}

	public BigDecimal getRentprice() {
		return rentprice;
	}

	public void setRentprice(BigDecimal rentprice) {
		this.rentprice = rentprice;
	}

	public BigDecimal getBysj() {
		return bysj;
	}

	public void setBysj(BigDecimal bysj) {
		this.bysj = bysj;
	}

	public BigDecimal getSyqj() {
		return syqj;
	}

	public void setSyqj(BigDecimal syqj) {
		this.syqj = syqj;
	}

	public BigDecimal getGoodsagent() {
		return goodsagent;
	}

	public void setGoodsagent(BigDecimal goodsagent) {
		this.goodsagent = goodsagent;
	}

	public BigDecimal getPackamount() {
		return packamount;
	}

	public void setPackamount(BigDecimal packamount) {
		this.packamount = packamount;
	}
	
}