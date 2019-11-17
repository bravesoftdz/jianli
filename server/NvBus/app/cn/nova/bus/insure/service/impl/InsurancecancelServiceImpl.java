package cn.nova.bus.insure.service.impl;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.persistence.LockModeType;

import cn.nova.bus.base.model.Platforminsureorderdetail;
import cn.nova.bus.common.ParamterConst;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.insure.model.Insurance;
import cn.nova.bus.insure.model.Insurancecancel;
import cn.nova.bus.insure.model.Insuranceturnoverdetail;
import cn.nova.bus.insure.service.InsurancecancelService;
import cn.nova.bus.sale.model.Ticketcancel;
import cn.nova.bus.security.Global;
import cn.nova.bus.system.service.ParameterService;
import cn.nova.bus.system.service.impl.ParameterServiceImpl;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.IDAO;

public class InsurancecancelServiceImpl implements InsurancecancelService {
	
	private IDAO dao = new EntityManagerDaoSurport();	
	@Override
	public void cancelInsuranceAtcancelTicket(List<Ticketcancel> ticketcancels,Global global) throws ServiceException{
		int cancelinsurenum=0;
		List<Insurancecancel> insurancecancels = new ArrayList<Insurancecancel>();
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		//统计废保险金额、数量
		for (Ticketcancel ticketcancel : ticketcancels) {
			if(ticketcancel.getIscancelinsure()){
				cancelinsurenum++;
				propertyFilters.clear();
				Insurance insurance = (Insurance) dao.get(Insurance.class, ticketcancel.getCancelinsureid());
				if(insurance==null){
					throw new ServiceException("0184");
				}
				else if("1".equals(insurance.getInsurancestatus())){
					throw new ServiceException("0185");
				}
				else if("2".equals(insurance.getInsurancestatus())){
					continue;
//					throw new ServiceException("0186");
				}
				else{
					Insurancecancel insurancecancel = new Insurancecancel();
					insurancecancel.setInsuranceid(insurance.getId());
					insurancecancel.setCancelway(ticketcancel.getCancelway());
					insurancecancel.setRemarks(ticketcancel.getRemarks());
					insurancecancel.setSellby(ticketcancel.getInsurancesellby());
					insurancecancels.add(insurancecancel);
				}
			}
		}
		if(cancelinsurenum==0){
			return;
		}
		this.cancelInsurance(insurancecancels, global);
	}

	@Override
	public void cancelInsurance(List<Insurancecancel> insurancecancels,Global global) throws ServiceException{
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		//插入或修改应保险缴款表
		Date now = new Date();
		propertyFilters.clear();
		propertyFilters.add(new PropertyFilter("EQB_t!isturnover", false));
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(now);
		calendar.set(calendar.get(Calendar.YEAR), 
					calendar.get(Calendar.MONTH), 
					calendar.get(Calendar.DAY_OF_MONTH), 
					0,0, 0);
		propertyFilters.add(new PropertyFilter("EQD_t!moneydate",calendar.getTime()));
		long selluserid = insurancecancels.get(0).getSellby();
		for (Insurancecancel insurancecancel : insurancecancels) {
			if(selluserid!=insurancecancel.getSellby()){
				throw new ServiceException("0223");  //废保险票不能同时废不同售票员售出的保险票
			}
		}
		propertyFilters.add(new PropertyFilter("EQL_t!seller",selluserid));
		List<Insuranceturnoverdetail> insuranceturnoverdetails = dao.find(Insuranceturnoverdetail.class, propertyFilters);
		boolean neednew = true;
		Insuranceturnoverdetail insuranceturnoverdetail=null;
		if(insuranceturnoverdetails!=null&&insuranceturnoverdetails.size()>0){
				insuranceturnoverdetail=insuranceturnoverdetails.get(0);
				neednew=false;
		}
		if(neednew){
			insuranceturnoverdetail = new Insuranceturnoverdetail();
			insuranceturnoverdetail.setMoneypayable(new BigDecimal(0));
			insuranceturnoverdetail.setSellmoney(new BigDecimal(0));
			insuranceturnoverdetail.setSellnum(0);
			insuranceturnoverdetail.setUpdateby(global.getUserinfo().getId());
			insuranceturnoverdetail.setUpdatetime(now);
			insuranceturnoverdetail.setCancelnum(0);
			insuranceturnoverdetail.setCancelmoney(new BigDecimal(0));
			insuranceturnoverdetail.setNonvouchermoneypayable(new BigDecimal(0));
			insuranceturnoverdetail.setNoncashmoney(new BigDecimal(0));
			insuranceturnoverdetail.setNoncashnum(0);
			insuranceturnoverdetail.setCreateby(global.getUserinfo().getId());
			insuranceturnoverdetail.setCreatetime(now);
			insuranceturnoverdetail.setEticketnum(0);
			insuranceturnoverdetail.setMoneydate(now);
			insuranceturnoverdetail.setReturnhandcharge(new BigDecimal(0));
			insuranceturnoverdetail.setReturnmoney(new BigDecimal(0));
			insuranceturnoverdetail.setReturnnum(0);
			insuranceturnoverdetail.setSeller(selluserid);
			insuranceturnoverdetail.setTicketturnover(null);
			insuranceturnoverdetail.setIsturnover(false);
			insuranceturnoverdetail.setTurnovertime(null);
			insuranceturnoverdetail.setTicketstartno("0");
			insuranceturnoverdetail.setTicketendno("0");
		}
		insuranceturnoverdetail.setCancelnum(insuranceturnoverdetail.getCancelnum()+insurancecancels.size());
		insuranceturnoverdetail.setUpdateby(global.getUserinfo().getId());
		insuranceturnoverdetail.setUpdatetime(now);
		
		ParameterService parameterService = new ParameterServiceImpl();
		String param2626 = parameterService.findParamValue(ParamterConst.Param_2626, global.getOrganization().getId());
		String param2627 = parameterService.findParamValue(ParamterConst.Param_2627, global.getOrganization().getId());
		//废保险
		for (Insurancecancel insurancecancel : insurancecancels) {
			propertyFilters.clear();
			Insurance insurance = (Insurance) dao.get(LockModeType.PESSIMISTIC_READ,Insurance.class, insurancecancel.getInsuranceid());
			if(insurance==null){
				throw new ServiceException("0184");
			}
			else if("1".equals(insurance.getInsurancestatus())){
				throw new ServiceException("0185");
			}
			else if("2".equals(insurance.getInsurancestatus())){
				throw new ServiceException("0186");
			}else if(ParamterConst.COMMON_FLAG.FALG_YES.equals(param2626) && ParamterConst.COMMON_FLAG.FALG_YES.equals(param2627) &&
					("7".equals(insurance.getSellway()) || "10".equals(insurance.getSellway()))){
				throw new ServiceException("0517");
			}
			else{
				insurance.setInsurancestatus("2");
			}
			dao.merge(insurance);
			insurancecancel.setPremium(insurance.getPremium());
			insuranceturnoverdetail.setMoneypayable(insuranceturnoverdetail.getMoneypayable().subtract(insurancecancel.getPremium()));
			insuranceturnoverdetail.setCancelmoney(insuranceturnoverdetail.getCancelmoney().add(insurancecancel.getPremium()));
			//0现金、1银联卡、2贵客卡余额、3贵客卡积分
			if("2".equals(insurance.getPaymethod())||"3".equals(insurance.getPaymethod())){
				insuranceturnoverdetail.setNonvouchermoneypayable(insuranceturnoverdetail.getNonvouchermoneypayable().subtract(insurancecancel.getPremium()));
			}

			insurancecancel.setCreateby(global.getUserinfo().getId());
			insurancecancel.setCreatetime(now);
			insurancecancel.setCancelby(global.getUserinfo().getId());
			insurancecancel.setCancelip(global.getIpAddress());
			insurancecancel.setCanceltime(now);
			insurancecancel.setTicketoutletsid(global.getTicketoutlets().getId());
			insurancecancel.setUpdateby(global.getUserinfo().getId());
			insurancecancel.setUpdatetime(now);
			//bus365保险服务器退保险
			if(ParamterConst.COMMON_FLAG.FALG_YES.equals(param2626)){
				propertyFilters.clear();
				propertyFilters.add(new PropertyFilter("EQL_t!insuranceid",insurancecancel.getInsuranceid()));
				List<Platforminsureorderdetail> pdList = dao.find(Platforminsureorderdetail.class, propertyFilters);
				if(pdList.size()==1){
					Platforminsureorderdetail detail = pdList.get(0);
					detail.setStatus(4);
					dao.merge(detail);
				}
			}
		}
		insuranceturnoverdetail = (Insuranceturnoverdetail) dao.merge(insuranceturnoverdetail);
		for (Insurancecancel insurancecancel : insurancecancels) {
			insurancecancel.setTurnoverdetailid(insuranceturnoverdetail.getId());
			dao.merge(insurancecancel);
		}
		//TODO 调用保险方接口   
	}
}
