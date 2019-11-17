package cn.nova.bus.pack.dao;

import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.pack.model.Packfee;
import cn.nova.bus.pack.model.Packfeetype;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

@SuppressWarnings("rawtypes")
public class PackfeeDao extends EntityManagerDaoSurport{
	
	/**根据条件查询收费标准设置
	 * @param propertyFilters
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> query(List<PropertyFilter> propertyFilters){
		StringBuffer sb = new StringBuffer("select p,o.name, pt.name as pricetype from Packfee p,Organization o," +
				" Packfeetype pt  where o.id=p.orgid and p.packfeetypeid=pt.id ");
		sb.append(PropertyFilter.toJpql(propertyFilters,true));
		sb.append(" order by p.fromdistance,p.todistance,p.fromweight,p.toweight");
		
		Query query = getEntityManager().createQuery(sb.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilters);
		
		return query.getResultList();
	}
	
	@SuppressWarnings("unchecked")
	public List<Object> query(){
		StringBuffer sb = new StringBuffer("select p,o.name, pt.name as pricetype from Packfee p,Organization o," +
				" Packfeetype pt  where o.id=p.orgid and p.pricetypeid=pt.id ");
		Query query = getEntityManager().createQuery(sb.toString());	
		return query.getResultList();
	}
	
	
	/**
	 * 判断公里范围+重量范围不能重复
	 * @param packfee
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public boolean isExistformDistanceWeight(
		Packfee packfee) {
		StringBuffer sql = new StringBuffer();
		sql.append("select p.id, p.packfeetypeid from Packfee p where p.orgid=:orgid and p.packfeetypeid=:packfeetypeid and ((")
				.append(" (p.fromdistance!=:fromdistance or p.todistance!=:todistance) and (")
				.append(" (p.fromdistance>=:fromdistance and p.fromdistance<=:todistance)")
				.append(" or (p.fromdistance<=:fromdistance and p.todistance>=:todistance)")
				.append(" or (p.fromdistance<=:fromdistance and p.todistance>=:fromdistance)")
				
				//.append(" or (p.fromdistance>=:fromdistance and p.todistance>=:todistance)")
				
				.append(" or (p.fromdistance>=:fromdistance and p.todistance<=:todistance)))")	
				.append(" or ((p.fromdistance=:fromdistance and p.todistance=:todistance) and(")
				.append(" (p.fromweight>=:fromweight and p.fromweight<=:toweight)")
				.append(" or (p.fromweight<=:fromweight and p.toweight>=:toweight)")
				.append(" or (p.fromweight<=:fromweight and p.toweight>=:fromweight)")
				
				//.append(" or (p.fromweight<=:fromweight and p.toweight>=:toweight)")
				
				.append(" or (p.fromweight>=:fromweight and p.toweight<=:toweight))")
				.append("))");
		if (packfee.getId()!=0){
			sql.append(" and p.id!="+packfee.getId());
		}
		
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("fromdistance", packfee.getFromdistance());
		query.setParameter("todistance", packfee.getTodistance());
		query.setParameter("fromweight", packfee.getFromweight());
		query.setParameter("toweight", packfee.getToweight());
		query.setParameter("orgid", packfee.getOrgid());
		query.setParameter("packfeetypeid", packfee.getPackfeetypeid());

		List<Object> objlist = query.getResultList();
		return objlist != null && objlist.size() > 0 ? true : false;
		
	}
}
