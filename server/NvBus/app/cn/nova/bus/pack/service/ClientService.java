package cn.nova.bus.pack.service;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.pack.model.Client;
import cn.nova.utils.orm.PropertyFilter;

public interface ClientService {

	/**
	 * 添加或修改
	 * @param Employe
	 * @return boolean操作是否成功
	 * @throws ServiceException 
	 */
	public  Client  saveClient(Client Client) throws ServiceException ;
	
	/**
	 * 根据ID删除
	 * @param id
	 * @return boolean删除是否成功
	 * @throws ServiceException 
	 */
	public Boolean delClient(long id);
	
	/**
	 * 查找
	 * @param where
	 * @return  List<Map<String,Object>>
	 */
	public List<Map<String, Object>> queryClient(List<PropertyFilter> propertyFilterList);
	
	/**
	 * 更新积分信息
	 * @param id    客户id
	 * @param integrater   修改积分
	 * @return
	 * @throws ServiceException
	 */
	public  Boolean  updateClientIntegrater(long id,long integrater) throws ServiceException ;
	
	/**
	 *  更新积分信息
	 * @param id  客户id
	 * @param price   支付金额
	 * @return
	 * @throws ServiceException
	 */
	public Boolean updateClientIntegrater(long id, BigDecimal price)throws ServiceException ;

}
