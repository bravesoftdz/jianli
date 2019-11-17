package cn.nova.bus.pack.dao;

import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.pack.model.Pack;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

public class PackBalanceDao extends EntityManagerDaoSurport {
	//列表查询
	public List<Object> getList(List<PropertyFilter> propertyFilter) {
		StringBuilder sb = new StringBuilder(
				"select t.id, sf.name         sendstationname, st.name         tostationname, t.departdate, t.packno, dd.value        status, s.code          schedulecode, t.pieces, t.weight, t.shipprice, t.packfee, t.handfee, t.unloadfee, t.insurance, t.custodial, t.transitfee, t.insuredamount, t.insurancefee, t.deliveryfee, t.otherfee, t.totalfee, t.packprice, org.name          balanceorgname, v.vehicleno, vu.name         unitname, ui.name         signbyname, t.signtime, ub.name         balancebyname, t.balancedate, v.id vehicleid, vu.id unitid")
				.append(" from pack t")
				.append(" left join station sf on t.sendstationid = sf.id")
				.append(" left join station st on t.tostationid = st.id")
				.append(" left join digitaldictionary d on d.tablename = 'pack' and d.columnname = 'status'")
				.append(" left join digitaldictionarydetail dd on dd.digitaldictionaryid = d.id and dd.code = t.status")
				.append(" left join schedule s on s.id = t.scheduleid")
				.append(" left join organization org on t.balanceorgid = org.id")
				.append(" left join vehicle v on t.vehicleid = v.id")
				.append(" left join unit vu on v.unitid = vu.id")
				.append(" left join userinfo ui on t.signby = ui.id")
				.append(" left join userinfo ub on t.balanceby = ub.id")
				.append(" where t.packtype = '0' and t.status in ('1', '2') ");
		sb.append(PropertyFilter.toJpql(propertyFilter, true));
		sb.append(" order by t.departdate");
		Query query = em.createNativeQuery(sb.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilter);
		return query.getResultList();
	}

	//根据ID值串查询行包信息
	public List<Pack> getList(String packids) {
		String sql = "select t from Pack t where t.id in ("+packids+")";
		Query query = em.createQuery(sql);
		return query.getResultList();
	}

}
