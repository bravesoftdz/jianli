package cn.nova.bus.archive.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.archive.model.Customer;
import cn.nova.bus.archive.model.CustomerCache;
import cn.nova.bus.exception.ServiceException;
import cn.nova.utils.commons.MethodResult;
import cn.nova.utils.orm.PropertyFilter;

public interface CustomerService {

	/**
	 * 添加或修改
	 * @param Employe
	 * @return boolean操作是否成功
	 * @throws ServiceException 
	 */
	public  Customer  saveCustomer(Customer Customer) throws ServiceException ;
	
	/**
	 * 根据ID删除
	 * @param id
	 * @return boolean删除是否成功
	 * @throws ServiceException 
	 */
	public Boolean delCustomer(long id);
	
	/**
	 * 查找
	 * @param where
	 * @return  List<Map<String,Object>>
	 */
	public List<Map<String, Object>> queryCustomer(List<PropertyFilter> propertyFilterList,String showfullidno);
	
	public List<Map<String, Object>> queryDefaultCustomer(List<PropertyFilter> propertyFilterList);
	
	public List<Map<String, Object>> queryBuyTickets(List<PropertyFilter> propertyFilterList);


	public boolean canBeSave(Customer customer);

	public boolean saveCustomerlist(List<Customer> customerlist) throws ServiceException ;

	public Customer fineById(Long id);

	public MethodResult savecustomerlistfromexcel(String c_info, String inputtype);

	public List<Map<String, Object>> queryIdentityCard(Integer icSize,
			String computercode) throws Exception;
	
	/**
	 * 更新customer表中的冗余字段
	 */
	public void updateCustomer();

	
}
