package cn.nova.bus.pack.dao;

import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

public class PackRecycleDao extends EntityManagerDaoSurport{

	public List<Object> getList(List<PropertyFilter> buildFromHttpRequest) {
		StringBuilder sb = new StringBuilder(
				"select st.name      tostationname, t.pieces, t.totalfee, t.createtime, u.name       sellbyname, t.packno, v.vehicleno, t.vehicleid, t.id" +
				" from pack t" +
				" left join station st on t.tostationid = st.id" +
				" left join userinfo u on t.sellby = u.id" +
				" left join vehicle v on t.vehicleid = v.id" +
				" where t.collectstatus = '1' ");
		sb.append(PropertyFilter.toJpql(buildFromHttpRequest, true));
		sb.append(" order by t.departdate");
		Query query = em.createNativeQuery(sb.toString());
		JPAPropertyFilterUtil.setParameter(query, buildFromHttpRequest);
		return query.getResultList();
	}

}
