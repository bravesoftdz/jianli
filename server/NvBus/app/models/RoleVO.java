package models;

import java.math.BigDecimal;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

/**
 * The persistent class for the ROLE database table.
 * 
 */
@Entity
@Table(name = "ROLE")
public class RoleVO extends BaseModel {
	public static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name = "ROLE_ID_GENERATOR", sequenceName = "SEQ_PUB", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "ROLE_ID_GENERATOR")
	public long id;

	public String describe;

	public String name;

	public Long orgid;
	public String orgid__display;

	public BigDecimal ticketdiscount;

	public boolean isactive;
	
}