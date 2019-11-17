package cn.nova.bus.dispatch.dao;



import java.util.Date;
import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.base.model.Vehicle;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.price.model.Schedulestatus;
import cn.nova.bus.price.model.Schedulevehiclepeopleplan;



@SuppressWarnings("rawtypes")
public class ScheduleReportDao extends EntityManagerDaoSurport {
	
	//参数flag 为0时未报到班次 为1时已报到班次
	@SuppressWarnings("unchecked")
	public List<Object> Query(String flag,long departstationId,Date departDate,String vehicleno){
		Query query =null;
		StringBuffer sql = new StringBuffer("select ddz.name as ddzName,xl.name as routename ");
		if (flag.equals("0")){
			sql.append(",sfz.name as sfzname,bc.code ");
			sql.append(",zdz.name as zdzname ");
			sql.append(",cx.name as cxname,trim(zt.departtime)as departtime,cl.vehicleno,cldw.name as dwname,jh.seatnum,(jh.seatnum-jh.soldeatnum) as yzs ");
			sql.append(",zt.ticketentrance as jpk,zt.buspark,jsy1.name as jsy1 ");
			sql.append(",jsy2.name as jsy2 ");
			sql.append(",jsy3.name as jsy3 ");
			sql.append(",jsy4.name as jsy4 ");
			sql.append(",cwy1.name as cwy1 ");
			sql.append(",cwy2.name as cwy2 ");
			sql.append(",jh.scheduleid,jh.id as planscheduleid,jh.orgid as czorgid,zt.orgid as bdorgid,cl.id as vehicleid ");
			sql.append(",zt.departdate ");
			sql.append(" from  Schedulestatus zt,Scheduleplan jh,station ddz,station sfz,station zdz ");
			sql.append("  ,Schedulevehiclepeopleplan bcjh left join Vehicle cl on  bcjh.planvehicleid=cl.id  ");
			sql.append("  left join Unit cldw on cldw.id = bcjh.planunitid ");
			sql.append(" left join Driver jsy1 on jsy1.id = bcjh.plandriver1id ");
			sql.append(" left join Driver jsy2 on jsy2.id = bcjh.plandriver2id ");
			sql.append(" left join Driver jsy3 on jsy3.id = bcjh.plandriver3id ");
			sql.append(" left join Driver jsy4 on jsy4.id = bcjh.plandriver4id ");
			sql.append(" left join Steward cwy1 on cwy1.id = bcjh.plansteward1id ");
			sql.append(" left join Steward cwy2 on cwy2.id = bcjh.plansteward2id ");
			sql.append("  ,schedule bc,route xl,Vehicletype cx ");
			sql.append(" where zt.scheduleplanid = jh.id and zt.departdate=jh.departdate ");
			sql.append(" and zt.scheduleid=bc.id and bc.routeid=xl.id ");
			sql.append(" and jh.startstationid=sfz.id and jh.endstationid=zdz.id ");
			sql.append(" and zt.scheduleplanid=bcjh.scheduleplanid and zt.departdate=bcjh.departdate and bcjh.orderno=0 ");
			sql.append(" and bcjh.planvehicletypeid=cx.id  and zt.departstationid=ddz.id ");			
			sql.append(" and zt.isreported = 0");			
			sql.append(" and zt.departdate=:departdate");			
			sql.append(" and zt.departstationId=:departstationId");
			if (!vehicleno.equals("")){
				sql.append( " and cl.vehicleno like :vehicleno ");
			}
			sql.append(" order by zt.departtime asc ");
			
		}else if (flag.equals("1")){
			sql.append(",sfz.name as sfzname,bc.code ");
			sql.append(",zdz.name as zdzname ");
			sql.append(",cx.name as cxname,trim(zt.departtime)as departtime,cl.vehicleno,bdcl.vehicleno as bdvehicleno,clbd.reporttime,cldw.name as dwname,jh.seatnum,(jh.seatnum-jh.soldeatnum) as yzs ");
			sql.append(",zt.ticketentrance as jpk,zt.buspark,jsy1.name as jsy1 ");
			sql.append(",bdjsy1.name as bdjsy1,jsy2.name as jsy2 ");
			sql.append(",bdjsy2.name as bdjsy2,jsy3.name as jsy3 ");
			sql.append(",bdjsy3.name as bdjsy3,jsy4.name as jsy4,bdjsy4.name as bdjsy4 ");
			sql.append(",cwy1.name as cwy1,bdcwy1.name as bdcwy1 ");
			sql.append(",cwy2.name as cwy2,bdcwy2.name as bdcwy2 ");
//			sql.append(",jh.scheduleid,jh.id as planscheduleid,jh.orgid as czorgid,zt.orgid as bdorgid,cl.id as vehicleid ");
//			sql.append(",zt.departdate ");
			sql.append(" from  Schedulestatus zt,Scheduleplan jh,station ddz,station sfz,station zdz ");
			sql.append("  ,Schedulevehiclepeopleplan bcjh left join Vehicle cl on  bcjh.planvehicleid=cl.id  ");
			sql.append("  left join Unit cldw on cldw.id = bcjh.planunitid ");
			sql.append(" left join Driver jsy1 on jsy1.id = bcjh.plandriver1id ");
			sql.append(" left join Driver jsy2 on jsy2.id = bcjh.plandriver2id ");
			sql.append(" left join Driver jsy3 on jsy3.id = bcjh.plandriver3id ");
			sql.append(" left join Driver jsy4 on jsy4.id = bcjh.plandriver4id ");
			sql.append(" left join Steward cwy1 on cwy1.id = bcjh.plansteward1id ");
			sql.append(" left join Steward cwy2 on cwy2.id = bcjh.plansteward2id ");
			sql.append("  ,schedule bc,route xl,Vehicletype cx ");
			sql.append(" ,vehiclereport clbd left join Driver bdjsy1 on bdjsy1.id = clbd.driver1id ");
			sql.append(" left join Driver bdjsy2 on bdjsy2.id = clbd.driver2id ");
			sql.append(" left join Driver bdjsy3 on bdjsy3.id = clbd.driver3id ");
			sql.append(" left join Driver bdjsy4 on bdjsy4.id = clbd.driver4id ");
			sql.append(" left join Steward bdcwy1 on bdcwy1.id = clbd.steward1id ");
			sql.append(" left join Steward bdcwy2 on bdcwy2.id = clbd.steward2id left join Vehicle bdcl on bdcl.id = clbd.vehicleid ");
			sql.append(" where zt.scheduleplanid = jh.id  and zt.departdate=jh.departdate and zt.scheduleplanid=clbd.scheduleplanid ");
			sql.append(" and zt.scheduleid=bc.id and bc.routeid=xl.id ");
			sql.append(" and jh.startstationid=sfz.id and jh.endstationid=zdz.id ");
			sql.append(" and zt.scheduleplanid=bcjh.scheduleplanid and zt.departdate=bcjh.departdate and bcjh.orderno=0 ");
			sql.append(" and bcjh.planvehicletypeid=cx.id  and zt.departstationid=ddz.id ");			
			sql.append(" and zt.isreported = 1");			
			sql.append(" and zt.departdate=:departdate");			
			sql.append(" and zt.departstationId=:departstationId");
			if (!vehicleno.equals("")){
				sql.append( " and cl.vehicleno like :vehicleno ");
			}
			sql.append(" order by zt.departtime asc ");
		}
		query = getEntityManager().createNativeQuery(sql.toString());		
		if (!vehicleno.equals("")){
			vehicleno = "%"+vehicleno+"%";
			query.setParameter("vehicleno", vehicleno);
		}		
		query.setParameter("departdate", departDate);
		query.setParameter("departstationId", departstationId);
		//System.out.println("scheduleReportSql="+sql.toString());
		return query.getResultList();
	}
	
	
	//通过IC卡号获取对应车辆信息	
	@SuppressWarnings("unchecked")
	public List<Vehicle> getVehicleIdbyCardNo(String cardNo){
		Query query =null;
		StringBuffer sql = new StringBuffer("select v from Vehicle v");
		sql.append(" where v.cardno=:cardNo ");
		query = getEntityManager().createQuery(sql.toString());
		query.setParameter("cardNo", cardNo);		
		//System.out.println("scheduleReportSql="+sql.toString());		
		return query.getResultList();
		
	} 
	
	
	
	//通过车辆ID 、车站Id 、发车日期 获取 班次运行计划对象
	@SuppressWarnings("unchecked")
	public List<Schedulevehiclepeopleplan> getchedulevehiclepeopleplanlist(long departstationId, long vehicleId,Date departDate){
		Query query =null;
		StringBuffer sql = new StringBuffer("select svpp from Schedulevehiclepeopleplan svpp ,Schedulestatus ss ");
		sql.append(" where svpp.scheduleplan =ss.scheduleplan and ss.isreported=0 and svpp.planvehicle.id=:vehicleId and ss.departdate=:departDate ");
		sql.append(" and ss.departstationid=:departstationId order by ss.departtime,svpp.orderno asc ");
		//System.out.println("scheduleReportSql="+sql.toString());
		query = getEntityManager().createQuery(sql.toString());
		query.setParameter("departstationId", departstationId);
		query.setParameter("vehicleId", vehicleId);
		query.setParameter("departDate", departDate);
		//System.out.println("getchedulevehiclepeopleplanlist="+sql.toString());
		return query.getResultList();
	}
	
	//通过车辆ID 、车站Id 、发车日期 获取 班次运行状态对象
	@SuppressWarnings("unchecked")
	public List<Schedulestatus> getSchedulestatuslist(long departstationId, long vehicleId,Date departDate){
		Query query =null;
		StringBuffer sql = new StringBuffer("select ss from Schedulevehiclepeopleplan svpp,Schedulestatus ss ");
		sql.append(" where svpp.scheduleplan =ss.scheduleplan and ss.isreported=0 and svpp.planvehicle.id=:vehicleId and svpp.departdate=:departDate ");
		sql.append(" and ss.departstationid=:departstationId order by ss.departtime");
		query = getEntityManager().createQuery(sql.toString());
		query.setParameter("departstationId", departstationId);
		query.setParameter("vehicleId", vehicleId);
		query.setParameter("departDate", departDate);
		System.out.println("scheduleReportSql="+sql.toString());
		return query.getResultList();
	}
	
	
}
