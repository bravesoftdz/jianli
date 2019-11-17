package cn.nova.bus.base.model;

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
	 * 票价里程相关</b><br/>
	 * <b>类名称：</b>Insurancetypefares<br/>
	 * <b>创建人：</b>姜蓥瑞<br/>
	 * <b>关键修改：</b><br/>
	 * <b>修改时间：</b><br/>
	 * <b>修改人：</b><br/>
	 *
	 */
	@Entity
	public class Insurancetypefares implements Serializable {
		/**
		 * serialVersionUID:
		 */
		private static final long serialVersionUID = 1L;

		@Id
		@SequenceGenerator(name = "INSURANCETYPE_ID_GENERATOR", sequenceName = "SEQ_PUB", allocationSize = 1)
		@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "INSURANCETYPE_ID_GENERATOR")
		@Column(name = "ID", unique = true, nullable = false, precision = 10, scale = 0)
		private long id;

		private long orgid;

		private long insuretypeid;

		private long fromprice;

		private long endprice;

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

		public long getOrgid() {
			return orgid;
		}

		public void setOrgid(long orgid) {
			this.orgid = orgid;
		}

		public long getInsuretypeid() {
			return insuretypeid;
		}

		public void setInsuretypeid(long insuretypeid) {
			this.insuretypeid = insuretypeid;
		}

		public long getFromprice() {
			return fromprice;
		}

		public void setFromprice(long fromprice) {
			this.fromprice = fromprice;
		}

		public long getEndprice() {
			return endprice;
		}

		public void setEndprice(long endprice) {
			this.endprice = endprice;
		}

		public long getCreateby() {
			return createby;
		}

		public void setCreateby(Long createby) {
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

	
	
	

