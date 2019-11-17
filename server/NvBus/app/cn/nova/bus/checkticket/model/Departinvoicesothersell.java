package cn.nova.bus.checkticket.model;

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
@Table(name = "DEPARTINVOICESOTHERSELL")
public class Departinvoicesothersell implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name = "DEPARTINVOICESOTHERSELL_ID_GENERATOR", sequenceName = "SEQ_DEPARTINVOICESOTHERSELL", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "DEPARTINVOICESOTHERSELL_ID_GENERATOR")
	@Column(nullable = false, unique = true)
	public Long id;
	/*车票 ID*/
	public Long ticketsellid;
	/*它站运量单（发车凭证） ID*/
	public Long departinvoicesotherdetailid;
	
	public Long createby;

	@Temporal(TemporalType.TIMESTAMP)
	public Date createtime;
	
	public Long updateby;
	
	@Temporal(TemporalType.TIMESTAMP)
	public Date updatetime;

	public Departinvoicesothersell(Long id, Long ticketsellid, Long departinvoicesotherid, Long createby,
			Date createtime, Long updateby, Date updatetime) {
		super();
		this.id = id;
		this.ticketsellid = ticketsellid;
		this.departinvoicesotherdetailid = departinvoicesotherid;
		this.createby = createby;
		this.createtime = createtime;
		this.updateby = updateby;
		this.updatetime = updatetime;
	}

	public Departinvoicesothersell(Long ticketsellid, Long departinvoicesotherid, Long createby, Long updateby) {
		super();
		this.id = 0L;
		this.ticketsellid = ticketsellid;
		this.departinvoicesotherdetailid = departinvoicesotherid;
		this.createby = createby;
		this.createtime = new Date();
		this.updatetime = new Date();
		this.updateby = updateby;
	}
	
	
}
