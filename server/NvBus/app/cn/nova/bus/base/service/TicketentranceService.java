package cn.nova.bus.base.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.base.model.Ticketentrance;
import cn.nova.bus.exception.ServiceException;
import cn.nova.utils.orm.Page;
import cn.nova.utils.orm.PropertyFilter;
/**
 * 检票口设置
 * @author huanghaoze
 *
 */
public interface TicketentranceService {

	/**
	 * 添加或修改检票口设置信息
	 * @param ticketentrance
	 * @return boolean操作是否成功
	 * @throws ServiceException 
	 */
	public Ticketentrance  saveTicketentrance(Ticketentrance ticketentrance) throws ServiceException;
	
	/**
	 * 根据ID删除检票口信息
	 * @param id
	 * @return boolean删除是否成功
	 */
	public Boolean delTicketentrance(Ticketentrance ticketentrance)throws ServiceException;
	
	
	/**
	 * 根据ID删除检票口信息; 只是将激活状态修改为false
	 * @param id
	 * @return boolean删除是否成功
	 * @throws ServiceException 
	 */
	public Ticketentrance updTicketentrance(Ticketentrance ticketentrance) throws ServiceException;
	
	/**
	 * 根据id查找实体
	 * @param id
	 * @return
	 */
	public Ticketentrance findbyid(long id);
	
	/**
	 * 查找检票口信息
	 * @param where
	 * @return  List<Map<String,Object>>
	 */
	public List<Map<String,Object>> query(List<PropertyFilter> propertyFilterList);

	/**
	 * 分页查找检票口信息
	 * @param entrace
	 * @param map
	 * @return
	 */
	public Page<Ticketentrance> findPage(Page<Ticketentrance> entrace,Map<Object, Object> map);
		
}
