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
 * The persistent class for the ROUTEROAD database table.
 * 
 */
@Entity
@Table(name="ROUTEROAD")
public class Routeroad implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name="ROUTEROAD_ID_GENERATOR", sequenceName="SEQ_PUB",allocationSize=1)
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="ROUTEROAD_ID_GENERATOR")
	@Column(unique=true, nullable=false, precision=10)
	private long id;


	private long createby;

    @Temporal( TemporalType.TIMESTAMP)
	@Column(nullable=false)
	private Date createtime;


	private int distance;


	private String entrancename;


	private String exitname;


	private String name;


	private int orderno;


	private String roadgrade;

	//bi-directional many-to-one association to Route
    @ManyToOne
	@JoinColumn(name="ROUTEID", nullable=false)
	private Route route;


	private Long updateby;

    @Temporal( TemporalType.TIMESTAMP)
	private Date updatetime;
    
    //该字段作为记录的操作类型字段，不对数据库表进行映射
    @Transient
    private byte opertype;


    public Routeroad() {
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

	public int getDistance() {
		return this.distance;
	}

	public void setDistance(int distance) {
		this.distance = distance;
	}

	public String getEntrancename() {
		return this.entrancename;
	}

	public void setEntrancename(String entrancename) {
		this.entrancename = entrancename;
	}

	public String getExitname() {
		return this.exitname;
	}

	public void setExitname(String exitname) {
		this.exitname = exitname;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getOrderno() {
		return this.orderno;
	}

	public void setOrderno(int orderno) {
		this.orderno = orderno;
	}

	public String getRoadgrade() {
		return this.roadgrade;
	}

	public void setRoadgrade(String roadgrade) {
		this.roadgrade = roadgrade;
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

	public void setRoute(Route route) {
		this.route = route;
	}

	public Route getRoute() {
		return route;
	}

	public void setOpertype(byte opertype) {
		this.opertype = opertype;
	}

	public byte getOpertype() {
		return opertype;
	}

}