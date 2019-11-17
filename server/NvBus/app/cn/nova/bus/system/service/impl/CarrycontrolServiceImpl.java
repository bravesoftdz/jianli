package cn.nova.bus.system.service.impl;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.system.dao.CarrycontrolDao;
import cn.nova.bus.system.model.Carrycontrol;
import cn.nova.bus.system.service.CarrycontrolService;
import cn.nova.utils.orm.jpa.IDAO;



public class CarrycontrolServiceImpl implements CarrycontrolService {


	private IDAO<Carrycontrol> dao = new EntityManagerDaoSurport<Carrycontrol>();

	@PersistenceContext
	private EntityManager em;

	CarrycontrolDao carrycontrolDao;
	
	@SuppressWarnings("deprecation")
	@Override
	public boolean save(Carrycontrol carr) {
		if (carr.getId() == 0) {
			return dao.save(carr);
		} else {
			return dao.update(carr);
		}
		
	}

	@Override
	public boolean delete(Carrycontrol carr) {
		if (carr != null) {
			return dao.del(carr);
		} else
			return false;
	}

	@Override
	public boolean delete(Long id) {
		return dao.delete(Carrycontrol.class, id);
	}

	@Override
	public List<Carrycontrol> query() {
		return dao.query(Carrycontrol.class, null);
	}

	@Override
	public Carrycontrol getByModulecode(String Modulecode) {
		return dao.get(Carrycontrol.class, Modulecode);
	}
	
	@Override
	public Carrycontrol getById(long id) {
		return dao.get(Carrycontrol.class, id);
	}

	@Override
	public List<Map<String, Object>> query(String describe) {
		String sql = "";
		sql = "select t,u.name from Carrycontrol t,Userinfo u where t.updateby=u.id ";
				
		if (!describe.equals(""))
			sql = sql + "  and t.describe like '%" + describe + "%'";		

		Object[] fileds = { Carrycontrol.class,"name" };// 初始化要查询的字段

		Object[] filedtype = { Carrycontrol.class,String.class };

		return dao.query(fileds, sql, filedtype);
	}

	@Override
	public boolean equals(String code, String name) {
		return false;
	}

	@Override
	public Long getValue(Long id, String value,String value2) {
		String sql = "";
		if (value.equals("describe")) {
			sql = sql + "select t.id from Carrycontrol t where t.id !=" + id+" and t.describe ='"+value2+"'";
		} else if (value.equals("modulecode")) {
			sql = sql + "select t.id from Carrycontrol t where t.id !=" + id+" and t.modulecode ='"+value2+"'";
		}
		Query query = em.createQuery(sql);
		@SuppressWarnings("rawtypes")
		List list = query.getResultList();
		if (list.isEmpty()) {
			return (long) 0;
		}
		return (Long) query.getSingleResult();
	}

	@Override
	public Long findModulecode(String modulecode) {
		String sql = "select t.id from Carrycontrol t where t.modulecode='"
			+ modulecode + "'";
		Query query = em.createQuery(sql);
		@SuppressWarnings("rawtypes")
		List list = query.getResultList();
		if (list.isEmpty()) {
			return (long) 0;
		}
		return (Long) query.getSingleResult();
	}

	@Override
	public Long findDescribe(String describe) {
		String sql = "select t.id from Carrycontrol t where t.describe='"
			+ describe + "'";
		Query query = em.createQuery(sql);
		@SuppressWarnings("rawtypes")
		List list = query.getResultList();
		if (list.isEmpty()) {
			return (long) 0;
		}
		return (Long) query.getSingleResult();
	}

	@Override
	public BigDecimal carryControl(String formula, String modulecode) {
		//Carrycontrol carrycontrol=carrycontrolDao.getCarrycontrol(modulecode);
		//CarryControlUtil.getResultExpression(formula, carrycontrol.getFormula())
		return new BigDecimal(0);
	}
	
	

}
