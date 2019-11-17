package cn.nova.bus.check.service;

import java.text.ParseException;
import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.base.model.Vehicle;
import cn.nova.bus.check.model.Chkitem;
import cn.nova.bus.check.model.Securitycheck;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;
import cn.nova.utils.commons.MethodResult;
import cn.nova.utils.orm.PropertyFilter;

public interface SecuritycheckService {

	public Securitycheck save(Securitycheck security) throws ServiceException;

	public List<Securitycheck> query();

	public boolean querycheckplan(long vehicleid, Date departdate,long orgid);
	
	public Securitycheck getById(Long id);

	public List<Map<String, Object>> query(
			List<PropertyFilter> propertyFilterList);

	public Long getBySecurityId(Long vehicleno, String periodtype);

	public String getSerialnumber(Long checkby);

	public Long getId(Securitycheck security, short period);

	/**
	 * 查询车辆的安检结果
	 * @param vehicleId  车辆ID
	 * @param departdate 发车日期
	 * @param orgid      机构ID
	 * @return 返回的 -1:未检 1:当日合格 0:不合格 2:无安检计划无需校验安检 3:24小时内安检合格
	 */
	public MethodResult getVehicleCheckResult(long vehicleId, Date departdate,long orgid);

	// 通过报到卡号得到车辆ID
//	public Long getVehicleid(String cardno);

	// 获取安检打印信息
	public List<Map<String, Object>> queryCheckinfo(long id);

	// 根据卡号获取车辆ID或者自动保存安检记录
	public long checkCardNO(String cardno, boolean isautosave, Global global)
			throws ServiceException;
	
	public List<Map<String, Object>> qrySecurityVehicle(String cardno,Long vehicleid,long orgid)
	throws ServiceException , ParseException;

	public boolean deleteScurityCheck(Long id)  throws ServiceException;

	/** 车辆安检月统计表 
	 * @param propertyFromHttpRequest
	 * @return
	 */
	public List<Map<String, Object>> querySecuritycheck(
			List<PropertyFilter> propertyFromHttpRequest);
	
	//证件有效期剩余过期天数提示
	public List<Map<String, Object>> showValidate(long orgid, long vehicleid,String cardno,long driverid,long driverid1) throws ServiceException;
	//证件有效期过期天数提示
	public String outdateshowValidate(long orgid, long vehicleid,String cardno,long driverid) throws ServiceException;

	/**
	 * 更新车牌信息  李电志 2015年7月8日 16:43:31
	 * @param 车牌id 
	 * @param 线路 id
	 */
	public Vehicle saveVehicleInfo(Long vehicleid, long routeid);
	/**
	 * 查找证件过期的车辆
	 * @param orgid
	 * @param vehicleid
	 * @param cardno
	 * @param driverid
	 * @param driverid1
	 * @return
	 */
	public Vehicle showExpire(long orgid, long vehicleid,
			String cardno, long driverid, long driverid1)  throws ServiceException;
	//通过车牌号查询出vehicleid
	public long getVehicleId(String vehicleno);

	public Map<String, String> saveSecuritycheckresult(List<Chkitem> list,
			String vehicleno, String periodtype, String checkby,
			String checktime, String result, String notenum);

	public String getVehicleUnitName(Long vehicleid);
	
	/**
	 * 重打安检通知单
	 * @param orgid
	 * @param securityCheckId
	 */
	public List<Map<String, Object>> reprintSecurity(Global global, Long securityCheckId);

	/**
	 * 车辆或驾驶员证件有效期到期提醒
	 * @param vehicleid
	 * @param id
	 * @return
	 */
	List<Map<String, Object>> qrySecurityExpirydate(Global global,long vehicleid, long driverid);
}
