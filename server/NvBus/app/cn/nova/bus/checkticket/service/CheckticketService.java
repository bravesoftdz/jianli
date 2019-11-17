package cn.nova.bus.checkticket.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.base.model.Schedule;
import cn.nova.bus.checkticket.model.Ledcontent;
import cn.nova.bus.checkticket.model.ScheduleStartCheck;
import cn.nova.bus.checkticket.socket.Message;
import cn.nova.bus.exception.BusinessException;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.price.model.Scheduleplan;
import cn.nova.bus.price.model.Schedulestatus;
import cn.nova.bus.sale.model.RemoteTicketsell;
import cn.nova.bus.sale.model.Ticketsell;
import cn.nova.bus.security.Global;
import cn.nova.utils.commons.MethodResult;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.web.ServletPropertyFilterUtil;

/**
 * @author lck
 * 
 */
public interface CheckticketService {
	// 检票界面查询班次列表信息
	public List<Map<String, Object>> qryScheduleplan(
			List<PropertyFilter> propertyFilterList, Date departdate,
			Long reportorgid,long departstationid);

	// 检票界面查询班次列表信息
	public List<Map<String, Object>> qryScheduleplanbyself(
			List<PropertyFilter> propertyFilterList, Date departdate,
			Long reportorgid,long departstationid,Global global);
	
	public Ticketsell checkticket(long checkstationid, long vehiclereportid,
			Ticketsell ticket, Global global, boolean islazycheck, String ip,
			String ticketentrance, boolean isauthcheck,String checktype) throws ServiceException ;
	
	// 实现按票号检票过程,islazycheck是否补检
	public Ticketsell checkByticketno(long checkstationid,
			long vehiclereportid, String ticketno, Global global,
			boolean islazycheck,String ip,String ticketentrance) throws ServiceException;
	
    //实现无票根检票	
	public int checkByticketid(long checkstationid,
			long vehiclereportid, String ticketids,Global global,
			String ip)throws ServiceException;
	
	// 实现按座位号(流水号)检票过程
	public Ticketsell checkBySeatno(long checkstationid, long vehiclereportid,
			long scheduleplanid, short seatno, Global global,
			boolean islazycheck,String ip,String ticketentrance) throws ServiceException;

	// 实现按票号连续检票过程
	public int checkByticketno(List<PropertyFilter> propertyFilterList,long checkstationid, long vehiclereportid,
			String startTicketno, String endTicketno, Global global,
			boolean islazycheck,String ip,String ticketentrance) throws ServiceException;
	
	//校验需检票的发车站是否在输入的发车站范围内
	public int verifyDepartstation(List<PropertyFilter> propertyFilterList,String ticketno,Date departdate) throws ServiceException;
	
	// 实现取消检票过程
	public Ticketsell cancelCheckticket(long checkstationid, String ticketno,
			 Global global,int iscancelold) throws Exception;

	
	// 实现按座位号(流水号)退检票过程
	public Ticketsell cancelCheckBySeatno(long checkstationid,
			long scheduleplanid, short seatno,Global global,int iscancelold) throws Exception;
	
	
	// 查询座位信息,显示已售信息以及座位状态信息
	public List<Map<String, Object>> qrySeatstatus(long scheduleplanid,long checkstationid);

	// 查询流水班次已报到车辆信息
	public List<Map<String, Object>> qryReportvehicle(long scheduleplanid,boolean isdeparted,long reportorgid,Date departdate);

	
	// 查询当前站所有该班次的报到车辆信息
	public List<Map<String, Object>> qryReportvehicle(long scheduleplanid,long reportorgid);

	// 查询已检\未检车票
	public List<Map<String, Object>> qryTicketsell(long scheduleplanid,
			boolean ischecked);

	// 查询车票
	public List<Map<String, Object>> qryTicket(Global global,String ticketno,String certificateno);

	// 按日期、班次、座位号查询票号
	public List<Map<String, Object>> qryTicket(long scheduleplanid, short seatno)
			throws ServiceException;

	// 实现混检
	/*
	 * vehiclereportid 可为0或者空，其他参数不允许为空
	 */

	public Ticketsell mixCheckticket(long checkstationid, long scheduleplanid,
			long vehiclereportid, long ticketid,Global global, short newseatno,String ticketentrance
			,boolean isauthcheck)
			throws ServiceException, Exception;

	// 实现全检
	public int checkAlltickets(List<PropertyFilter> propertyFilterList,long checkstationid, long scheduleplanid,
			long vehiclereportid, Global global, boolean islazycheck,String ip,String ticketentrance)
			throws ServiceException;

	// 查询报到车辆的检票数
	public long qryReportVechiletickets(long scheduleplanid,
			long vehiclereportid,Date departdate);

	// 查询未检票数
	public long qryUnCheckTickets(long scheduleplanid,Date departdate);
	
	// 查询报到车辆的检票数(一卡通刷卡上车人数)
	public long qryOneCardReportVechiletickets(long scheduleplanid,
			long vehiclereportid,Date departdate);

	// 查询已检的车票信息
	public List<Map<String, Object>> queryCheckedticket(
			List<PropertyFilter> propertyFilterList);

	// 查询混检车票信息
	public String queryMixInfo(long ticketid);

	//实现整车退检
	public boolean cancelAllCheckticket(List<PropertyFilter> propertyFilterList,long checkstationid,long scheduleplanid,long vehiclereportid,
			Global global) throws Exception;
	
	//实现特检
	public Ticketsell checkAuthBySeatno(long checkstationid, long vehiclereportid,
			long scheduleplanid, short seatno,Global global,
			boolean islazycheck,String ip,String ticketentrance) throws ServiceException; 
	
	//
	public void addMusicContent(Ledcontent lc)throws ServiceException; 

	// 实现按票号/身份证检票过程，改方法用于匝机检票
	public Message checkByticketno(Message msg) throws BusinessException;
	
	public boolean isMixTicket(Global global,long checkstationid,String ticketno) throws ServiceException;
	
	//是否是远程检票
	public boolean isRemoteTicketCheck(Global global, String ticketno);
	
	public long cancleRemoteTicketCheck(long checkstationid, Global global, String ticketno) throws Exception;
	
	/**
	 * 检票界面双击班次获取 到站和票数信息
	 * @param scheduleplanid
	 * @param ischecked
	 * @return
	 */
	public List<Map<String, Object>> sumTickets(Long scheduleplanid );
	
	//刷卡开检
	public String[] setScheduleStatus(String cardno,Date departdate);


	public String checkticketno(String ticketno,String certificateno,Global global);

	//座位信息
	public List<Map<String, Object>> qrySeatstatusdetail(List<PropertyFilter> propertyFilterList);

	public boolean seatnums(long scheduleplanid);

	//根据身份证查询车票信息
	public List<Map<String, Object>> qryTicketinfoByIDcard(
			List<PropertyFilter> propertyFilterList);

	public boolean saveseller(long sellerid, long departinvoicesid) throws Exception;

	public Schedulestatus changeticketstatus(long scheduleplanid,long departstationid,boolean isbegincheck) throws Exception;
	
	public void savechecklog(Ticketsell ts,String checktype,String operationtype,Global global);

	public List<Map<String, Object>> qryReportdriver(
			List<PropertyFilter> buildFromHttpRequest, long orgid);

	public void schedulestartcheck(ScheduleStartCheck schedulestartcheck,long userinfo,long orgid)throws Exception;

	public boolean queryschedulestartcheck(
			ScheduleStartCheck schedulestartcheck,long orgids);

	public MethodResult mixCheckTuanTicket(Long checkstationid, long scheduleplanid, long vehiclereportid,
			Global global, short newseatno, String ticketentrance, boolean b, Ticketsell ticketsell) throws Exception;

	public Scheduleplan getScheduleplan(long scheduleplanid);

	public Schedule getSchedule(Ticketsell ticket);
	
	/**
	 * 根据ServiceException的code 返回对应检票的flag 用于语音播报
	 * @param code
	 *  @return -1 不提示语音信息 </br>
	 * 		   -2 该票号不存在</br>
	 * 		   -3 该票号的班次与当前班次不一致</br>
	 * 		   -4 该票已检</br>
	 * 		   -5 未报班</br>
	 *         -6 未到发车时间</br>
	 *         -7 已过发车时间</br>
	 */
	public Long switchException(String code);
	
	public long qryIssamerep(long vehiclereportid,
			String ticketno,long checkstationid,Date departdate)throws ServiceException;
	public boolean checkisschedule(long vehiclereportid, String ticketno, Date departdate);

	public Ticketsell createNewTicketSell(long id, Global global)throws  Exception ;

	public String addTicketMixChange(long ticketsellid, Ticketsell ticket);
	
	//查询车票是否为混检退票
	public String isMixChange(String ticketno);
	
	public String qryEstationsellticket(String encryptionticketno, Global global);
}
