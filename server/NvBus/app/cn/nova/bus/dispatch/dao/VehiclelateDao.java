/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b>cn.nova.bus.dispatch.dao<br/>
 * <b>文件名：</b>VehiclelateDao.java<br/>
 * <b>版本信息：</b><br/>
 * <b>日期：</b>2011-6-28-上午11:31:20<br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.dispatch.dao;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.dispatch.model.Vehiclelate;

/**
 * <b>类描述：车辆晚点处理DAO</b><br/>
 * <b>类名称：</b>VehiclelateDao<br/>
 * <b>创建人：</b><a href="mailto:lanchengkun@nova.net.cn">兰成坤</a><br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 * 
 */
@SuppressWarnings("rawtypes")
public class VehiclelateDao extends EntityManagerDaoSurport {

	@SuppressWarnings("unchecked")
	public List<Vehiclelate> qryVehiclelate(Date fromdepart, Date enddepart,
			String vehicleids) {
		StringBuilder sql = new StringBuilder("select v")
				.append(" from Vehiclelate v")
				.append(" where v.departdate>=:fromdepart and v.departdate<=:enddepart")
				.append(" and v.vehicleid in " + vehicleids);
		Query query = em.createQuery(sql.toString());
		query.setParameter("fromdepart", fromdepart);
		query.setParameter("enddepart", enddepart);
		return query.getResultList();
	}

	public BigDecimal getVehiclelatesDeduct(String vehicleids) {
		StringBuilder sql = new StringBuilder("select sum(v.forfeit)").append(
				" from Vehiclelate v").append(
				" where  v.balanceid is null and v.vehicleid in " + vehicleids);
		Query query = em.createNativeQuery(sql.toString());
		List list = query.getResultList();
		return (BigDecimal) (list != null && list.size() > 0 ? list.get(0) : 0);
	}
}
