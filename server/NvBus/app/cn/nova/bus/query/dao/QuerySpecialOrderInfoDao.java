package cn.nova.bus.query.dao;

import java.util.List;
import java.util.Date;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.report.param.Reportparam;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

@SuppressWarnings("rawtypes")
public class QuerySpecialOrderInfoDao extends EntityManagerDaoSurport {
	/**
	 * 特殊订单退款明细
	 * @param propertyFilterList
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> querySpecialOrderInfo(List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = new StringBuilder(" select so.sellorgname, ")
		    .append(" so.orderno, ")
		    .append(" so.departdate, ")
		    .append(" so.price, ")
		    .append(" so.insurefee, ")
		    .append(" decode(so.status, 0, '正常', 1, '已退', 2, '已废', 3, '已检', '异常') status, ")
		    .append(" so.returnfee, ")
		    .append(" so.returncause, ")
		    .append(" so.returnperson, ")
		    .append(" so.returntime, ")
		    .append(" so.remark ")
		    .append(" from specialorderinfo so,organization t ")
		    .append(" where 1=1 and so.sellorgcode = t.code ");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}
	}

