/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b>cn.nova.bus.balance.dao<br/>
 * <b>文件名：</b>Orgdayneedbalancedetaildao.java<br/>
 * <b>版本信息：</b>0.1<br/>
 * <b>日期：</b> 2011-7-14 上午09:00:16 <br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.balance.dao;

import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

/**
 * <b>类描述：</b><br/>
 * <b>类名称：</b>Orgdayneedbalancedetaildao.java<br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2011-7-14 上午09:00:16 <br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
@SuppressWarnings("rawtypes")
public class Orgdayneedbalancedetaildao extends EntityManagerDaoSurport {

	@SuppressWarnings("unchecked")
	public List<Object> query(List<PropertyFilter> propertyfilter) {
		StringBuffer sql = new StringBuffer("select t, o.name as orgname, ");
		sql.append(" b.balanceno as balanceno, u.name as createname, us.name as updatename, ");
		sql.append(" org.name as otherorgname from Orgdayneedbalancedetail t, Orgdayneedbalance od, ");
		sql.append(" Organization o, Balance b, Userinfo u, Userinfo us, Organization org ");
		sql.append(" where t.orgid=o.id and t.balanceid=b.id and t.createby=u.id and t.updateby=us.id and ");
		sql.append(" t.orgdayneedbalanceid=od.id and t.otherorgid=org.id ");
		sql.append(PropertyFilter.toJpql(propertyfilter, true));
		Query query = getEntityManager().createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyfilter);
		return query.getResultList();
	}

}
