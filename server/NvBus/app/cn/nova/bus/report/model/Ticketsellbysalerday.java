package cn.nova.bus.report.model;

import java.io.Serializable;
import javax.persistence.*;

import java.math.BigDecimal;
import java.util.Date;

/**
 * The persistent class for the TICKETSELLBYSALERDAY database table.
 * 
 */
@Entity
public class Ticketsellbysalerday implements Serializable {
	private static final long serialVersionUID = 1L;
	@Id
	@SequenceGenerator(name = "SALERDAY_ID_GENERATOR", sequenceName = "SEQ_REPORT", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SALERDAY_ID_GENERATOR")
	@Column(unique = true, nullable = false, precision = 10)
	private long id;

	private BigDecimal additionfee;

	private long badnum;

	private BigDecimal cancelmoeny;

	private long cancelnum;

	private BigDecimal computefee;

	private BigDecimal coolairfee;

	@Temporal(TemporalType.DATE)
	private Date createtime;

	private long orgid;

	private BigDecimal returnfee;

	private long returnnum;

	private BigDecimal returnprice;

	private long sellby;

	@Temporal(TemporalType.DATE)
	private Date selldate;

	private BigDecimal sellnum;

	private BigDecimal stationservicefee;

	private BigDecimal totalprice;

	private BigDecimal synreturnsynnum;
	private BigDecimal synreturnsynprice;
	private BigDecimal synreturnsynfee;
	private BigDecimal synreturnlocnum;
	private BigDecimal synreturnlocprice;
	private BigDecimal synreturnlocfee;
	private BigDecimal totalfee;
	private BigDecimal baseprice;
	private BigDecimal localincome;
	private BigDecimal divideprice;

	private BigDecimal fueladditionfee;
	
	public Ticketsellbysalerday() {
	}

	public BigDecimal getAdditionfee() {
		return this.additionfee;
	}

	public void setAdditionfee(BigDecimal additionfee) {
		this.additionfee = additionfee;
	}

	public long getBadnum() {
		return this.badnum;
	}

	public void setBadnum(long badnum) {
		this.badnum = badnum;
	}

	public BigDecimal getCancelmoeny() {
		return this.cancelmoeny;
	}

	public void setCancelmoeny(BigDecimal cancelmoeny) {
		this.cancelmoeny = cancelmoeny;
	}

	public long getCancelnum() {
		return this.cancelnum;
	}

	public void setCancelnum(long cancelnum) {
		this.cancelnum = cancelnum;
	}

	public BigDecimal getComputefee() {
		return this.computefee;
	}

	public void setComputefee(BigDecimal computefee) {
		this.computefee = computefee;
	}

	public BigDecimal getCoolairfee() {
		return this.coolairfee;
	}

	public void setCoolairfee(BigDecimal coolairfee) {
		this.coolairfee = coolairfee;
	}

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public long getOrgid() {
		return this.orgid;
	}

	public void setOrgid(long orgid) {
		this.orgid = orgid;
	}

	public BigDecimal getReturnfee() {
		return this.returnfee;
	}

	public void setReturnfee(BigDecimal returnfee) {
		this.returnfee = returnfee;
	}

	public long getReturnnum() {
		return this.returnnum;
	}

	public void setReturnnum(long returnnum) {
		this.returnnum = returnnum;
	}

	public BigDecimal getReturnprice() {
		return this.returnprice;
	}

	public void setReturnprice(BigDecimal returnprice) {
		this.returnprice = returnprice;
	}

	public long getSellby() {
		return this.sellby;
	}

	public void setSellby(long sellby) {
		this.sellby = sellby;
	}

	public Date getSelldate() {
		return this.selldate;
	}

	public void setSelldate(Date selldate) {
		this.selldate = selldate;
	}

	public BigDecimal getSellnum() {
		return this.sellnum;
	}

	public void setSellnum(BigDecimal sellnum) {
		this.sellnum = sellnum;
	}

	public BigDecimal getStationservicefee() {
		return this.stationservicefee;
	}

	public void setStationservicefee(BigDecimal stationservicefee) {
		this.stationservicefee = stationservicefee;
	}

	public BigDecimal getTotalprice() {
		return this.totalprice;
	}

	public void setTotalprice(BigDecimal totalprice) {
		this.totalprice = totalprice;
	}

	public BigDecimal getSynreturnsynnum() {
		return synreturnsynnum;
	}

	public void setSynreturnsynnum(BigDecimal synreturnsynnum) {
		this.synreturnsynnum = synreturnsynnum;
	}

	public BigDecimal getSynreturnsynprice() {
		return synreturnsynprice;
	}

	public void setSynreturnsynprice(BigDecimal synreturnsynprice) {
		this.synreturnsynprice = synreturnsynprice;
	}

	public BigDecimal getSynreturnsynfee() {
		return synreturnsynfee;
	}

	public void setSynreturnsynfee(BigDecimal synreturnsynfee) {
		this.synreturnsynfee = synreturnsynfee;
	}

	public BigDecimal getSynreturnlocnum() {
		return synreturnlocnum;
	}

	public void setSynreturnlocnum(BigDecimal synreturnlocnum) {
		this.synreturnlocnum = synreturnlocnum;
	}

	public BigDecimal getSynreturnlocprice() {
		return synreturnlocprice;
	}

	public void setSynreturnlocprice(BigDecimal synreturnlocprice) {
		this.synreturnlocprice = synreturnlocprice;
	}

	public BigDecimal getSynreturnlocfee() {
		return synreturnlocfee;
	}

	public void setSynreturnlocfee(BigDecimal synreturnlocfee) {
		this.synreturnlocfee = synreturnlocfee;
	}

	public BigDecimal getTotalfee() {
		return totalfee;
	}

	public void setTotalfee(BigDecimal totalfee) {
		this.totalfee = totalfee;
	}

	public BigDecimal getBaseprice() {
		return baseprice;
	}

	public void setBaseprice(BigDecimal baseprice) {
		this.baseprice = baseprice;
	}

	public BigDecimal getLocalincome() {
		return localincome;
	}

	public void setLocalincome(BigDecimal localincome) {
		this.localincome = localincome;
	}

	public BigDecimal getDivideprice() {
		return divideprice;
	}

	public void setDivideprice(BigDecimal divideprice) {
		this.divideprice = divideprice;
	}

   public Date getCreatetime() {
    return createtime;
   }

   public void setCreatetime(Date createtime) {
    this.createtime = createtime;
   }

	public BigDecimal getFueladditionfee() {
		return fueladditionfee;
	}
	
	public void setFueladditionfee(BigDecimal fueladditionfee) {
		this.fueladditionfee = fueladditionfee;
	}

}