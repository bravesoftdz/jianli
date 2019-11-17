package cn.nova.bus.balance.dao;

import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

/**
 * <b>类描述：综合收费信息</b><br/>
 * <b>类名称：</b>ComplexfeeDao.java<br/>
 * <b>创建人：</b><a href="mailto:huanghaoze@nova.net.cn">hhz</a><br/>
 * <b>创建时间：</b><br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
@SuppressWarnings("rawtypes")
public class ComplexfeeDao extends EntityManagerDaoSurport{

	//综合收费信息
	public List<Object> find(List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = new StringBuilder(
				"select cx.feetype,cx.fee,cx.customer,cx.remarks,cx.printtime,cx.createtime,")
		.append(" cx.updatetime,opr.name as operatorname,o.name as orgname,")
		.append(" cu.name as createname,upr.name as updatename,cx.id,o.id as orgid,cu.id as createby,cx.operator")
		.append(" from Complexfee cx ,Organization o, Userinfo opr ,Userinfo cu,Userinfo upr")
		.append(" where cx.orgid = o.id and  cx.operator= opr.id and cx.createby = cu.id and cx.updateby = upr.id ")
		.append(PropertyFilter.toJpql(propertyFilterList,true));
		sql.append(" order by o.id,cx.printtime desc ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}
	
}
