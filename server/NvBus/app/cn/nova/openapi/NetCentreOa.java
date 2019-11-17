package cn.nova.openapi;



import org.apache.commons.lang.StringUtils;

import util.AppConstant;
import util.JsonUtil;
import util.RpcUtil;
import cn.nova.openapi.model.EncryptRequest;
import cn.nova.openapi.model.EncyprtResponse;
import cn.nova.openapi.model.UnEncyprtRequst;
import cn.nova.openapi.model.UnEncyprtResponse;

/**
 * openapi接口，所有的URL地址，与调用方法。
 * @author Mark
 *
 */
public class NetCentreOa {
	public static String ip;
	public final static  String DEPART_STATION_QUERY = "/openapi/departcities";
	public final static  String REACH_STATION_QUERY = "/openapi/reachstations";
	public final static  String SCHEDULE_QUERY = "/openapi/searchschedules";
	public final static  String LOCK_SEAT = "/openapi/locktickets";
	public final static  String UNLOCK_SEAT = "/openapi/unlocktickets";
	public final static  String SELL_TICKET = "/openapi/selltickets";
	public final static  String CANCEL_TICKET = "/openapi/cancelticket";
	public final static  String RETURN_TICKET = "/openapi/refundticket";
	public final static  String ORDER_QUERY = "/openapi/orderquery";
	public final static  String CHANGE_TICKET = "/openapi/changeticketno";
	public final static  String DAILY_LEDGER = "";
	public final static  String DETAIL_LEDGER = "";
	
	/**
	 * 得到openapi服务器地址
	 * @return
	 */
	public static String getRemoteApiUrl(){
		if(StringUtils.isEmpty(ip)){
			ip = AppConstant.getValue("openapi.url");
		}
		return ip;
	}
	
	/**
	 * 发送没有加密的get请求。
	 * @param path 不包含ip的路径
	 * @param requstParam 请求map
	 * @return
	 */
	public static UnEncyprtResponse sentUnEncyprtGet(String path, UnEncyprtRequst requstParam){
		String rs = RpcUtil.remoteCallGet(getRemoteApiUrl() + path, requstParam.getRequstMap());
		play.Logger.info(rs);
		UnEncyprtResponse result = JsonUtil.parseObject(rs, UnEncyprtResponse.class);
		return result;		
	}
	
	/**
	 * 发送加密的post请求
	 * @param path 不包含ip的路径
	 * @param encryptParam 加密请求map
	 * @return
	 */
	public static EncyprtResponse sendEncyprtPost(String path, EncryptRequest encryptParam){
		String rs = RpcUtil.remoteCallPost(getRemoteApiUrl() + path, encryptParam.getRequstMap());
		play.Logger.info("加密后请求：" + JsonUtil.toFullString(encryptParam.getRequstMap()) );
		play.Logger.info("结果：" + rs);
		EncyprtResponse result = JsonUtil.parseObject(rs, EncyprtResponse.class);
		return result;
	}

}
