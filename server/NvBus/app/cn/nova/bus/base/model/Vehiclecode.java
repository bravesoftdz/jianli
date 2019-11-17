/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b>cn.nova.bus.base.model<br/>
 * <b>文件名：</b>Vehiclecode.java<br/>
 * <b>版本信息：</b>v4.0<br/>
 * <b>日期：</b>2013-3-15 上午09:41:48<br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.base.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * <b>类描述：</b><br/>
 * <b>类名称：</b>Vehiclecode.java<br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2013-3-15 上午09:41:48<br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
@Entity
public class Vehiclecode implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Id
	// @SequenceGenerator(name = "VEHICLECODE_ID_GENERATOR", sequenceName =
	// "SEQ_PUB")
	// @GeneratedValue(strategy = GenerationType.SEQUENCE, generator =
	// "VEHICLECODE_ID_GENERATOR")
	private long id;
	private String name;
	private String code;
	@Temporal(TemporalType.TIMESTAMP)
	private Date createtime;
	private long createby;
	@Temporal(TemporalType.TIMESTAMP)
	private Date updatetime;
	private long updateby;
	private String fullname;

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
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

	public String getFullname() {
		return fullname;
	}

	public void setFullname(String fullname) {
		this.fullname = fullname;
	}

}
