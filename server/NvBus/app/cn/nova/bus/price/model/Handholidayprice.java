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
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

import cn.nova.bus.base.model.Vehiclebrandmodel;
import play.db.jpa.NoTransaction;
import play.db.jpa.Transactional;

/**
 * The persistent class for the HANDHOLIDAYPRICE database table.
 * 
 */
@Entity
public class Handholidayprice implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name = "HANDHOLIDAYPRICE_ID_GENERATOR", sequenceName="SEQ_TICKETPRICE",allocationSize=1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "HANDHOLIDAYPRICE_ID_GENERATOR")
	private long id;

	private long createby;

	@Temporal(TemporalType.TIMESTAMP)
	private Date createtime;

	private long departstationid;

	@Temporal(TemporalType.DATE)
	private Date enddate;

	private BigDecimal fullprice;

	private BigDecimal halfprice;

	private long holidayid;

	private long reachstationid;

	private long scheduleid;

	private String seats;

	private String seattype;

	@Temporal(TemporalType.DATE)
	private Date startdate;

	private BigDecimal studentprice;

	private long updateby;

	@Temporal(TemporalType.TIMESTAMP)
	private Date updatetime;

	private long vehicletypeid;
	
	private BigDecimal lowerlimitprice;

	private BigDecimal toplimitprice;
	
	
	private BigDecimal moreprice;
	
	@Transient
	private boolean isselect = true;
    //优惠票 、 往返票 、 联程票
	private BigDecimal discountprice;
	
	private BigDecimal roundprice;
	
	private BigDecimal connectprice;

	public BigDecimal getMoreprice() {
		return moreprice;
	}

	public void setMoreprice(BigDecimal moreprice) {
		this.moreprice = moreprice;
	}
	
	@OneToMany(cascade = { CascadeType.ALL }, mappedBy = "handholidayprice")
	private List<Handholidaypriceitem> handholidaypriceitemlist;
	
	
	@ManyToOne
	@JoinColumn(name = "vehiclebrandmodelid", nullable = true)
	private Vehiclebrandmodel vehiclebrandmodel;

	
	@Transient	
	private Long vehiclebrandmodelid;

	public Long getVehiclebrandmodelid() {
		return vehiclebrandmodelid;
	}

	public void setVehiclebrandmodelid(Long vehiclebrandmodelid) {
		this.vehiclebrandmodelid = vehiclebrandmodelid;
	}


	
	//该字段作为记录的操作类型字段，不对数据库表进行映射
    @Transient
    private String opertype;

	public String getOpertype() {
		return opertype;
	}

	public void setOpertype(String opertype) {
		this.opertype = opertype;
	}
	
	public BigDecimal getLowerlimitprice() {
		return lowerlimitprice;
	}

	public void setLowerlimitprice(BigDecimal lowerlimitprice) {
		this.lowerlimitprice = lowerlimitprice;
	}

	public BigDecimal getToplimitprice() {
		return toplimitprice;
	}

	public void setToplimitprice(BigDecimal toplimitprice) {
		this.toplimitprice = toplimitprice;
	}


	public Handholidayprice() {
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

	public Date getEnddate() {
		return this.enddate;
	}

	public void setEnddate(Date enddate) {
		this.enddate = enddate;
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

	public long getHolidayid() {
		return this.holidayid;
	}

	public void setHolidayid(long holidayid) {
		this.holidayid = holidayid;
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

	public String getSeats() {
		return this.seats;
	}

	public void setSeats(String seats) {
		this.seats = seats;
	}

	public String getSeattype() {
		return this.seattype;
	}

	public void setSeattype(String seattype) {
		this.seattype = seattype;
	}

	public Date getStartdate() {
		return this.startdate;
	}

	public void setStartdate(Date startdate) {
		this.startdate = startdate;
	}

	public BigDecimal getStudentprice() {
		return this.studentprice;
	}

	public void setStudentprice(BigDecimal studentprice) {
		this.studentprice = studentprice;
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
	
	public Vehiclebrandmodel getVehiclebrandmodel() {
		return vehiclebrandmodel;
	}

	public void setVehiclebrandmodel(Vehiclebrandmodel vehiclebrandmodel) {
		this.vehiclebrandmodel = vehiclebrandmodel;
	}
	
	public List<Handholidaypriceitem> getHandholidaypriceitemlist() {
		return handholidaypriceitemlist;
	}

	public void setHandholidaypriceitemlist(
			List<Handholidaypriceitem> handholidaypriceitemlist) {
		this.handholidaypriceitemlist = handholidaypriceitemlist;
	}

	public boolean isIsselect() {
		return isselect;
	}

	public void setIsselect(boolean isselect) {
		this.isselect = isselect;
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