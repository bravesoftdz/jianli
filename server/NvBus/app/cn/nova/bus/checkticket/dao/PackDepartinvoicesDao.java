package cn.nova.bus.checkticket.dao;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.persistence.Query;

import cn.nova.bus.base.model.Ticketoutlets;
import cn.nova.bus.checkticket.model.Departinvoices;
import cn.nova.bus.checkticket.model.Departinvoicesdeductdetail;
import cn.nova.bus.checkticket.model.Departinvoicesdetail;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.sale.model.Ticketsell;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

@SuppressWarnings("rawtypes")
public class PackDepartinvoicesDao extends EntityManagerDaoSurport {

	@SuppressWarnings("unchecked")
	public List<Object> query(List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = new StringBuilder(
				" select t.id,t.departinvoicesno,t.scheduleplanid,t.departdate,t.scheduleid,trim(t.departtime) as departtime,t.vehicleid,t.reportid,t.printorgid,t.printip, ")
		.append(" t.printby,t.printtime,t.pieces,t.shipprice,t.packfee,t.handfee,t.custodial,t.transitfee,t.insuredamount,t.insurancefee, ")
		.append(" t.deliveryfee,t.otherfee,t.packprice,t.servicefee,t.totalfee,t.balanceamount,t.cancelstationid,t.cancelby,t.canceltime, ")
		.append(" t.status,t.packbalanceid,t.printway,t.datatype,t.createtime,t.createby,t.updatetime,t.updateby, ")
		.append(" sc.code as schedulename,dic.value as statusname,v.vehicleno as vehiclename,ve.vehicleno as reportname, ")		
		.append(" o.name as orgname,u.name as printname,use.name as createname,ui.name as updatename,ca.name as cancelname,cs.name as cancelstationname, ")
				.append(" ro.name as routename,son.name as endstationname,sp.seatnum,unit.name as unitname,dicprint.value as printwayname,dicdata.value as datatypename,vt.name as vehicletypename ")
				.append(" ,sde.name as startstationname")
				.append(" from Packdepartinvoices t left join PackBalance ba on t.packbalanceid=ba.id  left join Userinfo ca on t.cancelby = ca.id ")
				.append(" left join Station cs on t.cancelstationid = cs.id, Scheduleplan sp, Schedule sc,Route ro, Vehicle v, Vehiclereport vr, Organization o, Userinfo u, Unit unit, Userinfo use, Userinfo ui, Vehicle ve, Digitaldictionary dig, Digitaldictionarydetail dic, Station son ")
				.append(" ,Digitaldictionary digprint,Digitaldictionarydetail dicprint,Digitaldictionary digdata,Digitaldictionarydetail dicdata,Vehicletype vt,Station sde ")
				.append(" where t.scheduleplanid = sp.id and t.scheduleid = sc.id and t.vehicleid = v.id and t.reportid = vr.id ")
				.append(" and vr.vehicleid = ve.id and t.printorgid = o.id and t.printby = u.id and t.createby = use.id and t.updateby = ui.id ")
				.append(" and dig.tablename = 'packdepartinvoices' and dig.columnname = 'status' and dic.digitaldictionaryid = dig.id and dic.code = t.status ")
				.append("  and sp.endstationid = son.id and v.unitid = unit.id and sc.routeid = ro.id ")
				.append(" and digprint.tablename = 'packdepartinvoices' and digprint.columnname = 'printway' and dicprint.digitaldictionaryid = digprint.id and dicprint.code = t.printway  ")
				.append(" and digdata.tablename = 'packdepartinvoices' and digdata.columnname = 'datatype' and dicdata.digitaldictionaryid = digdata.id and dicdata.code = t.datatype ")
				.append(" and v.vehicletypeid = vt.id and sp.startstationid = sde.id");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}
	
	public List<Object> qryDepartDetail(List<PropertyFilter> propertyFilterList) {
		StringBuilder sql=new StringBuilder(
			" select fs.name as fromstation,ts.name as reachstation,pdd.pieces,pdd.shipprice,pdd.packfee,pdd.handfee,pdd.custodial,pdd.transitfee, ")
		    .append(" pdd.insuredamount,pdd.insurancefee,pdd.deliveryfee,pdd.otherfee,pdd.packprice,pdd.servicefee,pdd.totalfee,pdd.balanceamount ")
		    .append(" from packdepartinvoicesdetail pdd,station fs,station ts ")
		    .append(" where fs.id = pdd.sendstationid and ts.id = pdd.tostationid ");
		sql.append(PropertyFilter.toJpql(propertyFilterList,true));
		Query query=em.createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}
	
	public List<Object> FindPackDepNum(Date departdate,
			long scheduleplanid, long scheduleid) {
	    StringBuilder sql = new StringBuilder();
	    sql.append(" select sum(tt.yesfaban) as yesfaban,sum(tt.nofaban) as nofaban from ")
	    .append(" (select count(p.id) as yesfaban,0 as nofaban from pack p,packdepartinvoices pd,packdepartinvoicespack pdp ")
	    .append(" where p.id=pdp.packid and pd.id=pdp.packdepartinvoicesid and pd.departdate=:departdate and pd.scheduleid=:scheduleid and pd.scheduleplanid=:scheduleplanid ")		
	    .append(" union all ")
	    .append(" select 0 as yesfaban,count(p.id) nofaban from pack p,scheduleplan sp,schedule s ")
	    .append(" where p.scheduleid=s.id and sp.scheduleid=s.id and p.id not in (select pdp.packid from packdepartinvoicespack pdp) and  p.status='1' and p.departdate=:departdate and s.id=:scheduleid and sp.id=:scheduleplanid ")	    
	    .append(" )tt ");
	    Query query = em.createNativeQuery(sql.toString());
	    query.setParameter("departdate", departdate);
	    query.setParameter("scheduleid", scheduleid);
	    query.setParameter("scheduleplanid", scheduleplanid);
	    return query.getResultList();	
	}
}
