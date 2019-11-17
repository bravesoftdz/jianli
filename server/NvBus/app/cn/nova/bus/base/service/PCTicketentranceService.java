package cn.nova.bus.base.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.base.model.Pcticketentrance;
import cn.nova.bus.exception.ServiceException;
import cn.nova.utils.orm.PropertyFilter;

/**
 * 检票控制管理接口
 * @author huanghaoze
 *
 * 增加了检票口权限查询,add by lck
 */
public interface PCTicketentranceService {


	/**
	 * 添加或修改检检票控制信息
	 * @param ticketentrance
	 * @return boolean操作是否成功
	 * @throws ServiceException 
	 */
	public Boolean  savePcticketentrance(Pcticketentrance pcticketentrance,String ticketentranceids) throws ServiceException;
	

	/**
	 * 添加或修改检检票控制信息
	 * @param ticketentrance
	 * @return boolean操作是否成功
	 */
	public Boolean  updatePcticketentrance(Pcticketentrance pcticketentrance,String ticketentranceids);
	
	/**
	 * 根据ID删除工作站控制信息
	 * @param id
	 * @return boolean删除是否成功
	 */
	public Boolean delpcticketentrance(long id,String ip);
	
	
	/**
	 * 查找检票控制信息
	 * @param List<PropertyFilter> propertyFilterList
	 * @return  List<Map<String,Object>>
	 */
	public List<Pcticketentrance> findPCentrance(String ip,long orgid,long entranceid);

	/**
	 * 查找检票控制信息
	 * @param where
	 * @return  List<Map<String,Object>>
	 */
	public List<Map<String,Object>> findPCTicketentrance(List<PropertyFilter> propertyFilterList);
	
	/**
	 * 查找检票列表信息
	 * @param where
	 * @return  Map<Object,Object> where
	 */
	public List<Map<String,Object>> findPCEntranceName(List<PropertyFilter> propertyFilterList);

	/**
	 * 根据orgid 查找检票口列表信息
	 * @param where
	 * @return  Map<Object,Object> where
	 */
	List<Map<String, Object>> findTicketentrancename(
			List<PropertyFilter> propertyFilterList);

	//根据用户所在机构以及登录机器IP，查询该机器拥有的检票口
	public List<Map<String, Object>> qryTicketentrance(String ip,String orgids);
}
