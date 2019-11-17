package cn.nova.bus.base.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.base.model.SetDriverVehicle;
import cn.nova.bus.exception.ServiceException;
import cn.nova.utils.orm.PropertyFilter;

public interface SetDriverVehicleService {
	/**
	 * 查找
	 * @param where
	 * @return  List<Map<String,Object>>
	 */
	public List<Map<String, Object>> querySetDriverVehicle(List<PropertyFilter> propertyFilterList);
	/**
	 * 根据ID删除
	 * @param id
	 * @return boolean删除是否成功
	 * @throws ServiceException 
	 */
	public Boolean delSetDriverVehicle(long id) ;
	/**
	 * 添加
	 * @param setDriverVehicle
	 * @return
	 * @throws ServiceException
	 * @throws Exception
	 */
	public SetDriverVehicle  saveSetDriverVehicle(SetDriverVehicle setDriverVehicle) throws ServiceException, Exception;
	/**
	 * 修改
	 * @param setDriverVehicle
	 * @return
	 * @throws ServiceException
	 * @throws Exception
	 */
	public String modifySetDriverVehicle(SetDriverVehicle setDriverVehicle) throws ServiceException, Exception;
	/**
	 * 查询本地机构
	 * @param orgids
	 * @return
	 */
	public List<Map<String, Object>> queryCurOrg(String orgids);
	/**
	 * 由驾驶员联动显示未关联的车牌
	 * @param orgid
	 * @param driverid
	 * @return
	 */
	public List<Map<String, Object>> queryvehicleno(String orgid,String driverid);
}
