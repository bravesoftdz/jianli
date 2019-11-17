package cn.nova.openapi.model.response;

/**
 * 加密的响应封装对象。
 * @author Mark
 *
 */
public class EncyprtResponseModel extends BaseResponseModel {
	public String rescode;
	public String resmsg;
	public String uid;
	
	public boolean isOk(){
		return rescode.equals("0000");
	}
	
	public boolean isNotOk(){
		return !rescode.equals("0000");
	}
	
}
