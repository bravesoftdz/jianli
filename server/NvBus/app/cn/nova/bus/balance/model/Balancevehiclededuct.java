package cn.nova.bus.balance.model;

import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
/**
 * 
 * <b>类描述：单车结算扣费表</b><br/>
 * <b>类名称：</b>Balancevehiclededuct<br/>
 * <b>创建人：</b><a href="mailto:lanchengkun@nova.net.cn">兰成坤</a><br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 *
 */
@Entity
public class Balancevehiclededuct {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name = "BALANCEVEHICLE_ID_GENERATOR", sequenceName = "SEQ_BALANCE", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "BALANCEVEHICLE_ID_GENERATOR")
	private long id;

	private long vehicleid;

	private long balancedeductitemid;

	private BigDecimal deductmoney;

	private long orgid;


	@Temporal(TemporalType.TIMESTAMP)
	private Date createtime;

	private long createby;

	@Temporal(TemporalType.TIMESTAMP)
	private Date updatetime;

	private long updateby;
	
	
	private BigDecimal divdedeductmoney;
	
	
	public BigDecimal getDivdedeductmoney() {
		return divdedeductmoney;
	}

	public void setDivdedeductmoney(BigDecimal divdedeductmoney) {
		this.divdedeductmoney = divdedeductmoney;
	}
	
	
	public Balancevehiclededuct(){
		
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public long getVehicleid() {
		return vehicleid;
	}

	public void setVehicleid(long vehicleid) {
		this.vehicleid = vehicleid;
	}

	public long getBalancedeductitemid() {
		return balancedeductitemid;
	}

	public void setBalancedeductitemid(long balancedeductitemid) {
		this.balancedeductitemid = balancedeductitemid;
	}

	public BigDecimal getDeductmoney() {
		return deductmoney;
	}

	public void setDeductmoney(BigDecimal deductmoney) {
		this.deductmoney = deductmoney;
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
}
