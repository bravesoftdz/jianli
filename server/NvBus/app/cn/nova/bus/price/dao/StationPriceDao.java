/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b>cn.nova.bus.price.dao<br/>
 * <b>文件名：</b>StationPriceDao.java<br/>
 * <b>版本信息：</b>v4.0<br/>
 * <b>日期：</b> 2013-4-25  <br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.price.dao;

import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

/**
 * <b>类描述：站点平时票价管理</b><br/>
 * <b>类名称：</b>StationPriceDao.java<br/>
 * <b>创建人：</b><a href="mailto:huanghaoze@nova.net.cn">hhz</a><br/>
 * <b>创建时间：</b>2013-4-25  <br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
@SuppressWarnings("rawtypes")
public class StationPriceDao extends EntityManagerDaoSurport  {

	/**
	 * 查询站点平时票价
	 * @param propertyFilterList
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> qryStationPrice(List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = new StringBuilder(
				"select o.name as orgname,dt.name as departstationname,rt.name as reachstationname,sp.departstationid,sp.reachstationid,")
		.append("sp.id,o.id as orgid,Trim(sp.fullprice) as fullprice,Trim(sp.halfprice) as halfprice,Trim(sp.studentprice) as studentprice,")
		.append("cu.name as createname,up.name as updatename,sp.createtime,sp.updatetime,sp.createby ")
		.append(" from Stationprice sp,Organization o,Station dt,Station rt,Userinfo cu,Userinfo up")
		.append(" where sp.orgid=o.id and sp.departstationid=dt.id and sp.reachstationid = rt.id ")
		.append(" and sp.createby=cu.id and sp.updateby=up.id");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		sql.append(" order by o.name ,dt.name ");
		Query query = getEntityManager().createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}
}
