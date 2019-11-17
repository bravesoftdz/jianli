package cn.nova.bus.base.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;


/**
 * The persistent class for the ROUTESTOP database table.
 * 
 */
@Entity
@Table(name="ROUTESTOP")
public class Routestop implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name="ROUTESTOP_ID_GENERATOR", sequenceName="SEQ_ROUTESTOP",allocationSize=1)
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="ROUTESTOP_ID_GENERATOR")
	@Column(unique=true, nullable=false, precision=10)
	private long id;


	private int balancedistance;


	private Long createby;

    @Temporal( TemporalType.TIMESTAMP)
	@Column(nullable=false)
	private Date createtime;


	private int distance;


	private boolean isactive;

	private int orderno;


	private long stationid;


	private Long updateby;

    @Temporal( TemporalType.TIMESTAMP)
	private Date updatetime;

	//bi-directional many-to-one association to Route
    @ManyToOne
	@JoinColumn(name="ROUTEID", nullable=false)
	private Route route;
    
    //该字段作为记录的操作类型字段，不对数据库表进行映射
    @Transient
    private byte opertype;
    

	private boolean isdepart;
    
    public boolean isIsdepart() {
		return isdepart;
	}

	public void setIsdepart(boolean isdepart) {
		this.isdepart = isdepart;
	}

	public Routestop() {
    }

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public int getBalancedistance() {
		return this.balancedistance;
	}

	public void setBalancedistance(int balancedistance) {
		this.balancedistance = balancedistance;
	}

	public Long getCreateby() {
		return this.createby;
	}

	public void setCreateby(Long createby) {
		this.createby = createby;
	}

	public Date getCreatetime() {
		return this.createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	public int getDistance() {
		return this.distance;
	}

	public void setDistance(int distance) {
		this.distance = distance;
	}

	public boolean getIsactive() {
		return this.isactive;
	}

	public void setIsactive(boolean isactive) {
		this.isactive = isactive;
	}

	public int getOrderno() {
		return this.orderno;
	}

	public void setOrderno(int orderno) {
		this.orderno = orderno;
	}

	public long getStationid() {
		return this.stationid;
	}

	public void setStationid(long stationid) {
		this.stationid = stationid;
	}

	public Long getUpdateby() {
		return this.updateby;
	}

	public void setUpdateby(Long updateby) {
		this.updateby = updateby;
	}

	public Date getUpdatetime() {
		return this.updatetime;
	}

	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}

	public Route getRoute() {
		return this.route;
	}

	public void setRoute(Route route) {
		this.route = route;
	}

	public void setOpertype(byte opertype) {
		this.opertype = opertype;
	}

	public byte getOpertype() {
		return opertype;
	}
	
}