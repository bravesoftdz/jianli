/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b>cn.nova.bus.query.service<br/>
 * <b>文件名：</b>InsuranceQryService.java<br/>
 * <b>版本信息：</b>v4.0<br/>
 * <b>日期：</b>2013-2-22 上午09:18:30<br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.query.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.utils.orm.PropertyFilter;

/**
 * <b>类描述：</b><br/>
 * <b>类名称：</b>InsuranceQryService.java<br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2013-2-22 上午09:18:30<br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
public interface InsuranceQryService {

	/**
	 * 保险销售明细查询
	 * 
	 * @param buildFromHttpRequest
	 * @return
	 */
	List<Map<String, Object>> queryInsurance(
			List<PropertyFilter> buildFromHttpRequest, long routeid, long scheduleid, String orderno);
	
	/**
	 * 废保明细查询
	 * 
	 * @param buildFromHttpRequest
	 * @return
	 */
	List<Map<String, Object>> queryCancelInsurance(List<PropertyFilter> buildFromHttpRequest);

	/**
	 * 险销售汇总查询
	 * 
	 * @param buildFromHttpRequest
	 * @return
	 */
	List<Map<String, Object>> queryInsurancedetail(List<PropertyFilter> buildFromHttpRequest);
	/**
	 * 售票员保险销售统计
	 * 
	 * @param buildFromHttpRequest
	 * @return
	 */
	List<Map<String, Object>> insuranceReport(
			List<PropertyFilter> buildFromHttpRequest, long routeid,long returnOrcanceluserid,String begindate,
			String enddate,String orgids,Date departbegindate,Date departenddate, String paymethod);

}
