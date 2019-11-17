package cn.nova.bus.checkticket.dao;

import java.math.BigDecimal;
import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.checkticket.model.Departinvoicesdetail;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

@SuppressWarnings("rawtypes")
public class DepartinvoicesdetailDao extends EntityManagerDaoSurport {

	@SuppressWarnings("unchecked")
	public List<Object> query(List<PropertyFilter> propertyFilters) {
		StringBuffer sql = new StringBuffer(
				"select t, st.name as fromstationname, si.name as reachstationname,")
				.append(" sc.code as schedulename, us.name as createname, use.name as updatename, ")
				.append(" tt.name as typename, dic.value as statusname from Departinvoicesdetail t, ")
				.append(" Departinvoices d, Station st, Station si, Schedule sc, Userinfo us, Userinfo use, ")
				.append(" Tickettype tt, Digitaldictionary dig, Digitaldictionarydetail dic ")
				.append(" where t.departinvoices.id=d.id and t.fromstationid=st.id and t.reachstationid=si.id and ")
				.append(" t.scheduleid=sc.id and t.createby=us.id and t.updateby=use.id and t.tickettype=tt.code and ")
				.append(" dig.tablename='departinvoices'  and dig.columnname='status' and dic.digitaldictionary.id=dig.id ")
				.append("  and dic.code=t.status ");
		sql.append(PropertyFilter.toJpql(propertyFilters, true));
		Query query = getEntityManager().createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilters);
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	public List<Departinvoicesdetail> getResult(Long departinvoicesid) {
		StringBuffer sql = new StringBuffer(
				"select t from Departinvoicesdetail t ")
				.append("  where t.departinvoices.id=:departinvoicesid");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("departinvoicesid", departinvoicesid);
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	public List<Object> qrydeailBydepartinvoicesid(long departinvoicesid) {
			
//		StringBuffer sql = new StringBuffer(
//					"select t.id as id,t.issupply as issupply,t.departinvoices.id as pid,t.fromstationid as fromstationid,t.reachstationid as reachstationid,t.tickettype as tickettype,t.distance as distance,t.price as price,t.ticketnum as ticketnum,t.totalamount as totalamount, ")
//					.append(" t.stationservicefee as stationservicefee,t.fueladditionfee as fueladditionfee,t.othterfee as othterfee,t.agentfee as agentfee,t.balanceamount as balanceamount,t.scheduleid as scheduleid, ")
//					.append(" t.departdate as departdate,t.departtime as departtime,t.createtime as createtime,t.createby as createby,t.updatetime as updatetime,t.updateby as updateby,0 as balanceprice, ")
//					.append(" st.name as fromstationname,si.name as reachstationname,sc.code as schedulename,us.name as createname,use.name as updatename,tt.name as typename ")
//					.append(" from Departinvoicesdetail t,Station st,Station si,Schedule sc,Userinfo us,Userinfo use,Tickettype tt ")
//					.append(" where 1 = 1 and t.fromstationid = st.id and t.reachstationid = si.id and t.scheduleid = sc.id and t.createby = us.id ")
//					.append(" and t.updateby = use.id and t.tickettype = tt.code ")
//					.append(" and t.departinvoices.id=")
//					.append(departinvoicesid);
		
		StringBuffer sql = new StringBuffer(
		" select ts.id,0 as isselect,ts.departdate,ts.ticketno,ts.price,ts.seatno,ts.departinvoices.id as departinvoicesid,s.code as schedulename,ste.name as reachstationname,tt.name as typename,stt.name as fromstationname ")
		.append(" ,ts.departstationid as fromstationid,ts.reachstationid as reachstationid,ts.tickettype as tickettype")
		.append(" from Ticketsell ts,Departinvoices ds,Scheduleplan sp,Schedule s,Tickettype tt,Station stt, Station ste ")
		.append(" where 1 = 1 and ts.departinvoices.id=ds.id and ts.scheduleplanid = sp.id and sp.scheduleid = s.id and ts.tickettype = tt.code ")
		.append("  and ts.departstationid = stt.id and ts.reachstationid = ste.id ")
		.append(" and ds.id=")
		.append(departinvoicesid);

			Query query = getEntityManager().createQuery(sql.toString());

			return query.getResultList();
		

	}

	public long getTicketnum(long departinvoicesid) {
		StringBuffer sql = new StringBuffer(
				"select nvl(sum(t.ticketnum),0) from Departinvoicesdetail t where t.departinvoices.id=");
		sql.append(departinvoicesid);
		Query query = getEntityManager().createQuery(sql.toString());
		if (query.getResultList().isEmpty()) {
			return (long) 0;
		}
		Long sumticketnum = (Long) query.getSingleResult();

		return sumticketnum;
	}

	public BigDecimal getTotalamount(long departinvoicesid) {
		StringBuffer sql = new StringBuffer(
				"select nvl(sum(t.totalamount),0) from Departinvoicesdetail t where t.departinvoices.id=");
		sql.append(departinvoicesid);
		Query query = getEntityManager().createQuery(sql.toString());
		if (query.getResultList().isEmpty()) {
			return new BigDecimal(0);
		}
		return (BigDecimal) query.getSingleResult();
	}

	public BigDecimal getAgentfee(long departinvoicesid) {
		StringBuffer sql = new StringBuffer(
				"select nvl(sum(t.agentfee),0) from Departinvoicesdetail t where t.departinvoices.id=");
		sql.append(departinvoicesid);
		Query query = getEntityManager().createQuery(sql.toString());
		if (query.getResultList().isEmpty()) {
			return new BigDecimal(0);
		}
		return (BigDecimal) query.getSingleResult();
	}

	public BigDecimal getStationfee(long departinvoicesid) {
		StringBuffer sql = new StringBuffer(
				"select nvl(sum(t.stationservicefee),0) from Departinvoicesdetail t where t.departinvoices.id=");
		sql.append(departinvoicesid);
		Query query = getEntityManager().createQuery(sql.toString());
		if (query.getResultList().isEmpty()) {
			return new BigDecimal(0);
		}
		return (BigDecimal) query.getSingleResult();
	}

	public BigDecimal getBalanceamount(Long departinvoicesid) {
		StringBuffer sql = new StringBuffer(
				"select nvl(sum(t.balanceamount),0) from Departinvoicesdetail t where t.departinvoices.id=");
		sql.append(departinvoicesid);
		Query query = getEntityManager().createQuery(sql.toString());
		if (query.getResultList().isEmpty()) {
			return new BigDecimal(0);
		}
		return (BigDecimal) query.getSingleResult();
	}

	public BigDecimal getOtherfee(Long departinvoicesid) {
		StringBuffer sql = new StringBuffer(
				"select nvl(sum(t.othterfee),0) from Departinvoicesdetail t where t.departinvoices.id=");
		sql.append(departinvoicesid);
		Query query = getEntityManager().createQuery(sql.toString());
		if (query.getResultList().isEmpty()) {
			return new BigDecimal(0);
		}
		return (BigDecimal) query.getSingleResult();
	}

	public BigDecimal getFueladditionfee(Long departinvoicesid) {
		StringBuffer sql = new StringBuffer(
				"select nvl(sum(t.fueladditionfee),0) from Departinvoicesdetail t where t.departinvoices.id=");
		sql.append(departinvoicesid);
		Query query = getEntityManager().createQuery(sql.toString());
		if (query.getResultList().isEmpty()) {
			return new BigDecimal(0);
		}
		return (BigDecimal) query.getSingleResult();
	}

}
