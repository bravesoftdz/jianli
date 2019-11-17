package controllers;

import java.util.Map;

import models.Result;
import play.data.validation.Validation;
import bp.FileDataBP;
import bpinterface.FileDataInterface;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SerializerFeature;

public class FileDataAction extends Application {
	public static void getPage(String formkey, String params, int page,
			int rows, boolean isPagination) throws Exception {
		FileDataInterface filebp = new FileDataBP();
		Map<String, Object> map = filebp.getPage(formkey, params, page, rows,
				isPagination);
		renderText(JSON.toJSONStringWithDateFormat(map, "yyyy-MM-dd",
				SerializerFeature.WriteDateUseDateFormat));
	}
	
	public static void save(String formkey,String params) throws Exception{
		FileDataInterface filebp = new FileDataBP();
		Result result = filebp.save(formkey,params);
		Validation validation = Validation.current();
		if(validation.hasErrors()){
			response.status = 550;
			renderText(JSON.toJSONString(validation.errors()));
		}
		renderText(JSON.toJSONString(result));
	}

	public static void delete(String formkey,String ids) {
		FileDataInterface filebp = new FileDataBP();
		Result result = filebp.bulkDelete(formkey,ids);
		renderText(JSON.toJSONString(result));
	}
	
	public static void autoComplete(Long fieldid,String params){
		FileDataInterface filebp = new FileDataBP();
		Map<String,Object> map = filebp.autoComplete(fieldid,params);
		renderText(JSON.toJSONStringWithDateFormat(map,"yyyy-MM-dd", SerializerFeature.WriteDateUseDateFormat));
	}
}
