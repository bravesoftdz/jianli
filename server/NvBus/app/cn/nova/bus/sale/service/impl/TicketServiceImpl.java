package cn.nova.bus.sale.service.impl;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import util.Encryption;

import cn.nova.bus.bill.model.Billtype;
import cn.nova.bus.bill.service.BilltypeService;
import cn.nova.bus.bill.service.impl.BilltypeServiceImpl;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.sale.dao.TicketDao;
import cn.nova.bus.sale.model.Ticketsell;
import cn.nova.bus.sale.service.TicketService;
import cn.nova.bus.security.Global;
import cn.nova.utils.commons.DateUtils;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;

/**
 * @author lck
 * 
 */

public class TicketServiceImpl implements TicketService {
	
	private TicketDao ticketDao = new TicketDao();
	
	private BilltypeService billtypeService = new BilltypeServiceImpl();

	@Override
	public Ticketsell getTicket(String ticketno) throws ServiceException {
		Ticketsell ticketsell = ticketDao.getTicket(ticketno);
		if (ticketsell == null) {
			throw new ServiceException("0116");
		}
		//添加校验售票记录的密文是否正确
		DateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");
		String datestr = df.format(ticketsell.getSelltime());
		String cipherStr = ticketsell.getOrgid()+datestr+ticketsell.getSellby();
//		if(DateUtils.compare(ticketsell.getSelltime(),ticketsell.getUpdatetime())<=0){
			if(!Encryption.chkTicketno(cipherStr, ticketsell.getTiksno())){
				throw new ServiceException("0500");//售票记录密文错误！
			}
//		}
		return ticketsell;
	}

	@Override
	public Ticketsell getTicket(String ticketno,Date departdate) throws ServiceException {
		Ticketsell ticketsell = ticketDao.getTicket(ticketno,departdate);
		if (ticketsell == null) {
			//该车票不存在，或过了补开天数
			throw new ServiceException("0440");
		}
		//添加校验售票记录的密文是否正确
		DateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");
		String datestr = df.format(ticketsell.getSelltime());
		String cipherStr = ticketsell.getOrgid()+datestr+ticketsell.getSellby();
		//更换为job执行，不再校验
//		if(DateUtils.compare(ticketsell.getSelltime(),ticketsell.getUpdatetime())<=0){
			if(!Encryption.chkTicketno(cipherStr, ticketsell.getTiksno())){
				throw new ServiceException("0500");
			}
//		}
		return ticketsell;
	}
	
	@Override
	public Ticketsell getTicket(long scheduleplanid, Short seatno)
			throws ServiceException {
		Ticketsell ticketsell = ticketDao.getTicket(scheduleplanid, seatno);
		if (ticketsell == null) {
			throw new ServiceException("0116");
		}
		//添加校验售票记录的密文是否正确
		DateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");
		String datestr = df.format(ticketsell.getSelltime());
		String cipherStr = ticketsell.getOrgid()+datestr+ticketsell.getSellby();
//		if(DateUtils.compare(ticketsell.getSelltime(),ticketsell.getUpdatetime())<=0){
			if(!Encryption.chkTicketno(cipherStr, ticketsell.getTiksno())){
				throw new ServiceException("0500");
			}
//		}
		return ticketsell;
	}

	/**
	 * 改票查询
	 */
	@Override
	public List<Map<String, Object>> findTicketChange(
			List<PropertyFilter> propertyFilters,Global global) {
		List<Map<String, Object>> result = ticketDao.findTicketChange(propertyFilters,global);
		/*//处理团体票
		Billtype billtype = null;
		Iterator<Map<String, Object>> iterator =  result.iterator();
		while(iterator.hasNext()){
			Map<String, Object> ticket = iterator.next();
			if("T".equals(ticket.get("tickettype").toString())){
				if(billtype==null){
					billtype = billtypeService.findByCode("Ticket");
				}
				if(billtype.getTicketnolength()<ticket.get("ticketno").toString().length()){
					iterator.remove();
				}
			}
		}
		iterator =  result.iterator();
		while(iterator.hasNext()){
			Map<String, Object> ticket = iterator.next();
			if("T".equals(ticket.get("tickettype").toString())){
				//查出所有车票
				List<PropertyFilter> propertyFilters2 = new ArrayList<PropertyFilter>();
				propertyFilters2.add(new PropertyFilter("EQD_t!departdate", ticket.get("departdate")));
				propertyFilters2.add(new PropertyFilter("GTS_t!ticketno", ticket.get("ticketno")));
				propertyFilters2.add(new PropertyFilter("EQS_t!tickettype", ticket.get("tickettype").toString()));
				StringBuilder sql = new StringBuilder("select t from Ticketsell t where t.ticketno like '")
									.append(ticket.get("ticketno").toString()).append("%'");
				List<Ticketsell> ts_tuans = ticketDao.find(sql.toString(), propertyFilters2);
				for (Ticketsell ts_tuan : ts_tuans) {
					ticket.put("price", ((BigDecimal)ticket.get("price")).add(ts_tuan.getPrice()));
				}
				ticket.put("isselected",null);
			}
		}*/
		return result;
	}

	/**
	 * 查询单表(售票表)，用于重打
	 */
	@Override
	public List<Map<String, Object>> find(List<PropertyFilter> propertyFilters) {
		return ListUtil.listToMap(new Object[] { Ticketsell.class },
				ticketDao.find(Ticketsell.class, propertyFilters));
	}

	@Override
	public List<Map<String, Object>> query(
			List<PropertyFilter> propertyFilterList) {
		return ListUtil.listToMap(new Object[] { "id", "seatno", "ticketno",
				"departdate", "departtime", "carrychildnum", "fullprice",
				"price", "discountrate", "stationservicefee", "distance",
				"selltime", "ticketentrance", "createtime", "updatetime",
				"vehicleno", "schedulecode", "orgname", "departname",
				"reachname", "sellname", "createname", "updatename",
				"ticketname","sellid" }, ticketDao.query(propertyFilterList),
				new Object[] { Long.class, Short.class, String.class,
						Timestamp.class, String.class, Byte.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, Long.class, Timestamp.class,
						String.class, Timestamp.class, Timestamp.class,
						String.class, String.class, String.class, String.class,
						String.class, String.class, String.class, String.class,
						String.class, String.class });
	}

	@Override
	public List<Map<String, Object>> qryTicketsell(List<PropertyFilter> propertyFilterList){// 本站票+异站票
		List<Map<String, Object>> map = new ArrayList<Map<String,Object>>();
		String certificateno = "";
		Iterator<PropertyFilter> itso=propertyFilterList.iterator();
		while(itso.hasNext()){
			PropertyFilter pf=itso.next();			
			if(pf.getPropertyName().contains("certificateno")){
				certificateno =(String) pf.getMatchValue();
				itso.remove();
			}			
		}
		map.addAll(query_(propertyFilterList,certificateno));
//		map.addAll(query(propertyFilterList));
		Iterator<PropertyFilter> its=propertyFilterList.iterator();
		while(its.hasNext()){
			PropertyFilter pf=its.next();
			if(pf.getPropertyName().contains("scheduleid")){
				its.remove();
			}
		}
		map.addAll(queryTicketsellagent(propertyFilterList));
		return map;
	}
	
	@Override
	public List<Map<String, Object>> queryTicketsellagent(
			List<PropertyFilter> propertyFilterList) {
		return ListUtil.listToMap(new Object[] { "id", "seatno", "ticketno",
				"departdate", "departtime", "carrychildnum", "fullprice",
				"price", "discountrate", "stationservicefee", "distance",
				"selltime", "ticketentrance", "createtime", "updatetime",
				"vehicleno", "schedulecode", "orgname", "departname",
				"reachname", "sellname", "createname", "updatename",
		"ticketname","sellid","ticketlength","tickettype" }, ticketDao.queryTicketsellagent(propertyFilterList),
		new Object[] { Long.class, Short.class, String.class,
			Timestamp.class, String.class, Byte.class,
			BigDecimal.class, BigDecimal.class, BigDecimal.class,
			BigDecimal.class, Long.class, Timestamp.class,
			String.class, Timestamp.class, Timestamp.class,
			String.class, String.class, String.class, String.class,
			String.class, String.class, String.class, String.class,
			String.class, String.class, Integer.class, String.class });
	}

	@Override
	public List<Ticketsell> getTickets(String ticketno, Date departdate)
			throws ServiceException {
		return ticketDao.getTickets(ticketno,departdate);
	}

	public BilltypeService getBilltypeService() {
		return billtypeService;
	}

	public void setBilltypeService(BilltypeService billtypeService) {
		this.billtypeService = billtypeService;
	}
	/*
	@Override
	public List<Ticketsell> qryTickets(String ticketnos, Date departdate) {
		return ticketDao.qryTickets(ticketnos,departdate);
	}*/

	@Override
	public List<Map<String, Object>> getTicketcout(String ticketno, Date departdate,String certificateno) {
		return ListUtil.listToMap(new Object[] {"ticketsellid","scheduleplanid","ticketno","name","certificateno","certificatetype","schedulecode","departtime","isrealnameticket","ticketstatus"},
				ticketDao.getTicketcout(ticketno, departdate,certificateno),
		new Object[] { long.class,long.class, String.class, String.class, String.class, String.class, String.class, String.class,boolean.class,String.class});
		
	}


	@Override
	public List<Map<String, Object>> getmulTicketlist(String ticketno, Date departdate, String certificateno) {
		return ListUtil.listToMap(
				new Object[] { "ticketsellid", "ticketno", "departdate", "tostation", "schedulecode", "seatno",
						"ticketstatus", "scheduleplanid", "departtime", "customername", "certificatetypename",
						"certificateno" },
				ticketDao.querymultickets(ticketno, departdate, certificateno),
				new Object[] { long.class, String.class, Date.class, String.class, String.class, String.class,
						String.class, long.class, String.class, String.class, String.class, String.class });
	}

	@Override
	public boolean lineworkexistdepart(String ticketno,String departdate) {
		
		return ticketDao.lineworkexistdepart(ticketno,departdate);
	}

	@Override
	public boolean checkTicketByTicket(Ticketsell ticketsell) {
		if (ticketsell == null) {
			return false;
		}
		DateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");
		String datestr = df.format(ticketsell.getSelltime());
		String cipherStr = ticketsell.getOrgid()+datestr+ticketsell.getSellby();
		if(!Encryption.chkTicketno(cipherStr, ticketsell.getTiksno())){
			return false;
		}
		return true;
	}

	/**
	 * 查询单表(售票表)，关联 departinvoicesothersell
	 * @return
	 */
	public List<Map<String, Object>> queryTicketByTicketno(String ticketno) {
		return ListUtil.listToMap(new Object[] {"isselect","id","ticketno","seatno","price",
				"departtime","computefee","otherfee","stationservicefee"
				,"departstationid","ischecked","departinvoicesotherid","reachstationname","tickettype","schedulecode"},
				ticketDao.queryTicketByTicketno(ticketno),
		new Object[] {Boolean.class,long.class,String.class, Integer.class, BigDecimal.class
				,String.class,BigDecimal.class,BigDecimal.class,
			BigDecimal.class,long.class, Boolean.class,long.class,String.class,String.class,String.class });
	}

	@Override
	public List<Map<String, Object>> queryTicketByDepartinvoicesotherdetailid(Long departinvoicesotherdetailid) {
		return ListUtil.listToMap(new Object[] {"isselect","id","ticketno","seatno","price",
				"departtime","stationservicefee","departstationid","ischecked","departinvoicesotherid","reachstationname","tickettype","computefee"},
				ticketDao.queryTicketByDepartinvoicesotherdetailid(departinvoicesotherdetailid),
		new Object[] {Boolean.class,long.class, 
			String.class, Integer.class, BigDecimal.class, String.class,
			BigDecimal.class,long.class, Boolean.class,long.class,String.class,String.class,BigDecimal.class});
	}
	
	private List<Map<String, Object>> query_(
			List<PropertyFilter> propertyFilterList,String certificateno) {
		return ListUtil.listToMap(new Object[] { "id", "seatno", "ticketno",
				"departdate", "departtime", "carrychildnum", "fullprice",
				"price", "discountrate", "stationservicefee", "distance",
				"selltime", "ticketentrance", "createtime", "updatetime",
				"vehicleno", "schedulecode", "orgname", "departname",
				"reachname", "sellname", "createname", "updatename",
				"ticketname" ,"sellby","sellway", "sellid","ticketlength","tickettype" }, ticketDao.query_(propertyFilterList,certificateno),
				new Object[] { Long.class, Short.class, String.class,
						Timestamp.class, String.class, Byte.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, Long.class, Timestamp.class,
						String.class, Timestamp.class, Timestamp.class,
						String.class, String.class, String.class, String.class,
						String.class, String.class, String.class, String.class,
						String.class,String.class,String.class,String.class,Integer.class,String.class });
	}

}
