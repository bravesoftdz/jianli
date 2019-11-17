package cn.nova.bus.report.service.impl;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.report.dao.CustomerBookingDao;
import cn.nova.bus.report.service.CustomerBookingService;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;

public class CustomerBookingServiceImpl implements CustomerBookingService {
	private CustomerBookingDao customerBookingDao = new CustomerBookingDao();
	/**
	 * 订票统计查询
	 * @param propertyFilterList
	 * @return
	 */
	@Override
	public List<Map<String, Object>> QueryCustomerBooking(
			String orgid,Date startdate,Date enddate) {
		customerBookingDao = new CustomerBookingDao();
		return ListUtil.listToMap(new Object[] { 
				"orgname","cusname","sex","mobilephone","bookingnum",
				"R","S","C","certificatetype","certificateno","email"},
				customerBookingDao.QueryCustomerBooking(orgid, startdate, enddate),
				new Object[] {
				String.class,String.class,String.class,String.class,Long.class,
				Long.class,Long.class,Long.class,String.class,String.class,String.class,});
	
	}
	
	/**
	 * 班次预售情况查询
	 * @param propertyFilterList
	 * @return
	 */
	@Override
	public List<Map<String, Object>> QueryPersellSum(
			List<PropertyFilter> propertyFilterList) {
		customerBookingDao = new CustomerBookingDao();
		if(propertyFilterList!=null && propertyFilterList.size() >0){
			for(int i=propertyFilterList.size()-1;i>=0;i--){	
				PropertyFilter propertyFilter=propertyFilterList.get(i);
				if("s!id".equals(propertyFilter.getPropertyFullName())){
					long id= (Long) propertyFilter.getMatchValue();
					if(id>0){
						String schedulecode=customerBookingDao.queryScheduleCode(id);
						PropertyFilter propertyFilter_new =new PropertyFilter("LIKES_s!code",schedulecode);
						propertyFilterList.remove(propertyFilter);
						propertyFilterList.add(propertyFilter_new);			
					}
				}
			}
		}
		return ListUtil.listToMap(new Object[] { 
				"routename", "departdate","departtime","isovertime","sellnum", 
				"sellprice","code","ticreturnnum","totalreturnmoney","cancelticketnum",
				"cancelservicefee","actualamount"},
				customerBookingDao.QueryPersellSum(propertyFilterList),
				new Object[] {
				String.class,Timestamp.class,String.class,boolean.class,Long.class,
				BigDecimal.class,String.class,Long.class,BigDecimal.class,Long.class,
				BigDecimal.class,BigDecimal.class
				});
	}

}
