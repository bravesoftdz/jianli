package cn.nova.bus.report.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.utils.orm.PropertyFilter;

public interface QueryBillinuseService {

	public List<Map<String, Object>> queryDepartinvoices(
			List<PropertyFilter> propertyFilter);

	public List<Map<String, Object>> queryDepartinvoicesdetail(
			List<PropertyFilter> propertyFilter);

	List<Map<String, Object>> queryBillinuseReport(Date startdate,
			Date enddate, Long recipients, String status);
	

	/**
	 * 站务分公司使用票证明细帐
	 * @param orgids
	 * @param startdate
	 * @param enddate
	 * @param recipients
	 * @param status
	 * @param biitype
	 * @param biitype
	 * @return storageid
	 */
	public List<Map<String, Object>> queryBilldetailReport(String orgids,Date startdate,
			Date enddate, Long recipients, String status,Long billtype,Long storageid);
	
	/**
	 * 车票使用汇总表
	 */
	public List<Map<String, Object>> queryTicketReport(
			List<PropertyFilter> propertyFilter,String startticketno ,String endticketno);
	
	/**车票换号重打查询
	 * @param propertyFilters
	 * @return
	 */
	public List<Map<String,Object>> queryTicketReprint(List<PropertyFilter> propertyFilters);
}
