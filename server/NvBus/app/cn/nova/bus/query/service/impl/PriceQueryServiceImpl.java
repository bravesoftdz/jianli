package cn.nova.bus.query.service.impl;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.query.dao.PriceQueryServiceDao;
import cn.nova.bus.query.service.PriceQueryService;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;

public class PriceQueryServiceImpl implements PriceQueryService {
	private PriceQueryServiceDao priceqrydao = new PriceQueryServiceDao();
	/**
	 * 班次票价查询
	 * @param propertyFilterList
	 * @return
	 */
	@Override
	public List<Map<String, Object>> QuerySchedulePrice(
			List<PropertyFilter> propertyFilterList) {
		priceqrydao = new PriceQueryServiceDao();
		if(propertyFilterList!=null && propertyFilterList.size() >0){
			for(int i=propertyFilterList.size()-1;i>=0;i--){	
				PropertyFilter propertyFilter=propertyFilterList.get(i);
				if("s!id".equals(propertyFilter.getPropertyFullName().toString())){
					long id= (Long) propertyFilter.getMatchValue();
					if(id>0){
						String schedulecode=priceqrydao.queryScheduleCode(id);
						PropertyFilter propertyFilter_new =new PropertyFilter("LIKES_s!code",schedulecode);
						propertyFilterList.remove(propertyFilter);
						propertyFilterList.add(propertyFilter_new);			
					}
				}
			}
		}
		return ListUtil.listToMap(new Object[] { 
				"departdate","orgname","endstationn","routename","code","departstation","departtime",
				"schedulestatus","reachstation","seattypename","seatnum","soldeatnum","fullprice",
				"halfprice","studentprice","toplimitprice","lowerlimitprice",
				"stationservicefee","fueladditionfee","distance","issellable" },
				priceqrydao.QuerySchedulePrice(propertyFilterList),
				new Object[] {
				Date.class,String.class,String.class,String.class,String.class,String.class,String.class,
				String.class,String.class,String.class,Short.class,Short.class,BigDecimal.class, 
				BigDecimal.class,BigDecimal.class, BigDecimal.class,BigDecimal.class,
				BigDecimal.class, BigDecimal.class, BigDecimal.class,boolean.class});
	
	}

}
