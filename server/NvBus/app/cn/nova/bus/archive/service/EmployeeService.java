package cn.nova.bus.archive.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.archive.model.Employee;
import cn.nova.bus.exception.ServiceException;
import cn.nova.utils.orm.PropertyFilter;

/**
 * 员工档案管理
 * @author Administrator
 *
 */
public interface EmployeeService {
	
	/**
	 * 添加或修改
	 * @param Employe
	 * @return boolean操作是否成功
	 * @throws ServiceException 
	 */
	public  Employee  saveEmployee(Employee employee) throws ServiceException;
	
	/**
	 * 根据ID删除
	 * @param id
	 * @return boolean删除是否成功
	 * @throws ServiceException 
	 */
	public Boolean delEmployee(long id);
	
	/**
	 * 查找
	 * @param where
	 * @return  List<Map<String,Object>>
	 */
	public List<Map<String, Object>> queryEmployee(List<PropertyFilter> propertyFilterList);

	public List<Map<String, Object>> findPicturebyId(List<PropertyFilter> propertyFilterList);
}
