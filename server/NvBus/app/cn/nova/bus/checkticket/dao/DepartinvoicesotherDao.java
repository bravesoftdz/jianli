package cn.nova.bus.checkticket.dao;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.persistence.Query;

import cn.nova.bus.base.model.Schedule;
import cn.nova.bus.checkticket.model.Departinvoicesother;
import cn.nova.bus.checkticket.model.Departinvoicesotherdetail;
import cn.nova.bus.checkticket.model.Departinvoicesothersell;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.sale.model.Ticketsell;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;
import cn.nova.utils.orm.jpa.ListUtil;

@SuppressWarnings("rawtypes")
public class DepartinvoicesotherDao extends EntityManagerDaoSurport {
	/**
	 * 根据发班id查询发班code
	 * @param Scheduleid
	 * @return
	 */
	
	@SuppressWarnings("unchecked")
	public String queryScheduleCode(Long Scheduleid) {
		StringBuilder sql = new StringBuilder(
				" select t.code from Schedule t  where t.id= :id");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("id", Scheduleid);
		return (String) query.getSingleResult();
	}
	// 售票员手工单营收汇总表
	@SuppressWarnings("unchecked")
	public List<Object> querySum(List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = new StringBuilder();
		sql.append(
				"select u.name as seller,count(d.id) as num,sum(d.ticketnum) as ticketnum,sum(d.totalmoney) as totalmoney")
				.append(" from departinvoicesother d, userinfo u,organization o")
				.append(" where u.id = d.seller").append(" and d.orgid=o.id");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true)).append(
				" group by u.id,u.name");
		System.out.println(sql);
		Query query = em.createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	public List<Object> query(List<PropertyFilter> propertyFilters) {
		StringBuffer sql = new StringBuffer(
				"select 0 as ischoose,u.name unname,d.createby, d.scheduleid, d.id, d.isreturntrip, d.isoriginator, d.departinvoicesno, ");
		sql.append(
				" d.departdate, trim(d.departtime), d.ticketnum, d.totalmoney, d.balancemoney, ")
				.append(" d.stationfee, d.agentfee, d.recordip, d.balancedate, d.createtime, d.updatetime, ")
				.append(" d1.name as d1name, d2.name as d2name, d3.name as d3name, d4.name as d4name, o.name as orgname, ")
				.append(" ste1.name as ste1name, ste2.name as ste2name, s.code as schedulecode, st.name as departname,")
				.append(" v.vehicleno as vehiclename, u.name as createname, us.name as updatename, bs.name as ")
				.append(" balancestationname, ba.balanceno as balancename, dic.value as statusname, d.selfdepartdate, ")
				.append(" d.orgid, d.vehicleid, d.departstationid, d1.id as driver1id, d2.id as driver2id, d3.id as driver3id, ")
				.append(" d4.id as driver4id, ste1.id as steward1id, ste2.id as steward2id,trim(s.starttime) starttime,d.datafrom,")
				.append(" dtd.value ,d.balanceunitid,ui.name as balanceunitname,un.name unitname,dd1.value as isauditvalue  ")
				.append(" ,d.seller as sellerid,u1.name seller,ddnd.value workwayname,r.name routename,un.fullname,")
				.append(" et.name as reachstationname,r.distance,v.seatnum,vt.name as vehicletypename,d.OTHTERFEE,un.code unitcode")
				.append(" from Departinvoicesother d ")
				.append(" left join driver d1 on d.driver1id=d1.id  left join  driver d2 on d.driver2id=d2.id ")
				.append(" left join driver d3 on d.driver3id=d3.id left join  driver d4 on d.driver4id=d4.id ")
				.append(" left join unit ui on ui.id = d.balanceunitid ")
				.append(" left join userinfo u1 on u1.id = d.seller ")
				.append(" left join steward ste1 on d.steward1id=ste1.id left join steward ste2 on d.steward2id=ste2.id ")
				.append(" left join balance ba on d.balanceid=ba.id left join station bs on d.balancestationid=bs.id ")
				//.append(" left join schedule s on d.scheduleid=s.id, Station st, Vehicle v, Userinfo u, Userinfo us, ")
				.append(" left join schedule s on d.scheduleid=s.id left join Station st on d.departstationid = st.id ")
				.append(" left join route r on s.routeid = r.id  left join Station et on r.endstationid = et.id")
				.append(" left join Vehicle v on   d.vehicleid = v.id left join vehicletype vt on v.vehicletypeid = vt.id")
				.append(" left join Unit un on  v.unitid = un.id left join Userinfo u on d.createby = u.id")
				.append(" left join Userinfo us on d.updateby = us.id,")
				.append(" Digitaldictionary dig, Digitaldictionarydetail dic, Organization o, Digitaldictionarydetail dtd, ")
				.append(" Digitaldictionary dt1, Digitaldictionarydetail dd1, Digitaldictionary ddn, Digitaldictionarydetail ddnd ")
				// 新增数据字典关联查询手工单的审核状态 20150901 by liyi
				.append(" where  ddn.tablename = 'schedule' ")
				.append(" and ddn.columnname = 'workways'  and ddn.id=ddnd.digitaldictionaryid   and ddnd.code=s.workways ")
				.append(" and dtd.digitaldictionaryid=121 and dtd.code=d.datafrom ")
				.append(" and dig.tablename='departinvoices' ")
				.append(" and dig.columnname='status' and dic.digitaldictionaryid=dig.id and dic.code=d.status  ")
				.append(" and dt1.tablename='departinvoicesother' and dt1.columnname='isaudit' and dd1.digitaldictionaryid=dt1.id ")
				// 新增数据字典的关联关系
				.append(" and dd1.code = d.isaudit and")
				.append(" d.orgid=o.id ");
		sql.append(PropertyFilter.toJpql(propertyFilters, true));
		Query query = em.createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilters);
		return query.getResultList();
	}

	public List getResult(long id) {
		StringBuffer sql = new StringBuffer(
				"select t from Departinvoicesotherdetail t where t.departinvoicesotherid=");
		sql.append(id);
		Query query = getEntityManager().createQuery(sql.toString());
		return query.getResultList();
	}

	// 根据结算车辆获取该车辆的回程结算信息
	@SuppressWarnings("unchecked")
	public List<Departinvoicesother> getInvoicesotherBalance(long balanceunitid) {
		StringBuffer sql = new StringBuffer("select d from ")
				.append(" Departinvoicesother d,Vehicle v")
				.append(" where d.vehicleid=v.id and v.balanceunitid=:balanceunitid")
				.append(" and d.status='0'");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("balanceunitid", balanceunitid);
		return query.getResultList();
	}

	// 根据结算车辆获取该车辆的回程结算信息
	@SuppressWarnings("unchecked")
	public List<Departinvoicesother> qryInvoicesotherBalance(String vehicleids) {
		StringBuffer sql = new StringBuffer("select d from ")
				.append(" Departinvoicesother d")
				.append(" where d.vehicleid in " + vehicleids)
				.append(" and d.status='0'");
		Query query = getEntityManager().createQuery(sql.toString());
		return query.getResultList();
	}

	// 审核手工单，修改审核状态为审核
	public boolean audit(String departinvoiceid) {
		int re = 0;
		String[] ids = departinvoiceid.split(",");
		for (String id : ids) {
			String sql = "update departinvoicesother set isaudit = '1' where id =:departinvoiceid";
			Query query = getEntityManager().createNativeQuery(sql.toString());
			query.setParameter("departinvoiceid", id);
			re = query.executeUpdate();
			if (re == 0)
				return false;
		}
		return true;
	}

	// 取消审核手工单，修改审核状态为未审核
	public boolean cancelaudit(String departinvoiceid) {
		int re = 0;
		String[] ids = departinvoiceid.split(",");
		for (String id : ids) {
			String sql = "update departinvoicesother set isaudit = '0' where id =:departinvoiceid";
			Query query = getEntityManager().createNativeQuery(sql.toString());
			query.setParameter("departinvoiceid", id);
			re = query.executeUpdate();
			if (re == 0)
				return false;
		}
		return true;
	}

	public List<Object> queryDepartinvoicesotherSimple(
			List<PropertyFilter> propertyFilterList) {
		StringBuffer sql = new StringBuffer();
		sql.append(
				"  select t.id as id , t.departinvoicesno as departinvoicesno, t.vehicleid as vehicleid, v.vehicleno as vehicleno, ")
				.append(" t.scheduleid as scheduleid, s.code as schedulecode, r.id as routeid, r.name as routename, t.departdate as departdate, trim(t.departtime) as departtime, ")
				.append(" t.ticketnum as ticketnum, t.pieces as pieces, t.totalmoney as totalmoney, t.seller as sellerid, u.name as sellername ")

				.append(" from departinvoicesother t left join organization o on t.orgid=o.id ")
				.append(" left join vehicle v on t.vehicleid = v.id ")
				.append(" left join schedule s on t.scheduleid = s.id ")
				.append(" left join route r on s.routeid = r.id ")
				.append(" left join userinfo u on t.seller=u.id ")
				.append(" where 1=1 ");

		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		Query query = em.createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}
	
	public List<Object> queryDepartinvoicesotherTicketno(
			List<PropertyFilter> propertyFilterList) {
		StringBuffer sql = new StringBuffer();
		sql.append("  select t.id as id , t.departinvoicesno as departinvoicesno, t.vehicleid as vehicleid, v.vehicleno as vehicleno,ss.id as reachstationid,ss.name as reachstationname, ")
		.append(" t.scheduleid as scheduleid, s.code as schedulecode,t.departdate as departdate, ")
		.append(" t.ticketnum as ticketnum, t.totalmoney as prices, ")
		.append(" t.totalmoney as totalmoney,t.agentfee as agentfee,t.stationfee as stationfee,")
		.append(" t.seller as seller, ui.name as sellername,t.balanceby as balanceby, u.name as balancename ")
		.append(" ,t.createtime as createtime,t.othterfee as othterfee,t.balancemoney as balancemoney,t.datafrom as datafrom,dd.value as datafromname,ut.name as unitname ")
		.append(" from departinvoicesother t left join organization o on t.orgid=o.id ")
		.append(" left join vehicle v on t.vehicleid = v.id ")
		.append(" left join unit ut on ut.id = v.unitid ")
		.append(" left join schedule s on t.scheduleid = s.id ")
		.append(" left join route r on s.routeid = r.id ")
		.append(" left join station ss on r.endstationid = ss.id")
		.append(" left join userinfo u on t.balanceby=u.id ")
		.append(" left join userinfo ui on t.seller=ui.id ")
		.append(" left join (select dd.code,dd.value,d.name from digitaldictionary d left join digitaldictionarydetail dd")
		.append(" on d.id = dd.digitaldictionaryid where d.tablename = 'departinvoicesother' and d.columnname = 'datafrom') dd on dd.code = t.datafrom")
		.append(" where 1=1 ");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		Query query = em.createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}

	public Schedule getScheduleByRouteid(Long routeid) {
		StringBuffer sql = new StringBuffer();
		sql.append("select s from Route r, Schedule s where r.id = s.route.id and s.isactive=1 and r.id = :routeid");

		Query query = em.createQuery(sql.toString());
		query.setParameter("routeid", routeid);
		List<Schedule> list = query.getResultList();

		return null != list && list.size() > 0 ? list.get(0) : null;
	}

	public boolean qryDepartinvoicesother(String departinvoicesno, Long id) {
		StringBuffer sql = new StringBuffer();
		if (id == 0) {
			sql.append("select t from Departinvoicesother t where t.departinvoicesno=:departinvoicesno and t.status<>'1'");
			Query query = em.createQuery(sql.toString());
			query.setParameter("departinvoicesno", departinvoicesno);
			List<Departinvoicesother> list = query.getResultList();
			return null != list && list.size() > 0 ? true : false;
		} else {
			sql.append("select t from Departinvoicesother t where t.departinvoicesno=:departinvoicesno and t.status<>'1' and t.id<>:id");
			Query query = em.createQuery(sql.toString());
			query.setParameter("departinvoicesno", departinvoicesno);
			query.setParameter("id", id);
			List<Departinvoicesother> list = query.getResultList();
			return null != list && list.size() > 0 ? true : false;
		}
	}

	public List<Object> queryInvoiceByNo(String departinvoiceno) {
		StringBuffer sql = new StringBuffer();
		sql.append(" select count(do.departinvoicesno) isexist from  departinvoicesother do where do.departinvoicesno=:departinvoiceno");
		Query query = em.createNativeQuery(sql.toString());
		query.setParameter("departinvoiceno", departinvoiceno);
		List<Object> list = query.getResultList();
		return list;
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
	public List<Departinvoicesotherdetail> qryDepartinvoicesotherdetail(long departinvoicesotherid){
		
		StringBuffer sql = new StringBuffer("select t from Departinvoicesotherdetail t where t.status='0' ");
		sql.append(" and departinvoicesotherid=:departinvoicesotherid ");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("departinvoicesotherid", departinvoicesotherid);		
		return query.getResultList();
	}
	public void updateDepartinvoicedetailDateById(long id, Date departdate) {
		StringBuffer sql = new StringBuffer("");
		sql.append(" update departinvoicesotherdetail di set di.departdate=:departdate where di.departinvoicesotherid=:id");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("departdate", departdate);
		query.setParameter("id", id);
		query.executeUpdate();
	}	
	/**
	 * @Title deleteDepartinvoicesothersellByDepartinvoicesotherid
	 * @Description 按照 运量单明细 ID 删除关联表数据
	 * @param departinvoicesotherid 
	 * void 
	 * @author tianhb
	 * @date 2016年6月14日-下午10:04:17
	 * @update 
	 * @throws
	 */
	public void deleteDepartinvoicesothersellByotherid(Long departinvoiceotherid) {
		StringBuffer sb = new StringBuffer();
		sb.append(" delete departinvoicesothersell d where d.departinvoicesotherdetailid in ( ")
		  .append(" select dd.id from departinvoicesother do ,departinvoicesotherdetail dd ")
		  .append(" where do.id = dd.departinvoicesotherid and do.id = :departinvoiceotherid ) ");
		Query query = getEntityManager().createNativeQuery(sb.toString());
		query.setParameter("departinvoiceotherid", departinvoiceotherid);		
		query.executeUpdate();
		StringBuffer sql = new StringBuffer();
		sql.append(" delete departinvoicesotherdetail d where d.departinvoicesotherid = :departinvoiceotherid");
		query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("departinvoiceotherid", departinvoiceotherid);		
		query.executeUpdate();
	}
	/**
	 * @return 
	 * @Title qryTicketsellidByOtherid
	 * @Description 根据结算单补录明细 ID 查询车票ID
	 * @param departinvoicesotherdetailid 
	 * void 
	 * @author tianhb
	 * @date 2016年6月28日-下午3:16:16
	 * @update 
	 * @throws
	 */
	public List qryTicketsellidByOtherid(Long otherid) {
		StringBuffer sql =new StringBuffer();
		sql.append(" select dos.ticketsellid ")
		.append(" from departinvoicesothersell dos ")
		.append(" left join departinvoicesotherdetail dd on dos.departinvoicesotherdetailid = dd.id")
		.append(" where dd.departinvoicesotherid = :otherid");
		Query query = em.createNativeQuery(sql.toString());
		query.setParameter("otherid", otherid);
		List list = query.getResultList();
		return list;
	}
	/**
	 * @Title qryTicketsellidByOtherdetailid
	 * @Description 根据结算单补录 ID 查询车票ID
	 * @param otherdetailid
	 * @return List 
	 * @author tianhb
	 * @date 2016年6月28日-下午7:00:48
	 * @update 
	 * @throws
	 */
	public List qryTicketsellidByOtherdetailid(Long otherdetailid) {
		StringBuffer sql =new StringBuffer();
		sql.append(" SELECT dos.ticketsellid")
		.append(" FROM departinvoicesothersell dos ")
		.append(" WHERE dos.departinvoicesotherdetailid = :otherdetailid");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("otherdetailid", otherdetailid);
		List list = query.getResultList();
		return list;
	}
	/**
	 * 根据售票id查询所有车票然后按照票种和到站分组
	 * @param ticketsellids
	 * @return
	 */
	public List<Ticketsell> getTicketsellList(String ticketsellids) {
		StringBuffer sql =new StringBuffer();
		sql.append(" select t from Ticketsell t where t.ticketstatus = '0' and t.id in ("+ticketsellids+")");
		Query query = getEntityManager().createQuery(sql.toString());
		List<Ticketsell> list = query.getResultList();
		if(list!=null&&!list.isEmpty()){
			return list;
		}else{
			return null;
		}
	}

	public Long queryTicketTypeByTypeCode(String tickettype) {
		StringBuffer sql =new StringBuffer();
		sql.append(" select t.id from tickettype t where t.isactive = 1 and t.code = :tickettype");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("tickettype",tickettype);
		List list = query.getResultList();
		if(list!=null&&list.size()>0){
			BigDecimal b = (BigDecimal) list.get(0);
			return b.longValue();
		}else{
			return 0L;
		}
	}
	public List<Departinvoicesotherdetail> queryDepartinvoicesotherdetailById(Long id,String ticketsellid) {
		StringBuffer sql =new StringBuffer();
		sql.append(" select distinct dod from Departinvoicesother do,Departinvoicesotherdetail dod,Departinvoicesothersell ds ") 
		   .append(" where do.id = dod.departinvoicesotherid ")
		   .append(" and do.id = :id ")
		   .append(" and ds.departinvoicesotherdetailid = dod.id and ds.ticketsellid in ("+ticketsellid+")");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("id",id);
		List list = query.getResultList();
		if(list!=null&&list.size()>0){
			return list;
		}else{
			return null;
		}
	}
	public void deleteDepartinvoicesothersellByDetailid(Long departinvoicesotherdetailid) {
		StringBuffer sql = new StringBuffer();
		sql.append(" delete from departinvoicesothersell ds where ds.departinvoicesotherdetailid =:departinvoicesotherdetailid");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("departinvoicesotherdetailid", departinvoicesotherdetailid);		
		query.executeUpdate();
	}
	public void deleteDepartinvoicesellByticketid(String ticketid) {
		StringBuffer sql = new StringBuffer();
		sql.append(" delete from departinvoicesothersell ds where ds.ticketsellid in("+ ticketid +")");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.executeUpdate();
	}
	public int queryDetailsize(Long departinvoicesotherdetailid) {
		StringBuffer sql =new StringBuffer();
		sql.append(" select dod from Departinvoicesothersell dod where dod.departinvoicesotherdetailid =:departinvoicesotherdetailid");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("departinvoicesotherdetailid",departinvoicesotherdetailid);
		List list = query.getResultList();
		if(list!=null&&list.size()>0){
			return query.getResultList().size();
		}else{
			return 0;
		}
	}
	public List<Departinvoicesothersell> querydepartinvoicesothersells(long id, String ticketsellids) {
		StringBuffer sql =new StringBuffer();
		sql.append(" select ds from Departinvoicesother do,Departinvoicesotherdetail dod,Departinvoicesothersell ds ") 
		   .append(" where do.id = dod.departinvoicesotherid ")
		   .append(" and do.id = :id ")
		   .append(" and ds.departinvoicesotherdetailid = dod.id and ds.ticketsellid in ("+ticketsellids+")");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("id",id);
		List list = query.getResultList();
		if(list!=null&&list.size()>0){
			return list;
		}else{
			return null;
		}
	}
	public List<Departinvoicesotherdetail> queryDepartinvoicesotherdetailById(Long id) {
		StringBuffer sql =new StringBuffer();
		sql.append(" select dod from Departinvoicesotherdetail dod") 
		   .append(" where dod.departinvoicesotherid = :id ");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("id",id);
		List list = query.getResultList();
		if(list!=null&&list.size()>0){
			return list;
		}else{
			return null;
		}
	}
	public Integer findotherdetailsellbysellid(Long sellid) {
		StringBuffer sql =new StringBuffer();
		sql.append(" select count(1) from departinvoicesothersell ds,departinvoicesotherdetail dod ")
		   .append(" where ds.departinvoicesotherdetailid = dod.id and ds.ticketsellid = :sellid ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("sellid",sellid);
		List list = query.getResultList();
		if(list!=null&&list.size()>0){
			return ((BigDecimal) list.get(0)).intValue();
		}else{
			return 0;
		}
	}
	
	public Departinvoicesother finddepartinvoicesotherbysellid(Long sellid) {
		StringBuffer sql =new StringBuffer();
		sql.append(" select do from Departinvoicesother do,Departinvoicesotherdetail dod,Departinvoicesothersell ds ") 
		   .append(" where do.id = dod.departinvoicesotherid ")
		   .append(" and ds.departinvoicesotherdetailid = dod.id ")
		   .append(" and ds.ticketsellid = :sellid ");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("sellid",sellid);
		List list = query.getResultList();
		if(list!=null&&list.size()>0){
			return (Departinvoicesother) list.get(0);
		}else{
			return null;
		}
	}
	public List<Object> checkdepartinvoicesell(Long departinvoicesotherid) {
		StringBuffer sql =new StringBuffer();
		sql.append(" select dos ")
		.append(" from Departinvoicesothersell dos ")
		.append(" , Departinvoicesotherdetail dd ")
		.append(" where dos.departinvoicesotherdetailid = dd.id and dd.departinvoicesotherid = :otherid");
		Query query = em.createQuery(sql.toString());
		query.setParameter("otherid", departinvoicesotherid);
		List list = query.getResultList();
		if(list==null||list.size() < 1){
			return list;
		}else{
			return list;
		}
	}
	/**
	 * 根据otherid查询出所有的detail明细然后重新进行other赋值
	 * @param departinvoicesotherid
	 * @return
	 */
	public List<Departinvoicesotherdetail> querydepartinvoicesotherd(Long departinvoicesotherid) {
		StringBuffer sql =new StringBuffer();
		sql.append(" select dd ")
		.append(" from Departinvoicesotherdetail dd ")
		.append(" where dd.departinvoicesotherid =:departinvoicesotherid");
		Query query = em.createQuery(sql.toString());
		query.setParameter("departinvoicesotherid", departinvoicesotherid);
		List list = query.getResultList();
		if(list==null||list.size() < 1){
			return list;
		}else{
			return list;
		}
	}
	
}
