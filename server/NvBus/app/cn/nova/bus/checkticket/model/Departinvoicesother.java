package cn.nova.bus.checkticket.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

import cn.nova.bus.archive.model.Driver;
import cn.nova.bus.archive.model.Steward;
import cn.nova.bus.balance.model.Balance;
import cn.nova.bus.base.model.Schedule;
import cn.nova.bus.base.model.Station;

/**
 * The persistent class for the DEPARTINVOICESOTHER database table.
 * 
 */
@Entity
public class Departinvoicesother implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name = "DEPARTINVOICESOTHER_ID_GENERATOR", sequenceName = "SEQ_DEPARTINVOICES",allocationSize=1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "DEPARTINVOICESOTHER_ID_GENERATOR")
	private long id;

	private BigDecimal agentfee;

	private Long balanceby;

	@Temporal(TemporalType.DATE)
	private Date balancedate;

	@JoinColumn(name = "BALANCEID", nullable = true)
	@OneToOne
	private Balance balance;

	private BigDecimal balancemoney;

	@JoinColumn(name = "BALANCESTATIONID", nullable = true)
	@OneToOne
	private Station balancestation;

	private Long createby;

	@Temporal(TemporalType.TIMESTAMP)
	private Date createtime;

	@Temporal(TemporalType.DATE)
	private Date departdate;

	private String departinvoicesno;

	private Long departstationid;

	private String departtime;

	@JoinColumn(name = "DRIVER1ID", nullable = true)
	@OneToOne
	private Driver driver1;

	@JoinColumn(name = "DRIVER2ID", nullable = true)
	@OneToOne
	private Driver driver2;

	@JoinColumn(name = "DRIVER3ID", nullable = true)
	@OneToOne
	private Driver driver3;

	@JoinColumn(name = "DRIVER4ID", nullable = true)
	@OneToOne
	private Driver driver4;

	private boolean isoriginator;

	private boolean isreturntrip;

	private Long orgid;

	private String recordip;

	@JoinColumn(name = "SCHEDULEID", nullable = true)
	@OneToOne
	private Schedule schedule;

	@Temporal(TemporalType.DATE)
	private Date selfdepartdate;

	private BigDecimal stationfee;

	private String status;

	@JoinColumn(name = "STEWARD1ID", nullable = true)
	@OneToOne
	private Steward steward1;

	@JoinColumn(name = "STEWARD2ID", nullable = true)
	@OneToOne
	private Steward steward2;

	private long ticketnum;

	private BigDecimal totalmoney;

	private Long updateby;
	
	private String datafrom;


	@Temporal(TemporalType.TIMESTAMP)
	private Date updatetime;

	private Long vehicleid;
	
	private long balanceunitid;
	
	private Long seller;
	
	@Transient
	private Long reachstationid;
	
	@Transient
	private Long departinvoicesotherdetailid;
	
	@Transient
	private BigDecimal price;
	
	@Transient
	private Long tickettypeid;
	
	@Transient
	private BigDecimal balanceprice;
	
	@Transient
	private boolean isdeleteticket;

	public boolean isIsdeleteticket() {
		return isdeleteticket;
	}

	public void setIsdeleteticket(boolean isdeleteticket) {
		this.isdeleteticket = isdeleteticket;
	}

	private BigDecimal othterfee;
	
	private Integer pieces;
	
	public BigDecimal getOthterfee() {
		return othterfee;
	}

	public void setOthterfee(BigDecimal othterfee) {
		this.othterfee = othterfee;
	}

	public BigDecimal getBalanceprice() {
		return balanceprice;
	}

	public void setBalanceprice(BigDecimal balanceprice) {
		this.balanceprice = balanceprice;
	}

	public Long getTickettypeid() {
		return tickettypeid;
	}

	public void setTickettypeid(Long tickettypeid) {
		this.tickettypeid = tickettypeid;
	}

	public BigDecimal getPrice() {
		return price;
	}

	public void setPrice(BigDecimal price) {
		this.price = price;
	}

	public Long getDepartinvoicesotherdetailid() {
		return departinvoicesotherdetailid;
	}

	public void setDepartinvoicesotherdetailid(Long departinvoicesotherdetailid) {
		this.departinvoicesotherdetailid = departinvoicesotherdetailid;
	}

	public Long getReachstationid() {
		return reachstationid;
	}

	public void setReachstationid(Long reachstationid) {
		this.reachstationid = reachstationid;
	}

	public Departinvoicesother() {
	}

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public BigDecimal getAgentfee() {
		return this.agentfee;
	}

	public void setAgentfee(BigDecimal agentfee) {
		this.agentfee = agentfee;
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

	public BigDecimal getBalancemoney() {
		return balancemoney;
	}

	public void setBalancemoney(BigDecimal balancemoney) {
		this.balancemoney = balancemoney;
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

	public Date getDepartdate() {
		return departdate;
	}

	public void setDepartdate(Date departdate) {
		this.departdate = departdate;
	}

	public String getDepartinvoicesno() {
		return departinvoicesno;
	}

	public void setDepartinvoicesno(String departinvoicesno) {
		this.departinvoicesno = departinvoicesno;
	}

	public Long getDepartstationid() {
		return departstationid;
	}

	public void setDepartstationid(Long departstationid) {
		this.departstationid = departstationid;
	}

	public String getDeparttime() {
		return departtime;
	}

	public void setDeparttime(String departtime) {
		this.departtime = departtime;
	}

	public Balance getBalance() {
		return balance;
	}

	public void setBalance(Balance balance) {
		this.balance = balance;
	}

	public Station getBalancestation() {
		return balancestation;
	}

	public void setBalancestation(Station balancestation) {
		this.balancestation = balancestation;
	}

	public Driver getDriver1() {
		return driver1;
	}

	public void setDriver1(Driver driver1) {
		this.driver1 = driver1;
	}

	public Driver getDriver2() {
		return driver2;
	}

	public void setDriver2(Driver driver2) {
		this.driver2 = driver2;
	}

	public Driver getDriver3() {
		return driver3;
	}

	public void setDriver3(Driver driver3) {
		this.driver3 = driver3;
	}

	public Driver getDriver4() {
		return driver4;
	}

	public void setDriver4(Driver driver4) {
		this.driver4 = driver4;
	}

	public Boolean getIsoriginator() {
		return isoriginator;
	}

	public void setIsoriginator(Boolean isoriginator) {
		this.isoriginator = isoriginator;
	}

	public Boolean getIsreturntrip() {
		return isreturntrip;
	}

	public void setIsreturntrip(Boolean isreturntrip) {
		this.isreturntrip = isreturntrip;
	}

	public Long getOrgid() {
		return orgid;
	}

	public void setOrgid(Long orgid) {
		this.orgid = orgid;
	}

	public String getRecordip() {
		return recordip;
	}

	public void setRecordip(String recordip) {
		this.recordip = recordip;
	}

	public Date getSelfdepartdate() {
		return selfdepartdate;
	}

	public void setSelfdepartdate(Date selfdepartdate) {
		this.selfdepartdate = selfdepartdate;
	}

	public BigDecimal getStationfee() {
		return stationfee;
	}

	public void setStationfee(BigDecimal stationfee) {
		this.stationfee = stationfee;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Steward getSteward1() {
		return steward1;
	}

	public void setSteward1(Steward steward1) {
		this.steward1 = steward1;
	}

	public Steward getSteward2() {
		return steward2;
	}

	public void setSteward2(Steward steward2) {
		this.steward2 = steward2;
	}

	public long getTicketnum() {
		return ticketnum;
	}

	public void setTicketnum(long ticketnum) {
		this.ticketnum = ticketnum;
	}

	public BigDecimal getTotalmoney() {
		return totalmoney;
	}

	public void setTotalmoney(BigDecimal totalmoney) {
		this.totalmoney = totalmoney;
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

	public Long getVehicleid() {
		return vehicleid;
	}

	public void setVehicleid(Long vehicleid) {
		this.vehicleid = vehicleid;
	}

	public Schedule getSchedule() {
		return schedule;
	}

	public void setSchedule(Schedule schedule) {
		this.schedule = schedule;
	}

	public String getDatafrom() {
		return datafrom;
	}

	public void setDatafrom(String datafrom) {
		this.datafrom = datafrom;
	}

	public long getBalanceunitid() {
		return balanceunitid;
	}

	public void setBalanceunitid(long balanceunitid) {
		this.balanceunitid = balanceunitid;
	}

	public Long getSeller() {
		return seller;
	}

	public void setSeller(Long seller) {
		this.seller = seller;
	}

	public Integer getPieces() {
		return pieces;
	}

	public void setPieces(Integer pieces) {
		this.pieces = pieces;
	}
	
}