/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b>cn.nova.bus.dispatch.dao<br/>
 * <b>文件名：</b>VehiclelostDao.java<br/>
 * <b>版本信息：</b><br/>
 * <b>日期：</b>2011-6-28-下午01:42:26<br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.dispatch.dao;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.base.model.Schedule;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.dispatch.model.Vehiclelost;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

public class NetSaleControlDao extends EntityManagerDaoSurport {

	public List<Object> queryschbyrouteid(List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = new StringBuilder();
		sql.append("select 0 as isselect,s.code,trim(s.starttime) as starttime,s.id as scheduleid "
				+ "from schedule s,route r where r.id = s.routeid and s.isdelete = 0 and r.isactive = 1 ");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}

	public List<Object> queryNetSaleControl(List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = new StringBuilder();
		sql.append(" select t.id, o.name as netorg,r.name as routename, s.code as schedulecode, cu.name as createby, t.createtime, uu.name as updateby, t.updatetime from netsalecontrol t ")
		.append(" left join organization o on o.id = t.netorgid   ")
		.append(" left join route r on r.id = t.routeid  ")
		.append(" left join schedule s on s.id = t.scheduleid  ")
		.append(" left join userinfo cu on cu.id = t.createby  ")
		.append(" left join userinfo uu on uu.id = t.updateby  ")
		.append(" where 1=1   ");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}

	public boolean exitNetSaleControl(long scheduleid, long orgid, long netorgid) {
		StringBuilder sql = new StringBuilder();
		sql.append(
				" select count(t.id) from netsalecontrol t where t.orgid = :orgid and t.netorgid = :netorgid and t.scheduleid = :scheduleid  ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("scheduleid", scheduleid);
		query.setParameter("orgid", orgid);
		query.setParameter("netorgid", netorgid);
		List resultlist = query.getResultList();
		BigDecimal result = (BigDecimal) resultlist.get(0);
		return result.compareTo(BigDecimal.ZERO) > 0 ? true : false;
	}

	public List<Schedule> getOrgAllSchedule(long orgid) {
		StringBuilder sql = new StringBuilder();
		sql.append(
				" select s from Schedule s where s.isactive = 1 and s.orgid = :orgid   ");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("orgid", orgid);
		return query.getResultList();
	}
}
