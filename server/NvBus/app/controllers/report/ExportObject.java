package controllers.report;

import java.io.UnsupportedEncodingException;
import java.lang.reflect.Array;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.math.BigDecimal;
import java.sql.Clob;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.persistence.Query;

import org.apache.commons.lang.StringUtils;

import models.BPException;
import models.MetaColumn;
import models.MetaForm;
import models.MetaSubcolumn;
import play.db.jpa.JPA;
import play.mvc.Http.Cookie;
import play.mvc.Http.Request;
import play.mvc.Http.Response;
import plugin.ExportExcel;
import plugin.ReportPluginInterface;
import util.AppContrast;
import util.CommonUtil;
import util.JSUtil;
import util.PropertyUtil;
import util.report.ComplexReportProcessUtils;
import util.report.MetaUtils;

import bp.report.FileDataBP;
import bp.report.UIBP;
import bpinterface.report.UIInterface;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.TypeReference;

import controllers.Application;

public class ExportObject extends Application {

	/**
	 * 基于EXCEL打印
	 * 
	 * @param formkey
	 * @param url
	 * @throws Exception 
	 */
	public static void printExc(String formkey,String url) throws Exception{
		ExportObject.exportOrPrintExcl(formkey, url, true);
	}
	
	/**
	 * 导出完全可配置与部分可配置表格
	 * 
	 * @param formkey
	 * @param url
	 * @throws Exception
	 */
	public static void exportExc(String formkey,String url) throws Exception {
		ExportObject.exportOrPrintExcl(formkey, url, false);
	}

	/**
	 * 
	 * @param formkey
	 * @param url
	 * @param flag 【导出Excel false】【 打印Excel true】
	 * @throws Exception
	 */
	private static void exportOrPrintExcl(String formkey,String url,boolean flag) throws Exception {
		String suffix = ".xls";
		if(flag){
			suffix = "_print.xls";
		}
		List headers = null;
		String[] flds = null;
		
		
		Cookie ck = Request.current().cookies.get("params");
		String se = ck.value;
		String params = java.net.URLDecoder.decode(se, "UTF-8");
		
		flds = getFields(formkey);
		headers = getPluginReportHeader(formkey);
		List maplistdata = getExportData(formkey, flds, params);
		
		Response response = Response.current();
		response.reset();

		response.contentType = "application/msexcel;charset=GB2312";
		response.setHeader(
				"Content-disposition",
				"attachment;filename="
						+ java.net.URLEncoder.encode(
								java.net.URLDecoder.decode(url, "utf-8")
										+ suffix, "UTF-8"));
		ExportExcel.exportExc(maplistdata, headers, flds, url, response.out);
	}

	private static List getExportData(String formkey, String[] flds,
			String params) throws Exception {
		String returncolumn = null;  //返回字段
		String sqldata = "", datasource=null; // 主查询sql, 对应datasource
		String pluginName = null;  //复杂sql的插件
		List maplist = new ArrayList(); // 中间过渡数据
		List maplistdata = new ArrayList();// 最后需要导出到excel的数据
		MetaColumn column = MetaUtils.findColumnByFormkey(formkey);
		
		pluginName = column.pluginname;
		datasource = column.datasource;
		returncolumn = column.returncolumn;
		Long id= column.id;
		
		FileDataBP filedatabp = new FileDataBP();
		String createTempTable = filedatabp.createTempTable(formkey, true, null);
		String sql = " select * from " + createTempTable ;
		//合计数据
		String summarysql = null;	
		// 如果配置了datasource则通过 datasource获取导出数据，否则通过插件获取数据；
		if (CommonUtil.isNotEmptyString(datasource)) {
			if(CommonUtil.isNotEmptyString(column.pluginname)){
				ReportPluginInterface plugin = (ReportPluginInterface) PropertyUtil.getObject(column.pluginname);
				summarysql = plugin.getSummarysql(params);
				if(null != plugin.getDynamicaddSql(sql, params)){
					sqldata = plugin.getDynamicaddSql(sql, params);
				}
			}
			if(StringUtils.isBlank(sqldata)){
				sqldata = sql;
			}
			System.out.println("sqldata-->"+sqldata);
			Query qy = JPA.em().createNativeQuery(sqldata);
			List listdata = qy.getResultList();
			
			String[] fieldslist = returncolumn.split(",");
			for (int i = 0; i < fieldslist.length; i++) {
				fieldslist[i] = fieldslist[i].trim();
			}
			if(CommonUtil.isNotEmptyString(column.pluginname)){
				ReportPluginInterface plugin = (ReportPluginInterface) PropertyUtil.getObject(column.pluginname);
				if(null !=plugin.getResFields()){
					fieldslist = plugin.getResFields();
				}
			}
			List map = CommonUtil.list2Map(listdata, fieldslist);
			
			for (Object obj : map) {
				Map<String, Object> item = (Map<String, Object>) obj;
				Map<String, Object> my = new HashMap<String, Object>();
				for (int i = 0; i < flds.length; i++) {
					my.put(flds[i], item.get(flds[i]));
				}
				maplist.add(my);
			}
			String subcolumnsql = "select * from meta_subcolumn where columnid = "+id;
			Query subcolumnquery = JPA.em().createNativeQuery(subcolumnsql,MetaSubcolumn.class);
			List<MetaSubcolumn> subcolumndata = subcolumnquery.getResultList();
			try {
				ComplexReportProcessUtils utils = new ComplexReportProcessUtils();
				subcolumndata = utils.dynamicadd(subcolumndata);
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			} catch (CloneNotSupportedException e) {
				e.printStackTrace();
			}
				for(int m=0;m<maplist.size();m++){
					Map<String, Object> item = (Map<String, Object>) maplist.get(m);
					for(int j = 0;j<flds.length;j++){
						for(int i = 0;i<subcolumndata.size();i++){
							String subname = (String)subcolumndata.get(i).field.split("!")[1];
							if(subname.equals(flds[j])){
								int subtype = subcolumndata.get(i).edittype;
								if(subtype == 5||subcolumndata.get(i).enumerate!=null){
									if(subcolumndata.get(i).enumerate!=null){
										String enumerate = subcolumndata.get(i).enumerate;
										String[] ets = enumerate.split(",");
										for(int n = 0;n<ets.length;n++){
											int typevalue = Integer.parseInt(ets[n].split("-")[0]);
											if(typevalue == (Integer.parseInt(item.get(flds[j]).toString()))){
												item.put(flds[j], ets[n].split("-")[1]);
												break;
											}
										}
									}else{
										if(subcolumndata.get(i).digitsql!=null){
											String digitsql = subcolumndata.get(i).digitsql;
											Query dig = JPA.em().createNativeQuery(digitsql);
											List diglist = dig.getResultList();
											for(int h=0;h<diglist.size();h++){
												if(Array.get(diglist.get(h), 0) instanceof String){
													int code = Integer.parseInt((String)Array.get(diglist.get(h), 0));
													if(code == (Integer)item.get(flds[j])){
														item.put(flds[j], (String)Array.get(diglist.get(h), 1));
														break;
													}
												}
												if(Array.get(diglist.get(h), 0) instanceof BigDecimal){
													int code = ((BigDecimal)Array.get(diglist.get(h), 0)).intValue();
													if(code == (Integer)item.get(flds[j])){
														item.put(flds[j], (String)Array.get(diglist.get(h), 1));
														break;
													}
												}
												if(Array.get(diglist.get(h), 0) instanceof Integer){
													int code = ((Integer)Array.get(diglist.get(h), 0));
													if(code == (Integer)item.get(flds[j])){
														item.put(flds[j], (String)Array.get(diglist.get(h), 1));
														break;
													}
												}
											}
										}
									}
								}else if(subtype == 6){
									String result = null;
									if (CommonUtil.isNotEmptyString(subcolumndata.get(i).format)) {
										result = JSUtil.format(subcolumndata.get(i).format.replaceAll("\"", "'"), item.get(flds[j]).toString());
									} else {
										result = ((BigDecimal)item.get(flds[j])).intValue() == 0 ? "否": "是";
									}
									item.put(flds[j], result);
								}else if(subtype == 10){
									
									if(subcolumndata.get(i).digitsql!=null){
										String digitsql = subcolumndata.get(i).digitsql;
										Query dig = JPA.em().createNativeQuery(digitsql);
										List diglist = dig.getResultList();
										for(int h=0;h<diglist.size();h++){
											if(Array.get(diglist.get(h), 0) instanceof String){
												int code = Integer.parseInt((String)Array.get(diglist.get(h), 0));
												if(code == Integer.parseInt((String)item.get(flds[j]))){
													item.put(flds[j], (String)Array.get(diglist.get(h), 1));
													break;
												}
											}
											if(Array.get(diglist.get(h), 0) instanceof BigDecimal){
//												int code = ((BigDecimal)Array.get(diglist.get(h), 0)).intValue();
												item.put(flds[j], (String)Array.get(diglist.get(h), 1));
//												if(code == ((BigDecimal)item.get(flds[j])).intValue()){
//													item.put(flds[j], (String)Array.get(diglist.get(h), 1));
													break;
//												}
											}
											if(Array.get(diglist.get(h), 0) instanceof Character){
												char code = ((Character)Array.get(diglist.get(h), 0));
												if(code == (Character)item.get(flds[j])){
													item.put(flds[j], (String)Array.get(diglist.get(h), 1));
													break;
												}
											}
										}
									}
								} else if (subtype == 1 || subtype == 3) {
									// 格式化字段类型是1的数据
									if (CommonUtil.isNotEmptyString(subcolumndata.get(i).format)) {
										if (item.get(flds[j]) != null && CommonUtil.isNotEmptyString(item.get(flds[j]).toString().trim()) && !(item.get(flds[j]) instanceof byte[])) {
											String content = JSUtil.format(subcolumndata.get(i).format, item.get(flds[j]).toString());
											if (CommonUtil.isNotEmptyString(content) && content.startsWith("<input type=\"checkbox\"")) {
												item.put(flds[j], item.get(flds[j]));
											} else {
												item.put(flds[j], content);
											}
										}
										
									}
								}
							}
						}
					}
					maplistdata.add(item);
				}
				if (summarysql != null) {
					Query createNativeQuery = JPA.em().createNativeQuery(summarysql);
					List sumlist = null;
					try {
						sumlist = createNativeQuery.getResultList();
					} catch (Exception e) {
						throw new BPException("汇总语句错误");
					}
					String summarycolumn = column.summarycolumn;
					if(CommonUtil.isEmptyString(summarycolumn)){
						throw new BPException("汇总字段不能为空");
					}
					String[] fields = summarycolumn.split("\\s*,\\s*");
					List<Map<String, Object>> summarylist = CommonUtil.list2Map(sumlist, fields);
					if(summarylist.size()>0){
						maplistdata.add(summarylist.get(0));
					}
				}
		} else if(CommonUtil.isNotEmptyString(column.pluginname)){
			try {
				String[] fieldslist = returncolumn.split(",");
				for (int i = 0; i < fieldslist.length; i++) {
					fieldslist[i] = fieldslist[i].trim();
				}
				ReportPluginInterface plugin = (ReportPluginInterface) PropertyUtil.getObject(column.pluginname);
				if(null !=plugin.getDynamicaddSql(sql, params)){
					fieldslist = plugin.getResFields();
				}
				maplistdata = getPluginReportData(params, pluginName, fieldslist);
			} catch (Exception e) {
				play.Logger.error(e.getMessage(), e);
			}
		}
		return maplistdata;
	}
	
	
	private static ArrayList getPluginReportHeader(String formkey) {
		MetaColumn column = MetaUtils.findColumnByFormkey(formkey);
		List<MetaSubcolumn> list = MetaSubcolumn.find("from MetaSubcolumn where  (listisdisplay=1  or isdynamicadd = 1 ) and columnid = ? order by listlocation", column.id).fetch();
		try {
			ComplexReportProcessUtils utils = new ComplexReportProcessUtils();
			list = utils.dynamicadd(list);
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (CloneNotSupportedException e) {
			e.printStackTrace();
		}
		int size = list.size();
		int maxLevel = 0;	//总共有多少级表头
		int subColStart = 0;	// 子表头从哪列开始
		StringBuilder level = new StringBuilder();
		List<String> headers = new ArrayList<String>();

		for (int i =0; i < size; i ++) {
			String ptitle = list.get(i).ptitle;
			if (ptitle != null) {
				if (ptitle.split("\\|").length>maxLevel) {
					maxLevel = ptitle.split("\\|").length;
				}
			}
		}
		maxLevel += 1;
		//父表头
		for (int i =0; i < size; i ++) {
			String title = list.get(i).title;
			String ptitle = list.get(i).ptitle;
			int columns = 0;
			// 必须先执行if统计subColStart再执行else,否则每次添加子列时subColStart都不同
			if (ptitle == null){
				level.append(title+":0:"+maxLevel+":1,");   //n(两)行一列  title:rowStart:rowNum(所占行数):colNum(所占列数)
			} else {
				//统计父title占的列数
				for (int j =0; j < size; j ++) {
					if (ptitle.equals(list.get(j).ptitle)) {
						columns += 1;
					}
				}
				// 多个子表头对应一个父表头，但level1中添加一个父表头，不能重复
				if ((i + 1) == size || !ptitle.equals(list.get(i+1).ptitle)) {
					level.append(ptitle+":"+0+":1:"+columns+",");
				}
			}
		}
		if (level.length() > 0) {
			headers.add(level.substring(0, level.length() - 1));
			level.delete(0, level.length());
		} 
			
		//子表头
		for (int x=1, steps =-1; x < maxLevel; x++) {
			level = new StringBuilder();
			for (int i =0; i < size; i ++) {
				String title = list.get(i).title;
				String ptitle = list.get(i).ptitle;
				if (ptitle != null) {
					steps ++;	// 有跨行表头则后面的表头顺延
					level.append(title+":"+(subColStart+steps)+",");  //默认一行一列   格式(title:subColStart)
				}else {
					subColStart++;	//子表头开始列数
				}
			}
			steps = 0;
			if (level.length() > 0) {
				headers.add(level.substring(0, level.length() - 1));
				level.delete(0, level.length());
			} 
		}
		return (ArrayList) headers;
	}
	
	
	/**
	 * 
	 * 
	 * @param params
	 * @param pluginName
	 * @param fields
	 * @return
	 * @throws InstantiationException
	 * @throws IllegalAccessException
	 * @throws ClassNotFoundException
	 * @throws SecurityException
	 * @throws NoSuchMethodException
	 * @throws NoSuchFieldException
	 * @throws IllegalArgumentException
	 * @throws InvocationTargetException
	 */
	private static List getPluginReportData(String params, String pluginName, String[] fields) throws Exception {
		Object obj = Class.forName(pluginName).newInstance();
		// 获取 getSql() 方法
		
		Class[] argsClass = new Class[2];
		argsClass[0]=String.class;
		argsClass[1]=boolean.class;
		Method getSql = Class.forName(pluginName).getMethod("getSql", argsClass);
		String sql = (String) getSql.invoke(obj, params,true);
		Query query = JPA.em().createNativeQuery(sql);
		List<Map<String, Object>> list = CommonUtil.list2Map(query.getResultList(), fields);
		return list;
	}
	
	/**
	 * 获得要导出字段
	 * 
	 * @param formkey
	 * @param params 
	 * @return
	 */
	private static String[] getFields(String formkey) {
		MetaForm form = MetaUtils.findFormByKey(formkey);
		List<MetaSubcolumn> columnlist = MetaSubcolumn.find(
				"from MetaSubcolumn ms where ms.columnid = ? and (ms.listisdisplay = 1 or ms.isdynamicadd = 1 ) order by listlocation",
				form.columnid).fetch();
		try {
			ComplexReportProcessUtils utils = new ComplexReportProcessUtils();
			columnlist = utils.dynamicadd(columnlist);
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (CloneNotSupportedException e) {
			e.printStackTrace();
		}
		StringBuilder sb = new StringBuilder();
		String fieldname = null;
		for (MetaSubcolumn obj : columnlist) {
			try {
				fieldname = obj.field.split("!")[1].toLowerCase();
			} catch (Exception e) {
				throw new RuntimeException("元数据字段表字段名格式错误,格式:表名!字段名");
			}
			if (obj.listisdisplay.intValue() != AppContrast.FALSE) {
				if (obj.edittype.intValue() == AppContrast.INPUT_COMBO) {
					sb.append(fieldname).append("__display,");
				} else {
					sb.append(fieldname).append(",");
				}
			}
		}
		return sb.toString().split(",");
	}
	
}
