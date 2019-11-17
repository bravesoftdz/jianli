package cn.nova.bus.base.model;

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

/**
 * Stationstandard entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "STATIONSTANDARD")
public class Stationstandard implements java.io.Serializable {

	// Fields

	private long id;
	private String code;
	private String province;
	private String city;
	private String area;
	private String stationname;
	private String stationaddress;
	private Date createtime;
	private long createby;
	private Date updatetime;
	private long updateby;
	private String name;

	// Property accessors
	@Id
	@SequenceGenerator(name = "STATION_ID_GENERAT", sequenceName = "SEQ_PUB", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "STATION_ID_GENERAT")
	@Column(nullable = false, unique = true)
	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	@Column(name = "CODE", nullable = false, length = 20)
	public String getCode() {
		return this.code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	@Column(name = "PROVINCE", length = 20)
	public String getProvince() {
		return this.province;
	}

	public void setProvince(String province) {
		this.province = province;
	}

	@Column(name = "CITY", length = 50)
	public String getCity() {
		return this.city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	@Column(name = "AREA", length = 50)
	public String getArea() {
		return this.area;
	}

	public void setArea(String area) {
		this.area = area;
	}

	@Column(name = "STATIONNAME", length = 100)
	public String getStationname() {
		return this.stationname;
	}

	public void setStationname(String stationname) {
		this.stationname = stationname;
	}

	@Column(name = "STATIONADDRESS", length = 200)
	public String getStationaddress() {
		return this.stationaddress;
	}

	public void setStationaddress(String stationaddress) {
		this.stationaddress = stationaddress;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "CREATETIME", nullable = false, length = 7)
	public Date getCreatetime() {
		return this.createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	@Column(name = "CREATEBY", nullable = false, precision = 10, scale = 0)
	public long getCreateby() {
		return this.createby;
	}

	public void setCreateby(long createby) {
		this.createby = createby;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "UPDATETIME", nullable = false, length = 7)
	public Date getUpdatetime() {
		return this.updatetime;
	}

	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}

	@Column(name = "UPDATEBY", nullable = false, precision = 10, scale = 0)
	public long getUpdateby() {
		return this.updateby;
	}

	public void setUpdateby(long updateby) {
		this.updateby = updateby;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

}