package cn.nova.bus.balance.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.EntityListeners;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import cn.nova.utils.orm.listener.SyncCodeGenerate;

@Entity
@Table(name = "SCHEDULELOSTTREATMENT")
@EntityListeners({ SyncCodeGenerate.class, ScheduleLostTreatments.class })
public class ScheduleLostTreatments implements Serializable {

	@Id
	@SequenceGenerator(name = "ScheduleLostTreatment_ID_GENERATOR", sequenceName = "SEQ_BALANCE", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "ScheduleLostTreatment_ID_GENERATOR")
	private Long id;
	private Long scheduleid;
	private Long vehicleid;
	private Long routeid;
	private Date departdate;
	private String plandeparttime;
	private Boolean status;
	private Boolean isreport;
	private Long reportuser;
	private Boolean isdepart;
	private String departtime;
	private String schedulestatus;
	private Boolean firstcheck;
	private Boolean recheck;
	private String answer;
	private Boolean isaddbalanceprice;
	private Long balanceid;
	private Date balancedate;
	private Boolean isbalance;
	private BigDecimal fine;
	private Long orgid;
	private Long firstcheckuser;
	private Long recheckuser;
	private Date firstchecktime;
	private Date rechecktime;
	private Long seatnum;
	private Date createtime;
	private Long createby;
	private Date updatetime;
	private Long updateby;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
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

	public Long getRouteid() {
		return routeid;
	}

	public void setRouteid(Long routeid) {
		this.routeid = routeid;
	}

	public Date getDepartdate() {
		return departdate;
	}

	public void setDepartdate(Date departdate) {
		this.departdate = departdate;
	}

	public String getPlandeparttime() {
		return plandeparttime;
	}

	public void setPlandeparttime(String plandeparttime) {
		this.plandeparttime = plandeparttime;
	}

	public Boolean isStatus() {
		return status;
	}

	public void setStatus(Boolean status) {
		this.status = status;
	}

	public Boolean isIsreport() {
		return isreport;
	}

	public void setIsreport(Boolean isreport) {
		this.isreport = isreport;
	}

	public Long getReportuser() {
		return reportuser;
	}

	public void setReportuser(Long reportuser) {
		this.reportuser = reportuser;
	}

	public Boolean isIsdepart() {
		return isdepart;
	}

	public void setIsdepart(Boolean isdepart) {
		this.isdepart = isdepart;
	}

	public String getDeparttime() {
		return departtime;
	}

	public void setDeparttime(String departtime) {
		this.departtime = departtime;
	}

	public String getSchedulestatus() {
		return schedulestatus;
	}

	public void setSchedulestatus(String schedulestatus) {
		this.schedulestatus = schedulestatus;
	}

	public Boolean isFirstcheck() {
		return firstcheck;
	}

	public void setFirstcheck(Boolean firstcheck) {
		this.firstcheck = firstcheck;
	}

	public Boolean isRecheck() {
		return recheck;
	}

	public void setRecheck(Boolean recheck) {
		this.recheck = recheck;
	}

	public String getAnswer() {
		return answer;
	}

	public void setAnswer(String answer) {
		this.answer = answer;
	}

	public Boolean isIsaddbalanceprice() {
		return isaddbalanceprice;
	}

	public void setIsaddbalanceprice(Boolean isaddbalanceprice) {
		this.isaddbalanceprice = isaddbalanceprice;
	}

	public Long getBalanceid() {
		return balanceid;
	}

	public void setBalanceid(Long balanceid) {
		this.balanceid = balanceid;
	}

	public Date getBalancedate() {
		return balancedate;
	}

	public void setBalancedate(Date balancedate) {
		this.balancedate = balancedate;
	}

	public Boolean isIsbalance() {
		return isbalance;
	}

	public void setIsbalance(Boolean isbalance) {
		this.isbalance = isbalance;
	}

	public BigDecimal getFine() {
		return fine;
	}

	public void setFine(BigDecimal fine) {
		this.fine = fine;
	}

	public Long getOrgid() {
		return orgid;
	}

	public void setOrgid(Long orgid) {
		this.orgid = orgid;
	}

	public Long getFirstcheckuser() {
		return firstcheckuser;
	}

	public void setFirstcheckuser(Long firstcheckuser) {
		this.firstcheckuser = firstcheckuser;
	}

	public Long getRecheckuser() {
		return recheckuser;
	}

	public void setRecheckuser(Long recheckuser) {
		this.recheckuser = recheckuser;
	}

	public Date getFirstchecktime() {
		return firstchecktime;
	}

	public void setFirstchecktime(Date firstchecktime) {
		this.firstchecktime = firstchecktime;
	}

	public Date getRechecktime() {
		return rechecktime;
	}

	public void setRechecktime(Date rechecktime) {
		this.rechecktime = rechecktime;
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

	public Long getSeatnum() {
		return seatnum;
	}

	public void setSeatnum(Long seatnum) {
		this.seatnum = seatnum;
	}
}
