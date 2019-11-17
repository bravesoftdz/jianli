package cn.nova.bus.system.model;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;


/**
 * 
 * <p>
 * Title: 保存数据集控件信息
 * </p>
 * <p>
 * Description:
 * </p>
 * <p>
 * Copyright: Copyright (c) 2011
 * </p>
 * <p>
 * Company: nova
 * </p>
 * 
 * @author lanckun
 * @version 0.1
 */

@Entity
public class GridField implements Serializable{
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name="GRIDFIELD_ID_GENERATOR", sequenceName="SEQ_PUB",allocationSize=1)
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="GRIDFIELD_ID_GENERATOR")
	private long id;

	private String componentname;

	private String fieldname;

	private Long fieldno;

	private boolean isvisible;

	private Long userid;

	private Long width;

    public GridField() {
    }

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getComponentname() {
		return this.componentname;
	}

	public void setComponentname(String componentname) {
		this.componentname = componentname;
	}

	public String getFieldname() {
		return this.fieldname;
	}

	public void setFieldname(String fieldname) {
		this.fieldname = fieldname;
	}

	public Long getFieldno() {
		return this.fieldno;
	}

	public void setFieldno(Long fieldno) {
		this.fieldno = fieldno;
	}

	public boolean getIsvisible() {
		return this.isvisible;
	}

	public void setIsvisible(boolean isvisible) {
		this.isvisible = isvisible;
	}

	public Long getUserid() {
		return this.userid;
	}

	public void setUserid(Long userid) {
		this.userid = userid;
	}

	public Long getWidth() {
		return this.width;
	}

	public void setWidth(Long width) {
		this.width = width;
	}

}