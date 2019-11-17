package util.report;

import java.util.Map;
import java.util.Set;
import java.util.regex.Matcher;

import models.MetaSubcolumn;
import play.Logger;
import util.CommonUtil;
import util.CurrentUtil;

/**
 * 对复杂sql语句的一些特殊处理
 * 
 * @author mengjian
 *
 */
public class ComplexSqlUtils {

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
	private String getMapValue(Map<String, String> paramMap, String key)  {
		// key 时间区间格式 b!time#s, b!time#e
		String targetkey = key;
		if(key.endsWith("#s") || key.endsWith("#e")){
			targetkey = key.split("#")[0];
		}
		Set<String> keySet = paramMap.keySet();
		String value = "";
		for(String str : keySet){
			// str格式: id#field 如,1000085#b!name
			String sk = str.split("#")[1];
			if(sk.equals(targetkey)){
				value = paramMap.get(str);
			}
			
			Long subid = Long.parseLong(str.split("#")[0]);
			MetaSubcolumn subcolumn = MetaUtils.findSubcolumnById(subid);
			if(subcolumn.iscontrol && CommonUtil.isEmptyString(value)){
				value = CurrentUtil.getGlobal().getOrgIDs();
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

}
