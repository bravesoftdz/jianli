package cn.nova.bus.archive.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.archive.model.Driverrewardpenalize;
import cn.nova.bus.archive.model.Stewardrewardpenalize;
import cn.nova.utils.orm.Page;
import cn.nova.utils.orm.PropertyFilter;

/**
 * 驾驶员奖励处罚记录
 * @author huanghaoze
 *
 */
public interface RewardpenalizeService {
	
	/**
	 * 添加或修改驾驶员奖励处罚记录
	 * @param Driver
	 * @return boolean操作是否成功
	 */
	public Driverrewardpenalize  saveDriverrewardpenalize(Driverrewardpenalize driverrewardpenalize);
	
	/**
	 * 根据成员ID删除驾驶员奖惩记录，真正删除记录
	 * @param id
	 * @return boolean删除是否成功
	 */
	public Boolean delDriverrewardpenalize(long id);
	
	/**
	 * 表面删除，实则将激活状态修改为false
	 * @param id
	 * @return boolean删除是否成功
	 */
	public Boolean updDriverrewardpenalize(Driverrewardpenalize driverrewardpenalize);
	
	/**
	 * 查找驾驶员奖励处罚记录
	 * @param where
	 * @return  List<Map<String,Object>>
	 */
	public List<Map<String, Object>> queryDriverrewardpenalize(List<PropertyFilter> propertyFilterList);



	/**
	 * 添加或修改乘务员奖励处罚记录
	 * @param Driver
	 * @return boolean操作是否成功
	 */
	public Stewardrewardpenalize  saveStewardrewardpenalize(Stewardrewardpenalize stewardrewardpenalize);
	
	/**
	 * 根据成员ID删除乘务员奖惩记录，真正删除记录
	 * @param id
	 * @return boolean删除是否成功
	 */
	public Boolean delStewardrewardpenalize(long id);
	
	/**
	 * 表面删除，实则将激活状态修改为false
	 * @param id
	 * @return boolean删除是否成功
	 */
	public Boolean updStewardrewardpenalize(Stewardrewardpenalize stewardrewardpenalize);
	
	/**
	 * 查找乘务员奖励处罚记录
	 * @param where
	 * @return  List<Map<String,Object>>
	 */
	public List<Map<String, Object>> queryStewardrewardpenalize(List<PropertyFilter> propertyFilterList);

	/**
	 * 分页查找乘务员奖励处罚记录
	 * @param entrace
	 * @param map
	 * @return
	 */
	public Page<Stewardrewardpenalize> findPage(Page<Stewardrewardpenalize> entrace,Map<Object, Object> map);

	/**
	 * 根据奖惩记录id查找一条记录
	 * @param id
	 * @return
	 */
	public Stewardrewardpenalize findbyid(Long id);
}
