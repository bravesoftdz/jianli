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

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.dispatch.model.Vehiclelost;

/**
 * <b>类描述：车辆脱班DAO</b><br/>
 * <b>类名称：</b>VehiclelostDao<br/>
 * <b>创建人：</b><a href="mailto:lanchengkun@nova.net.cn">兰成坤</a><br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 * 
 */
@SuppressWarnings("rawtypes")
public class VehiclelostDao extends EntityManagerDaoSurport {
	@SuppressWarnings("unchecked")
	public List<Vehiclelost> qryVehiclelost(Date fromdepart, Date enddepart,
			String vehicleids) {
		StringBuilder sql = new StringBuilder("select v")
				.append(" from Vehiclelost v")
				.append(" where v.departdate>=:fromdepart and v.departdate<=:enddepart")
				.append(" and v.vehicle.id in " + vehicleids);
		Query query = em.createQuery(sql.toString());
		query.setParameter("fromdepart", fromdepart);
		query.setParameter("enddepart", enddepart);
		return query.getResultList();
	}
	
	public BigDecimal qryVehiclelostDeduct(Date fromdepart, Date enddepart,
			String vehicleids) {
		StringBuilder sql = new StringBuilder("select sum(v.forfeit)")
				.append(" from Vehiclelost v")
				.append(" where v.departdate>=:fromdepart and v.departdate<=:enddepart")
				.append(" and v.vehicleid in " + vehicleids);
		Query query = em.createNativeQuery(sql.toString());
		query.setParameter("fromdepart", fromdepart);
		query.setParameter("enddepart", enddepart);
		List list = query.getResultList();		
		return  (BigDecimal) (list!=null&&list.size()>0?list.get(0):0);
	}

	
	public Object[] qryScheduleLostTreatment(Date fromdepart, Date todepart,
			String vehicleids, String schedulestatus) {
		StringBuilder sql = new StringBuilder();
		sql.append("select to_char(wm_concat(t.id)) as id,sum(t.fine) ")
		.append(" from ScheduleLostTreatment t where t.vehicleid in " + vehicleids)
		.append(" and t.departdate>=:fromdepart and t.departdate<=:todepart ")
		.append(" and t.isaddbalanceprice='1' and t.recheck='1' and t.balanceid is null and t.schedulestatus=:schedulestatus"); 
		Query query = em.createNativeQuery(sql.toString());
		query.setParameter("fromdepart", fromdepart);
		query.setParameter("todepart", todepart);
		query.setParameter("schedulestatus", schedulestatus);
		List list = query.getResultList();		
		return  list!=null && list.size()>0 ? (Object[])list.get(0) : null;
	}
}
