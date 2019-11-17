/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b>cn.nova.bus.base<br/>
 * <b>文件名：</b>Ticketdiscount.java<br/>
 * <b>版本信息：</b>v4.0<br/>
 * <b>日期：</b>2013-1-9 上午09:00:29<br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.base.model;

import java.math.BigDecimal;
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
 * <b>类描述：</b><br/>
 * <b>类名称：</b>Ticketdiscount.java<br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2013-1-9 上午09:00:29<br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
@Entity
@Table(name = "TICKETDISCOUNT")
public class Ticketdiscount {

	@Id
	@SequenceGenerator(name = "TICKETDISCOUNT_ID_GENERATOR", sequenceName = "SEQ_PUB", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "TICKETDISCOUNT_ID_GENERATOR")
	@Column(unique = true, nullable = false, precision = 10)
	private long id;

	private String tickettype;

	private String datatype;

	private long dataid;

	@Temporal(TemporalType.DATE)
	private Date startdate;

	@Temporal(TemporalType.DATE)
	private Date enddate;

	private int sellnum;

	private BigDecimal mindiscountrate;

	private BigDecimal defaultdiscountrate;

	private long orgid;

	private long createby;

	@Temporal(TemporalType.TIMESTAMP)
	private Date createtime;

	private long updateby;

	@Temporal(TemporalType.TIMESTAMP)
	private Date updatetime;

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getTickettype() {
		return tickettype;
	}

	public void setTickettype(String tickettype) {
		this.tickettype = tickettype;
	}

	public String getDatatype() {
		return datatype;
	}

	public void setDatatype(String datatype) {
		this.datatype = datatype;
	}

	public long getDataid() {
		return dataid;
	}

	public void setDataid(long dataid) {
		this.dataid = dataid;
	}

	public Date getStartdate() {
		return startdate;
	}

	public void setStartdate(Date startdate) {
		this.startdate = startdate;
	}

	public Date getEnddate() {
		return enddate;
	}

	public void setEnddate(Date enddate) {
		this.enddate = enddate;
	}

	public int getSellnum() {
		return sellnum;
	}

	public void setSellnum(int sellnum) {
		this.sellnum = sellnum;
	}

	public BigDecimal getMindiscountrate() {
		return mindiscountrate;
	}

	public void setMindiscountrate(BigDecimal mindiscountrate) {
		this.mindiscountrate = mindiscountrate;
	}

	public BigDecimal getDefaultdiscountrate() {
		return defaultdiscountrate;
	}

	public void setDefaultdiscountrate(BigDecimal defaultdiscountrate) {
		this.defaultdiscountrate = defaultdiscountrate;
	}

	public long getOrgid() {
		return orgid;
	}

	public void setOrgid(long orgid) {
		this.orgid = orgid;
	}

	public long getCreateby() {
		return createby;
	}

	public void setCreateby(long createby) {
		this.createby = createby;
	}

	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	public long getUpdateby() {
		return updateby;
	}

	public void setUpdateby(long updateby) {
		this.updateby = updateby;
	}

	public Date getUpdatetime() {
		return updatetime;
	}

	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}

}
