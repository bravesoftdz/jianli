package util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.TimeUnit;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.NameValuePair;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.params.HttpMethodParams;
import play.Logger;
import play.libs.F.Promise;
import play.libs.WS;
import play.libs.WS.HttpResponse;
import play.libs.WS.WSRequest;
import play.mvc.Controller;
import play.mvc.Http.Response;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.system.model.Organization;
import cn.nova.bus.system.service.OrganizationService;
import cn.nova.bus.system.service.impl.OrganizationServiceImpl;
import cn.nova.utils.commons.MethodResult;
import cn.nova.utils.orm.jpa.IDAO;

public class RpcUtil extends Controller{ 
	public static final Map<String,String> jsonHeaders = new HashMap<String,String>();
	public final static int WAITTIME = 100;//等待时间(微秒)
	public final static int TIMEOUT = 10;//10s 
	static{
		jsonHeaders.put("Accept", "application/json, text/javascript, */*; q=0.01");
	}
	public static String getRemoteIp() throws Exception{
		OrganizationService organizationService = new OrganizationServiceImpl();
		Organization organization = CurrentUtil.getGlobal().getOrganization();
		Organization centreOrg = organizationService.getDirectlyParentOrg(organization);
		if(centreOrg==null){
			String errorWorld = "无法连接中心服务器:找不到" + organization.getName() + "的上级机构";
			Logger.warn(errorWorld);
			throw new Exception(errorWorld);
		}
		return centreOrg.getAddress();
	}
	
	public static String getRemoteIp(Long orgid){
		IDAO<Organization> dao = new EntityManagerDaoSurport<Organization>();
	    Organization org = dao.get(Organization.class, orgid);
		return org.getServersaddress();
	}
	
	public static MethodResult remoteMethodCall(String remoteIp, String actionurl, Map<String, String> requestMap) throws Exception{
		String remoteCall = remoteCall(remoteIp, actionurl, requestMap);
		
		MethodResult methodResult = new MethodResult();
		if(remoteCall == null || "".equals(remoteCall)){
			play.Logger.info(remoteIp + actionurl + "远程调用失败！methodResult为空。");
			throw new Exception("远程调用失败！");
		}
		try{
			methodResult = JsonUtil.parseObject(remoteCall, MethodResult.class);
		}catch(Exception e){
			play.Logger.error(e.getMessage(), e);
			play.Logger.info(remoteIp + actionurl + "远程调用失败！转换响应对MethodResult对象失败");
			throw new Exception("远程调用失败！");
		}
		return methodResult;
	}
	
	public static String remoteCallGet(String url, Map<String, String> requestMap){
		if(!url.startsWith("http")){
			url = "http://" + url;
		}		
		HttpResponse resp = WS.url(url).setParameters(requestMap).get();
		return readStream(resp);
	};
	public static String remoteCallPost(String url, Map<String, String> requestMap){
		if(!url.startsWith("http")){
			url = "http://" + url;
		}		
		HttpResponse resp = WS.url(url).setParameters(requestMap).post();
		return readStream(resp);
	};
	
	public static String remoteCall(String remoteIp, String actionurl,Map<String, String> requestMap) throws Exception{
		if(!remoteIp.startsWith("http")){
			remoteIp = "http://" + remoteIp;
		}
		HttpResponse resp = null;
		try{
//			WSRequest request = WS.url(remoteIp + actionurl);
//			request.timeout = 1;
//			resp = request.setParameters(requestMap).post();
			resp = WS.url(remoteIp + actionurl).setParameters(requestMap).post();
		}catch(Exception e){
			play.Logger.info(remoteIp + actionurl + "远程调用失败！异常信息：" + e.getMessage());
			play.Logger.error(e.getMessage(), e);
			throw new Exception("远程调用失败！",e);
		}
		
		if( 200 != resp.getStatus()){
			play.Logger.info(remoteIp + actionurl + "远程调用失败！响应码为：" + resp.getStatus());
			play.Logger.info(remoteIp + actionurl + "远程调用失败！响应码为：" + resp.getString("status"));
			play.Logger.info(remoteIp + actionurl + "远程调用失败！响应码为：" + resp.getString("data"));
			throw new Exception("远程调用失败！");
		}
		
		return readStream(resp);
	}

	private static String readStream(HttpResponse resp) {
		InputStream is = resp.getStream();
		BufferedReader reader = new BufferedReader(new InputStreamReader(is));   
		StringBuilder sb = new StringBuilder();   
		String line = null;   
		try {   
		    while ((line = reader.readLine()) != null) {   
		        sb.append(line);   
		    }   
		} catch (IOException e) {   
		    play.Logger.error(e.getMessage(), e);   
		} finally {   
		    try {   
		        is.close();   
		    } catch (IOException e) {   
		        play.Logger.error(e.getMessage(), e);   
		    }   
		}
		
		String str = sb.toString();
		return str;
	}
	/**
	 * Post方式HTTP异步调用
	 * @param url
	 * @param timeout 请求超时时间
	 * @return
	 */
	public static String httpPost(String url,int timeout,Map<String,String> params){
		String reString = null;
		try{
			WSRequest req = WS.url(url);
			req.headers.put("Accept","application/json, text/javascript, */*; q=0.01");
			req.setParameters(params);
			Promise<HttpResponse> promise = req.postAsync();
			HttpResponse res = promise.get(timeout, TimeUnit.MILLISECONDS);
			if(res != null){
				reString = res.getString("UTF-8");
				Response.current().status = res.getStatus();
			}
		}catch(Exception e){
			 play.Logger.error(e.getMessage(), e);   
		}
		return reString;
	}
	/**
	 * Post方式HTTP异步调用
	 * @param url
	 * @param timeout 请求超时时间
	 * @return
	 */
	public static String httpPost(String url,int timeout,Object params){
		String reString = null;
		try{
			WSRequest req = WS.url(url);
            req.headers.put("Accept","application/json, text/javascript, */*; q=0.01");
            req.setHeader("Content-Type","application/json;charset=UTF-8");
            req.body(params);
			Promise<HttpResponse> promise = req.postAsync();
			HttpResponse res = promise.get(timeout, TimeUnit.MILLISECONDS);
			if(res != null){
				reString = res.getString("UTF-8");
				Response.current().status = res.getStatus();
			}
		}catch(Exception e){
			play.Logger.error(e.getMessage(), e);
		}
		return reString;
	}
	/**
	 * GET方式HTTP异步调用
	 * @param url 请求地址
	 * @param headers 请求消息头 传入null为jsonHeaders
	 * @param timeout 获取返回超时时间
	 * @param responseEncoding 传入空为UTF-8
	 * @return
	 */
	public static String httpGet(String url,Map<String,String> headers,int timeout,String responseEncoding){
		if(null == headers){
			headers = jsonHeaders;
		}
		if(null == responseEncoding || "".equals(responseEncoding)){
			responseEncoding = "UTF-8";
		}
		String reString = null;
		try{
			WSRequest req = WS.url(url);
			req.timeout = timeout<=0 ? TIMEOUT : timeout / 1000;
			req.headers.putAll(headers);
			HttpResponse res = req.get();
			if(res != null){
				reString = res.getString(responseEncoding);
				Response.current().status = res.getStatus();
			}
		}catch(Exception e){
			 play.Logger.error(e.getMessage(), e);   
		}
		return reString;
	}
	
	public static String httpPostByLink(String uri,Map<String,String> params,String httpContentCharset)throws Exception{
		PostMethod postMethod = null;
		try {
			HttpClient client = new HttpClient();
			client.getHttpConnectionManager().getParams().setConnectionTimeout(10000);
		    client.getHttpConnectionManager().getParams().setSoTimeout(100000);
		    
		    postMethod = new PostMethod(uri);
		    if(null != httpContentCharset){
		    	postMethod.getParams().setParameter(HttpMethodParams.HTTP_CONTENT_CHARSET, httpContentCharset);
		    }
		    postMethod.addParameters(transFromMap(params));
    		client.executeMethod(postMethod);
    		String responsetext = postMethod.getResponseBodyAsString();
    		return responsetext;
		} catch (Exception e) {
			throw e;
		}finally{
			if(postMethod != null){
				postMethod.releaseConnection();
			}
		}
	}
	/**
	 * 将Map<String,String>中的数据转换为httpclient  PostMehtod 需要的参数格式
	 * @param map
	 * @return
	 */
	private static NameValuePair[] transFromMap(Map<String,String> map){
		NameValuePair[] pairs = new NameValuePair[map.size()];
		int i = 0;
		for(String key :map.keySet()){
			pairs[i] = new NameValuePair();
			pairs[i].setName(key);
			pairs[i].setValue(map.get(key));
			i++;
		}
		return pairs;
	}
}
