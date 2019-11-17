package cn.nova.bus.sale.service.impl;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.persistence.LockModeType;

import cn.nova.bus.bill.model.Billinuse;
import cn.nova.bus.bill.model.Billinventory;
import cn.nova.bus.sale.dao.TicketturnoverdetailDao;
import cn.nova.bus.sale.model.Ticketturnoverdetail;
import cn.nova.bus.sale.model.Ticketturnoverdetailepay;
import cn.nova.bus.sale.service.TicketturnoverdetailService;
import cn.nova.bus.security.Global;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;

@SuppressWarnings("unchecked")
public class TicketturnoverdetailServiceImpl implements
		TicketturnoverdetailService {

	
	private TicketturnoverdetailDao dao = new TicketturnoverdetailDao();

	@Override
	public boolean save(Ticketturnoverdetail detail) {
		if (detail.getId() == 0) {
			return dao.save(detail);
		} else {
			return dao.update(detail);
		}
	}

	@Override
	public Ticketturnoverdetail getTicketturnoverdetail(Long seller,
			long startno) {
		return dao.getList(seller, startno);
	}

	@Override
	public long getMaxid() {
		return dao.getMaxid();
	}
	/**
	 * 查询车票票款缴款明细
	 */
	@Override
	public List<Map<String, Object>> query(
			List<PropertyFilter> propertyFilterList,long seller, Global global) {
		Timestamp lastturnovertime = dao.qrylastturnovertime(seller);
		return ListUtil.listToMap(new Object[] {		
				"id", "ticketturnoverid", "moneydate", "seller", "ticketstartno", "ticketendno", "turnovertime",
				"moneypayable", "sellnum", "sellmoney", "returnnum", "returnmoney", "returnhandcharge", "cancelnum",
				"noncashnum", "noncashmoney", "eticketnum", "createtime", "createby", "updatetime", "updateby",
				"servicefee", "bookservicefee", "isturnover", "cancelmoney", "nonvouchermoneypayable",
				"changeservicefee", "billinuseid", "batchno", "sellreturntripnum", "returnprintnum", "billdamagednum",
				"stationservicefee", "fueladditionfee", "computefee", "coolairfee", "additionfee", "waterfee",
				"insurefee", "otherfee", "synccode", "changenum", "updatename", "sellername", "createname", "ischoose",
				"code", "nostationfeemoney", "lastlost", "money",
				"eticketreturncharge","eservicefee","ebookservicefee","echangeservicefee","eticketreturnnum","eticketreturnmoney",
				"eticketmoney", "ticketallnum", "changeprice",
				"nreturnnum", "nreturnmoney",
				"noncashmoneypayable","eticketreturnbacknum","eticketreturnbackmoney","eticketreturnbackcharge",
				"noncashreturnnum","noncashreturnmoney","noncashreturnhandcharge","cashmoneypayable",
				"cashsellnum","cashsellmoney","cashreturnnum","cashreturnmoney",
				"cashreturnhandcharge","cashservicefee" ,"cashbookservicefee","cashchangeservicefee" },
				dao.queryticketturnover(propertyFilterList,lastturnovertime,global), new Object[] {
						long.class, long.class, Date.class, long.class, String.class, String.class, Timestamp.class,
						BigDecimal.class, long.class, BigDecimal.class, long.class, BigDecimal.class, BigDecimal.class,
						long.class, long.class, BigDecimal.class, long.class, Timestamp.class, long.class,
						Timestamp.class, long.class, BigDecimal.class, BigDecimal.class, boolean.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class, long.class, String.class, long.class,
						long.class, long.class, BigDecimal.class, BigDecimal.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class, BigDecimal.class, String.class,
						long.class, String.class, String.class, String.class, Boolean.class, String.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class,BigDecimal.class,BigDecimal.class,BigDecimal.class,BigDecimal.class,BigDecimal.class,
						BigDecimal.class, long.class,BigDecimal.class, long.class, BigDecimal.class,
						BigDecimal.class, long.class,BigDecimal.class,BigDecimal.class,
						long.class,BigDecimal.class,BigDecimal.class,BigDecimal.class,
						long.class,BigDecimal.class,long.class,BigDecimal.class,
						BigDecimal.class,BigDecimal.class,BigDecimal.class,BigDecimal.class});
	}

	@Override
	public Ticketturnoverdetail getById(long id) {
		return (Ticketturnoverdetail) dao.get(LockModeType.PESSIMISTIC_READ,Ticketturnoverdetail.class, id);
	}
	
	@Override
	public List<Ticketturnoverdetail> getByIds(String[] ids) {
		// TODO Auto-generated method stub
		return dao.getByIds(ids);
	}

	/**
	 * 查询车票票款对应的退票数
	 */
	@Override
	public List<Map<String, Object>> queryReturnTicketno(
			List<PropertyFilter> buildFromHttpRequest) {
		return ListUtil.listToMap(new Object[] { "ticketprice",
				"returnticketno" },
				dao.queryReturnTicketno(buildFromHttpRequest), new Object[] {
						BigDecimal.class, String.class });
	}

	/**
	 * 查询车票票款对应的废票数
	 */
	@Override
	public List<Map<String, Object>> queryCancelTicketno(
			List<PropertyFilter> buildFromHttpRequest) {
		return ListUtil.listToMap(new Object[] { "ticketprice",
				"cancelticketno" },
				dao.queryCancelTicketno(buildFromHttpRequest), new Object[] {
						BigDecimal.class, String.class });
	}

	/**
	 * 查询车票票款对应的坏票登记数
	 */
	@Override
	public List<Map<String, Object>> queryBillTicketno(
			List<PropertyFilter> buildFromHttpRequest) {
		return ListUtil.listToMap(new Object[] { "startno", "endno","damageddscribe" },
				dao.queryBillTicketno(buildFromHttpRequest), new Object[] {
						String.class, String.class ,String.class});
	}

	@Override
	public Ticketturnoverdetail getCurTicketturnoverdetail(long sellerid,String startvoucherno) {
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		Date now = new Date();
		//插入或修改应缴款表
		propertyFilters.clear();
		propertyFilters.add(new PropertyFilter("EQB_t!isturnover", false));
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(now);
		calendar.set(calendar.get(Calendar.YEAR), 
					calendar.get(Calendar.MONTH), 
					calendar.get(Calendar.DAY_OF_MONTH), 
					0,0, 0);
		propertyFilters.add(new PropertyFilter("EQD_t!moneydate",calendar.getTime()));
		propertyFilters.add(new PropertyFilter("EQL_t!seller",sellerid));
		List<Ticketturnoverdetail> ticketturnoverdetails = dao.find(LockModeType.PESSIMISTIC_READ,Ticketturnoverdetail.class, propertyFilters);
		boolean neednew = true;
//		Billinuse buse=null;
		Ticketturnoverdetail ticketturnoverdetail=null;
		if(ticketturnoverdetails!=null&&ticketturnoverdetails.size()>0){
			if(startvoucherno!=null&&!startvoucherno.equals("0")){
				for (Ticketturnoverdetail _ticketturnoverdetail : ticketturnoverdetails) {				
					if(new Long(_ticketturnoverdetail.getTicketendno()).longValue()+1L==new Long(startvoucherno)){
						propertyFilters.clear();
						propertyFilters.add(new PropertyFilter("EQL_t!id", _ticketturnoverdetail.getBillinuseid()));
						propertyFilters.add(new PropertyFilter("GEL_t!endno",new Long(startvoucherno)));
						propertyFilters.add(new PropertyFilter("LEL_t!startno",new Long(startvoucherno)));						
						propertyFilters.add(new PropertyFilter("EQL_t!recipients",sellerid));
						List<Billinuse> billinuses = dao.find(Billinuse.class, propertyFilters);
						if(billinuses!=null&&billinuses.size()>0){
							ticketturnoverdetail=_ticketturnoverdetail;
							neednew=false;
							break;
						}						
					}
				}
				if(neednew){
					for (Ticketturnoverdetail _ticketturnoverdetail : ticketturnoverdetails) {
						if("0".equals(_ticketturnoverdetail.getTicketstartno())){
							ticketturnoverdetail=_ticketturnoverdetail;
							neednew=false;
							break;
						}
					}
				}
			}
			else{
				ticketturnoverdetail=ticketturnoverdetails.get(0);
				neednew=false;
			}
		}
		
		if(neednew){
			ticketturnoverdetail = new Ticketturnoverdetail();
			ticketturnoverdetail.setMoneypayable(new BigDecimal(0));
			ticketturnoverdetail.setSellmoney(new BigDecimal(0));
			ticketturnoverdetail.setSellnum(0);
			ticketturnoverdetail.setUpdateby(sellerid);
			ticketturnoverdetail.setUpdatetime(now);
			ticketturnoverdetail.setCancelnum(0);
			ticketturnoverdetail.setChangenum(0);
			ticketturnoverdetail.setCancelmoney(new BigDecimal(0));
			ticketturnoverdetail.setNonvouchermoneypayable(new BigDecimal(0));
			ticketturnoverdetail.setNoncashmoney(new BigDecimal(0));
			ticketturnoverdetail.setNoncashnum(0);
			ticketturnoverdetail.setCreateby(sellerid);
			ticketturnoverdetail.setCreatetime(now);
			ticketturnoverdetail.setEticketnum(0);
			ticketturnoverdetail.setMoneydate(now);
			ticketturnoverdetail.setReturnhandcharge(new BigDecimal(0));
			ticketturnoverdetail.setReturnmoney(new BigDecimal(0));
			ticketturnoverdetail.setReturnnum(0);
			ticketturnoverdetail.setSeller(sellerid);
			ticketturnoverdetail.setTicketturnover(null);
			ticketturnoverdetail.setBookservicefee(new BigDecimal(0));
			ticketturnoverdetail.setServicefee(new BigDecimal(0));
			ticketturnoverdetail.setChangeservicefee(new BigDecimal(0));
			ticketturnoverdetail.setIsturnover(false);
			ticketturnoverdetail.setTurnovertime(null);
			ticketturnoverdetail.setBilldamagednum(0);
			ticketturnoverdetail.setSellreturntripnum(0);
			ticketturnoverdetail.setReturnprintnum(0);
			ticketturnoverdetail.setBatchno("0");
			ticketturnoverdetail.setBillinuseid(0);
			ticketturnoverdetail.setTicketstartno("0");
			ticketturnoverdetail.setTicketendno("0");
			ticketturnoverdetail.setFueladditionfee(new BigDecimal(0));
			ticketturnoverdetail.setStationservicefee(new BigDecimal(0));
			ticketturnoverdetail.setComputefee(new BigDecimal(0));
			ticketturnoverdetail.setCoolairfee(new BigDecimal(0));
			ticketturnoverdetail.setAdditionfee(new BigDecimal(0));
			ticketturnoverdetail.setWaterfee(new BigDecimal(0));
			ticketturnoverdetail.setInsurefee(new BigDecimal(0));
			ticketturnoverdetail.setOtherfee(new BigDecimal(0));
			ticketturnoverdetail.setEticketreturncharge(new BigDecimal(0));
			ticketturnoverdetail.setEticketreturnmoney(new BigDecimal(0));
			ticketturnoverdetail.setEticketreturnnum(0);
			ticketturnoverdetail.setEservicefee(new BigDecimal(0));//电子补票服务费
			ticketturnoverdetail.setEchangeservicefee(new BigDecimal(0));//电子订票服务费
			ticketturnoverdetail.setEbookservicefee(new BigDecimal(0));//电子改签服务费
			ticketturnoverdetail.setReturnamountweb(new BigDecimal(0));
			ticketturnoverdetail.setChargesweb(new BigDecimal(0));
			
			ticketturnoverdetail.setTicketprintnum(0);//售票、改签、补票等打印物理票张数：包含车票数、改签凭证数、补票凭证数
			ticketturnoverdetail.setChangeprintnum(0);//改签凭证打印张数
			ticketturnoverdetail.setSupplementprintnum(0);//补票凭证打印张数
			ticketturnoverdetail.setNoncashmoneypayable(BigDecimal.ZERO);;//非现金应缴款
			ticketturnoverdetail.setEticketreturnbacknum(0); //电子票原路返还的退票总张数
			ticketturnoverdetail.setEticketreturnbackmoney(BigDecimal.ZERO);//电子票原路返还的退票总金额
			ticketturnoverdetail.setEticketreturnbackcharge(BigDecimal.ZERO);//电子票原路返还的总退票手续费
			ticketturnoverdetail.setReturnnumweb(0);;//退网售车票原路返还的退票总张数
			ticketturnoverdetail.setMoney(BigDecimal.ZERO);
			ticketturnoverdetail.setLost(BigDecimal.ZERO);
//			if(startvoucherno==null){
//				ticketturnoverdetail.setTicketstartno("0");
//				ticketturnoverdetail.setTicketendno("0");
//			}
//			else{
//				//ticketturnoverdetail.setTicketstartno(startvoucherno); 由调用者设置
//			}
		}
		//ticketturnoverdetail.setTicketendno 由调用者设置
		//其它字段改变也由调用者设置
		//ticketturnoverdetail.setMoneypayable(ticketturnoverdetail.getMoneypayable().subtract(totalreturnmoney));
		
		if(ticketturnoverdetail.getEservicefee()==null){
			ticketturnoverdetail.setEservicefee(new BigDecimal(0));//电子补票服务费
		}
		if(ticketturnoverdetail.getEchangeservicefee()==null){
			ticketturnoverdetail.setEchangeservicefee(new BigDecimal(0));//电子订票服务费
		}
		if(ticketturnoverdetail.getEbookservicefee()==null){
			ticketturnoverdetail.setEbookservicefee(new BigDecimal(0));//电子改签服务费
		}
		if(ticketturnoverdetail.getEticketreturncharge()==null){
			ticketturnoverdetail.setEticketreturncharge(new BigDecimal(0));
		}
		return ticketturnoverdetail;
	}

	public List<Map<String, Object>> queryTicketRevenue(List<PropertyFilter> propertyFilterList){
		//,""
		List<Map<String, Object>> list= ListUtil.listToMap(new Object[] { "sellnum",
				"sellmoney", "returnnum", "returnmoney", "cancelnum", "cancelmoney",
				"eticketnum","billdamagednum","returnhandcharge","servicefee",
				"bookservicefee","changeservicefee","moneypayable","stationservicefee",
		"fueladditionfee","computefee","coolairfee","additionfee","waterfee","insurefee","otherfee"},
				dao.queryTicketRevenue(propertyFilterList), new Object[] {
				BigDecimal.class,BigDecimal.class,BigDecimal.class,BigDecimal.class,
				BigDecimal.class,BigDecimal.class,BigDecimal.class,BigDecimal.class,
				BigDecimal.class,BigDecimal.class,BigDecimal.class,BigDecimal.class,
				BigDecimal.class,
				BigDecimal.class,BigDecimal.class,BigDecimal.class,BigDecimal.class,
				BigDecimal.class,BigDecimal.class,BigDecimal.class,BigDecimal.class
		});
		//list.get(0).put("stationservicefee",dao.queryTicketStationservicefee(propertyFilterList));
		return list;
	}

	@Override
	public BigDecimal qryNoTicketturnoverPrice(long sellerid) {
		BigDecimal totalprice=new BigDecimal(0);
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		propertyFilters.clear();					
		propertyFilters.add(new PropertyFilter("EQL_t!seller",sellerid));
		propertyFilters.add(new PropertyFilter("EQB_t!isturnover",false));
		List<Ticketturnoverdetail> tds = dao.find(Ticketturnoverdetail.class, propertyFilters);
		for(Ticketturnoverdetail td:tds){
			totalprice=totalprice.add(td.getMoneypayable());
		}
		return totalprice;
	}

	@Override
	public String qrylastlostmoney(long seller) {
		return dao.qrylastlostmoney(seller);
	}

	@Override
	public Ticketturnoverdetailepay getCurTicketturnoverdetailepay(
			Ticketturnoverdetail ticketturnoverdetail, long id, String payMethod) {
		Ticketturnoverdetailepay ticketturnoverdetailepay = null;
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		Date now = new Date();
		//插入或修改应缴款表
		propertyFilters.clear();
		propertyFilters.add(new PropertyFilter("EQS_t!paymethod", payMethod));
		propertyFilters.add(new PropertyFilter("EQL_t!ticketturnoverdetailid", ticketturnoverdetail.getId()));
		ticketturnoverdetailepay = (Ticketturnoverdetailepay) dao.uniqueResult(LockModeType.PESSIMISTIC_READ,Ticketturnoverdetailepay.class, propertyFilters);
		if(ticketturnoverdetailepay!=null && ticketturnoverdetailepay.getId()>0){//已有记录取出
			return ticketturnoverdetailepay;
		}else{
			ticketturnoverdetailepay = new Ticketturnoverdetailepay();
			ticketturnoverdetailepay.setCreateby(id);
			ticketturnoverdetailepay.setCreatetime(now);
			ticketturnoverdetailepay.setPrice(0D);
			ticketturnoverdetailepay.setTicketnum(0);
			ticketturnoverdetailepay.setPaymethod(payMethod);
		}
		return ticketturnoverdetailepay;
	}

	@Override
	public List<Map<String, Object>> qryticketturnoverdetailEPay(
			List<PropertyFilter> propertyFilterList) {
		List<Object> list = dao.qryticketturnoverdetailEPay(propertyFilterList);
		return ListUtil.listToMap(new Object[] { "id",
				"paymethod", "ticketnum", "price"},
				list, new Object[] {
				Long.class,String.class,Integer.class,BigDecimal.class
		});
	}
	/** 禅道号  15893 
	 * 售票员营收缴款  打印 应缴合计 查询出预售票和预售票款  “预售票数”和“预售金额” 
	 * @return
	 */
	@Override
	public List<Map<String, Object>> queryDetailBalanceAllow(String ticketturnoverdetailids,String ticketturnoverids) {
		List<Object> list = dao.queryDetailBalanceAllow(ticketturnoverdetailids,ticketturnoverids);
		return ListUtil.listToMap(new Object[] {"precount", "preprice"},
				list, new Object[] {Integer.class,BigDecimal.class
		});
	}
}
