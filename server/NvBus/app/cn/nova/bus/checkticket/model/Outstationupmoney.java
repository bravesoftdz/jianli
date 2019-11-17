package cn.nova.bus.checkticket.model;

import java.io.Serializable;
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

@Entity
@Table(name = "OUTSTATIONUPMONEY")
public class Outstationupmoney implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name = "OUTSTATIONUPMONEY_ID_GENERATOR", sequenceName = "SEQ_OUTSTATIONUPMONEY", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "OUTSTATIONUPMONEY_ID_GENERATOR")
	@Column(nullable = false, unique = true)
	private long id;

	private String departmonth;//	varchar2(6)	n			发车月份,yyyymm
	private String routename;//	VARCHAR2(30)	n			线路名称
	private BigDecimal price;//	number(10,2)	n			外站售票金额
	private BigDecimal agentfee;//	number(10,2)	n			客运代理费
	private BigDecimal waterfee;//	number(10,2)	n			水费
	private BigDecimal stopfee;//	number(10,2)	n			停车费
	private BigDecimal violationfee;//	number(10,2)	n			违约脱班
	private BigDecimal otherfee1;//	number(10,2)	n			其他1
	private BigDecimal otherfee2;//	number(10,2)	n			其他2
	private BigDecimal balancemoney;//	number(10,2)	n			净缴金额
	private long operatorid;//	number(10)	n			
	private long orgid;//	number(10)	n
	
	@Temporal(TemporalType.TIMESTAMP)
	private Date createtime;//	date	n	sysdate		
	private long createby;//	number(10)	n			
	
	@Temporal(TemporalType.TIMESTAMP)
	private Date updatetime;//date	n	sysdate		
	private long updateby;//	number(10)	n		
	
	public Outstationupmoney() {
		// TODO Auto-generated constructor stub
	}
	
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public String getDepartmonth() {
		return departmonth;
	}
	public void setDepartmonth(String departmonth) {
		this.departmonth = departmonth;
	}
	public BigDecimal getPrice() {
		return price;
	}
	public void setPrice(BigDecimal price) {
		this.price = price;
	}
	public BigDecimal getAgentfee() {
		return agentfee;
	}
	public void setAgentfee(BigDecimal agentfee) {
		this.agentfee = agentfee;
	}
	public BigDecimal getWaterfee() {
		return waterfee;
	}
	public void setWaterfee(BigDecimal waterfee) {
		this.waterfee = waterfee;
	}
	public BigDecimal getStopfee() {
		return stopfee;
	}
	public void setStopfee(BigDecimal stopfee) {
		this.stopfee = stopfee;
	}
	public BigDecimal getViolationfee() {
		return violationfee;
	}
	public void setViolationfee(BigDecimal violationfee) {
		this.violationfee = violationfee;
	}
	public BigDecimal getOtherfee1() {
		return otherfee1;
	}
	public void setOtherfee1(BigDecimal otherfee1) {
		this.otherfee1 = otherfee1;
	}
	public BigDecimal getOtherfee2() {
		return otherfee2;
	}
	public void setOtherfee2(BigDecimal otherfee2) {
		this.otherfee2 = otherfee2;
	}
	public BigDecimal getBalancemoney() {
		return balancemoney;
	}
	public void setBalancemoney(BigDecimal balancemoney) {
		this.balancemoney = balancemoney;
	}
	public long getOperatorid() {
		return operatorid;
	}
	public void setOperatorid(long operatorid) {
		this.operatorid = operatorid;
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
	public long getCreateby() {
		return createby;
	}
	public void setCreateby(long createby) {
		this.createby = createby;
	}
	public Date getUpdatetime() {
		return updatetime;
	}
	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}
	public long getUpdateby() {
		return updateby;
	}
	public void setUpdateby(long updateby) {
		this.updateby = updateby;
	}

	public String getRoutename() {
		return routename;
	}

	public void setRoutename(String routename) {
		this.routename = routename;
	}
	
}