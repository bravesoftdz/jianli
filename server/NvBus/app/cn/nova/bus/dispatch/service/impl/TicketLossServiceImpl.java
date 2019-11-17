package cn.nova.bus.dispatch.service.impl;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.persistence.Query;

import play.Logger;
import play.db.jpa.GenericModel;
import play.db.jpa.JPA;
import util.CommonUtil;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.dispatch.model.TicketLoss;
import cn.nova.bus.dispatch.service.TicketLossService;
import cn.nova.bus.sale.model.Ticketsell;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;
import cn.nova.utils.orm.jpa.ListUtil;

public class TicketLossServiceImpl implements TicketLossService {

	@Override
	public List<Map<String, Object>> query(TicketLoss tl) {
		// TODO Auto-generated method stub
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		List list = null;
		List<Map<String, Object>> result = null;
		StringBuffer sql = new StringBuffer("select ");
		sql.append(" tl.id,")
		   .append(" u1.name as lossreportername,")
		   .append(" tl.losstime,")
		   .append(" decode(tl.status, 0, '取消挂失', 1, '挂失') status,")
		   .append(" ts.departdate,")
		   .append(" TRIM(ts.departtime),")
		   .append(" s.code as schedulecode,")
		   .append(" st.name as reachstationname,")
		   .append(" ts.selltime,")
		   .append(" ts.seatno,")
		   .append(" ts.ticketno,")
		   .append(" u2.name as sellby,")
		   .append(" o.name as sellstationname,")
		   .append(" ts.sellip,")
		   .append(" ts.price")
		   .append(" from")
		   .append(" ticketloss tl, ticketsell ts, schedule s, station st, userinfo u1, userinfo u2, organization o")
		   .append(" where")
		   .append("  tl.ticketsellid = ts.id")
		   .append(" and tl.scheduleid = s.id")
		   .append(" and ts.reachstationid = st.id")
		   .append(" and tl.lossby = u1.id")
		   .append(" and ts.sellby = u2.id")
		   .append(" and ts.orgid = o.id");
		if(tl.getLossby() != null && tl.getLossby() > 0){
			sql.append(" and tl.lossby="+tl.getLossby());
		}
		if (tl.getLosstime() != null) {
			sql.append(" and trunc(tl.losstime)=date'"+sdf.format(tl.getLosstime())+"'");
		}
		if(tl.getStatus() != null){
			sql.append(" and tl.status="+tl.getStatus());
		}
//		   .append(PropertyFilter.toJpql(propertyFilterList, true));
		Logger.info("sql-->"+sql.toString());
		Query query = JPA.em().createNativeQuery(sql.toString());
//		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		list = query.getResultList();
		result = ListUtil.listToMap(new Object[] {
				"id", "lossreportername", "losstime", "status", "departdate", "departtime", "schedulecode", "reachstationname", "selltime",
				"seatno", "ticketno", "sellby", "sellstationname", "sellip","price"}, list, new Object[] {
				Long.class, String.class, Date.class, String.class, Date.class, String.class,   String.class,  String.class,  Date.class,
				String.class, String.class, String.class, String.class, String.class, BigDecimal.class});
		
		return result;
	}

	@Override
	public boolean save(TicketLoss tl) {
		// TODO Auto-generated method stub
		EntityManagerDaoSurport dao = new EntityManagerDaoSurport();
		try{
			if (tl.getId() != null && tl.getId() > 0) {
				dao.merge(tl);
			} else {
				dao.save(tl);
			}
		} catch(Exception e) {
			play.Logger.error(e.getMessage(), e);
			return false;
		}
		return true;
	}
	/**
	 * @Title queryTicketSell
	 * @Description 生产调度-车票挂失 增加挂失时查询车票信息
	 * @param ts
	 * @return 
	 * List<Map<String,Object>> 
	 * @author
	 * @date 2017年4月11日-上午9:12:15
	 * @update  tianhb
	 * @throws
	 */
	public List<Map<String, Object>> queryTicketSell(Ticketsell ts) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		List list = null;
		List<Map<String, Object>> result = null;
		StringBuffer sql = new StringBuffer("select ");
		sql.append(" ts.id,")
		   .append(" s.code as schedulecode,")
		   .append(" ts.departdate,")
		   .append(" TRIM(ts.departtime),")
		   .append(" st.name as reachstationname,")
		   .append(" ts.seatno,")
		   .append(" ts.ticketno,")
		   .append(" ts.price,")
		   .append(" o.name as sellstationname,")
		   .append(" u.name as sellby,")
		   .append(" ts.sellip,")
		   .append(" ts.selltime")
			//add by tianhb 2017年4月10日 任务7460:车票挂失功能，新增挂失时，需要增加查询条件（旅客身份证信息、旅客姓名）来查询,查询结果增加证件类型,证件号,旅客姓名  begin
		   .append(" ,ts.certificatetypename,ts.certificateno,ts.customername")
			//add by tianhb 2017年4月10日  任务7460:车票挂失功能，新增挂失时，需要增加查询条件（旅客身份证信息、旅客姓名）来查询,查询结果增加证件类型,证件号,旅客姓名  end
		   
		   .append(" from")
		   .append(" ticketsell ts, schedule s, station st, userinfo u, organization o")
		   .append(" where")
		   .append("  ts.scheduleid = s.id")
		   .append(" and ts.reachstationid = st.id")
		   .append(" and ts.orgid = o.id")
		   .append(" and ts.sellby = u.id")
		   .append(" and ts.TICKETSTATUS='0'");
		if(ts.getScheduleid() != 0 && !"".equals(ts.getScheduleid())){
			sql.append(" and ts.scheduleid="+ts.getScheduleid());
		}
		if (ts.getDepartdate()!=null) {
			sql.append(" and ts.departdate= date'"+sdf.format(ts.getDepartdate())+"'");
		}
		if (ts.getDeparttime() != null && !"".equals(ts.getDeparttime())) {
			sql.append(" and ts.departtime='"+ts.getDeparttime()+"'");
		}
		if(ts.getReachstationid() != 0){
			sql.append(" and ts.reachstationid="+ts.getReachstationid());
		}
		//add by tianhb 2017年4月10日 任务7460:车票挂失功能，新增挂失时，需要增加查询条件（旅客身份证信息、旅客姓名）来查询,查询结果增加证件类型,证件号,旅客姓名  begin
		if(CommonUtil.isNotEmptyString(ts.getCertificateno())){
			sql.append(" AND ts.certificateno = '" + ts.getCertificateno() + "'");
		}
		if(CommonUtil.isNotEmptyString(ts.getCustomername())){
			sql.append(" AND ts.customername = '" + ts.getCustomername() + "'");
		}
		//add by tianhb 2017年4月10日  任务7460:车票挂失功能，新增挂失时，需要增加查询条件（旅客身份证信息、旅客姓名）来查询,查询结果增加证件类型,证件号,旅客姓名  end
		Logger.info("sql-->"+sql.toString());
		Query query = JPA.em().createNativeQuery(sql.toString());
		list = query.getResultList();
		result = ListUtil.listToMap(new Object[] {
				"id", "schedulecode", "departdate", "departtime", "reachstationname", "seatno", "ticketno", "price",
				 "sellstationname", "sellby","sellip", "selltime","certificatetypename","certificateno","customername"}, list, new Object[] {
				Long.class, String.class, Date.class, String.class, String.class,  String.class, String.class, BigDecimal.class,
				String.class, String.class, String.class, Timestamp.class,
				//add by tianhb 2017年4月10日 任务7460:车票挂失功能，新增挂失时，需要增加查询条件（旅客身份证信息、旅客姓名）来查询,查询结果增加证件类型,证件号,旅客姓名  begin
				String.class, String.class, String.class});
				//add by tianhb 2017年4月10日  任务7460:车票挂失功能，新增挂失时，需要增加查询条件（旅客身份证信息、旅客姓名）来查询,查询结果增加证件类型,证件号,旅客姓名  end
		return result;
	}
	
	@Override
	public TicketLoss getTicketLossById(Long id) {
		// TODO Auto-generated method stub
		return (TicketLoss) new EntityManagerDaoSurport().get(TicketLoss.class, id);
	}
	@Override
	public List<TicketLoss> getTicketLossByTicketSellId(Long id) {
		// TODO Auto-generated method stub
		String sql = "from TicketLoss tl where tl.ticketsellid="+id;
		Query query = JPA.em().createQuery(sql);
		return (List<TicketLoss>) query.getResultList();
	}

	@Override
	public int update(TicketLoss tl) {
		// TODO Auto-generated method stub
		int count = 0;
		count = new EntityManagerDaoSurport().merge(tl) == null? 0 : 1;
		return count;
	}
}
