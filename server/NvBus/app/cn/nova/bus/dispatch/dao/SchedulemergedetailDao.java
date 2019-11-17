package cn.nova.bus.dispatch.dao;

import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.dispatch.model.Schedulemergedetail;

@SuppressWarnings("rawtypes")
public class SchedulemergedetailDao extends EntityManagerDaoSurport {

	@SuppressWarnings("unchecked")
	public List<Schedulemergedetail> getBySchedulemergeid(Long schedulemergeid) {
		StringBuffer sql = new StringBuffer(
				"select t from Schedulemergedetail t where t.schedulemergeid=");
		sql.append(schedulemergeid);
		Query query = getEntityManager().createQuery(sql.toString());
		return query.getResultList();
	}

}
