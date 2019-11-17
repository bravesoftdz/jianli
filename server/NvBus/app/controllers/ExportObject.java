package controllers;

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

import models.MetaForm;
import models.MetaSubcolumn;
import play.db.jpa.JPA;
import play.mvc.Http.Cookie;
import play.mvc.Http.Request;
import play.mvc.Http.Response;
import plugin.ExportExcel;
import util.AppContrast;
import util.CommonUtil;
import util.JSUtil;
import bp.FileDataBP;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.TypeReference;

public class ExportObject extends Application {
	public static MetaForm findFormByKey(String formkey) {
		MetaForm form = MetaForm.find("from MetaForm where formkey = ?",
				formkey).first();
		if (form == null) {
			throw new RuntimeException("ERROR.FORM.NOT.EXIST");
		}
		return form;
	}

	/**
	 * 导出完全可配置与部分可配置表格
	 * @param fields 数据字段
	 * @param titles 表头
	 * @param formkey 可配置表格的formkey,用来获取表格的titles和fields
	 * @param url
	 * @throws UnsupportedEncodingException
	 */
	public static void exportExc(String formkey,String url) throws UnsupportedEncodingException {
		Cookie ck = Request.current().cookies.get("params");
		String se = ck.value;
		String params = java.net.URLDecoder.decode(se, "UTF-8");
		String returncolumn = null;  //返回字段
		String model = null; // 对应groupby
		String sqldata = "", datasource=null; // 主查询sql, 对应datasource
		String strsql = null; // 查询条件装配成的sql
		String pluginName = null;  //复杂sql的插件
		List maplist = new ArrayList(); // 中间过渡数据
		List maplistdata = new ArrayList();// 最后需要导出到excel的数据
		List headers = null;
		List list = null;	// query查询出来的数据
		String[] flds = null;

		flds = getFields(formkey);

		String sql = "select datasource,trim(returncolumn),groupby, pluginname,id from meta_column where id = (select columnid from meta_form where formkey = "
				+ formkey + ")";
		Query query = JPA.em().createNativeQuery(sql);
		list = query.getResultList();
		pluginName = (String) Array.get(list.get(0), 3);
		System.out.println();
		if(Array.get(list.get(0),0) instanceof Clob){
			Clob clob = (Clob)Array.get(list.get(0),0);
			if(clob!=null){
				try {
					datasource = clob.getSubString(1, (int) clob.length());
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					play.Logger.error(e.getMessage(), e);
				}
			}
		}else if(Array.get(list.get(0),0) instanceof String){
			datasource = (String)Array.get(list.get(0),0);
		}
		returncolumn = (String) Array.get(list.get(0), 1);
		//权限控制类型的导出
		BigDecimal id= (BigDecimal)Array.get(list.get(0), 4);
		String[] fieldslist = returncolumn.split(",");
		for (int i = 0; i < fieldslist.length; i++) {
			fieldslist[i] = fieldslist[i].trim();
		}
			
		headers = getPluginReportHeader(formkey);
		// 如果配置了datasource则通过 datasource获取导出数据，否则通过插件获取数据；
		if (CommonUtil.isNotEmptyString(datasource)) {
			model = (String) Array.get(list.get(0), 2);
			
			sqldata = datasource;
			Map<String, String> paramMap = new HashMap<String, String>();
			if(CommonUtil.isNotEmptyString(params)){
				paramMap = JSON.parseObject(params, new TypeReference<Map<String,String>>(){});
			}
//			strsql = FileDataBP.createsql(params);
//			sqldata = sqldata + strsql;
//			if (model != null) {
//				sqldata = sqldata + " group by " + model;
//			}
			String regex = "\\^.*?(@(.*?)@).*?\\^";
			Pattern pattern = Pattern.compile(regex);
			Matcher matcher = pattern.matcher(sqldata);
			//替换关键字生成sql
			if (matcher.find()) {
				sqldata = new FileDataBP().getComplexSql(paramMap, sqldata, matcher);
			} else {
				strsql = FileDataBP.createsql(params);
				sqldata = sqldata + strsql;
				if (model != null) {
					sqldata = sqldata + " group by " + model;
				}
			}
			System.out.println("sqldata-->"+sqldata);
			Query qy = JPA.em().createNativeQuery(sqldata);
			List listdata = qy.getResultList();
			
			List map = CommonUtil.list2Map(listdata, fieldslist);
//			List map = CommonUtil.list2Map(listdata, fields);
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
//									if(((BigDecimal)item.get(flds[j])).intValue() == 0){
//										item.put(flds[j], "否");
//									}else if(((BigDecimal)item.get(flds[j])).intValue() == 1){
//										item.put(flds[j], "是");
//									}
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
												int code = ((BigDecimal)Array.get(diglist.get(h), 0)).intValue();
												if(code == ((BigDecimal)item.get(flds[j])).intValue()){
													item.put(flds[j], (String)Array.get(diglist.get(h), 1));
													break;
												}
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
		} else {
			try {
				maplistdata = getPluginReportData(params, pluginName, fieldslist);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				play.Logger.error(e.getMessage(), e);
			}
		}
		
		Response response = Response.current();
		response.reset();

		response.contentType = "application/msexcel;charset=GB2312";
		response.setHeader(
				"Content-disposition",
				"attachment;filename="
						+ java.net.URLEncoder.encode(
								java.net.URLDecoder.decode(url, "utf-8")
										+ ".xls", "UTF-8"));
		ExportExcel.exportExc(maplistdata, headers, flds, url, response.out);
	}
	
	/**
	 * 导出不可配置表格
	 * @param fields	数据字段
	 * @param titles	表头
	 * @param url
	 * @param reportClassName	导出表格对应的*BP.java类
	 * @param mergeCells		需要合并的数据单元格
	 * @throws UnsupportedEncodingException
	 * @throws SecurityException
	 * @throws NoSuchMethodException
	 * @throws InstantiationException
	 * @throws IllegalAccessException
	 * @throws ClassNotFoundException
	 * @throws IllegalArgumentException
	 * @throws InvocationTargetException
	 * @throws NoSuchFieldException
	 */
	public static void exportExcUnConfig(String fields, String titles, String url, String reportClassName, String mergeCells) throws UnsupportedEncodingException, SecurityException, NoSuchMethodException, InstantiationException, IllegalAccessException, ClassNotFoundException, IllegalArgumentException, InvocationTargetException, NoSuchFieldException {
		Cookie ck = Request.current().cookies.get("params");
		String se = ck.value;
		String params = java.net.URLDecoder.decode(se, "UTF-8");
		System.out.println("................ excel.....  params="+params);
		System.out.println("................ titles="+titles);
		String[] tableHeaders = titles.split(",");
		Object obj = Class.forName(reportClassName).newInstance();
		Map<String, Object> map = null;
		Map<String, String> paramMap = null;
		String top = "";	//报表上面的部分
		String tail = "";	//报表下面的部分
		String type = null;	//标识哪一个报表
		// 获取 getPage() 方法
		Method getPage = null;
		Method[] ms = Class.forName(reportClassName).getDeclaredMethods();
		for (Method m: ms) {
			String methodName = m.getName();
			if ("getPage".equals(methodName)) {
				Class[] paramTypes = m.getParameterTypes();
				if (paramTypes.length == 1) {
					getPage = Class.forName(reportClassName).getMethod("getPage", new Class[]{String.class});
					map = (Map<String, Object>)getPage.invoke(obj, new Object[]{params});
				} else {
					getPage = Class.forName(reportClassName).getMethod("getPage", new Class[]{String.class, int.class, int.class});
					map = (Map<String, Object>)getPage.invoke(obj, new Object[]{params, 0 ,0});
				}
				break;
			}
		}
		if (CommonUtil.isNotEmptyString(params)) {
			paramMap = JSON.parseObject(params,	new TypeReference<Map<String, String>>() {});
			type = paramMap.get("type");
		}
		if ("year".equals(type) || "season".equals(type) || "month".equals(type)) {
			if ("year".equals(type)) {
				top += "站务作业年报统计汇总表:0:0:22:1,";
				top += map.get("year")+"年"+":3:1:3:1," + "表8:18:1:1:1,";
			} else if ("season".equals(type)) {
				top += "站务作业季报统计汇总表:0:0:25:1,";
				top += map.get("year")+"年"+map.get("month")+"月:4:1:3:1," + "表7:19:1:1:1,";
			} else {
				top += "站务作业月报统计汇总表:0:0:25:1,";
				top += map.get("year")+"年"+map.get("month")+"月:4:1:3:1," + "表5:19:1:1:1,";
			}
			top += "填报单位："+map.get("unitname")+":0:2:4:1";
			tail += "备注：1、客运量以二次验票人数为准；2、其他收入是指除窗口售票收入、停车费、卫生费、租赁收入以外的站务收入，如洗车费等；3、进站车辆数为时期指标。:0:0:15:1,";
			tail += "单位负责人：:0:1:2:1,"+"审核人：:4:1:2:1,"+"填报人：:8:1:2:1,"+"联系电话：:12:1:2:1";
		} else if("stationDaySummaryReport".equals(type) || "subStationDaySummaryReport".equals(type)) {
			if ("stationDaySummaryReport".equals(type)) {
				top += "站务作业日报统计汇总表:0:0:12:1,"; 
			} else {
				top += "各子公司站务作业统计日报表:0:0:12:1,"; 
			}
			top += "填报部门："+map.get("deptname")+":0:1:2:1,"+"日期："+map.get("year")+"年"+map.get("month")+"月"+map.get("day")+"日:9:1:3:1";
			tail += "部门负责人：:0:0:2:1,"+"填报人：:4:0:2:1,"+"联系电话：:8:0:2:1";
		} else if ("subCompanySummaryReport".equals(type)) {
			top += "各子公司站务系统统计月报表:0:0:14:1,";
			top += "填报单位："+map.get("filldeptname")+":0:1:2:1,"+"子公司："+map.get("branchdeptname")+":3:1:3:1,"+"查询日期："+map.get("searchStartDate")+"  至   "+map.get("searchEndDate")+":7:1:4:1,打印日期："+map.get("printDate")+":9:1:3:1,"+"表5:11:1:4:1";
			tail += "备注：1、客运量以二次验票人数为准；2、其他收入是指除窗口售票收入、停车费、卫生费、租赁收入以外的站务收入，如洗车费等；3、进站车辆数为时期指标。:0:0:15:1,";
			tail += "单位负责人：:0:1:2:1,"+"审核人：:4:1:2:1,"+"填报人：:8:1:2:1,"+"联系电话：:12:1:2:1";		
		}
		Response response = Response.current();
		response.reset();
		
		response.contentType = "application/msexcel;charset=GB2312";
		response.setHeader(
				"Content-disposition",
				"attachment;filename="
						+ java.net.URLEncoder.encode(
								java.net.URLDecoder.decode(url, "utf-8")
										+ ".xls", "UTF-8"));
		System.out.println("................  map="+map);
		ExportExcel.exportUnExc(top, tail, (List)map.get("rows"), tableHeaders, fields.split(","), url, response.out, mergeCells);
	}

	private static ArrayList getPluginReportHeader(String formkey) {
		String subColumnsSql = "select title,field,ptitle from meta_subcolumn ms where ms.listisdisplay=1 and ms.columnid = (select columnid from meta_form where formkey = "
			+ formkey + ") order by ms.listlocation";
		Query subColumnsquery = JPA.em().createNativeQuery(subColumnsSql);
		List list = subColumnsquery.getResultList();
		int size = list.size();
		int maxLevel = 0;	//总共有多少级表头
		int subColStart = 0;	// 子表头从哪列开始
		StringBuilder level = new StringBuilder();
		List<String> headers = new ArrayList<String>();

		for (int i =0; i < size; i ++) {
			String ptitle = (String)Array.get(list.get(i), 2);
			if (ptitle != null) {
				if (ptitle.split("\\|").length>maxLevel) {
					maxLevel = ptitle.split("\\|").length;
				}
			}
		}
		maxLevel += 1;
		//父表头
		for (int i =0; i < size; i ++) {
			String title = (String)Array.get(list.get(i), 0);
			String ptitle = (String)Array.get(list.get(i), 2);
			int columns = 0;
			// 必须先执行if统计subColStart再执行else,否则每次添加子列时subColStart都不同
			if (ptitle == null){
				level.append(title+":0:"+maxLevel+":1,");   //n(两)行一列  title:rowStart:rowNum(所占行数):colNum(所占列数)
			} else {
				//统计父title占的列数
				for (int j =0; j < size; j ++) {
					if (ptitle.equals((String)Array.get(list.get(j), 2))) {
						columns += 1;
					}
				}
				// 多个子表头对应一个父表头，但level1中添加一个父表头，不能重复
				if ((i + 1) == size || !ptitle.equals((String)Array.get(list.get(i+1), 2))) {
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
				String title = (String)Array.get(list.get(i), 0);
				String ptitle = (String)Array.get(list.get(i), 2);
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
	
	private static List getPluginReportData(String params, String pluginName, String[] fields) throws InstantiationException, IllegalAccessException, ClassNotFoundException, SecurityException, NoSuchMethodException, NoSuchFieldException, IllegalArgumentException, InvocationTargetException {
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
	
	public static String[] getFields(String formkey) {
		MetaForm form = findFormByKey(formkey);
		List<MetaSubcolumn> columnlist = MetaSubcolumn.find(
				"from MetaSubcolumn ms where columnid = ? and ms.listisdisplay = 1 order by listlocation",
				form.columnid).fetch();
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
	
	/**
	 * 其他手写的导出
	 * @param fields
	 * @param titles
	 * @param url
	 * @param reportClassName
	 * @param mergeCells
	 * @throws UnsupportedEncodingException
	 * @throws SecurityException
	 * @throws NoSuchMethodException
	 * @throws InstantiationException
	 * @throws IllegalAccessException
	 * @throws ClassNotFoundException
	 * @throws IllegalArgumentException
	 * @throws InvocationTargetException
	 * @throws NoSuchFieldException
	 */
	public  void exportUnConfig(String fields, String titles, String url, String reportClassName, String mergeCells,Map<String,Object> map) throws UnsupportedEncodingException, SecurityException, NoSuchMethodException, InstantiationException, IllegalAccessException, ClassNotFoundException, IllegalArgumentException, InvocationTargetException, NoSuchFieldException {
		String[] tableHeaders = titles.split(",");
		Object obj = Class.forName(reportClassName).newInstance();
		Map<String, String> paramMap = null;
		String top = "";	//报表上面的部分
		String tail = "";	//报表下面的部分
		String type = null;	//标识哪一个报表
		// 获取 getPage() 方法
		Method getPage = null;
		// 获取getMerge方法
		Method getMerge = null;
		Method[] ms = Class.forName(reportClassName).getDeclaredMethods();
		// 获取getMerge方法
		for (Method m: ms) {
			String methodName = m.getName();
			if ("getMerge".equals(methodName)) {
				Class[] paramTypes = m.getParameterTypes();
				if (paramTypes.length == 1) {
					getMerge = Class.forName(reportClassName).getMethod(methodName, new Class[]{List.class});
				}
				break;
			}
		}
//		if (CommonUtil.isNotEmptyString(params)) {
//			paramMap = JSON.parseObject(params,	new TypeReference<Map<String, String>>() {});
//			type = paramMap.get("type");
//		}
		Response response = Response.current();
		response.reset();
		
		response.contentType = "application/msexcel;charset=GB2312";
		response.setHeader(
				"Content-disposition",
				"attachment;filename="
						+ java.net.URLEncoder.encode(
								java.net.URLDecoder.decode(url, "utf-8")
										+ ".xls", "UTF-8"));
		System.out.println("................  map="+map);
		
		ExportExcel.exportUnExc(top, tail, (List)map.get("rows"), tableHeaders, fields.split(","), url, response.out, mergeCells,getMerge,obj);
	}
	
	public static void getselect(String formkey) {
		MetaForm form = findFormByKey(formkey);
		List<MetaSubcolumn> columnlist = MetaSubcolumn.find(
				"from MetaSubcolumn where columnid = ? order by listlocation",
				form.columnid).fetch();
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
		renderText(sb.toString());
	}
}
