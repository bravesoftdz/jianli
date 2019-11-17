package cn.nova.bus.query.dao;

import java.util.Date;
import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.utils.orm.PropertyFilter;

@SuppressWarnings("rawtypes")
public class SchTicketPriceQryDao extends EntityManagerDaoSurport {

	/**
	 *站务分公司各班线票价情况汇总表  
	 * @param propertyFilterList
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> queryTicketSummary(
			List<PropertyFilter> propertyFilterList) {

		String orgids = null;
		Long routeid = null;
		Date startdate = null;
		Date enddate = null;
		boolean isbyend=false;
		boolean isbyreach=false;

		if (propertyFilterList != null && propertyFilterList.size() > 0) {
			for (int t = 0; t < propertyFilterList.size(); t++) {
				if (propertyFilterList.get(t).getPropertyFullName()
						.equals("s!orgid")) {
					orgids = (String) propertyFilterList.get(t).getMatchValue();
					continue;
				}

				if (propertyFilterList.get(t).getPropertyFullName()
						.equals("p!startdate")) {
					startdate = (Date) propertyFilterList.get(t)
							.getMatchValue();
					continue;
				}
				if (propertyFilterList.get(t).getPropertyFullName()
						.equals("p!enddate")) {
					enddate = (Date) propertyFilterList.get(t).getMatchValue();
					continue;
				}
				if (propertyFilterList.get(t).getPropertyFullName()
						.equals("p!isbyend")) {
					isbyend = (Boolean) propertyFilterList.get(t).getMatchValue();
					continue;
				}
				if (propertyFilterList.get(t).getPropertyFullName()
						.equals("p!isbyreach")) {
					isbyreach = (Boolean) propertyFilterList.get(t).getMatchValue();
					continue;
				}
				if (propertyFilterList.get(t).getPropertyFullName()
						.equals("r!id")) {
					routeid = (Long) propertyFilterList.get(t).getMatchValue();
					continue;
				}
			}
		}
		
		StringBuffer sb = new StringBuffer();
		

//		sb.append(" select distinct o.name orgname,s.name stnname,r.name routename, ");
//		sb.append(" max(tp.distance) distance,max(tp.balancedistance) balancedistance, ");
//		sb.append(" vt.type,vt.grade, ");
//		sb.append(" ( ");
//		sb.append("     select dd.value from digitaldictionary d,digitaldictionarydetail dd ");
//		sb.append("     where d.id=dd.digitaldictionaryid and d.tablename='vehicletype' and d.columnname='type'  ");
//		sb.append("     and vt.type=dd.code  ");
//		sb.append(" ) typevalue, ");
//		sb.append(" ( ");
//		sb.append("     select dd.value from digitaldictionary d,digitaldictionarydetail dd ");
//		sb.append("     where d.id=dd.digitaldictionaryid and d.tablename='vehicletype' and d.columnname='grade'  ");
//		sb.append("     and vt.type=dd.code  ");
//		sb.append(" ) typevalue, ");
//		sb.append(" max(tp.toplimitprice) toplimitprice,max(tp.fueladditionfee) toplimitfuelfee, ");
//		sb.append(" max(tp.toplimitprice)+max(tp.fueladditionfee) toptoprice, ");
//		sb.append(" max(tp.fullprice) fullprice,max(tp.fueladditionfee) fullfuelfee,max(tp.fullprice)+max(tp.fueladditionfee) fulltoprice ");
//		sb.append(" from ticketprice tp ,vehicle v,vehicletype vt,vehiclereport vr,  ");
//		sb.append(" Organization o,schedule sd, route r,Station s ");
//
//		sb.append(" where tp.orgid = o.id and s.id=tp.reachstationid ");
//		sb.append(" and v.id=vr.vehicleid and vt.id=v.vehicletypeid and vr.scheduleplanid=tp.scheduleplanid ");
//		sb.append(" and vr.scheduleid = tp.scheduleid ");
//		sb.append(" and sd.id= tp.scheduleid and r.id=sd.routeid ");
//		if (isbyreach){
//			
//		}else{
//			sb.append(" and tp.reachstationid=r.endstationid ");//是否按到达站汇总
//		}
//		sb.append(" and tp.orgid in"+orgids+" ");
//		sb.append(" and tp.createtime between :startdate and :enddate ");
//		sb.append(" group by o.id,o.name,s.id,s.name,vt.type,vt.grade,r.name");
//		sb.append(" order by o.name,vt.type,vt.grade");

//		sb.append(" select o.name orgname,tp.departdate,fs.name startstname,es.name endstname, ");
		sb.append(" select o.name orgname,:startdate departdate,fs.name startstname,es.name endstname, ");
		sb.append(" max(tp.distance) distance,max(tp.balancedistance) balancedistance,   ");
		sb.append(" vt.type,vt.grade,  ");
		sb.append(" (  ");
		sb.append("    select dd.value from digitaldictionary d,digitaldictionarydetail dd  ");
		sb.append("    where d.id=dd.digitaldictionaryid and d.tablename='vehicletype' and d.columnname='type'   ");
		sb.append("    and vt.type=dd.code   ");
		sb.append(" ) typevalue,  ");
		sb.append(" (  ");
		sb.append("    select dd.value from digitaldictionary d,digitaldictionarydetail dd  ");
		sb.append("    where d.id=dd.digitaldictionaryid and d.tablename='vehicletype' and d.columnname='grade'   ");
		sb.append("    and vt.grade=dd.code   ");
		sb.append(" ) gradevalue,  ");
		sb.append(" max(tp.toplimitprice) toplimitprice,max(tp.fueladditionfee) toplimitfuelfee, ");
		sb.append(" max(tp.toplimitprice)+max(tp.fueladditionfee) toptoprice, ");
		sb.append(" max(tp.fullprice) fullprice,max(hhp.price) fullfuelfee,max(tp.fullprice)+max(tp.fueladditionfee) fulltoprice ");

		sb.append(" from ticketprice tp  ");
		sb.append(" ,schedulevehiclepeopleplan spp,vehicletype vt  ");
		sb.append(" ,schedule s,route r,Station fs ,Station es,organization o ,");
		sb.append(" (select hp.scheduleid, hp.departstationid, ");
		sb.append(" hp.reachstationid,hp.vehicletypeid,hpi.price");
		sb.append(" from handprice hp, handpriceitem hpi, ticketpriceformulaitem tpi");
		sb.append(" where hp.id = hpi.handpriceid");
		sb.append(" and hpi.tickettype = 'Q'");
		sb.append(" and tpi.name like '%燃油%'");
		sb.append(" and hpi.ticketpriceformulaitemid= tpi.id ) hhp");
		sb.append(" where  s.id=tp.scheduleid and r.id=s.routeid ");
		sb.append(" and fs.id=tp.departstationid and es.id=tp.reachstationid ");
		sb.append(" and  vt.id=spp.planvehicletypeid  and spp.scheduleplanid=tp.scheduleplanid ");
		if (isbyreach){
		
		}else{
			sb.append(" and tp.reachstationid=r.endstationid ");//是否按到达站汇总
		}
		if(routeid!=null){
			sb.append(" and r.id = "+routeid);
		}
		sb.append(" and o.id=tp.orgid and tp.orgid in"+orgids+" and fs.id=o.stationid ");
		sb.append(" and tp.departdate between :startdate and :enddate  ");
		sb.append(" and hhp.scheduleid=tp.scheduleid");
		sb.append(" and hhp.departstationid=tp.departstationid");
		sb.append(" and hhp.reachstationid=tp.reachstationid");
		sb.append(" and hhp.vehicletypeid=vt.id");
//		sb.append(" group by o.name,tp.departdate,fs.id,fs.name,es.id,es.name,vt.type,vt.grade");
//		sb.append(" order by o.name,tp.departdate,fs.name,es.name ");
		sb.append(" group by o.name,fs.id,fs.name,es.id,es.name,vt.type,vt.grade");
		sb.append(" order by o.name,fs.name,es.name ");		
		
		Query query = getEntityManager().createNativeQuery(sb.toString());

		query.setParameter("startdate", startdate);
		query.setParameter("enddate", enddate);

		List<Object> list = query.getResultList();

		return list;
	}
}
