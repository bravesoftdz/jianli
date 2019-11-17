package cn.nova.bus.report.model;
import java.io.Serializable;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import cn.nova.utils.business.BusinessFieldType;

@Entity
@Table(name="SCHEDULEUPLOADIDX")
public class Scheduleuploadidx implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name = "SCHEDULEUPLOADIDX_ID_GENERATOR", sequenceName = "SEQ_SCHEDULEUPLOADIDX", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SCHEDULEUPLOADIDX_ID_GENERATOR")
	private long id;

	private String idxtype;

	@Temporal(TemporalType.DATE)
	private Date departdate;

	private String schtype;

	private String orgcode;
	
	private long idxnum;
	public String getIdxtype() {
		return idxtype;
	}

	public void setIdxtype(String idxtype) {
		this.idxtype = idxtype;
	}

	public Date getDepartdate() {
		return departdate;
	}

	public void setDepartdate(Date departdate) {
		this.departdate = departdate;
	}

	public String getSchtype() {
		return schtype;
	}

	public void setSchtype(String schtype) {
		this.schtype = schtype;
	}

	public String getOrgcode() {
		return orgcode;
	}

	public void setOrgcode(String orgcode) {
		this.orgcode = orgcode;
	}

	public long getIdxnum() {
		return idxnum;
	}

	public void setIdxnum(long idxnum) {
		this.idxnum = idxnum;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	private Long createby;
	private Long updateby;
	@Temporal(TemporalType.TIMESTAMP)
	private Date createtime;

	@Temporal(TemporalType.TIMESTAMP)
	private Date updatetime;

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	

	public Long getCreateby() {
		return createby;
	}

	public void setCreateby(Long createby) {
		this.createby = createby;
	}

	public Long getUpdateby() {
		return updateby;
	}

	public void setUpdateby(Long updateby) {
		this.updateby = updateby;
	}

	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	public Date getUpdatetime() {
		return updatetime;
	}

	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}

}
