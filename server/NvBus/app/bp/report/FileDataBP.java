package bp.report;

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
import play.db.jpa.Model;
import play.mvc.Scope.Session;
import plugin.PluginInterface;
import plugin.ReportPluginInterface;
import util.AppContrast;
import util.CommonUtil;
import util.CurrentUtil;
import util.PropertyUtil;
import util.ResourceConfig;
import util.report.ComplexSqlUtils;
import util.report.MetaUtils;

import bpinterface.report.FileDataInterface;
import bpinterface.report.UIInterface;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.TypeReference;



public class FileDataBP implements FileDataInterface{
	
	public Map<String,Object> getPage(String formkey, String params, int page, int rows, String orderCondition, boolean isPagination) throws Exception{
		MetaColumn column = MetaUtils.findColumnByFormkey(formkey);
		
		StringBuilder conditions = new StringBuilder();
		
		
		//生成排序String
		Map<String, String> orderMap = null;
		StringBuilder orderconditions = new StringBuilder();
		orderMap = JSON.parseObject(orderCondition, new TypeReference<Map<String,String>>(){});
		for(String key : orderMap.keySet()) {
			String name = key.split("!")[1];
			String value = orderMap.get(key);
			if(value.equals("true")){
				orderconditions.append(name+",");
			}
		}
		Map<String, String> paramMap = new HashMap<String, String>();
		if(CommonUtil.isNotEmptyString(params)){
			paramMap = JSON.parseObject(params, new TypeReference<Map<String,String>>(){});
		}
		
		String sql = null;	// 主查询sql
		String countsql = null;	//总记录数
		String summarysql = null;	//合计信息
		/*
		 * 获取主查询语句，如果column.datasource未配置，则从column.pluginname获取
		 */
		if (CommonUtil.isNotEmptyString(column.datasource)) {
			sql = column.datasource;
			System.out.println("sql-->"+sql);
			String regex = "\\^.*?(@(.*?)@).*?\\^";
			Pattern pattern = Pattern.compile(regex);
			Matcher matcher = pattern.matcher(sql);
			//替换关键字生成sql
			if (matcher.find()) {
				ComplexSqlUtils utils = new ComplexSqlUtils();
				sql = utils.getComplexSql(paramMap, sql, matcher);
			} else {
				// 根据查询条件自动拼装sql
				conditions = getConditionSql(paramMap, column);
				sql += conditions.toString();
				if (CommonUtil.isNotEmptyString(column.groupby)) {
					sql += " group by " + column.groupby;
				}
			}
			//构造临时表方便后续查询
			String tmpTableName = this.createTempTable(formkey, isPagination, sql);
			sql = " select * from " + tmpTableName ;
		} 
		if(CommonUtil.isNotEmptyString(column.pluginname)){
			ReportPluginInterface plugin = (ReportPluginInterface) PropertyUtil.getObject(column.pluginname);
			if (!CommonUtil.isNotEmptyString(sql)) {
				sql = plugin.getSql(params, isPagination);
				
			} 
			// 获取countsql,如果已写在插件里，则优先使用插件里的countsql，否则截取主查询语句拼装成countsql
			countsql = plugin.getCountSql(params);
			summarysql = plugin.getSummarysql(params);
		}
		
		
		//是否排序
		if(CommonUtil.isNotEmptyString(orderconditions.toString())){
			orderconditions.deleteCharAt(orderconditions.length()-1);
			String order =orderconditions.toString();
			sql +=" order by "+order;
		}else {
			if(CommonUtil.isNotEmptyString(column.pluginname)){
				ReportPluginInterface plugin = (ReportPluginInterface) PropertyUtil.getObject(column.pluginname);
				if(null != plugin.addOrderSql(params)){
					sql += plugin.addOrderSql(params);
				}
			}
		}
		//记录数
		int total = 0;
		//查询临时表中数据总记录
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
		if(CommonUtil.isNotEmptyString(column.pluginname)){
			ReportPluginInterface plugin = (ReportPluginInterface) PropertyUtil.getObject(column.pluginname);
			if(null != plugin.getDynamicaddSql(sql, params)){
				sql = plugin.getDynamicaddSql(sql, params);
			}
		}
		Query query = JPA.em().createNativeQuery(sql);
		
		Query countQuery = JPA.em().createNativeQuery(countsql);
		if(CommonUtil.isNotEmptyString(countsql)){
			total = ((BigDecimal) countQuery.getSingleResult()).intValue();
		}else{
			total = query.getResultList().size();
		}
		

		//记录
		if(page > 0 && rows > 0){
			query.setFirstResult((page - 1) * rows);
			query.setMaxResults(rows);
		}
		List list = query.getResultList();
		if(CommonUtil.isEmptyString(column.returncolumn)){
			throw new RuntimeException("返回列信息未定义!");
		}
		String[] fields = column.returncolumn.split("\\s*,\\s*");
		if(CommonUtil.isNotEmptyString(column.pluginname)){
			ReportPluginInterface plugin = (ReportPluginInterface) PropertyUtil.getObject(column.pluginname);
			if(null !=plugin.getDynamicaddSql(sql, params)){
				fields = plugin.getResFields();
			}
		}
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
	 * mengjian by 20150610 
	 * 首次查询创建临时表缓存数据
	 * 临时表命名规则:Temp_ + fromkey + sessionID
	 * 
	 * @param formkey
	 * @param isPagination
	 * @param sql
	 * @return
	 */
	public String createTempTable(String formkey, boolean isPagination,
			String sql) {
		String sessionid=Session.current().getId();
		String tmpTableName = "Temp_" + formkey + "_" + sessionid.hashCode();
		if(sessionid.hashCode() < 0){
			tmpTableName = tmpTableName.replace("-", "");
		}
		if(!isPagination){
			this.registerTempTable(tmpTableName);
			String tmpSql = "create table " + tmpTableName +" as (" + sql + ")";
			System.out.println(tmpSql);
			Query query = JPA.em().createNativeQuery(tmpSql);
			query.executeUpdate();
		}
		return tmpTableName;
	}
	

	/**
	 * mengjian by 20150610 
	 * 注册表到TMP_TABLE中，表中所存放的临时表会定时删除
	 *
	 * 每次重新查询时也会删除临时表 重新创建
	 */
	private void registerTempTable(String tempTable_name) {
		String sessionid = Session.current().getId();
		String delSql = "delete tmp_table where tablename = '" + tempTable_name
				+ "'";
		JPA.em().createNativeQuery(delSql).executeUpdate();
		String createSql = "Insert into tmp_table (ID,SessionID,TableName,CreateBy,UserID) values(SEQ_PUB.nextval, '"
				+ sessionid + "','" + tempTable_name + "',101,101)";
		JPA.em().createNativeQuery(createSql).executeUpdate();
		String dropSql = "Drop Table " + tempTable_name;
		try {
			JPA.em().createNativeQuery(dropSql).executeUpdate();
		} catch (Exception e) {
			// drop 临时表报错
			System.out.println(dropSql);
		}

	}


	
	/**
	 * 根据查询条件拼接条件语句
	 * @param paramMap 查询条件
	 * @param column 模块唯一标识
	 * @return
	 * @throws Exception
	 */
	private StringBuilder getConditionSql(Map<String, String> paramMap, MetaColumn column) throws Exception {
		StringBuilder conditions = new StringBuilder();
		for(String key : paramMap.keySet()) {
			Long subid = Long.parseLong(key.split("#")[0]);
			String value = paramMap.get(key);
			MetaSubcolumn subcolumn = MetaUtils.findSubcolumnById(subid);
			if(CommonUtil.isNotEmptyString(value) && !"org!value".equals(key.split("#")[1])) {
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
							conditions.append(" and ").append(queryType(alias, fieldname, "GET", isdate, low));
						}
						if(CommonUtil.isNotEmptyString(up)){
							conditions.append(" and ").append(queryType(alias, fieldname, "LET", isdate, up));
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
				@SuppressWarnings("rawtypes")
				List resultList = JPA.em().createNativeQuery(sql).getResultList();
				String orgids = null;
//				String orgids = CurrentUtil.getGlobal().getOrgIDs();
				if(subcolumn.iscontrol && !resultList.isEmpty() && CommonUtil.isNotEmptyString(orgids)){
					conditions.append(" and org.id in (").append(orgids).append(")");
				}
			}
		}
		return conditions;
	}
	
	public Map<String,Object> getList(String formkey) {
		MetaColumn column = MetaUtils.findColumnByFormkey(formkey);
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
	
	public Map<String, Object> autoComplete(Long fieldid, String params) {
		MetaReference refer = MetaUtils.findReferBySubid(fieldid);
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
//		sb.append(" order by id desc");
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
