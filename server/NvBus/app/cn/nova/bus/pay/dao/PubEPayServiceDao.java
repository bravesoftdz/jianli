package cn.nova.bus.pay.dao;

import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.pay.model.Paystationway;
import cn.nova.bus.pay.param.ReachInfo;
import cn.nova.bus.pay.param.StartInfo;
import play.db.jpa.JPA;
import util.DateUtils;

public class PubEPayServiceDao extends EntityManagerDaoSurport {

	public Paystationway getPaystationway() {
		String sql = "select t from Paystationway t where t.isactive = 1";
		Query query = em.createQuery(sql.toString());
		List<Paystationway> list = query.getResultList();
		if (null != list) {
			if (list.size() > 1) {
				return null;
			} else {
				return list.get(0);
			}
		} else {
			return null;
		}
	}

	public StartInfo getstartstationinfo(long stationid) {
		try {
			StringBuffer sql = new StringBuffer();
			sql.append(" select rownum  as id,t.provincename, c.cityname, t.stationname")
					.append("  from (select d.name as provincename, o.name as stationname from station s, district d, organization o")
					.append("  where s.id = o.stationid and substr(s.code, 0, 2) = substr(d.code, 0, 2) and substr(d.code, 3, 4) = '0000'")
					.append("  and o.islocal = 1  and s.id = :stationid) t,")
					.append(" (select d.name as cityname from station s, organization o, district d where s.id = o.stationid")
					.append(" and o.type = '2' and substr(s.code, 0, 4) = substr(d.code, 0, 4) and substr(d.code, 5, 2) = '00'")
					.append("  and substr(s.code, 3, 2) <> '00'  and o.islocal = 1  and rownum<=1) c");
			Query query = JPA.em().createNativeQuery(sql.toString(), StartInfo.class);
			query.setParameter("stationid", stationid);
			List<StartInfo> list = query.getResultList();
			return (null != list && list.size() > 0) ? list.get(0) : null;
		} catch (Exception e) {
			play.Logger.error(" 电子支付构建参数 getstartstationinfo 报错:" + e.getMessage(), e);
			return null;
		}
	}

	public ReachInfo getreachstationinfo(long stationid) {
		try {
			StringBuffer sql = new StringBuffer();
			sql.append(" select rownum  as id,p.name as provincename, c.name as cityname, s.name as stationname")
					.append(" from station s, district c, district p where substr(s.code, 0, 2) = substr(p.code, 0, 2)")
					.append("  and substr(p.code, 3, 4) = '0000'  and substr(s.code, 0, 4) = substr(c.code, 0, 4)")
					.append(" and substr(c.code, 5, 2) = '00' and s.isactive=1").append(" and s.id = :stationid");
			Query query = JPA.em().createNativeQuery(sql.toString(), ReachInfo.class);
			query.setParameter("stationid", stationid);
			List<ReachInfo> list = query.getResultList();
			return (null != list && list.size() > 0) ? list.get(0) : null;
		} catch (Exception e) {
			play.Logger.error(" 电子支付构建参数 getreachstationinfo 报错:" + e.getMessage(), e);
			return null;
		}
	}
}
