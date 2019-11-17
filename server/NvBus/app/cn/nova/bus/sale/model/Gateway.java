package cn.nova.bus.sale.model;

import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 *  @author zhangqingfeng
 */
@Entity
@Table(name = "GATEWAY")
public class Gateway implements java.io.Serializable {

	// Fields

	private String id;
	private Integer paywaytype;
	private Integer paytradename;
	private String paytradenameval;
	private String picturepath;
	private String bankcode;
	private String bankname;
	private Date createtime;
	private Date updatetime;

	// Constructors

	/** default constructor */
	public Gateway() {
	}

	/** minimal constructor */
	public Gateway(String id) {
		this.id = id;
	}

	/** full constructor */
	public Gateway(String id, Integer paywaytype, Integer paytradename,
			String paytradenameval, String picturepath, String bankcode,
			String bankname, Date createtime, Date updatetime) {
		this.id = id;
		this.paywaytype = paywaytype;
		this.paytradename = paytradename;
		this.paytradenameval = paytradenameval;
		this.picturepath = picturepath;
		this.bankcode = bankcode;
		this.bankname = bankname;
		this.createtime = createtime;
		this.updatetime = updatetime;
	}

	// Property accessors
	@Id
	@Column(name = "ID", unique = true, nullable = false, length = 20)
	public String getId() {
		return this.id;
	}

	public void setId(String id) {
		this.id = id;
	}

	@Column(name = "PAYWAYTYPE", precision = 3, scale = 0)
	public Integer getPaywaytype() {
		return this.paywaytype;
	}

	public void setPaywaytype(Integer paywaytype) {
		this.paywaytype = paywaytype;
	}

	@Column(name = "PAYTRADENAME", precision = 3, scale = 0)
	public Integer getPaytradename() {
		return this.paytradename;
	}

	public void setPaytradename(Integer paytradename) {
		this.paytradename = paytradename;
	}

	@Column(name = "PAYTRADENAMEVAL", length = 50)
	public String getPaytradenameval() {
		return this.paytradenameval;
	}

	public void setPaytradenameval(String paytradenameval) {
		this.paytradenameval = paytradenameval;
	}

	@Column(name = "PICTUREPATH", length = 200)
	public String getPicturepath() {
		return this.picturepath;
	}

	public void setPicturepath(String picturepath) {
		this.picturepath = picturepath;
	}

	@Column(name = "BANKCODE", length = 20)
	public String getBankcode() {
		return this.bankcode;
	}

	public void setBankcode(String bankcode) {
		this.bankcode = bankcode;
	}

	@Column(name = "BANKNAME", length = 30)
	public String getBankname() {
		return this.bankname;
	}

	public void setBankname(String bankname) {
		this.bankname = bankname;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "CREATETIME", length = 7)
	public Date getCreatetime() {
		return this.createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "UPDATETIME", length = 7)
	public Date getUpdatetime() {
		return this.updatetime;
	}

	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}

}