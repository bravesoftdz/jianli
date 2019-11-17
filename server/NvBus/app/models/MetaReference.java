package models;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;


@Entity
@Table(name="meta_reference")
public class MetaReference extends BaseModel {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@Id
	public Long id;
	public Integer panelwidth;//面板宽度
	public String idfield;//提交字段
	public String textfield;//显示字段
	public String field;//参与查询的字段列表
	public String returnfield;//返回列
	public String datasource;//sql
};
