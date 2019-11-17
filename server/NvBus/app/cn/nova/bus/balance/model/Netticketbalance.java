package cn.nova.bus.balance.model;

import java.io.Serializable;
import javax.persistence.*;
import java.math.BigDecimal;
import java.util.Date;


/**
 * The persistent class for the NETTICKETBALANCE database table.
 * 
 */
@Entity
public class Netticketbalance implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name="NETTICKETBALANCE_ID_GENERATOR", sequenceName="SEQ_BALANCE")
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="NETTICKETBALANCE_ID_GENERATOR")
	private long id;

	private BigDecimal additionfee;

	private BigDecimal balancemoney;

	private BigDecimal byadditionfee;

	private BigDecimal bycancelmoeny;

	private BigDecimal bycancelnum;

	private BigDecimal bycomputefee;

	private BigDecimal bycoolairfee;

	private BigDecimal byreturnfeeother;

	private BigDecimal byreturnfeeself;

	private BigDecimal byreturnmoneyother;

	private BigDecimal byreturnnumother;

	private BigDecimal byreturnnumself;

	private BigDecimal bysellagentfee;

	private BigDecimal bysellmoney;

	private BigDecimal bysellnum;

	private BigDecimal bystationservicefee;

	private BigDecimal bysyncincome;

	private BigDecimal cancelmoeny;

	private BigDecimal cancelnum;

	private BigDecimal computefee;

	private BigDecimal coolairfee;

	private BigDecimal createby;

    @Temporal( TemporalType.TIMESTAMP)
	private Date createtime;

    @Temporal( TemporalType.DATE)
	private Date enddate;

	private BigDecimal isactive;

	private BigDecimal localincome;

	private BigDecimal orgid;

	private BigDecimal returnfeeother;

	private BigDecimal returnfeeself;

	private BigDecimal returnmoneyother;

	private BigDecimal returnmoneyself;

	private BigDecimal returnnumother;

	private BigDecimal returnnumself;

	private BigDecimal sellagentfee;

	private BigDecimal sellmoney;

	private BigDecimal sellnum;

    @Temporal( TemporalType.DATE)
	private Date startdate;

	private BigDecimal stationservicefee;

	private BigDecimal updateby;

    @Temporal( TemporalType.TIMESTAMP)
	private Date updatetime;

	private BigDecimal vipconsumemoney;

	private BigDecimal vipconsumepoint;

	private BigDecimal viprechargemoney;

	private BigDecimal viprechargepoint;

    public Netticketbalance() {
    }

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public BigDecimal getAdditionfee() {
		return this.additionfee;
	}

	public void setAdditionfee(BigDecimal additionfee) {
		this.additionfee = additionfee;
	}

	public BigDecimal getBalancemoney() {
		return this.balancemoney;
	}

	public void setBalancemoney(BigDecimal balancemoney) {
		this.balancemoney = balancemoney;
	}

	public BigDecimal getByadditionfee() {
		return this.byadditionfee;
	}

	public void setByadditionfee(BigDecimal byadditionfee) {
		this.byadditionfee = byadditionfee;
	}

	public BigDecimal getBycancelmoeny() {
		return this.bycancelmoeny;
	}

	public void setBycancelmoeny(BigDecimal bycancelmoeny) {
		this.bycancelmoeny = bycancelmoeny;
	}

	public BigDecimal getBycancelnum() {
		return this.bycancelnum;
	}

	public void setBycancelnum(BigDecimal bycancelnum) {
		this.bycancelnum = bycancelnum;
	}

	public BigDecimal getBycomputefee() {
		return this.bycomputefee;
	}

	public void setBycomputefee(BigDecimal bycomputefee) {
		this.bycomputefee = bycomputefee;
	}

	public BigDecimal getBycoolairfee() {
		return this.bycoolairfee;
	}

	public void setBycoolairfee(BigDecimal bycoolairfee) {
		this.bycoolairfee = bycoolairfee;
	}

	public BigDecimal getByreturnfeeother() {
		return this.byreturnfeeother;
	}

	public void setByreturnfeeother(BigDecimal byreturnfeeother) {
		this.byreturnfeeother = byreturnfeeother;
	}

	public BigDecimal getByreturnfeeself() {
		return this.byreturnfeeself;
	}

	public void setByreturnfeeself(BigDecimal byreturnfeeself) {
		this.byreturnfeeself = byreturnfeeself;
	}

	public BigDecimal getByreturnmoneyother() {
		return this.byreturnmoneyother;
	}

	public void setByreturnmoneyother(BigDecimal byreturnmoneyother) {
		this.byreturnmoneyother = byreturnmoneyother;
	}

	public BigDecimal getByreturnnumother() {
		return this.byreturnnumother;
	}

	public void setByreturnnumother(BigDecimal byreturnnumother) {
		this.byreturnnumother = byreturnnumother;
	}

	public BigDecimal getByreturnnumself() {
		return this.byreturnnumself;
	}

	public void setByreturnnumself(BigDecimal byreturnnumself) {
		this.byreturnnumself = byreturnnumself;
	}

	public BigDecimal getBysellagentfee() {
		return this.bysellagentfee;
	}

	public void setBysellagentfee(BigDecimal bysellagentfee) {
		this.bysellagentfee = bysellagentfee;
	}

	public BigDecimal getBysellmoney() {
		return this.bysellmoney;
	}

	public void setBysellmoney(BigDecimal bysellmoney) {
		this.bysellmoney = bysellmoney;
	}

	public BigDecimal getBysellnum() {
		return this.bysellnum;
	}

	public void setBysellnum(BigDecimal bysellnum) {
		this.bysellnum = bysellnum;
	}

	public BigDecimal getBystationservicefee() {
		return this.bystationservicefee;
	}

	public void setBystationservicefee(BigDecimal bystationservicefee) {
		this.bystationservicefee = bystationservicefee;
	}

	public BigDecimal getBysyncincome() {
		return this.bysyncincome;
	}

	public void setBysyncincome(BigDecimal bysyncincome) {
		this.bysyncincome = bysyncincome;
	}

	public BigDecimal getCancelmoeny() {
		return this.cancelmoeny;
	}

	public void setCancelmoeny(BigDecimal cancelmoeny) {
		this.cancelmoeny = cancelmoeny;
	}

	public BigDecimal getCancelnum() {
		return this.cancelnum;
	}

	public void setCancelnum(BigDecimal cancelnum) {
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

	public BigDecimal getCreateby() {
		return this.createby;
	}

	public void setCreateby(BigDecimal createby) {
		this.createby = createby;
	}

	public Date getCreatetime() {
		return this.createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	public Date getEnddate() {
		return this.enddate;
	}

	public void setEnddate(Date enddate) {
		this.enddate = enddate;
	}

	public BigDecimal getIsactive() {
		return this.isactive;
	}

	public void setIsactive(BigDecimal isactive) {
		this.isactive = isactive;
	}

	public BigDecimal getLocalincome() {
		return this.localincome;
	}

	public void setLocalincome(BigDecimal localincome) {
		this.localincome = localincome;
	}

	public BigDecimal getOrgid() {
		return this.orgid;
	}

	public void setOrgid(BigDecimal orgid) {
		this.orgid = orgid;
	}

	public BigDecimal getReturnfeeother() {
		return this.returnfeeother;
	}

	public void setReturnfeeother(BigDecimal returnfeeother) {
		this.returnfeeother = returnfeeother;
	}

	public BigDecimal getReturnfeeself() {
		return this.returnfeeself;
	}

	public void setReturnfeeself(BigDecimal returnfeeself) {
		this.returnfeeself = returnfeeself;
	}

	public BigDecimal getReturnmoneyother() {
		return this.returnmoneyother;
	}

	public void setReturnmoneyother(BigDecimal returnmoneyother) {
		this.returnmoneyother = returnmoneyother;
	}

	public BigDecimal getReturnmoneyself() {
		return this.returnmoneyself;
	}

	public void setReturnmoneyself(BigDecimal returnmoneyself) {
		this.returnmoneyself = returnmoneyself;
	}

	public BigDecimal getReturnnumother() {
		return this.returnnumother;
	}

	public void setReturnnumother(BigDecimal returnnumother) {
		this.returnnumother = returnnumother;
	}

	public BigDecimal getReturnnumself() {
		return this.returnnumself;
	}

	public void setReturnnumself(BigDecimal returnnumself) {
		this.returnnumself = returnnumself;
	}

	public BigDecimal getSellagentfee() {
		return this.sellagentfee;
	}

	public void setSellagentfee(BigDecimal sellagentfee) {
		this.sellagentfee = sellagentfee;
	}

	public BigDecimal getSellmoney() {
		return this.sellmoney;
	}

	public void setSellmoney(BigDecimal sellmoney) {
		this.sellmoney = sellmoney;
	}

	public BigDecimal getSellnum() {
		return this.sellnum;
	}

	public void setSellnum(BigDecimal sellnum) {
		this.sellnum = sellnum;
	}

	public Date getStartdate() {
		return this.startdate;
	}

	public void setStartdate(Date startdate) {
		this.startdate = startdate;
	}

	public BigDecimal getStationservicefee() {
		return this.stationservicefee;
	}

	public void setStationservicefee(BigDecimal stationservicefee) {
		this.stationservicefee = stationservicefee;
	}

	public BigDecimal getUpdateby() {
		return this.updateby;
	}

	public void setUpdateby(BigDecimal updateby) {
		this.updateby = updateby;
	}

	public Date getUpdatetime() {
		return this.updatetime;
	}

	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}

	public BigDecimal getVipconsumemoney() {
		return this.vipconsumemoney;
	}

	public void setVipconsumemoney(BigDecimal vipconsumemoney) {
		this.vipconsumemoney = vipconsumemoney;
	}

	public BigDecimal getVipconsumepoint() {
		return this.vipconsumepoint;
	}

	public void setVipconsumepoint(BigDecimal vipconsumepoint) {
		this.vipconsumepoint = vipconsumepoint;
	}

	public BigDecimal getViprechargemoney() {
		return this.viprechargemoney;
	}

	public void setViprechargemoney(BigDecimal viprechargemoney) {
		this.viprechargemoney = viprechargemoney;
	}

	public BigDecimal getViprechargepoint() {
		return this.viprechargepoint;
	}

	public void setViprechargepoint(BigDecimal viprechargepoint) {
		this.viprechargepoint = viprechargepoint;
	}

}