/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b>cn.nova.bus.base.dao<br/>
 * <b>文件名：</b>TicketoutletsDao.java<br/>
 * <b>版本信息：</b>0.1<br/>
 * <b>日期：</b> 2011-7-28 上午11:50:24 <br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.base.dao;

import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.base.model.Ticketoutlets;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

/**
 * <b>类描述：</b><br/>
 * <b>类名称：</b>TicketoutletsDao.java<br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2011-7-28 上午11:50:24 <br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
@SuppressWarnings("rawtypes")
public class TicketoutletsDao extends EntityManagerDaoSurport {

	@SuppressWarnings("unchecked")
	public List<Object> query(List<PropertyFilter> buildFromHttpRequest) {
		StringBuffer sql = new StringBuffer(
				"select s,d.name as districtname,u.name as createname,");
		sql.append("o.name as orgname,dic.value as dicgrade,dic2.value as dictype, ");
		sql.append("(select name from Station where id=s.startstation.id) as startstationname ");
		sql.append(" from Ticketoutlets s, District d ,Userinfo u, Organization o, ");
		sql.append(" Digitaldictionarydetail dic,Digitaldictionary dig,Digitaldictionarydetail dic2, ");
		sql.append(" Digitaldictionary dig2 where s.districtid=d.id and u.id=s.createby and ");
		sql.append(" o.id=s.orgid and dig.columnname='level' and dig.tablename='ticketoutlets' and ");
		sql.append(" dic.digitaldictionary.id=dig.id and dic.code=s.grade ");
		sql.append(" and dig2.columnname = 'type' and dig2.tablename = 'ticketoutlets' and ");
		sql.append(" dic2.digitaldictionary.id = dig2.id and dic2.code = s.type and s.isactive=1 ");
		sql.append(PropertyFilter.toJpql(buildFromHttpRequest, true));
		Query query = getEntityManager().createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, buildFromHttpRequest);
		return query.getResultList();
	}

	public Long checkNameUnique(Ticketoutlets ticketoutlet, boolean isactive) {
		StringBuffer sql = new StringBuffer("select r.id from Ticketoutlets r ");
		sql.append(" where r.name=:name ");
		if (isactive) {
			sql.append(" and r.isactive=1 ");
		}
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("name", ticketoutlet.getName());
		if (query.getResultList().size() < 1) {
			return (long) 0;
		}
		return (Long) query.getSingleResult();
	}

	public Long checkTypeUnique(Ticketoutlets ticketoutlet, boolean isactive) {
		StringBuffer sql = new StringBuffer("select r.id from Ticketoutlets r ");
		sql.append(" where r.orgid=:orgid and r.type='0' ");
		if (isactive) {
			sql.append(" and r.isactive=1 ");
		}
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("orgid", ticketoutlet.getOrgid());
		if (query.getResultList().size() < 1) {
			return (long) 0;
		}
		return (Long) query.getSingleResult();
	}
	public boolean isExistTicketoutlets(String ticketoutletcode) {
		StringBuffer sql = new StringBuffer("select r from Ticketoutlets r ");
		sql.append(" where r.code=:ticketoutletcode ");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("ticketoutletcode", ticketoutletcode);
		List<Object> obj=query.getResultList();
		return obj!=null&&obj.size()>0?true:false;
	}
}
