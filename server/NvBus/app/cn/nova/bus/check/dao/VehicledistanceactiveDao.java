/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b>cn.nova.bus.check.dao<br/>
 * <b>文件名：</b>VehicledistanceactiveDao.java<br/>
 * <b>版本信息：</b>v4.0<br/>
 * <b>日期：</b> 2013-5  <br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.check.dao;

import java.util.Date;
import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.common.ParamterConst;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.system.dao.ParameterDao;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

/**
 * <b>类描述：车辆行驶里程管理</b><br/>
 * <b>类名称：</b>VehicledistanceactiveDao.java<br/>
 * <b>创建人：</b><a href="mailto:huanghaoze@nova.net.cn">hhz</a><br/>
 * <b>创建时间：</b>2013-5-3  <br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
@SuppressWarnings("rawtypes")
public class VehicledistanceactiveDao extends EntityManagerDaoSurport {


	private ParameterDao paradao;
	/**
	 * 查询最后一次激活记录
	 * @param propertyFilterList
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> queryLastActive(
			Date startdate,Date enddate,long vehicleid,long userid,long orgid) {
		paradao=new ParameterDao(); 
		String limit =paradao.findParamValue(ParamterConst.Param_0142, orgid);//先把参数值找出来:车辆的里程限制公里数
		StringBuilder sql = new StringBuilder(
		"select v.vehicleno,v.id vehicleid,v.maintainvaliddate,")
		.append(" (case")
		.append("	when v.nextmaintaindistance <= 0 then to_char(nvl("+limit+",0))" )
		.append("	else")
		.append("   	to_char(v.nextmaintaindistance)")
		.append("	end) distancelimit,")
		.append("al.createtime,")
		.append("u.name createname,")
		.append("sum(al.departdistance) departdistance,")
		.append("al.lastactivetime ")
		.append(" from vehicle v,")
		.append("  userinfo u,")
		.append("  (select v.id vehicleid,")//查询新添加的车辆，发非流水班运行里程
		.append("		v.createby,")
		.append("		v.createtime,")
		.append("		v.createtime lastactivetime,")
		.append("		sum(nvl(d.distance,0)) departdistance")
		.append("	from vehicle v")		
		.append("		 left join")
		.append("		 (select dt.vehicleid,")
		.append("		  		count(distinct dt.reportid) * r.distance * 2 distance,")
		.append("		  		to_date(to_char(dt.departdate, 'yyyy-mm-dd') || ' ' ||")
		.append("		  			dt.departtime || ':00','yyyy-mm-dd hh24:mi:ss') departtime")
		.append("		  from departinvoices dt, route r, schedule s")
		.append("		  where dt.status <> '1'")
		.append("		  	and dt.scheduleid = s.id")
		.append("		  	and s.routeid = r.id")
		.append("		  	and s.islinework = 0")
		.append("  			and dt.departstationid = r.startstationid")
		.append(" 			and dt.vehicleid not in (select vd.vehicleid")
        .append(" 			 	       from vehicledistanceactive vd group by vd.vehicleid)");
		if(vehicleid!=0){
			sql.append(" and dt.vehicleid = "+vehicleid);
		}
		sql.append("	   group by dt.vehicleid,")
		.append("		  	dt.reportid,")
		.append("		  	r.distance,")
		.append("		  	dt.departdate,")
		.append("		  	dt.departtime) d ")
		.append("		  	on v.id=d.vehicleid and d.departtime>v.createtime")		
		.append("		where v.isactive = 1 ")
		.append("		   		and v.id not in (select vd.vehicleid from vehicledistanceactive vd")
		.append("							group by vd.vehicleid)");
		if(vehicleid!=0){
			sql.append(" and v.id = "+vehicleid);
		}
		if(userid!=0){
			sql.append(" and v.createby=" + userid);
		}
		if(startdate!=null && enddate!=null){
			sql.append(" and v.createtime between :startdate and :enddate ");
		}
		sql.append("		group by v.id, v.createby, v.createtime")
		.append(" union all")
		.append("	select v.id vehicleid,")//查询新添加的车辆（不在车辆行驶里程限制记录表里），发流水班运行里程
		.append("	v.createby,")
		.append("	v.createtime,")
		.append("	v.createtime lastactivetime,")
		.append("	sum(nvl(line.distance,0)) departdistance")
		.append("	from vehicle v left join ")
		.append("		(select dt.vehicleid,vp.reporttime, nvl(count(distinct dt.reportid)*r.distance * 2,0) distance")
		.append("		 from departinvoices dt,")
		.append("			route r, schedule s, vehiclereport vp")
		.append("		where dt.status <> '1'")
		.append("			and dt.scheduleid = s.id")
		.append("			and s.routeid = r.id")
		.append("			and s.islinework = 1")
		.append("  			and dt.departstationid = r.startstationid")
		.append("			and dt.scheduleplanid = vp.scheduleplanid")
		.append("			and vp.scheduleid = s.id")
		.append("			and dt.reportid = vp.id")
		.append("			and vp.isdeparted = 1")
		.append("			and dt.vehicleid not in")
		.append("				(select vd.vehicleid from vehicledistanceactive vd group by vd.vehicleid)")
		.append("			and vp.vehicleid = dt.vehicleid");
		if(vehicleid!=0){
			sql.append(" and dt.vehicleid = "+vehicleid);
		}
		sql.append("		group by dt.vehicleid, r.distance,vp.reporttime) line on line.vehicleid=v.id and line.reporttime>=v.createtime")
		.append("	where v.isactive = 1")
		.append("		 and v.id not in (select vd.vehicleid from vehicledistanceactive vd")
		.append("				group by vd.vehicleid)");
		if(vehicleid!=0){
			sql.append(" and v.id = "+vehicleid);
		}
		if(userid!=0){
			sql.append(" and v.createby=" + userid);
		}
		if(startdate!=null && enddate!=null){
			sql.append(" and v.createtime between :startdate and :enddate");
		}
		sql.append("	group by v.id,v.createby,v.createtime")
		.append(" union all")
		.append("	select v.id vehicleid,")//查询已添加车辆（已经存在于记录表的车辆），发非流水班运行里程
		.append("		vd.createby,")
		.append("		vd.createtime,")
		.append("		vd.lastactivetime,")
		.append("		nvl(sum(d.distance), 0) departdistance")
		.append("	from (select max(vd.createtime) createtime, vd.vehicleid")
		.append("			from vehicledistanceactive vd")
		.append("			group by vd.vehicleid) vvd ")
		.append("		  left join")
		.append("		  (select dt.vehicleid,")
		.append("		  		count(distinct dt.reportid) * r.distance * 2 distance,")
		.append("		  		to_date(to_char(dt.departdate, 'yyyy-mm-dd') || ' ' ||")
		.append("		  			dt.departtime || ':00','yyyy-mm-dd hh24:mi:ss') departtime")
		.append("		  from departinvoices dt, route r, schedule s")
		.append("		  where dt.status <> '1'")
		.append("		  	and dt.scheduleid = s.id")
		.append("		  	and s.routeid = r.id")
		.append("  			and dt.departstationid = r.startstationid")
		.append("		  	and s.islinework = 0");
		if(vehicleid!=0){
			sql.append(" and dt.vehicleid = "+vehicleid);
		}
		sql.append("		  group by dt.vehicleid,")
		.append("		  	dt.reportid,")
		.append("		  	r.distance,")
		.append("		  	dt.departdate,")
		.append("		  	dt.departtime) d ")
		.append("		  	on vvd.vehicleid=d.vehicleid and d.departtime>vvd.createtime,")
		.append("		vehicledistanceactive vd,vehicle v")
		.append("	where vvd.vehicleid = v.id")
		.append("		and vd.vehicleid = v.id")
		.append("		and vd.createtime = vvd.createtime")
		.append("		and v.isactive = 1");
		if(vehicleid!=0){
			sql.append(" and v.id = "+vehicleid);
		}
		if(userid!=0){
			sql.append(" and v.createby=" + userid);
		}
		if(startdate!=null && enddate!=null){
			sql.append(" and vd.createtime between :startdate and :enddate ");
		}
		sql.append("	group by v.id, vd.createby, vd.createtime, vd.lastactivetime")
		.append(" union all")
		.append("	select v.id vehicleid,")//查询已添加车辆（已经存在于记录表的车辆），发流水班运行里程
		.append("		vd.createby,")
		.append("		vd.createtime,")
		.append("		vd.lastactivetime,")
		.append("		sum(nvl(line.distance,0)) departdistance")
		.append("	from vehicledistanceactive vd,")
		.append("		vehicle v,")
		.append("		(select max(vd.createtime) createtime, vd.vehicleid")
		.append("			from vehicledistanceactive vd group by vd.vehicleid) vvd")
		.append("		left join ")
		.append("		(select vp.reporttime,")
		.append("			dt.vehicleid,")
		.append("			nvl(count(distinct dt.reportid) * r.distance * 2,0) distance")
		.append("		from departinvoices dt,route r,")
		.append("			schedule s,vehiclereport vp")
		.append("		where dt.status <> '1'")
		.append("			and dt.scheduleplanid = vp.scheduleplanid")
		.append("			and dt.scheduleid = vp.scheduleid")
		.append("			and dt.reportid = vp.id")
		.append("			and dt.scheduleid = s.id")
		.append("			and s.routeid = r.id")
		.append("			and vp.isdeparted = 1")
		.append("			and s.islinework = 1")
		.append("  			and dt.departstationid = r.startstationid")
		.append("			and dt.vehicleid = vp.vehicleid");
		if(vehicleid!=0){
			sql.append(" and dt.vehicleid = "+vehicleid);
		}
		sql.append("		group by vp.reporttime, dt.vehicleid,r.distance) line  ")
		.append("		on vvd.vehicleid=line.vehicleid and line.reporttime>= vvd.createtime")
		.append("	where v.isactive = 1")
		.append("		and vvd.vehicleid = v.id")
		.append("		and vd.vehicleid = v.id")
		.append("		and vd.createtime = vvd.createtime");
		if(vehicleid!=0){
			sql.append(" and v.id = "+vehicleid);
		}
		if(userid!=0){
			sql.append(" and v.createby=" + userid);
		}
		if(startdate!=null && enddate!=null){
			sql.append(" and vd.createtime between :startdate and :enddate");
		}
		sql.append("   group by v.id, vd.createby, vd.createtime, vd.lastactivetime) al")
		.append(" where al.vehicleid = v.id")
		.append("	and al.createby = u.id")
		.append(" group by v.vehicleno,v.id,v.maintainvaliddate,v.nextmaintaindistance, al.createtime, u.name, al.lastactivetime");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		if(startdate!=null && enddate!=null){
			query.setParameter("startdate", startdate);
			query.setParameter("enddate", enddate);
		}
		List resultList = query.getResultList();
		return resultList==null||resultList.size()==0? null : resultList;
	}	
	
	/**
	 * 查找历史激活记录
	 * @param propertyFilterList
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> queryHistoryActive(List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = new StringBuilder(
				"select v.vehicleno,")
		.append(" 	vd.limitdistance distancelimit,")//激活时限制里程
		.append("   vd.createtime,")
		.append("   vd.lastactivetime,")
		.append(" 	u.name createname,")
		.append(" 	vd.departdistance ")//激活时已运行里程
		.append("from  vehicledistanceactive vd,")
		.append(" 	vehicle v,")
		.append(" 	userinfo u ")
		.append("where vd.vehicleid = v.id")
		.append(" 	and vd.createby = u.id ");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		sql.append(" order by v.vehicleno,vd.createtime desc ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}

}
