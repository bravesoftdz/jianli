package cn.nova.bus.balance.model;

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

import play.data.binding.As;

@Entity
@Table(name="TICKETTURNOVERDIFADJUST")
public class Ticketturnoverdifadjust  implements Serializable {
	
	@Id
	@SequenceGenerator(name="DIFADJUSTS_ID_GENERATOR", sequenceName="SEQ_BALANCE")
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="DIFADJUSTS_ID_GENERATOR")
	private long id;
	
	private Date moneydate;
	
	private long  seller;
	
    private BigDecimal difmoney;
    
	private long orgid;
	
	private String remark;
	

	@Temporal( TemporalType.TIMESTAMP)
	private Date createtime;
    
	private long  createby;
	
	private long updateby;

	@Temporal( TemporalType.TIMESTAMP)
	private Date updatetime;
	
	
	public Ticketturnoverdifadjust(){
		
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public Date getMoneydate() {
		return moneydate;
	}

	public void setMoneydate(Date moneydate) {
		this.moneydate = moneydate;
	}

	public long getSeller() {
		return seller;
	}

	public void setSeller(long seller) {
		this.seller = seller;
	}

	public BigDecimal getDifmoney() {
		return difmoney;
	}

	public void setDifmoney(BigDecimal difmoney) {
		this.difmoney = difmoney;
	}

	public long getOrgid() {
		return orgid;
	}

	public void setOrgid(long orgid) {
		this.orgid = orgid;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
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

	public long getUpdateby() {
		return updateby;
	}

	public void setUpdateby(long updateby) {
		this.updateby = updateby;
	}

	public Date getUpdatetime() {
		return updatetime;
	}

	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}

}
