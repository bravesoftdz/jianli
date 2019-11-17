package controllers.report;

import java.util.Map;

import models.Result;
import play.data.validation.Validation;
import bp.report.FileDataBP;
import bpinterface.report.FileDataInterface;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SerializerFeature;

import controllers.Application;

public class FileDataAction extends Application {
	public static void getPage(String formkey, String params, int page,
			int rows, String orderCondition, boolean isPagination) throws Exception {
		FileDataInterface filebp = new FileDataBP();
		Map<String, Object> map = filebp.getPage(formkey, params, page, rows,
				orderCondition, isPagination);
		renderText(JSON.toJSONStringWithDateFormat(map, "yyyy-MM-dd",
				SerializerFeature.WriteDateUseDateFormat));
	}
	
	public static void autoComplete(Long fieldid,String params){
		FileDataInterface filebp = new FileDataBP();
		Map<String,Object> map = filebp.autoComplete(fieldid,params);
		renderText(JSON.toJSONStringWithDateFormat(map,"yyyy-MM-dd", SerializerFeature.WriteDateUseDateFormat));
	}
}
