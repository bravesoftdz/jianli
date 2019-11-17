package cn.nova.bus.report.service.impl;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.persistence.Query;

import cn.nova.bus.report.dao.SellerTaskDao;
import cn.nova.bus.report.service.SellerTaskService;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;
import cn.nova.utils.orm.jpa.ListUtil;

public class SellerTaskServiceImpl implements SellerTaskService{
	
	private SellerTaskDao dao = new SellerTaskDao();
	@Override
	public List<Map<String, Object>> query(List<PropertyFilter> propertyFilter) {
		
		return ListUtil.listToMap(new Object[] { "seller", "code",
				"soldnum", "soldmoney", "returnnum", "returnmoney",
				"cancelnum", "canclemoney", "totalnum", "totalmoney" }, 
				dao.query(propertyFilter),
				new Object[] { String.class, String.class, 
				Long.class,	Double.class, Long.class, Double.class,
				Long.class, Double.class, Long.class, Double.class });
	}

}
