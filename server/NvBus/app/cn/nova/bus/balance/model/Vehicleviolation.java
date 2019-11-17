package cn.nova.bus.balance.model;

import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import play.data.binding.As;

/**
 * 
 * <b>类描述：车辆违规管理</b><br/>
 * <b>类名称：</b>Vehicleviolation<br/>
 * <b>创建人：</b><a href="mailto:lanchengkun@nova.net.cn">兰成坤</a><br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 * 
 */
@Entity
public class Vehicleviolation {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name = "VIOLATION_ID_GENERATOR", sequenceName = "SEQ_BALANCE", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "VIOLATION_ID_GENERATOR")
	private long id;

	private String notenum;

	private String routename;

	private long vehicleid;

	private Date violationdate;

	private String departtime;

	private BigDecimal debit;

	private String remark;

	private long billor;

	@Temporal(TemporalType.TIMESTAMP)
	private Date billdate;

	private String handleret;

	private BigDecimal breachfee;

	private boolean ishandle;

	private Long handlor;

	private Date handledate;

	@JoinColumn(name = "BALANCEID", nullable = true)
	@ManyToOne(cascade = { CascadeType.REFRESH, CascadeType.PERSIST })
	private Balance balance;
	
	private Long departinvoicesid;  //结算单ID
	
	private boolean iscash;  //现金罚款0:非现金1:现金

	public Balance getBalance() {
		return balance;
	}

	public void setBalance(Balance balance) {
		this.balance = balance;
	}

	private long orgid;

	@Temporal(TemporalType.TIMESTAMP)
	private Date createtime;

	private long createby;

	@Temporal(TemporalType.TIMESTAMP)
	private Date updatetime;

	private long updateby;

	private String balancetype;
	
	private String status;
	
	public Vehicleviolation() {

	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getRoutename() {
		return routename;
	}

	public void setRoutename(String routename) {
		this.routename = routename;
	}

	public long getVehicleid() {
		return vehicleid;
	}

	public void setVehicleid(long vehicleid) {
		this.vehicleid = vehicleid;
	}

	public Date getViolationdate() {
		return violationdate;
	}

	public void setViolationdate(Date violationdate) {
		this.violationdate = violationdate;
	}

	public String getDeparttime() {
		return departtime;
	}

	public void setDeparttime(String departtime) {
		this.departtime = departtime;
	}

	public BigDecimal getDebit() {
		return debit;
	}

	public void setDebit(BigDecimal debit) {
		this.debit = debit;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public long getBillor() {
		return billor;
	}

	public void setBillor(long billor) {
		this.billor = billor;
	}

	public Date getBilldate() {
		return billdate;
	}

	@As("yyyy-MM-dd HH:mm:ss")
	public void setBilldate(Date billdate) {
		this.billdate = billdate;
	}

	public String getHandleret() {
		return handleret;
	}

	public void setHandleret(String handleret) {
		this.handleret = handleret;
	}

	public BigDecimal getBreachfee() {
		return breachfee;
	}

	public void setBreachfee(BigDecimal breachfee) {
		this.breachfee = breachfee;
	}

	public boolean isIshandle() {
		return ishandle;
	}

	public void setIshandle(boolean ishandle) {
		this.ishandle = ishandle;
	}

	public Long getHandlor() {
		return handlor;
	}

	public void setHandlor(Long handlor) {
		this.handlor = handlor;
	}

	public Date getHandledate() {
		return handledate;
	}

	public void setHandledate(Date handledate) {
		this.handledate = handledate;
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

	@As("yyyy-MM-dd HH:mm:ss")
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

	public String getNotenum() {
		return notenum;
	}

	public void setNotenum(String notenum) {
		this.notenum = notenum;
	}

	public String getBalancetype() {
		return balancetype;
	}

	public void setBalancetype(String balancetype) {
		this.balancetype = balancetype;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Long getDepartinvoicesid() {
		return departinvoicesid;
	}

	public void setDepartinvoicesid(Long departinvoicesid) {
		this.departinvoicesid = departinvoicesid;
	}

	public boolean isIscash() {
		return iscash;
	}

	public void setIscash(boolean iscash) {
		this.iscash = iscash;
	}
    

    
}
