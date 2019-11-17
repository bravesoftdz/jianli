package cn.nova.bus.base.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.base.model.Pcsellschedule;
import cn.nova.bus.exception.ServiceException;
import cn.nova.utils.orm.PropertyFilter;

/**
 * 工作站控制
 * @author hhz
 *
 */
public interface PCSellscheduleService {
	
	/**
	 * 添加\修改检售票控制信息
	 * @param ticketentrance
	 * @return boolean操作是否成功
	 */
	public Boolean  savePcsellschedule(Pcsellschedule pcsellschedule,String typeid) throws ServiceException;
	

	/**
	 * 根据ID删除售票控制信息
	 * @param id
	 * @return boolean删除是否成功
	 */
	public Boolean delpcsellschedule(long id);
	
	/**
	 * 修改售票控制信息
	 * @param 
	 * @return 
	 */
	public boolean updatePcsellschedule(Pcsellschedule pcsellschedule,
			String typeids) throws ServiceException;

	/**
	 * 根据机构ID,ip , 可售类型，删除售票控制信息
	 * @param id
	 * @return boolean删除是否成功
	 */
	public Boolean delschedule(Pcsellschedule pcsellschedule);
	
	
	/**
	 * 查找售票控制信息
	 * @param where
	 * @return  List<Map<String,Object>>
	 */
	public  List<Pcsellschedule>  findEntyby(Map<String,Object> where);

	/**
	 * 查找工作站控制信息
	 * @param where
	 * @return  Map<Object,Object> where
	 */
	public List<Map<String,Object>> findsellschedule(List<PropertyFilter> propertyFilterList);
	

	/**
	 * 查找线路名，或班次名
	 * @param where
	 * @return  Map<Object,Object> where
	 */
	public List<Map<String,Object>> findschedulesname(Pcsellschedule pcsellschedule);

	/**
	 * 查找指定机构的线路或者班次
	 * @param orgid
	 * @param type
	 * @return
	 */
	List<Map<String, Object>> findscheduleOrRoute(Pcsellschedule pcsellschedule,long routeid,Boolean isupdate);

}
