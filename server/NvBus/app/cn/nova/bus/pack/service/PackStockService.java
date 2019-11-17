package cn.nova.bus.pack.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.pack.model.Pack;
import cn.nova.bus.pack.model.Packpickup;
import cn.nova.bus.pack.vo.PackStockVO;
import cn.nova.bus.security.Global;
import cn.nova.utils.orm.PropertyFilter;

public interface PackStockService {

	/**
	 * //签发查询班次
	 * 
	 * @param propertyFilters
	 * @return
	 */
	public List<Map<String, Object>> queryschedule(
			List<PropertyFilter> propertyFilters,Date departdate);

	public PackStockVO querystockscheduleBy(Global global,
			String departinvoicesno,String isbukai,String isreprint,List<Map<String, Object>> result,List<PropertyFilter> propertyFilters)
			throws ServiceException;
	/**
	 * 签发班次
	 * @param packids
	 * @param routeid
	 * @param scheduleid
	 * @param vehicleid
	 * @param stationids
	 * @param departdate
	 * @return
	 * @throws ServiceException
	 */
	public boolean updatepack(String packids,long routeid,long scheduleid,
			Long vehicleid,String stationids,long signby,Date signtime,Date departdate) throws ServiceException;
	/**
	 * 行包签发  查询报到车辆信息 李电志 2015年5月20日 16:22:15
	 * @param departdate
	 * @param param
	 * @param orgid
	 * @return
	 * @throws ServiceException
	 */
	public List<Map<String, Object>> qrysendVehicle(Date departdate,
			String param, long orgid) throws ServiceException;

	/**
	 * 行包签发 李电志 2015年5月20日 16:22:32
	 * @param departdate
	 * @param packno
	 * @param vehiclereportid
	 * @param signby
	 * @return
	 * @throws ServiceException
	 */
	public boolean senderPack(Date departdate, String packno,
			long vehiclereportid, long scheduleid, long signby, String flag_pack)
			throws ServiceException;

	/**
	 * 保存提领数据
	 * 
	 * @param packpickup
	 * @return
	 * @throws ServiceException
	 */
	public Packpickup savepackpickup(Packpickup packpickup, String packpickno,
			int packpickups,long sellby) throws ServiceException;

	/**
	 * 查询行包员日营收
	 * 
	 * @param userid
	 * @param date
	 * @return
	 */
	public List<Map<String, Object>> querysellbyrevenue(long userid, Date date);

	/**
	 * 取消签发、提领
	 * 
	 * @param pack
	 * @return
	 * @throws ServiceException
	 */
	public boolean cancelPack(Pack pack) throws ServiceException;

	public boolean updatPackBy(String singbillno,
			List<PropertyFilter> propertyFilters);


	/**
	 * 查询当前车辆签发的行包信息
	 * 
	 * @param buildFromHttpRequest
	 * @return
	 */
	public List<Map<String, Object>> querystockSendPack(long vehiclereportid,long scheduleid,
			String flag_pack) throws ServiceException;
	
	public List<Map<String, Object>> havaPackdepart(Pack pack);
	
	
	public List<Map<String, Object>> qrysendSchedule(Date departdate,
			String param, long orgid) throws ServiceException;
	
	//计划班次
	public List<Map<String, Object>> qrysendSchedulePlan(Date departdate,
			String param,boolean isfindbyreported);
	
	public boolean choosenSenderPack(Date departdate, String pknos,
			long vehiclereportid,long scheduleid, long signby, String flag_pack, Long routeid, Global global)
			throws ServiceException;
}
