package cn.nova.bus.balance.service.impl;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import cn.nova.bus.balance.dao.ComplexfeeDao;
import cn.nova.bus.balance.model.Complexfee;
import cn.nova.bus.balance.service.ComplexfeeService;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;


/**
 * <b>类描述：综合收费信息设置</b><br/>
 * <b>类名称：</b>ComplexfeeServiceImpl.java<br/>
 * <b>创建人：</b><a href="mailto:huanghaoze@nova.net.cn">hhz</a><br/>
 * <b>创建时间：</b><br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */

public class ComplexfeeServiceImpl implements ComplexfeeService {


	private ComplexfeeDao complexfeedao = new ComplexfeeDao();
	
	@Override
	public List<Map<String, Object>> query(
			List<PropertyFilter> propertyFilterList) {
		Object[] fileds = { "feetype","fee","customer","remarks","printtime",
					"createtime","updatetime","operatorname","orgname",
					"createname","updatename","id","orgid","createby","operatorid" };		
		Object[] filedtypes = { 
				String.class, BigDecimal.class,String.class,String.class,Timestamp.class,
				Timestamp.class, Timestamp.class,String.class,String.class,
				String.class,String.class,Long.class,Long.class,Long.class,Long.class};
		return ListUtil.listToMap(fileds,
				complexfeedao.find(propertyFilterList),filedtypes);
	}
	
	@Override
	public Complexfee merge(Complexfee complexfee) {		
		return (Complexfee) complexfeedao.merge(complexfee);
	}

	@Override
	public boolean delete(Complexfee complexfee) {
		return complexfeedao.delete(complexfee);
	}

}
