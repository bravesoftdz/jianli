package cn.nova.bus.insure.service.impl;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.LockModeType;

import cn.nova.bus.base.model.Platforminsureorderdetail;
import cn.nova.bus.common.ParamterConst;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.exception.BusinessException;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.insure.model.Insurance;
import cn.nova.bus.insure.model.Insurancereturn;
import cn.nova.bus.insure.model.Insuranceturnoverdetail;
import cn.nova.bus.insure.service.InsurancereturnService;
import cn.nova.bus.log.model.Operationlog;
import cn.nova.bus.sale.model.Ticketreturn;
import cn.nova.bus.sale.model.Ticketsell;
import cn.nova.bus.sale.service.TicketpriceReturnService;
import cn.nova.bus.sale.service.impl.TicketpriceReturnServiceImpl;
import cn.nova.bus.security.Global;
import cn.nova.bus.system.service.ParameterService;
import cn.nova.bus.system.service.impl.ParameterServiceImpl;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.IDAO;

public class InsurancereturnServiceImpl implements InsurancereturnService { 
	
	private IDAO dao = new EntityManagerDaoSurport();
	ParameterService parameterService = new ParameterServiceImpl();
	
	//原路退款
	private TicketpriceReturnService ticketpriceReturnService;
	
	@Override
	public void returnInsuranceAtreturnTicket(List<Ticketreturn> ticketreturns,
			Global global) throws ServiceException {
		
		String param1181 = parameterService.findParamValue("1181", global.getOrganization().getId());
		int returninsurenum = 0;
		List<Insurancereturn> insurancereturns = new ArrayList<Insurancereturn>();
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		// 统计退保险金额、数量
		for (Ticketreturn ticketreturn : ticketreturns) {
			if (ticketreturn.getIsreturninsure()) {
				returninsurenum++;
				propertyFilters.clear();
				Insurance insurance = (Insurance) dao.get(Insurance.class,ticketreturn.getReturninsureid());
				if (insurance == null) {
					//EXCEPTIONINFO-0172:找不到对应的保险单
					throw new ServiceException("0172");
				} 
				//符合原路退款的保险不允许单独退、否则提示：已过发车日期，不允许单独退保险！ add by tianhb 2018年6月14日 BEGIN
				Ticketsell ticketsell = (Ticketsell)dao.get(LockModeType.NONE,Ticketsell.class, insurance.getSellid());
				String msg = "该保险已经【原路退款】、不允许单独退保险-保险号:" + insurance.getInsuranceno();
				if(null == ticketpriceReturnService){
					ticketpriceReturnService = new TicketpriceReturnServiceImpl();
				}
				//符合原路退款的保险不允许单独退、否则提示：已过发车日期，不允许单独退保险！ add by tianhb 2018年6月14日 END
				if ("1".equals(insurance.getInsurancestatus())) {
					//EXCEPTIONINFO-0173:该保险单状态为已退，不允许退保险
					throw new ServiceException("0173");
				} else if ("2".equals(insurance.getInsurancestatus())) {
					//EXCEPTIONINFO-0174:该保险单状态为已废，不允许退保险
					throw new ServiceException("0174");
				}else if((!ticketreturn.getIsreturnticket()) && ParamterConst.COMMON_FLAG.FALG_NO.equalsIgnoreCase(param1181)
						&& (insurance.getSellway().equals("10")||insurance.getSellway().equals("7"))){
					throw new BusinessException("网售票/自助机售票不允许单独退保险！");
				//符合原路退款的保险不允许单独退、否则提示：已过发车日期，不允许单独退保险！ add by tianhb 2018年6月14日 BEGIN
				}else if(null != ticketsell && ticketpriceReturnService.isCanReturnBack(ticketsell)){
					if(ticketpriceReturnService.isExistTicketpriceReturn(ticketsell.getId())){
						play.Logger.info(msg);
						throw new BusinessException(msg);
					}else{
						msg = "已过发车日期，不允许单独退保险-保险号:" + insurance.getInsuranceno();
						play.Logger.info(msg);
						throw new BusinessException(msg);
					}
				//符合原路退款的保险不允许单独退、否则提示：已过发车日期，不允许单独退保险！ add by tianhb
				} else {
					Insurancereturn insurancereturn = new Insurancereturn();
					insurancereturn.setPremium(insurance.getPremium());
					insurancereturn.setInsuranceid(insurance.getId());

					insurancereturn.setReturnfeemode(ticketreturn.getReturnfeemode());//返款模式
//					if("1".equals(ticketreturn.getReturnfeemode())){//若是原路返还的退0元
//						insurancereturn.setPremium(new BigDecimal(0));
//					}else{
//						insurancereturn.setPremium(insurance.getPremium());
//					}
					insurancereturn.setReturnway(ticketreturn.getReturnway());
					insurancereturn.setRemarks(ticketreturn.getRemarks());
					insurancereturn.setPaymethod(insurance.getPaymethod());
					insurancereturns.add(insurancereturn);
				}
			}
		}
		if (returninsurenum == 0) {
			return;
		}
//		this.returnInsurance(insurancereturns, global);
		returnInsuranceSplit(insurancereturns, global);//调用修改后方法
	}
	/**
	 * 重新梳理退保险方法，对returnInsurance(List<Insurancereturn> insurancereturns, Global global)部分逻辑做了修改：
	 * 		1.退保险分为：退车站售保险、退网售保险、退自助机售保险
	 * 		2.其中：窗口退网售保险，则退保记录的退保人、退保数、退保金额记为网站
	 * @param insurancereturns
	 * @param global
	 * @throws ServiceException
	 */
	public void returnInsuranceSplit(List<Insurancereturn> insurancereturns,
			Global global) throws ServiceException {
		//将网售保险和车站窗口售保分开
		Map<String, Object> map = splitInsuranceReturn(insurancereturns);
		Long sellbyWeb = (Long) map.get("sellbyWeb");
		List<Insurancereturn> insReturnListWeb = (List<Insurancereturn>) map.get("insReturnListWeb");//网售保险
		List<Insurancereturn> insReturnListStation = (List<Insurancereturn>) map.get("insReturnListStation");//车站售保险
		
		Date now = new Date();
		//退车站售出的保险
		if(insReturnListStation.size() > 0){
			Insuranceturnoverdetail insuTurnoverDetailStation = getCurInsuTurnoverDetailStation(global, now);//获取车站用户保险缴款明细
			//退保
			returnInsuranceStation(insReturnListStation, insuTurnoverDetailStation, global, now);
		}
		
		//退网站售出的保险
		if(insReturnListWeb.size() > 0){
			//获取网站用户保险缴款明细
			Insuranceturnoverdetail insuTurnoverDetailWeb = getCurInsuTurnoverDetailWeb(global, now, sellbyWeb);//获取网站用户保险缴款明细
			//退保
			returnInsuranceWeb(insReturnListWeb, insuTurnoverDetailWeb, global, now);
		}
	}
	/**
	 * 获取网站售票员保险缴款明细
	 * @param global
	 * @param now
	 * @param sellbyWeb
	 * @return
	 */
	private Insuranceturnoverdetail getCurInsuTurnoverDetailWeb(Global global, Date now, Long sellbyWeb){
		Insuranceturnoverdetail insuTurnoverDetailWeb = null;
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		
		//网站保险营收		
		propertyFilters.clear();
		propertyFilters.add(new PropertyFilter("EQB_t!isturnover", false));
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(now);
		calendar.set(calendar.get(Calendar.YEAR), calendar.get(Calendar.MONTH),
				calendar.get(Calendar.DAY_OF_MONTH), 0, 0, 0);
		propertyFilters.add(new PropertyFilter("EQD_t!moneydate", calendar
				.getTime()));
		propertyFilters.add(new PropertyFilter("EQL_t!seller", sellbyWeb));
		List<Insuranceturnoverdetail> insuranceturnoverdetailswebs = dao.find(
				Insuranceturnoverdetail.class, propertyFilters);
		
		boolean needNew = true;
		if (insuranceturnoverdetailswebs != null
				&& insuranceturnoverdetailswebs.size() > 0) {
			insuTurnoverDetailWeb = insuranceturnoverdetailswebs.get(0);
			needNew = false;
		}
		//新建退网售保险营收
		if (needNew) {
			insuTurnoverDetailWeb = new Insuranceturnoverdetail();
			insuTurnoverDetailWeb.setMoneypayable(new BigDecimal(0));
			insuTurnoverDetailWeb.setSellmoney(new BigDecimal(0));
			insuTurnoverDetailWeb.setSellnum(0);
			insuTurnoverDetailWeb.setUpdateby(sellbyWeb);
			insuTurnoverDetailWeb.setUpdatetime(now);
			insuTurnoverDetailWeb.setCancelnum(0);
			insuTurnoverDetailWeb.setCancelmoney(new BigDecimal(0));
			insuTurnoverDetailWeb
					.setNonvouchermoneypayable(new BigDecimal(0));
			insuTurnoverDetailWeb.setNoncashmoney(new BigDecimal(0));
			insuTurnoverDetailWeb.setNoncashnum(0);
			insuTurnoverDetailWeb.setCreateby(sellbyWeb);
			insuTurnoverDetailWeb.setCreatetime(now);
			insuTurnoverDetailWeb.setEticketnum(0);
			insuTurnoverDetailWeb.setMoneydate(now);
			insuTurnoverDetailWeb.setReturnhandcharge(new BigDecimal(0));
			insuTurnoverDetailWeb.setReturnmoney(new BigDecimal(0));
			insuTurnoverDetailWeb.setReturnnum(0);
			insuTurnoverDetailWeb.setSeller(sellbyWeb);
			insuTurnoverDetailWeb.setTicketturnover(null);
			insuTurnoverDetailWeb.setIsturnover(false);
			insuTurnoverDetailWeb.setTurnovertime(null);
			insuTurnoverDetailWeb.setTicketstartno("0");
			insuTurnoverDetailWeb.setTicketendno("0");
			insuTurnoverDetailWeb.setEreturnbackmoney(new BigDecimal(0));
			insuTurnoverDetailWeb.setEreturnbacknum(0);
			insuTurnoverDetailWeb.setEreturnmoney(new BigDecimal(0));
			insuTurnoverDetailWeb.setEreturnnum(0);
			insuTurnoverDetailWeb.setNoncashmoneypayable(BigDecimal.ZERO);
			insuTurnoverDetailWeb.setMoney(BigDecimal.ZERO);
			insuTurnoverDetailWeb.setLost(BigDecimal.ZERO);
			insuTurnoverDetailWeb.setEreturncharge(BigDecimal.ZERO);
		}
			
		return insuTurnoverDetailWeb;
	}
	/**
	 * 车站退网售保险：
	 * 		退保数、退保金额统计到网站用户头上
	 * @param insReturnListWeb
	 * @param insuTurnoverDetailWeb
	 * @param global
	 * @param now
	 * @throws ServiceException
	 */
	private void returnInsuranceWeb(List<Insurancereturn> insReturnListWeb,
			Insuranceturnoverdetail insuTurnoverDetailWeb, Global global, Date now) throws ServiceException{
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		ParameterService parameterService = new ParameterServiceImpl();
		//2626: 是否使用bus365平台售保险，0不适用，1使用
		String param2626 = parameterService.findParamValue(ParamterConst.Param_2626, global.getOrganization().getId());
		//2727: 平台售保险自助机或者网上售票退保控制0不控制1控制
		String param2627 = parameterService.findParamValue(ParamterConst.Param_2627, global.getOrganization().getId());
		
		//修改保险为退保状态，保存退保记录，更新保险缴款明细记录
		for (Insurancereturn insurancereturn : insReturnListWeb) {
			//修改保险
			propertyFilters.clear();
			Insurance insurance = (Insurance) dao.get(
					LockModeType.PESSIMISTIC_READ, Insurance.class,
					insurancereturn.getInsuranceid());
			if (insurance == null) {
				throw new ServiceException("0172");
			} else if ("1".equals(insurance.getInsurancestatus())) {
				throw new ServiceException("0173");
			} else if ("2".equals(insurance.getInsurancestatus())) {
				throw new ServiceException("0174");
			} else if(ParamterConst.COMMON_FLAG.FALG_YES.equals(param2626) && ParamterConst.COMMON_FLAG.FALG_YES.equals(param2627) &&
					("7".equals(insurance.getSellway()) || "10".equals(insurance.getSellway()))){
				throw new ServiceException("0517");
			}else {
				insurance.setInsurancestatus("1");
			}
			if(insurancereturn.getPremium().compareTo(new BigDecimal(0))==0
					||insurancereturn.getPremium().toString().equals("0")){
				throw new ServiceException("退保金额为0不允许退保","800");
			}
			dao.merge(insurance);
			
			//如果是网售 退保修改网售营收
			play.Logger.info("--- update before Web insuranceturnoverdetail.getReturnnum()=" + insuTurnoverDetailWeb.getReturnnum()
					+ ", getReturnmoney()=" + insuTurnoverDetailWeb.getReturnmoney());
			insuTurnoverDetailWeb.setReturnnum(insuTurnoverDetailWeb.getReturnnum()+1);//退保数+1
			insuTurnoverDetailWeb.setMoneypayable(insuTurnoverDetailWeb
					.getMoneypayable().subtract(insurancereturn.getPremium()));
			insuTurnoverDetailWeb.setReturnmoney(insuTurnoverDetailWeb
					.getReturnmoney().add(insurancereturn.getPremium()));
			
			play.Logger.info("--- update after Web insurancereturn.getPremium()=" + insurancereturn.getPremium()+
					", getReturnnum()=" + insuTurnoverDetailWeb.getReturnnum()+ ", getReturnmoney()=" + insuTurnoverDetailWeb.getReturnmoney());
			if ("2".equals(insurance.getPaymethod())
					|| "3".equals(insurance.getPaymethod())) {// 0现金、1银联卡、2贵客卡余额、3贵客卡积分
				insuTurnoverDetailWeb.setNonvouchermoneypayable(insuTurnoverDetailWeb
								.getNonvouchermoneypayable().subtract(insurancereturn.getPremium()));
			}

			//保存保险退票记录
			insurancereturn.setCreateby(global.getUserinfo().getId());
			insurancereturn.setCreatetime(now);
			insurancereturn.setReturnby(insurance.getSellby());//网售保险，退保时退保人记为网站售票员
			insurancereturn.setReturnip(global.getIpAddress());
			insurancereturn.setReturntime(now);
			insurancereturn.setTicketoutletsid(global.getTicketoutlets().getId());
			insurancereturn.setUpdateby(global.getUserinfo().getId());
			insurancereturn.setUpdatetime(now);
			//bus365保险服务器退保险
			if(ParamterConst.COMMON_FLAG.FALG_YES.equals(param2626)){
				propertyFilters.clear();
				propertyFilters.add(new PropertyFilter("EQL_t!insuranceid",insurancereturn.getInsuranceid()));
				List<Platforminsureorderdetail> pdList = dao.find(Platforminsureorderdetail.class, propertyFilters);
				if(pdList.size()==1){
					Platforminsureorderdetail detail = pdList.get(0);
					detail.setStatus(4);
					dao.merge(detail);
				}
			}
			
			//记录操作日志
			Operationlog log = new Operationlog();
			log.setIp(global.getIpAddress());
			StringBuffer content = new StringBuffer();
			content.append("车站窗口操作员").append(global.getUserinfo().getCode()).append(", ");
			content.append("return userId=").append(global.getUserinfo().getId()).append(", ");
			content.append("退网售保险insuranceno=").append(insurance.getInsuranceno()).append(", insuranceId=").append(insurance.getId()).append(", ");
			content.append("该保险原售票员id=").append(insurance.getId()).append(", ");
			content.append("该保险退保数量、金额记在网站售票员保险缴款明细下, web Insuranceturnoverdetail id=").append(insuTurnoverDetailWeb.getId());
			log.setContent(content.toString());
			log.setModule("退保->退网售保险");
			log.setOperatetime(new Date());
			log.setOperation("退保");
			log.setSessionid(global.getSessionID());
			log.setUserid(global.getUserinfo().getId());
			dao.merge(log);
		}
		
		//保存退保员缴款明细
		insuTurnoverDetailWeb = (Insuranceturnoverdetail) dao.merge(insuTurnoverDetailWeb);
		play.Logger.info(insuTurnoverDetailWeb.getId() + "--- merge after Web insuranceturnoverdetail.getReturnnum()="
				+ insuTurnoverDetailWeb.getReturnnum() + ", getReturnmoney()=" + insuTurnoverDetailWeb.getReturnmoney());
		
		//给退保记录turnoverdetailid字段赋值
		for (Insurancereturn insurancereturn : insReturnListWeb) {
			insurancereturn.setTurnoverdetailid(insuTurnoverDetailWeb.getId());
			dao.merge(insurancereturn);
		}
		// TODO 调用保险方接口
	}
	/**
	 * 将网售保险和车站窗口售保分开
	 * @param insurancereturns
	 * @return
	 */
	private Map<String, Object> splitInsuranceReturn(List<Insurancereturn> insurancereturns) throws ServiceException {
		List<Insurancereturn> insReturnListWeb = new ArrayList<Insurancereturn>();//网售保险
		List<Insurancereturn> insReturnListStation = new ArrayList<Insurancereturn>();//车站售保险
		long sellbyWeb = 0L;//网售保险售票员
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		
		for (Insurancereturn insuranceReturn : insurancereturns) {
			Insurance insurance = (Insurance) dao.get(
					LockModeType.PESSIMISTIC_READ, Insurance.class,
					insuranceReturn.getInsuranceid());
			if (insurance == null) {
				throw new ServiceException("0172");
			} else if ("1".equals(insurance.getInsurancestatus())) {
				throw new ServiceException("0173");
			} else if ("2".equals(insurance.getInsurancestatus())) {
				throw new ServiceException("0174");
			}
			
			if(insuranceReturn.getReturnfeemode() == null){
				propertyFilters.clear();
				propertyFilters.add(new PropertyFilter("EQL_t!id", insurance.getSellid()));
				List<Ticketsell> tklist = dao.find(Ticketsell.class, propertyFilters);
				if(tklist != null && tklist.size() > 0){
					insuranceReturn.setReturnfeemode(tklist.get(0).getReturnfeemode());//返款模式
					play.Logger.info(insurance.getInsuranceno() + "该保险对应车票返款模式为=" + tklist.get(0).getReturnfeemode());
				}else{
					play.Logger.info(insurance.getInsuranceno() + "该保险未找到对应车票,返款模式为空");
				}
			}
			
			if ("7".equals(insurance.getSellway()) && "1".equals(insuranceReturn.getReturnfeemode())){
				//网站售：原路返还时退票人记为网站售票员；垫付时退票人记为窗口退票员
				insReturnListWeb.add(insuranceReturn);
				if(sellbyWeb == 0){
					sellbyWeb = insurance.getSellby();
				}else if(sellbyWeb != insurance.getSellby()){
					throw new BusinessException("不可同时退两个不同网站用户售出的保险！");
				}
			}else if("10".equals(insurance.getSellway())){
				if("1".equals(insuranceReturn.getReturnfeemode())){
					insReturnListWeb.add(insuranceReturn);
					if(sellbyWeb == 0){
						sellbyWeb = insurance.getSellby();
					}else if(sellbyWeb != insurance.getSellby()){
						throw new BusinessException("不可同时退两个不同自助机用户售出的保险！");
					}
				}else{
					//垫付
					insReturnListStation.add(insuranceReturn);
				}
			}else{
				//窗口售或接口售垫付
				insReturnListStation.add(insuranceReturn);
			}
		}
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("sellbyWeb", sellbyWeb);
		resultMap.put("insReturnListWeb", insReturnListWeb);
		resultMap.put("insReturnListStation", insReturnListStation);
		return resultMap;
	}
	/**
	 * 退车站售出的保险
	 * @param global
	 * @param insReturnListStation
	 * @throws ServiceException 
	 */
	private void returnInsuranceStation(List<Insurancereturn> insReturnListStation,
			Insuranceturnoverdetail insuTurnoverDetailStation, Global global, Date now) throws ServiceException{
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		String param1180 = new ParameterServiceImpl().findParamValue("1180", global.getOrganization().getId());//窗口售票退款方式0：车站垫付，1：原路返还
		//判断是否为窗口电子保险以及退票方式
		Insurancereturn i = insReturnListStation.get(0);
		boolean isStationEpay = false;
		String paymethod = i.getPaymethod();
		if("1".equals(paymethod) || "4".equals(paymethod) || "5".equals(paymethod)
				|| "10".equals(paymethod) || "11".equals(paymethod)){
			Long id = i.getInsuranceid();
			Insurance insurance = (Insurance) dao.get(Insurance.class,id);
			if("0".equals(insurance.getSellway()) || "1".equals(insurance.getSellway()) || "2".equals(insurance.getSellway()) || "6".equals(insurance.getSellway())){
				isStationEpay = true;
			}
		}
		//修改保险为退保状态，保存退保记录，更新保险缴款明细记录
		for (Insurancereturn insurancereturn : insReturnListStation) {
			//修改保险
			propertyFilters.clear();
			Insurance insurance = (Insurance) dao.get(
					LockModeType.PESSIMISTIC_READ, Insurance.class,
					insurancereturn.getInsuranceid());
			if (insurance == null) {
				throw new ServiceException("0172");
			} else if ("1".equals(insurance.getInsurancestatus())) {
				throw new ServiceException("0173");
			} else if ("2".equals(insurance.getInsurancestatus())) {
				throw new ServiceException("0174");
			} else {
				insurance.setInsurancestatus("1");
			}
			if(isStationEpay){
				if("1".equals(param1180) && !"3".equals(insurancereturn.getReturnway())){
					insurancereturn.setReturnfeemode("1");
				}else{
					insurancereturn.setReturnfeemode("0");
				}
				insurancereturn.setReturnmethod("0");//窗口退票
			}
			insurance.setUpdatetime(now);
			dao.merge(insurance);
			play.Logger.info(global.getUserinfo().getCode() + "该用户退保险记录为：insuranceno=" 
					+ insurance.getInsuranceno() + "insuranceid=" + insurance.getId());
			
			//修改车站退保缴款明细
			play.Logger.info("--- update before Station insuranceturnoverdetail.getReturnnum()=" + insuTurnoverDetailStation.getReturnnum()
					+ ", getReturnmoney()="+insuTurnoverDetailStation.getReturnmoney());
			insuTurnoverDetailStation.setReturnnum(insuTurnoverDetailStation.getReturnnum()+1);//退保数+1
			insuTurnoverDetailStation.setMoneypayable(insuTurnoverDetailStation
					.getMoneypayable().subtract(insurancereturn.getPremium()));
			insuTurnoverDetailStation.setReturnmoney(insuTurnoverDetailStation
					.getReturnmoney().add(insurancereturn.getPremium()));
			play.Logger.info("--- update after Station insurancereturn.getPremium()="+insurancereturn.getPremium()+
					", getReturnnum()="+insuTurnoverDetailStation.getReturnnum()+
					", getReturnmoney()="+insuTurnoverDetailStation.getReturnmoney());
			// 0现金、1银联卡、2贵客卡余额、3贵客卡积分
			if ("2".equals(insurance.getPaymethod())
					|| "3".equals(insurance.getPaymethod())) {
				insuTurnoverDetailStation.setNonvouchermoneypayable(insuTurnoverDetailStation
								.getNonvouchermoneypayable().subtract(insurancereturn.getPremium()));
			}
			if(isStationEpay){
				if("1".equals(insurancereturn.getReturnfeemode())){//窗口电子票原路返还
					insuTurnoverDetailStation.setEreturnbacknum(insuTurnoverDetailStation.getEreturnbacknum()+1);
					insuTurnoverDetailStation.setEreturnbackmoney(insuTurnoverDetailStation.getEreturnbackmoney().add(insurancereturn.getPremium()));
					insuTurnoverDetailStation.setNoncashmoneypayable(insuTurnoverDetailStation.getNoncashmoneypayable().subtract(insurancereturn.getPremium()));
				}else{//窗口电子票车站垫付
					insuTurnoverDetailStation.setEreturnnum(insuTurnoverDetailStation.getEreturnnum()+1);
					insuTurnoverDetailStation.setEreturnmoney(insuTurnoverDetailStation.getEreturnmoney().add(insurancereturn.getPremium()));
				}
			}
			//保存保险退票记录
			insurancereturn.setCreateby(global.getUserinfo().getId());
			insurancereturn.setCreatetime(now);
			insurancereturn.setReturnby(global.getUserinfo().getId());
			insurancereturn.setReturnip(global.getIpAddress());
			insurancereturn.setReturntime(now);
			insurancereturn.setTicketoutletsid(global.getTicketoutlets().getId());
			insurancereturn.setUpdateby(global.getUserinfo().getId());
			insurancereturn.setUpdatetime(now);
		}
		
		//保存退保员缴款明细
		insuTurnoverDetailStation = (Insuranceturnoverdetail) dao.merge(insuTurnoverDetailStation);
		play.Logger.info("--- merge after Station insuranceturnoverdetail.getReturnnum()="+insuTurnoverDetailStation.getReturnnum()
				+ ", getReturnmoney()="+insuTurnoverDetailStation.getReturnmoney());
		
		//给退保记录turnoverdetailid字段赋值
		for (Insurancereturn insurancereturn : insReturnListStation) {
			insurancereturn.setTurnoverdetailid(insuTurnoverDetailStation.getId());
			dao.merge(insurancereturn);
		}
		
		// TODO 调用保险方接口
	}
	@Deprecated
	@Override
	public void returnInsurance(List<Insurancereturn> insurancereturns,
			Global global) throws ServiceException {
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		// 插入或修改应保险缴款表
		Date now = new Date();
		propertyFilters.clear();
		propertyFilters.add(new PropertyFilter("EQB_t!isturnover", false));
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(now);
		calendar.set(calendar.get(Calendar.YEAR), calendar.get(Calendar.MONTH),
				calendar.get(Calendar.DAY_OF_MONTH), 0, 0, 0);
		propertyFilters.add(new PropertyFilter("EQD_t!moneydate", calendar
				.getTime()));
		propertyFilters.add(new PropertyFilter("EQL_t!seller", global
				.getUserinfo().getId()));
		List<Insuranceturnoverdetail> insuranceturnoverdetails = dao.find(
				Insuranceturnoverdetail.class, propertyFilters);
		boolean neednew = true;
		Insuranceturnoverdetail insuranceturnoverdetail = null;
		if (insuranceturnoverdetails != null
				&& insuranceturnoverdetails.size() > 0) {
			insuranceturnoverdetail = insuranceturnoverdetails.get(0);
			neednew = false;
		}
		if (neednew) {
			insuranceturnoverdetail = new Insuranceturnoverdetail();
			insuranceturnoverdetail.setMoneypayable(new BigDecimal(0));
			insuranceturnoverdetail.setSellmoney(new BigDecimal(0));
			insuranceturnoverdetail.setSellnum(0);
			insuranceturnoverdetail.setUpdateby(global.getUserinfo().getId());
			insuranceturnoverdetail.setUpdatetime(now);
			insuranceturnoverdetail.setCancelnum(0);
			insuranceturnoverdetail.setCancelmoney(new BigDecimal(0));
			insuranceturnoverdetail
					.setNonvouchermoneypayable(new BigDecimal(0));
			insuranceturnoverdetail.setNoncashmoney(new BigDecimal(0));
			insuranceturnoverdetail.setNoncashnum(0);
			insuranceturnoverdetail.setCreateby(global.getUserinfo().getId());
			insuranceturnoverdetail.setCreatetime(now);
			insuranceturnoverdetail.setEticketnum(0);
			insuranceturnoverdetail.setMoneydate(now);
			insuranceturnoverdetail.setReturnhandcharge(new BigDecimal(0));
			insuranceturnoverdetail.setReturnmoney(new BigDecimal(0));
			insuranceturnoverdetail.setReturnnum(0);
			insuranceturnoverdetail.setSeller(global.getUserinfo().getId());
			insuranceturnoverdetail.setTicketturnover(null);
			insuranceturnoverdetail.setIsturnover(false);
			insuranceturnoverdetail.setTurnovertime(null);
			insuranceturnoverdetail.setTicketstartno("0");
			insuranceturnoverdetail.setTicketendno("0");
		}
		insuranceturnoverdetail.setReturnnum(insuranceturnoverdetail
				.getReturnnum() + insurancereturns.size());
		insuranceturnoverdetail.setUpdateby(global.getUserinfo().getId());
		insuranceturnoverdetail.setUpdatetime(now);

		String param2626 = parameterService.findParamValue(ParamterConst.Param_2626, global.getOrganization().getId());
		String param2627 = parameterService.findParamValue(ParamterConst.Param_2627, global.getOrganization().getId());
		// 退保险
		for (Insurancereturn insurancereturn : insurancereturns) {
			boolean isReturnfeemode =  false;
			propertyFilters.clear();
			Insurance insurance = (Insurance) dao.get(
					LockModeType.PESSIMISTIC_READ, Insurance.class,
					insurancereturn.getInsuranceid());
			if (insurance == null) {
				throw new ServiceException("0172");
			} else if ("1".equals(insurance.getInsurancestatus())) {
				throw new ServiceException("0173");
			} else if ("2".equals(insurance.getInsurancestatus())) {
				throw new ServiceException("0174");
			}else if(ParamterConst.COMMON_FLAG.FALG_YES.equals(param2626) && ParamterConst.COMMON_FLAG.FALG_YES.equals(param2627) &&
					("7".equals(insurance.getSellway()) || "10".equals(insurance.getSellway()))){
				throw new ServiceException("0517");
			}
			else {
				insurance.setInsurancestatus("1");
			}

			play.Logger.info("returnInsurance 退保险的保险票号2"+insurance.getInsuranceno()+"退保金额"+insurance.getPremium());
			play.Logger.info("insureid="+insurancereturn.getInsuranceid()+",insurancereturn.getPremium()="+insurancereturn.getPremium());
			if(insurancereturn.getPremium().compareTo(new BigDecimal(0))==0
					||insurancereturn.getPremium().toString().equals("0")){
				throw new ServiceException("退保金额为0不允许退保","800");
			}
			//非原路返还的保险才操作保险缴款明细中应缴款、退保款等相关金额字段（减掉保险金额）
			if(!"1".equals(insurancereturn.getReturnfeemode())){
				insuranceturnoverdetail.setMoneypayable(insuranceturnoverdetail
						.getMoneypayable().subtract(insurancereturn.getPremium()));
				insuranceturnoverdetail.setReturnmoney(insuranceturnoverdetail
						.getReturnmoney().add(insurancereturn.getPremium()));
				// 0现金、1银联卡、2贵客卡余额、3贵客卡积分
				if ("2".equals(insurance.getPaymethod())
						|| "3".equals(insurance.getPaymethod())) {
					insuranceturnoverdetail
					.setNonvouchermoneypayable(insuranceturnoverdetail
							.getNonvouchermoneypayable().subtract(
									insurancereturn.getPremium()));
				}
			}
			dao.merge(insurance);
//			
//			Ticketsell ts = (Ticketsell) dao.get(Ticketsell.class,insurance.getSellid());
//			// 原因 :退联网票时 应该是Ticketsellagent表  是车站垫付  增加非空判断
//			if(ts != null){
//				if(ts.getReturnfeemode().equals("1")&&ts.getOrgid()==insurance.getOrgid()){
//					isReturnfeemode = true;
//					//若是原路返回，并且售票机构跟售保机构为同一机构，则不需要修改营收
//						play.Logger.info("原路返还保单号："+insurance.getInsuranceno());
//				}
//			}
//			if(!isReturnfeemode){
//				insuranceturnoverdetail.setMoneypayable(insuranceturnoverdetail
//						.getMoneypayable().subtract(insurancereturn.getPremium()));
//					insuranceturnoverdetail.setReturnmoney(insuranceturnoverdetail
//							.getReturnmoney().add(insurancereturn.getPremium()));		
//			}

			insurancereturn.setCreateby(global.getUserinfo().getId());
			insurancereturn.setCreatetime(now);
			insurancereturn.setReturnby(global.getUserinfo().getId());
			insurancereturn.setReturnip(global.getIpAddress());
			insurancereturn.setReturntime(now);
			insurancereturn.setTicketoutletsid(global.getTicketoutlets()
					.getId());
			insurancereturn.setUpdateby(global.getUserinfo().getId());
			insurancereturn.setUpdatetime(now);
			//bus365保险服务器退保险
			if(ParamterConst.COMMON_FLAG.FALG_YES.equals(param2626)){
				propertyFilters.clear();
				propertyFilters.add(new PropertyFilter("EQL_t!insuranceid",insurancereturn.getInsuranceid()));
				List<Platforminsureorderdetail> pdList = dao.find(Platforminsureorderdetail.class, propertyFilters);
				if(pdList.size()==1){
					Platforminsureorderdetail detail = pdList.get(0);
					detail.setStatus(4);
					dao.merge(detail);
				}
			}
		}
		insuranceturnoverdetail = (Insuranceturnoverdetail) dao
				.merge(insuranceturnoverdetail);
		for (Insurancereturn insurancereturn : insurancereturns) {
			insurancereturn
					.setTurnoverdetailid(insuranceturnoverdetail.getId());
			dao.merge(insurancereturn);
		}
		// TODO 调用保险方接口
	}
	/**
	 * 获取当前售票员的保险营收缴款明细记录
	 * @param global
	 * @return
	 */
	private Insuranceturnoverdetail getCurInsuTurnoverDetailStation(Global global, Date now){
		Insuranceturnoverdetail insuTurnoverDetailStation = null;
		
		//从数据库查询当前用户的保险营收缴款明细记录
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		propertyFilters.clear();
		propertyFilters.add(new PropertyFilter("EQB_t!isturnover", false));
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(now);
		calendar.set(calendar.get(Calendar.YEAR), calendar.get(Calendar.MONTH),
				calendar.get(Calendar.DAY_OF_MONTH), 0, 0, 0);
		propertyFilters.add(new PropertyFilter("EQD_t!moneydate", calendar.getTime()));
		propertyFilters.add(new PropertyFilter("EQL_t!seller", global.getUserinfo().getId()));
		List<Insuranceturnoverdetail> insuTurnoverDetailList = dao.find(LockModeType.PESSIMISTIC_READ,
				Insuranceturnoverdetail.class, propertyFilters);
		
		if (insuTurnoverDetailList != null && insuTurnoverDetailList.size() > 0) {
			insuTurnoverDetailStation = insuTurnoverDetailList.get(0);
		}else{
			insuTurnoverDetailStation = new Insuranceturnoverdetail();
			insuTurnoverDetailStation.setMoneypayable(new BigDecimal(0));
			insuTurnoverDetailStation.setSellmoney(new BigDecimal(0));
			insuTurnoverDetailStation.setSellnum(0);
			insuTurnoverDetailStation.setUpdateby(global.getUserinfo().getId());
			insuTurnoverDetailStation.setUpdatetime(now);
			insuTurnoverDetailStation.setCancelnum(0);
			insuTurnoverDetailStation.setCancelmoney(new BigDecimal(0));
			insuTurnoverDetailStation.setNonvouchermoneypayable(new BigDecimal(0));
			insuTurnoverDetailStation.setNoncashmoney(new BigDecimal(0));
			insuTurnoverDetailStation.setNoncashnum(0);
			insuTurnoverDetailStation.setCreateby(global.getUserinfo().getId());
			insuTurnoverDetailStation.setCreatetime(now);
			insuTurnoverDetailStation.setEticketnum(0);
			insuTurnoverDetailStation.setMoneydate(now);
			insuTurnoverDetailStation.setReturnhandcharge(new BigDecimal(0));
			insuTurnoverDetailStation.setReturnmoney(new BigDecimal(0));
			insuTurnoverDetailStation.setReturnnum(0);
			insuTurnoverDetailStation.setSeller(global.getUserinfo().getId());
			insuTurnoverDetailStation.setTicketturnover(null);
			insuTurnoverDetailStation.setIsturnover(false);
			insuTurnoverDetailStation.setTurnovertime(null);
			insuTurnoverDetailStation.setTicketstartno("0");
			insuTurnoverDetailStation.setTicketendno("0");
			insuTurnoverDetailStation.setEreturnbackmoney(new BigDecimal(0));
			insuTurnoverDetailStation.setEreturnbacknum(0);
			insuTurnoverDetailStation.setEreturnmoney(new BigDecimal(0));
			insuTurnoverDetailStation.setEreturnnum(0);
			insuTurnoverDetailStation.setNoncashmoneypayable(BigDecimal.ZERO);
			insuTurnoverDetailStation.setMoney(BigDecimal.ZERO);
			insuTurnoverDetailStation.setLost(BigDecimal.ZERO);
			insuTurnoverDetailStation.setEreturncharge(BigDecimal.ZERO);
		}
		insuTurnoverDetailStation.setUpdateby(global.getUserinfo().getId());
		insuTurnoverDetailStation.setUpdatetime(now);
		
		return insuTurnoverDetailStation;
	}
}
