package cn.nova.bus.pack.service.impl;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import play.db.jpa.JPA;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.pack.dao.PackDao;
import cn.nova.bus.pack.dao.PacktturnoverdetailDao;
import cn.nova.bus.pack.model.Pack;
import cn.nova.bus.pack.model.Packreturnback;
import cn.nova.bus.pack.model.Packtturnoverdetail;
import cn.nova.bus.pack.service.PackreturnbackService;
import cn.nova.bus.security.Global;
import cn.nova.utils.orm.PropertyFilter;

public class PackreturnbackServiceImpl implements PackreturnbackService {

	@Override
	public Boolean save(Packreturnback preturnback,Global global) {
		// TODO Auto-generated method stub
		if(!JPA.em().getTransaction().isActive()){
			JPA.em().getTransaction().begin();
		}
		Packreturnback prb = new EntityManagerDaoSurport<Packreturnback>().merge(preturnback);
		Pack pack = new PackDao().getEntityManager().find(Pack.class, preturnback.getPackid());//该行包
		updatePackturnoverdetail(global.getUserinfo().getId(), pack, preturnback.getFee());//给当前退票的操作员记录一条负的营收
		JPA.em().getTransaction().commit();
		if(prb == null){
			return false;
		} else {
			return true;
		}
	}
	//更新行包营收缴款,退票营收，记录为负数
	private Packtturnoverdetail updatePackturnoverdetail(long sellby, Pack pack, BigDecimal fee) {//fee:手续费

		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		propertyFilters.clear();
		propertyFilters.add(new PropertyFilter("EQB_t!isturnover", false));
		propertyFilters.add(new PropertyFilter("EQD_t!moneydate", new Date()));
		propertyFilters.add(new PropertyFilter("EQL_t!sellby", sellby));

		PacktturnoverdetailDao packtturnoverdetailDao = new PacktturnoverdetailDao();
		List<Packtturnoverdetail> list =  packtturnoverdetailDao.qryPacktturnoverdetailBypackno(propertyFilters, false);//查到某操作员某天的营收缴款(包括两部分：本人受理和退票的营收和退他人行包的营收)
		Packtturnoverdetail packtturnoverdetail = null;		//营收缴款
		if(null != list && list.size() > 0){
			  packtturnoverdetail = list.get(0);//今天已存在营收缴款
//	          packtturnoverdetail.setTicketendno(pack.getPackno());//行包单号 
//	          packtturnoverdetail.setSendpacks(pack.getPieces()+packtturnoverdetail.getSendpacks());//件数 
	          if (pack.getTotalfee() != null) {
	        	  packtturnoverdetail.setSendpackamount((packtturnoverdetail.getSendpackamount().subtract(pack.getTotalfee())).add(fee));//总的营收数-行包总数+ 手续费 
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
	          packtturnoverdetail.setReturnnum(packtturnoverdetail.getReturnnum() +1); //退票数
	          packtturnoverdetail.setSellby(sellby);
	          packtturnoverdetail.setReturnmoney(packtturnoverdetail.getReturnmoney().add(pack.getTotalfee().subtract(fee)));//退票款
	          packtturnoverdetail.setReturnhandcharge(packtturnoverdetail.getReturnhandcharge().add(fee));//手续费
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
				  packtturnoverdetail.setSendpackamount((pack.getTotalfee().subtract(fee)).negate());//合计金额  
				  packtturnoverdetail.setMoneypayable(packtturnoverdetail.getSendpackamount());//合计金额 
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
		  
		        packtturnoverdetail.setReturnnum(1); //退票数
		        packtturnoverdetail.setReturnmoney((pack.getTotalfee().subtract(fee)));//退票款
		        packtturnoverdetail.setReturnhandcharge(fee);//手续费
		        packtturnoverdetail.setCancelnum(0);
			  packtturnoverdetail.setOrgid(pack.getOrgid());
			  packtturnoverdetail.setDatafrom("0");
			  packtturnoverdetail.setTicketnum(0);
			  packtturnoverdetail.setSellby(sellby);
			  packtturnoverdetail.setCreateby(sellby);
			  packtturnoverdetail.setCreatetime(pack.getCreatetime());
			  packtturnoverdetail.setUpdateby(sellby);
			  packtturnoverdetail.setUpdatetime(new Date());
			  packtturnoverdetailDao.merge(packtturnoverdetail);
		}
		
		return packtturnoverdetail ;
	}
}
