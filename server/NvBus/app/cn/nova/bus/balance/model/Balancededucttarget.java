package cn.nova.bus.balance.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;


/**
 * The persistent class for the BALANCEDEDUCTTARGET database table.
 * 
 */
@Entity
public class Balancededucttarget implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name="BALANCEDEDUCTTARGET_ID_GENERATOR", sequenceName="SEQ_PUB",allocationSize=1)
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="BALANCEDEDUCTTARGET_ID_GENERATOR")
	private long id;

	private long createby;

    @Temporal( TemporalType.TIMESTAMP)
	private Date createtime;

	private String description;

	private boolean isactive;

	private String name;

	private short prioritylevel;

	private long updateby;

    @Temporal( TemporalType.TIMESTAMP)
	private Date updatetime;

    public Balancededucttarget() {
    }

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
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

	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public boolean getIsactive() {
		return this.isactive;
	}

	public void setIsactive(boolean isactive) {
		this.isactive = isactive;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public short getPrioritylevel() {
		return this.prioritylevel;
	}

	public void setPrioritylevel(short prioritylevel) {
		this.prioritylevel = prioritylevel;
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

}