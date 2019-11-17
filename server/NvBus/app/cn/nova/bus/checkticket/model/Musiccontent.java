package cn.nova.bus.checkticket.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
public class Musiccontent implements Serializable {

	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name = "MUSIC_ID_GENERATOR", sequenceName = "SEQ_BOYIN")
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "MUSIC_ID_GENERATOR")
	private long id;

	private String content;

	@Temporal(TemporalType.TIMESTAMP)
	private Date departtime;

	private String orgname;
	
	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getOrgname() {
		return orgname;
	}

	public void setOrgname(String orgname) {
		this.orgname = orgname;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getDeparttime() {
		return departtime;
	}

	public void setDeparttime(Date departtime) {
		this.departtime = departtime;
	}
}
