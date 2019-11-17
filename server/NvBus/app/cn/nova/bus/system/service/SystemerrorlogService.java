/**
 * 
 */
package cn.nova.bus.system.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.system.model.Systemerrorlog;

/**
 * 系统日志管理接口
 * @author huanghaoze
 *
 */
public interface SystemerrorlogService {
	
	public boolean savelog(Systemerrorlog log);
	
	public Boolean deleteById(Long logid);
	
	public List<Systemerrorlog> findByLog(Systemerrorlog log);
	
	public List<Map<String, Object>> findlogByMap(Map<Object,Object> map);
	
}
