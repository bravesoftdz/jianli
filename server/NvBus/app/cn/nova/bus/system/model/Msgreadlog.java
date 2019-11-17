package cn.nova.bus.system.model;

import java.io.Serializable;
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
 * The persistent class for the MSGREADLOG database table.
 * 
 */
@Entity
@Table(name="MSGREADLOG")
public class Msgreadlog implements Serializable {
	private static final long serialVersionUID = 1L;
	@Id
	@SequenceGenerator(name = "MSGREADLOG_ID_GENERATOR", sequenceName="SEQ_PUB",allocationSize=1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "MSGREADLOG_ID_GENERATOR")
	@Column(unique=true, nullable=false, precision=10)
	private long id;
	
	@Column(nullable=false, precision=10)
	private Long userid;
	
	@Column(nullable=false, precision=10)
	private Long msgid;
	
	@Column(nullable=false, length=20)
	private String msgtype;
	
	@Temporal(TemporalType.TIMESTAMP)
	private Date readtime;

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public Long getUserid() {
		return userid;
	}

	public void setUserid(Long userid) {
		this.userid = userid;
	}

	public String getMsgtype() {
		return msgtype;
	}

	public void setMsgtype(String msgtype) {
		this.msgtype = msgtype;
	}

	public Date getReadtime() {
		return readtime;
	}

	public void setReadtime(Date readtime) {
		this.readtime = readtime;
	}

	public Long getMsgid() {
		return msgid;
	}

	public void setMsgid(Long msgid) {
		this.msgid = msgid;
	}
	

}
