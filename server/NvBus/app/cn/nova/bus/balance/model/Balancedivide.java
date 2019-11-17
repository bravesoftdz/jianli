package cn.nova.bus.balance.model;

import java.io.Serializable;
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
 * <b>类描述：结算分层协议</b><br/>
 * <b>类名称：</b>Balancedivide<br/>
 * <b>创建人：</b><a href="mailto:lanchengkun@nova.net.cn">兰成坤</a><br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 *
 */
@Entity
public class Balancedivide implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name = "BALANCEDEDIVIDE_ID_GENERATOR", sequenceName = "SEQ_BALANCE", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "BALANCEDEDIVIDE_ID_GENERATOR")
	private long id;

	private long routeid;

	private long vehicleid;

	private long dividevehicleid;

	private BigDecimal divide;

	private long orgid;

	@Temporal(TemporalType.TIMESTAMP)
	private Date createtime;

	private long createby;

	@Temporal(TemporalType.TIMESTAMP)
	private Date updatetime;

	private long updateby;

	public Balancedivide(){
		
		
	}
	
	
	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public long getRouteid() {
		return routeid;
	}

	public void setRouteid(long routeid) {
		this.routeid = routeid;
	}

	public long getVehicleid() {
		return vehicleid;
	}

	public void setVehicleid(long vehicleid) {
		this.vehicleid = vehicleid;
	}



	public long getDividevehicleid() {
		return dividevehicleid;
	}


	public void setDividevehicleid(long dividevehicleid) {
		this.dividevehicleid = dividevehicleid;
	}


	public BigDecimal getDivide() {
		return divide;
	}

	public void setDivide(BigDecimal divide) {
		this.divide = divide;
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
