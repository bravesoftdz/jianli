package cn.nova.bus.sale.service.impl;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.persistence.LockModeType;

import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.insure.model.Insuranceturnoverdetail;
import cn.nova.bus.insure.service.InsuranceturnoverdetailService;
import cn.nova.bus.insure.service.impl.InsuranceturnoverdetailServiceImpl;
import cn.nova.bus.log.model.Operationlog;
import cn.nova.bus.sale.dao.TicketturnoverDao;
import cn.nova.bus.sale.model.Ticketturnover;
import cn.nova.bus.sale.model.Ticketturnoverdetail;
import cn.nova.bus.sale.service.TicketturnoverService;
import cn.nova.bus.sale.service.TicketturnoverdetailService;
import cn.nova.bus.security.Global;
import cn.nova.bus.system.service.impl.ParameterServiceImpl;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;
import util.CommonUtil;
import util.JsonUtil;

@SuppressWarnings("unchecked")
public class TicketturnoverServiceImpl implements TicketturnoverService {

	private TicketturnoverDao dao = new TicketturnoverDao();
	/*
	 * private TicketturnoverdetailDao ticketdao;
	 * 
	 * private InsuranceturnoverdetailDao insuredao;
	 */

	private TicketturnoverdetailService ticketdetailService = new TicketturnoverdetailServiceImpl();

	private InsuranceturnoverdetailService insurancedetailService = new InsuranceturnoverdetailServiceImpl();

	@Override
	public Ticketturnover save(Ticketturnover ticketturnover,
			String ticketdetail, String insuredetail) throws ServiceException {
		play.Logger.info("ticketturnover_seller:%s", ticketturnover.getSeller());
		if (ticketturnover.getId() == 0) {
			ticketturnover = (Ticketturnover) dao.merge(ticketturnover);
			Long seller=ticketturnover.getSeller();
			ticketturnover.setFueladditionfee(new BigDecimal(0));
			ticketturnover.setStationservicefee(new BigDecimal(0));
			ticketturnover.setComputefee(new BigDecimal(0));
			ticketturnover.setCoolairfee(new BigDecimal(0));
			ticketturnover.setAdditionfee(new BigDecimal(0));
			ticketturnover.setWaterfee(new BigDecimal(0));
			ticketturnover.setInsurefee(new BigDecimal(0));
			ticketturnover.setOtherfee(new BigDecimal(0));
			BigDecimal moneypayable = new BigDecimal(0);
			if (!"".equals(ticketdetail)) {
				String[] ticketdetailid = ticketdetail.split(",");
//				Ticketturnoverdetail ticketturnoverdetail = null;
				int ticketsellnum = 0;
				List<Ticketturnoverdetail> ticketturnoverdetaillist = ticketdetailService.getByIds(ticketdetailid);
				for (Ticketturnoverdetail ticketturnoverdetail : ticketturnoverdetaillist) {
					if (!ticketturnoverdetail.isIsturnover()) {
						ticketsellnum=ticketsellnum+ticketturnoverdetail.getSellnum();
						ticketturnoverdetail.setIsturnover(true);
						ticketturnoverdetail.setTurnovertime(new Date());
						ticketturnoverdetail.setTicketturnover(ticketturnover);
						//售票员主明细不一致时，以明细表为主
						if(seller!=ticketturnoverdetail.getSeller()){
							ticketturnover.setSeller(ticketturnoverdetail.getSeller());
						}
						
						ticketturnover.setFueladditionfee(ticketturnover
								.getFueladditionfee().add(
										ticketturnoverdetail
												.getFueladditionfee()));
						ticketturnover.setStationservicefee(ticketturnover
								.getStationservicefee().add(
										ticketturnoverdetail
												.getStationservicefee()));
						ticketturnover.setComputefee(ticketturnover
								.getComputefee().add(
										ticketturnoverdetail.getComputefee()));
						ticketturnover.setCoolairfee(ticketturnover
								.getCoolairfee().add(
										ticketturnoverdetail.getCoolairfee()));
						ticketturnover.setAdditionfee(ticketturnover
								.getAdditionfee().add(
										ticketturnoverdetail.getAdditionfee()));
						ticketturnover.setWaterfee(ticketturnover.getWaterfee()
								.add(ticketturnoverdetail.getWaterfee()));
						ticketturnover.setInsurefee(ticketturnover
								.getInsurefee().add(
										ticketturnoverdetail.getInsurefee()));
						ticketturnover.setOtherfee(ticketturnover.getOtherfee()
								.add(ticketturnoverdetail.getOtherfee()));
						ticketdetailService.save(ticketturnoverdetail);
					} else {
						throw new ServiceException(
								ticketturnoverdetail.getTicketstartno(), "0226");
					}
				
					moneypayable = moneypayable.add(ticketturnoverdetail
							.getMoneypayable());
				}
				if (ticketsellnum != ticketturnover.getSellnum()) {
					throw new ServiceException("0355");
				}
			}
			if (insuredetail != null && !"".equals(insuredetail)) {
				String[] insuredetailid = insuredetail.split(",");
				Insuranceturnoverdetail insurancedetail = null;
				for (int i = 0; i < insuredetailid.length; i++) {
					insurancedetail = insurancedetailService.getById(Long
							.parseLong(insuredetailid[i]));
					if (!insurancedetail.isIsturnover()) {
						insurancedetail.setIsturnover(true);
						insurancedetail.setTurnovertime(new Date());
						insurancedetail.setTicketturnover(ticketturnover);
						insurancedetailService.save(insurancedetail);
						//售票员主明细不一致时，以明细表为主
						if(seller!=insurancedetail.getSeller()){
							ticketturnover.setSeller(insurancedetail.getSeller());
						}
						
					} else {
						throw new ServiceException(
								insurancedetail.getTicketendno(), "0227");
					}
					moneypayable = moneypayable.add(insurancedetail
							.getMoneypayable());
				}
			}
			if (moneypayable.compareTo(ticketturnover.getMoneypayable()) != 0) {
				throw new ServiceException("0355");
			}
			play.Logger.info("t_seller:%s", ticketturnover.getSeller());
			ticketturnover = (Ticketturnover) dao.merge(ticketturnover);
			return ticketturnover;
		} else {
			ticketturnover = (Ticketturnover) dao.merge(ticketturnover);
			return ticketturnover;
		}
	}

	@Override
	public boolean delete(long id) {
		return dao.delete(Ticketturnover.class, id);
	}

	@Override
	public Ticketturnover getById(long id) {
		return (Ticketturnover) dao.get(Ticketturnover.class, id);
	}

	/**
	 * 查询售票员已缴款信息，用来重打缴款单
	 */
	@Override
	public List<Map<String, Object>> query(List<PropertyFilter> propertyFilter,Global global) {
		return ListUtil.listToMap(new Object[] {
				"id", "neticketreturncharge", "neticketreturnmoney", "neticketreturnnum", "neticketreturnbacknum"
				,"neticketreturnbackmoney", "neticketreturnbackcharge", "ieticketreturnnum", "ieticketreturnmoney"
				,"ieticketreturncharge", "iereturnbacknum", "iereturnbackmoney", "iereturnbackcharge",
				 "bookservicefee", "changeservicefee", "cancelmoney", "cancelnum",
				"createby", "createtime", "eticketnum", "insurecancelmoney", "insurecancelnum", "insurechargemoney",
				"insurechargenum", "insureeticketnum", "insurenonvouchermoneypayable", "insurereturnhandcharge",
				"insurereturnmoney", "insurereturnnum", "insuresellmoney", "insuresellnum", "lastlost", "lost", "money",
				"moneypayable", "noncashmoney", "noncashnum", "nonvouchermoneypayable", "receiptip", "receiptorgid",
				"receipttime", "receiver", "remarks", "returnhandcharge", "returnmoney", "returnnum", "seller",
				"sellmoney", "sellnum", "servicefee", "turnovertime", "sellreturntripnum", "returnprintnum",
				"billdamagednum", "stationservicefee", "fueladditionfee", "computefee", "coolairfee", "additionfee",
				"waterfee", "insurefee", "otherfee", "ticketstrike", "insurstrike", "ticketmoney", "insuremoney",
				"ticketmoneypayable", "insuremoneypayable", "balance", "orgname", "receivername", "sellername", "code",
				"createname", "ischoose", "startmoneydate", "startticketno", "endmoneydate", "endticketno",
				"nostationfeemoney","nsellnum","nsellmoney","nreturnnum","nreturnmoney","nreturnhandcharge",
				"nreturtotalnnum","nreturntotalmoney","nreturnhandtotalcharge","ninsuresellnum",
				"ninsuresellmoney","ninsurenoncashnum","ninsurenoncashmoney","ninsurereturnnum",
				"ninsurereturnmoney","ninsurereturntotalnum","ntinsurereturntotalmoney","neticketpayable"// ,"precount","preprice"
				,"totalpayable","ticketcashmoneypayable","insurecashmoneypayable","insurenocashmoneypayable"
				,"eticketmoney","ticketallnum"
		}, dao.query(propertyFilter,global),
				new Object[] { 
						long.class, BigDecimal.class, BigDecimal.class, Long.class, Long.class, 
						BigDecimal.class, BigDecimal.class, Long.class, BigDecimal.class, 
						BigDecimal.class, Long.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class, int.class, long.class,
						Date.class, int.class, BigDecimal.class, int.class, BigDecimal.class, int.class, int.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class, int.class, BigDecimal.class, int.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class, BigDecimal.class, BigDecimal.class,
						int.class, BigDecimal.class, String.class, long.class, Date.class, long.class,
						String.class, BigDecimal.class, BigDecimal.class, int.class, long.class,
						BigDecimal.class, int.class, BigDecimal.class, java.util.Date.class, int.class, int.class,
						int.class, BigDecimal.class, BigDecimal.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, String.class, String.class, String.class, String.class, String.class,
						Boolean.class, Date.class, String.class, Date.class, String.class, BigDecimal.class,
						Integer.class, BigDecimal.class, Integer.class, BigDecimal.class, BigDecimal.class,
						Integer.class, BigDecimal.class, BigDecimal.class, Integer.class, BigDecimal.class,
						Integer.class, BigDecimal.class, Integer.class, BigDecimal.class, Integer.class,
						BigDecimal.class, BigDecimal.class,BigDecimal.class, BigDecimal.class,BigDecimal.class, BigDecimal.class
						,long.class,BigDecimal.class
				});
	}

	/**
	 * 根据缴款ID，获取缴款的信息，用来打印缴款单
	 */
	@Override
	public List<Map<String, Object>> queryTicketturnover(Long ticketturnoverid) {
		return ListUtil.listToMap(new Object[] {   
				 "id", "turnovertime",  "seller",  "money", 
				 "lastlost",  "lost",  "moneypayable",  "receiver", 
				 "receipttime",  "receiptorgid",  "receiptip",  "remarks", 
				 
				 "sellnum",  "sellmoney",  "returnnum",  "returnmoney", 
				 "returnhandcharge",  "cancelnum",  "noncashnum",  "noncashmoney", 
				 "eticketnum",  "insuresellnum",  "insuresellmoney",  "insurereturnnum", 
				 
				 "insurereturnmoney",  "insurereturnhandcharge",  "insurecancelnum",  "insurechargenum", 
				 "insurechargemoney", "insureeticketnum",  "createtime",  "createby", 
				 "servicefee",  "bookservicefee",  "cancelmoney",  "insurecancelmoney", 
				 
				 "insurenonvouchermoneypayable",  "nonvouchermoneypayable",  "changeservicefee",  "sellreturntripnum", 
				 "returnprintnum",  "billdamagednum",  "stationservicefee",  "fueladditionfee", 
				 "computefee",  "coolairfee",  "additionfee",  "waterfee", 
				 
				 "insurefee",  "otherfee",  "insurstrike",  "ticketstrike", 
				 "ticketmoney", "insuremoney",  "ticketmoneypayable",  "insuremoneypayable", 
				 "balance", 
				
				"receivername", "orgname", "sellername", "createname", "code",
				"startmoneydate", "startticketno", "endmoneydate",
				"endticketno" , "precount", "preprice","insurancestartno","insuranceendno","ticketnoOnline","ticketnoCancel","ticketnostartandend"
				},
				dao.queryTicketturnover(ticketturnoverid), new Object[] { 
						Long.class,Timestamp.class,Long.class,BigDecimal.class,
						BigDecimal.class,BigDecimal.class,BigDecimal.class,Long.class,
						Timestamp.class,Long.class,String.class,String.class,
						
						Long.class,BigDecimal.class,Long.class,BigDecimal.class,
						BigDecimal.class,Long.class,Long.class,BigDecimal.class,
						Long.class,Long.class,BigDecimal.class,Long.class,
						
						BigDecimal.class,BigDecimal.class,Long.class,Long.class,
						BigDecimal.class,Long.class,Timestamp.class,Long.class,
						BigDecimal.class,BigDecimal.class,BigDecimal.class,BigDecimal.class,
						
						BigDecimal.class,BigDecimal.class,BigDecimal.class,Long.class,
						Long.class,Long.class,BigDecimal.class,BigDecimal.class,
						BigDecimal.class,BigDecimal.class,BigDecimal.class,BigDecimal.class,
						
						BigDecimal.class,BigDecimal.class,BigDecimal.class,BigDecimal.class,
						BigDecimal.class,BigDecimal.class,BigDecimal.class,BigDecimal.class,
						BigDecimal.class,
						
						String.class, String.class,
						String.class, String.class, String.class, Date.class,
						String.class, Date.class, String.class,
						Integer.class, BigDecimal.class,String.class,String.class,String.class,String.class,String.class
				});
	}

	@Override
	public List<Map<String, Object>> queryTicketturnover(long id,
			String returnticketno, String cancelticketno,
			String damagedticketno, String returninsureno,
			String cancelinsureno, String damagedinsureno) {
		// return ListUtil.listToMap(new Object[] { Ticketturnover.class,
		// "returnticketno", "cancelticketno", "damagedticketno",
		// "returninsureno", "cancelinsureno", "damagedresureno",
		// "receivername", "orgname", "sellername", "createname" }, dao
		// .queryTicketturnover(id, returnticketno, cancelticketno,
		// damagedticketno, returninsureno, cancelinsureno,
		// damagedinsureno), new Object[] { Ticketturnover.class,
		// String.class, String.class, String.class, String.class,
		// String.class, String.class, String.class, String.class,
		// String.class, String.class });
		return null;
	}

	@Override
	public List<Map<String, Object>> queryTurnover(long seller) {
		return ListUtil.listToMap(new Object[] { Ticketturnover.class },
				dao.queryTicket(seller), new Object[] { Ticketturnover.class });
	}

	/**
	 * 根据缴款ID，获取售票员实缴款金额
	 */
	@Override
	public List<Map<String, Object>> queryTurnoverMoney(
			List<PropertyFilter> buildFromHttpRequest) {
		return ListUtil.listToMap(new Object[] { "turnovermoney" },
				dao.queryTurnovermoney(buildFromHttpRequest),
				new Object[] { BigDecimal.class });
	}

	/*
	 * (non-Javadoc) 售票员解款情况查询
	 * 
	 * @see
	 * cn.nova.bus.sale.service.TicketturnoverService#queryTicketseller(java
	 * .util.Date, long)
	 */
	@Override
	public List<Map<String, Object>> queryTicketseller(Date moneydate,
			long seller) {
		return ListUtil.listToMap(new Object[] { "name", "money", "lost",
				"lastlost", "moneypayable" },
				dao.queryTicketsell(moneydate, seller), new Object[] {
						String.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class });
	}

	@Override
	public List<Map<String, Object>> queryRevenueOfDay(Long billtypeid,
			List<PropertyFilter> propertyFilter) {
		return ListUtil.listToMap(new Object[] { "userid","code", "name", "ticketnum",
				"sellnum", "sellmoney", "returnnum", "returnmoney","cancelnum",
				"handcharge", "changeservicefee","realsellnum","nonvouchermoneypayable","revenuemoneypayable", "moneypayable", "strike",
				"money", "ticketstartno", "ticketendno","longlost","shortlost","balance" },
				dao.queryRevenueOfDay(billtypeid,propertyFilter), new Object[] {
						String.class,String.class, String.class, Integer.class,
						Integer.class, BigDecimal.class, Integer.class,
						BigDecimal.class,Integer.class, BigDecimal.class, BigDecimal.class,Integer.class,
						BigDecimal.class, BigDecimal.class,BigDecimal.class,BigDecimal.class,  BigDecimal.class,
						String.class, String.class,BigDecimal.class,BigDecimal.class,BigDecimal.class });
	}

	@Override
	public List<Map<String, Object>> queryticketturnoverReturnAndCancel(
			Long ticketturnoverid) {
		return ListUtil.listToMap(new Object[] { "tickettype","ticketno1","returnamount1","ticketno2","returnamount2",
				"ticketno3","returnamount3","ticketno4","returnamount4"},
				dao.queryticketturnoverReturnAndCancel(ticketturnoverid), new Object[] {
						String.class,String.class,BigDecimal.class,String.class,BigDecimal.class,
						String.class,BigDecimal.class,String.class,BigDecimal.class});
	}

	public List<Map<String, Object>> qryRtnCelByTktoverDetails(List<PropertyFilter> buildFromHttpRequest) {
		return ListUtil.listToMap(new Object[] { "tickettype", "ticketno1",
				"returnamount1", "ticketno2", "returnamount2", "ticketno3",
				"returnamount3", "ticketno4", "returnamount4" }, dao
				.qryRtnCelByTktoverDetails(buildFromHttpRequest),
				new Object[] { String.class, String.class,
						BigDecimal.class,String.class, BigDecimal.class,
						String.class, BigDecimal.class, String.class, BigDecimal.class });
	}

	@Override
	public List<Map<String, Object>> queryinsurenceturnover(Long ticketturnoverid) {
		return ListUtil.listToMap(new Object[] {   
				 "id", "turnovertime",  "seller",  "money", 
				 "lastlost",  "lost",  "moneypayable",  "receiver", 
				 "receipttime",  "receiptorgid",  "receiptip",  "remarks", 
				 "sellnum",  "sellmoney",  "returnnum",  "returnmoney", 
				 "returnhandcharge",  "cancelnum",  "noncashnum",  "noncashmoney", 
				 "eticketnum",  "insuresellnum",  "insuresellmoney",  "insurereturnnum", 
				 "insurereturnmoney",  "insurereturnhandcharge",  "insurecancelnum",  "insurechargenum", 
				 "insurechargemoney", "insureeticketnum",  "createtime",  "createby", 
				 "servicefee",  "bookservicefee",  "cancelmoney",  "insurecancelmoney", 
				 "insurenonvouchermoneypayable",  "nonvouchermoneypayable",  "changeservicefee",  "sellreturntripnum", 
				 "returnprintnum",  "billdamagednum",  "stationservicefee",  "fueladditionfee", 
				 "computefee",  "coolairfee",  "additionfee",  "waterfee", 
				 "insurefee",  "otherfee",  "insurstrike",  "ticketstrike", 
				 "ticketmoney", "insuremoney",  "ticketmoneypayable",  "insuremoneypayable", 
				 "balance", 
				"receivername", "orgname", "sellername", "createname", "code",
				"startmoneydate", "startticketno", "endmoneydate",
				"endticketno" , "precount", "preprice","ticketnoOnline","ticketnoCancel","ticketnostartandend" },
				dao.queryinsurenceturnover(ticketturnoverid), new Object[] { 
						Long.class,Timestamp.class,Long.class,BigDecimal.class,
						BigDecimal.class,BigDecimal.class,BigDecimal.class,Long.class,
						Timestamp.class,Long.class,String.class,String.class,
						Long.class,BigDecimal.class,Long.class,BigDecimal.class,
						BigDecimal.class,Long.class,Long.class,BigDecimal.class,
						Long.class,Long.class,BigDecimal.class,Long.class,
						BigDecimal.class,BigDecimal.class,Long.class,Long.class,
						BigDecimal.class,Long.class,Timestamp.class,Long.class,
						BigDecimal.class,BigDecimal.class,BigDecimal.class,BigDecimal.class,
						BigDecimal.class,BigDecimal.class,BigDecimal.class,Long.class,
						Long.class,Long.class,BigDecimal.class,BigDecimal.class,
						BigDecimal.class,BigDecimal.class,BigDecimal.class,BigDecimal.class,
						BigDecimal.class,BigDecimal.class,BigDecimal.class,BigDecimal.class,
						BigDecimal.class,BigDecimal.class,BigDecimal.class,BigDecimal.class,
						BigDecimal.class,
						String.class, String.class,
						String.class, String.class, String.class, Date.class,
						String.class, Date.class, String.class,
						Integer.class, BigDecimal.class,String.class,String.class,String.class });
	}

	@Override
	public List<Map<String, Object>> queryinsurenceturnoverReturnAndCancel(Long ticketturnoverid) {
		return ListUtil.listToMap(new Object[] { "tickettype","ticketno1","returnamount1","ticketno2","returnamount2",
				"ticketno3","returnamount3","ticketno4","returnamount4"},
				dao.queryinsurenceturnoverReturnAndCancel(ticketturnoverid), new Object[] {
						String.class,String.class,BigDecimal.class,String.class,BigDecimal.class,
						String.class,BigDecimal.class,String.class,BigDecimal.class});
	}

	@Override
	public List<Map<String, Object>> qryRtnCelByIstoverDetails(List<PropertyFilter> buildFromHttpRequest) {
		return ListUtil.listToMap(new Object[] { "tickettype", "ticketno1",
				"returnamount1", "ticketno2", "returnamount2", "ticketno3",
				"returnamount3", "ticketno4", "returnamount4" }, dao
				.qryRtnCelByIstoverDetails(buildFromHttpRequest),
				new Object[] { String.class, String.class,
						BigDecimal.class,String.class, BigDecimal.class,
						String.class, BigDecimal.class, String.class, BigDecimal.class });
	}

	/**
	 * 注销缴款
	 */
	@Override
	public Boolean cancelTurnover(String turnoverids,Global global) {
		List<Long> ticketoveridlist = new ArrayList<Long>();
		String[] ids = turnoverids.split(",");
		for (String id : ids) {
			if (CommonUtil.isNotEmptyString(id)) {
				ticketoveridlist.add(Long.valueOf(id));
			}
		}
		List<Long> queryidlist = new ArrayList<Long>();//处理的ids
		Iterator<Long> iterator = ticketoveridlist.listIterator();
		
		while (iterator.hasNext()) {
			Long id = iterator.next();
			//查询的list大于最大查询个数 或者 没有下一个
			if (!queryidlist.contains(id)) {//不存在则添加到查询的list中
				queryidlist.add(id);
			}
		}
		//循环处理
		for (Long turnoverid : queryidlist) {
			Ticketturnover ticketturnover = (Ticketturnover) dao.get(LockModeType.PESSIMISTIC_READ,Ticketturnover.class, turnoverid);
			if (ticketturnover!=null) {
				cancelDetailTicketAndInsure(ticketturnover, global);
			}
		}
		return true;
	}
	private void cancelDetailTicketAndInsure(Ticketturnover ticketturnover,Global global) {
		Date now = new Date();
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		propertyFilters.add(new PropertyFilter("EQL_t!ticketturnover.id", ticketturnover.getId()));
		propertyFilters.add(new PropertyFilter("EQB_t!isturnover", true));
		//查找车票缴款明细
		List<Ticketturnoverdetail> ticketturnoverdetails = dao.find(LockModeType.PESSIMISTIC_READ, Ticketturnoverdetail.class, propertyFilters);
		//保险缴款明细
		List<Insuranceturnoverdetail> insuranceturnoverdetails = dao.find(LockModeType.PESSIMISTIC_READ, Insuranceturnoverdetail.class, propertyFilters);
		if (CommonUtil.isNotEmptyCollection(ticketturnoverdetails)) {
			for (Ticketturnoverdetail ticketturnoverdetail : ticketturnoverdetails) {
				ticketturnoverdetail.setIsturnover(false);
				ticketturnoverdetail.setTurnovertime(null);
				ticketturnoverdetail.setTicketturnover(null);
				ticketturnoverdetail.setUpdateby(global.getUserinfo().getId());
				ticketturnoverdetail.setUpdatetime(now);
				dao.merge(ticketturnoverdetail);
			}
		}
		
		if (CommonUtil.isNotEmptyCollection(insuranceturnoverdetails)) {
			for (Insuranceturnoverdetail insuranceturnoverdetail : insuranceturnoverdetails) {
				insuranceturnoverdetail.setIsturnover(false);
				insuranceturnoverdetail.setTurnovertime(null);
				insuranceturnoverdetail.setTicketturnover(null);
				insuranceturnoverdetail.setUpdateby(global.getUserinfo().getId());
				insuranceturnoverdetail.setUpdatetime(now);
				dao.merge(insuranceturnoverdetail);
			}
		}
		play.Logger.info("注销缴款单 ticketturnover>> "+JsonUtil.parseObject(ticketturnover));
		String log = "注销缴款单 >> 注销人["+global.getUserinfo().getId()+"],"+
				"收款人["+ticketturnover.getReceiver()+"],"+
				"本期应缴款["+ticketturnover.getMoneypayable()+"],"+
				"实缴款["+ticketturnover.getMoney()+"],"+
				"本次溢欠款["+ticketturnover.getLost()+"],"+
				"缴款时间["+ticketturnover.getTurnovertime()+"],"+
				"车票冲账["+ticketturnover.getTicketstrike()+"],"+
				"保险冲账["+ticketturnover.getInsurstrike()+"],";
		Operationlog operationlog = new Operationlog();
		operationlog.setIp(global.getIpAddress());
		operationlog.setContent(log);
		operationlog.setOperation("取消缴款");
		operationlog.setOperatetime(now);
		operationlog.setModule("营收缴款-取消缴款");
		operationlog.setSessionid(global.getSessionID());
		operationlog.setUserid(global.getUserinfo().getId());
		dao.merge(operationlog);
		dao.delete(ticketturnover);
	}
	
	/**
	 *		 将保险和车票的缴款明细添加 实收和本期溢欠款字段 并赋值
	 * 		a.保险和车票的缴款明细一起缴款 多余的实缴款钱 存到车票的缴款明细的最后一条 
	 * 		b.只有车票的缴款 同a
	 * 		c.只有保险的缴款 因为没有车票的缴款钱 所以 多余的实缴款钱 存到保险的缴款明细的最后一条
	 * 		money = 剩余的实缴款钱数 lost = 最后一条应缴款-剩余的实缴款钱数     lost >0 本次缴款欠款 lost <0 本次缴款溢款
	 */
	@Override
	public Ticketturnover saveTicketturnover(Ticketturnover ticketturnover,
			String ticketdetail, String insuredetail) throws ServiceException {
		play.Logger.info("营收缴款参数：ticketdetail ids=" + ticketdetail
				+ ", insuredetail ids=" + insuredetail + ", ticketturnover="
				+ JsonUtil.toFormatString(ticketturnover));
		if (ticketturnover.getId() == 0) {
			ticketturnover = (Ticketturnover) dao.merge(ticketturnover);
			play.Logger.info("=============:%s", ticketturnover.getId());
			String param_4014 = new ParameterServiceImpl().findParamValue("4014", ticketturnover.getReceiptorgid());
			BigDecimal money = ticketturnover.getMoney();// 实缴款金额
			Long seller = ticketturnover.getSeller();
			ticketturnover.setFueladditionfee(new BigDecimal(0));
			ticketturnover.setStationservicefee(new BigDecimal(0));
			ticketturnover.setComputefee(new BigDecimal(0));
			ticketturnover.setCoolairfee(new BigDecimal(0));
			ticketturnover.setAdditionfee(new BigDecimal(0));
			ticketturnover.setWaterfee(new BigDecimal(0));
			ticketturnover.setInsurefee(new BigDecimal(0));
			ticketturnover.setOtherfee(new BigDecimal(0));
			// BigDecimal moneypayable = new BigDecimal(0);
			boolean isinsu = false;
			boolean isticket = false;
			String insuranceids = "";// 保险缴款明细id
			String ticketdetailids = "";// 车票缴款明细id
			if (!"".equals(ticketdetail)) {// 车票缴款明细id
				String[] ticketdetailid = ticketdetail.split(",");
				for (int i = 0; i < ticketdetailid.length; i++) {// 以防出现',,'问题
					if (!"".equals(ticketdetailid[i]))
						ticketdetailids = ticketdetailids + ticketdetailid[i] + ",";
				}
			}
			List<Insuranceturnoverdetail> insuranceturnoverdetaillist = null;
			// 优先处理保险信息
			if (insuredetail != null && !"".equals(insuredetail)) {// 保险缴款明细id
				String[] insuredetailid = insuredetail.split(",");
				for (int i = 0; i < insuredetailid.length; i++) {// 以防出现',,'问题
					if (!"".equals(insuredetailid[i]))
						insuranceids = insuranceids + insuredetailid[i] + ",";
				}
				if (!"".equals(insuranceids)) {// 如果保险ID不为空
					isinsu = true;
					insuranceids = insuranceids.substring(0, insuranceids.lastIndexOf(","));
					// 得到当前缴款的明细的结果集 ticketdetailidslist
					insuranceturnoverdetaillist = dao.qyrInsuranceturnoverdetaillistbyId(insuranceids);
					for (Insuranceturnoverdetail insuranceturnoverdetail : insuranceturnoverdetaillist) {
						if (!insuranceturnoverdetail.isIsturnover()) {// 该保险明细没有缴款
							if ((insuranceturnoverdetail.getMoneypayable()
									.subtract(insuranceturnoverdetail.getNoncashmoneypayable()))
											.compareTo(money) <= 0) {// 该条记录的应缴款小于实缴款
								insuranceturnoverdetail.setMoney(insuranceturnoverdetail.getMoneypayable()
										.subtract(insuranceturnoverdetail.getNoncashmoneypayable()));
								insuranceturnoverdetail.setLost(BigDecimal.ZERO);
								// 实缴款=实缴款-该条记录的应缴
								money = money.subtract(insuranceturnoverdetail.getMoneypayable()
										.subtract(insuranceturnoverdetail.getNoncashmoneypayable()));
							} else {// 该条记录的应缴款大于实缴款
								insuranceturnoverdetail.setMoney(money);
								// insuranceturnoverdetail.lost = 应缴款-实缴款
								insuranceturnoverdetail.setLost(insuranceturnoverdetail.getMoneypayable()
										.subtract(insuranceturnoverdetail.getNoncashmoneypayable())
										.subtract(insuranceturnoverdetail.getMoney()));
								// 实缴款=实缴款-该条记录的应缴 实际为0
								money = money.subtract(money);
							}
							insuranceturnoverdetail.setIsturnover(true);
							insuranceturnoverdetail.setTurnovertime(new Date());
							insuranceturnoverdetail.setTicketturnover(ticketturnover);
							insurancedetailService.save(insuranceturnoverdetail);
						} else {
							throw new ServiceException(// 该条缴款记录已经缴款
									insuranceturnoverdetail.getTicketendno(), "0227");
						}
					}
				}
			}
			List<Ticketturnoverdetail> ticketdetailidslist = null;
			// 处理车票 实缴款和lost
			if (!"".equals(ticketdetailids)) {
				isticket = true;
				ticketdetailids = ticketdetailids.substring(0, ticketdetailids.lastIndexOf(","));
				// 得到当前缴款的明细的结果集 ticketdetailidslist
				ticketdetailidslist = dao.qyrTicketturnoverdetaillistbyId(ticketdetailids);
				int ticketsellnum = 0;

				for (Ticketturnoverdetail ticketturnoverdetail : ticketdetailidslist) {//
					if (!ticketturnoverdetail.isIsturnover()) {// 该车票明细未缴款
						if ((ticketturnoverdetail.getMoneypayable()
								.subtract(ticketturnoverdetail.getNoncashmoneypayable())).compareTo(money) <= 0) {// 该条记录的应缴款小于实缴款
							ticketturnoverdetail.setMoney(ticketturnoverdetail.getMoneypayable()
									.subtract(ticketturnoverdetail.getNoncashmoneypayable()));// 实缴款=应缴款
							// ticketturnoverdetail.lost = 0
							ticketturnoverdetail.setLost(BigDecimal.ZERO);
							// 实缴款=实缴款- 应缴款
							money = money.subtract(ticketturnoverdetail.getMoneypayable()
									.subtract(ticketturnoverdetail.getNoncashmoneypayable()));
						} else {// 该条记录的应缴款大于实缴款
							ticketturnoverdetail.setMoney(money);// 实缴款=
																	// 剩余的实缴款
							// 溢欠款 = 营收-实收
							ticketturnoverdetail.setLost(ticketturnoverdetail.getMoneypayable()
									.subtract(ticketturnoverdetail.getNoncashmoneypayable())
									.subtract(ticketturnoverdetail.getMoney()));
							money = money.subtract(money);// money = 0
						}
						ticketsellnum = ticketsellnum + ticketturnoverdetail.getSellnum();
						ticketturnoverdetail.setIsturnover(true);
						ticketturnoverdetail.setTurnovertime(new Date());
						ticketturnoverdetail.setTicketturnover(ticketturnover);
						ticketturnoverdetail.setUpdateby(ticketturnover.getCreateby());
						ticketturnoverdetail.setUpdatetime(ticketturnover.getCreatetime());
						// 售票员主明细不一致时，以明细表为主
						if (seller != ticketturnoverdetail.getSeller()) {
							ticketturnover.setSeller(ticketturnoverdetail.getSeller());
						}
						ticketturnover.setFueladditionfee(
								ticketturnover.getFueladditionfee().add(ticketturnoverdetail.getFueladditionfee()));
						ticketturnover.setStationservicefee(
								ticketturnover.getStationservicefee().add(ticketturnoverdetail.getStationservicefee()));
						ticketturnover.setComputefee(
								ticketturnover.getComputefee().add(ticketturnoverdetail.getComputefee()));
						ticketturnover.setCoolairfee(
								ticketturnover.getCoolairfee().add(ticketturnoverdetail.getCoolairfee()));
						ticketturnover.setAdditionfee(
								ticketturnover.getAdditionfee().add(ticketturnoverdetail.getAdditionfee()));
						ticketturnover
								.setWaterfee(ticketturnover.getWaterfee().add(ticketturnoverdetail.getWaterfee()));
						ticketturnover
								.setInsurefee(ticketturnover.getInsurefee().add(ticketturnoverdetail.getInsurefee()));
						ticketturnover
								.setOtherfee(ticketturnover.getOtherfee().add(ticketturnoverdetail.getOtherfee()));
						ticketdetailService.save(ticketturnoverdetail);
					} else {
						throw new ServiceException(// 该条缴款记录已经缴款
								ticketturnoverdetail.getTicketstartno(), "0226");
					}
				}
				if (ticketsellnum != ticketturnover.getSellnum()) {
					throw new ServiceException("", "1000");
				}
			}

			if (!isinsu && !isticket) {
				play.Logger.error("缴款时传入的缴款明细记录有误, 车票缴款明细ID:" + ticketdetail + " 保险缴款明细ID:" + insuredetail);
				throw new ServiceException("传入数据有误!");
			}
			if("1".equals(param_4014)){//如果上期欠款累计到当前
				BigDecimal lastlost = dao.querylastlost(seller);
				if (isticket) {//说明本次有车票缴款记录
					Ticketturnoverdetail ticketturnoverdetail = ticketdetailidslist.get(ticketdetailidslist.size() - 1);
					//最后一条记录的lost为负数 说明是多缴(溢款) money 要增加 lost = lost - money 
					if(ticketturnoverdetail.getLost().compareTo(BigDecimal.ZERO)<=0){
						ticketturnoverdetail.setMoney(ticketturnoverdetail.getMoney().add(money));
						ticketturnoverdetail.setLost(ticketturnoverdetail.getLost().subtract(money));
					}
					//那么实缴款实际包含上期欠款 则需要对缴款的最后一条明细记录的lost做增加
					ticketturnoverdetail.setLost(ticketturnoverdetail.getLost().add(lastlost));
					dao.merge(ticketturnoverdetail);
				} else {
					Insuranceturnoverdetail insuranceturnoverdetail = insuranceturnoverdetaillist.get(insuranceturnoverdetaillist.size()-1);
					if(insuranceturnoverdetail.getLost().compareTo(BigDecimal.ZERO)<0){
						insuranceturnoverdetail.setMoney(insuranceturnoverdetail.getMoney().add(money));
						insuranceturnoverdetail.setLost(insuranceturnoverdetail.getLost().subtract(money));
					}
					insuranceturnoverdetail.setLost(insuranceturnoverdetail.getLost().add(lastlost));
					dao.merge(insuranceturnoverdetail);
				}
			}else{
				if(money.compareTo(BigDecimal.ZERO)>1){
					if (isticket) {//说明本次有车票缴款记录
						Ticketturnoverdetail ticketturnoverdetail = ticketdetailidslist.get(ticketdetailidslist.size() - 1);
						ticketturnoverdetail.setMoney(ticketturnoverdetail.getMoney().add(money));
						ticketturnoverdetail.setLost(ticketturnoverdetail.getLost().subtract(money));
						dao.merge(ticketturnoverdetail);
					} else {
						Insuranceturnoverdetail insuranceturnoverdetail = insuranceturnoverdetaillist.get(insuranceturnoverdetaillist.size()-1);
						insuranceturnoverdetail.setMoney(insuranceturnoverdetail.getMoney().add(money));
						insuranceturnoverdetail.setLost(insuranceturnoverdetail.getLost().subtract(money));
						dao.merge(insuranceturnoverdetail);
					}		
				}
			}
			
			play.Logger.info("t_seller:%s", ticketturnover.getSeller());
			ticketturnover = (Ticketturnover) dao.merge(ticketturnover);
			return ticketturnover;
		} else {
			ticketturnover = (Ticketturnover) dao.merge(ticketturnover);
			play.Logger.info("缴款更新：" + JsonUtil.toSimpleString(ticketturnover));
			return ticketturnover;
		}
	}
	@Override
	public List<Map<String, Object>> queryWebTakedInfo(List<PropertyFilter> propertyFilter) {
		return ListUtil.listToMap(new Object[] { "takedcount", "takedprice" }, dao.queryWebTakedInfo(propertyFilter),
				new Object[] { Integer.class, BigDecimal.class });
	}
	
	/**
	 * 根据缴款id 查询电子退票相关的打印数据源
	 * @return
	 */
	@Override
	public List<Map<String, Object>> qryReturnMoney(String ticketturnoverids) {
		return ListUtil.listToMap(new Object[] { "eticketreturnnum","eticketreturnmoney","eticketreturncharge"
				,"eticketreturnbacknum","eticketreturnbackmoney","eticketreturnbackcharge"
				,"ereturnnum","ereturnmoney","ereturncharge"
				,"ereturnbacknum","ereturnbackmoney","ereturnbackcharge"
				,"noncashmoneypayable","insurereturnnumweb","insurereturnamountweb"},
				dao.qryReturnMoney(ticketturnoverids),
				new Object[] { String.class,String.class,String.class,
			String.class,String.class,String.class,
			String.class,String.class,String.class,
			String.class,String.class,String.class,
			String.class,String.class,String.class});
	}
	
	/**
	 * 营收缴款打印模板增加打印项【网售票价】、【网售张数】和【网售金额】打印数据集，并且按照票价分组
	 */
	@Override
	public List<Map<String, Object>> queryWebInfoGroup(long id) {
		return ListUtil.listToMap(new Object[] { "takeby","seller", "price", "wcount", "wprice" }, dao.queryWebInfoGroup(id),
				new Object[] { String.class, long.class, BigDecimal.class, Integer.class, BigDecimal.class });
	}
}
