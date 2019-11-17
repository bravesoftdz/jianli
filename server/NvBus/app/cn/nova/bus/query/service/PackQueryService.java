package cn.nova.bus.query.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.security.Global;
import cn.nova.utils.orm.PropertyFilter;

public interface PackQueryService {
	
	/**
	 * 行包发货营收统计
	 * @param propertyFilters
	 * @return
	 */
	public List<Map<String, Object>> queryPackShipment(List<PropertyFilter> propertyFilters);
	
	/**
	 * 行包提领营收统计
	 * @param propertyFilters
	 * @return
	 */
	public List<Map<String, Object>> queryPackReceive(List<PropertyFilter> propertyFilters);
	
	/**
	 * 小件营收统计
	 * @param propertyFilters
	 * @return
	 */
	public List<Map<String, Object>> queryGoods(List<PropertyFilter> propertyFilters,Boolean isbysellgroup);
	
	/**
	 *	车辆返款统计
	 * 
	 * @param propertyFilters
	 * @return
	 */
	public List<Map<String, Object>> queryPackVehiclePrice(List<PropertyFilter> propertyFilters);
	/**
	 *	前台明细统计
	 * 
	 * @param propertyFilters
	 * @return
	 */
	public List<Map<String, Object>> queryPackDetails(Global global,List<PropertyFilter> buildFromHttpRequest);
	
	/**
	 *	出库明细统计
	 * 
	 * @param propertyFilters
	 * @return
	 */
	public List<Map<String, Object>> qryLibraryDetails(List<PropertyFilter> buildFromHttpRequest);
	
	/**
	 *	对付明细统计
	 * 
	 * @param propertyFilters
	 * @return
	 */
	public List<Map<String, Object>> queryCollectDetail(List<PropertyFilter> buildFromHttpRequest);
	
	/**
	 * 发货明细统计
	 * 
	 * @param propertyFilters
	 * @return
	 */
	public List<Map<String, Object>> querySendGoodsdGetails(List<PropertyFilter> buildFromHttpRequest);
}
