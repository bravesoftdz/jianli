package cn.nova.bus.archive.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.archive.model.Driverworkexperience;
import cn.nova.bus.archive.model.Steward;
import cn.nova.bus.archive.model.Stewardworkexperience;
import cn.nova.bus.exception.ServiceException;
import cn.nova.utils.orm.Page;
import cn.nova.utils.orm.PropertyFilter;

/**
 * 乘务员档案管理
 * @author Administrator
 *
 */
public interface StewardService {

	/**
	 * 添加或修改乘务员档案
	 * @param Driver
	 * @return boolean操作是否成功
	 * @throws ServiceException 
	 */
	public Steward  saveSteward(Steward steward) throws ServiceException;
	
	/**
	 * 根据ID删除乘务员档案，真正删除记录
	 * @param id
	 * @return boolean删除是否成功
	 * @throws ServiceException 
	 */
	public Boolean delSteward(long id) throws ServiceException;
	
	/**
	 * 表面删除，实则将激活状态修改为false
	 * @param id
	 * @return boolean修改是否成功
	 */
	public Boolean delSteward(Steward steward);
	
	/**
	 * 查找乘务员档案
	 * @param where
	 * @return  List<Map<String,Object>>
	 */
	public List<Map<String, Object>> querySteward(List<PropertyFilter> propertyFilterList,String isfinger);

	/**
	 * 分页查找乘务员档案
	 * @param entrace
	 * @param map
	 * @return
	 */
	public Page<Steward> findPage(Page<Steward> entrace,Map<Object, Object> map);

	public Steward findbyid(Long id);
	
	
	public List<Map<String, Object>> queryStewardFinger();

	public boolean  saveStewardFinger(Steward steward) throws ServiceException;
	
	
	/**
	 * 添加或修改驾驶员工作经历
	 * @param Driver
	 * @return boolean操作是否成功
	 */
	public Stewardworkexperience  saveworkexperience(Stewardworkexperience workexperience);
	
	/**
	 * 根据成员ID删除驾驶员工作经历，真正删除记录
	 * @param id
	 * @return boolean删除是否成功
	 */
	public Boolean delworkexperience(long id);
	
	/**
	 * 表面删除，实则将激活状态修改为false
	 * @param id
	 * @return boolean删除是否成功
	 */
	public Boolean updworkexperience(Stewardworkexperience workexperience);
	
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
	public Page<Stewardworkexperience> findWorkPage(Page<Driverworkexperience> entrace,Map<Object, Object> map);

	/**
	 * 根据工作经历id查找一条记录
	 * @param id
	 * @return
	 */
	public Driverworkexperience findWorkBid(Long id);


	public List<Map<String, Object>> findPicturebyId(List<PropertyFilter> propertyFilterList);

	public List<Map<String, Object>> findStewardBystewardid(long stewardid);
}
