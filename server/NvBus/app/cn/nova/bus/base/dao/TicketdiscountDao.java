/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b>cn.nova.bus.base.dao<br/>
 * <b>文件名：</b>TicketdiscountDao.java<br/>
 * <b>版本信息：</b>v4.0<br/>
 * <b>日期：</b>2013-1-9 上午10:18:14<br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.base.dao;

import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.base.model.Ticketdiscount;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

/**
 * <b>类描述：</b><br/>
 * <b>类名称：</b>TicketdiscountDao.java<br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2013-1-9 上午10:18:14<br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
@SuppressWarnings("rawtypes")
public class TicketdiscountDao extends EntityManagerDaoSurport {

	@SuppressWarnings("unchecked")
	public List<Object> queryTicketdiscount(List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = new StringBuilder(" select t.id,t.dataid, o.name orgname,u.name createname, ");
		sql.append(" us.name updatename, t.startdate, t.enddate, t.defaultdiscountrate, ")
		.append(" t.mindiscountrate, t.createtime,t.updatetime, t.sellnum, t.orgid, ")
		.append(" trim(case t.datatype when '0' then '机构' when '1' then '线路' when '2' then '班次' end) typename, ")
		.append(" tt.name tickettype, ")
		.append(" (case t.datatype when '0' then (select org.name from Organization org where org.id=t.dataid) ")
		.append(" when '1' then (select r.name from Route r where r.id=t.dataid) ")
		.append(" when '2' then (select s.code from Schedule s where s.id=t.dataid) end) dataname,t.createby,tt.code ")
		.append(" from ticketdiscount t, userinfo u, userinfo us, organization o,tickettype tt ")
		.append(" where t.createby=u.id and t.updateby=us.id and t.orgid=o.id and t.tickettype=tt.code");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}

	/**
	 * @param ticketdiscount
	 * @return
	 */
	public boolean isExist(Ticketdiscount ticketdiscount) {
		StringBuilder sql = new StringBuilder("select t from Ticketdiscount t ");
		sql.append(" where t.tickettype=:tickettype and t.datatype=:datatype ")
		.append(" and t.dataid=:dataid and ((t.startdate<=:startdate and t.enddate >=:startdate) or ")
		.append(" (t.startdate<=:enddate and t.enddate>=:enddate)) ");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("tickettype", ticketdiscount.getTickettype());
		query.setParameter("datatype", ticketdiscount.getDatatype());
		query.setParameter("dataid", ticketdiscount.getDataid());
		query.setParameter("startdate", ticketdiscount.getStartdate());
		query.setParameter("enddate", ticketdiscount.getEnddate());
		return query.getResultList().size() > 0 ? true : false;
	}


}
