package models;

import java.math.BigDecimal;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.alibaba.fastjson.annotation.JSONField;



@Entity
@Table(name="userinfo")
public class UserInfoVO extends BaseModel {
	/**
	 * 
	 */
	private static final long serialVersionUID = 888848936272406651L;

	@Id
	@SequenceGenerator(name = "USERINFO_ID_GENERATOR", sequenceName = "SEQ_PUB",allocationSize=1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "USERINFO_ID_GENERATOR")
	public long id;

	public String code;

	public String cardno;

	public BigDecimal ticketdiscount;

	public String email;

	public String idcard;

	public Boolean islock;

	public Boolean isactive;

	public Boolean ismultipoint;

	public String name;

	public Long orgid;
	public String orgid__display;

	public String password;

	public String phone;

	public Long departmentid;
	public String departmentid__display;
}
