package cn.nova.bus.pack.dao;

import java.util.Calendar;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.persistence.Query;

import cn.nova.bus.base.model.Station;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.pack.model.Pack;
import cn.nova.bus.pack.vo.PackStockVO;
import cn.nova.bus.price.model.Ticketprice;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

@SuppressWarnings("rawtypes")
public class PackStockDao extends EntityManagerDaoSurport {
	private Pack pack;

	/**
	 * 签发查询班次
	 * 
	 * @param propertyFilters
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> queryschedule(List<PropertyFilter> propertyFilters, Date departdate) {
		StringBuffer sb = new StringBuffer();
		//
		// sb.append("select
		// sd.id,sd.code,r.name,ss.departdate,trim(ss.departtime) as
		// departtime,")
		// .append(" nvl(vep.isdeparted, ss.isdeparted) isdeparted,trim(case
		// ss.status when '0' then")
		// .append(" '正常' when '1' then '报停' when '2' then '晚点' when '3' then
		// '被并' when '4' then '脱班' when '5' then '停售'")
		// .append(" end) as status,v.id as vehicleid,sd.id as scheduleid,r.id
		// as routeid,v.vehicleno,d.name as drivername,")
		// .append(" u.name as unitname,p.packno as packno,d.mobilephone as
		// mobilephone,p.paymethod as paymethod ,dd.value as
		// payvalue,p.collectstatus as collectstatus,p.packprice from
		// Vehiclereport vep")
		// .append(" left join Driver d on d.id = vep.driver1id, Schedulestatus
		// ss, Vehicle v, unit u,")
		// .append(" Schedule sd, Route r,pack p,digitaldictionarydetail dd
		// where ss.scheduleplanid = vep.scheduleplanid")
		// .append(" and vep.vehicleid = v.id and vep.scheduleid = sd.id and
		// v.unitid = u.id and sd.routeid = r.id and dd.digitaldictionaryid = 82
		// and dd.code = p.paymethod")
		// .append(" and vep.isactive = 1 ");
		// sb.append(PropertyFilter.toJpql(propertyFilters,true));
		// 2015年5月17日 15:08:08
		// sb.append("select vie.scheduleid, vie.code, vie.name,")
		// .append(" vie.departdate,vie.departtime, vie.isdeparted,
		// vie.status,")
		// .append(" vie.vehicleid, vie.packno,")
		// .append(" vie.vehicleno,vie.routeid,vie.unitname,vie.")
		// .append(" collectstatus,vie.packprice")
		// .append("
		// ,vie.paymethod,vie.payvalue,nvl(vr.isdeparted,vie.isdeparted)")
		// .append(" isdeparted,dr.name as drivername,dr.mobilephone as")
		// .append(" mobilephone,vie.isreported from")
		// .append(" (select s.id as scheduleid, s.code, r.name,
		// ss.departdate,")
		// .append(" trim(ss.departtime) as departtime, ss.isdeparted,trim(case
		// ss.status")
		// .append(" when '0' then '正常' when '1' then '报停' when '2' then '晚点'
		// when '3'")
		// .append(" then '被并' when '4' then '脱班' when '5' then '停售' end) as
		// status, v.id")
		// .append(" as vehicleid, p.packno,v.vehicleno, r.id as routeid,u.name
		// as")
		// .append(" unitname, p.collectstatus as collectstatus,
		// p.packprice,p.paymethod")
		// .append(" as paymethod,did.value as
		// payvalue,ss.isreported,ss.departstationid from pack p left")
		// .append(" join vehicle v left join unit u on v.unitid=u.id on
		// p.vehicleid=v.id,")
		// .append(" schedule s,schedulestatus ss,route r,digitaldictionary
		// di,")
		// .append(" digitaldictionarydetail did where p.scheduleid = s.id and")
		// .append(" ss.scheduleid=s.id and s.routeid=r.id and di.tablename =
		// 'pack' and")
		// .append(" di.columnname = 'paymethod' and did.digitaldictionaryid =
		// di.id and")
		// .append(" did.code = p.paymethod ）vie left join vehiclereport vr left
		// join")
		// .append(" driver dr on vr.driver1id=dr.id on vie.scheduleid =
		// vr.scheduleid and")
		// .append(" vie.vehicleid=vr.vehicleid where 1=1");
		// 2015年5月17日 15:08:08 之前
		// sb.append("select s.id as scheduleid, r.id as routeid,v.id as
		// vehicleid,vp.id,vp.departdate,s.code,")
		// .append(" v.vehicleno,trim(ss.departtime),u.name,d.name
		// drivername,d.mobilephone, count(p.pieces) pieces,")
		// .append(" nvl(sum(p.totalfee),0) totalfee,")
		// .append(" ss.isreported,trim(case v.status when '0' then '正常' when
		// '1' then '报停' when '2' ")
		// .append(" then '晚点' when '3' then '被并' when '4' then '脱班' when '5'
		// then '停售' end) as status, vp.isdeparted,")
		// .append(" r.name routename")
		// .append(" from vehiclereport vp")
		// .append(" left join schedule s on vp.scheduleid = s.id")
		// .append(" left join organization org on vp.reportorgid = org.id")
		// .append(" left join schedulestatus ss on vp.scheduleplanid =
		// ss.scheduleplanid and ss.departstationid = org.stationid")
		// .append(" left join vehicle v on vp.vehicleid = v.id")
		// .append(" left join unit u on v.unitid = u.id")
		// .append(" left join driver d on vp.driver1id = d.id")
		// .append(" left join pack p on vp.id = p.vehiclereportid and
		// p.packtype = 0")
		// .append(" left join route r on s.routeid=r.id")
		// .append(" where 1=1")
		// // .append(" and vp.isactive = 1 and vp.reportorgid = 1")
		// .append(" and vp.isactive = 1 ")
		// .append(PropertyFilter.toJpql(propertyFilters,true))
		// .append(" group by vp.id, vp.departdate, s.code,
		// v.vehicleno,ss.departtime,u.name,d.name,d.mobilephone,")
		// .append(" ss.isreported, v.status,vp.isdeparted,r.id,
		// s.id,v.id,r.name")
		// ;
		//
		//
		// Query query = getEntityManager().createNativeQuery(sb.toString());
		// JPAPropertyFilterUtil.setParameter(query, propertyFilters);
		// List<Object> list =query.getResultList();
		// return list;
		sb.append(
				"select distinct sp.id as scheduleid,vr.id as vehiclereportid, sp.departdate, s.code,  nvl(v.vehicleno,vvr.vehicleno) vehicleno, ")
				.append("  trim(ss.departtime) as departtime, nvl(u.name,uv.name) as unitname, ")
				.append(" d1.mobilephone as phone1,d2.mobilephone as phone2,d3.mobilephone as phone3, ")
				// .append(" count(p.pieces) pieces, nvl(sum(p.totalfee), 0)
				// totalfee, ")
				.append("  decode(ss.isdeparted,0,'未发班','已发班')as isdeparted, ")
				.append(" decode(ss.status,'0','正常','1','报停','2','晚点','3','被并','4', '脱班','停售') as status, ")
				.append(" d1.name as name1, d2.name name2,d3.name name3,r.name as routename, ")
				.append(" r.id as routeid , s.id as schedule ")
				.append(" from scheduleplan sp left join schedule s on s.id = sp.scheduleid ")
				.append("  left join organization o on o.id = sp.orgid ")
				.append(" left join route r on r.id = s.routeid ")
				.append("  left join ticketprice tp on tp.scheduleplanid = sp.id ")
				// .append(" left join pack p on p.scheduleid = s.id and
				// p.packtype = 0 ")
				.append("  left join schedulestatus ss on ss.scheduleid = s.id and ss.scheduleplanid=sp.id ")
				.append("  left join schedulevehiclepeopleplan svp on svp.scheduleplanid = sp.id ")
				.append("  left join vehicle v on svp.planvehicleid = v.id ")
				.append(" left join driver d1 on svp.plandriver1id = d1.id ")
				.append("  left join driver d2 on svp.plandriver2id = d2.id ")
				.append("  left join driver d3 on svp.plandriver3id = d3.id ")
				.append("  left join unit u on u.id = v.unitid ")
				.append("   left join vehiclereport vr on vr.scheduleplanid = sp.id  and vr.isactive =1 and vr.isdeparted = 0 left join vehicle vvr on vvr.id = vr.vehicleid left join unit uv on vvr.unitid = uv.id  ")
				.append("   where ss.status in (0,2)   ");
		sb.append(" and ss.orgid = tp.orgid and tp.departstationid = ss.departstationid ");
		sb.append(PropertyFilter.toJpql(propertyFilters, true));
		// sb.append(" group by p.id,sp.id,vr.id, ss.departtime,")
		// .append(" s.code,sp.departdate, v.vehicleno,d1.mobilephone, ")
		// .append(" d2.mobilephone,d3.mobilephone,p.pieces,p.packno, ")
		// .append("
		// u.name,r.name,d1.name,d2.name,d3.name,ss.isdeparted,ss.status, ")
		// .append(" r.id, p.sendstationid,s.id ");
		Query query = getEntityManager().createNativeQuery(sb.toString());
		// query.setParameter("departdate", departdate);
		JPAPropertyFilterUtil.setParameter(query, propertyFilters);
		List list = query.getResultList();
		return list;
	}

	/**
	 * 签发班次
	 * 
	 * @param packids
	 * @param routeid
	 * @param scheduleid
	 * @param vehicleid
	 * @param stationids
	 * @param departdate
	 * @return
	 */
	public boolean updatepack(String packids, long scheduleid, Long vehicleid, long signby, Date signtime,
			Date departdate) {
		StringBuffer sb = new StringBuffer();
		// sb.append("update Pack set
		// scheduleid=:scheduleid,vehicleid=:vehicleid,status='1',balancestatus
		// =
		// '0',signby=:signby,signtime=:signtime,departdate=:departdate,updateby=:signby,updatetime=:signtime,singbillno=:singbillno
		// where id in(").append(packids).append(")");
		sb.append(
				"update Pack p set scheduleid=:scheduleid,vehicleid=:vehicleid,status='1',balancestatus = '0',signby=:signby,signtime=:signtime,departdate=:departdate,updateby=:signby,updatetime=:signtime where p.id in(")
				.append(packids).append(")");

		Query query = getEntityManager().createQuery(sb.toString());
		query.setParameter("scheduleid", scheduleid);
		query.setParameter("vehicleid", vehicleid);
		query.setParameter("signby", signby);
		query.setParameter("signtime", signtime);
		query.setParameter("departdate", departdate);
		// query.setParameter("singbillno", singbillno);
		// 修改pack的报道车辆id

		return query.executeUpdate() > 0 ? true : false;

	}

	/**
	 * 验证线路是否经过站点
	 * 
	 * @param packids
	 * @param scheduleid
	 * @return
	 */
	public boolean checkschedule(long routeid, long stationid) {
		StringBuffer sb = new StringBuffer();
		sb.append("select r.stationid from Routestop  r where r.route.id=:routeid");

		Query query = getEntityManager().createQuery(sb.toString());
		query.setParameter("routeid", routeid);

		List<Object> list = query.getResultList();
		if (list == null || list.size() <= 0) {
			return true;
		}

		// 把查询出来的站点跟传进来的站点进行对比、
		// String [] ids=stationids.split(",");

		boolean flas = true;
		// for (int i = 0; i < ids.length; i++) {

		for (Iterator it = list.iterator(); it.hasNext();) {
			Object o = it.next();
			if (stationid == Long.parseLong((o.toString()))) {
				flas = false;
				// it.remove();
				break;
			}
			flas = true;
		}
		// if(flas==false){
		// //存在当前站点
		// }else{
		// break;
		// }
		// }

		return flas;

	}

	/**
	 * 验证线路是否经过站点
	 * 
	 * @param packids
	 * @param scheduleid
	 * @return
	 */
	public boolean checkschedule(long routeid, String stationids) {
		StringBuffer sb = new StringBuffer();
		sb.append("select r.stationid from Routestop  r where r.route.id=:routeid");

		Query query = getEntityManager().createQuery(sb.toString());
		query.setParameter("routeid", routeid);

		List<Object> list = query.getResultList();
		if (list == null || list.size() <= 0) {
			return true;
		}

		// 把查询出来的站点跟传进来的站点进行对比、
		String[] ids = stationids.split(",");

		boolean flas = true;
		for (int i = 0; i < ids.length; i++) {
			long stationid = new Long(ids[i]);
			for (Iterator it = list.iterator(); it.hasNext();) {
				Object o = it.next();
				if (stationid == Long.parseLong((o.toString()))) {
					flas = false;
					// it.remove();
					break;
				}
				flas = true;
			}
			if (!flas) {
				// 存在当前站点
			} else {
				break;
			}
		}

		return flas;

	}

	/**
	 * 查询输入行包单号的行包信息 李电志 2015年5月19日 11:45:17
	 * 
	 * @param packids
	 * @param scheduleid
	 * @return
	 */
	public List<Pack> findPackinfo(String packno) {
		StringBuffer sb = new StringBuffer();
		sb.append("select p from Pack p").append(" where p.packno =:packno and p.packtype='0'");
		Query query = getEntityManager().createQuery(sb.toString());
		query.setParameter("packno", packno);
		return query.getResultList();
	}

	public List<Ticketprice> findTicketprice(Date departdate, long scheduleplanid, long reachstationid) {
		StringBuffer sb = new StringBuffer();
		sb.append("select p from Ticketprice p")
				.append(" where p.scheduleplan.id =:scheduleplanid and p.departdate=:departdate")
				.append(" and p.reachstationid=:reachstationid");
		Query query = getEntityManager().createQuery(sb.toString());
		query.setParameter("departdate", departdate);
		query.setParameter("scheduleplanid", scheduleplanid);
		query.setParameter("reachstationid", reachstationid);
		return query.getResultList();
	}

	/**
	 * 查询行包员日营收
	 * 
	 * @param userid
	 * @param date
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> querysellbyrevenue(long userid, Date date) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		cal.add(Calendar.DATE, 1); // 得到后一天

		StringBuffer sb = new StringBuffer("");
		sb.append(
				" select a.acceptpieces,a.accepttotalfee,b.goodspieces,b.goodstotalfee,c.pkuppieces,c.pkuptotalfee from (");
		sb.append(
				" select sum(p.pieces) as acceptpieces,sum(p.totalfee) as accepttotalfee from pack p where p.status in(0,1) and  p.sellby=:sellby and p.packtype='0' and p.createtime>=:formtime");
		sb.append(" and p.createtime<=:endtime ) a,");
		sb.append(
				"(select sum(g.pieces) as goodspieces,sum(g.totalfee) as goodstotalfee from goods g where g.status!=2 and  g.operator=:sellby and g.createtime>=:formtime");
		sb.append(" and g.createtime<=:endtime ) b,");
		sb.append(
				"(select sum(p.pieces) as pkuppieces,sum(pk.totalfee) as pkuptotalfee from pack p,packpickup pk where p.id=pk.packid and p.status=2 and  pk.operator=:sellby and pk.createtime>=:formtime");
		sb.append(" and pk.createtime<=:endtime ) c");

		Query query = getEntityManager().createNativeQuery(sb.toString());
		query.setParameter("sellby", userid);
		query.setParameter("formtime", date);
		query.setParameter("endtime", cal.getTime());

		return query.getResultList();
	}

	/**
	 * 取消签发、提领
	 * 
	 * @param pack
	 * @return
	 * @throws ServiceException
	 */
	public boolean cancelPack(Pack pack) throws ServiceException {
		if (pack.getPacktype().equals("0")) {
			// 取消签发
			StringBuffer sb = new StringBuffer();
			sb.append("update Pack set scheduleid=:scheduleid,vehicleid=:vehicleid,status='0',singbillno=null ");
			sb.append(" ,updateby=:updateby,updatetime=:updatetime");
			sb.append(" ,signby=:signby,signtime=:signtime where id=:packid");

			Query query = getEntityManager().createQuery(sb.toString());
			query.setParameter("scheduleid", pack.getScheduleid());
			query.setParameter("vehicleid", pack.getVehicleid());
			query.setParameter("signby", pack.getSignby());
			query.setParameter("signtime", pack.getSigntime());
			query.setParameter("packid", pack.getId());
			query.setParameter("updateby", pack.getUpdateby());
			query.setParameter("updatetime", pack.getUpdatetime());
			query.executeUpdate();
			// if(query.executeUpdate()>0 && pack.getPacktype().equals("2")){
			// //取消提领
			// sb = new StringBuffer();
			// sb.append("delete from Packpickup where p.packid=:packid");
			// query = getEntityManager().createQuery(sb.toString());
			// query.setParameter("packid", pack.getId());
			// query.executeUpdate();
			// }
		} else if (pack.getPacktype().equals("1")) {
			// 取消提领
			StringBuffer sb = new StringBuffer();
			sb.append("update Pack set status='4'"); // 状态为到货库存
			sb.append(" ,updateby=:updateby,updatetime=:updatetime");
			sb.append(" ,signby=:signby,signtime=:signtime where id=:packid");

			Query query = getEntityManager().createQuery(sb.toString());
			query.setParameter("signby", pack.getSignby());
			query.setParameter("signtime", pack.getSigntime());
			query.setParameter("packid", pack.getId());
			query.setParameter("updateby", pack.getUpdateby());
			query.setParameter("updatetime", pack.getUpdatetime());
			if (query.executeUpdate() > 0) {
				// 取消提领
				sb = new StringBuffer();
				sb.append("delete from Packpickup where packid=:packid");
				query = getEntityManager().createQuery(sb.toString());
				query.setParameter("packid", pack.getId());
				query.executeUpdate();
			}
		}
		return true;
	}

	@SuppressWarnings("unchecked")
	public List<Object> querystockscheduleBy(List<PropertyFilter> propertyFilters) {
		StringBuffer sb = new StringBuffer();

		sb.append("select sd.code ,sp.departdate,trim(ss.departtime) as departtime");
		sb.append(",v.vehicleno,d.name as drivername,u.name as unitname ");
		sb.append(" ,sp.id as scheduleplanid,sd.id as scheduleid,v.id as vehicleid,vep.id as vehiclereportid ");

		sb.append(
				" from Scheduleplan sp left join Vehiclereport vep on sp.id=vep.scheduleplanid left join Driver d on d.id=vep.driver1id left join Vehicle v on v.id=vep.vehicleid left join Unit u on u.id=v.unitid,Schedule sd,Route r,Routestop rt,Schedulestatus ss ");

		sb.append(
				" where sd.id=sp.scheduleid and rt.routeid =sd.routeid and r.id=sd.routeid and ss.scheduleplanid=sp.id");

		sb.append(PropertyFilter.toJpql(propertyFilters, true));

		Query query = getEntityManager().createNativeQuery(sb.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilters);
		List<Object> list = query.getResultList();
		return list;

	}

	public boolean updatPackBy(String singbillno, List<PropertyFilter> propertyFilters) {
		StringBuffer sb = new StringBuffer();
		sb.append("update Pack p set p.singbillno=:singbillno where 1=1 ");
		sb.append(PropertyFilter.toJpql(propertyFilters, true));
		Query query = getEntityManager().createQuery(sb.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilters);
		query.setParameter("singbillno", singbillno);

		return query.executeUpdate() > 0 ? true : false;

	}

	// 报道车辆
	public List<Object> qrysendVehicle(Date departdate, String param, long orgid) throws ServiceException {
		StringBuffer sb = new StringBuffer("select vp.id, s.code, v.vehicleno")
				.append("  from vehiclereport vp, vehicle v, schedule s")
				.append("  where vp.vehicleid = v.id and vp.isactive = 1")
				.append("  and vp.scheduleid = s.id and vp.reportorgid =:orgid")
				.append(" and vp.departdate =:departdate and v.vehicleno like '%" + param + "%'")
				.append(" group by vp.id, s.code, v.vehicleno");

		Query query = getEntityManager().createNativeQuery(sb.toString());
		query.setParameter("departdate", departdate);
		// query.setParameter("vehicleno", param);
		query.setParameter("orgid", orgid);
		List<Object> list = query.getResultList();
		return list;
	}

	public List<Object> qrysendSchedule(Date departdate, String param, long orgid) throws ServiceException {
		StringBuffer sb = new StringBuffer(
				"select sp.id,s.code as schcode,v.vehicleno ,s.starttime,s.id as scheduleid ")
						//
						.append(" from scheduleplan sp,  schedule s,schedulevehiclepeopleplan svp")
						.append(" right join vehicle v on svp.planvehicleid = v.id")
						.append(" where svp.scheduleplanid = sp.id").append("  and sp.scheduleid = s.id")
						.append("   and sp.orgid =:orgid").append(" and sp.departdate = :departdate")
						.append(" and s.code like '%" + param + "%'")
						.append(" group by sp.id,s.code,v.vehicleno ,s.starttime,s.id");

		Query query = getEntityManager().createNativeQuery(sb.toString());
		query.setParameter("departdate", departdate);
		query.setParameter("orgid", orgid);
		List<Object> list = query.getResultList();
		return list;
	}

	// 计划班次
	public List<Object> qrysendSchedulePlan(Date departdate, String param, boolean isfindbyreported) {
		StringBuffer sb = new StringBuffer("select sp.id,trim(sp.starttime) as starttime,s.code ")
				.append(" from scheduleplan sp left join schedulestatus ss on ss.scheduleplanid = sp.id and ss.departstationid = sp.startstationid , schedule s ")
				.append(" where sp.scheduleid=s.id ").append(" and sp.departdate = :departdate")
				.append(" and s.code like '%" + param + "%'");
		if (isfindbyreported) {
			sb.append(" and ss.isreported =1 ");
		}
		sb.append(" group by sp.id,s.code,sp.starttime ");

		Query query = getEntityManager().createNativeQuery(sb.toString());
		query.setParameter("departdate", departdate);
		List<Object> list = query.getResultList();
		return list;
	}

	public Pack getPack() {
		return pack;
	}

	public void setPack(Pack pack) {
		this.pack = pack;
	}

	/**
	 * 查询行包明细信息 李电志 2015年5月20日 16:18:38
	 * 
	 * @param vehiclereportid
	 * @return
	 */
	public List<Object> querystockSendPack(long vehiclereportid, long scheduleid, String flag_pack) {
		StringBuffer sb = new StringBuffer("select p.id,p.packno,p.pieces, ");
		sb.append(
				"p.name,p.departdate,p.sender,p.senderphone,p.consignee,p.consigneephone,u.name uname,p.signtime,p.createtime,")
				.append(" p.weight, p.packed,   p.shipprice,  p.packfee,  p.handfee  ,")
				.append(" p.insuredamount ,  p.transitfee ,  p.insurancefee ,   p.insurance,  p.deliveryfee , ")
				.append(" p.otherfee,  p.totalfee ,  p.senderaddress, p.consigneeaddress,  p.paymethod   ,")
				.append(" p.signby,  p.servicefee,  p.takename,  p.takecertificateno,  p.zhuanyuntostationid ,")
				.append(" p.collectby , p.collectdate  ,p.recycleby , p.recycledate , p.balancestatus ,")
				.append("p.goodsstatus,u.name sellname,di.value as paymethodname,didd.value as packedname");
		sb.append(
				" from pack p left join userinfo u on p.signby = u.id ,digitaldictionary d,digitaldictionarydetail di,digitaldictionary did,digitaldictionarydetail didd ");
		if (flag_pack.equals("isVehicle")) {
			sb.append(" where p.vehiclereportid= " + vehiclereportid);
		} else {
			sb.append(" where p.scheduleid=" + scheduleid);
		}
		sb.append(
				" and p.status = '1' and di.digitaldictionaryid=d.id and d.tablename='pack' and d.columnname='paymethod' and di.code = p.paymethod ")
				.append(" and didd.digitaldictionaryid=did.id and did.tablename='pack' and did.columnname='packed' and didd.code = p.packed");
		Query query = getEntityManager().createNativeQuery(sb.toString());
		// query.setParameter("departdate", departdate);
		// query.setParameter("scheduleid", scheduleid);
		List<Object> list = query.getResultList();
		return list;
	}

	public List<Object> havaPackdepart(Pack pack) {
		StringBuffer sb = new StringBuffer("select pd.packid from Packdepartinvoicespack pd where pd.packid=:packid ");

		Query query = getEntityManager().createQuery(sb.toString());

		query.setParameter("packid", pack.getId());
		List<Object> list = query.getResultList();
		return list;
	}

	public List<Object> findRoute(Date departdate, long scheduleplanid, long reachstationid) {
		StringBuffer sb = new StringBuffer();
		sb.append("select distinct r.id from route r ,schedule s,scheduleplan sp, schedulestop sst ")
				.append(" where r.id=s.routeid and sp.scheduleid=s.id and sst.scheduleid = s.id ")
				.append(" and (r.endstationid=:reachstationid or sst.stationid in (:reachstationid) )")
				.append(" and sp.id=:scheduleplanid").append(" and sp.departdate=:departdate");
		Query query = getEntityManager().createNativeQuery(sb.toString());
		query.setParameter("departdate", departdate);
		query.setParameter("scheduleplanid", scheduleplanid);
		query.setParameter("reachstationid", reachstationid);
		return query.getResultList();
	}

}
