package models;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;


@Entity
@Table(name="meta_form")
public class MetaForm extends BaseModel {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@Id
	public Long id;	
	public String formkey;//表单Key
	public String formtitle;//表单标题
	public String listtitle;//列表标题
	public Integer formtype;//表单类型,1-档案2-单据
	public int margintop;//弹出框位置
	public Long columnid;//主表栏位ID
	public Long subcolumnid;//次表栏位ID
	public String pluginname;//后台插件,java文件
	public String listpagejs;//前台插件,js文件
	public String editpagejs;//前台插件,js文件
}