/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b>cn.nova.bus.balance.dao<br/>
 * <b>文件名：</b>Orgdayneedbalancedao.java<br/>
 * <b>版本信息：</b>0.1<br/>
 * <b>日期：</b> 2011-7-13 下午03:24:55 <br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.balance.dao;

import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

/**
 * <b>类描述：</b> <b>类名称：</b><br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2011-7-13 下午03:24:55 <br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
@SuppressWarnings("rawtypes")
public class Orgdayneedbalancedao extends EntityManagerDaoSurport {

	@SuppressWarnings("unchecked")
	public List<Object> query(List<PropertyFilter> propertyfilter) {
		StringBuffer sql = new StringBuffer("select t, o.name as orgname, ");
		sql.append(" b.balanceno as balanceno, u.name as createname, us.name as updatename ");
		sql.append(" from Orgdayneedbalance t, Organization o, Balance b, Userinfo u, Userinfo us ");
		sql.append(" where t.orgid=o.id and t.balanceid=b.id and t.createby=u.id and t.updateby=us.id ");
		sql.append(PropertyFilter.toJpql(propertyfilter, true));
		Query query = getEntityManager().createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyfilter);
		return query.getResultList();
	}

}
