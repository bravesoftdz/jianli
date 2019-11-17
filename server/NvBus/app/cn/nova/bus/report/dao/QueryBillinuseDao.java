package cn.nova.bus.report.dao;

import java.util.Date;
import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.common.ConstDefiniens;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

@SuppressWarnings("rawtypes")
public class QueryBillinuseDao extends EntityManagerDaoSurport {

	/**
	 * 售票员票证使用情况查询
	 * 
	 * @param startdate
	 * @param enddate
	 * @param recipients
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> qryBillinuseReport(Date startdate, Date enddate,
			Long recipients, String status) {
		StringBuffer sql = new StringBuffer("select u.code, u.name, ");
		sql.append(
				" b.startno, b.endno, b.nextno, (b.endno-b.startno+1) as total, ")
				.append(" (b.endno-b.nextno+1) leftnum, (b.nextno-b.startno) as usenum, ")
				.append(" (select count(tr.id) from ticketreturn tr where to_number(tr.returnvoucherno)>= b.startno and ")
				.append(" to_number(tr.returnvoucherno) <= b.endno and to_date(tr.returntime)>=:startdate and ")
				.append(" to_date(tr.returntime)<=:enddate and tr.returnby=b.recipients) as returnnum, ")
				.append(" nvl(((select sum(ti.sellnum) from ticketturnoverdetail ti where ti.seller=b.recipients and ")
				.append(" to_number(ti.ticketstartno)>=b.startno and to_number(ti.ticketendno)<=b.endno and ")
				.append(" ti.moneydate>=:startdate and ti.moneydate<=:enddate) - ")
				.append(" (select sum(ti.cancelnum) from ticketturnoverdetail ti where ti.seller=b.recipients and ")
				.append(" to_number(ti.ticketstartno)>=b.startno and to_number(ti.ticketendno)<=b.endno and ")
				.append(" ti.moneydate>=:startdate and ti.moneydate<=:enddate)),0) as sellnum, ")
				.append(" nvl((select sum(ti.cancelnum) from ticketturnoverdetail ti where ti.seller=b.recipients and ")
				.append(" to_number(ti.ticketstartno)>=b.startno and to_number(ti.ticketendno)<=b.endno and ")
				.append(" ti.moneydate>=:startdate and ti.moneydate<=:enddate),0) as cancelnum, ")
				.append(" nvl((select sum(bi.endno-bi.startno+1) from billdamaged bi where bi.billinuseid = b.id and to_date(bi.recordtime)>=:startdate and ")
				.append(" to_date(bi.recordtime)<=:enddate),0) as damagednum ")
				.append(" from billinuse b, userinfo u, billtype bi where b.recipients=u.id ")
				.append(" and b.billtypeid=bi.id and bi.code='Ticket' and (b.endno-b.startno+1)>0 ")
				.append(" and to_date(b.createtime)<=:enddate");
		if (recipients != null) {
			sql.append(" and b.recipients=");
			sql.append(recipients);
		}
		if (status != null && !"".equals(status)) {
			sql.append(" and b.status !=" + status);
		}
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("startdate", startdate);
		query.setParameter("enddate", enddate);
		return query.getResultList();
	}

	/**
	 * 站务分公司使用票证明细帐
	 * 
	 * @param orgids
	 * @param startdate
	 * @param enddate
	 * @param recipients
	 * @param status
	 * @param biitype
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> queryBilldetailReport(String orgids, Date startdate,
			Date enddate, Long recipients, String status, Long billtype,
			Long storageid) {
		StringBuffer sql = new StringBuffer();
		sql.append(" select o.name orgname,u.name sellbyname,bn.createtime,bs.name bsname, ");
		sql.append(" bt.code btcode,bt.name btname,bn.startno,bn.nextno,(bn.startno|| '-' || bn.endno) billno,(bn.endno-bn.startno+1) as total,(bn.endno-bn.nextno+1) leftnum, ");
		sql.append(" (case bt.code when 'Ticket' then (select count(tf.ticketno) from ticketchargeoff tf where tf.ticketno between bn.startno and bn.endno+1) else 0 end) caoffnum  ");
		sql.append(" from organization o,billinuse bn,billinventory bnt, userinfo u,billtype bt,Billstorage bs ");
		sql.append(" where o.id=u.orgid and u.id=bn.recipients and bn.billtypeid=bt.id ");
		sql.append(" and bs.id=bnt.storageid and bnt.id=bn.billinventoryid ");
		sql.append(" and bn.createtime between :startdate and :enddate  ");
		if (recipients != null) {
			sql.append(" and bn.recipients=" + recipients);
		}
		if (status != null && !"".equals(status)) {
			sql.append(" and bn.status='" + status + "'");
		}

		if (billtype != null) {
			sql.append(" and bn.billtypeid=" + billtype);
		}

		if (storageid != null) {
			sql.append(" and bs.id=" + billtype);
		}
		if (orgids != null && !"".equals(orgids)) {
			sql.append(" and o.id in" + orgids);
		}

		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("startdate", startdate);
		query.setParameter("enddate", enddate);
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	public List<Object> queryTicketReport(String orgids, Long sellby,
			String ticketstatus, String startticketno, String endticketno,
			Date startselltime, Date endselltime) {

		StringBuffer sql = new StringBuffer("");
	

		sql.append(" select orgname,");
		sql.append(" to_char(min(startselltime),'yyyy-mm-dd') startselltime,to_char(max(endselltime),'yyyy-mm-dd') endselltime,");
		sql.append("  min(startticketno) startticketno,max(endticketno) endticketno, ");
		sql.append("  nvl(sum(z_sellnum),0) z_sellnum,nvl(sum(z_totalamount),0) z_totalamount,nvl(sum(r_sellnum),0) r_sellnum,");
		sql.append("  nvl(sum(r_totalamount),0) r_totalamount,nvl(sum(c_sellnum),0) c_sellnum,nvl(sum(c_totalamount),0) c_totalamount,");
		sql.append("  nvl(sum(z_sellnum+r_sellnum+c_sellnum),0) sellnum,");
		sql.append("  nvl(sum(z_totalamount+r_totalamount+c_totalamount),0) totalamount,");
		sql.append("  nvl(sum(b_sellnum),0) b_sellnum,nvl(sum(returnvouchernum),0) returnvouchernum,");
		sql.append("  nvl(sum(z_sellnum + r_sellnum + c_sellnum+b_sellnum+returnvouchernum),0) totalnum");
		
		sql.append(" from ( ");
		sql.append(" select org.name orgname,t.sellby sellby,min(t.selltime) startselltime,max(t.selltime) endselltime,");
		sql.append("  min(t.ticketno) startticketno,max(t.ticketno) endticketno, ");
		sql.append("  (case when t.ticketstatus=0 then count(t.id) else 0 end) z_sellnum,");
		sql.append("  (case when t.ticketstatus=0 then sum(t.price) else 0  end) z_totalamount,");
		sql.append("  (case when t.ticketstatus=1 then count(t.id) else 0 end) r_sellnum,");
		sql.append("  (case when t.ticketstatus=1 then sum(t.price) else 0  end) r_totalamount,");
		sql.append("  (case when t.ticketstatus=2 then count(t.id) else 0 end) c_sellnum,");
		sql.append("  (case when t.ticketstatus=2 then sum(t.price) else 0 end) c_totalamount,");
		sql.append("  0 b_sellnum, 0 returnvouchernum,1 type");
		sql.append("  from Ticketsell t,Organization org where org.id=t.orgid ");
		if (orgids != null && !"".equals(orgids)) {
			sql.append("  and t.orgid in " + orgids + "");
		}
		if (sellby != null) {
			sql.append("  and t.sellby =" + sellby);
		}
		if (ticketstatus != null && !"".equals(ticketstatus)) {
			sql.append("  and t.ticketstatus = '" + orgids + "'");
		}
		if (startselltime != null && endselltime != null) {
			sql.append(" and t.selltime between :startselltime and :endselltime");
		}
		if (startticketno != null && endticketno != null
				&& !"".equals(startticketno + endticketno)) {
			sql.append(" and t.ticketno between '" + startticketno + "' and '"
					+ endticketno + "' ");
		}
		sql.append(" and (length(t.ticketno) = 12 or length(t.ticketno) = 8) ");//团体票按一张票证统计，写死票号长度为12或8位，否则团体票统计多张
		sql.append("  group by t.ticketstatus,t.sellby,org.name");
		// --坏票数
		sql.append(" union ");
		sql.append(" select org.name orgname,b.recordby sellby,min(recordtime) startselltime,  max(recordtime) endselltime,");
		sql.append(" lpad(min(b.startno),min((select bt.ticketnolength from billtype bt where bt.code='"
				+ ConstDefiniens.TICKET + "')),0) startticketno,");
		sql.append(" lpad(max(b.endno),min((select bt.ticketnolength from billtype bt where bt.code='"
				+ ConstDefiniens.TICKET + "')),0) endticketno,");
		sql.append(" 0 z_sellnum,0 z_totalamount, 0 r_sellnum, 0 r_totalamount, 0 c_sellnum, 0 c_totalamount, sum(b.amount) b_sellnum,0 returnvouchernum,");
		sql.append(" 1 type from Billdamaged b,organization org,userinfo u, billtype bt, Billinuse bu where b.billtypeid = bt.id and bt.code = '"
				+ ConstDefiniens.TICKET + "'");
		sql.append(" and bu.billtypeid = bt.id and b.billinuseid = bu.id and u.id = bu.recipients and org.id=u.orgid ");
		if (orgids != null && !"".equals(orgids)) {
			sql.append("  and org.id in " + orgids + "");
		}
		if (startticketno != null && endticketno != null
				&& !"".equals(startticketno + endticketno)) {

			sql.append("  and b.startno>='" + startticketno
					+ "' and b.endno<='" + endticketno + "'");

		}
		if (sellby != null) {
			sql.append("  and b.recordby =" + sellby);
		}
		
		if (startselltime != null && endselltime != null) {
			sql.append(" and b.recordtime between :startselltime and :endselltime");

		}
		// 退票凭证数
		sql.append(" group by b.recordby,org.name union ");
		sql.append(" select org.name orgname,tr.returnby sellby,min(returntime) startselltime, max(returntime) endselltime, min(returnvoucherno) startticketno,");
		sql.append(" max(returnvoucherno) endticketno,0 z_sellnum, 0 z_totalamount, 0 r_sellnum, 0 r_totalamount,");
		sql.append(" 0 c_sellnum, 0 c_totalamount, 0 b_sellnum, count(tr.id) returnvouchernum, 1 type");
		sql.append(" from Ticketreturn tr,organization org,Userinfo u, billtype bt  where tr.billtypeid = bt.id and bt.code = '"
				+ ConstDefiniens.TICKET + "' ");
		// and length(tr.returnvoucherno)>0
		sql.append(" and org.id=u.orgid and u.id=tr.returnby ");
		
		if (orgids != null && !"".equals(orgids)) {
			sql.append("  and org.id in " + orgids + "");
		}
		if (startticketno != null && endticketno != null
				&& !"".equals(startticketno + endticketno)) {

			sql.append("  and tr.returnvoucherno>='" + startticketno
					+ "' and tr.returnvoucherno<='" + endticketno + "'");

		}
		
		if (startselltime != null && endselltime != null) {
			sql.append(" and tr.returntime between :startselltime and :endselltime");

		}
		
		if (sellby != null) {
			sql.append("  and tr.returnby =" + sellby);
		}
		
		sql.append("  group by tr.returnby,org.name)");
		sql.append(" group by type,orgname");

		Query query = getEntityManager().createNativeQuery(sql.toString());
		if (startselltime != null && endselltime != null) {
			query.setParameter("startselltime", startselltime);
			query.setParameter("endselltime", endselltime);
		}

		List<Object> list = query.getResultList();
		return list;

	}
	
	/**车票换号重打查询
	 * @param propertyFilters
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> queryTicketReprint(List<PropertyFilter> propertyFilters){
		StringBuffer sql = new StringBuffer();
		sql.append(" select trp,org.name as orgname,su.name as sellname,cu.name as changename,st.name as departstationname,et.name as reachstationname ");
		sql.append(" from Ticketreprint trp,Station st,Station et,Organization org,Userinfo su,Userinfo cu ");
		sql.append("  where st.id=trp.departstationid and et.id=trp.reachstationid and org.id=trp.sellorgid ");
		sql.append("  and su.id=trp.sellby and cu.id=trp.changeby ");
		sql.append(PropertyFilter.toJpql(propertyFilters, true));

		Query query = getEntityManager().createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilters);
		List<Object> list=query.getResultList();
		return list;
	}
	
}
