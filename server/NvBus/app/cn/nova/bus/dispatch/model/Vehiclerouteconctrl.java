package cn.nova.bus.dispatch.model;

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
	@Entity
	@Table(name = "VEHICLEROUTECONCTRL")
	public class Vehiclerouteconctrl implements Serializable {
		private static final long serialVersionUID = 1L;

		@Id
		@SequenceGenerator(name = "VEHICLEROUTECONCTRL_ID_GENERATOR", sequenceName = "SEQ_PUB", allocationSize = 1)
		@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "VEHICLEROUTECONCTRL_ID_GENERATOR")
		@Column(name = "ID", unique = true, nullable = false, precision = 10, scale = 0)
		private Long id;

		private long vehicleid;

		private long scheduleid;
		
		private long routeid;

		private long orgid;

		private long createby;
		
		@Column(nullable = false)
		@Temporal(TemporalType.TIMESTAMP)
		private Date createtime;

		private long updateby;
		
		@Column(nullable = false)
		@Temporal(TemporalType.TIMESTAMP)
		private Date updatetime;
		
		
		public Long getId() {
			return id;
		}
		public void setId(Long id) {
			this.id = id;
		}
		public long getVehicleid() {
			return vehicleid;
		}
		public void setVehicleid(long vehicleid) {
			this.vehicleid = vehicleid;
		}
		public long getScheduleid() {
			return scheduleid;
		}
		public void setScheduleid(long scheduleid) {
			this.scheduleid = scheduleid;
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
		public long getRouteid() {
			return routeid;
		}
		public void setRouteid(long routeid) {
			this.routeid = routeid;
		}
		

}
