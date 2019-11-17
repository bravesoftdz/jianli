package cn.nova.openapi.model;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import org.apache.commons.lang.StringUtils;

import util.AppConstant;

/**
 * 非加密的请求参数封装对象
 * @author Mark
 *
 */
public class UnEncyprtRequst {
	private static String uid;
	private Map<String, String> map;
	
	public UnEncyprtRequst(){
		init();
	}
	
	/**
	 * 得到openapi分发的uid
	 * @return
	 */
	public String getUid(){
		if(StringUtils.isEmpty(uid)){
			uid = AppConstant.getValue("openapi.uid");
		}
		return uid;
	}

	/**
	 * 初始化，将uid放到map中
	 */
	private void init(){
		map = new HashMap<String, String>();
		map.put("uid",  getUid());
	}
	
	public void put(String key, String value){
		map.put(key, value);
	}
	
	public Map getRequstMap(){
		return map;
	}
	
}
