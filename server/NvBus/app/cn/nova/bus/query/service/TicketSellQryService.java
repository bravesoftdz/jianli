package cn.nova.bus.query.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.query.param.Qryparam;
import cn.nova.bus.security.Global;
import cn.nova.utils.orm.PropertyFilter;

/**
 * 车票查询(查询当天的售票明细【正常、退、废】票。当天的全部售票、当天售当天的票、当天预售票)
 * @author Administrator
 *
 */
public interface TicketSellQryService {

	/**
	 * 售票查询
	 * @param propertyFilterList
	 * @return
	 */
	public List<Map<String, Object>> query(Qryparam qp,Global global);

	/**
	 * 预售票情况查询
	 * @param propertyFilterList
	 * @return
	 */
	public List<Map<String, Object>> queryPersell(List<PropertyFilter> propertyFilterList);


	/**
	 * 车票改签情况查询
	 * @param propertyFilterList
	 * @return
	 */
	public List<Map<String, Object>> queryTicketchange(List<PropertyFilter> propertyFilterList);
	

	/**
	 * 留票情况查询
	 * @param propertyFilterList
	 * @return
	 */
	public List<Map<String, Object>> queryReserveTicket(List<PropertyFilter> propertyFilterList);
	

	/**
	 * 退票情况查询
	 * @param propertyFilterListf
	 * @return
	 */
	public List<Map<String, Object>> queryTicketreturn(List<PropertyFilter> propertyFilterList,String schedulecode,Long routeid,Qryparam qp);
	

	/**
	 * 废票情况查询
	 * @param propertyFilterList
	 * @return
	 */
	public List<Map<String, Object>> queryTickeCancle(List<PropertyFilter> propertyFilterList);
	
	/**
	 * 坏票登记情况查询
	 * @param propertyFilterList
	 * @return
	 */
	public List<Map<String, Object>> queryBilldamaged(
			List<PropertyFilter> propertyFilterList) ;
	
	/**
	 * 异站退本站票情况查询
	 * @param propertyFilterList
	 * @return
	 */
	public List<Map<String, Object>> queryReturnLocal(
			List<PropertyFilter> propertyFilterList);

	/**
	 * 分布式、集中式异站售本站
	 * @param propertyFilterList
	 * @param qp 
	 * @return
	 */
	List<Map<String, Object>> queryFocusSaleLocal(
			List<PropertyFilter> propertyFilterList,Global global, Qryparam qp);

	/**
	 * 分布式、集中式本站售异站
	 * @param propertyFilterList
	 * @return
	 */
	List<Map<String, Object>> queryFocusSaleOther(
			List<PropertyFilter> propertyFilterList, String scheduleorgid, Long orgid);
	
	/**
	 * 电子票明细查询
	 * @param propertyFilterList
	 * @return
	 */
	public List<Map<String, Object>> queryTicketDetail(Qryparam qp);
	
	
	/**
	 * 远程检票信息查询
	 * @param propertyFilterList
	 * @return
	 */
	public List<Map<String, Object>> queryrRemoteticketsell(List<PropertyFilter> propertyFilterList);
	/**
	 * 查询取票操作日志
	 * @param departstationname
	 * @param sellticketorgid
	 * @param taketicketorgid
	 * @param dtpstartdate
	 * @param dtpenddate
	 * @return
	 */
	public List<Map<String, Object>> qryTaketicketlog(String operatorgname,
			String sellticketorgid, String ticketoutletsid, Date dtpstartdate,
			Date dtpenddate);

	public List<Map<String, Object>> queryChangeCancelTicket(List<PropertyFilter> propertyFilterList, String sign, Date dtpstartdate,
			Date dtpenddate);

	public boolean saveCustomerinfo(String certificateno, long customerid, String customername, Date birthday,
			String sex, String ticketno) throws ServiceException;
	
	public Map<String, String> checkTicketValidity(String datetoDay,
			String strTicketNumber);
	
	
}
