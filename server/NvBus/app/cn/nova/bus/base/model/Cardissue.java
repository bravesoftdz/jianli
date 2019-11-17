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

import cn.nova.bus.system.model.Organization;

@Entity
public class Cardissue implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name = "CARDISSUE_ID_GENERATOR", sequenceName = "SEQ_PUB", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "CARDISSUE_ID_GENERATOR")
	@Column(name = "ID", unique = true, nullable = false, precision = 10, scale = 0)
	private long id;

	@Column(nullable = false)
	private String serialnumber;

	@Column(nullable = false)
	private Long billtypeid;

	@Column(nullable = false)
	private String cardno;

	@Column(nullable = false)
	private String type;

	@Column(nullable = false)
	private Long typeid;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(nullable = false)
	private Date validdate;

	@Column(nullable = false)
	private Long issueby;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(nullable = false)
	private Date issuetime;

	@Column(nullable = false)
	private Long issueorgid;

	@Column(nullable = false)
	private String issueip;

	@Column(nullable = false)
	private String status;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(nullable = false)
	private Date createtime;

	@Column(nullable = false)
	private Long createby;

	@Column(nullable = false)
	private Long updateby;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(nullable = false)
	private Date updatetime;

	@Column(nullable = false)
	private Long ticketoutletsid;

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getSerialnumber() {
		return serialnumber;
	}

	public void setSerialnumber(String serialnumber) {
		this.serialnumber = serialnumber;
	}

	public Long getBilltypeid() {
		return billtypeid;
	}

	public void setBilltypeid(Long billtypeid) {
		this.billtypeid = billtypeid;
	}

	public String getCardno() {
		return cardno;
	}

	public void setCardno(String cardno) {
		this.cardno = cardno;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public Long getTypeid() {
		return typeid;
	}

	public void setTypeid(Long typeid) {
		this.typeid = typeid;
	}

	public Date getValiddate() {
		return validdate;
	}

	public void setValiddate(Date validdate) {
		this.validdate = validdate;
	}

	public Long getIssueby() {
		return issueby;
	}

	public void setIssueby(Long issueby) {
		this.issueby = issueby;
	}

	public Date getIssuetime() {
		return issuetime;
	}

	public void setIssuetime(Date issuetime) {
		this.issuetime = issuetime;
	}

	public Long getIssueorgid() {
		return issueorgid;
	}

	public void setIssueorgid(Long issueorgid) {
		this.issueorgid = issueorgid;
	}

	public String getIssueip() {
		return issueip;
	}

	public void setIssueip(String issueip) {
		this.issueip = issueip;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
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

	public Date getUpdatetime() {
		return updatetime;
	}

	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}

	public Long getTicketoutletsid() {
		return ticketoutletsid;
	}

	public void setTicketoutletsid(Long ticketoutletsid) {
		this.ticketoutletsid = ticketoutletsid;
	}

}
