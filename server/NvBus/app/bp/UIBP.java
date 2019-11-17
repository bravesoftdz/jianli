package bp;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.Query;

import models.BPException;
import models.MetaColumn;
import models.MetaForm;
import models.MetaReference;
import models.MetaSubcolumn;
import play.db.jpa.JPA;
import util.AppContrast;
import util.CommonUtil;
import util.CurrentUtil;
import util.DateUtils;
import bpinterface.UIInterface;

import com.alibaba.fastjson.JSON;

public class UIBP implements UIInterface{
	public MetaForm findFormByKey(String formkey){
		MetaForm form = MetaForm.find("from MetaForm where formkey = ?",formkey).first();
		if(form == null) {
			throw new RuntimeException("ERROR.FORM.NOT.EXIST");
		}
		return form;
	}
	
	public MetaColumn findColumnByFormkey(String formkey) {
		MetaForm form = findFormByKey(formkey);
		MetaColumn column = MetaColumn.findById(form.columnid);
		if(column == null) {
			throw new RuntimeException("ERROR.COLUMN.IS.NOT.EXIST");
		}
		return column;
	}
	
	public MetaColumn findSecColumnByFormkey(String formkey) {
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
	
	public MetaSubcolumn findSubcolumnById(Long id) {
		MetaSubcolumn subcolumn = MetaSubcolumn.findById(id);
		if(subcolumn == null) {
			throw new RuntimeException("ERROR.FIELD.IS.NOT.EXIST");
		}
		return subcolumn;
	}
	
	public MetaReference findReferBySubid(Long fieldid){
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
	
	public String tableColumns(String formkey) throws Exception{
		MetaColumn column = findColumnByFormkey(formkey);
		if(CommonUtil.isNotEmptyString(column.complexheader)){//3级或3级以上的复杂表头
			return column.complexheader;
		}else{
			return getHeaderWithin2(column);
		}
	}

	/**
	 * 拼装表头,1级和2级
	 * @param column
	 * @return
	 * @throws Exception 
	 */
	private String getHeaderWithin2(MetaColumn column) throws Exception {
		List<MetaSubcolumn> columnlist = MetaSubcolumn.find("from MetaSubcolumn where columnid = ? order by listlocation", column.id).fetch();
		Map<String, List<MetaSubcolumn>> map = new HashMap<String, List<MetaSubcolumn>>();
		List list = null;
		StringBuilder sb = new StringBuilder();
		sb.append("[[");
		if(column.isselectedcolumn.intValue() == AppContrast.TURE) {
			sb.append("{checkbox:true,field:\"xxx\",rowspan:2},");
		}
		for(MetaSubcolumn obj : columnlist){
			if(CommonUtil.isNotEmptyString(obj.ptitle)){
				if(map.containsKey(obj.ptitle)){
					map.get(obj.ptitle).add(obj);
				}else{
					list = new ArrayList<MetaSubcolumn>();
					list.add(obj);
					map.put(obj.ptitle, list);
					
					int len = ((BigDecimal) (JPA
							.em()
							.createNativeQuery(
									"select count(t.id) from meta_subcolumn t where t.ptitle = ? and t.columnid = ?")
							.setParameter(1, obj.ptitle)
							.setParameter(2, obj.columnid).getSingleResult()))
							.intValue();
					
					sb.append("{title:\"")
							.append(obj.ptitle)
							.append("\",colspan:")
							.append(len).append("},");
				}
			}else{
				sb = appendColumn(sb, 2, obj);//Column
			}
			
		}
		if(!columnlist.isEmpty()){
			sb.deleteCharAt(sb.length()-1);
		}
		sb.append("],[");
		List<List<MetaSubcolumn>> msLists = new ArrayList<List<MetaSubcolumn>>(map.values());
		Collections.sort(msLists, new Comparator(){
			@Override
			public int compare(Object o1, Object o2) {
				if (o1 == null || o2 == null) {
					return 0;
				} 
				List<MetaSubcolumn> ele1 = (List<MetaSubcolumn>)o1;
				List<MetaSubcolumn> ele2 = (List<MetaSubcolumn>)o2;
				return ele1.get(0).listlocation - ele2.get(0).listlocation;
			}
			
		});
		for (List<MetaSubcolumn> msList: msLists) {
			for(MetaSubcolumn sobj : msList){
				sb = appendColumn(sb, 1, sobj);//Column Group
			}
		}
		if(!map.isEmpty()){
			sb.deleteCharAt(sb.length()-1);
		}
		sb.append("]]");
		return sb.toString();
	}

	/**
	 * 添加表格列头信息
	 * @param sb
	 * @param rowspan	Column单独列rowspan为2,Column Group父列下的子列rowspan为1
	 * @param sobj
	 * @return
	 * @throws Exception 
	 */
	private StringBuilder appendColumn(StringBuilder sb, int rowspan,
			MetaSubcolumn sobj) throws Exception {
		String fieldname = "";
		try {
			fieldname = sobj.field.split("!")[1].toLowerCase();
		} catch (Exception e) {
			throw new RuntimeException("元数据字段表字段名格式错误,格式:表名!字段名");
		}
		if(sobj.listisdisplay.intValue() == AppContrast.FALSE) {
			sb.append("{")
			.append("field:\"").append(fieldname).append("\",")
			.append("hidden:true")
			.append("},");
		}else{
			sb.append("{")
			.append("field:\"").append(fieldname).append("\",")
			.append("title:\"").append(sobj.title).append("\",")
			.append("width:").append(sobj.listwidth).append(",")
			.append("halign:\"center\",")
			.append("rowspan:").append(rowspan).append(",")
			.append("align:\"").append(sobj.align).append("\"");
			if(sobj.edittype.intValue() == AppContrast.INPUT_COMBO){
				sb.append(",formatter:").append("function(value,row,index){return row.").append(fieldname).append("__display}");
			}else if(sobj.edittype.intValue() == AppContrast.INPUT_SELECT || sobj.edittype.intValue() == AppContrast.INPUT_DIGITSELECT){
				sb.append(",formatter:").append(selectFormatterFunction(sobj));
			}else if(CommonUtil.isNotEmptyString(sobj.format)){
				sb.append(",formatter:").append(sobj.format);
			}
			sb.append("},");
		}
		return sb;
	}
	
	/**
	 * 下拉框的fomatter涵数
	 * @param col
	 * @return
	 * @throws Exception
	 */
	private String selectFormatterFunction(MetaSubcolumn col) throws Exception{
		StringBuilder sb = new StringBuilder();
		sb.append("function(value,row,index){");
		int type = col.edittype.intValue();
		if(type == AppContrast.INPUT_SELECT){
			try {
				String[] options =  col.enumerate.split(",");
				for(int i = 0; i < options.length; i++){
					String[] opt = options[i].split("-");
					if(i == 0){
						sb.append("if(value == '").append(opt[0]).append("'){return '").append(opt[1]).append("'}");
					}else{
						sb.append("else if(value == '").append(opt[0]).append("'){return '").append(opt[1]).append("'}");
					}
				}
			} catch (Exception e) {
				throw new BPException("下拉框的数据格式错误");
			}
		}else if(type == AppContrast.INPUT_DIGITSELECT){
			String sql = col.digitsql;
			Query query = JPA.em().createNativeQuery(sql);
			try {
				List<?> list = query.getResultList();
				for(int i = 0; i < list.size(); i++){
					Object[] opt  = (Object[]) list.get(i);
					if(i == 0){
						sb.append("if(value == '").append(opt[0]).append("'){return '").append(opt[1]).append("'}");
					}else{
						sb.append("else if(value == '").append(opt[0]).append("'){return '").append(opt[1]).append("'}");
					}
				}
			} catch (Exception e) {
				throw new BPException("数据下拉框的查询语句错误");
			}
		}
		sb.append("}");
		return sb.toString();
		
	}
	
	public String getselect(String formkey){
		MetaForm form = findFormByKey(formkey);
		List<MetaSubcolumn> columnlist = MetaSubcolumn.find("from MetaSubcolumn where columnid = ? order by listlocation", form.columnid).fetch();
		StringBuilder sb = new StringBuilder();
		String fieldname = null;
		for(MetaSubcolumn obj : columnlist) {
			try {
				fieldname = obj.field.replace("!", ".").toLowerCase();
			} catch (Exception e) {
				throw new RuntimeException("元数据字段表字段名格式错误,格式:表名!字段名");
			}
			if(obj.listisdisplay.intValue() != AppContrast.FALSE) {
				if(obj.edittype.intValue() == AppContrast.INPUT_COMBO){
					sb.append(fieldname).append("__display,");
				}else if(CommonUtil.isNotEmptyString(obj.format)){
					sb.append(fieldname).append(",");
				}
			}
		}
		return sb.toString();
	}
	
	public String conditionHtml(Long columnid){
		List<MetaSubcolumn> conditionlist = MetaSubcolumn.find("from MetaSubcolumn where columnid = ? and iscondition = 1 order by conditionorder",columnid).fetch();
		if(conditionlist.isEmpty()){//没有查询条件
			return "";
		}
		
		StringBuilder sb = new StringBuilder();
		sb.append("<div class=\"panel panel-default\" id=\"query\">")
		.append("<div class=\"panel-heading\">")
		.append("<h4 class=\"panel-title\">")
		.append("<a data-toggle=\"collapse\" data-toggle=\"collapse\" href=\"#collapseOne\">查询条件</a>")
		.append("</h4>")
		.append("</div>")
		.append("<div id=\"collapseOne\" class=\"panel-collapse collapse in\">")
		.append("<div class=\"panel-body\">")
		.append("<form id=\"searchform\">")
		.append("<div class=\"row\">");
		
		//动态生成查询条件	
		String fieldname = null;
		for(MetaSubcolumn obj : conditionlist) {
			//id=prefix#field#suffix
			try {
				fieldname = obj.field.split("!")[1].toLowerCase();
			} catch (Exception e) {
				throw new RuntimeException("元数据字段表字段名格式错误,格式:表名!字段名");
			}
			if(obj.isintervalcondition.intValue() == AppContrast.TURE) {
				String low = "s_" + fieldname + "_low";
				String up = "s_" + fieldname + "_up";
				String fieldLow = queryfieldHtml(low, obj);
				String fieldUp = queryfieldHtml(up, obj);
				sb.append("<div class=\"col-xs-3\">")//下限
				.append("<div class=\"form-group\">")
				.append("<label class=\"col-xs-4 control-label\" for=\"").append(low).append("\">")
				.append("<span class=\"title\">").append(obj.title).append("</span>")
				.append("</label>")
				.append("<div class=\"col-xs-8\">")
				.append(fieldLow)
				.append("</div>")
				.append("</div>")
				.append("</div>")
				.append("<div class=\"col-xs-3\">")//上限
				.append("<div class=\"form-group\">")
				.append("<label class=\"col-xs-4 control-label\" for=\"").append(up).append("\">").append("<span class=\"title\">").append("至").append("</span>").append("</label>")
				.append("<div class=\"col-xs-8\">")
				.append(fieldUp)
				.append("</div>")
				.append("</div>")
				.append("</div>");
			}else{
				String inputid = "s_" + fieldname;
				String fieldhtml = queryfieldHtml(inputid, obj);
				sb.append("<div class=\"col-xs-3\">")
				.append("<div class=\"form-group\">")
				.append("<label class=\"col-xs-4 control-label\" for=\"").append(inputid).append("\">").append("<span class=\"title\">").append(obj.title).append("</span>").append("</label>")
				.append("<div class=\"col-xs-8\">")
				.append(fieldhtml)
				.append("</div>")
				.append("</div>")
				.append("</div>");
			}
		}
		sb.append("</div>")
		.append("</form>")
		.append("</div>")
		.append("</div>")
		.append("</div>");
		return sb.toString();
	}
	
	public String formHtml(String formkey) {
		MetaForm form = findFormByKey(formkey);
		List<MetaSubcolumn> sublist = MetaSubcolumn.find("from MetaSubcolumn where columnid = ? order by editorder", form.columnid).fetch();
		StringBuilder sb = new StringBuilder();
		String fieldname = null;
		
		int labelwidth = 4;
		int inputwidth = 8;
		if(form.formtype.intValue() == AppContrast.FORM_RECEIPT){
			labelwidth = 5;
			inputwidth = 7;
		}
		for(MetaSubcolumn obj : sublist) {
			try {
				fieldname = obj.field.split("!")[1].toLowerCase();
			} catch (Exception e) {
				throw new RuntimeException("元数据字段表字段名格式错误,格式:表名!字段名");
			}
			String inputid = "e_" + fieldname;
			if(obj.edittype.intValue() == AppContrast.INPUT_HIDDEN) {
				sb.append(editfieldHtml(inputid, obj));
			}else{
				int width = obj.editwidth > 12 ? 12 : obj.editwidth;//最大只能为12
				sb.append("<div class=\"col-xs-").append(width);
				if(obj.isdisplay.intValue() == AppContrast.FALSE){
					sb.append(" self-display");
				}
				sb.append("\">")
				.append("<div class=\"form-group\">")
				.append("<label class=\"col-xs-").append(labelwidth).append(" control-label\" for=\"").append(inputid).append("\">");
				if(obj.ismustenter.intValue() == AppContrast.TURE){
					sb.append("<span class=\"mark\">*</span>");
				}
				sb.append("<span class=\"title\">").append(obj.title).append("</span>")
				.append("</label>")
				.append("<div class=\"col-xs-").append(inputwidth).append("\">")
				.append(editfieldHtml(inputid, obj))
				.append("</div>")
				.append("</div>")
				.append("</div>");
			}
		}
		return sb.toString();
	}

	public String listModuleSettings(String formkey) {
		MetaForm form = findFormByKey(formkey);
		List<MetaSubcolumn> datefields = MetaSubcolumn.find("from MetaSubcolumn where columnid = ? order by editorder", form.columnid).fetch();
		Map<String,List<Map<String,Object>>> outerMap = new HashMap<String, List<Map<String,Object>>>();
		List<Map<String,Object>> datetimepickerlist = new ArrayList<Map<String,Object>>();
		List<Map<String,Object>> combogridlist = new ArrayList<Map<String,Object>>();
		for(MetaSubcolumn obj : datefields){
			if(obj.edittype.intValue() == AppContrast.INPUT_DATE) {
				if(obj.isintervalcondition.intValue() == AppContrast.TURE) {
					datetimepickerlist.add(setOptions("s", obj, "low"));
					datetimepickerlist.add(setOptions("s", obj, "up"));
				}else if(obj.iscondition.intValue() == AppContrast.TURE) {
					datetimepickerlist.add(setOptions("s", obj, ""));
				}
				if(form.formtype == AppContrast.FORM_FILE){
					datetimepickerlist.add(setOptions("e", obj, ""));
				}
			}else if(obj.edittype.intValue() == AppContrast.INPUT_COMBO){
				if(obj.isintervalcondition.intValue() == AppContrast.TURE) {
					combogridlist.add(setOptions("s", obj, "low"));
					combogridlist.add(setOptions("s", obj, "up"));
				}else if(obj.iscondition.intValue() == AppContrast.TURE) {
					combogridlist.add(setOptions("s", obj, ""));
				}
				if(form.formtype == AppContrast.FORM_FILE){
					combogridlist.add(setOptions("e", obj, ""));
				}
			}
		}
		outerMap.put("datetimepicker", datetimepickerlist);
		outerMap.put("combogrid", combogridlist);
		return JSON.toJSONString(outerMap);
	}

	public String editModuleSettings(String formkey) {
		MetaForm form = findFormByKey(formkey);
		List<MetaSubcolumn> datefields = MetaSubcolumn.find("from MetaSubcolumn where columnid = ? order by editorder", form.columnid).fetch();
		Map<String,List<Map<String,Object>>> outerMap = new HashMap<String, List<Map<String,Object>>>();
		List<Map<String,Object>> datetimepickerlist = new ArrayList<Map<String,Object>>();
		List<Map<String,Object>> combogridlist = new ArrayList<Map<String,Object>>();
		for(MetaSubcolumn obj : datefields){
			if(obj.edittype.intValue() == AppContrast.INPUT_DATE) {
				datetimepickerlist.add(setOptions("e", obj, ""));
			}else if(obj.edittype.intValue() == AppContrast.INPUT_COMBO){
				combogridlist.add(setOptions("e", obj, ""));
			}
		}
		outerMap.put("datetimepicker", datetimepickerlist);
		outerMap.put("combogrid", combogridlist);
		return JSON.toJSONString(outerMap);
	}
	
	public String operateHtml(String formkey) {
		return "";
	}
	
	/**
	 * 生成查询条件中各种类型的表单组件
	 * @param inputid
	 * @param sub
	 * @return
	 */
	private String queryfieldHtml(String inputid,MetaSubcolumn obj) {
		//name=id#field
		//number date combo 处理
		String str = "";
		if(obj.field.contains("__")){
			str = obj.field.split("__")[0];
		}else{
			str = obj.field;
		}
		String name = obj.id + "#" + str;
		String defaultVal = obj.conditiondefaultvalue;
		int inputType = obj.edittype.intValue();
		StringBuilder sb = null;
		if(inputType == AppContrast.INPUT_TEXT) {
			sb = new StringBuilder();
			sb.append("<input class=\"form-control input-sm");
			if(CommonUtil.isNotEmptyString(obj.editformattype)){
				sb.append(" self-check");
			}
			if(obj.isdomain.intValue() == AppContrast.TURE) {
				sb.append(" self-domain");
			}
			sb.append("\" id=\"").append(inputid).append("\" name=\"").append(name).append("\" type=\"text\"");
			if(CommonUtil.isNotEmptyString(defaultVal)){
				sb.append(" value=\"").append(defaultVal).append("\"");
			}
			if(CommonUtil.isNotEmptyString(obj.editformattype)){
				sb.append(" format=\"").append(obj.editformattype).append("\"");
			}
			sb.append(">");
			return sb.toString();
		}else if(inputType == AppContrast.INPUT_NUMBER) {
			sb = new StringBuilder();
			sb.append("<input class=\"form-control input-sm self-number");
			if(obj.isdomain.intValue() == AppContrast.TURE) {
				sb.append(" self-domain");
			}
			sb.append("\" id=\"").append(inputid).append("\" name=\"").append(name).append("\" type=\"text\"");
			if(CommonUtil.isNotEmptyString(defaultVal)){
				sb.append(" value=\"").append(defaultVal).append("\"");
			}
			sb.append(">");
			return sb.toString();
		}else if(inputType == AppContrast.INPUT_PASSWORD) {
			sb = new StringBuilder();
			sb.append("<input class=\"form-control input-sm");
			if(obj.isdomain.intValue() == AppContrast.TURE) {
				sb.append(" self-domain");
			}
			sb.append("\" id=\"").append(inputid).append("\" name=\"").append(name).append("\" type=\"password\"");
			if(CommonUtil.isNotEmptyString(defaultVal)){
				sb.append(" value=\"").append(defaultVal).append("\"");
			}
			sb.append(">");
			return sb.toString();
		}else if(inputType == AppContrast.INPUT_HIDDEN) {
			sb = new StringBuilder();
			sb.append("<input");
			if(obj.isdomain.intValue() == AppContrast.TURE) {
				sb.append(" class=\"self-domain\"");
			}
			sb.append(" id=\"").append(inputid).append("\" name=\"").append(name).append("\" type=\"hidden\"");
			if(CommonUtil.isNotEmptyString(defaultVal)){
				sb.append(" value=\"").append(defaultVal).append("\"");
			}
			sb.append(">");
			return sb.toString();
		}else if(inputType == AppContrast.INPUT_SELECT) {
			sb = new StringBuilder();
			sb.append("<select class=\"form-control input-sm");
			if(obj.isdomain.intValue() == AppContrast.TURE) {
				sb.append(" self-domain");
			}
			if(obj.ismulti){
				sb.append(" self-multi");
			}
			sb.append("\" id=\"").append(inputid).append("\" name=\"").append(name).append("\"");
			if(obj.ismulti){
				sb.append(" multiple = \"multiple\"");
			}
			sb.append(">");
			if(!obj.ismulti){
				sb.append("<option value=\"\">请选择</option>");
			}
			try {
				String[] options =  obj.enumerate.split(",");
				for(String option : options) {
					String[] opt = option.split("-");
					sb.append("<option value=\"").append(opt[0]).append("\"");
					if(opt[0].equals(defaultVal)){
						sb.append(" selected=\"selected\"");
					}
					sb.append(">").append(opt[1]).append("</option>");
				}
			} catch (Exception e) {
				throw new RuntimeException("ERROR.FIELD.ENUM.FORMAT.IS.WRONG");
			}
			sb.append("</select>");
			return sb.toString();
		}else if(inputType == AppContrast.INPUT_DIGITSELECT) {
			sb = new StringBuilder();
			sb.append("<select class=\"form-control input-sm");
			if(obj.isdomain.intValue() == AppContrast.TURE) {
				sb.append(" self-domain");
			}
			if(obj.ismulti){
				sb.append(" self-multi");
			}
			sb.append("\" id=\"").append(inputid).append("\" name=\"").append(name).append("\"");
			if(obj.ismulti){
				sb.append(" multiple = \"multiple\"");
			}
			sb.append(">");
			if(!obj.ismulti){
				sb.append("<option value=\"\">请选择</option>");
			}
			try {
				String sql = obj.digitsql;
				Query query = JPA.em().createNativeQuery(sql);
				List<?> list = query.getResultList();
				Object[] arr = null;
				for(Object item : list){
					arr = (Object[]) item;
					sb.append("<option value=\"").append(arr[0]).append("\"");
					if(arr[0].equals(defaultVal)){
						sb.append(" selected=\"selected\"");
					}
					sb.append(">").append(arr[1]).append("</option>");
				}
			} catch (Exception e) {
				throw new RuntimeException("表查询下拉框的数据源sql错误!");
			}
			sb.append("</select>");
			return sb.toString();
		}else if(inputType == AppContrast.INPUT_CHECKBOX) {
			sb = new StringBuilder();
			sb.append("<div class=\"checkbox\">")
			.append("<label>")
			.append("<input");
			if(obj.isdomain.intValue() == AppContrast.TURE) {
				sb.append(" class=\"self-domain\"");
			}
			sb.append(" id=\"").append(inputid).append("\" name=\"").append(name).append("\" type=\"checkbox\" value=\"1\"");
			if("1".equals(defaultVal)) {
				sb.append(" checked=\"checked\"");
			}
			sb.append(">");
			sb.append("</label>")
			.append("</div>");
			return sb.toString();
		}else if(inputType == AppContrast.INPUT_TEXTAREA) {
			sb = new StringBuilder();
			sb.append("<textarea class=\"form-control input-sm");
			if(obj.isdomain.intValue() == AppContrast.TURE) {
				sb.append(" self-domain");
			}
			sb.append("\" id=\"").append(inputid).append("\" name=\"").append(name).append("\">");
			if(CommonUtil.isNotEmptyString(defaultVal)){
				sb.append(defaultVal);
			}
			sb.append("</textarea>");
			return sb.toString();
		}else if(inputType == AppContrast.INPUT_DATE) {
			sb = new StringBuilder();
			sb.append("<input class=\"form-control input-sm self-date self-readonly");
			if(obj.isdomain.intValue() == AppContrast.TURE) {
				sb.append(" self-domain");
			}
			sb.append("\" id=\"").append(inputid).append("\" name=\"").append(name).append("\" type=\"text\"");
			if(CommonUtil.isNotEmptyString(defaultVal)){
				sb.append(" value=\"").append(defaultVal).append("\"");
			}
			sb.append(" >");
			return sb.toString();
		}else if(inputType == AppContrast.INPUT_COMBO) {
			sb = new StringBuilder();
			sb.append("<input class=\"form-control input-sm");
			if(obj.isdomain.intValue() == AppContrast.TURE) {
				sb.append(" self-domain");
			}
			sb.append("\" id=\"").append(inputid).append("\" name=\"").append(name).append("\" type=\"text\"");
			if(CommonUtil.isNotEmptyString(defaultVal)){
				sb.append(" value=\"").append(defaultVal).append("\"");
			}
			sb.append(">");
			return sb.toString();
		}else{
			throw new RuntimeException("ERROR.FIELD.EDITTYPE.IS.WRONG");
		}
	}
	
	/**
	 * 生成编辑表单中各种类型的表单组件
	 * 相对queryfieldHtml添加是否必填，是否只读控制
	 * @param sub
	 * @return
	 */
	private String editfieldHtml(String inputid,MetaSubcolumn obj) {
		//name=id#field
		//number date combo 处理
		String str = "";
		if(obj.field.contains("__")){
			str = obj.field.split("__")[0];
		}else{
			str = obj.field;
		}
		String name = obj.id + "#" + str;
		int isrequired = obj.ismustenter.intValue();
		int isreadonly = obj.isreadonly.intValue();
		String defaultVal = obj.editdefaultvalue;
		Integer maxlength = obj.inputlength;
		int inputType = obj.edittype.intValue();
		StringBuilder sb = null;
		if(inputType == AppContrast.INPUT_TEXT) {
			sb = new StringBuilder();
			sb.append("<input class=\"form-control input-sm");
			if(isrequired == AppContrast.TURE) {
				sb.append(" self-required");
			}else{
				sb.append(" self-norequired");
			}
			if(isreadonly == AppContrast.TURE) {
				sb.append(" self-readonly");
			}
			if(CommonUtil.isNotEmptyString(obj.editformattype)){
				sb.append(" self-check");
			}
			if(obj.isdomain.intValue() == AppContrast.TURE) {
				sb.append(" self-domain");
			}
			sb.append("\" id=\"").append(inputid).append("\" name=\"").append(name).append("\" type=\"text\"");
			if(CommonUtil.isNotEmptyString(defaultVal)){
				sb.append(" value=\"").append(defaultVal).append("\"");
			}
			if(maxlength!=null){
				sb.append(" maxlength=\"").append(maxlength).append("\"");
			}
			if(CommonUtil.isNotEmptyString(obj.editformattype)){
				sb.append(" format=\"").append(obj.editformattype).append("\"");
			}
			sb.append(">");
			return sb.toString();
		}else if(inputType == AppContrast.INPUT_NUMBER) {
			sb = new StringBuilder();
			sb.append("<input class=\"form-control input-sm self-number");
			if(isrequired == AppContrast.TURE) {
				sb.append(" self-required");
			}else{
				sb.append(" self-norequired");
			}
			if(isreadonly == AppContrast.TURE) {
				sb.append(" self-readonly");
			}
			if(obj.isdomain.intValue() == AppContrast.TURE) {
				sb.append(" self-domain");
			}
			sb.append("\" id=\"").append(inputid).append("\" name=\"").append(name).append("\" type=\"text\"");
			if(CommonUtil.isNotEmptyString(defaultVal)){
				sb.append(" value=\"").append(defaultVal).append("\"");
			}
			if(maxlength!=null){
				sb.append(" maxlength=\"").append(maxlength).append("\"");
			}
			sb.append(">");
			return sb.toString();
		}else if(inputType == AppContrast.INPUT_PASSWORD) {
			sb = new StringBuilder();
			sb.append("<input class=\"form-control input-sm");
			if(isrequired == AppContrast.TURE) {
				sb.append(" self-required");
			}else{
				sb.append(" self-norequired");
			}
			if(isreadonly == AppContrast.TURE) {
				sb.append(" self-readonly");
			}
			if(obj.isdomain.intValue() == AppContrast.TURE) {
				sb.append(" self-domain");
			}
			sb.append("\" id=\"").append(inputid).append("\" name=\"").append(name).append("\" type=\"password\"");
			if(CommonUtil.isNotEmptyString(defaultVal)){
				sb.append(" value=\"").append(defaultVal).append("\"");
			}
			if(maxlength!=null){
				sb.append(" maxlength=\"").append(maxlength).append("\"");
			}
			sb.append(">");
			return sb.toString();
		}else if(inputType == AppContrast.INPUT_HIDDEN) {
			sb = new StringBuilder();
			sb.append("<input");
			if(obj.isdomain.intValue() == AppContrast.TURE) {
				sb.append(" class=\"self-domain\"");
			}
			sb.append(" id=\"").append(inputid).append("\" name=\"").append(name).append("\" type=\"hidden\"");
			if(CommonUtil.isNotEmptyString(defaultVal)){
				sb.append(" value=\"").append(defaultVal).append("\"");
			}
			sb.append(">");
			return sb.toString();
		}else if(inputType == AppContrast.INPUT_SELECT) {
			sb = new StringBuilder();
			sb.append("<select class=\"form-control input-sm");
			if(obj.isdomain.intValue() == AppContrast.TURE) {
				sb.append(" self-domain");
			}
			sb.append("\" id=\"").append(inputid).append("\" name=\"").append(name).append("\">");
			try {
				String[] options =  obj.enumerate.split(",");
				for(String option : options) {
					String[] opt = option.split("-");
					sb.append("<option value=\"").append(opt[0]).append("\"");
					if(opt[0].equals(defaultVal)){
						sb.append(" selected=\"selected\"");
					}
					sb.append(">").append(opt[1]).append("</option>");
				}
			} catch (Exception e) {
				throw new RuntimeException("ERROR.FIELD.ENUM.FORMAT.IS.WRONG");
			}
			sb.append("</select>");
			return sb.toString();
		}else if(inputType == AppContrast.INPUT_CHECKBOX) {
			sb = new StringBuilder();
			sb.append("<div class=\"checkbox\">")
			.append("<label>")
			.append("<input");
			if(obj.isdomain.intValue() == AppContrast.TURE) {
				sb.append(" class=\"self-domain\"");
			}
			sb.append(" id=\"").append(inputid).append("\" name=\"").append(name).append("\" type=\"checkbox\" value=\"1\"");
			if("1".equals(defaultVal)) {
				sb.append(" checked=\"checked\"");
			}
			sb.append(">");
			sb.append("</label>")
			.append("</div>");
			return sb.toString();
		}else if(inputType == AppContrast.INPUT_TEXTAREA) {
			sb = new StringBuilder();
			sb.append("<textarea class=\"form-control input-sm");
			if(isrequired == AppContrast.TURE) {
				sb.append(" self-required");
			}else{
				sb.append(" self-norequired");
			}
			if(isreadonly == AppContrast.TURE) {
				sb.append(" self-readonly");
			}
			if(obj.isdomain.intValue() == AppContrast.TURE) {
				sb.append(" self-domain");
			}
			sb.append("\" id=\"").append(inputid).append("\" name=\"").append(name).append("\">");
			if(CommonUtil.isNotEmptyString(defaultVal)){
				sb.append(defaultVal);
			}
			sb.append("</textarea>");
			return sb.toString();
		}else if(inputType == AppContrast.INPUT_DATE) {
			sb = new StringBuilder();
			sb.append("<input class=\"form-control input-sm self-date self-readonly");
			if(isrequired == AppContrast.TURE) {
				sb.append(" self-required");
			}else{
				sb.append(" self-norequired");
			}
			if(obj.isdomain.intValue() == AppContrast.TURE) {
				sb.append(" self-domain");
			}
			sb.append("\" id=\"").append(inputid).append("\" name=\"").append(name).append("\" type=\"text\"");
			if(CommonUtil.isNotEmptyString(defaultVal)){
				sb.append(" value=\"").append(defaultVal).append("\"");
			}else if(isrequired == AppContrast.TURE){
				Date date = new Date();
				String dateToStr = DateUtils.DateToStr(date);
				sb.append(" value=\"").append(dateToStr).append("\"");
			}
			sb.append(" placeholder=\"请选择\">");
			return sb.toString();
		}else if(inputType == AppContrast.INPUT_COMBO) {
			sb = new StringBuilder();
			sb.append("<input class=\"form-control input-sm self-combo");
			if(isrequired == AppContrast.TURE) {
				sb.append(" self-required");
			}else{
				sb.append(" self-norequired");
			}
			if(isreadonly == AppContrast.TURE) {
				sb.append(" self-readonly");
			}
			if(obj.isdomain.intValue() == AppContrast.TURE) {
				sb.append(" self-domain");
			}
			sb.append("\" id=\"").append(inputid).append("\" name=\"").append(name).append("\" type=\"text\"");
			if(CommonUtil.isNotEmptyString(defaultVal)){
				sb.append(" defaultvalue=\"").append(defaultVal).append("\"");
			}
			sb.append(" >");
			return sb.toString();
		}else if(inputType == AppContrast.INPUT_DIGITSELECT) {
			sb = new StringBuilder();
			sb.append("<select class=\"form-control input-sm");
			if(obj.isdomain.intValue() == AppContrast.TURE) {
				sb.append(" self-domain");
			}
			sb.append("\" id=\"").append(inputid).append("\" name=\"").append(name).append("\">");
			
			try {
				String sql = obj.digitsql;
				Query query = JPA.em().createNativeQuery(sql);
				List<?> list = query.getResultList();
				Object[] arr = null;
				for(Object item : list){
					arr = (Object[]) item;
					sb.append("<option value=\"").append(arr[0]).append("\"");
					if(arr[0].equals(defaultVal)){
						sb.append(" selected=\"selected\"");
					}
					sb.append(">").append(arr[1]).append("</option>");
				}
			} catch (Exception e) {
				throw new RuntimeException("表查询下拉框的数据源sql错误!");
			}
			sb.append("</select>");
			return sb.toString();
		}else{
			throw new RuntimeException("ERROR.FIELD.EDITTYPE.IS.WRONG");
		}
	}
	
	/**
	 * 时间和自动完成组件的配置信息
	 * @param prefix
	 * @param obj
	 * @param suffix
	 * @return
	 */
	private Map<String,Object> setOptions(String prefix,MetaSubcolumn obj,String suffix){
		Map<String,Object> map = new HashMap<String,Object>();
		StringBuilder sb = new StringBuilder();
		String fieldname = null;
		try {
			fieldname = obj.field.split("!")[1].toLowerCase();
		} catch (Exception e) {
			throw new RuntimeException("元数据字段表字段名格式错误,格式:表名!字段名");
		}
		String idstr = prefix + "_" + fieldname;
		if(CommonUtil.isNotEmptyString(suffix)){
			idstr += "_" + suffix;
		}
		if(obj.edittype.intValue() == AppContrast.INPUT_DATE){
			map.put("id", idstr);
			map.put("format", obj.editformattype);
			return map;
		}else if(obj.edittype.intValue() == AppContrast.INPUT_COMBO){
			MetaReference refer = findReferBySubid(obj.id);
			map.put("id", idstr);
			map.put("panelwidth",refer.panelwidth);
			map.put("idfield",refer.idfield);
			map.put("textfield",refer.textfield);
			map.put("columns",refer.returnfield);
			if(CommonUtil.isNotEmptyString(obj.fileattributes)){
				try {
					String[] item = null;
					for(String str : obj.fileattributes.split(",")){
						item = str.split("-");
						idstr = prefix + "_" + item[0];
						sb.append(idstr).append("-").append(item[1]).append(",");
					}
					sb.deleteCharAt(sb.length()-1);
				} catch (Exception e) {
					throw new RuntimeException("ERROR.FIELD.FILLATTRIBUTES.FORMAT.WRONG");
				}
			}
			map.put("relations",sb.toString());
			return map;
		}else{
			throw new RuntimeException("ERROR.FIELD.NOT.SUPPORT.PLUGIN");
		}
	}

	public String editortableColumns(String formkey){
		MetaForm form = findFormByKey(formkey);
		List<MetaSubcolumn> columnlist = MetaSubcolumn.find("from MetaSubcolumn where columnid = ? order by listlocation", form.subcolumnid).fetch();
		StringBuilder sb = new StringBuilder();
		sb.append("[[");
		MetaColumn column = findColumnByFormkey(formkey);
		if(column.isselectedcolumn.intValue() == AppContrast.TURE) {
			sb.append("{checkbox:true},");
		}
		String fieldname = null;
		for(MetaSubcolumn obj : columnlist) {
			try {
				fieldname = obj.field.split("!")[1].toLowerCase();
			} catch (Exception e) {
				throw new RuntimeException("元数据字段表字段名格式错误,格式:表名!字段名");
			}
			if(obj.edittype.intValue() == AppContrast.INPUT_HIDDEN || obj.isdisplay.intValue() == AppContrast.FALSE) {
				sb.append("{")
				.append("field:\"").append(fieldname).append("\",")
				.append("hidden:true")
				.append("},");
			}else{
				sb.append("{")
				.append("field:\"").append(fieldname).append("\",")
				.append("title:\"").append(obj.title).append("\",")
				.append("width:").append(obj.listwidth).append(",")
				.append("halign:\"center\",")
				.append("align:\"").append(obj.align).append("\"");
				if(obj.edittype.intValue() == AppContrast.INPUT_COMBO){
					sb.append(",formatter:").append("function(value,row,index){return row.").append(fieldname).append("__display}");
				}else if(CommonUtil.isNotEmptyString(obj.format)){
					sb.append(",formatter:").append(obj.format);
				}
				if(obj.isreadonly.intValue() == AppContrast.FALSE){
					sb.append(",editor:").append(columnEditor(obj));
				}
				sb.append("},");
			}
		}
		if(!columnlist.isEmpty()){
			sb.deleteCharAt(sb.length()-1);
		}
		sb.append("]]");
		System.out.println(sb.toString());
		return sb.toString();
	}
	
	/**
	 * 获取可编辑表格的editor配置
	 * @param obj
	 * @return
	 */
	private String columnEditor(MetaSubcolumn obj){
		int inputType = obj.edittype.intValue();
		int isreq = obj.ismustenter.intValue();
		StringBuilder sb = null;
		if(inputType == AppContrast.INPUT_TEXT || inputType == AppContrast.INPUT_TEXTAREA){
			sb = new StringBuilder();
			sb.append("{type:\"validatebox\",options:{");
			if(isreq == AppContrast.TURE){
				sb.append("required:true");
			}
			sb.append("}}");
		}else if(inputType == AppContrast.INPUT_NUMBER){
			sb = new StringBuilder();
			sb.append("{type:\"numberbox\",options:{");
			if(isreq == AppContrast.TURE){
				sb.append("required:true,");
			}
			sb.append("precision:2");
			sb.append("}}");
		}else if(inputType == AppContrast.INPUT_SELECT){
			StringBuilder data = new StringBuilder();
			data.append("[");
			try{
				String[] options =  obj.enumerate.split(",");
				for(String option : options) {
					String[] opt = option.split("-");
					data.append("{\"id\":\"").append(opt[0]).append("\",")
					.append("\"text\":\"").append(opt[1]).append("\"},");
				}
				data.deleteCharAt(data.length()-1);
			}catch(Exception e){
				throw new RuntimeException("ERROR.FIELD.ENUM.FORMAT.IS.WRONG",e);
			}
			data.append("]");
			
			sb = new StringBuilder();
			sb.append("{type:\"combobox\",options:{");
			if(isreq == AppContrast.TURE){
				sb.append("required:true,");
			}
			sb.append("valueField:\"id\",");
			sb.append("textField:\"text\",");
			sb.append("data:").append(data.toString());
			sb.append("}}");
		}else if(inputType == AppContrast.INPUT_CHECKBOX){
			sb = new StringBuilder();
			sb.append("{type:\"checkbox\",options:{");
			sb.append("on:1,");
			sb.append("off:0");
			sb.append("}}");
			sb.append("}}");
		}else if(inputType == AppContrast.INPUT_DATE){
			sb = new StringBuilder();
			sb.append("{").append("");
			String format = obj.editformattype.trim();
			if(CommonUtil.isEmptyString(format)){
				sb.append("type:\"datetimebox\",");
			}else{
				if("yyyy-MM-dd".equals(format)){
					sb.append("type:\"datebox\",");
				}else if("HH:mm:ss".equals(format)||"HH:mm".equals(format)){
					sb.append("type:\"timespinner\",");
				}else{
					sb.append("type:\"datetimebox\",");
				}
			}
			sb.append("options:{");
			if(isreq == AppContrast.TURE){
				sb.append("required:true,");
			}
			if("yyyy-MM-dd HH:mm".equals(format) || "HH:mm".equals(format)){
				sb.append("showSeconds:false");
			}
			sb.append("}}");
		}else if(inputType == AppContrast.INPUT_COMBO){
			MetaReference refer = findReferBySubid(obj.id);
			sb = new StringBuilder();
			sb.append("{type:\"combogrid\",options:{");
			if(isreq == AppContrast.TURE){
				sb.append("required:true,");
			}
			sb.append("panelWidth:").append(refer.panelwidth).append(",")
			.append("queryParams:{fieldid:\"").append(obj.id).append("\"},")
			.append("idField:\"").append(refer.idfield).append("\",")
			.append("textField:\"").append(refer.textfield).append("\",")
			.append("columns:").append(refer.returnfield).append(",")
			.append("onSelect:").append("function(index,row){comboOnselect(index,row,\"").append(obj.fileattributes).append("\")},")
			.append("onChange:").append("function(newValue,oldValue){comboOnchange(newValue,oldValue,").append(obj.id).append(",\"").append(obj.fileattributes).append("\",$(this))}")
			.append("}}");
		}else{
			throw new RuntimeException("error.editortable.edittype.not.support");
		}
		return sb.toString();
	}

	@Override
	public String defrowdata(String formkey) {
		MetaColumn column = findSecColumnByFormkey(formkey);
		List<MetaSubcolumn> list = MetaSubcolumn.find("from MetaSubcolumn t where t.editdefaultvalue is not null and t.columnid = ?", column.id).fetch();
		StringBuilder sb = new StringBuilder("{");
		for(MetaSubcolumn obj : list){
			sb.append("\"").append(obj.field.split("!")[1]).append("\":\"").append(obj.editdefaultvalue).append("\",");
		}
		if(!list.isEmpty()){
			sb.deleteCharAt(sb.length()-1);
		}
		sb.append("}");
		return sb.toString();
	}


}

