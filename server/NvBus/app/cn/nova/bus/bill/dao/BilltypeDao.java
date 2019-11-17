/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b>cn.nova.bus.bill.dao<br/>
 * <b>文件名：</b>BilltypeDao.java<br/>
 * <b>版本信息：</b>0.1<br/>
 * <b>日期：</b> 2011-7-13 下午02:38:39 <br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.bill.dao;

import java.util.List;
import java.util.Map;

import javax.persistence.Query;

import cn.nova.bus.bill.model.Billtype;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

/**
 * <b>类描述：</b>
 * <b>类名称：</b><br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2011-7-13 下午02:38:39	<br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */

public class BilltypeDao extends EntityManagerDaoSurport<Billtype> {

	@SuppressWarnings("unchecked")
	public List<Object> query(List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = new StringBuilder(
				"select b   from  Billtype b where b.isactive='1' ");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		Query query = getEntityManager().createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}

	@SuppressWarnings("rawtypes")
	public Long getIdByCode(String code) {
		StringBuilder sql = new StringBuilder("select b.id from Billtype b ");
		sql.append(" where b.isactive='1' and  b.code='");
		sql.append(code).append("'");
		Query query = getEntityManager().createQuery(sql.toString());
		List list = query.getResultList();
		if (list.isEmpty()) {
			return (long) 0;
		}
		return (Long) query.getSingleResult();
	}

	public Billtype getBilltypeByName(String name, String value) {
		StringBuilder sql = new StringBuilder("select b from Billtype b ");
		sql.append(" where b.name=:name");
		if (value != null) {
			sql.append(" and b.isactive='0' ");
		}
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("name", name);
		@SuppressWarnings("rawtypes")
		List list = query.getResultList();
		if (list.isEmpty()) {
			return null;
		}
		return (Billtype) query.getSingleResult();
	}

	public Billtype getBilltypeByCode(String code, String value) {
		StringBuilder sql = new StringBuilder("select b from Billtype b ");
		sql.append(" where b.code=:code");
		if (value != null) {
			sql.append(" and b.isactive='0' ");
		}
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("code", code);
		@SuppressWarnings("rawtypes")
		List list = query.getResultList();
		if (list.isEmpty()) {
			return null;
		}
		return (Billtype) query.getSingleResult();
	}
	
	public List queryUsableBillType(){
		StringBuilder sql = new StringBuilder();
		sql.append(" select distinct bt.id,bt.code,bt.name,bt.ticketnolength ")
		.append(" from Billinuse bs left join Billinventory bi on bs.billinventoryid=bi.id left join Billtype bt on bi.billtypeid=bt.id ")
		.append(" where bt.isactive=1  order by id ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		return query.getResultList();
		
	}

	public List<Object> qryvalue(String name) {
		StringBuffer sql = new StringBuffer("select parvalue from Billtype where name =:name");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("name", name);
		return query.getResultList();
	}

}
