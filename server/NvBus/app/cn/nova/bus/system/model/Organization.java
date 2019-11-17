package cn.nova.bus.system.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EntityListeners;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

import cn.nova.bus.base.model.District;
import cn.nova.bus.base.model.Station;
import cn.nova.bus.base.model.Unit;
import cn.nova.utils.orm.listener.SyncCodeGenerate;

/**
 * The persistent class for the ORGANIZATION database table.
 * 
 * @author lijh
 */
@Entity
@EntityListeners({ SyncCodeGenerate.class })
public class Organization implements Serializable {
	private static final long serialVersionUID = -4032361175654528988L;

	@Id
	@SequenceGenerator(name = "ORGANIZATION_ID_GENERATOR", sequenceName = "SEQ_PUB", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "ORGANIZATION_ID_GENERATOR")
	@Column(name = "ID", unique = true, nullable = false, precision = 10, scale = 0)
	private long id;

	@Column(nullable = false)
	private String code;

	private String contactperson;

	private String contactphone;

	@Column(nullable = false)
	private long createby;

	@Column(nullable = false)
	@Temporal(TemporalType.TIMESTAMP)
	private Date createtime;

	private String describe;

	@Column(nullable = false)
	private String name;

	@ManyToOne
	@JoinColumn(name = "PARENTID", nullable = true)
	Organization organ;

	@Column(nullable = true)
	private String serversaddress;

	@ManyToOne
	@JoinColumn(name = "STATIONID", nullable = true)
	private Station station;

	private String ticketserversaddress;

	@Column(nullable = false)
	private String type;

	@ManyToOne
	@JoinColumn(name = "UNITID", nullable = true)
	private Unit unit;

	@Column(nullable = false)
	private long updateby;

	@Column(nullable = false)
	@Temporal(TemporalType.TIMESTAMP)
	private Date updatetime;

	// 该字段作为记录的操作类型字段，不对数据库表进行映射
	@Transient
	private String opertype;

	private String address;

	@Column(nullable = false)
	private boolean islocal;

	@Column(nullable = false)
	private boolean isactive;

	@ManyToOne
	@JoinColumn(name = "DISTRICTID", nullable = true)
	private District district;

	@Column(nullable = false, length = 40)
	private String synccode;

	@Column(precision = 5, nullable = true)
	private Integer connectcosttime;

	@Column(nullable = false, precision = 1)
	private boolean isonline;

	@Override
	public String toString() {
		StringBuilder sb = new StringBuilder();
		sb.append("Organization [id=").append(id).append(", code=")
				.append(code).append(", contactperson=").append(contactperson)
				.append(", contactphone=").append(contactphone)
				.append(", createby=").append(createby).append(", createtime=")
				.append(createtime).append(", describe=").append(describe)
				.append(", name=").append(name).append(", serversaddress=")
				.append(serversaddress).append(", stationid=").append(station)
				.append(", ticketserversaddress=").append(ticketserversaddress)
				.append(", type=").append(type).append(", unitid=")
				.append(unit).append(", updateby=").append(updateby)
				.append(", updatetime=").append(updatetime).append("]");
		return sb.toString();
	}

	public Organization() {
	}

	public void setSynccode(String synccode) {
		this.synccode = synccode;
	}

	public String getSynccode() {
		return synccode;
	}

	public String getOpertype() {
		return opertype;
	}

	public void setOpertype(String opertype) {
		this.opertype = opertype;
	}

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getCode() {
		return this.code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getContactperson() {
		return this.contactperson;
	}

	public void setContactperson(String contactperson) {
		this.contactperson = contactperson;
	}

	public String getContactphone() {
		return contactphone;
	}

	public void setContactphone(String contactphone) {
		this.contactphone = contactphone;
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

	public String getDescribe() {
		return this.describe;
	}

	public void setDescribe(String describe) {
		this.describe = describe;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getServersaddress() {
		return this.serversaddress;
	}

	public void setServersaddress(String serversaddress) {
		this.serversaddress = serversaddress;
	}

	public String getTicketserversaddress() {
		return this.ticketserversaddress;
	}

	public void setTicketserversaddress(String ticketserversaddress) {
		this.ticketserversaddress = ticketserversaddress;
	}

	public String getType() {
		return this.type;
	}

	public void setType(String type) {
		this.type = type;
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

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public boolean isIsactive() {
		return isactive;
	}

	public boolean getIsactive() {
		return isactive;
	}

	public void setIsactive(boolean isactive) {
		this.isactive = isactive;
	}

	public Station getStation() {
		return station;
	}

	public void setStation(Station station) {
		this.station = station;
	}

	public Unit getUnit() {
		return unit;
	}

	public void setUnit(Unit unit) {
		this.unit = unit;
	}

	public boolean isIslocal() {
		return islocal;
	}

	public boolean getIslocal() {
		return islocal;
	}

	public void setIslocal(boolean islocal) {
		this.islocal = islocal;
	}

	public String getServersaddressIp() {
		if (null == getServersaddress())
			return null;
		int index = getServersaddress().indexOf(":");
		if (index < 0) {
			return getServersaddress();
		} else {
			return getServersaddress().substring(0, index);
		}
	}

	public String getServersaddressPort() {
		if (null == getServersaddress())
			return null;
		int index = getServersaddress().indexOf(":");
		if (index < 0) {
			return "3700";
		} else {
			return getServersaddress().substring(index + 1);
		}
	}

	public Organization getOrgan() {
		return organ;
	}

	public void setOrgan(Organization organ) {
		this.organ = organ;
	}
	/*
	public boolean isPeikedian() {
		return getType().equals("1");
	}*/

	public void setDistrict(District district) {
		this.district = district;
	}

	public District getDistrict() {
		return district;
	}

	public Integer getConnectcosttime() {
		return connectcosttime;
	}

	public void setConnectcosttime(Integer connectcosttime) {
		this.connectcosttime = connectcosttime;
	}

	public boolean getIsonline() {
		return isonline;
	}

	public void setIsonline(boolean isonline) {
		this.isonline = isonline;
	}
}