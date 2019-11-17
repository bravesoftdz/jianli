package cn.nova.bus.base.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
/**
 * 
 * <b>类描述：保险类型里程相关</b><br/>
 * <b>类名称：</b>Insuretypedistance<br/>
 * <b>创建人：</b><a href="mailto:lanchengkun@nova.net.cn">兰成坤</a><br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 *
 */
@Entity
public class Insuretypedistance implements Serializable {
	/**
	 * serialVersionUID:
	 */
	private static final long serialVersionUID = 4078801460535314317L;

	@Id
	@SequenceGenerator(name = "INSURETYPEDIS_ID_GENERATOR", sequenceName = "SEQ_PUB", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "INSURETYPEDIS_ID_GENERATOR")
	@Column(name = "ID", unique = true, nullable = false, precision = 10, scale = 0)
	private long id;

	private long orgid;

	private long insuretypeid;

	private long fromdistance;

	private long enddistance;

	private long createby;

	@Temporal(TemporalType.TIMESTAMP)
	private Date createtime;

	private long updateby;

	@Temporal(TemporalType.TIMESTAMP)
	private Date updatetime;

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public long getOrgid() {
		return orgid;
	}

	public void setOrgid(long orgid) {
		this.orgid = orgid;
	}

	public long getInsuretypeid() {
		return insuretypeid;
	}

	public void setInsuretypeid(long insuretypeid) {
		this.insuretypeid = insuretypeid;
	}

	public long getFromdistance() {
		return fromdistance;
	}

	public void setFromdistance(long fromdistance) {
		this.fromdistance = fromdistance;
	}

	public long getEnddistance() {
		return enddistance;
	}

	public void setEnddistance(long enddistance) {
		this.enddistance = enddistance;
	}

	public long getCreateby() {
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

	public long getUpdateby() {
		return updateby;
	}

	public void setUpdateby(long updateby) {
		this.updateby = updateby;
	}

	public Date getUpdatetime() {
		return updatetime;
	}

	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}
}
