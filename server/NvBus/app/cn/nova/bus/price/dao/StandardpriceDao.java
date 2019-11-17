package cn.nova.bus.price.dao;

import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.price.model.Standardprice;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;
@SuppressWarnings("rawtypes")
public class StandardpriceDao extends EntityManagerDaoSurport {
	@SuppressWarnings("unchecked")
	public List<Object> query(List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = new StringBuilder(
				"select sp,s1.name as departstation, ")
		        .append(" s2.name as reachstation,v.name as vehicletype")
				.append(" from Standardprice sp,Schedule s,Station s1,Station s2,Vehicletype v")
				.append(" where sp.scheduleid=s.id and sp.vehicletypeid=v.id ")
				.append(" and sp.departstationid=s1.id and sp.reachstationid=s2.id");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		sql.append(" order by sp.vehicletypeid,")
		.append("sp.departstationid,sp.reachstationid ");
		Query query = getEntityManager().createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}
	@SuppressWarnings("unchecked")
	public List<Object> qryStandardPriceItem(List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = new StringBuilder(
				"select t.code, t.name, sd.price  from Standardprice s, ")
		.append(" Standardpriceitem sd, Ticketpriceformulaitem t")
		.append(" where s.id = sd.standardprice.id and sd.ticketpriceformulaitemid = t.id");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		Query query = getEntityManager().createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}
	
	//查询该班次循环车型
	@SuppressWarnings("unchecked")
	public List<Long> qryCycleschemesVehicletype(long scheduleid) {
		StringBuilder sql = new StringBuilder("select distinct ty.id")
		.append(" from Cycleschemesschedule c,Cycleschemesvehicle v,Vehicletype ty")
		.append(" where v.cyclescheme=c.cyclescheme and c.scheduleid=:scheduleid")
		.append(" and ty.id=v.vehicletypeid");	
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleid", scheduleid);
		return query.getResultList();
	}
	@SuppressWarnings("unchecked")
	public List<Standardprice> qryStandardPrice(long scheduleid) {
		StringBuilder sql = new StringBuilder(
				"select s from Standardprice s where s.scheduleid=:scheduleid");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleid", scheduleid);
		return query.getResultList();
	}
}
