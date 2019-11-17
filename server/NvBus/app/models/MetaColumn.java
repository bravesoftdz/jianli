package models;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;


@Entity
@Table(name="meta_column")
public class MetaColumn extends BaseModel {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@Id
	public Long id;
	public String name;//栏位名称
	public Integer isselectedcolumn;//是否有选择列,1是0否,默认1
	public String entityname;//实体名称
	public String returncolumn;//返回列信息
	public String datasource;//列表数据源,sql
	public String subforeignkey;//子表外键
	public String groupby;
	public String pluginname;
	
	public String summarysql;//汇总sql
	public String summarycolumn;//汇总列信息
	
	public String complexheader;
};
