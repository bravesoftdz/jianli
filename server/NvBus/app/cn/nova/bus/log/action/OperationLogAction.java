package cn.nova.bus.log.action;

import cn.nova.bus.action.BaseAction;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.persistence.Transient;

import util.CurrentUtil;
import cn.nova.bus.log.model.Operationlog;
import cn.nova.bus.log.service.OperationLogService;
import cn.nova.bus.log.service.impl.OperationLogServiceImpl;
import cn.nova.bus.security.Global;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.web.ServletPropertyFilterUtil;
import play.mvc.Http;
import play.mvc.Http.Request;

/**
 * 公共日志记录
 * @author qjw
 *
 */
public class OperationLogAction extends BaseAction{

	//保存的参数
	public Operationlog operationlog;
	
	private OperationLogService operationlogservice;
	
	private List<Map<String,Object>>  operationlogmap;
	
	public String findOperationlog(){
		try{
			operationlogservice = new OperationLogServiceImpl();
			List<PropertyFilter> propertyFilterList =ServletPropertyFilterUtil.buildFromHttpRequest();
		 setOperationlogmap(operationlogservice.query(propertyFilterList));			
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
		
	public String savelog(){
		operationlogservice = new OperationLogServiceImpl();
		Global global = CurrentUtil.getGlobal();
		if(global==null){
			msg = "日志保存成功";
			markSuccess();
			return "json";
		}
		 //从当前会话全局获取用户信息id、Ip、会话Id		
		operationlog.setUserid(global.getUserinfo().getId());
		String remoteIP = getIpAddr();
		if(!remoteIP.equals(global.getIpAddress())) {
			play.Logger.info("savelog--------------------------");
			play.Logger.info("remoteIP="+remoteIP);
			play.Logger.info("global.getIpAddress()="+global.getIpAddress());
		}
		global.setIpAddress(remoteIP);
		operationlog.setIp(remoteIP);
		operationlog.setSessionid(global.getSessionID());
		operationlog.setOperatetime(new Date());
		try{
			operationlogservice.savelog(operationlog);
			msg = "日志保存成功";
			markSuccess();
			System.out.println("数据操作日志已保存");
		}catch(Exception ex){
			System.out.println("保存数据操作日志失败；"+ex);
			msg = "日志保存失败";
			markFail();
		}
		return "json";
	}

	@Transient
	public Operationlog getOperationlog() {
		return operationlog;
	}

	public void setOperationlog(Operationlog operationlog) {
		this.operationlog = operationlog;
	}

	@Transient
	public List<Map<String, Object>> getOperationlogmap() {
		return operationlogmap;
	}

	public void setOperationlogmap(List<Map<String, Object>> operationlogmap) {
		this.operationlogmap = operationlogmap;
	}
	private String getIpAddr() {
		Request request = Request.current();
		Map<String, Http.Header> headerMap = request.headers;
		Http.Header ip = headerMap.get("x-forwarded-for");
		if (ip == null || ip.value().length() == 0 || "unknown".equalsIgnoreCase(ip.name)) {
			ip = headerMap.get("Proxy-Client-IP");
		}
		if (ip == null || ip.value().length() == 0  || "unknown".equalsIgnoreCase(ip.name)) {
			ip = headerMap.get("WL-Proxy-Client-IP");
		}
		if (ip == null || ip.value().length() == 0  || "unknown".equalsIgnoreCase(ip.name)) {
			return request.remoteAddress;
		}
		return ip.name;
	}

}
