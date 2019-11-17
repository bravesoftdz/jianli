package cn.nova.bus.query.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.utils.orm.PropertyFilter;

/**
 * <b>类描述：售票员售退废报表;客运班线动态表;客运班线动态同比表</b><br/>
 * <b>类名称：</b>AccountantReportService.java<br/>
 * <b>创建人：</b><a href="mailto:huanghaoze@nova.net.cn">黄浩泽</a><br/>
 * <b>创建时间：</b>2012-4-28  <br/>
 * <b>关键修改：修改售票员售退废报表</b><br/>
 * <b>修改时间：2012-06-29</b><br/>
 * <b>修改人：hhz</b><br/>
 */
public interface AccountantReportService {

	/**
	 * 售票员售退废报表
	 * @param propertyFilterList
	 * @return
	 */
	public List<Map<String, Object>> querySellerDailyReport(
			List<PropertyFilter> propertyFilterList,boolean groupbydate,String paymethod);
	
	/**
	 *  客运班线动态表
	 * @param propertyFilterList
	 * @return  qryRouteDynamicCompare
	 */
	public List<Map<String, Object>> queryRouteDynamic(String orgids,Date startdate,
			Date enddate,String departorgs,String vehicletype,String districttype,String workways);
	

	/**
	 *  客运班线动态同比表
	 * @param propertyFilterList
	 * @return  qryRouteDynamicCompare
	 */
	public List<Map<String, Object>> qryRouteDynamicCompare(
			List<PropertyFilter> propertyFilterList,boolean isbyroute,boolean isbydate);
}
