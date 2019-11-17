package cn.nova.bus.pack.service.impl;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.persistence.LockModeType;

import cn.nova.bus.pack.dao.PacktturnoverdetailDao;
import cn.nova.bus.pack.model.Pack;
import cn.nova.bus.pack.model.Packtturnoverdetail;
import cn.nova.bus.pack.service.PacktturnoverdetailService;
import cn.nova.bus.sale.model.Ticketturnoverdetail;

import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;

@SuppressWarnings("unchecked")
public class PacktturnoverdetailServiceImpl implements PacktturnoverdetailService{

	
	private PacktturnoverdetailDao dao = new PacktturnoverdetailDao();

	

	/**
	 * 查询行包缴款明细
	 */
	@Override
	public List<Map<String, Object>> query(
			List<PropertyFilter> propertyFilterList) {
//		List<Object> result = new ArrayList<Object>();
//		Iterator<Object> iterator = dao.query(propertyFilterList).iterator();
//		while(iterator.hasNext()){
//			Object[] arr = (Object[]) iterator.next();
//			Packtturnoverdetail pdetail = (Packtturnoverdetail) arr[0];
//			String orgname = (String) arr[1];
//		}
		
	
		
		return ListUtil
				.listToMap(new Object[] { "id", "packtturnoverid", "moneydate",
						"sellby", "ticketstartno", "ticketendno",
						"turnovertime", "audittime", "sendpacks",
						"sendpackamount", "pickups", "pickupamount",
						"moneypayable", "isturnover", "isaudit", "batchno",
						"shipprice", "packfee", "unloadfee", "handfee",
						"custodial", "transitfee", "insuredamount",
						"insurancefee", "insurance", "deliveryfee",
						"servicefee", "otherfee", "packprice", "orgid",
						"datafrom", "createby", "updateby", "cancelnum",
						"returnnum", "ticketnum", "returnhandcharge",
						"returnmoney", "orgname", "datafromname", "sellbyname",
						"createbyname", "updatebyname", "ischoose" },
						dao.query(propertyFilterList), new Object[] {
								String.class, String.class, Date.class,
								String.class, String.class, String.class,
								String.class, String.class, Long.class,
								BigDecimal.class, Long.class, BigDecimal.class,
								BigDecimal.class, Boolean.class, Boolean.class,
								String.class, BigDecimal.class,
								BigDecimal.class, BigDecimal.class,
								BigDecimal.class, BigDecimal.class,
								BigDecimal.class, BigDecimal.class,
								BigDecimal.class, BigDecimal.class,
								BigDecimal.class, BigDecimal.class,
								BigDecimal.class, BigDecimal.class,
								String.class, String.class, String.class,
								String.class, Long.class, Long.class,
								Long.class, BigDecimal.class, BigDecimal.class,
								String.class, String.class, String.class,
								String.class, String.class, Boolean.class });
	}

	@Override
	public Packtturnoverdetail getById(long id) {
		return (Packtturnoverdetail) dao.get(Packtturnoverdetail.class, id);
	}
	
	public boolean wastePackcanclepacktturnoverdetail(Pack pack, long sellby) {
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		Date now = new Date();
		propertyFilters.clear();
		propertyFilters.add(new PropertyFilter("EQB_t!isturnover", false));
		propertyFilters.add(new PropertyFilter("EQD_t!moneydate",now));
		propertyFilters.add(new PropertyFilter("EQL_t!sellby",sellby));
		PacktturnoverdetailDao packtturnoverdetailDao = new PacktturnoverdetailDao();
		List<Packtturnoverdetail> list =  packtturnoverdetailDao.qryPacktturnoverdetailBypackno(propertyFilters, false);//查到某操作员某天的营收缴款(包括两部分：本人受理和退票的营收和退他人行包的营收)
		Packtturnoverdetail packtturnoverdetail = null;		//营收缴款
		if(null != list && list.size() > 0){
			  packtturnoverdetail = list.get(0);//今天已存在营收缴款
	          if (pack.getTotalfee() != null) {
	        	  packtturnoverdetail.setSendpackamount(packtturnoverdetail.getSendpackamount().subtract(pack.getTotalfee()));//合计金额 
		          packtturnoverdetail.setMoneypayable(packtturnoverdetail.getSendpackamount());//合计金额 
	          	}
	         if (pack.getShipprice() != null) {
	        	  packtturnoverdetail.setShipprice(packtturnoverdetail.getShipprice().subtract(pack.getShipprice()));//托运费 
	          	}
	         if (pack.getPackfee()!= null ) {
	        	  packtturnoverdetail.setPackfee(packtturnoverdetail.getPackfee().subtract(pack.getPackfee()));//包装费 
	         	}
	         if (pack.getHandfee()!= null ) {
	        	 packtturnoverdetail.setHandfee(packtturnoverdetail.getHandfee().subtract(pack.getHandfee()));//装卸费 
				}
	         if (pack.getCustodial()!= null ) {
	        	 packtturnoverdetail.setCustodial(packtturnoverdetail.getCustodial().subtract(pack.getCustodial()));//装卸费 
				}
	         if (pack.getTransitfee()!= null ) {
	        	 packtturnoverdetail.setTransitfee(packtturnoverdetail.getTransitfee().subtract(pack.getTransitfee()));//中转费 
				}
	         if (pack.getInsuredamount()!= null ) {
	        	 packtturnoverdetail.setInsuredamount(packtturnoverdetail.getInsuredamount().subtract(pack.getInsuredamount()));//保价金额 	
				}
	         if (pack.getInsurancefee()!= null ) {
	        	 packtturnoverdetail.setInsurancefee(packtturnoverdetail.getInsurancefee().subtract(pack.getInsurancefee()));//保价费 
				}
	         if (pack.getInsurance()!= null ) {
	        	 packtturnoverdetail.setInsurance(packtturnoverdetail.getInsurance().subtract(pack.getInsurance()));//保险费 
				}
	         if (pack.getDeliveryfee()!= null ) {
	        	 packtturnoverdetail.setDeliveryfee(packtturnoverdetail.getDeliveryfee().subtract(pack.getDeliveryfee()));//送货费 	
				}
	         if (pack.getServicefee()!= null ) {
	        	 packtturnoverdetail.setServicefee(packtturnoverdetail.getServicefee().subtract(pack.getServicefee()));//服务费
				}
	         if (pack.getOtherfee()!= null ) {
	        	 packtturnoverdetail.setOtherfee(packtturnoverdetail.getOtherfee().subtract(pack.getOtherfee()));//其他费
				}
	         if (pack.getPackprice()!= null ) {
	        	 packtturnoverdetail.setPackprice(packtturnoverdetail.getPackprice().subtract(pack.getPackprice()));//-代收货款 	
				}
	          if(pack.getUnloadfee() != null){//存在到货装卸费
	        	  packtturnoverdetail.setUnloadfee(pack.getUnloadfee().subtract(packtturnoverdetail.getUnloadfee())); //到货装卸费 = 原到货装卸费 - 行包到货装卸费
	          }
	          packtturnoverdetail.setSellby(sellby);
	          packtturnoverdetail.setCancelnum(packtturnoverdetail.getCancelnum()+1);//废票数
	          packtturnoverdetail.setUpdateby(sellby);
	          packtturnoverdetail.setUpdatetime(new Date());
	          packtturnoverdetailDao.merge(packtturnoverdetail);
	          
		}else{
			  packtturnoverdetail = new Packtturnoverdetail();
			  packtturnoverdetail.setMoneydate(new Date()); //行包缴款日期 
			  packtturnoverdetail.setSellby(pack.getSellby());//办理员 
			  packtturnoverdetail.setTicketstartno("0");//行包单号 
			  packtturnoverdetail.setTicketendno("0");//行包单号 
			  packtturnoverdetail.setSendpacks(0);//件数 
			  if (pack.getTotalfee()==null) {
				  packtturnoverdetail.setSendpackamount(BigDecimal.valueOf(0));
				  packtturnoverdetail.setMoneypayable(BigDecimal.valueOf(0));
			  }else{
				  packtturnoverdetail.setSendpackamount(pack.getTotalfee().negate());//合计金额  
				  packtturnoverdetail.setMoneypayable(pack.getTotalfee().negate());//合计金额 
			  }
			  packtturnoverdetail.setIsturnover(false);
			  packtturnoverdetail.setIsaudit(false);
			  if (pack.getShipprice()==null) {
				  packtturnoverdetail.setShipprice(BigDecimal.valueOf(0));
			  }else{
				  packtturnoverdetail.setShipprice(pack.getShipprice().negate());//托运费 
			  }
			  if(pack.getPackfee()==null){
				  packtturnoverdetail.setPackfee(BigDecimal.valueOf(0));
			  }else{
			  packtturnoverdetail.setPackfee(pack.getPackfee().negate());//包装费 
			  }
			  if(pack.getHandfee()==null){
				  packtturnoverdetail.setHandfee(BigDecimal.valueOf(0));  
			  }else{
				  packtturnoverdetail.setHandfee(pack.getHandfee().negate());//装卸费  
			  }
	          if(pack.getUnloadfee() == null){//到货装卸费
	        	  packtturnoverdetail.setUnloadfee(BigDecimal.valueOf(0));	//如果不存在货装卸费，则设置为0
	          }else{
	        	  packtturnoverdetail.setUnloadfee(pack.getUnloadfee().negate()); //存在货装卸费
	          }
	          if(pack.getCustodial()==null){
	        	  packtturnoverdetail.setCustodial(BigDecimal.valueOf(0));//保管费   
	          }else{
	        	  packtturnoverdetail.setCustodial(pack.getCustodial().negate());//保管费   
	          }
	          if(pack.getTransitfee()==null){
	        	  packtturnoverdetail.setTransitfee(BigDecimal.valueOf(0));//中转费   
	          }else{
	        	  packtturnoverdetail.setTransitfee(pack.getTransitfee().negate());//中转费   
	          }
	          if(pack.getInsuredamount() == null ){
	        	  packtturnoverdetail.setInsuredamount(BigDecimal.valueOf(0));//保价金额   
	          }else{
	        	  packtturnoverdetail.setInsuredamount(pack.getInsuredamount().negate());//保价金额   
	          }
	          if(pack.getInsurancefee() == null){
	        	  packtturnoverdetail.setInsurancefee(BigDecimal.valueOf(0));//保价费   
	          }else{
	        	  packtturnoverdetail.setInsurancefee(pack.getInsurancefee().negate());//保价费 
	          }
	          if(pack.getInsurance() == null){
	        	  packtturnoverdetail.setInsurance(BigDecimal.valueOf(0));//保险费   
	          }else{
	        	  packtturnoverdetail.setInsurance(pack.getInsurance().negate());//保险费   
	          }
			  if(pack.getDeliveryfee()==null){
				  packtturnoverdetail.setDeliveryfee(BigDecimal.valueOf(0));//送货费   
			  }else{
				  packtturnoverdetail.setDeliveryfee(pack.getDeliveryfee().negate());//送货费   
			  }
			  if(pack.getServicefee()==null){
				  packtturnoverdetail.setServicefee(BigDecimal.valueOf(0));//服务费  
			  }else{
				  packtturnoverdetail.setServicefee(pack.getServicefee().negate());//服务费  
			  }
			  if(pack.getOtherfee()==null){
				  packtturnoverdetail.setOtherfee(BigDecimal.valueOf(0));//其他费 
			  }else{
				  packtturnoverdetail.setOtherfee(pack.getOtherfee().negate());//其他费  
			  }
			  if(pack.getPackprice() == null){
				  packtturnoverdetail.setPackprice(BigDecimal.valueOf(0));//-代收货款  
			  }else{
				  packtturnoverdetail.setPackprice(pack.getPackprice().negate());//-代收货款 
			  }
		      packtturnoverdetail.setCancelnum(1);//废票数
		      packtturnoverdetail.setReturnnum(0); //退票数
		      packtturnoverdetail.setReturnmoney(new BigDecimal(0));//退票款
		      packtturnoverdetail.setReturnhandcharge(new BigDecimal(0));//手续费
			  packtturnoverdetail.setOrgid(pack.getOrgid());
			  packtturnoverdetail.setDatafrom("0");
			  packtturnoverdetail.setTicketnum(0);//用票数
			  packtturnoverdetail.setSellby(sellby);
			  packtturnoverdetail.setCreateby(sellby);
			  packtturnoverdetail.setCreatetime(pack.getCreatetime());
			  packtturnoverdetail.setUpdateby(sellby);
			  packtturnoverdetail.setUpdatetime(new Date());
			  packtturnoverdetailDao.merge(packtturnoverdetail);
		}
		return true;
	}
	@Override
	public Packtturnoverdetail getCurPackturnoverdetail(long sellby,Pack pack) {
		
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		Date now = new Date();
		propertyFilters.clear();
		propertyFilters.add(new PropertyFilter("EQB_t!isturnover", false));
		propertyFilters.add(new PropertyFilter("EQD_t!moneydate",now));
		propertyFilters.add(new PropertyFilter("EQL_t!sellby",sellby));
		propertyFilters.add(new PropertyFilter("EQS_t!paymethod", pack.getPaymethod()));
		List<Packtturnoverdetail> list =  dao.qryPacktturnoverdetailBypackno(propertyFilters, false);//查到某操作员某天的营收缴款
		Packtturnoverdetail packtturnoverdetail = null;		//营收缴款
		if(list != null && list.size()>0){
			packtturnoverdetail = list.get(0);//今天已存在营收缴款
			if("1".equals(pack.getPaymethod())){
				if("0".equals(packtturnoverdetail.getTicketstartno())){
					packtturnoverdetail.setTicketstartno(pack.getPackno());	
				}
				packtturnoverdetail.setTicketendno(pack.getPackno());
				packtturnoverdetail.setSendpacks(pack.getPieces()+packtturnoverdetail.getSendpacks());
		          packtturnoverdetail.setUpdateby(sellby);
		          packtturnoverdetail.setUpdatetime(pack.getUpdatetime());
		          packtturnoverdetail.setTicketnum(packtturnoverdetail.getTicketnum()+1);//用票数
		          dao.merge(packtturnoverdetail);
			}else{
				
			 if("0".equals(packtturnoverdetail.getTicketstartno())){
					packtturnoverdetail.setTicketstartno(pack.getPackno());	
				}
	          packtturnoverdetail.setTicketendno(pack.getPackno());//行包单号 
	          packtturnoverdetail.setSendpacks(pack.getPieces()+packtturnoverdetail.getSendpacks());//件数 
	          if (pack.getTotalfee() != null) {
	        	  packtturnoverdetail.setSendpackamount( pack.getTotalfee().add(packtturnoverdetail.getSendpackamount()) );//合计金额 
		          packtturnoverdetail.setMoneypayable(pack.getTotalfee().add(packtturnoverdetail.getMoneypayable()));//合计金额 
	          	}
	         if (pack.getShipprice() != null) {
	        	  packtturnoverdetail.setShipprice(pack.getShipprice().add(packtturnoverdetail.getShipprice()));//托运费 
	          	}
	         if (pack.getPackfee()!= null ) {
	        	  packtturnoverdetail.setPackfee(pack.getPackfee().add(packtturnoverdetail.getPackfee()));//包装费 
	         	}
	         if (pack.getHandfee()!= null ) {
	        	 packtturnoverdetail.setHandfee(pack.getHandfee().add(packtturnoverdetail.getHandfee()));//装卸费 
				}
	         if (pack.getCustodial()!= null ) {
	        	 packtturnoverdetail.setCustodial(pack.getCustodial().add(packtturnoverdetail.getCustodial()));//装卸费 
				}
	         if (pack.getTransitfee()!= null ) {
	        	 packtturnoverdetail.setTransitfee(pack.getTransitfee().add(packtturnoverdetail.getTransitfee()));//中转费 
				}
	         if (pack.getInsuredamount()!= null ) {
	        	 packtturnoverdetail.setInsuredamount(pack.getInsuredamount().add(packtturnoverdetail.getInsuredamount()));//保价金额 	
				}
	         if (pack.getInsurancefee()!= null ) {
	        	 packtturnoverdetail.setInsurancefee(pack.getInsurancefee().add(packtturnoverdetail.getInsurancefee()));//保价费 
				}
	         if (pack.getInsurance()!= null ) {
	        	 packtturnoverdetail.setInsurance(pack.getInsurance().add(packtturnoverdetail.getInsurance()));//保险费 
				}
	         if (pack.getDeliveryfee()!= null ) {
	        	 packtturnoverdetail.setDeliveryfee(pack.getDeliveryfee().add(packtturnoverdetail.getDeliveryfee()));//送货费 	
				}
	         if (pack.getServicefee()!= null ) {
	        	 packtturnoverdetail.setServicefee(pack.getServicefee().add(packtturnoverdetail.getServicefee()));//服务费
				}
	         if (pack.getOtherfee()!= null ) {
	        	 packtturnoverdetail.setOtherfee(pack.getOtherfee().add(packtturnoverdetail.getOtherfee()));//其他费
				}
	         if (pack.getPackprice()!= null ) {
	        	 packtturnoverdetail.setPackprice(pack.getPackprice().add(packtturnoverdetail.getPackprice()));//-代收货款 	
				}
	          if(pack.getUnloadfee() != null){//存在到货装卸费
	        	  packtturnoverdetail.setUnloadfee(packtturnoverdetail.getUnloadfee().add(pack.getUnloadfee())); //到货装卸费 = 原到货装卸费 + 行包到货装卸费
	          }
	          packtturnoverdetail.setTicketnum(packtturnoverdetail.getTicketnum()+1);//用票数
	          packtturnoverdetail.setUpdateby(pack.getUpdateby());
	          packtturnoverdetail.setUpdatetime(pack.getUpdatetime());
	          packtturnoverdetail = dao.merge(packtturnoverdetail);
			}
	          
		}else{
			 packtturnoverdetail = new Packtturnoverdetail();//今天还未存在营收缴款
			if("1".equals(pack.getPaymethod())){
				 packtturnoverdetail.setMoneydate(new Date()); //行包缴款日期 
				  packtturnoverdetail.setSellby(pack.getSellby());//办理员 
				  packtturnoverdetail.setTicketstartno(pack.getPackno());//行包单号 
				  packtturnoverdetail.setTicketendno(pack.getPackno());//行包单号 
				  packtturnoverdetail.setSendpacks(pack.getPieces());//件数 
				  packtturnoverdetail.setSendpackamount(BigDecimal.valueOf(0));
				  packtturnoverdetail.setMoneypayable(BigDecimal.valueOf(0));
				  packtturnoverdetail.setIsturnover(false);
				  packtturnoverdetail.setIsaudit(false);
				  packtturnoverdetail.setShipprice(BigDecimal.valueOf(0));
				  packtturnoverdetail.setPackfee(BigDecimal.valueOf(0));
				  packtturnoverdetail.setHandfee(BigDecimal.valueOf(0));  
	        	  packtturnoverdetail.setUnloadfee(BigDecimal.valueOf(0));	//如果不存在货装卸费，则设置为0
	        	  packtturnoverdetail.setCustodial(BigDecimal.valueOf(0));//保管费   
	        	  packtturnoverdetail.setTransitfee(BigDecimal.valueOf(0));//中转费   
	        	  packtturnoverdetail.setInsuredamount(BigDecimal.valueOf(0));//保价金额   
	        	  packtturnoverdetail.setInsurancefee(BigDecimal.valueOf(0));//保价费   
	        	  packtturnoverdetail.setInsurance(BigDecimal.valueOf(0));//保险费   
				  packtturnoverdetail.setDeliveryfee(BigDecimal.valueOf(0));//送货费   
				  packtturnoverdetail.setServicefee(BigDecimal.valueOf(0));//服务费  
				  packtturnoverdetail.setOtherfee(BigDecimal.valueOf(0));//其他费 
				  packtturnoverdetail.setPackprice(BigDecimal.valueOf(0));//-代收货款  
				  packtturnoverdetail.setReturnnum(0);
				  packtturnoverdetail.setReturnhandcharge(BigDecimal.valueOf(0));
				  packtturnoverdetail.setReturnmoney(BigDecimal.valueOf(0));
				  packtturnoverdetail.setCancelnum(0);
				  packtturnoverdetail.setOrgid(pack.getOrgid());
				  packtturnoverdetail.setDatafrom("0");
				  packtturnoverdetail.setTicketnum(1);//用票数
				  packtturnoverdetail.setCreateby(pack.getCreateby());
				  packtturnoverdetail.setCreatetime(pack.getCreatetime());
				  packtturnoverdetail.setUpdateby(pack.getUpdateby());
				  packtturnoverdetail.setUpdatetime(pack.getUpdatetime());
				  packtturnoverdetail.setPaymethod(pack.getPaymethod());//行包付款方式
				  packtturnoverdetail = dao.merge(packtturnoverdetail);	
			}else{
			 
			  packtturnoverdetail.setMoneydate(new Date()); //行包缴款日期 __________________
			  packtturnoverdetail.setSellby(pack.getSellby());//办理员 ______________
			  packtturnoverdetail.setTicketstartno(pack.getPackno());//行包单号 __________________
			  packtturnoverdetail.setTicketendno(pack.getPackno());//行包单号 __________________
			  packtturnoverdetail.setSendpacks(pack.getPieces());//件数 __________________
			  if (pack.getTotalfee()==null) {
				  packtturnoverdetail.setSendpackamount(BigDecimal.valueOf(0));
				  packtturnoverdetail.setMoneypayable(BigDecimal.valueOf(0));
			  }else{
				  packtturnoverdetail.setSendpackamount(pack.getTotalfee());//合计金额  __________________
				  packtturnoverdetail.setMoneypayable(pack.getTotalfee());//合计金额  __________________
			  }
			  packtturnoverdetail.setIsturnover(false);
			  packtturnoverdetail.setIsaudit(false);
			  if (pack.getShipprice()==null) {
				  packtturnoverdetail.setShipprice(BigDecimal.valueOf(0));
			  }else{
				  packtturnoverdetail.setShipprice(pack.getShipprice());//托运费 
			  }
			  if(pack.getPackfee()==null){
				  packtturnoverdetail.setPackfee(BigDecimal.valueOf(0));
			  }else{
			  packtturnoverdetail.setPackfee(pack.getPackfee());//包装费 
			  }
			  if(pack.getHandfee()==null){
				  packtturnoverdetail.setHandfee(BigDecimal.valueOf(0));  
			  }else{
				  packtturnoverdetail.setHandfee(pack.getHandfee());//装卸费  
			  }
	          if(pack.getUnloadfee() == null){//到货装卸费
	        	  packtturnoverdetail.setUnloadfee(BigDecimal.valueOf(0));	//如果不存在货装卸费，则设置为0
	          }else{
	        	  packtturnoverdetail.setUnloadfee(pack.getUnloadfee()); //存在货装卸费
	          }
	          if(pack.getCustodial()==null){
	        	  packtturnoverdetail.setCustodial(BigDecimal.valueOf(0));//保管费   
	          }else{
	        	  packtturnoverdetail.setCustodial(pack.getCustodial());//保管费   
	          }
	          if(pack.getTransitfee()==null){
	        	  packtturnoverdetail.setTransitfee(BigDecimal.valueOf(0));//中转费   
	          }else{
	        	  packtturnoverdetail.setTransitfee(pack.getTransitfee());//中转费   
	          }
	          if(pack.getInsuredamount() == null ){
	        	  packtturnoverdetail.setInsuredamount(BigDecimal.valueOf(0));//保价金额   
	          }else{
	        	  packtturnoverdetail.setInsuredamount(pack.getInsuredamount());//保价金额   
	          }
	          if(pack.getInsurancefee() == null){
	        	  packtturnoverdetail.setInsurancefee(BigDecimal.valueOf(0));//保价费   
	          }else{
	        	  packtturnoverdetail.setInsurancefee(pack.getInsurancefee());//保价费 
	          }
	          if(pack.getInsurance() == null){
	        	  packtturnoverdetail.setInsurance(BigDecimal.valueOf(0));//保险费   
	          }else{
	        	  packtturnoverdetail.setInsurance(pack.getInsurance());//保险费   
	          }
			  if(pack.getDeliveryfee()==null){
				  packtturnoverdetail.setDeliveryfee(BigDecimal.valueOf(0));//送货费   
			  }else{
				  packtturnoverdetail.setDeliveryfee(pack.getDeliveryfee());//送货费   
			  }
			  if(pack.getServicefee()==null){
				  packtturnoverdetail.setServicefee(BigDecimal.valueOf(0));//服务费  
			  }else{
				  packtturnoverdetail.setServicefee(pack.getServicefee());//服务费  
			  }
			  if(pack.getOtherfee()==null){
				  packtturnoverdetail.setOtherfee(BigDecimal.valueOf(0));//其他费 
			  }else{
				  packtturnoverdetail.setOtherfee(pack.getOtherfee());//其他费  
			  }
			  if(pack.getPackprice() == null){
				  packtturnoverdetail.setPackprice(BigDecimal.valueOf(0));//-代收货款  
			  }else{
				  packtturnoverdetail.setPackprice(pack.getPackprice());//-代收货款 
			  }
			  packtturnoverdetail.setPaymethod(pack.getPaymethod());//行包付款方式
			  packtturnoverdetail.setTicketnum(1);//用票数
			  packtturnoverdetail.setReturnnum(0);
			  packtturnoverdetail.setReturnhandcharge(BigDecimal.valueOf(0));
			  packtturnoverdetail.setReturnmoney(BigDecimal.valueOf(0));
			  packtturnoverdetail.setCancelnum(0);
			  packtturnoverdetail.setOrgid(pack.getOrgid());
			  packtturnoverdetail.setDatafrom("0");
			  packtturnoverdetail.setCreateby(pack.getCreateby());
			  packtturnoverdetail.setCreatetime(pack.getCreatetime());
			  packtturnoverdetail.setUpdateby(pack.getUpdateby());
			  packtturnoverdetail.setUpdatetime(pack.getUpdatetime());
			  packtturnoverdetail = dao.merge(packtturnoverdetail);
		}
		}
		return packtturnoverdetail ;
	}
}
