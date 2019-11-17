package cn.nova.bus.pay.service.impl;

import java.util.ArrayList;
import java.util.List;

import cn.nova.bus.archive.model.Customer;
import cn.nova.bus.base.model.District;
import cn.nova.bus.base.model.Station;
import cn.nova.bus.common.ParamterConst;
import cn.nova.bus.pay.dao.PubEPayServiceDao;
import cn.nova.bus.pay.model.Paystationway;
import cn.nova.bus.pay.param.BusParamEPaymentInfo;
import cn.nova.bus.pay.param.BusRider;
import cn.nova.bus.pay.param.BusScheduleInfo;
import cn.nova.bus.pay.param.ParamScheduleRiderIn;
import cn.nova.bus.pay.param.ReachInfo;
import cn.nova.bus.pay.param.StartInfo;
import cn.nova.bus.pay.service.TicketEPayOnLineUnionService;
import cn.nova.bus.pay.service.TicketEpayFlyingpigCMBCService;
import cn.nova.bus.security.Global;
import cn.nova.bus.system.dao.DigitaldictionarydetailDao;
import cn.nova.bus.system.model.Digitaldictionarydetail;
import cn.nova.utils.commons.MethodResult;
import util.CommonUtil;
import util.DateUtils;
import util.JsonUtil;

public class TicketCommEPayServiceImpl {
	private PubEPayServiceDao pubdao = new PubEPayServiceDao();

	/**
	 * 支付服务器公共支付方法
	 * 
	 * @param paraminfo
	 * @return
	 */
	public MethodResult ePaymentComm(BusParamEPaymentInfo paraminfo) {
		play.Logger.info("电子支付请求参数 : BusParamEPaymentInfo " + JsonUtil.toSimpleString(paraminfo));
		MethodResult result = new MethodResult();
		try {
			if (null == paraminfo) {
				play.Logger.error("电子支付paraminfo参数为空!参数不合法!");
				result.setResult(MethodResult.FAILURE);
				result.setResultMsg("参数不合法!");
				return result;
			}
			// 获得当前支付版本的版本号
			Paystationway paystationway = pubdao.getPaystationway();
			if (null == paystationway) {
				result.setResult(MethodResult.FAILURE);
				result.setResultMsg("Paystationway配置不合法!Paystationway记录为0 或者正在使用的为多条!");
				return result;
			}
			// 要兼容线上支付宝/线上银联支付 即最开始的线上电子支付(版本定为1.0)
			if (ParamterConst.VERSION_FLAG.FALG_ONE.equals(paystationway.getVersion())) {
				TicketEPayOnLineUnionService service = new TicketEPayOnLineUnionServiceImpl();
				return service.ePaymentVersionOne(paraminfo);
			}
			// 新版的线上支付服务器的(定为2.0)
			if (ParamterConst.VERSION_FLAG.FALG_TWO.equals(paystationway.getVersion())) {
				play.Logger.info("电子支付请求service.ePaymentVersionTwo(paraminfo)");
				TicketEpayFlyingpigCMBCService service = new TicketEpayFlyingpigCMBCImpl();
				return service.ePaymentVersionTwo(paraminfo);

			}

			// if(ParamterConst.VERSION_FLAG.FALG_THR.equals(paystationway.getVersion())){
			// 预留
			// }

			else {
				result.setResult(MethodResult.FAILURE);
				result.setResultMsg("Paystationway 未找到对应版本的支付方式");
				return result;
			}
		} catch (Exception e) {
			result.setResult(MethodResult.FAILURE);
			result.setResultMsg("支付异常," + e.getMessage());
			play.Logger.error("支付异常," + e.getMessage(), e);
		}
		return result;
	}
	/**
	 * 公司支付服务器统一退款接口
	 * 
	 * @param paraminfo
	 * @return
	 */
	public MethodResult ePayReturnComm(BusParamEPaymentInfo paraminfo) {
		play.Logger.info("电子支付退款请求参数 : BusParamEPaymentInfo " + JsonUtil.toSimpleString(paraminfo));
		MethodResult result = new MethodResult();
		try {
			if (null == paraminfo) {
				play.Logger.error("电子支付退款参数为空!参数不合法!");
				result.setResult(MethodResult.FAILURE);
				result.setResultMsg("参数不合法!");
				return result;
			}
			// 获得当前支付版本的版本号
			Paystationway paystationway = pubdao.getPaystationway();
			if (null == paystationway) {
				result.setResult(MethodResult.FAILURE);
				result.setResultMsg("Paystationway配置不合法!Paystationway记录为0 或者正在使用的为多条!");
				return result;
			}
			// 要兼容线上支付宝/线上银联支付 即最开始的线上电子支付(版本定为1.0)
			if (ParamterConst.VERSION_FLAG.FALG_ONE.equals(paystationway.getVersion())) {
				TicketEPayOnLineUnionService service = new TicketEPayOnLineUnionServiceImpl();
				return service.ePayReturnVersionOne(paraminfo);
			}
			// 新版的线上支付服务器的(定为2.0)
			if (ParamterConst.VERSION_FLAG.FALG_TWO.equals(paystationway.getVersion())) {
				TicketEpayFlyingpigCMBCService service = new TicketEpayFlyingpigCMBCImpl();
				return service.ePayReturnVersionOneTwo(paraminfo);

			}

			// if(ParamterConst.VERSION_FLAG.FALG_THR.equals(paystationway.getVersion())){
			// 预留
			// }

			else {
				result.setResult(MethodResult.FAILURE);
				result.setResultMsg("Paystationway 未找到对应版本的支付方式");
				return result;
			}
		} catch (Exception e) {
			result.setResult(MethodResult.FAILURE);
			result.setResultMsg("commEpayReturn 退款异常," + e.getMessage());
			play.Logger.error("commEpayReturn 退款异常," + e.getMessage(), e);
		}
		return result;

	}

	public MethodResult ePaySpecialReturnComm(BusParamEPaymentInfo paraminfo) {
		play.Logger.info("电子支付退款请求参数 : BusParamEPaymentInfo " + JsonUtil.toSimpleString(paraminfo));
		MethodResult result = new MethodResult();
		try {
			if (null == paraminfo) {
				play.Logger.error("电子支付退款参数为空!参数不合法!");
				result.setResult(MethodResult.FAILURE);
				result.setResultMsg("参数不合法!");
				return result;
			}
			// 获得当前支付版本的版本号
			Paystationway paystationway = pubdao.getPaystationway();
			if (null == paystationway) {
				result.setResult(MethodResult.FAILURE);
				result.setResultMsg("Paystationway配置不合法!Paystationway记录为0 或者正在使用的为多条!");
				return result;
			}
			// 要兼容线上支付宝/线上银联支付 即最开始的线上电子支付(版本定为1.0)
			if (ParamterConst.VERSION_FLAG.FALG_ONE.equals(paystationway.getVersion())) {
				TicketEPayOnLineUnionService service = new TicketEPayOnLineUnionServiceImpl();
				return service.ePaySpecialReturnVersionOne(paraminfo);
			}
			// 新版的线上支付服务器的(定为2.0)
			if (ParamterConst.VERSION_FLAG.FALG_TWO.equals(paystationway.getVersion())) {
				TicketEpayFlyingpigCMBCService service = new TicketEpayFlyingpigCMBCImpl();
				return service.ePaySpecialReturnVersionOneTwo(paraminfo);

			}

			// if(ParamterConst.VERSION_FLAG.FALG_THR.equals(paystationway.getVersion())){
			// 预留
			// }

			else {
				result.setResult(MethodResult.FAILURE);
				result.setResultMsg("Paystationway 未找到对应版本的支付方式");
				return result;
			}
		} catch (Exception e) {
			result.setResult(MethodResult.FAILURE);
			result.setResultMsg("commEpayReturn 退款异常," + e.getMessage());
			play.Logger.error("commEpayReturn 退款异常," + e.getMessage(), e);
		}
		return result;

	}

	/**
	 * 支付需要的参数 将班次信息 ,乘客信息 global 等分别赋值给 paraminfo 以作为支付参数
	 * 
	 * @param paraminfo
	 * @param scheduleriders
	 * @param global
	 * @return
	 */
	public BusParamEPaymentInfo converterParam(BusParamEPaymentInfo paraminfo,
			List<ParamScheduleRiderIn> scheduleriders, Global global) {
		DigitaldictionarydetailDao dictionaryDao = new DigitaldictionarydetailDao();
		paraminfo.setPayuserby(global.getUserinfo().getId());
		paraminfo.setPayipby(global.getIpAddress());
		paraminfo.setGlobal(global);
		paraminfo.setOrgid(global.getOrganization().getId());
		paraminfo.setOrgname(global.getOrganization().getName());
		// 如果是支付宝
		if (ParamterConst.COMMON_FLAG.FALG_YES.equals(paraminfo.getGateway())) {
			List<BusRider> riders = new ArrayList<BusRider>();
			List<BusScheduleInfo> busscheduleinfos = new ArrayList<BusScheduleInfo>();
			// 将参数赋值给支付参数类
			for (ParamScheduleRiderIn paramScheduleRiderIn : scheduleriders) {
				BusRider rider = new BusRider();
				rider.setFullprice(paramScheduleRiderIn.getFullprice());// 全价票
				rider.setHaschildren(paramScheduleRiderIn.getHaschildren());// 是否携带儿童
				if (null != paramScheduleRiderIn.getCustomerid() && paramScheduleRiderIn.getCustomerid() > 1) {// 证件信息
					Customer c = (Customer) pubdao.get(Customer.class,
							paramScheduleRiderIn.getCustomerid().longValue());
					rider.setRidercertnumber(c.getCertificateno());
					Digitaldictionarydetail certificatetype = dictionaryDao.qryDigitaldictionarydetail("customer",
							"certificatetype", c.getCertificatetype());
					rider.setRidercerttype(certificatetype.getValue());
					rider.setRidername(c.getName());
				}
				// 座位号
				rider.setSeatnumber(paramScheduleRiderIn.getSeatnumber());
				// 服务费
				rider.setServicecharge(paramScheduleRiderIn.getServicecharge());
				// 单站票价 因为校验所有的单张之和要等于总价 所以要加上保险
				rider.setTicketprice(paramScheduleRiderIn.getTicketprice().add(paramScheduleRiderIn.getPremium()));
				riders.add(rider);
				// 班次信息
				BusScheduleInfo scheduleinfo = new BusScheduleInfo();
				String departtime = (DateUtils.formatDate(paramScheduleRiderIn.getDepartdate()) + " "
						+ paramScheduleRiderIn.getDeptime() + ":00");
				// 发车时间
				scheduleinfo.setDeptime(departtime);
				// 距离
				scheduleinfo.setDistance(paramScheduleRiderIn.getDistance());
				// 到达站
				Station reachstation = (Station) pubdao.get(Station.class, paramScheduleRiderIn.getTostationid());
				// 到达站区域
				District reachstationdistrict = (District) pubdao.get(District.class, reachstation.getDistrictid());
				// 发车站
				Station deaprtstation = (Station) pubdao.get(Station.class, paramScheduleRiderIn.getStartstationid());
				// 发车站区域
				District deaprtstationdistrict = (District) pubdao.get(District.class, deaprtstation.getDistrictid());
				if (null != reachstationdistrict) {
					scheduleinfo.setTostationprovincename(reachstationdistrict.getName());
				}
				if (null != deaprtstationdistrict) {
					scheduleinfo.setStartcityname(deaprtstationdistrict.getName());
				}
				// 发车站名称
				scheduleinfo.setStartstationname(deaprtstation.getName());
				//暂时取车站 有问题及时修改
				scheduleinfo.setLastplacename(reachstation.getName());
				scheduleinfo.setTostationname(reachstation.getName());
				scheduleinfo.setScheduleplanid(paramScheduleRiderIn.getScheduleplanid());
				// 班次号
				scheduleinfo.setBusnumber(paramScheduleRiderIn.getBusnumber());
				
				StartInfo startinfo = pubdao.getstartstationinfo(deaprtstation.getId());
				if(startinfo != null){
					if(CommonUtil.isNotEmptyString(startinfo.cityname)){
						scheduleinfo.setStartcityname(startinfo.cityname);
					}
					if(CommonUtil.isNotEmptyString(startinfo.provincename)){
						scheduleinfo.setStartprovincename(startinfo.provincename);
					}
					if(CommonUtil.isNotEmptyString(startinfo.stationname)){
						scheduleinfo.setStartstationname(startinfo.stationname);
					}
				}
				ReachInfo reachinfo = pubdao.getreachstationinfo(reachstation.getId());
				if(reachinfo != null ){
					if(CommonUtil.isNotEmptyString(reachinfo.cityname)){
						scheduleinfo.setTostationcityname(reachinfo.cityname);
					}
					if(CommonUtil.isNotEmptyString(reachinfo.provincename)){
						scheduleinfo.setTostationprovincename(reachinfo.provincename);
					}
					if(CommonUtil.isNotEmptyString(reachinfo.stationname)){
						scheduleinfo.setTostationname(reachinfo.stationname);
					}
				}
				busscheduleinfos.add(scheduleinfo);
			}
			paraminfo.setRider(riders);
			paraminfo.setScinfo(busscheduleinfos);
		}
		return paraminfo;
	}
	public MethodResult queryPayresult(BusParamEPaymentInfo paraminfo) throws Exception {
		TicketEpayFlyingpigCMBCService service = new TicketEpayFlyingpigCMBCImpl();
		return service.queryPayresult(paraminfo);
	}
	
	public void  savepayorder(String orderno,String mess) {
		TicketEpayFlyingpigCMBCService service = new TicketEpayFlyingpigCMBCImpl();
		service.savepayorder(orderno,mess);
	}
	

}
