package cn.nova.bus.system.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * The persistent class for the DIGITALDICTIONARYDETAIL database table.
 * 
 */
@Entity
@Table(name = "DIGITALDICTIONARYDETAIL")
public class Digitaldictionarydetail implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name = "DIGITALDICTIONARYDETAIL_ID_GENERATOR", sequenceName="SEQ_PUB",allocationSize=1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "DIGITALDICTIONARYDETAIL_ID_GENERATOR")
	@Column(unique = true, nullable = false, precision = 10)
	private long id;

	@Column(nullable = false, length = 10)
	private String code;

	@Column(nullable = false, precision = 10)
	private Long createby;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(nullable = false)
	private Date createtime;

	@Column(length = 100)
	private String describe;

	@ManyToOne
	@JoinColumn(name = "digitaldictionaryid", nullable = false)
	private Digitaldictionary digitaldictionary;

	@Column(nullable = false, precision = 3)
	private short orderno;

	@Column(precision = 10)
	private long updateby;

	@Temporal(TemporalType.DATE)
	private Date updatetime;

	@Column(nullable = false, length = 50)
	private String value;

	public Digitaldictionarydetail() {
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

	public Long getCreateby() {
		return this.createby;
	}

	public void setCreateby(Long createby) {
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

	public Digitaldictionary getDigitaldictionary() {
		return digitaldictionary;
	}

	public void setDigitaldictionary(Digitaldictionary digitaldictionary) {
		this.digitaldictionary = digitaldictionary;
	}

	public short getOrderno() {
		return this.orderno;
	}

	public void setOrderno(short orderno) {
		this.orderno = orderno;
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

	public String getValue() {
		return this.value;
	}

	public void setValue(String value) {
		this.value = value;
	}

}