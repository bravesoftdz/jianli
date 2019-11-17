package cn.nova.openapi.model;

import util.AppConstant;
import cn.nova.openapi.util.Md5Digest;
import cn.nova.openapi.util.RSAUtils;


/**
 * @author Mark
 *
 */
public class EncyprtResponse {
	public String uid;
	public String data;
	public String md5;
	
	/**
	 * 获取响应中的加密内容，并解密后，返回。
	 * @return
	 * @throws Exception
	 */
	public String getDecyprtData() throws Exception{
		String decyprt = decyprt();
		if(calcMd5(decyprt)){
			return decyprt;
		}else{
			throw new Exception("响应数据不正常");
		}
	}
	
	/**
	 * 解密内容
	 * @return
	 */
	public String decyprt(){
		String decyprtStr = "";
		try {
			decyprtStr = RSAUtils.decryptByPrivateKey(data, AppConstant.getValue("openapi.privatekey"));
			play.Logger.info(decyprtStr);
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return decyprtStr;
	}
	
	/**
	 * 计算md5
	 * @param decyprt
	 * @return
	 */
	public boolean calcMd5(String decyprt){
		String md5New = Md5Digest.md5(decyprt);
		return md5.equals(md5New);
	}
}