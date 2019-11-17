package cn.nova.bus.base.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.base.model.Scheduleselltickettype;
import cn.nova.bus.exception.ServiceException;
import cn.nova.utils.orm.PropertyFilter;

/**
 * <b>类描述：班线可售票种设置</b><br/>
 * <b>类名称：</b>ScheduleselltickettypeService.java<br/>
 * <b>创建人：</b><a href="mailto:huanghaoze@nova.net.cn">hhz</a><br/>
 * <b>创建时间：</b><br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
public interface ScheduleselltickettypeService {

	public List<Map<String,Object>> findselltickettype(List<PropertyFilter> propertyFilterList) ;	

	public Scheduleselltickettype updateScheduleselltickettype(Scheduleselltickettype scheduleselltickettype,
			String typeids,String tickettypes);
	
	public Scheduleselltickettype saveScheduleselltickettype(Scheduleselltickettype scheduleselltickettype,
			String typeids,String tickettypes)  throws ServiceException ;
	
	public boolean delscheduleselltickettype(long id);
	
	public List<Map<String, Object>> findscheduleOrRoute(long orgid,String type,boolean isupdate,long id,long routeid);
	
	/**
	 * 查询班次的可售票种
	 * @param scheduleid
	 * @return
	 */
	public List<Map<String,Object>> findCanSaleTicketType(long scheduleid);
}
