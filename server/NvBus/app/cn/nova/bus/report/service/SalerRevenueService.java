package cn.nova.bus.report.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.report.param.Reportparam;
import cn.nova.utils.orm.PropertyFilter;

/**
 * 
 * <p>
 * Title: 营收报表服务接口
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
public interface SalerRevenueService {

	// 查询本数据库所有机构
	public List<Map<String, Object>> queryLocalOrg(String orgids);

	// 查询异站机构
	public List<Map<String, Object>> querySyncOrg(long orgid);

	/**
	 * 售票员售票情况日报表
	 * @param ticketoutletid 
	 * 
	 * @param propertyFilterList
	 * @return
	 */
	public List<Map<String, Object>> querySalerdayRevenue(String orgids,
			Date startdate, Date enddate, boolean isbyseller,boolean isbyselldate,String sellerids, String ticketoutletid,String paymethod);

	/**
	 * 本站售异站汇总表
	 * @param isgroupbyday 
	 * @param besaleorgids 
	 * 
	 * @param propertyFilterList
	 * @return
	 */
	public List<Map<String, Object>> querySalerSyncOrgRevenue(String orgids,
			Date startdate, Date enddate, long orgid,String datetype,long currorgid, Boolean isgroupbyday, String besaleorgids);

	/**
	 * 异站售本站汇总表
	 * @param isgroupbyday 
	 * @param olddepartEdate 
	 * @param olddepartSdate 
	 * 
	 * @param propertyFilterList
	 * @return
	 */
	public List<Map<String, Object>> querySyncSaleLocal(String orgids,
			Date startdate, Date enddate,  String schorgids,String datetype,long orgid, Boolean isolddate, Boolean isgroupbyday);

	/**
	 * 客运站划拨明细表
	 * 
	 * @param propertyFilterList
	 * @return
	 */
	public List<Map<String, Object>> queryInvoincesDetail(String orgids,
			List<PropertyFilter> propertyFilterList);

	/**
	 * 各分公司划拨汇总表
	 * 
	 * @param propertyFilterList
	 * @return
	 */
	public List<Map<String, Object>> queryBalanceUnitInvoinces(String orgids,
			int type, List<PropertyFilter> propertyFilterList);

	/**
	 * 客运站结算汇总表
	 * 
	 * @param propertyFilterList
	 * @return
	 */
	public List<Map<String, Object>> queryStationBalanceInvoinces(Reportparam rp);

	/**
	 * 长途站预售票查询情况表（跨月汇总）
	 * 
	 * @param month
	 * @return
	 */
	public List<Map<String, Object>> queryPresellMonthRevenue(String orgids,
			Date month, Boolean isSellLocal);

	/**
	 * 车辆划拨汇总表
	 * 
	 * @param String
	 *            orgids,Date startdate,Date enddate
	 * @return
	 */
	public List<Map<String, Object>> queryVehicleIncome(String orgids,
			Date startdate, Date enddate,
			List<PropertyFilter> propertyFilterList,String printorgids);

	/**
	 * 客运每日班次营收汇总
	 * 
	 * @param String
	 *            orgids,Date startdate,Date enddate
	 * @return
	 */
	public List<Map<String, Object>> queryDayScheduleIncome(String orgids,
			Date startdate, Date enddate, Boolean isovertime,String schedulestatus);

	/**
	 * 售票每日营收统计表
	 * 
	 * @param String
	 *            orgids,Date startdate,Date enddate
	 * @return
	 */
	public List<Map<String, Object>> queryDayIncome(String orgids,
			Date startdate, Date enddate, Long seller);

	public List<Map<String, Object>> qrysellerdepartinvoices(long sellerid, String orgids, Date departstartdate,
			Date departenddate);


	
}
