package cn.nova.bus.dispatch.dao;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.sale.model.Seatlock;

@SuppressWarnings("rawtypes")
public class SeatlockDao extends EntityManagerDaoSurport {
	
	public Seatlock getSeatlock(Long scheduleplanid, short seatno) {
		StringBuffer sql = new StringBuffer(
				"select t from Seatlock t where t.id.scheduleplanid=");
		sql.append(scheduleplanid).append(" and t.id.seatno=").append(seatno);
		Query query = getEntityManager().createQuery(sql.toString());
		return (Seatlock) query.getSingleResult();
	}
	
}
