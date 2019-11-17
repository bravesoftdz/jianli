package cn.nova.bus.checkticket.dao;

import java.math.BigDecimal;
import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

@SuppressWarnings("rawtypes")
public class DepartinvoicesotherdetailDao extends EntityManagerDaoSurport {

	@SuppressWarnings("unchecked")
	public List<Object> query(List<PropertyFilter> propertyFilters) {
		StringBuffer sql = new StringBuffer(
				"select t.id,t.othterfee,t.createby, t.price as price,t.agentfee,(t.balanceamount) as balanceamount,t.departdate,trim(t.departtime),t.ticketnum,t.balanceprice,t.balanceamount,t.stationservicefee,t.totalamount,s.name as fromstationname, st.name as reachstationname,")
		.append(" tt.name as ticketname, sc.id as scheduleid,sc.code as schedulename, u.name as createname, us.name as updatename, ")
		.append(" dic.value as statusname,de.departinvoicesno as departinvoicesno,de.isoriginator,uu.name as uuname,uu.fullname as ufname,d1.name as driver1,")
		.append(" d2.name as driver2,ste.name as stewardname,usi.name as usiname,nvl((case when tt.code = 'Q' then t.ticketnum end),0) as qticketnum, ")
		.append(" nvl((case when tt.code = 'B' then t.ticketnum end),0) as bticketnum,")
		.append(" nvl((case when tt.code = 'X' then t.ticketnum  end),0) as xticketnum,")
		.append(" t.price - t.othterfee - t.agentfee - t.stationservicefee as apartprice,")
		.append(" r.name as routename,  t.distance,  sc.code,  sc.planseatnum, t.stationservicefee, tol.name as ticketoutletsname,   tol.jianpin,")
        .append(" t.totalamount,  t.stationservicefee + t.othterfee + t.agentfee as allotherfee, uui.name as uuiname,   uui.fullname as uuifullname,  vt.name as vtname, vbm.brandname, puser.name as printname,")
        .append(" d.printtime, sta.name as printstation, de.pieces,t.createtime,t.fromstationid,t.reachstationid")
        .append(" ,t.ticketnum*t.distance as totaldistance ")
        .append(" ,de.seller as seller, usi.name as sellername,v.id as vehicleid ,v.vehicleno as vehicleno,de.datafrom,de.stationfee AS stationfee , r.id routeid")
//        .append(" ,de.balanceby as balanceby, u.name as balancename")
		.append(" from Departinvoicesotherdetail t left join schedule sc on t.scheduleid=sc.id  left join Departinvoicesother de on t.departinvoicesotherid = de.id")
		.append(" left join Driver d1 on d1.id = de.driver1id  left join Driver d2 on d2.id = de.driver2id left join Steward ste on ste.id = de.steward1id")
		.append(" left join Userticketoutlets ust on ust.userinfoid = de.seller left join Departinvoices d on d.departinvoicesno=de.departinvoicesno left join Userinfo puser on puser.id=d.printby ")
		.append(" left join Organization o on o.id=d.printorgid left join Station sta on sta.id=o.stationid ")
		.append(" left join Ticketoutlets tol on tol.id = ust.ticketoutletsid  left join Route r on sc.routeid = r.id ")
		.append(" left join Unit uu on uu.id = de.balanceunitid left join Station s on  t.fromstationid = s.id ")
		.append(" left join Station st on t.reachstationid = st.id left join Tickettype tt on t.tickettypeid = tt.id")
		.append(" left join Userinfo u on t.createby = u.id left join Userinfo us on t.updateby = us.id")
		.append(" left join Userinfo usi on usi.id = de.seller left join Digitaldictionary dig on dig.tablename = 'departinvoices' and dig.columnname = 'status'")
//		.append(" LEFT JOIN Userinfo user on user.id = de.balanceby ")
		.append(" left join Digitaldictionarydetail dic on dic.digitaldictionaryid = dig.id and dic.code = t.status ")
		.append(" left join Vehicle v on de.vehicleid = v.id left join Vehiclebrandmodel vbm  on v.vehiclebrandmodelid = vbm.id")
		.append(" left join Vehicletype vt on v.vehicletypeid = vt.id left join Unit uui on uui.id = v.unitid")
		.append(" where 1=1 ");
		sql.append(PropertyFilter.toJpql(propertyFilters, true));
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilters);
		return query.getResultList();
	}

	public long getTicketnum(long departinvoicesid) {
		StringBuffer sql = new StringBuffer(
				"select nvl(sum(t.ticketnum),0) from Departinvoicesotherdetail t where t.departinvoicesotherid=");
		sql.append(departinvoicesid);
		Query query = getEntityManager().createNativeQuery(sql.toString());
		if (query.getResultList().isEmpty()) {
			return (long) 0;
		}
		BigDecimal sumticketnum = (BigDecimal) query.getSingleResult();
		
		return sumticketnum.longValue();
	}

	public BigDecimal getTotalamount(long departinvoicesid) {
		StringBuffer sql = new StringBuffer(
				"select nvl(sum(t.totalamount),0) from Departinvoicesotherdetail t where t.departinvoicesotherid=");
		sql.append(departinvoicesid);
		Query query = getEntityManager().createQuery(sql.toString());
		if (query.getResultList().isEmpty()) {
			return new BigDecimal(0);
		}
		return (BigDecimal) query.getSingleResult();
	}

	public BigDecimal getAgentfee(long departinvoicesid) {
		StringBuffer sql = new StringBuffer(
				"select nvl(sum(t.agentfee),0) from Departinvoicesotherdetail t where t.departinvoicesotherid=");
		sql.append(departinvoicesid);
		Query query = getEntityManager().createQuery(sql.toString());
		if (query.getResultList().isEmpty()) {
			return new BigDecimal(0);
		}
		return (BigDecimal) query.getSingleResult();
	}

	public BigDecimal getStationfee(long departinvoicesid) {
		StringBuffer sql = new StringBuffer(
				"select nvl(sum(t.stationservicefee),0) from Departinvoicesotherdetail t where t.departinvoicesotherid=");
		sql.append(departinvoicesid);
		Query query = getEntityManager().createQuery(sql.toString());
		if (query.getResultList().isEmpty()) {
			return new BigDecimal(0);
		}
		return (BigDecimal) query.getSingleResult();
	}

	public BigDecimal getBalanceamount(Long departinvoicesotherid) {
		StringBuffer sql = new StringBuffer(
				"select nvl(sum(t.balanceamount),0) from Departinvoicesotherdetail t where t.departinvoicesotherid=");
		sql.append(departinvoicesotherid);
		Query query = getEntityManager().createQuery(sql.toString());
		if (query.getResultList().isEmpty()) {
			return new BigDecimal(0);
		}
		return (BigDecimal) query.getSingleResult();
	}
	
	public int getDepartinvoicesOtherDistance(long scheduleid,long reachstationid){
		
		StringBuffer sql = new StringBuffer("select rs.distance from Routestop rs where rs.isactive=1 ");
		sql.append(" and rs.route.id=(select s.route.id from Schedule s where s.id=:scheduleid ")
		.append(" ) and rs.stationid=:reachstationid ");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleid", scheduleid);
		query.setParameter("reachstationid", reachstationid);
		
		if (query.getResultList().isEmpty()) {
			return 0;
		}
		
		Integer result =  (Integer)query.getSingleResult();
		
		return result;
	}

	public List<Object> queryByotherticketno(List<PropertyFilter> buildFromHttpRequest) {
		StringBuffer sql = new StringBuffer();
		sql.append("  select t.id               as id,d.id               as departinvoicesotherdetailid,")
		  .append(" t.departinvoicesno as departinvoicesno,  ")
		  .append("  t.vehicleid        as vehicleid,v.vehicleno        as vehicleno, ")
		  .append("  ss.id              as reachstationid,ss.name            as reachstationname, ")
		  .append("  t.seller seller,   usll.name as sellername, ")
		  .append("  t.scheduleid       as scheduleid,s.code             as schedulename, ")
		  .append("  t.departdate       as departdate,t.departtime       as departtime, ")
		  .append("  d.ticketnum        as ticketnum, d.totalamount       as price, ")
		  .append("  d.agentfee         as agentfee,d.stationservicefee       as stationfee,   ")     
		  .append("  d.othterfee        as othterfee,t.datafrom         as datafrom, ")
		  .append("  d.balanceamount     as balanceamount ")
		.append("  from departinvoicesother t ")
		.append("  left join departinvoicesotherdetail d on d.departinvoicesotherid = t.id ")
		.append("  left join organization o on t.orgid = o.id left join vehicle v on t.vehicleid = v.id ")
		.append("  left join unit ut on ut.id = v.unitid left join schedule s on t.scheduleid = s.id ")
		.append("  left join station ss on d.reachstationid = ss.id ")
		.append("  left join userinfo u on t.createby = u.id left join userinfo ui on t.updateby = ui.id ")
		.append("  left join userinfo usll on usll.id = t.seller ")
		.append(" where 1 = 1 ");
		sql.append(PropertyFilter.toJpql(buildFromHttpRequest, true));
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, buildFromHttpRequest);
		List list =  query.getResultList();
		if(list!=null){
			return list;
		}else{
			return null;
		}
	}

	public List qryTicketsellidByOtherdetailid(Long departinvoicesotherdetailId) {
		StringBuffer sql =new StringBuffer();
		sql.append(" select dos.ticketsellid ")
		.append(" from departinvoicesothersell dos ")
		.append(" where dos.departinvoicesotherdetailid = :departinvoicesotherdetailId");
		Query query = em.createNativeQuery(sql.toString());
		query.setParameter("departinvoicesotherdetailId", departinvoicesotherdetailId);
		List list = query.getResultList();
		return list;
	}
}
