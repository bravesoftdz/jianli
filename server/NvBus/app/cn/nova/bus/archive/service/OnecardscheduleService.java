package cn.nova.bus.archive.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.archive.model.Onecardschedule;
import cn.nova.bus.exception.ServiceException;
import cn.nova.utils.orm.PropertyFilter;

public interface OnecardscheduleService {

	/**
	 * <b>类描述：</b>班次预售天数控制<br/>
	 * <b>类名称：</b>ScheduleperselldaysService.java<br/>
	 * <b>创建人：</b><a href="mailto:huanghaoze@nova.net.cn">hhz</a><br/>
	 * <b>创建时间：</b>2012-9-12 6<br/>
	 * <b>关键修改：</b><br/>
	 * <b>修改时间：</b><br/>
	 * <b>修改人：</b><br/>
	 */
public List<Map<String,Object>> findOnecardschedule(
		List<PropertyFilter> propertyFilterList,Date startdate,Date enddate) ;
	
	/**
	 * 添加班次预售天数
	 * @param scheduleperselldays
	 * @param typeids
	 * @return
	 * @throws ServiceException
	 */
	public Onecardschedule saveOnecardschedule(Onecardschedule onecardschedule,
			String typeids)  throws ServiceException ;
	/**
	 * 修改班次预售天数
	 * @param scheduleperselldays
	 * @param typeids
	 * @return
	 */
	public Onecardschedule updateOnecardschedule(Onecardschedule onecardschedule,
			String typeids) throws ServiceException ;
	
	/**
	 * 根据ID 删除
	 * @param id
	 * @return
	 */
	public boolean delschedule(long id);	

	/**
	 * 显示班次或者线路明细
	 * @param orgid
	 * @param type
	 * @param isupdate
	 * @param id
	 * @param routeid
	 * @return
	 */
	public List<Map<String, Object>> findscheduleOrRoute(long orgid,String type,boolean isupdate,long id,long routeid);
	


}
