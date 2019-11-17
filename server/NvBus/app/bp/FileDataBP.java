package bp;

import java.lang.reflect.Field;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.persistence.Query;

import models.BPException;
import models.BaseModel;
import models.MetaColumn;
import models.MetaForm;
import models.MetaReference;
import models.MetaSubcolumn;
import models.Result;
import play.Logger;
import play.data.validation.Validation;
import play.db.jpa.JPA;
import plugin.DSPluginInterface;
import plugin.PluginInterface;
import util.AppContrast;
import util.CommonUtil;
import util.CurrentUtil;
import util.PropertyUtil;
import util.ResourceConfig;
import bpinterface.FileDataInterface;
import bpinterface.UIInterface;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.TypeReference;



public class FileDataBP implements FileDataInterface{
	public Map<String,Object> getPage(String formkey, String params, int page, int rows, boolean isPagination) throws Exception{
		UIInterface uibp = new UIBP();
		MetaColumn column = uibp.findColumnByFormkey(formkey);
		
		StringBuilder conditions = new StringBuilder();
		if(CommonUtil.isNotEmptyString(params)) {
			Map<String, String> paramMap = JSON.parseObject(params, new TypeReference<Map<String,String>>(){});
			for(String key : paramMap.keySet()) {
				Long subid = Long.parseLong(key.split("#")[0]);
				String value = paramMap.get(key);
				MetaSubcolumn subcolumn = uibp.findSubcolumnById(subid);
				if(CommonUtil.isNotEmptyString(value)) {
					String alias;
					String fieldname;
					try {
						alias = subcolumn.field.split("!")[0];
						fieldname = subcolumn.field.split("!")[1];
					} catch (Exception e) {
						throw new RuntimeException("元数据字段表字段名格式错误,格式:表名!字段名!");
					}
					
					boolean isdate = subcolumn.edittype.intValue() == AppContrast.INPUT_DATE;
					
					if(subcolumn.isintervalcondition.intValue() == AppContrast.TURE) {
						if(value.split("&").length == 2){
							String low = value.split("&")[0];
							String up = value.split("&")[1];
							if(CommonUtil.isNotEmptyString(low)){
								if(isdate){
									conditions.append(" and ").append(alias).append(".").append(fieldname).append(" >= date'").append(low).append("'");
								}else{
									conditions.append(" and ").append(queryType(alias, fieldname, "GET", isdate, low));
								}
							}
							if(CommonUtil.isNotEmptyString(up)){
								if(isdate){
									conditions.append(" and ").append(alias).append(".").append(fieldname).append(" <= to_date('").append(up).append(" 23:59:59','yyyy-mm-dd hh24:mi:ss')");
								}else{
									conditions.append(" and ").append(queryType(alias, fieldname, "LET", isdate, up));
								}
							}
						}
					}else{
						String type = subcolumn.querytype;
						if(CommonUtil.isEmptyString(type)){
							throw new RuntimeException("查询条件字段的查询类型不能为空!");
						}
						conditions.append(" and ").append(queryType(alias, fieldname, type, isdate, value));
					}
				}else{
					//有查询权限控制,机构过滤
					String sql = "select id from meta_subcolumn where columnid = "+column.id+" and iscondition = 1 and iscontrol = 1";
					List resultList = JPA.em().createNativeQuery(sql).getResultList();
					String orgids =null; 
						//String orgids =CurrentUtil.getOrgids();报错，暂时隐藏
					if(subcolumn.iscontrol && !resultList.isEmpty() && CommonUtil.isNotEmptyString(orgids)){
						String alias;
						String fieldname;
						try {
							alias = subcolumn.field.split("!")[0];
							fieldname = subcolumn.field.split("!")[1];
						} catch (Exception e) {
							throw new RuntimeException("元数据字段表字段名格式错误,格式:表名!字段名!");
						}
						conditions.append(" and ").append(alias).append(".").append(fieldname).append(" in (").append(orgids).append(")");
					}
				}
			}
		}
		
		String sql = "";	// 主查询sql
		String countsql = null;	//总记录数
		String summarysql = null;	//合计信息
		/*
		 * 获取主查询语句，如果column.datasource未配置，则从column.pluginname获取
		 */
		if (CommonUtil.isNotEmptyString(column.datasource)) {
			sql = column.datasource + conditions.toString();
			if(CommonUtil.isNotEmptyString(column.groupby)){
				sql += " group by " + column.groupby;
			}
			System.out.println("sql-->"+sql);
		} 
		if(CommonUtil.isNotEmptyString(column.pluginname)){
			DSPluginInterface plugin = (DSPluginInterface) PropertyUtil.getObject(column.pluginname);
			if (!CommonUtil.isNotEmptyString(sql)) {
				sql = plugin.getSql(params, isPagination);
				
			} 
			// 获取countsql,如果已写在插件里，则优先使用插件里的countsql，否则截取主查询语句拼装成countsql
			countsql = plugin.getCountSql(params);
			summarysql = plugin.getSummarysql(params);
		}
		if (countsql == null) {
			int beginIndex = sql.indexOf("from");
			String fromclause = sql.substring(beginIndex);
			if(CommonUtil.isNotEmptyString(column.groupby)){
				countsql = "select count(*) from ("+sql.toString()+")";
			}else{
				countsql = "select count(*) "+ fromclause;
			}
			System.out.println("countsql*-->"+countsql);
		}
		Query query = JPA.em().createNativeQuery(sql);
		
		//记录数
		int total = 0;
		Query countQuery = JPA.em().createNativeQuery(countsql);
		if(CommonUtil.isNotEmptyString(countsql)){
			total = ((BigDecimal) countQuery.getSingleResult()).intValue();
		}else{
			total = query.getResultList().size();
		}

		//记录
		query.setFirstResult((page - 1) * rows);
		query.setMaxResults(rows);
		List list = query.getResultList();
		if(CommonUtil.isEmptyString(column.returncolumn)){
			throw new RuntimeException("返回列信息未定义!");
		}
		String[] fields = column.returncolumn.split("\\s*,\\s*");
		List<Map<String,Object>> innerMap = CommonUtil.list2Map(list,fields);
		
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("total", total);
		map.put("rows", innerMap);
		
		//合计
		if(CommonUtil.isNotEmptyString(column.summarysql)){
			summarysql = column.summarysql;
			summarysql += conditions.toString();
		} 
		
		if (summarysql != null) {
			System.out.println("conditionSql="+conditions.toString());
			System.out.println("summarysql-->"+summarysql);
			query = JPA.em().createNativeQuery(summarysql);
			List sumlist = null;
			try {
				sumlist = query.getResultList();
			} catch (Exception e) {
				throw new BPException("汇总语句错误");
			}
			String summarycolumn = column.summarycolumn;
			if(CommonUtil.isEmptyString(summarycolumn)){
				throw new BPException("汇总字段不能为空");
			}
			fields = summarycolumn.split("\\s*,\\s*");
			List<Map<String, Object>> summarylist = CommonUtil.list2Map(sumlist, fields);
			
			map.put("footer", summarylist);
		}
		return map;
	}

	/**
	 * 复杂sql, 替换关键字
	 * @param paramMap
	 * @param sql
	 * @param matcher
	 * @return
	 */
	public String getComplexSql(Map<String, String> paramMap, String sql, Matcher matcher) {
		matcher.reset();
		while (matcher.find()) {
			String global = matcher.group(); //^...^
			String part = matcher.group(1);//@...@
			String key = matcher.group(2);
			String value = getMapValue(paramMap, key);
			if (CommonUtil.isEmptyString(value)) {
				sql = sql.replace(global, "");
			} else {
				sql = sql.replace(part, value);
			}
			
		}
		sql = sql.replace("^", "");
		return sql;
	}
	
	/**
	 * 根据key取Map中相应value
	 * 传人key:b!name,map中key:1000085#b!name
	 * 区间时间key:b!time#s-->b!time#e,map 中key: id#b!time(20141201&20141212)
	 * @param paramMap
	 * @param key
	 * @return
	 */
	private String getMapValue(Map<String, String> paramMap, String key) {
		// key 时间区间格式 b!time#s, b!time#e
		key = key.toLowerCase();
		String targetkey = key;
		if(key.endsWith("#s") || key.endsWith("#e")){
			targetkey = key.split("#")[0];
		}
		Set<String> keySet = paramMap.keySet();
		String sk = "";
		String value = "";
		for(String str : keySet){
			// str格式: id#field 如,1000085#b!name
			sk = str.split("#")[1];
			if(sk.equals(targetkey)){
				value = paramMap.get(str);
			}
		}
		// key 时间区间格式 b!time#s, b!time#e	
		try {
			if(key.endsWith("#s")){
				value = value.split("&")[0];
			}else if(key.endsWith("#e")){
				value = value.split("&")[1];
			}
		} catch (Exception e) {
			Logger.info("sql 关键字 替换 区间条件 错误" + key);
			play.Logger.error(e.getMessage(), e);
		}
		
		//查询类型IN
		if(value.contains("&")){
			StringBuilder sb = new StringBuilder();
			String[] arr = value.split("&");
			for(String str : arr){
				sb.append("'").append(str).append("',");
			}
			sb.deleteCharAt(sb.length() - 1);
			value = sb.toString();
		}
		
		return value;
	}

	
	/**
	 * 根据查询条件拼接条件语句
	 * @param paramMap 查询条件
	 * @param column 模块唯一标识
	 * @return
	 * @throws Exception
	 */
	private StringBuilder getConditionSql(Map<String, String> paramMap, MetaColumn column) throws Exception {
		UIInterface uibp = new UIBP();
		StringBuilder conditions = new StringBuilder();
		for(String key : paramMap.keySet()) {
			Long subid = Long.parseLong(key.split("#")[0]);
			String value = paramMap.get(key);
			MetaSubcolumn subcolumn = uibp.findSubcolumnById(subid);
			if(CommonUtil.isNotEmptyString(value)) {
				String alias;
				String fieldname;
				try {
					alias = subcolumn.field.split("!")[0];
					
					fieldname = subcolumn.field.split("!")[1];
					if(subcolumn.field.contains("__")){
						fieldname = fieldname.split("__")[0];
					}
				} catch (Exception e) {
					throw new RuntimeException("元数据字段表字段名格式错误,格式:表名!字段名!");
				}
				
				boolean isdate = subcolumn.edittype.intValue() == AppContrast.INPUT_DATE;
				
				if(subcolumn.isintervalcondition.intValue() == AppContrast.TURE) {
					if(value.split("&").length == 2){
						String low = value.split("&")[0];
						String up = value.split("&")[1];
						if(CommonUtil.isNotEmptyString(low)){
							if(isdate){
								conditions.append(" and ").append(alias).append(".").append(fieldname).append(" >= date'").append(low).append("'");
							}else{
								conditions.append(" and ").append(queryType(alias, fieldname, "GET", isdate, low));
							}
						}
						if(CommonUtil.isNotEmptyString(up)){
							if(isdate){
								conditions.append(" and ").append(alias).append(".").append(fieldname).append(" <= to_date('").append(up).append(" 23:59:59','yyyy-mm-dd hh24:mi:ss')");
							}else{
								conditions.append(" and ").append(queryType(alias, fieldname, "LET", isdate, up));
							}
						}
					}
				}else{
					String type = subcolumn.querytype;
					if(CommonUtil.isEmptyString(type)){
						throw new RuntimeException("查询条件字段的查询类型不能为空!");
					}
					conditions.append(" and ").append(queryType(alias, fieldname, type, isdate, value));
				}
			}
		}
		return conditions;
	}
	
	public static String createsql(String params){
		UIInterface uibp = new UIBP();
		StringBuffer sb = new StringBuffer();
		FileDataBP fbp = new FileDataBP();
		if(CommonUtil.isNotEmptyString(params)) {
			Map<String, String> paramMap = JSON.parseObject(params, new TypeReference<Map<String,String>>(){});
			for(String key : paramMap.keySet()) {
				Long subid = Long.parseLong(key.split("#")[0]);
				String value = paramMap.get(key);
				if(CommonUtil.isNotEmptyString(value)) {
					MetaSubcolumn subcolumn = uibp.findSubcolumnById(subid);
					String alias;
					String fieldname;
					try {
						alias = subcolumn.field.split("!")[0];
						fieldname = subcolumn.field.split("!")[1];
					} catch (Exception e) {
						throw new RuntimeException("元数据字段表字段名格式错误,格式:表名!字段名!");
					}
					
					boolean isdate = subcolumn.edittype.intValue() == AppContrast.INPUT_DATE;
					
					if(subcolumn.isintervalcondition.intValue() == AppContrast.TURE) {
						if(value.split("&").length == 2){
							String low = value.split("&")[0];
							String up = value.split("&")[1];
							if(CommonUtil.isNotEmptyString(low)){
								sb.append(" and ").append(fbp.queryType(alias, fieldname, "GET", isdate, low));
							}
							if(CommonUtil.isNotEmptyString(up)){
								sb.append(" and ").append(fbp.queryType(alias, fieldname, "LET", isdate, up));
							}
						}
					}else{
						String type = subcolumn.querytype;
						if(CommonUtil.isEmptyString(type)){
							throw new RuntimeException("查询条件字段的查询类型不能为空!");
						}
						sb.append(" and ").append(fbp.queryType(alias, fieldname, type, isdate, value));
					}
				}
			}
		}
		return sb.toString();
	}
	public Map<String,Object> getList(String formkey) {
		UIInterface uibp = new UIBP();
		MetaColumn column = uibp.findColumnByFormkey(formkey);
		StringBuilder sb = new StringBuilder();
		sb.append(column.datasource);
		Query query = JPA.em().createNativeQuery(sb.toString());
		List list = query.getResultList();
		int count = list.size();
		String[] fields = column.returncolumn.split("\\s*,\\s*");
		List<Map<String,Object>> innerMap = CommonUtil.list2Map(list,fields);
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("total", count);
		map.put("rows", innerMap);
		return map;
	}
	
	public Object findById(String formkey,Long id){
		UIInterface uibp = new UIBP();
		MetaColumn column = uibp.findColumnByFormkey(formkey);
		StringBuilder sb = new StringBuilder(column.datasource);
		sb.append(" and t.id = ?");
		Query query = JPA.em().createNativeQuery(sb.toString());
		query.setParameter(1, id);
		List list = query.getResultList();
		String[] fields = column.returncolumn.split("\\s*,\\s*");
		List<Map<String,Object>> innerMap = CommonUtil.list2Map(list,fields);
		return innerMap.get(0);
	}
	
	public Result save(String formkey, String params) throws Exception{
		UIInterface uibp = new UIBP();
		MetaColumn column = uibp.findColumnByFormkey(formkey);
		params = params.replaceAll("\\d+#.*?!", "");
		Class clazz = getClass(column.entityname);
		BaseModel model = null;
		try{
			model = (BaseModel) JSON.parseObject(params, clazz);
		}catch(Exception e){
			throw new IllegalArgumentException("模块" + formkey + "保存时,表单数据"
					+ params + "转对象出错", e);
		}	
		Field idfield = clazz.getDeclaredField("id");
		Long id = (Long) idfield.get(model);
		if(id == null || id == 0) {
			try {
				Field isactivefield = clazz.getDeclaredField("isactive");
				isactivefield.set(model, true);//逻辑删除状态字段默认值
			} catch (Exception e) {
			}
			model.createStamp(false);
		}
		if(id != null && id != 0){
			model.updateStamp(false);
		}
		
		MetaForm form = uibp.findFormByKey(formkey);
		PluginInterface plugin = null;
		// 插件
		if(CommonUtil.isNotEmptyString(form.pluginname)){
			plugin = (PluginInterface) PropertyUtil.getObject(form.pluginname);
		}
		
		if(plugin != null) {
			model = (BaseModel) plugin.mainBefore(form,model);
		}
		Validation validation = Validation.current();
		if(validation.hasErrors()){
			return new Result(false,"操作失败!");
		}
		
		model = model.merge();
		model.validateAndSave();
		if(plugin != null) {
			plugin.mainAfter(form,model);
		}
		Result result = new Result(true,"保存成功!");
		return result;
	}
	
	public Result bulkDelete(String formkey, String ids) {
		UIInterface uibp = new UIBP();
		MetaColumn column = uibp.findColumnByFormkey(formkey);
		Class clazz = getClass(column.entityname);
		String hql = "";
		try {
			//逻辑删除
			clazz.getDeclaredField("isactive");
			hql = "update " + column.entityname + " set isactive = 0 where id in (" + ids + ")";
		} catch (Exception e) {
			//物理删除
			hql = "delete from " + column.entityname + " where id in (" + ids + ")";
		}
		Query query = JPA.em().createQuery(hql);
		query.executeUpdate();
		
		Result result = new Result(true,"删除成功!");
		return result;
	}
	
	public Map<String, Object> autoComplete(Long fieldid, String params) {
		UIInterface uibp = new UIBP();
		MetaReference refer = uibp.findReferBySubid(fieldid);
		StringBuilder sb = new StringBuilder();
		sb.append(refer.datasource);//.append(" and isactive = 1");
		if(CommonUtil.isNotEmptyString(params)){
			params = params.replaceAll("\\d+#.*?!", "");
			Map<String,String> map = JSON.parseObject(params, new TypeReference<Map<String,String>>(){});
			Map<String,String> sqlMap = JSON.parseObject(refer.field, new TypeReference<Map<String,String>>(){});
			String hql = null;
			String value = null;
			for(String key : map.keySet()){
				value = map.get(key).toUpperCase();
				if(CommonUtil.isNotEmptyString(value) && sqlMap.containsKey(key)){
					hql = sqlMap.get(key);
					String doval = value.replaceAll("(\')+", "");//去除单引双引等特殊字符
					hql = hql.replaceAll("@@", doval);
					sb.append(" and (").append(hql).append(")");
				}
			}
		}
		sb.append(" order by id desc");
		Query query = JPA.em().createQuery(sb.toString());
		int limit = 50;//Integer.parseInt(ResourceConfig.getValue("completecountlimit"));
		query.setFirstResult(0);
		query.setMaxResults(limit);
		List list = query.getResultList();
		int count = list.size();
		Map<String,Object> resultMap = new HashMap<String, Object>();
		resultMap.put("total", count);
		resultMap.put("rows", list);
		return resultMap;
	}
	
	/**
	 * 根据类名获取Class
	 * @param classname
	 * @return
	 */
	private Class getClass(String classname) {
		Class clazz = null;
		try {
			clazz = Class.forName(classname);
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("ERROR.ENTITY.IS.NOT.EXIST", e);
		}
		return clazz;
	}

	/**
	 * 生成查询条件
	 * @param alias	表别名
	 * @param fieldname	字段名
	 * @param type	查询类型
	 * @param isdate字段类型是否日期
	 * @param value	字段值
	 * @return
	 */
	private String queryType(String alias,String fieldname,String type, boolean isdate, String value){
		StringBuilder sb = null;
		if ("EQ".equals(type) || "NOEQ".equals(type) || "LT".equals(type)
				|| "GT".equals(type) || "LET".equals(type) || "GET".equals(type)){
			if(isdate){
				value = "date'" + value + "'";
			}else{
				value = "'" + value + "'";
			}
		}else if("IN".equals(type)){
			sb = new StringBuilder();
			String[] arr = value.split("&");
			for(String str : arr){
				if(isdate){
					sb.append("date");
				}
				sb.append("'").append(str).append("',");
			}
			sb.deleteCharAt(sb.length() - 1);
			value = sb.toString();
		}
		sb = new StringBuilder();
		sb.append(alias).append(".").append(fieldname);
		if("EQ".equals(type)){
			sb.append(" = ").append(value);
		}else if("NOEQ".equals(type)){
			sb.append(" <> ").append(value);
		}else if("LIKE".equals(type)){
			sb.append(" like '%").append(value).append("%'");
		}else if("LIKEL".equals(type)){
			sb.append(" like '%").append(value).append("'");
		}else if("LIKER".equals(type)){
			sb.append(" like '").append(value).append("%'");
		}else if("LT".equals(type)){
			sb.append(" <  ").append(value);
		}else if("GT".equals(type)){
			sb.append(" >  ").append(value);
		}else if("LET".equals(type)){
			sb.append(" <=  ").append(value);
		}else if("GET".equals(type)){
			sb.append(" >=  ").append(value);
		}else if("IN".equals(type)){
			sb.append(" in (").append(value).append(")");
		}else{
			throw new RuntimeException("字段查询类型错误!");
		}
		return sb.toString();
	}


}
