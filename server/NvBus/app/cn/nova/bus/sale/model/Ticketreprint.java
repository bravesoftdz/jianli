package cn.nova.bus.sale.model;

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

@Entity
@Table(name = "TICKETREPRINT")
public class Ticketreprint implements Serializable {
	/**
	 * serialVersionUID:
	 */
	private static final long serialVersionUID = -4199149007319796184L;

	@Id
	@SequenceGenerator(name = "TICKETREPRINT_ID_GENERATOR", sequenceName = "SEQ_TICKETSELL", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "TICKETREPRINT_ID_GENERATOR")
	@Column(unique = true, nullable = false, precision = 10)
	private long id;
	private Boolean isselfschedule;
	
	private long sellid;
	private long sellorgid;
	private Date departdate;
	private String departtime;
	private String schedulecode;
	private short seatno;
	private String oldticketno;
	private long departstationid;
	private String oldbatchno;
	private long reachstationid;
	private BigDecimal price;
	@Temporal(TemporalType.TIMESTAMP)
	private Date changetime;
	private long changeby;
	private String newticketno;
	private String newbatchno;

	private long sellby;
	@Temporal(TemporalType.TIMESTAMP)
	private Date selltime;
	@Column(nullable = false, precision = 10)
	private Long createby;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(nullable = false)
	private Date createtime;

	@Column(nullable = false, precision = 10)
	private Long updateby;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(nullable = false)
	private Date updatetime;

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public long getSellid() {
		return sellid;
	}

	public void setSellid(long sellid) {
		this.sellid = sellid;
	}

	public long getSellorgid() {
		return sellorgid;
	}

	public void setSellorgid(long sellorgid) {
		this.sellorgid = sellorgid;
	}

	public Date getDepartdate() {
		return departdate;
	}

	public void setDepartdate(Date departdate) {
		this.departdate = departdate;
	}

	public String getDeparttime() {
		return departtime;
	}

	public void setDeparttime(String departtime) {
		this.departtime = departtime;
	}


	public short getSeatno() {
		return seatno;
	}

	public void setSeatno(short seatno) {
		this.seatno = seatno;
	}

	public String getOldticketno() {
		return oldticketno;
	}

	public void setOldticketno(String oldticketno) {
		this.oldticketno = oldticketno;
	}

	public long getDepartstationid() {
		return departstationid;
	}

	public void setDepartstationid(long departstationid) {
		this.departstationid = departstationid;
	}

	public long getReachstationid() {
		return reachstationid;
	}

	public void setReachstationid(long reachstationid) {
		this.reachstationid = reachstationid;
	}

	public BigDecimal getPrice() {
		return price;
	}

	public void setPrice(BigDecimal price) {
		this.price = price;
	}

	public Date getChangetime() {
		return changetime;
	}

	public void setChangetime(Date changetime) {
		this.changetime = changetime;
	}

	public long getChangeby() {
		return changeby;
	}

	public void setChangeby(long changeby) {
		this.changeby = changeby;
	}

	public String getNewticketno() {
		return newticketno;
	}

	public void setNewticketno(String newticketno) {
		this.newticketno = newticketno;
	}

	public long getSellby() {
		return sellby;
	}

	public void setSellby(long sellby) {
		this.sellby = sellby;
	}

	public Date getSelltime() {
		return selltime;
	}

	public void setSelltime(Date selltime) {
		this.selltime = selltime;
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

	public String getOldbatchno() {
		return oldbatchno;
	}

	public void setOldbatchno(String oldbatchno) {
		this.oldbatchno = oldbatchno;
	}

	public String getNewbatchno() {
		return newbatchno;
	}

	public void setNewbatchno(String newbatchno) {
		this.newbatchno = newbatchno;
	}
	public String getSchedulecode() {
		return schedulecode;
	}

	public void setSchedulecode(String schedulecode) {
		this.schedulecode = schedulecode;
	}
	public Boolean getIsselfschedule() {
		return isselfschedule;
	}

	public void setIsselfschedule(Boolean isselfschedule) {
		this.isselfschedule = isselfschedule;
	}

}
