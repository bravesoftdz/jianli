package util.report;

import models.MetaColumn;
import models.MetaForm;
import models.MetaReference;
import models.MetaSubcolumn;
import util.CommonUtil;

/**
 * meta_基础表查询工具类
 * 
 * @author mengjian
 *
 */
public class MetaUtils {

	public static MetaForm findFormByKey(String formkey){
		MetaForm form = MetaForm.find("from MetaForm where formkey = ?",formkey).first();
		if(form == null) {
			throw new RuntimeException("ERROR.FORM.NOT.EXIST");
		}
		return form;
	}
	
	public static MetaColumn findColumnByFormkey(String formkey) {
		MetaForm form = findFormByKey(formkey);
		MetaColumn column = MetaColumn.findById(form.columnid);
		if(column == null) {
			throw new RuntimeException("ERROR.COLUMN.IS.NOT.EXIST");
		}
		return column;
	}
	
	public static MetaColumn findSecColumnByFormkey(String formkey) {
		MetaForm form = findFormByKey(formkey);
		if(form.subcolumnid == null) {
			throw new RuntimeException("ERROR.FORM.RECEIPT.SUBCOLUMN.MUST.NOT.NULL");
		}
		MetaColumn column = MetaColumn.findById(form.subcolumnid);
		if(column == null) {
			throw new RuntimeException("ERROR.COLUMN.IS.NOT.EXIST");
		}
		if(CommonUtil.isEmptyString(column.subforeignkey)){
			throw new RuntimeException("ERROR.SECCOLUMN.FOREIGNKEY.MUST.NOT.NULL");
		}
		return column;
	}
	
	public static MetaSubcolumn findSubcolumnById(Long id) {
		MetaSubcolumn subcolumn = MetaSubcolumn.findById(id);
		if(subcolumn == null) {
			throw new RuntimeException("ERROR.FIELD.IS.NOT.EXIST");
		}
		return subcolumn;
	}
	
	public static MetaReference findReferBySubid(Long fieldid){
		MetaSubcolumn subcolumn = findSubcolumnById(fieldid);
		if(subcolumn.referid == null) {
			throw new RuntimeException("ERROR.FIELD.EDITTYPE.COMBO.REFER.MUST.NOT.NULL");
		}
		MetaReference refer = MetaReference.findById(subcolumn.referid);
		if(refer == null) {
			throw new RuntimeException("ERROR.REFER.NOT.EXIST");
		}
		return refer;
	}
	


}
