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

/**
 * The persistent class for the HANDPRICE database table.
 * 
 */
@Entity
public class Handprice implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name = "HANDPRICE_ID_GENERATOR", sequenceName="SEQ_TICKETPRICE",allocationSize=1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "HANDPRICE_ID_GENERATOR")
	private long id;

	private long createby;

	@Temporal(TemporalType.TIMESTAMP)
	private Date createtime;

	private long departstationid;

	private BigDecimal fullprice;

	private BigDecimal halfprice;

	private long reachstationid;

	private long scheduleid;

	private String seats;

	private String seattype;

	private BigDecimal studentprice;

	private long updateby;

	@Temporal(TemporalType.TIMESTAMP)
	private Date updatetime;

	private long vehicletypeid;
    //优惠票 、 往返票 、 联程票
	private BigDecimal moreprice;
	
	private BigDecimal discountprice;
	
	private BigDecimal roundprice;
	
	private BigDecimal connectprice;

	
	public BigDecimal getMoreprice() {
		return moreprice;
	}

	public void setMoreprice(BigDecimal moreprice) {
		this.moreprice = moreprice;
	}

	@OneToMany(cascade = { CascadeType.ALL }, mappedBy = "handprice")
	private List<Handpriceitem> handpriceitemlist;
	
	
	@ManyToOne
	@JoinColumn(name = "vehiclebrandmodelid", nullable = true)
	private Vehiclebrandmodel vehiclebrandmodel;

	public Vehiclebrandmodel getVehiclebrandmodel() {
		return vehiclebrandmodel;
	}

	public void setVehiclebrandmodel(Vehiclebrandmodel vehiclebrandmodel) {
		this.vehiclebrandmodel = vehiclebrandmodel;
	}	
	
	@Transient
	private Long vehiclebrandmodelid;

	// 该字段作为记录的操作类型字段，不对数据库表进行映射
	@Transient
	private String opertype;

	@Transient
	private String vehicletypeids;
	@Transient
	private String departstation;
	@Transient
	private String reachstation;
	@Transient
	private String vehicletype;

	private BigDecimal toplimitprice;	

	private BigDecimal lowerlimitprice;
	
	public int getDistance() {
		return distance;
	}

	public void setDistance(int distance) {
		this.distance = distance;
	}

	@Transient
	private int distance;

	public String getVehicletypeids() {
		return vehicletypeids;
	}

	public void setVehicletypeids(String vehicletypeids) {
		this.vehicletypeids = vehicletypeids;
	}

	public String getOpertype() {
		return opertype;
	}

	public void setOpertype(String opertype) {
		this.opertype = opertype;
	}

	public Handprice() {
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
	
	public BigDecimal getToplimitprice() {
		return toplimitprice;
	}

	public void setToplimitprice(BigDecimal toplimitprice) {
		this.toplimitprice = toplimitprice;
	}

	public BigDecimal getLowerlimitprice() {
		return lowerlimitprice;
	}

	public void setLowerlimitprice(BigDecimal lowerlimitprice) {
		this.lowerlimitprice = lowerlimitprice;
	}
	
	public Long getVehiclebrandmodelid() {
		return vehiclebrandmodelid;
	}

	public void setVehiclebrandmodelid(Long vehiclebrandmodelid) {
		this.vehiclebrandmodelid = vehiclebrandmodelid;
	}
	public List<Handpriceitem> getHandpriceitemlist() {
		return handpriceitemlist;
	}

	public void setHandpriceitemlist(List<Handpriceitem> handpriceitemlist) {
		this.handpriceitemlist = handpriceitemlist;
	}
	
	public String getDepartstation() {
		return departstation;
	}

	public void setDepartstation(String departstation) {
		this.departstation = departstation;
	}

	public String getReachstation() {
		return reachstation;
	}

	public void setReachstation(String reachstation) {
		this.reachstation = reachstation;
	}

	public String getVehicletype() {
		return vehicletype;
	}

	public void setVehicletype(String vehicletype) {
		this.vehicletype = vehicletype;
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