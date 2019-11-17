package cn.nova.openapi.util;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


public class ParamUtils {
	/**
	 * 传入一个map返回一个排序后的字符串，如：a=a&b=b&c=c&d=d&e=e
	 * @param params
	 * @return
	 */
	public static String formatParams(Map<String, String> params){
		StringBuffer content = new StringBuffer();
		// 按照key做排序
		List<String> keys = new ArrayList<String>(params.keySet());
		Collections.sort(keys);
		for (int i = 0; i < keys.size(); i++) {
			String key = (String) keys.get(i);
			String value = (String) params.get(key);
			if (value != null) {
				content.append((i == 0 ? "" : "&") + key + "=" + value);
			} else {
				content.append((i == 0 ? "" : "&") + key + "=");
			}

		}
		return content.toString();
	}
	/**
	 * 将满足条件的url参数格式化为map
	 * @param params
	 * @return
	 */
	public static Map<String,String> formatFromString(String params){
		Map<String,String> map = new HashMap<String,String>();
		if(null != params && !"".equals(params)){
			String[] param = params.split("&");
			for(int i=0;i<param.length;i++){
				String[] aparam = param[i].split("=");
				if(aparam.length==2){
					map.put(aparam[0], aparam[1]);
				}
			}
		}
		return map;
	}
	
	public static void main(String[] args){
		Map<String, String> params = ParamUtils.formatFromString("uid=1001&orderno=111&md5=12456");
		for (Map.Entry<String, String> entry : params.entrySet()) {
			System.out.println(entry.getKey()+"="+entry.getValue());
		}
	}
	
	
}
