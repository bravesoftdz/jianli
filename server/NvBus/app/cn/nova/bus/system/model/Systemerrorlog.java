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
 * 系统日志管理
 * The persistent class for the SYSTEMLOG database table.
 * @author huanghaoze
 */
@Entity
@Table(name="SYSTEMERRORLOG")
public class Systemerrorlog implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name="SYSTEMERRORLOG_ID_GENERATOR", sequenceName="SEQ_SYSTEMERRORLOG",allocationSize=1)
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="SYSTEMERRORLOG_ID_GENERATOR")
	@Column(unique=true, nullable=false, precision=10)
	private long id;

	@Column(nullable=false, length=40)
	private String ip;

    @Temporal( TemporalType.TIMESTAMP)
	@Column(nullable=false)
	private Date occurtime;

	@Column(nullable=false, length=100)
	private String module;

	@Column(nullable=false, length=2000)
	private String content;

	@Column(nullable=false, length=50)
	private String sessionid;

	@Column(nullable=false, precision=10)
	private Long userid;

    public Systemerrorlog() {
    }
    public String toString(){
    	return "Systemerrorlog [id="+id+", ip= "+ip+", occurtime="+occurtime+", module="+module
    			+", content="+content+", sessionid="+sessionid+", userid="+userid+"]";
    }
	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getIp() {
		return this.ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

	public String getSessionid() {
		return this.sessionid;
	}

	public void setSessionid(String sessionid) {
		this.sessionid = sessionid;
	}

	public Long getUserid() {
		return this.userid;
	}

	public void setUserid(Long userid) {
		this.userid = userid;
	}

	public Date getOccurtime() {
		return occurtime;
	}

	public void setOccurtime(Date occurtime) {
		this.occurtime = occurtime;
	}

	public String getModule() {
		return module;
	}

	public void setModule(String module) {
		this.module = module;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

}