package cn.nova.bus.system.dao;

import javax.persistence.NoResultException;
import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.system.model.Exceptioninfo;

@SuppressWarnings("rawtypes")

public class ExceptioninfoDao extends EntityManagerDaoSurport {
	public String getExceptioninfo(String code) {

		String sql = "select e from Exceptioninfo e where e.code=:code";
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("code", code);
		try{
			Exceptioninfo exceptioninfo = (Exceptioninfo)query.getSingleResult();
			return exceptioninfo.getMsg();
		}catch(NoResultException e){
			return "发生未定义的系统异常！";
		}
	}
}
