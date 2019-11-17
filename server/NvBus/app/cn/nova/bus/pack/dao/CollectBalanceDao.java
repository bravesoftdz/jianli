package cn.nova.bus.pack.dao;

import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

public class CollectBalanceDao extends EntityManagerDaoSurport{

	public List<Object> getList(List<PropertyFilter> propertyFilter) {
		StringBuilder sb = new StringBuilder(
				"select t.id, sf.name         sendstationname, t.departdate, t.packno, dd.value        status, s.code          schedulecode, t.weight, t.shipprice, t.packfee, t.handfee, t.unloadfee, t.insurance, t.transitfee, t.insurancefee, t.deliveryfee, t.otherfee, t.totalfee, t.packprice, org.name          balanceorgname, v.vehicleno, vu.name         unitname, t.vehicleid, t.paymethod ")
				.append(" from pack t")
				.append(" left join station sf on t.sendstationid = sf.id")
				.append(" left join digitaldictionary d on d.tablename = 'pack' and d.columnname = 'status'")
				.append(" left join digitaldictionarydetail dd on dd.digitaldictionaryid = d.id and dd.code = t.status")
				.append(" left join schedule s on s.id = t.scheduleid")
				.append(" left join organization org on t.balanceorgid = org.id")
				.append(" left join vehicle v on t.vehicleid = v.id")
				.append(" left join unit vu on v.unitid = vu.id")
				.append(" where t.packtype = '1' and t.status = '0' and t.packprice > 0 and (t.collectstatus = '0' or t.collectstatus is null) ");
		sb.append(PropertyFilter.toJpql(propertyFilter, true));
		sb.append(" order by t.departdate");
		Query query = em.createNativeQuery(sb.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilter);
		return query.getResultList();
	}

}
