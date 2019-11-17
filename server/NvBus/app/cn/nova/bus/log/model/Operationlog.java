package cn.nova.bus.log.model;

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
 * The persistent class for the OPERATIONLOG database table.
 * 
 */
@Entity
public class Operationlog implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id	
	@SequenceGenerator(name="OPERATIONLOG_ID_GENERATOR", sequenceName="SEQ_OPERATIONLOG",allocationSize=1)
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="OPERATIONLOG_ID_GENERATOR")
	@Column(unique=true, nullable=false, precision=10)
	private long id;
	
	private String content;
	
	private String ip;

	private String module;

	@Temporal( TemporalType.TIMESTAMP)	
	private Date operatetime;
	
	private String operation;
	
	private String sessionid;
	
	private Long userid;

    public Operationlog() {
    }

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getContent() {
		return this.content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getIp() {
		return this.ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

	public String getModule() {
		return this.module;
	}

	public void setModule(String module) {
		this.module = module;
	}

	public Date getOperatetime() {
		return this.operatetime;
	}

	public void setOperatetime(Date timestamp) {
		this.operatetime = timestamp;
	}

	public String getOperation() {
		return this.operation;
	}

	public void setOperation(String operation) {
		this.operation = operation;
	}

	public String getSessionid() {
		return this.sessionid;
	}

	public Long getUserid() {
		return userid;
	}

	public void setUserid(Long userid) {
		this.userid = userid;
	}

	public void setSessionid(String sessionid) {
		this.sessionid = sessionid;
	}




}