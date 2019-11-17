package util;

import java.util.HashMap;
import java.util.Map;

import org.codehaus.jackson.map.ObjectMapper;

import cn.nova.openapi.util.Md5Digest;
import cn.nova.openapi.util.RSAUtils;

public class SecretClientUtil {  
	private Map<String, Object> dataparams = null;
	private String data = null;
	/**
	 * 加密生成签名
	 * @param privateKey
	 * @param md5key
	 * @param data
	 * @return
	 * @throws Exception
	 */
	public static Map<String, String> encryptData(String privateKey,String md5key,String data) throws Exception{
		Map<String, String> encryptmap = new HashMap<String, String>();
		String md5 = Md5Digest.md5WithKey(data, md5key);
		encryptmap.put("md5", md5);
		data = RSAUtils.encryptByPrivateKey(data, privateKey);
		encryptmap.put("data", data);
		return encryptmap;
	}
	
	public boolean decryptData(String privateKey,String md5key,String checkdata,String md5){
		boolean result = false;
		try {
			//RSA私钥解密
			data = RSAUtils.decryptByPrivateKey(checkdata, privateKey);
			String md5new = Md5Digest.md5WithKey(data, md5key);
			if(!md5new.equals(md5)){
				result = false;
				return result;
			}
			ObjectMapper mapper = new ObjectMapper(); 
			mapper.configure(org.codehaus.jackson.JsonParser.Feature.ALLOW_UNQUOTED_FIELD_NAMES, true);
			dataparams = mapper.readValue(data, Map.class);
			result = true;
		} catch (Exception e) {
			e.printStackTrace();
			result = false;
		}
		return result;
	}
	
	public Map<String, Object> getData(){
		return this.dataparams;
	}
	
	public String getDataJSON(){
		return this.data;
	}
}