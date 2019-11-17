package controllers;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.persistence.Query;

import models.AutocompleteResult;
import models.BPException;
import play.Logger;
import play.db.jpa.JPA;
import util.CommonUtil;
import util.CurrentUtil;
import util.ResourceConfig;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SerializerFeature;


public class CommonAction extends Application {
	//帮助框
	public static void autoComplete(String type,String text,String params) throws Exception{
		StringBuffer sql = new StringBuffer();;
		text = text.replaceAll("(\')+", "");
		String regex = "^\\d*$";
		Pattern pattern = Pattern.compile(regex);
		Matcher matcher = pattern.matcher(text);
		boolean isnum = matcher.matches();
		AutocompleteResult result = new AutocompleteResult();

		if("organization".equals(type)){
			result.fieldslist = Arrays.asList("ID ", "名称", "编码");
			result.nameslist = Arrays.asList("id", "name", "code");
			result.fieldswidthlist = Arrays.asList(40,120,80);
			sql = new StringBuffer("select t.id,t.name,t.code from organization t ")
					.append(" where t.isactive = 1 and (t.name like '%"+text+"%' or t.code like '%"+text.toUpperCase()+"%'")
					.append(" and t.type in ('0','1','2') and t.islocal=1 ");
			if(isnum){
				sql.append( " or t.id = '"+text+"'");
			}
			sql.append( ")");
		} else if("unit".equals(type)){
			result.fieldslist = Arrays.asList("ID ", "名称", "简拼");
			result.nameslist = Arrays.asList("id", "name", "jianpin");
			result.fieldswidthlist = Arrays.asList(40,200,120);
			sql = new StringBuffer("select t.id,t.name,t.jianpin from unit t where t.isactive = 1 and (t.name like '%"+text+"%' or t.fullname like '%"+text+"%' or t.jianpin like '%"+text.toUpperCase()+"%'");
			if(isnum){
				sql.append( " or t.id = '"+text+"'");
			}
			sql.append( ")");
		} else if("vehicle".equals(type)){
			result.fieldslist = Arrays.asList("ID ", "车牌号" ,"座位数");
			result.nameslist = Arrays.asList("id", "vehicleno", "seatnum");
			result.fieldswidthlist = Arrays.asList(40,100,40);
			sql = new StringBuffer("select t.id,t.vehicleno,t.seatnum from vehicle t where t.isactive = 1 and (t.vehicleno like '%"+text.toUpperCase()+"%'");
			if(isnum){
				sql.append( " or t.id = '"+text+"'");
			}
			sql.append( ")");
		} else if("route".equals(type)){ //线路
			result.fieldslist = Arrays.asList("ID ", "线路名称" ,"简拼");
			result.nameslist = Arrays.asList("id", "name", "jianpin");
			result.fieldswidthlist = Arrays.asList(40,100,60);
			sql = new StringBuffer("select t.id,t.name,t.jianpin from Route t where t.isactive = 1 and (t.name like '%"+text.toUpperCase()+"%' or t.jianpin like '%"+text.toUpperCase()+"%'" );
			if(isnum){
				sql.append( " or t.id = '"+text+"'");
			}
			sql.append( ")");
		} else{
			throw new BPException("validation.match");
		}
		Query query = JPA.em().createNativeQuery(sql.toString());
		int limit = Integer.parseInt("50");
		query.setFirstResult(0);
		query.setMaxResults(limit);
		@SuppressWarnings("rawtypes")
		List list = query.getResultList();
		result.resultcount = list.size();
		result.resultslist = list;
		renderText(JSON.toJSONString(result,SerializerFeature.WriteDateUseDateFormat));
	}
	//组织机构--分公司
	public static void findBranchOrganization(String ids) { //ids没有用处
		String[] fields={"id", "code", "name"};
		String sql = " select t.id, t.code, t.name from Organization t where t.isactive = 1 and t.type='4' ";
		Query query = JPA.em().createNativeQuery(sql.toString());
		List list=query.getResultList();
		List<Map<String,Object>> map=CommonUtil.list2Map(list, fields);
		Map<String,Object> innerMap=new HashMap<String,Object>();
		innerMap.put("rows", map);
		innerMap.put("total", list.size());
		renderText(JSON.toJSONString(innerMap,SerializerFeature.WriteDateUseDateFormat));
	}
	//组织机构--所属机构
	public static void findOrganization(String ids) {
		String[] fields={"id", "code", "name"};	
		String sql = " select t.id, t.code, t.name from Organization t where t.isactive = 1 and t.type in ('0','1','2') and t.islocal=1 and t.parentid in ("+ids+")";
		Query query = JPA.em().createNativeQuery(sql.toString());
		List list=query.getResultList();
		List<Map<String,Object>> map=CommonUtil.list2Map(list, fields);
		Map<String,Object> innerMap=new HashMap<String,Object>();
		innerMap.put("rows", map);
		innerMap.put("total", list.size());
		renderText(JSON.toJSONString(innerMap,SerializerFeature.WriteDateUseDateFormat));
	}
}
