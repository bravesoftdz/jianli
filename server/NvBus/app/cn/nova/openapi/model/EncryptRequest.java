package cn.nova.openapi.model;

import java.util.HashMap;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import util.AppConstant;
import util.JsonUtil;
import cn.nova.openapi.model.request.BaseRequsttModel;
import cn.nova.openapi.util.Md5Digest;
import cn.nova.openapi.util.RSAUtils;

/**
 * 加密请求，参数封装类
 * @author Mark
 *
 */
public class EncryptRequest {
	private static String uid;
	private BaseRequsttModel model;
	private Map<String, Object> map;
	
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
	
	public EncryptRequest(){
		map = new HashMap<String, Object>();
	}
	
	
	/**
	 * 用map初始化一个EncryptRequest
	 * 对于那种请求参数少的，用此法
	 * @param map
	 */
	public EncryptRequest(Map<String, Object> map){
		this.map = map;
	}
	
	/**
	 * 用BaseRequsttModel初始化一个EncryptRequest
	 * 对于请求参数多的，实现BaseRequsttModel抽象类，传入。
	 * @param map
	 */
	public EncryptRequest(BaseRequsttModel model){
		this.model = model;
	}
	
	public void put(String key, Object value){
		map.put(key, value);
	}
	
	/**
	 * 如果用map初始化一个EncryptRequest，可用此法得到加密后的请求map
	 * @return
	 */
	public Map<String, String> getReustMap4Map(){
		HashMap<String, String> requstMap = new HashMap<String, String>();
		String datastr = JsonUtil.toFullString(this.map);
//		System.out.println("加密前请求：" + datastr);
		requstMap.put("uid",  getUid());
		requstMap.put("data", getEncryptedString(datastr));
		requstMap.put("md5", getMd5String(datastr));
		return requstMap;	
	}
	
	/**
	 * 如果用BaseRequsttModel初始化一个EncryptRequest，可用此法得到加密后的请求map
	 * @return
	 */
	public Map<String, String> getReustMap4Model(){
		HashMap<String, String> requstMap = new HashMap<String, String>();
		String datastr = JsonUtil.toFullString(model);
//		System.out.println("加密前请求：" + datastr);
		requstMap.put("uid",  getUid());
		requstMap.put("data", getEncryptedString(datastr));
		requstMap.put("md5", getMd5String(datastr));
		return requstMap;	
	}
	
	/**
	 * 如果不知道是用model还是map初始化的，可用此法。
	 * 默认先找model，然后找map
	 * @return
	 */
	public Map<String, String> getRequstMap(){
		if(model != null){
			return getReustMap4Model();
		}
		return getReustMap4Map();
	}
	
	/**
	 * 加密字符串
	 * @param datastr
	 * @return
	 */
	private String getEncryptedString(String datastr){
		String encyprtStr = "";
		try {
			encyprtStr = RSAUtils.encryptByPrivateKey(datastr, AppConstant.getValue("openapi.privatekey"));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return encyprtStr;
	}
	
	private String getMd5String(String source){
		return Md5Digest.md5(source);
	}
}
