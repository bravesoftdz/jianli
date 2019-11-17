package cn.nova.bus.dispatch.service;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.Map;

import util.NvException;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.price.model.Schedulestatus;
import cn.nova.bus.price.model.Ticketprice;
import cn.nova.bus.security.Global;

public interface SchPlanService {
	// 查询票价信息
	public List<Map<String, Object>> qryTicketprice(long scheduleplanid);

	// 保存票价、停靠站可售信息
	public boolean batchsaveticketprice(String scheduleids,boolean iscopytostation,
			List<Ticketprice> ticketpricelist, Date fromdate, Date enddate,
			long updateby, String ipAddress) throws ServiceException;

	/**
	 * @param resultInfo：修改营运类别返回信息
	 */
	// 修改班次营运计划
	public boolean updateScheduleplan(Date startdate, Date enddate,
			Schedulestatus ss, String scheduleids, String ip,String workways,
			String remark,String worktype,boolean isworkline, String childnum, StringBuffer resultInfo)
			throws ServiceException, NvException;

	// 查询同线路的班次信息
	public List<Map<String, Object>> qrySameRouteSch(Date departdate,
			long routeid, long departstationid,long scheduleplanid);

	// 添加停靠点票价
	public boolean addStationprice(long scheduleplanid,
			String departstationids, long reachstationid, BigDecimal fullprice,
			BigDecimal halfprice, BigDecimal studentprice,
			BigDecimal moreprice, BigDecimal topprice,int distance, Global global, BigDecimal discountprice, BigDecimal roundprice, BigDecimal connectprice)
			throws ServiceException;

	// 查询站点票价
	public List<Map<String, Object>> qryStationprice(long departstationid,
			long reachstationid) throws ServiceException;

	//
	// 查询配客站点的发车时间
	public List<Map<String, Object>> qryDepartTime(long scheduleplanid,
			long departstationid,Date departdate) throws ServiceException;
	
	// 保存票价、停靠站可售信息
	public boolean saveDepartTimes(Date fromdate,Date enddate, long departstationid,
			List<Schedulestatus> sslist,Global global ) throws ServiceException;

	public List<Map<String, Object>> qryChildNum(long scheduleplanid);
}
