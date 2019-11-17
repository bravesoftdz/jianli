package cn.nova.bus.checkticket.dao;

import java.util.Date;
import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

@SuppressWarnings("rawtypes")
public class OutstationupmoneyDao extends EntityManagerDaoSurport {

	@SuppressWarnings("unchecked")
	public List<Object> query(List<PropertyFilter> propertyFilters) {
		StringBuffer sb = new StringBuffer(
				"select t.id,to_char(to_date(t.departmonth,'yyyyMM'),'yyyy-MM') departmonth,t.price,t.agentfee,t.waterfee,t.stopfee,t.violationfee,t.otherfee1,t.otherfee2,t.balancemoney,t.operatorid,t.orgid,t.createtime,t.createby,t.updatetime,t.updateby	,t.routename,org.name as orgname,u.name as operatorname,to_date(t.departmonth,'yyyyMM') as departmonthdate from Outstationupmoney t,Organization org , Userinfo u where org.id=t.orgid and u.id=t.operatorid");
		sb.append(PropertyFilter.toJpql(propertyFilters, true));
		Query query = getEntityManager().createNativeQuery(sb.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilters);
		List<Object> list = query.getResultList();
		return list;
	}

	public List<Object> qryVehicledriverreport(Date departdate,
			long vehiclereportid) {
		StringBuilder sql = new StringBuilder("select vr.driverid,drivername,ddrivinglicenseres,")
		.append(" dqualificationres,vdriverlicenseres,vworknores,vroadnores,")
		.append(" dworknores,vnotenum,driversign,classmember,")
		.append(" dispatcher,stewardname")
		.append("  from Vehicledriverreport vr")
		.append(" where vr.departdate=:departdate  and vr.vehiclereportid=:vehiclereportid");		
		Query query = em.createNativeQuery(sql.toString());
		query.setParameter("departdate", departdate);
		query.setParameter("vehiclereportid", vehiclereportid);
		return query.getResultList();
	}
	
	public List<Object> qryArriveStationCheck(Date departdate,long vehicleid){
		//查询进站检查表 进行校验。现已不用，改为使用报到表数据进行校验
//		StringBuilder sql = new StringBuilder("select t.checkdriver1id,t.checkdriver2id,t.checkstewardid ")
//		.append(" from ArriveStationCheck t where t.vehicleid =:vehicleid and t.arrivetime>:departdate");	
		StringBuilder sql = new StringBuilder("select t.driver1id checkdriver1id,t.driver2id checkdriver2id,t.steward1id checkstewardid ")
				.append(" from vehiclereport t where t.vehicleid =:vehicleid and t.departdate=:departdate");	
		Query query = em.createNativeQuery(sql.toString());
		query.setParameter("vehicleid", vehicleid);
		//and to_date(t.arrivetime,'yyyy-MM-dd')=to_date("+departdate+",'yyyy-MM-dd')
		query.setParameter("departdate", departdate);
		return query.getResultList();
	}

}
