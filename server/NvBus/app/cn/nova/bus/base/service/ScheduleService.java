package cn.nova.bus.base.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.base.model.Schedule;
import cn.nova.bus.base.model.Schedulelongstop;
import cn.nova.bus.base.model.Schedulestop;
import cn.nova.bus.base.vo.SchedulestopVo;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.system.model.Digitaldictionarydetail;
import cn.nova.utils.orm.PropertyFilter;

/**
 * 
 * <p>
 * Title: 班次信息服务接口
 * </p>
 * <p>
 * Description:
 * </p>
 * <p>
 * Copyright: Copyright (c) 2011
 * </p>
 * <p>
 * Company: nova
 * </p>
 * 
 * @author lanckun
 * @version 0.1
 */
public interface ScheduleService {
	public List<Map<String,Object>> query(List<PropertyFilter> propertyFilterList,String schedulestatus);
	public List<Map<String,Object>> querySchedule(List<PropertyFilter> propertyFilterList,String schedulestatus);
	public Schedule save(Schedule schedule) throws ServiceException;
	public boolean delSchedule(long id,long userid) throws ServiceException;
	
	public List<Map<String,Object>> qryScheduleStop(long scheduleid) throws ServiceException;	
	public Schedulestop saveScheduleStop(Schedulestop schedulestop) throws ServiceException;
	
	public List<Map<String, Object>> qryRouteStop(Schedule schedule) ;	
	public boolean delScheduleStop(long id,long userid) throws ServiceException;
	public List<Map<String, Object>> createDistrictTree() ;
	
	public List<Map<String,Object>> qrySchedulelongstop(Schedule schedule) throws ServiceException;
	public Schedulelongstop saveScheduleLong(Schedulelongstop schedulelongstop) throws ServiceException;
	public Schedulelongstop saveScheduleLong(Schedulelongstop schedulelongstop,Digitaldictionarydetail digitaldictionarydetail) throws ServiceException;
	public boolean delSchedulelongstop(Schedulelongstop schedulelongstop) throws ServiceException;
	
	/**
	 * 根据班次代码和发车机构ID获取班次（只要是该班次停靠传入机构所在的站点，即返回）：<br/>
	 * @param code 班次代码
	 * @param orgid 发车站机构ID
	 * @return 
	 */
	public Schedule getScheduleByCode(String code,Long orgid,Date departdate); 

	/**
	 * 查询班次停靠点
	 * @param scheduleid
	 * @param stationid
	 * @return
	 */
	public List<Map<String, Object>> qryScheduleStop(long scheduleid,long stationid);
	
	
	/**
	 * 批量修改班次信息需要的停靠点
	 * @param scheduleid
	 * @return
	 */
	public List<Map<String, Object>> qryScheduleStopTwo(long scheduleid) throws ServiceException;
	
	/**批量修改班次信息
	 * @param schedule
	 * @param scheduleids
	 * @param stationids
	 * @param stationlist
	 * @return
	 */
	public boolean updateScheduleAll(Schedule schedule,String scheduleids,String stationids,
			List<SchedulestopVo> stationlist ) throws ServiceException; 
	
	public List<Map<String, Object>> findrouteid(long scheduleid);
	
	
	/**
	 * 加班班次保存班次信息，可以重复code
	 * @param schedule
	 * @return
	 * @throws ServiceException
	 */
	public Schedule AddSchedulesave(Schedule schedule,Date startdate, Date enddate,long mbscheduleid) throws ServiceException;

	public List<Map<String, Object>> selfcheckSchedule(Date departdate, long departstationid,long vehicleid,long reportorgid);
}
