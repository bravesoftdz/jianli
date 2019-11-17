package cn.nova.bus.archive.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.Query;

import cn.nova.bus.archive.model.Viproomcheckin;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.IDAO;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

/**
 * 会员进入贵宾室管理
 * @author Administrator
 *
 */
@SuppressWarnings("rawtypes")
public class ViproomcheckinDao extends EntityManagerDaoSurport {
	/**
	 * 查询会员进入贵宾室信息
	 * @param propertyFilterList
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> queryViproomcheckinlist(List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = new StringBuilder(
				"select vr.id,ct.mobilephone,v.vipcardno,dd.value as schedulestatus,ts.ticketno,")
		.append(" ts.departdate,vr.checkintime,ct.name customername,s.code schedulecode,dd1.value gradename,")
		.append(" ct.sex,ts.seatno,trim(ss.departtime) departtime,ts.ischecked,ts.ticketentrance,")
		.append(" sn.name endstationname,ckby.name checkebyname,o.name checkorg ")
		.append(" from Viproomcheckin vr,vip v,customer ct,ticketsell ts,schedule s,schedulestatus ss,")
		.append(" station sn,userinfo ckby,organization o,")
		.append(" digitaldictionary d,digitaldictionarydetail dd, digitaldictionary d1,digitaldictionarydetail dd1")
		.append(" where vr.vipid=v.id and vr.ticketsellid = ts.id and ts.ticketstatus = '0' ")
		.append(" and v.customerid=ct.id and ts.scheduleid=s.id and sn.id=ts.reachstationid ")
		.append(" and ss.scheduleid=s.id and ss.departdate=ts.departdate and vr.checkinby=ckby.id")
		.append(" and d.id=dd.digitaldictionaryid and d.tablename='schedulestatus' and d.columnname='schedulestatus' ")
		.append(" and ss.status=dd.code and d1.id=dd1.digitaldictionaryid and d1.columnname = 'grade' ")
		.append(" and d1.tablename = 'vip' and v.vipgrade=dd1.code and ss.departstationid = o.stationid ")
		.append(" and s.orgid = o.id ");		
		sql.append(PropertyFilter.toJpql(propertyFilterList,true));
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}	
	
	/**
	 * 根据vip卡号 查询 顾客购票明细，
	 * @param propertyFilterList
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> queryTicketdetail(String vipcardno) {
		StringBuilder sql = new StringBuilder(
			"select 0 ischecked,t.selltime,t.departdate,trim(t.departtime) departtime, t.fullprice,t.seatno,t.ticketentrance ,")
		.append(" t.ischecked as ischeckedticket ,s.code as schedulename,st.name as reachname,ot.name as ticketoutname, ")
		.append(" r.name as routename,t.ticketno,t.id sellid,(case when vci.id > 0 then 1 else 0 end) isinroom ")
		.append(" from Ticketsell t ,vipconsumeldetail vsd left join viproomcheckin vci on vsd.sellid=vci.ticketsellid,vipconsume vs,")
		.append(" Vip v,Customer cm,Schedule s,Route r,Station st, Ticketoutlets ot")
		.append(" where s.id = t.scheduleid and st.id = t.reachstationid and r.id=s.routeid")
		.append(" and t.ticketoutletsid = ot.id and ot.id = t.ticketoutletsid and t.ticketstatus = '0' ")
		.append(" and t.id=vsd.sellid and vs.id=vsd.vipconsumeid and v.id=vs.vipid and vs.type=0 ")
		.append(" and t.departdate = trunc(sysdate) and v.customerid =cm.id ")
		.append(" and v.vipcardno = '" +vipcardno+"' ")
		.append(" order by vci.id desc ,t.departtime ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		return query.getResultList();		
	}
	
	/**
	 * 查询会员是否已进入贵宾室
	 * @param propertyFilterList
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public boolean isExitVipIn(long vipid,long ticketsellid) {
		Map<String,Object> map = new HashMap<String, Object>();		
		map.put("vipid", vipid);		
		map.put("ticketsellid", ticketsellid);
		List<Viproomcheckin> viproomcheckin = find(Viproomcheckin.class, map);
		return viproomcheckin!=null && viproomcheckin.size()>0?true:false;
	}								
}
