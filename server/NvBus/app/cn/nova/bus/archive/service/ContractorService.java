package cn.nova.bus.archive.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.archive.model.Contractor;
import cn.nova.bus.exception.ServiceException;
import cn.nova.utils.orm.PropertyFilter;

/**
 * 承包者档案管理
 * @author Administrator
 *
 */
public interface ContractorService {

	/**
	 * 添加或修改
	 * @param Employe
	 * @return boolean操作是否成功
	 */
	public Contractor  saveContractor(Contractor contractor) throws ServiceException;
	
	/**
	 * 根据ID删除
	 * @param id
	 * @return boolean删除是否成功
	 * @throws ServiceException 
	 */
	public Boolean delContractor(long id) ;
	
	
	/**
	 * 查找
	 * @param where
	 * @return  List<Map<String,Object>>
	 */
	public List<Map<String, Object>> queryContractor(List<PropertyFilter> propertyFilterList);
}
