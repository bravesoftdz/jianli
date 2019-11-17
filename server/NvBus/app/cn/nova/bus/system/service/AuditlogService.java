/**
 * 
 */
package cn.nova.bus.system.service;

import java.util.List;
import java.util.Map;

import cn.nova.utils.orm.listener.Auditlog;


/**
 * 系统审计日志管理接口
 * @author huanghaoze
 *
 */
public interface AuditlogService {
	/**
	 * 保存数据审核日志
	 * @param Auditlog log
	 * @return 保存是否成功
	 */
	public boolean savelog(Auditlog log);
	
	/**
	 * 查找审计日志	
	 * @param  Map<Object,Object> map
	 * @return List<Map<String, Object>>
	 */
	public List<Map<String, Object>> findlogByMap(Map<Object,Object> map);

}
