package cn.nova.bus.base.service;

import java.sql.SQLIntegrityConstraintViolationException;
import java.util.List;
import java.util.Map;

import cn.nova.bus.base.model.Vehiclepark;
import cn.nova.bus.exception.ServiceException;
import cn.nova.utils.orm.Page;
import cn.nova.utils.orm.PropertyFilter;
/**
 *上车卡位设置
 * @author huanghaoze
 *
 */
public interface VehicleparkService {
	
	
	/**
	 * 添加或修改上车卡位设置信息
	 * @param Vehiclepark
	 * @return boolean操作是否成功
	 * @throws ServiceException 
	 * @throws SQLIntegrityConstraintViolationException 
	 */
	public Boolean  saveVehiclepark(Vehiclepark vehiclepark,String oldname) throws ServiceException;
	
	/**
	 * 根据ID删除上车卡位信息
	 * @param id
	 * @return boolean删除是否成功
	 */
	public Boolean delVehiclepark(long id);
	
	/**
	 * 表面删除，实则将激活状态修改为false
	 * @param id
	 * @return boolean删除是否成功
	 * @throws ServiceException 
	 */
	public Boolean delVehiclepark(Vehiclepark vehiclepark) throws ServiceException;
	
	/**
	 * 查找上车卡位信息
	 * @param where
	 * @return  List<Map<String,Object>>
	 */
	public List<Map<String, Object>> query(List<PropertyFilter> propertyFilterList);

	/**
	 * 分页查找上车卡位信息
	 * @param entrace
	 * @param map
	 * @return
	 */
	public Page<Vehiclepark> findPage(Page<Vehiclepark> entrace,Map<Object, Object> map);

	public Vehiclepark findbyid(Long id);
	
	
}
