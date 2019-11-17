package models;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

@Entity
@Table(name="meta_subcolumn")
public class MetaSubcolumn extends BaseModel {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@SequenceGenerator(name = "METASUBCOLUMN_ID_GENERATOR", sequenceName = "SEQ_PUB", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "METASUBCOLUMN_ID_GENERATOR")
	public Long id;
	public Long columnid;//主栏位ID
	public String name;//栏位名称,与字段同值
	
	public String querytype;
	public Integer iscondition;//是否查询条件,1是0否,默认0
	public Integer isintervalcondition;//是否区间条件,1是0否,默认0
	public Integer conditionorder;//查询条件顺序
	public String conditiondefaultvalue;//条件默认值
	public boolean ismulti; //是否多选
	
	public String field;//字段
	public String title;//标题
	public String align;//对齐方式,left、center、right,默认left
	public String format;//格式化代码
	public Integer listwidth;//列表宽度
	public Integer listlocation;//列表位置
	public Integer listisdisplay;//字段是否在列表中显示,1是0否,默认1
	
	public Integer edittype;//编辑类型（1-input,2-hidden,3-textarea,4-select,5-checkbox,6-date,7-combo）
	public Integer editorder;//编辑顺序
	public Integer editwidth;//编辑宽度值,1、2
	public Integer editheight;//编辑高度
	public Integer isdisplay;//是否显示,1是0否,默认1
	public Integer ismustenter;//是否必输,1是0否,默认0
	public Integer isreadonly;//是否只读,1是0否,默认0
	public Integer inputlength;//输入长度
	public String enumerate;//枚举类型,用于下拉列表等
	public String digitsql;//sql语句,用于下拉框
	public String editdefaultvalue;//编辑默认值
	public String editformattype;//编辑格式化串(邮件、证件号码、电话等)
	
	public Integer ispersistence;//是否可持久化,1是0否,默认1
	public Integer isrepeatable;//是否可重复（档案,唯一校验字段）,1是0否,默认0
	public Long referid;//参照表ID
	public String fileattributes;//对应档案属性
	public Integer isdomain;//是否领域字段
	public boolean iscontrol;//是否权限控制
	public String ptitle;
	
	public boolean isdynamicadd;//是否动态扩展,1表示横向动态扩展,0表示纵向扩展
	public String dynamicaddsql;//动态扩展列对应sql语句
	
	public MetaSubcolumn copy(){
		MetaSubcolumn copyvo = new MetaSubcolumn();
		copyvo.id=this.id;
		copyvo.columnid=this.columnid;
		copyvo.name=this.name;
				
		copyvo.querytype=this.querytype;
		copyvo.iscondition=this.iscondition;
		copyvo.isintervalcondition=this.isintervalcondition;
		copyvo.conditionorder=this.conditionorder;
		copyvo.conditiondefaultvalue=this.conditiondefaultvalue;
		copyvo.ismulti=this.ismulti;
				
		copyvo.field=this.field;
		copyvo.title=this.title;
		copyvo.align=this.align;
		copyvo.format=this.format;
		copyvo.listwidth=this.listwidth;
		copyvo.listlocation=this.listlocation;
		copyvo.listisdisplay=this.listisdisplay;
				
		copyvo.edittype=this.edittype;
		copyvo.editorder=this.editorder;
		copyvo.editwidth=this.editwidth;
		copyvo.editheight=this.editheight;
		copyvo.isdisplay=this.isdisplay;
		copyvo.ismustenter=this.ismustenter;
		copyvo.isreadonly=this.isreadonly;
		copyvo.inputlength=this.inputlength;
		copyvo.enumerate=this.enumerate;
		copyvo.digitsql=this.digitsql;
		copyvo.editdefaultvalue=this.editdefaultvalue;
		copyvo.editformattype=this.editformattype;
				
		copyvo.ispersistence=this.ispersistence;
		copyvo.isrepeatable=this.isrepeatable;
		copyvo.referid=this.referid;
		copyvo.fileattributes=this.fileattributes;
		copyvo.isdomain=this.isdomain;
		copyvo.iscontrol=this.iscontrol;
		copyvo.ptitle=this.ptitle;
				
		copyvo.isdynamicadd=this.isdynamicadd;
		copyvo.dynamicaddsql=this.dynamicaddsql;
		return copyvo;
	}
	
}
