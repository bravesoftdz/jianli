package cn.nova.bus.archive.dao;

import java.math.BigDecimal;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.persistence.Query;

import cn.nova.bus.archive.model.Driver;
import cn.nova.bus.archive.model.Driverfamilymember;
import cn.nova.bus.archive.model.Driverrewardpenalize;
import cn.nova.bus.archive.model.Driverworkexperience;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.dispatch.model.FingerCache;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.IDAO;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;
import util.CurrentUtil;

@SuppressWarnings("rawtypes")
public class DriverDao extends EntityManagerDaoSurport {

	@SuppressWarnings("unchecked")
	public List<Object> queryDriver(List<PropertyFilter> propertyFilterList,String isfinger) {
		
		if(!"3".equals(CurrentUtil.getGlobal().getOrganization().getType())){
			Iterator<PropertyFilter> it = propertyFilterList.iterator();
			while(it.hasNext()){
				PropertyFilter x = it.next();
			    if("o!id".equals(x.getPropertyFullName())){
			        it.remove();
			    }
			}
		}
		
		StringBuilder sql = new StringBuilder(
				"select d.id,d.code,d.name,d.cardno,d.idcard,d.sex,d.birthday,d.politicsstatus,")
				.append(" d.education,d.nativeplace,d.recruitmentdate,d.istemporary,d.archiveno,d.workstatus,")
				.append(" d.unitid,d.subunit,d.vehicleid,d.familyaddress,d.familyphone,d.mobilephone,")
				.append(" d.initialkm,d.issignedresponsibility,d.drivinglicense,d.drivinglicensefirstdate,")
				.append(" d.drivinglicensestartdate,d.drivinglicenseenddate,d.qualification,d.qualificationstartdate,")
				.append(" d.qualificationenddate,d.qualificationtype,d.workno,d.workstartdate,d.workenddate,d.salary,")
				.append(" d.orgid,d.isactive,d.islocaldelete, d.createtime,d.createby,d.updatetime,d.updateby,d.synccode,")
				.append(" d.qualifyvehicletype,d.routeid, d.jianpin,u.name as unitname,v.vehicleno as vehiclename,")
				.append(" uc.name as createname, up.name as updatename,r.name as routename")
				.append(" ,case when d.fingerstr1 is not null or d.fingerstr2 is not null or d.fingerstr3 is not null then 1 else 0 end as isfinger,d.sincerityauditingdate, d.continuingeducationdate, ")
				.append(" d.quanpin ")  //增加全拼查询
				.append(" from Userinfo uc,Userinfo up,Unit u  left join organization o on u.id=o.unitid,")
				.append(" Driver d LEFT JOIN route r on d.routeid=r.id LEFT JOIN vehicle v on v.id=d.vehicleid ")
				.append(" where uc.id = d.createby and up.id = d.updateby and d.unitid = u.id and d.isactive = 1 ");
		if(isfinger!=null&&isfinger.equals("True")){
			sql.append(" and (d.fingerstr1 is  not null or d.fingerstr2 is not null or d.fingerstr3 is not  null)  ");
		}else if(isfinger!=null&&isfinger.equals("False")){
			sql.append(" and  (d.fingerstr1 is   null and d.fingerstr2 is  null and d.fingerstr3 is   null)  ");
		}
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	public List<Object> queryWork(List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = new StringBuilder(
				" select  w ,u.name as createname,up.name as updatename "
						+ "from Driverworkexperience w ,Driver d,Userinfo u,Userinfo up "
						+ "where w.driverid =d.id and w.isactive = 1 and w.createby = u.id and w.updateby  = up.id ");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		Query query = getEntityManager().createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	public boolean update(String tablename, long delid, boolean isDelOne) {
		int resultnum = 0;
		String sql = "update " + tablename
				+ " t set t.isactive = 0,t.islocaldelete = 1 ";
		if (isDelOne) {
			sql = sql + " where t.id = " + delid;
		} else {
			sql = sql + " where t.driverid = " + delid;
		}
		if (tablename.equals("Driverfamilymember")) {
			resultnum = execute(sql);
		} else if (tablename.equals("Driverworkexperience")) {
			resultnum = execute(sql);
		} else if (tablename.equals("Driverrewardpenalize")) {
			resultnum = execute(sql);
		} else if (tablename.equals("Driver")) {
			sql = "update " + tablename
					+ " t set t.isactive = 0,t.islocaldelete = 1 where t.id = "
					+ delid;
			execute(sql);
		}
		if (resultnum > 0) {
			return true;
		} else {
			return false;
		}

	}

	@SuppressWarnings("unchecked")
	public boolean isExistVehicleDriver(long driverid) {
		StringBuilder sql = new StringBuilder(
				"select v from Schedulevehiclepeopleplan v where  "
						+ " v.plandriver1.id = " + driverid
						+ " or v.plandriver2.id = " + driverid
						+ " or v.plandriver3.id = " + driverid
						+ " or v.plandriver4.id = " + driverid);
		Query query = getEntityManager().createQuery(sql.toString());
		List<Object> list = query.getResultList();
		if (list.size() != 0) {
			return true;
		} else {
			return false;
		}

	}

	public long isExistDriver(String idcard, String cardno, String code,Long orgid) {
		Map<String, Object> map = new HashMap<String, Object>();
		if (idcard != null) {
			map.put("idcard", idcard);
			map.put("orgid", orgid);
		}
		if (cardno != null) {
			map.put("cardno", cardno);
		}
		if (code != null) {
			map.put("code", code);
		}
		map.put("isactive", true);
		List<Driver> driver = find(Driver.class, map);
		return driver != null && driver.size() > 0 ? driver.get(0).getId() : 0;
	}

	@SuppressWarnings("unchecked")
	public List<Object> queryFamily(List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = new StringBuilder(
				" select  f,u.name as createname,up.name as updatename  "
						+ "from Driverfamilymember f ,Driver d,Userinfo u,Userinfo up "
						+ "where f.driverid = d.id and f.isactive = 1 and f.createby = u.id and f.updateby  = up.id ");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		Query query = getEntityManager().createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	public List<Object> findPicturebyId(List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = new StringBuilder(
				"select d.id,d.picture,d.workenddate,d.qualificationenddate,d.drivinglicenseenddate from Driver d  ")
				.append(" where 1 = 1 ");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		Query query = getEntityManager().createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}

	// public Routestop getRoutestop(Route route,Long stationid) {
	// Map<String,Object> map = new HashMap<String, Object>();
	// map.put("route", route);
	// map.put("stationid", stationid);
	// List<Routestop> routestops = find(Routestop.class, map);
	// return routestops!=null&&routestops.size()>0?routestops.get(0):null;
	// }
	
	@SuppressWarnings("unchecked")
	public List<Object> queryDriverFinger() {
		StringBuilder sql = new StringBuilder("select d.id, d.fingerstr1 fingerstr,d.name ")
		.append(" from driver d where d.fingerstr1 is not null and d.isactive = 1")
		.append(" union all select d.id, d.fingerstr2 fingerstr ,d.name")
		.append("  from driver d where d.fingerstr2 is not null and d.isactive = 1")
		.append(" union all select d.id, d.fingerstr3 fingerstr ,d.name")
		.append("  from driver d where d.fingerstr3 is not null and d.isactive = 1");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		return query.getResultList();
	}
	
	@SuppressWarnings("unchecked")
	public List<Object> queryVehicleByDriverid(long driverid) {
		StringBuilder sql = new StringBuilder("select v.id as vehicleid,v.vehicleno,d.name drivername from Driver d,Vehicle v where d.vehicleid=v.id and d.isactive=1 and d.id= ");
		sql.append(driverid);
		Query query = getEntityManager().createNativeQuery(sql.toString());
		return query.getResultList();
	}
	
	public List<Object> queryDriverByDriverid(long driverid) {
//		StringBuilder sql = new StringBuilder("select d.id,d.name from Driver d where d.id= ");
		StringBuilder sql = new StringBuilder(
				" select d.id,d.name,v.id as vehicleid, v.vehicleno vehicleno from driver d  ");
		sql.append(" left join vehicle v on d.vehicleid=v.id where d.id=");
		sql.append(driverid);
		Query query = getEntityManager().createNativeQuery(sql.toString());
		return query.getResultList();
	}
	
	public List<Object> queryVehiclenoByDriverid(long driverid) {
		StringBuilder sql = new StringBuilder("select d.id,d.vehicleid from Driver d where d.id= ");
		sql.append(driverid);
		Query query = getEntityManager().createNativeQuery(sql.toString());
		return query.getResultList();
	}
	
	public List<Object> queryDriverInfo() {
		StringBuilder sql = new StringBuilder("");
		sql.append("select code,name,cardno,idcard,sex,birthday,politicsstatus,")
		.append("education,drivinglicense,drivinglicensefirstdate,drivinglicensestartdate")
		.append(",drivinglicenseenddate,qualification,qualificationstartdate,qualificationenddate")
		.append(",qualificationtype,picture from  driver d ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		return query.getResultList();
	}

	public List<Object> queryDriverAndStewardFinger() {
		StringBuilder sql = new StringBuilder("select d.id, d.fingerstr1 fingerstr,d.name ,'D' ")
				.append(" from driver d where d.fingerstr1 is not null and d.isactive = 1")
				.append(" union all select d.id, d.fingerstr2 fingerstr ,d.name ,'D' ")
				.append("  from driver d where d.fingerstr2 is not null and d.isactive = 1")
				.append(" union all select d.id, d.fingerstr3 fingerstr ,d.name,'D' ")
				.append("  from driver d where d.fingerstr3 is not null and d.isactive = 1")
				.append(" union all select s.id, s.fingerstr1 fingerstr ,s.name,'S' ")
				.append("  from Steward s where s.fingerstr1 is not null and s.isactive = 1")
				.append(" union all select s.id, s.fingerstr2 fingerstr ,s.name,'S' ")
				.append("  from Steward s where s.fingerstr2 is not null and s.isactive = 1")
				.append(" union all select s.id, s.fingerstr3 fingerstr ,s.name,'S' ")
				.append("  from Steward s where s.fingerstr3 is not null and s.isactive = 1");
				Query query = getEntityManager().createNativeQuery(sql.toString());
				return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	public List<Object> queryDriverCardno(String drivinglicense){
		StringBuilder sql = new StringBuilder(
				" select d.id driverid,v.id,v.vehicleno,v.cardno code from driver d,vehicle v where d.vehicleid=v.id and d.drivinglicense=:drivinglicense");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("drivinglicense", drivinglicense);
		return query.getResultList();
	}
	
	public FingerCache findFingeCache(long vehicleid, long driverorstewardid, Date savedate, String mark){
		StringBuilder sql = new StringBuilder(
				" select fc from FingerCache fc where fc.vehicleid=:vehicleid and fc.driverorstewardid=:driverorstewardid and fc.savedate=:savedate and fc.driverorstewardmark=:mark ");
		Query query = getEntityManager().createQuery(sql.toString(),FingerCache.class );
		query.setParameter("vehicleid", vehicleid);
		query.setParameter("driverorstewardid", driverorstewardid);
		query.setParameter("savedate", savedate);
		query.setParameter("mark", mark);
		List<FingerCache> list = query.getResultList();
		return list.size()>0?list.get(0):null;
	}
	
	//查看二维码录入时的驾驶员个数,作为判断驾驶员个数使用
	public int findDriversnum(long vehicleid,long orgid){
		StringBuffer sql = new StringBuffer(
				"select count(1) from certificateTwoCode ct ")
				.append(" where ct.certificatetype='4' and ct.vehicleid=:vehicleid and ct.orgid =:orgid ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("vehicleid", vehicleid);
		query.setParameter("orgid", orgid);
		BigDecimal count = (BigDecimal) query.getResultList().get(0);
		return count.intValue();
	}
	//根据司乘人员绑定的车辆查判断个人
	public int findDrivers(long vehicleid){
		StringBuffer sql = new StringBuffer(
				"select count(1) from driver t ")
				.append(" where t.isactive = 1 and t.vehicleid=:vehicleid ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("vehicleid", vehicleid);
		BigDecimal count = (BigDecimal) query.getResultList().get(0);
		return count.intValue();
	}
	//根据司乘人员绑定的车辆查判断个人
	public int findStewards(long vehicleid){
		StringBuffer sql = new StringBuffer(
				"select count(1) from steward t ")
				.append(" where t.isactive = 1 and t.vehicleid=:vehicleid ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("vehicleid", vehicleid);
		BigDecimal count = (BigDecimal) query.getResultList().get(0);
		return count.intValue();
	}
	public List<Object> findFingeCachecount(long vehicleid,Date savedate){
		//当天和当天之后的班次 都可以报班，需要查询到
		StringBuilder sql = new StringBuilder(
				" select fc from FingerCache fc where fc.vehicleid=:vehicleid and fc.savedate>sysdate-1 ");//=:savedate 
		Query query = getEntityManager().createQuery(sql.toString(),FingerCache.class );
		query.setParameter("vehicleid", vehicleid);
//		query.setParameter("savedate", savedate);
		List<Object> list = query.getResultList();
		return list;
	}
	
	public List<Object> findFingeCachecount(long vehicleid,Date savedate,String type){
		//当天和当天之后的班次 都可以报班，需要查询到
		StringBuilder sql = new StringBuilder(
				" select fc from FingerCache fc where fc.vehicleid=:vehicleid and fc.driverorstewardmark=:type  and fc.savedate>sysdate-1 ");//=:savedate 
		Query query = getEntityManager().createQuery(sql.toString(),FingerCache.class );
		query.setParameter("vehicleid", vehicleid);
//		query.setParameter("savedate", savedate);
		query.setParameter("type", type);
		List<Object> list = query.getResultList();
		return list;
	}
	
}
