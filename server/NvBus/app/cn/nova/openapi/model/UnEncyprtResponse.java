package cn.nova.openapi.model;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Transient;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.TypeReference;

import util.JsonUtil;


/**
 * 没加密的请求，响应对象封装。
 * @author Mark
 *
 */
public class UnEncyprtResponse {
	public String rescode;
	public String resmsg;
	public int totalrows;
	public Object data;
	
	/**
	 * 判断请求是否成功
	 * @return
	 */
	public boolean isOk(){
		return rescode.equals("0000");
	}
	
	/**
	 * 判断请求是否失败
	 * @return
	 */
	public boolean isNotOk(){
		return !rescode.equals("0000");
	}
}