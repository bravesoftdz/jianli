package controllers.report;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import play.mvc.Http.Cookie;
import play.mvc.Http.Request;
import util.CommonUtil;
import util.RedisUtil;
import util.RedisUtil.RedisDBApp;
import cn.nova.bus.report.service.QueryBalanceitemService;
import cn.nova.bus.report.service.impl.QueryBalanceitemServiceImpl;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.TypeReference;
import com.alibaba.fastjson.serializer.SerializerFeature;

import controllers.Application;
import controllers.ExportObject;


public class QueryBalanceItemAction extends Application {
	/*运费结算明细表--界面*/
	public static void index() {
		render("/report/queryBalanceItem.html");
	}
	/*运费结算明细表--数据*/
	public static void getData(String params) { 
		renderText(JSON.toJSONString(getBase(params), SerializerFeature.WriteDateUseDateFormat));
	}
	/*运费结算明细表--导出*/
	public static void exportData(String fields, String titles, String url, String reportClassName,String mergeCells) throws Exception {
		url = url + new SimpleDateFormat("yyyy-MM-dd-HH-mm-ss").format(new Date());
		Cookie ck = Request.current().cookies.get("params");
		fields = RedisUtil.get(RedisDBApp.temp, "Balanceitem");
		
		String se = ck.value;
		String params = java.net.URLDecoder.decode(se, "UTF-8");
		List<Map<String, Object>> map = getBase(params);
		map.remove(0);
		map.remove(map.size()-1);
		Map<String,Object> innerMap = new HashMap<String, Object>();
		innerMap.put("total",map.size() );
		innerMap.put("rows",map );
		controllers.ExportObject eo = new controllers.ExportObject();
		eo.exportUnConfig(fields, titles, url, reportClassName, mergeCells, innerMap);
	}
	public static List<Map<String, Object>> getBase(String params){
		String orgid = ""; 
		String startdate = "";
		String enddate = "";
		Date start_date = new Date();
		Date end_date = new Date();
		String unitid = "";
		String vehicleno = "";
		Map<String, String> paramMap = JSON.parseObject(params,
				new TypeReference<Map<String, String>>() {
		});
		if(CommonUtil.isNotEmptyString( paramMap.get("orgid") )){
			orgid = "(" + paramMap.get("orgid").replaceAll("&", ",") + ")";
		}
		startdate = paramMap.get("startdate");
		enddate = paramMap.get("enddate");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		
		try {
			start_date = sdf.parse(startdate+" 00:00:00");
			end_date = sdf.parse(enddate+" 23:59:59");
		} catch (ParseException e) {
			play.Logger.error("%转换时间格式错误%");
			e.printStackTrace();
		}
		Long unit_id = null;
		if(CommonUtil.isNotEmptyString( paramMap.get("unitid") )){
			unit_id = Long.parseLong(paramMap.get("unitid"));
		}
		if(CommonUtil.isNotEmptyString( paramMap.get("vehicleno") )){
			vehicleno = paramMap.get("vehicleno");
		}
		QueryBalanceitemService qbis = new QueryBalanceitemServiceImpl();
		List<Map<String, Object>> map = qbis.getBalanceitem(orgid, start_date, end_date, unit_id, vehicleno);
		return map;
	}
}
