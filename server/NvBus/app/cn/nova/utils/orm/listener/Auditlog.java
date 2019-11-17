package cn.nova.utils.orm.listener;

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
 * <b>类描述：</b>数据审计日志实体类<br/>
 * <b>关键修改：</b>原本中心和车站工程分别有实现此实体类，后将统一两者合并到此工程中<br/>
 * <b>修改时间：</b>2012-03-13<br/>
 * <b>修改人：</b><a href="mailto:lanhao@nova.net.cn">兰浩</a><br/>
 */
@Entity
@Table(name="AUDITLOG")
public class Auditlog implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name="AUDITLOG_ID_GENERATOR", sequenceName="SEQ_AUDITLOG",allocationSize=1)
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="AUDITLOG_ID_GENERATOR")
	@Column(unique=true, nullable=false, precision=10)
	private long id;

	@Column(nullable=false, length=2000)
	private String content;

	@Column(nullable=false, length=40)
	private String ip;

  @Temporal( TemporalType.TIMESTAMP)
	@Column(nullable=false)
	private Date occurtime;

	@Column(nullable=false, length=10)
	private String operation;

	@Column(nullable=false, length=50)
	private String sessionid;

	@Column(nullable=false, length=100)
	private String tablename;

	@Column(nullable=false, precision=10)
	private Long userid;

	@Column(nullable=true, precision=10)
	private Long dataid;
	
	public Long getDataid() {
		return dataid;
	}

	public void setDataid(Long dataid) {
		this.dataid = dataid;
	}

	public Auditlog() {
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

	public Date getOccurtime() {
		return this.occurtime;
	}

	public void setOccurtime(Date occurtime) {
		this.occurtime = occurtime;
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

	public void setSessionid(String sessionid) {
		this.sessionid = sessionid;
	}

	public String getTablename() {
		return this.tablename;
	}

	public void setTablename(String tablename) {
		this.tablename = tablename;
	}

	public Long getUserid() {
		return this.userid;
	}

	public void setUserid(Long userid) {
		this.userid = userid;
	}
}