package cn.nova.bus.archive.service.impl;

import java.util.List;
import java.util.Map;

import cn.nova.bus.archive.dao.EmployeeDao;
import cn.nova.bus.archive.model.Employee;
import cn.nova.bus.archive.service.EmployeeService;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.exception.ServiceException;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.IDAO;
import cn.nova.utils.orm.jpa.ListUtil;



public class EmployeeServiceImpl implements EmployeeService {

	
	private IDAO<Employee> dao = new EntityManagerDaoSurport<Employee>();
	
	private EmployeeDao employeedao = new EmployeeDao();
	@Override
	public Employee saveEmployee(Employee employee) throws ServiceException {
		
		if(employee.getId() != 0){
			if(employeedao.isExistEmployee(null,employee.getCode(),employee.getOrgid())!=0&&
					employeedao.isExistEmployee(null,employee.getCode(),employee.getOrgid())!=employee.getId() ){
				throw new ServiceException("0115");	
			}
			if(employeedao.isExistEmployee(employee.getIdcard(),null,0)!=0&&
					employeedao.isExistEmployee(employee.getIdcard(),null,0)!=employee.getId() ){
				throw new ServiceException("0113");	
			}			
			return dao.merge(employee);
		}else{
			if(employeedao.isExistEmployee(null,employee.getCode(),employee.getOrgid())!=0){
				throw new ServiceException("0115");		
			}
			if(employeedao.isExistEmployee(employee.getIdcard(),null,0)!=0){
				throw new ServiceException("0113");					
			}
			return dao.merge(employee);
		}
	}

	@Override
	public Boolean delEmployee(long id){
		return employeedao.updateByid(id);
	}

	@Override
	public List<Map<String, Object>> queryEmployee(
			List<PropertyFilter> propertyFilterList) {
		Object[] fileds = { Employee.class,"orgname","createname","updatename"};// 初始化要查询的字段
		Object[] filedtypes = { Employee.class,String.class,String.class,String.class};// 初始化要查询的字段 类型
	return ListUtil.listToMap(fileds, employeedao.queryEmployee(propertyFilterList),filedtypes);
	
	}


	public List<Map<String, Object>> findPicturebyId(List<PropertyFilter> propertyFilterList){
		Object[] fileds = {"id","picture"};
		Object[] filedtypes = {Long.class,String.class};
		return ListUtil.listToMap(fileds, employeedao.findPicturebyId(propertyFilterList),filedtypes);		
	}

}
