/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b>cn.nova.bus.archive.model<br/>
 * <b>文件名：</b>Vipremainmoneytransfer.java<br/>
 * <b>版本信息：</b>v4.0<br/>
 * <b>日期：</b>2013-3-12 上午09:27:13<br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.archive.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EntityListeners;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import cn.nova.utils.orm.listener.SyncCodeGenerate;

/**
 * <b>类描述：</b><br/>
 * <b>类名称：</b>Vipremainmoneytransfer.java<br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2013-3-12 上午09:27:13<br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
@Entity
@EntityListeners({ SyncCodeGenerate.class})
public class Vipremainmoneytransfer implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name = "VIPREMAINMONEYTRANSFER_ID_GENERATOR", sequenceName = "SEQ_PUB")
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "VIPREMAINMONEYTRANSFER_ID_GENERATOR")
	private long id;
	@Column(nullable=false, precision=10)
	private long oldvipid;
	
	@Column(nullable=false, precision=10)
	private long newvipid;
	
	private BigDecimal money;
	private BigDecimal vipamount;
	@Temporal(TemporalType.TIMESTAMP)
	private Date createtime;
	private long createby;
	@Temporal(TemporalType.TIMESTAMP)
	private Date updatetime;
	private long updateby;
	@Column(nullable = false, length = 40)
	private String synccode;
	
	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public long getOldvipid() {
		return oldvipid;
	}

	public void setOldvipid(long oldvipid) {
		this.oldvipid = oldvipid;
	}

	public long getNewvipid() {
		return newvipid;
	}

	public void setNewvipid(long newvipid) {
		this.newvipid = newvipid;
	}

	public BigDecimal getMoney() {
		return money;
	}

	public void setMoney(BigDecimal money) {
		this.money = money;
	}

	public BigDecimal getVipamount() {
		return vipamount;
	}

	public void setVipamount(BigDecimal vipamount) {
		this.vipamount = vipamount;
	}

	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	public long getCreateby() {
		return createby;
	}

	public void setCreateby(long createby) {
		this.createby = createby;
	}

	public Date getUpdatetime() {
		return updatetime;
	}

	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}

	public long getUpdateby() {
		return updateby;
	}

	public void setUpdateby(long updateby) {
		this.updateby = updateby;
	}

	public String getSynccode() {
		return synccode;
	}

	public void setSynccode(String synccode) {
		this.synccode = synccode;
	}

}
