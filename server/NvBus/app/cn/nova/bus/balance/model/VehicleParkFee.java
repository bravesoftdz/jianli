package cn.nova.bus.balance.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;

@Entity
public class VehicleParkFee implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name = "VEHICLEPARKFEE_ID_GENERATOR", sequenceName = "SEQ_PUB", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "VEHICLEPARKFEE_ID_GENERATOR")
	private Long id;

	private String vehicleno;
	
	private Date departdate;
	
	private BigDecimal parkfee;
	
	private Boolean isbalanced;
	
	private Long orgid;
	
	private Long balanceid;
	
	private Long createby;
	
	private Date createtime;
	
	private Long updateby;
	
	private Date updatetime;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getVehicleno() {
		return vehicleno;
	}

	public void setVehicleno(String vehicleno) {
		this.vehicleno = vehicleno;
	}

	public Date getDepartdate() {
		return departdate;
	}

	public void setDepartdate(Date departdate) {
		this.departdate = departdate;
	}

	public BigDecimal getParkfee() {
		return parkfee;
	}

	public void setParkfee(BigDecimal parkfee) {
		this.parkfee = parkfee;
	}

	public Boolean getIsbalanced() {
		return isbalanced;
	}

	public void setIsbalanced(Boolean isbalanced) {
		this.isbalanced = isbalanced;
	}

	public Long getOrgid() {
		return orgid;
	}

	public void setOrgid(Long orgid) {
		this.orgid = orgid;
	}

	public Long getBalanceid() {
		return balanceid;
	}

	public void setBalanceid(Long balanceid) {
		this.balanceid = balanceid;
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

}
