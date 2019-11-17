package cn.nova.bus.system.dao;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.system.model.Carrycontrol;

@SuppressWarnings("rawtypes")

public class CarrycontrolDao extends EntityManagerDaoSurport {
	public Carrycontrol getCarrycontrol(String modulecode) {

		String sql = "select c from Carrycontrol c where c.modulecode=:modulecode";
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("modulecode", modulecode);
		return (Carrycontrol)query.getSingleResult();
	}
}
