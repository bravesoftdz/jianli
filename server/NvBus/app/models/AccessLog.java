package models;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import play.db.jpa.GenericModel;

@Entity
@Table(name="accesslog")
public class AccessLog extends GenericModel{
	@Id
	@SequenceGenerator(name = "ACCESSLOG_ID_GENERATOR", sequenceName = "SEQ_ACCESSLOG", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "ACCESSLOG_ID_GENERATOR")
	@Column(name = "ID", unique = true, nullable = false, precision = 10, scale = 0)
	public long id;
	
	public int type; // 0车站  1socket 2webserver 
	
	public String ip;
	public String method;
	
	public String params;
	public Date occurtime;
	
	public long userid;
	public String usercode;
	
	public long ticketoutletid;
	public String ticketoutletcode;
}
