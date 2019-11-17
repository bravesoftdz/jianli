package cn.nova.bus.price.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;


/**
 * The persistent class for the STANDARDPRICE database table.
 * 
 */
@Entity
public class Standardprice implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name="STANDARDPRICE_ID_GENERATOR", sequenceName="SEQ_TICKETPRICE",allocationSize=1)
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="STANDARDPRICE_ID_GENERATOR")
	private long id;

	private long createby;

    @Temporal( TemporalType.TIMESTAMP)
	private Date createtime;

	private long departstationid;

	private BigDecimal fullprice;

	private BigDecimal halfprice;

	private BigDecimal lowerlimitprice;

	private long reachstationid;

	private long scheduleid;

	private BigDecimal studentprice;

	private BigDecimal toplimitprice;

	private long updateby;
    //优惠票 、 往返票 、 联程票
	private BigDecimal discountprice;

	private BigDecimal roundprice;

	private BigDecimal connectprice;

    @Temporal( TemporalType.TIMESTAMP)
	private Date updatetime;

	private long vehicletypeid;

	@OneToMany(cascade = { CascadeType.ALL }, mappedBy = "standardprice")
	private List<Standardpriceitem> standardpriceitemlist;
	
	
    public List<Standardpriceitem> getStandardpriceitemlist() {
		return standardpriceitemlist;
	}

	public void setStandardpriceitemlist(
			List<Standardpriceitem> standardpriceitemlist) {
		this.standardpriceitemlist = standardpriceitemlist;
	}

	public Standardprice() {
    }

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public long getCreateby() {
		return this.createby;
	}

	public void setCreateby(long createby) {
		this.createby = createby;
	}

	public Date getCreatetime() {
		return this.createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	public long getDepartstationid() {
		return this.departstationid;
	}

	public void setDepartstationid(long departstationid) {
		this.departstationid = departstationid;
	}

	public BigDecimal getFullprice() {
		return this.fullprice;
	}

	public void setFullprice(BigDecimal fullprice) {
		this.fullprice = fullprice;
	}

	public BigDecimal getHalfprice() {
		return this.halfprice;
	}

	public void setHalfprice(BigDecimal halfprice) {
		this.halfprice = halfprice;
	}

	public BigDecimal getLowerlimitprice() {
		return this.lowerlimitprice;
	}

	public void setLowerlimitprice(BigDecimal lowerlimitprice) {
		this.lowerlimitprice = lowerlimitprice;
	}

	public long getReachstationid() {
		return this.reachstationid;
	}

	public void setReachstationid(long reachstationid) {
		this.reachstationid = reachstationid;
	}

	public long getScheduleid() {
		return this.scheduleid;
	}

	public void setScheduleid(long scheduleid) {
		this.scheduleid = scheduleid;
	}

	public BigDecimal getStudentprice() {
		return this.studentprice;
	}

	public void setStudentprice(BigDecimal studentprice) {
		this.studentprice = studentprice;
	}

	public BigDecimal getToplimitprice() {
		return this.toplimitprice;
	}

	public void setToplimitprice(BigDecimal toplimitprice) {
		this.toplimitprice = toplimitprice;
	}

	public long getUpdateby() {
		return this.updateby;
	}

	public void setUpdateby(long updateby) {
		this.updateby = updateby;
	}

	public Date getUpdatetime() {
		return this.updatetime;
	}

	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}

	public long getVehicletypeid() {
		return this.vehicletypeid;
	}

	public void setVehicletypeid(long vehicletypeid) {
		this.vehicletypeid = vehicletypeid;
	}

	public BigDecimal getDiscountprice() {
		return discountprice;
	}

	public void setDiscountprice(BigDecimal discountprice) {
		this.discountprice = discountprice;
	}

	public BigDecimal getRoundprice() {
		return roundprice;
	}

	public void setRoundprice(BigDecimal roundprice) {
		this.roundprice = roundprice;
	}

	public BigDecimal getConnectprice() {
		return connectprice;
	}

	public void setConnectprice(BigDecimal connectprice) {
		this.connectprice = connectprice;
	}
	

}