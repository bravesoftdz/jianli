package cn.nova.bus.check.service.impl;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import cn.nova.bus.check.dao.SecuritycheckitemDao;
import cn.nova.bus.check.model.Securitycheckitem;
import cn.nova.bus.check.service.SecuritycheckitemService;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;

@SuppressWarnings("unchecked")
public class SecuritycheckitemServiceImpl implements SecuritycheckitemService {

	
	private SecuritycheckitemDao dao = new SecuritycheckitemDao();

	@Override
	public Securitycheckitem save(Securitycheckitem security) {
		if (security.getId() == 0) {
			return (Securitycheckitem) dao.merge(security);
		} else {
			return (Securitycheckitem) dao.merge(security);
		}
	}

	@Override
	public boolean delete(Long id) {
		return dao.delete(Securitycheckitem.class, id);
	}

	@Override
	public List<Securitycheckitem> query() {
		return dao.query(Securitycheckitem.class, null);
	}

	@Override
	public boolean delete(Securitycheckitem security) {
		if (security != null) {
			return dao.del(security);
		}
		return false;
	}

	@Override
	public Securitycheckitem getById(Long id) {
		return (Securitycheckitem) dao.get(Securitycheckitem.class, id);
	}

	@Override
	public List<Map<String, Object>> query(
			List<PropertyFilter> propertyFilterList) {
//		return ListUtil.listToMap(new Object[] { Securitycheckitem.class,
//				"createname", "updatename" }, dao.query(propertyFilterList),
//				new Object[] { Securitycheckitem.class,String.class,String.class});
		return ListUtil.listToMap(new Object[] { 
				"id","categorycode","name","describe","createtime",
				"createby","updatetime","updateby","isroutinecheck",
				"createname", "updatename" }, dao.query(propertyFilterList),
				new Object[] { 
				long.class,String.class,String.class,String.class,Timestamp.class,
				long.class,Timestamp.class,long.class,boolean.class,
				String.class,String.class});
	}

	@Override
	public boolean isUniqe(String name, String categorycode) {
		List<Securitycheckitem> list = dao.getcheckitem(name, categorycode);
		if (list.isEmpty()) {
			return true;
		}
		return false;
	}

	@Override
	public Long getId(String name, String categorycode) {
		List<Securitycheckitem> list = dao.getcheckitem(name, categorycode);
		if (list.isEmpty()) {
			return (long) 0;
		}
		return list.get(0).getId();
	}
	
	@Override
	public List<Map<String, Object>> qrySecuritycheckfeeReport(
			List<PropertyFilter> propertyFilterList) {
		return ListUtil.listToMap(new Object[] { "checkno","checkdate",
		"checktime","vehicleno", "orgname","securityfee","checkby" }, dao.qrySecuritycheckfeeReport(propertyFilterList),
				new Object[] { String.class,String.class,String.class,String.class,String.class,BigDecimal.class,String.class});
	}

}
