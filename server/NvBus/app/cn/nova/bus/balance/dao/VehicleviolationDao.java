/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b>cn.nova.bus.balance.dao<br/>
 * <b>文件名：</b>VehicleviolationDao.java<br/>
 * <b>版本信息：</b>v4.0<br/>
 * <b>日期：</b>2012-9-11 下午05:24:19<br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.balance.dao;

import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

/**
 * <b>类描述：</b><br/>
 * <b>类名称：</b>VehicleviolationDao.java<br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2012-9-11 下午05:24:19<br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
@SuppressWarnings("rawtypes")
public class VehicleviolationDao extends EntityManagerDaoSurport {

	@SuppressWarnings("unchecked")
	public List<Object> query(List<PropertyFilter> propertyFilterList) {
		StringBuffer sql = new StringBuffer("select t.id, v.id vehicleid, t.billor, ");
		sql.append(" t.orgid, t.createby, t.notenum, t.routename, ");
		sql.append(" t.violationdate, trim(t.departtime), t.debit, t.remark, t.billdate, t.handleret, ")
		//.append(" (case t.handleret when '0' then '警告' when '1' then '交纳违约金' else '' end) handleret, ")
		.append(" t.breachfee, t.ishandle, t.handledate, t.createtime, t.updatetime, v.vehicleno,")
		.append(" ue.name handlorname, u.name billorname, ui.name createname, use.name updatename, o.name orgname, ")
		//.append(" (case t.balancetype when '0' then '罚金结算' when '1' then '暂扣运量结算' else '' end) balancetype, ")
		.append(" t.balancetype, t.status ")
		.append(" from Vehicleviolation t left join Userinfo ue on t.handlor=ue.id, organization o, ")
		.append(" Vehicle v, Userinfo u, Userinfo ui, Userinfo use where t.vehicleid=v.id ")
		.append(" and t.billor=u.id and t.createby=ui.id and t.updateby=use.id and t.orgid=o.id ");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	public List<Object> notenumUnique(String notenum){
		StringBuffer sql = new StringBuffer("select t from Vehicleviolation t where ");
		sql.append(" t.notenum=:notenum");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("notenum", notenum);
		return query.getResultList(); 
	}

	/**
	 * @param id
	 * @return
	 */
	public boolean isBalance(Long id) {
		StringBuffer sql = new StringBuffer("select t from Vehicleviolation t where ");
		sql.append(" t.id=:id and (t.ishandle=1 or t.balance.id is not null)");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("id", id);
		if (!query.getResultList().isEmpty()) {
			return true;
		}
		return false; 
	}

	/**
	 * @param vehicleid
	 * @return
	 */
	public String getRoutenameByVehicleid(long vehicleid) {
		StringBuffer sql = new StringBuffer("select r.name from ");
		sql.append(" Vehicle v, Route r where v.route.id=r.id and v.id=:vehicleid");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("vehicleid", vehicleid);
		return (String) query.getSingleResult();
	}
	
}
