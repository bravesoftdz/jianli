package cn.nova.bus.query.dao;

import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

@SuppressWarnings("rawtypes")
public class PriceQueryServiceDao extends EntityManagerDaoSurport{

	/**
	 * 根据发班id查询发班code
	 * @param Scheduleid
	 * @return
	 */
	
	@SuppressWarnings("unchecked")
	public String queryScheduleCode(Long Scheduleid) {
		StringBuilder sql = new StringBuilder(
				" select t.code from Schedule t  where t.id= :id");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("id", Scheduleid);
		return (String) query.getSingleResult();
	}

	/**
	 * 班次票价查询
	 * @param propertyFilterList
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> QuerySchedulePrice(
			List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = new StringBuilder(		
			"select sp.departdate,org.name as orgname,ste.name as endstationn,r.name as routename,")
		.append("s.code,s1.name as departstation,trim(ss.departtime) as departtime,")
		.append("dds.value as schedulestatus,sr.name as reachstation,")
		.append("ddt.value as seattypename,t.seatnum,t.soldeatnum,t.fullprice,")
		.append("t.halfprice,t.studentprice,t.toplimitprice,")
		.append("t.lowerlimitprice, ")
		.append("(select max(tp.price) from Ticketpriceformulaitem tpf, Ticketpriceitem tp")
		.append(" where tpf.id = tp.ticketpriceformulaitemid  and tpf.name ='站务费'")
		.append(" and tp.scheduleid=s.id and tp.ticketpriceid=t.id group by tp.scheduleid) as stationservicefee,")
		.append(" t.fueladditionfee,t.distance,t.issellable")
		.append(" from Scheduleplan sp,Schedule s,Schedulevehiclepeopleplan sv,")
		.append(" Route r, Station s1,  Schedulestatus ss,Organization org,")
		.append("Ticketprice t,Station sr,station ste,digitaldictionary ds,")
		.append("digitaldictionarydetail dds,digitaldictionary dt ,digitaldictionarydetail ddt")
		.append(" where sp.scheduleid = s.id and sp.id = sv.scheduleplanid and sp.endstationid = ste.id")
		.append(" and sv.orderno = 0 and s.routeid= r.id and ss.departstationid = s1.id")
		.append(" and sp.id = ss.scheduleplanid and ss.departstationid = org.stationid")
		.append(" and t.reachstationid=sr.id and sp.id= t.scheduleplanid and ss.departstationid=t.departstationid")
		.append(" and ds.tablename ='schedulestatus' and ds.columnname='schedulestatus'")
		.append(" and dds.digitaldictionaryid=ds.id and ss.status =  dds.code")
		.append(" and dt.tablename ='handprice' and dt.columnname='seattype'")
		.append(" and ddt.digitaldictionaryid=dt.id and t.seattype = ddt.code ");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		sql.append(" order by r.name,s.code,t.departstationid,ss.departtime ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}
}
