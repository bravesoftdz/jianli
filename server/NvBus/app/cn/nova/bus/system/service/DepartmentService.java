package cn.nova.bus.system.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.system.model.Department;

public interface DepartmentService {

	boolean save(Department depart) throws ServiceException;
	
	boolean delete(Department depart);
	
	List<Map<String, Object>> query(long parentid);
	
	Department getById(Long id);

	boolean delete(Long id);
	
	List<Department> query();

	boolean qryUserByOrgId(Long departmentid, Long orgid);
	
}
