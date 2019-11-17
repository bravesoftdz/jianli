package cn.nova.bus.pack.dao;

import java.util.List;
import java.util.Map;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;



public class GenUpdatePackVehicleDao extends EntityManagerDaoSurport {
	
	public List<Object> qryReportPack() {
		StringBuilder sql = new StringBuilder(" select p.id,vp.vehicleid ")
				.append(" from pack p, vehiclereport vp, scheduleplan sp ")
				.append(" where p.scheduleid = vp.scheduleid ")
				.append(" and sp.islinework = 0 and vp.isactive = 1  and vp.isdeparted = 0 ")
				.append("   and vp.scheduleplanid = sp.id and vp.departdate = sp.departdate ")
				.append(" and p.departdate = vp.departdate  and sp.departdate = trunc(sysdate)");
		play.Logger.info(sql.toString());
		Query query = getEntityManager().createNativeQuery(sql.toString());
		List<Object> list = query.getResultList();
		play.Logger.info("qryReportPack list" + list.size());
		return list;
	}
}
