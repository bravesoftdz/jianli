package cn.nova.bus.base.dao;

import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.base.model.Ticketoutletsunsellstation;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

@SuppressWarnings("rawtypes")
public class TicketoutletsunsellstationDao extends EntityManagerDaoSurport {

	@SuppressWarnings("unchecked")
	public List<Object> query(List<PropertyFilter> propertyFilterList) {
		StringBuffer sql = new StringBuffer();
		sql.append("select t.createtime, t.updatetime, t.enddate, ")
		   .append(" t.startdate, t.id, ti.name as ticketname, ")
		   .append(" us.name as createname, use.name as updatename, dic.value , ")
		   .append(" case t.type when '0' then ('全部班次') ")
		   .append(" when '1' then (select r.name from Route r where t.typeid=r.id ) ")
		   .append(" when '2' then (select s.code from Schedule s where t.typeid=s.id) end as typename,st.name as stationname ")
		    .append(" from Ticketoutletsunsellstation t left join  Station   st on t.stationid = st.id ,")
		   .append(" Ticketoutlets ti,")
		   .append(" Userinfo us, Userinfo use, Digitaldictionary dig, Digitaldictionarydetail dic ")
		   .append(" where t.ticketoutletsid=ti.id and t.createby=us.id and t.updateby=use.id ")
		   .append(" and dig.tablename='sellschedule' and dig.columnname='type' ")
		   .append(" and dic.digitaldictionaryid=dig.id and dic.code=t.type ")
		   //.append(" and t.stationid=st.id")/
		   ;
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();

	}

	public boolean isExist(Ticketoutletsunsellstation ticketoutletsunsellstation) {
		StringBuffer sql = new StringBuffer(
				"select t from Ticketoutletsunsellstation t ");
		if (ticketoutletsunsellstation.getType().equals("0")) {
			sql.append(" where t.type=0 and t.typeid=0");
		} else if (ticketoutletsunsellstation.getType().equals("1")) {
			sql.append(", Route r where t.type=1 and t.typeid=r.id and r.id=");
			sql.append(ticketoutletsunsellstation.getTypeid());
		} else if (ticketoutletsunsellstation.getType().equals("2")) {
			sql.append(", Schedule s where t.type=2 and t.typeid=s.id and s.id=");
			sql.append(ticketoutletsunsellstation.getTypeid());
		}else if(ticketoutletsunsellstation.getType().equals("3")){
			sql.append(", Schedule s,Schedulestop st where t.type=3 and t.typeid=s.id and s.id = st.schedule.id and st.id=");
			sql.append(ticketoutletsunsellstation.getTypeid());
		}
		sql.append(" and t.ticketoutletsid=").append(ticketoutletsunsellstation.getTicketoutletsid())
		   .append(" and t.stationid=").append(ticketoutletsunsellstation.getStationid())
		   .append(" and not (t.startdate>:enddate")
		   .append("          or t.enddate<:startdate )");
		if(ticketoutletsunsellstation.getId()>0){
			sql.append(" and t.id<>").append(ticketoutletsunsellstation.getId());
		}
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("enddate", ticketoutletsunsellstation.getEnddate());
		query.setParameter("startdate", ticketoutletsunsellstation.getStartdate());
		List list = query.getResultList();
		if (list.isEmpty()) {
			return false;
		}
		return true;
	}

	public String getValue(Long ticketoutletid, String type, Long typeid,
			Long stationid) {
		StringBuffer sql = new StringBuffer(
				"select t from Ticketoutletsunsellstation t ");
		if (type.equals("0")) {
			sql.append(" where t.type=0 and t.typeid=0");
		} else if (type.equals("1")) {
			sql.append(", Route r where t.type=1 and t.typeid=r.id and r.id=");
			sql.append(typeid);
		} else if (type.equals("2")) {
			sql.append(", Schedule s where t.type=2 and t.typeid=s.id and s.id=");
			sql.append(typeid);
		}
		sql.append(" and t.ticketoutletsid=");
		sql.append(ticketoutletid);
		Query query = getEntityManager().createQuery(sql.toString());
		return (String) query.getSingleResult();
	}

}
