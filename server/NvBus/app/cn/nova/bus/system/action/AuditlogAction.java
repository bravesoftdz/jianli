package cn.nova.bus.system.action;

import cn.nova.bus.action.BaseAction;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import cn.nova.bus.system.service.AuditlogService;
import cn.nova.bus.system.service.impl.AuditlogServiceImpl;
import cn.nova.utils.orm.listener.Auditlog;

/**
 * 数据审核日志
 * @author huanghaoze
 *
 */
public class AuditlogAction extends BaseAction{
	AuditlogService auditlogservice;
	
	private List<Map<String,Object>> auditloglistmap;
	//查询条件
	private String begintime;
	private String endtime;
	private String orgid;		
	private String username;
	private String ip;
	private String tablename;
	private String operation;
	
	private Auditlog log ;//保存的参数
	
	public String saveauditlog(){
		try{
			auditlogservice = new AuditlogServiceImpl();
			auditlogservice.savelog(log);
			System.out.println("数据审计日志已保存");
		}catch(Exception ex){
			System.out.println("保存数据审计日志失败；"+ex);
		}
		return "json";
	}
	
	public String findauditlog(){
		auditlogservice = new AuditlogServiceImpl();
		Map<Object,Object> where=new HashMap();
		where.put("operation", operation);
		where.put("begintime", begintime);
		where.put("endtime", endtime);
		where.put("orgid", orgid);
		where.put("username", username);
		where.put("ip", ip);
		where.put("dataid",null);
		where.put("tablename", tablename);
		auditloglistmap = auditlogservice.findlogByMap(where);
		return "json";
	}

	public List<Map<String, Object>> getAuditloglistmap() {
		return auditloglistmap;
	}

	public void setAuditloglistmap(List<Map<String, Object>> auditloglistmap) {
		this.auditloglistmap = auditloglistmap;
	}

	public String getBegintime() {
		return begintime;
	}

	public void setBegintime(String begintime) {
		this.begintime = begintime;
	}

	public String getEndtime() {
		return endtime;
	}

	public void setEndtime(String endtime) {
		this.endtime = endtime;
	}

	public String getOrgid() {
		return orgid;
	}

	public void setOrgid(String orgid) {
		this.orgid = orgid;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

	public String getTablename() {
		return tablename;
	}

	public void setTablename(String tablename) {
		this.tablename = tablename;
	}

	public String getOperation() {
		return operation;
	}

	public void setOperation(String operation) {
		this.operation = operation;
	}

	public Auditlog getLog() {
		return log;
	}

	public void setLog(Auditlog log) {
		this.log = log;
	}
	
}
