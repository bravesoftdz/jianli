package cn.nova.bus.price.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

import cn.nova.bus.base.model.Vehiclebrandmodel;

/**
 * 售票点票价差额表
 * The persistent class for the TICKETOUTLETSPRICE database table.
 * 
 */
@Entity
public class Ticketoutletsprice implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name = "TICKETOUTLETSPRICE_ID_GENERATOR", sequenceName="SEQ_PUB",allocationSize=1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "TICKETOUTLETSPRICE_ID_GENERATOR")
	private long id;

	private long createby;

	@Temporal(TemporalType.TIMESTAMP)
	private Date createtime;

	private long departstationid;

	private BigDecimal difprice;

	private long reachstationid;

	private long scheduleid;

	private String seats;

	private String seattype;

	private long updateby;
	
	private long ticketoutletsid;
	
	private long orgid;

	@Temporal(TemporalType.TIMESTAMP)
	private Date updatetime;

	private long vehicletypeid;
	private Date starttime;
	private Date endtime;
	
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
	@Transient
	private int distance;
	@Transient
	private BigDecimal fullprice;
	@Transient
	private BigDecimal halfprice;
	@Transient
	private BigDecimal studentprice;
	@Transient
	private BigDecimal moreprice;
	
	public int getDistance() {
		return distance;
	}

	public void setDistance(int distance) {
		this.distance = distance;
	}



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

	public Ticketoutletsprice() {
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

	public BigDecimal getDifprice() {
		return this.difprice;
	}

	public void setDifprice(BigDecimal difprice) {
		this.difprice = difprice;
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
	
	public Long getVehiclebrandmodelid() {
		return vehiclebrandmodelid;
	}

	public void setVehiclebrandmodelid(Long vehiclebrandmodelid) {
		this.vehiclebrandmodelid = vehiclebrandmodelid;
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

	public long getTicketoutletsid() {
		return ticketoutletsid;
	}

	public void setTicketoutletsid(long ticketoutletsid) {
		this.ticketoutletsid = ticketoutletsid;
	}

	public long getOrgid() {
		return orgid;
	}

	public void setOrgid(long orgid) {
		this.orgid = orgid;
	}

	public BigDecimal getFullprice() {
		return fullprice;
	}

	public void setFullprice(BigDecimal fullprice) {
		this.fullprice = fullprice;
	}

	public BigDecimal getHalfprice() {
		return halfprice;
	}

	public void setHalfprice(BigDecimal halfprice) {
		this.halfprice = halfprice;
	}

	public BigDecimal getStudentprice() {
		return studentprice;
	}

	public void setStudentprice(BigDecimal studentprice) {
		this.studentprice = studentprice;
	}

	public BigDecimal getMoreprice() {
		return moreprice;
	}

	public void setMoreprice(BigDecimal moreprice) {
		this.moreprice = moreprice;
	}

	public Date getStarttime() {
		return starttime;
	}

	public void setStarttime(Date starttime) {
		this.starttime = starttime;
	}

	public Date getEndtime() {
		return endtime;
	}

	public void setEndtime(Date endtime) {
		this.endtime = endtime;
	}
	
	
}