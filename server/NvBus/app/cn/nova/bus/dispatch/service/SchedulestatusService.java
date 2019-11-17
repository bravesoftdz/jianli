package cn.nova.bus.dispatch.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.price.model.Schedulestatus;
import cn.nova.bus.sale.model.Ticketsell;
import cn.nova.bus.security.Global;
import cn.nova.utils.commons.MethodResult;
import cn.nova.utils.orm.PropertyFilter;

public interface SchedulestatusService {

	public boolean save(Schedulestatus schedulestatus);

	public boolean delete(Schedulestatus schedulestatus);

	public boolean delete(Long id);

	public List<Schedulestatus> query();

	public Schedulestatus getById(Long id);

	public List<Map<String, Object>> query(
			List<PropertyFilter> propertyFilterList, long curstationid,
			Date fromdate, Date enddate, boolean isfullseat) throws ServiceException;

	public List<Schedulestatus> getSchedulestatus(Long scheduleplanid);

	// 得到该营运计划对应的票价信息
	public List<Map<String, Object>> queryTicketprice(
			List<PropertyFilter> buildFromHttpRequest);

	public boolean saveStarttime(Schedulestatus schedulestatus, Long day,
			String ip) throws ServiceException;

	public boolean updateIssaleafterreport(long scheduleplanid, Global global)
			throws ServiceException;

	public boolean updateTicketentrancepark(long departstationid,
			Date startdate, Date enddate, String scheduleids, String buspark,
			String ticketentrance, String ip, long updateby)
			throws ServiceException;

	// 获取自动释放座位时间
	public Date getAutoCanelSeatTime(long departstationid, long scheduleplanid)
			throws ServiceException;

	// 判断是否为配客班次
	public boolean isStowageSch(long scheduleplanid) throws ServiceException;

	public List<Map<String, Object>> qryTicketentrance(long departstationid,
			long scheduleid) throws ServiceException;
	
	public List<Map<String, Object>> qryVehiclepark(long departstationid,
			long scheduleid) throws ServiceException;
	
	public int updateScheduleStatus();

	public List<Map<String,Object>> qryscheduleplan(Date departdate, long scheduleid);

	public List<Map<String, Object>> checkticketstatus(Date departdate, String schedulecode);
	
	//综合调度-同步班次计划 
	public MethodResult syncScheduleplan(Long scheduleplanid);
}
