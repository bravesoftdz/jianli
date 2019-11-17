package cn.nova.bus.dispatch.dao;

import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.archive.model.Driver;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.dispatch.model.Schedulestatuslog;


@SuppressWarnings("rawtypes")
public class CreateQuanPinDao extends EntityManagerDaoSurport {

	/**
	 * 查询全拼为空的所有driver的信息
	 * @return
	 */
	public List<Driver> queryDriver() {
		StringBuffer sql = new StringBuffer(" select d from Driver d where d.quanpin is null ");
		Query query = getEntityManager().createQuery(sql.toString());
		return query.getResultList();
	}

	
}
