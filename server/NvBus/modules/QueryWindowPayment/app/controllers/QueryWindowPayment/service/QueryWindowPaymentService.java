package controllers.QueryWindowPayment.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.security.Global;
import cn.nova.utils.orm.PropertyFilter;

/**
 * 
 * @author Administrator
 *
 */

public interface QueryWindowPaymentService {

	/**
	 * <b>类描述：</b>窗口电子支付对账汇总表<br/>
	 * @return List<Map<String,Object>>
	 */

	public List<Map<String,Object>> queryPaymentSummary(List<PropertyFilter> propertyFilterList,String summaryway,Date beginDate,Date endDate);
	/**
	 * <b>类描述：</b>窗口电子支付对账明细表<br/>
	 * @return List<Map<String,Object>>
	 */
	public List<Map<String,Object>> queryPayment(List<PropertyFilter> propertyFilterList,Date beginDate,Date endDate);
	
	public List<Map<String, Object>> find(String helpType, String param,List<PropertyFilter> propertyFilterList);
	
	/**
	 * 查询窗口电子支付明细
	 * #21596 将查询条件由售票日期修改为交易日期
	 * @param beginDate： 交易开始日期
	 * @param endDate： 交易截止日期
	 * @return
	 */
	public List<Map<String, Object>> ticketEpayDetail(Global g,
			Date beginDate, Date endDate, List<PropertyFilter> buildFromHttpRequest);

	/**
	 * 窗口电子支付汇总表
	 * 
	 * @param propertyFilterList
	 * @param summaryway
	 *            [ 0 支付方式分组 || 1 交易日期分组 || 2 交易日期和支付方式分组]
	 * @param datetype
	 *            [0 售票日期 || 1 发车日期]
	 * @return
	 */
	public List<Map<String,Object>> queryEpaymentTicketsSum(List<PropertyFilter> propertyFilterList, String summaryway,
			String datetype,Date starttime,Date endtime,Global g);
}
