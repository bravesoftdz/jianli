package cn.nova.bus.log.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.log.model.Operationlog;
import cn.nova.utils.orm.PropertyFilter;



public interface OperationLogService {
	
	/**
	 * 保存操作日志
	 * @param Auditlog log
	 * @return 保存是否成功
	 */
	public boolean savelog(Operationlog operationLog);
	

	public List<Map<String, Object>> query(List<PropertyFilter> propertyFilterList);

}
