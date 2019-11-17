package util;

import java.util.List;

import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.map.SerializationConfig;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.serializer.SerializerFeature;
import com.nova.jsonutil.CollectionPlus;

public class JsonUtil {
	public static String toSimpleString(Object obj){
		return JSON.toJSONString(obj);
	}
	
	public static String toFullString(Object obj){
		//对象为空时直接返回
		if(obj==null){
			return "";
		}
		return JSON.toJSONStringWithDateFormat(obj, JSON.DEFFAULT_DATE_FORMAT, 
				SerializerFeature.WriteMapNullValue,  //显示所有字段
				SerializerFeature.WriteNullStringAsEmpty,  //用“”代替null的String
				SerializerFeature.WriteNullListAsEmpty,   //用[]代替null的List
				SerializerFeature.WriteNullNumberAsZero,  //用0代替空的number
				SerializerFeature.WriteNullBooleanAsFalse); //用false代替空的false
	}
	
	public static String toFormatString(Object obj){
		return JSON.toJSONStringWithDateFormat(obj, JSON.DEFFAULT_DATE_FORMAT,SerializerFeature.WriteNullStringAsEmpty,SerializerFeature.WriteNullListAsEmpty, 
		SerializerFeature.WriteNullNumberAsZero, SerializerFeature.WriteNullBooleanAsFalse);			
	}
	
	public static String toString4Action(Object obj){
		CollectionPlus.isAction.set(true);
		String rdjson = toFullString(obj);
		CollectionPlus.isAction.set(false);
		return rdjson;
	}
	
	public static Object[] toObjctArray(Object obj){
		return((JSONArray)obj).toArray();
	}

	public static <T> List<T> parseArray(Object obj, Class<T> clazz) {
		return JSON.parseArray(obj.toString(), clazz);
	}
	
	public static <T> T parseObject(Object obj, Class<T> clazz){
		return JSON.parseObject(obj.toString(), clazz);
	}
	
	public static String parseObject(final Object object) {
		ObjectMapper om=new ObjectMapper();
		String ret=null;
		try {
			om.configure(SerializationConfig.Feature.FAIL_ON_EMPTY_BEANS, false);
			ret=om.writeValueAsString(object);
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return ret;
	}
}
