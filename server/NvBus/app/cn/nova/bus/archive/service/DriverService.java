package cn.nova.bus.archive.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.archive.model.Driver;
import cn.nova.bus.archive.model.Driverfamilymember;
import cn.nova.bus.archive.model.Driverworkexperience;
import cn.nova.bus.dispatch.model.FingerCache;
import cn.nova.bus.exception.ServiceException;
import cn.nova.utils.orm.Page;
import cn.nova.utils.orm.PropertyFilter;

/**
 * 驾驶员档案管理
 * @author Administrator
 *
 */
public interface DriverService {

	/**
	 * 添加或修改驾驶员档案
	 * @param Driver
	 * @return boolean操作是否成功
	 * @throws ServiceException 
	 */
	public Driver  saveDriver(Driver driver) throws ServiceException;
	
	/**
	 * 根据ID删除驾驶员档案，真正删除记录
	 * @param id
	 * @return boolean删除是否成功
	 * @throws ServiceException 
	 */
	public Boolean delDriver(long id) throws ServiceException;
	
	
	/**
	 * 查找驾驶员档案
	 * @param where
	 * @return  List<Map<String,Object>>
	 */
	public List<Map<String, Object>> queryDriver(List<PropertyFilter> propertyFilterList,String isfinger);

	
	public List<Map<String, Object>> queryDriverFinger();

	public boolean  saveDriverFinger(Driver driver) throws ServiceException;
	/**
	 * 分页查找驾驶员档案
	 * @param entrace
	 * @param map
	 * @return
	 */
	public Page<Driver> findPage(Page<Driver> entrace,Map<Object, Object> map);
	
	/**
	 * 根据驾驶员查询对应的车牌号
	 * @param where
	 * @return  List<Map<String,Object>>
	 */
	public List<Map<String, Object>> queryVehicleByDriverid(long driverid);

	/**
	 * 保存报班的驾驶员或乘务员，并返回车辆信息
	 * @param where
	 * @return  List<Map<String,Object>>
	 */
	public List<Map<String, Object>> saveFingeCache(long driverid);
	
	public List<Map<String, Object>> findFingecache(long vehicleid,Date savedate);
	
	public Driver findbyid(Long id);
	

	/**
	 * 添加或修改驾驶员家庭成员
	 * @param Driver
	 * @return boolean操作是否成功
	 */
	public Driverfamilymember  saveDriverfamilymember(Driverfamilymember driverfamil);
	
	/**
	 * 根据成员ID删除驾驶员家庭成员，真正删除记录
	 * @param id
	 * @return boolean删除是否成功
	 */
	public Boolean delDriverfamilymember(long id);
	
	/**
	 * 表面删除，实则将激活状态修改为false
	 * @param id
	 * @return boolean删除是否成功
	 */
	public Boolean delDriverFamily(Driverfamilymember driverfamily);
	
	/**
	 * 查找驾驶员家庭成员
	 * @param where
	 * @return  List<Map<String,Object>>
	 */
	public List<Map<String, Object>> queryFamily(List<PropertyFilter> propertyFilterList);

	/**
	 * 分页查找驾驶员
	 * @param entrace
	 * @param map
	 * @return
	 */
	public Page<Driverfamilymember> findFamliyPage(Page<Driverfamilymember> entrace,Map<Object, Object> map);

	public Driverfamilymember findFamliyByid(Long id);
	
	
	/**
	 * 添加或修改驾驶员工作经历
	 * @param Driver
	 * @return boolean操作是否成功
	 */
	public Driverworkexperience  saveDriverworkexperience(Driverworkexperience driverworkexperience);
	
	/**
	 * 根据成员ID删除驾驶员工作经历，真正删除记录
	 * @param id
	 * @return boolean删除是否成功
	 */
	public Boolean delDriverworkexperience(long id);
	
	/**
	 * 表面删除，实则将激活状态修改为false
	 * @param id
	 * @return boolean删除是否成功
	 */
	public Boolean updDriverworkexperience(Driverworkexperience driverworkexperience);
	
	/**
	 * 查找驾驶员工作经历
	 * @param where
	 * @return  List<Map<String,Object>>
	 */
	public List<Map<String, Object>> queryWork(List<PropertyFilter> propertyFilterList);

	/**
	 * 分页查找工作经历
	 * @param entrace
	 * @param map
	 * @return
	 */
	public Page<Driverworkexperience> findWorkPage(Page<Driverworkexperience> entrace,Map<Object, Object> map);

	/**
	 * 根据工作经历id查找一条记录
	 * @param id
	 * @return
	 */
	public Driverworkexperience findWorkBid(Long id);
	

	public List<Map<String, Object>> findPicturebyId(List<PropertyFilter> propertyFilterList);
	//查询驾驶员信息
	public List<Driver> getDriverInfo();

	public List<Map<String, Object>> queryDriverByDriverid(long driverid);
	
	public List<Map<String, Object>> queryVehiclenoByDriverid(long driverid);

	public List<Map<String, Object>> queryDriverAndStewardFinger();
	
	public List<Map<String, Object>> queryDriverCardno(String drivinglicense);
	
}
