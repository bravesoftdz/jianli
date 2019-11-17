package cn.nova.bus.pay.service.impl;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import cn.nova.bus.common.ParamterConst;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.insure.model.Insurance;
import cn.nova.bus.pay.model.Flypigorder;
import cn.nova.bus.pay.model.Payordermessage;
import cn.nova.bus.pay.param.BusParamEPaymentInfo;
import cn.nova.bus.pay.param.BusRider;
import cn.nova.bus.pay.param.BusScheduleInfo;
import cn.nova.bus.pay.param.TvmBusLineInfo;
import cn.nova.bus.pay.param.TvmCreateOrderRq;
import cn.nova.bus.pay.param.TvmPassengerVo;
import cn.nova.bus.pay.service.TicketEpayFlyingpigCMBCService;
import cn.nova.bus.sale.dao.PayInfoDao;
import cn.nova.bus.sale.model.Gateway;
import cn.nova.bus.sale.model.Payinfo;
import cn.nova.bus.sale.model.Payinfodetail;
import cn.nova.bus.sale.model.Ticketsell;
import cn.nova.bus.security.Global;
import cn.nova.bus.system.model.Userinfo;
import cn.nova.bus.system.service.ParameterService;
import cn.nova.bus.system.service.impl.ParameterServiceImpl;
import cn.nova.utils.commons.MethodResult;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.IDAO;
import play.db.jpa.JPA;
import util.AppConstant;
import util.DateUtils;
import util.EpayUrlApi;
import util.JsonUtil;
import util.RedisUtil;
import util.RedisUtil.RedisDBApp;
import util.RpcUtil;
import util.SecretClientUtil;
import utils.bus365.StringUtils;


public class TicketEpayFlyingpigCMBCImpl implements TicketEpayFlyingpigCMBCService {
	private static final String payBusinessId = AppConstant.getValue("pay.payBusinessId");
	private static final String payPrivateKey = AppConstant.getValue("pay.payPrivateKey");
	private static final String md5Key = AppConstant.getValue("pay.md5Key");
	private static final String payUrl = AppConstant.getValue("pay.payUrl");
	private static final String gatewayid = AppConstant.getValue("pay.gatewayid");
	private static final String gateway2Webchatid = AppConstant.getValue("pay.gateway2Webchatid");
	private IDAO dao = new EntityManagerDaoSurport();
	private ParameterService parameterService = new ParameterServiceImpl();
	private Map<String, Object> resultMap = new HashMap<String, Object>();
	private Map<String, String> param = new HashMap<String, String>();
	private Map<String, Object> dataMap = new HashMap<String, Object>();
	private String data = "";
	private String result = "";
	private String msg = "";
	private boolean isSavePayInfo = false;
	private String resultData = "";
	private String resultMd5 = "";
	private String paynum = "";
	private String message = "";
	private String topayinfoid = "";
	
	/**
	 * 2.0的支付飞猪+招商
	 */
	@Override
	public MethodResult ePaymentVersionTwo(BusParamEPaymentInfo paraminfo) {
		// 流程微信 获取订单号接口 ----> 支付接口
		// 支付宝 获取订单号接口 ---->调用飞猪接口----> 支付接口 ----> 飞猪出票接口(JOB刷)
		MethodResult result = new MethodResult();
		// 校验参数
		play.Logger.info("电子支付请求service.ePaymentVersionTwo(paraminfo) 校验参数");
		result = verificationPayBusParamEPaymentInfo(paraminfo);
		if (result.getResult() != MethodResult.SUCCESS) {
			return result;
		}
		play.Logger.info("电子支付请求service.ePaymentVersionTwo(paraminfo) 获取订单");
		// 获取订单
		String payorderno = getplateOrderno(paraminfo.getOrderno());
		// 得到支付订单号
		if (StringUtils.isNotEmptyString(payorderno)) {
			paraminfo.setPayorderno(payorderno);
		} else {
			result.setResultMsg("获取支付平台订单交易号出错");
			result.setResult(MethodResult.FAILURE);
			return result;
		}
		// 飞猪支付接口(实际是将票的信息发送给飞猪) 只有调用成功了 才能支付
		if (ParamterConst.COMMON_FLAG.FALG_YES.equals(paraminfo.getGateway())) {
			result = sendTickets2FlyPig(paraminfo);
		}
		if (result.getResult() != MethodResult.SUCCESS) {
			return result;
		}
		// 支付
		result = epayFlyingpigCMBC(paraminfo);
		// 返回
		return result;
	}

	/**
	 * 2.0的支付飞猪+招商 支付的参数校验
	 * 
	 * @param paraminfo
	 * @return
	 */
	private MethodResult verificationPayBusParamEPaymentInfo(BusParamEPaymentInfo paraminfo) {
		MethodResult result = new MethodResult();
		result.setResult(MethodResult.SUCCESS);
		if (!StringUtils.isNotEmptyString(paraminfo.getOrderno())) {
			result.setResult(MethodResult.FAILURE);
			result.setResultMsg("参数校验失败!订单号为空!");
		}
		if (!StringUtils.isNotEmptyString(paraminfo.getPayCode())) {
			result.setResult(MethodResult.FAILURE);
			result.setResultMsg("参数校验失败!支付码为空!");
		}
		if (!StringUtils.isNotEmptyString(paraminfo.getGateway())) {
			result.setResult(MethodResult.FAILURE);
			result.setResultMsg("参数校验失败!支付途径为空!");
		}
		if (!StringUtils.isNotEmptyString(paraminfo.getPaymethod())) {
			result.setResult(MethodResult.FAILURE);
			result.setResultMsg("参数校验失败!支付方式为空!");
		}
		if (paraminfo.getTotalprice().compareTo(BigDecimal.ZERO) <= 0) {
			result.setResult(MethodResult.FAILURE);
			result.setResultMsg("参数校验失败!支付金额小于0!");
		}
		// 说明是支付宝
		if (ParamterConst.COMMON_FLAG.FALG_YES.equals(paraminfo.getGateway())) {
			// 校验飞猪需要的 参数
			if (null == paraminfo.getScinfo()) {
				result.setResult(MethodResult.FAILURE);
				result.setResultMsg("参数校验失败!班次信息为空!");
			}
			if (null == paraminfo.getRider()) {
				result.setResult(MethodResult.FAILURE);
				result.setResultMsg("参数校验失败!乘客信息为空!");
			}
			if (paraminfo.getRider().size() == 0) {
				result.setResult(MethodResult.FAILURE);
				result.setResultMsg("参数校验失败!乘客信息为空!");
			}
		}
		return result;
	}

	/**
	 * 2.0的支付飞猪+招商 支付服务器 获取支付订单号
	 * 
	 * @param orderno
	 * @return
	 */
	private String getplateOrderno(String orderno) {
		String msg = "";
		Map<String, String> param = new HashMap<String, String>();
		param.put("orderno", orderno);
		String data = cn.nova.openapi.util.JsonUtil.parseObject(param);
		Map<String, String> params = null;
		try {
			params = SecretClientUtil.encryptData(payPrivateKey, md5Key, data);
			params.put("paybusinessid", payBusinessId);
			String result = RpcUtil.httpPostByLink(EpayUrlApi.allUrl(payUrl, EpayUrlApi.EPAY_GET_PAYORDERNO), params,
					"UTF-8");
			play.Logger.info("支付服务器申请平台订单号接口/payorderno返回数据" + result);
			Map<String, Object> resultMap = cn.nova.openapi.util.JsonUtil.paseJson2Map(result);
			String resultData = resultMap.get("data").toString();
			String resultMd5 = resultMap.get("md5").toString();
			// 解密返回结果
			SecretClientUtil secretClientUtil = new SecretClientUtil();
			boolean success = secretClientUtil.decryptData(payPrivateKey, md5Key, resultData, resultMd5);
			if (success) {
				Map<String, Object> dataMap = secretClientUtil.getData();
				msg = (String) dataMap.get("payorderno");
			}
		} catch (Exception e) {
			play.Logger.error("2.0的支付飞猪+招商 支付服务器 获取支付订单号,请重新刷码！" + e.getMessage(), e);
		}
		return msg;
	}
	public static boolean isIDNumber(String IDNumber) {
        if (IDNumber == null || "".equals(IDNumber)) {
            return false;
        }
        // 定义判别用户身份证号的正则表达式（15位或者18位，最后一位可以为字母）
        String regularExpression = "(^[1-9]\\d{5}(18|19|20)\\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\\d{3}[0-9Xx]$)|" +
                "(^[1-9]\\d{5}\\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\\d{3}$)";
        //假设18位身份证号码:41000119910101123X  410001 19910101 123X
        //^开头
        //[1-9] 第一位1-9中的一个      4
        //\\d{5} 五位数字           10001（前六位省市县地区）
        //(18|19|20)                19（现阶段可能取值范围18xx-20xx年）
        //\\d{2}                    91（年份）
        //((0[1-9])|(10|11|12))     01（月份）
        //(([0-2][1-9])|10|20|30|31)01（日期）
        //\\d{3} 三位数字            123（第十七位奇数代表男，偶数代表女）
        //[0-9Xx] 0123456789Xx其中的一个 X（第十八位为校验值）
        //$结尾

        //假设15位身份证号码:410001910101123  410001 910101 123
        //^开头
        //[1-9] 第一位1-9中的一个      4
        //\\d{5} 五位数字           10001（前六位省市县地区）
        //\\d{2}                    91（年份）
        //((0[1-9])|(10|11|12))     01（月份）
        //(([0-2][1-9])|10|20|30|31)01（日期）
        //\\d{3} 三位数字            123（第十五位奇数代表男，偶数代表女），15位身份证不含X
        //$结尾

        boolean matches = IDNumber.matches(regularExpression);
        //判断第18位校验值
        if (matches) {
            if (IDNumber.length() == 18) {
                try {
                    char[] charArray = IDNumber.toCharArray();
                    //前十七位加权因子
                    int[] idCardWi = {7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2};
                    //这是除以11后，可能产生的11位余数对应的验证码
                    String[] idCardY = {"1", "0", "X", "9", "8", "7", "6", "5", "4", "3", "2"};
                    int sum = 0;
                    for (int i = 0; i < idCardWi.length; i++) {
                        int current = Integer.parseInt(String.valueOf(charArray[i]));
                        int count = current * idCardWi[i];
                        sum += count;
                    }
                    char idCardLast = charArray[17];
                    int idCardMod = sum % 11;
                    if (idCardY[idCardMod].toUpperCase().equals(String.valueOf(idCardLast).toUpperCase())) {
                        return true;
                    } else {
                        play.Logger.error("身份证最后一位:" + String.valueOf(idCardLast).toUpperCase() + 
                                "错误,正确的应该是:" + idCardY[idCardMod].toUpperCase());
                        return false;
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    play.Logger.error("异常:" + IDNumber,e);
                    return false;
                }
            }

        }
        return matches;
    }
	/**
	 * 2.0的支付飞猪+招商 飞猪支付接口(实际是将票的信息发送给飞猪) 只有调用成功了 才能支付
	 * 
	 * @param paraminfo
	 * @return
	 */
	private MethodResult sendTickets2FlyPig(BusParamEPaymentInfo paraminfo) {
		MethodResult methodResult = new MethodResult();
		Date now = new Date();
		try {
			Userinfo seller = (Userinfo) dao.get(Userinfo.class, paraminfo.getPayuserby());
			long scheduleplanid = 0;
			BusScheduleInfo busscinfo = null;
			for (BusScheduleInfo busscheduleinfo : paraminfo.getScinfo()) {
				if (scheduleplanid == 0) {
					scheduleplanid = busscheduleinfo.getScheduleplanid();
				}
				if (scheduleplanid != busscheduleinfo.getScheduleplanid()) {
					methodResult.setResult(MethodResult.FAILURE);
					methodResult.setResultMsg("购物车购票暂不支持支付宝支付!");
					return methodResult;
				}
				busscinfo = busscheduleinfo;
			}
			// 班次信息 只传必填项
			TvmBusLineInfo businfo = new TvmBusLineInfo();
			if(busscinfo == null){
				methodResult.setResult(MethodResult.FAILURE);
				methodResult.setResultMsg("班次信息为空,不能支付!");
				return methodResult;
			}
			if(paraminfo.getRider().size()>20) {
				methodResult.setResult(MethodResult.FAILURE);
				methodResult.setResultMsg("支付宝支付暂不支持20人以上的电子支付!");
				return methodResult;
			}
			businfo.setDep_time(busscinfo.getDeptime());
			businfo.setDistance(busscinfo.getDistance());
			businfo.setLast_place_name(busscinfo.getLastplacename());
			
			businfo.setStart_city_name(busscinfo.getStartcityname());
			businfo.setStart_province_name(busscinfo.getStartprovincename());
			businfo.setStart_station_name(busscinfo.getStartstationname());
			
			businfo.setTo_station_city_name(busscinfo.getTostationcityname());
			businfo.setTo_station_name(busscinfo.getTostationname());
			businfo.setTo_station_province_name(busscinfo.getTostationprovincename());
			
			businfo.setBus_number(busscinfo.getBusnumber());
			
			List<TvmPassengerVo> passengers = new ArrayList<TvmPassengerVo>();
			// 请求参数
			TvmCreateOrderRq order = new TvmCreateOrderRq();
			boolean real_name=false;
			// 乘车人信息
			for (BusRider busRider : paraminfo.getRider()) {
				real_name=false;
				// 只传必填项
				TvmPassengerVo passenger = new TvmPassengerVo();
				passenger.setHas_children(busRider.getHaschildren());
				passenger.setRider_cert_number(busRider.getRidercertnumber());
				passenger.setRider_cert_type(busRider.getRidercerttype());
				passenger.setRider_name(busRider.getRidername());
				passenger.setSeat_number(busRider.getSeatnumber());
				passenger.setService_charge((busRider.getServicecharge().multiply(new BigDecimal("100"))).intValue());
				passenger.setFull_price((busRider.getFullprice().multiply(new BigDecimal("100"))).intValue());
				passenger.setTicket_price((busRider.getTicketprice().multiply(new BigDecimal("100"))).intValue());
				if(isIDNumber(busRider.getRidercertnumber())){
					//只有证件类型的是身份证的才传值 '01'
					passenger.setRider_cert_type("01");
					real_name=true;
				}else{
					//因为目前该接口只支持身份证所以 不是身份证的都赋值给空
					passenger.setRider_cert_number("");
					passenger.setRider_cert_type("");
					passenger.setRider_name("");
				}
				passengers.add(passenger);
			}
			order.setPassengers(passengers);
			order.setTvm_bus_line_info(businfo);
			order.setMachine_number(seller.getCode());
			order.setTrade_source("window");
			order.setTicket_count(paraminfo.getRider().size());
			order.setTotal_price((paraminfo.getTotalprice().multiply(new BigDecimal("100"))).intValue());
			order.setReal_name(real_name);
			HashMap<String, Object> dataMap = new HashMap<String, Object>();
			dataMap.put("param_t_v_m_create_order_r_q", JsonUtil.parseObject(order));
			dataMap.put("orderno", paraminfo.getOrderno());
			dataMap.put("payorderno", paraminfo.getPayorderno());
			data = JsonUtil.parseObject(dataMap);
			param = SecretClientUtil.encryptData(payPrivateKey, md5Key, data);
			param.put("paybusinessid", payBusinessId);
			play.Logger.info(" 2.0的支付飞猪+招商 飞猪创建订单接口/three/createorder请求数据: " + dataMap);
			String result = RpcUtil.httpPostByLink(EpayUrlApi.allUrl(payUrl, EpayUrlApi.EPAY_THREE_CREATEORDER), param,
					"UTF-8");
			play.Logger.info(" 2.0的支付飞猪+招商 飞猪创建订单接口/three/createorder返回数据: " + result);
			resultMap = cn.nova.openapi.util.JsonUtil.paseJson2Map(result);
			resultData = resultMap.get("data").toString();
			resultMd5 = resultMap.get("md5").toString();
			SecretClientUtil secretClient = new SecretClientUtil();
			if (!secretClient.decryptData(payPrivateKey, md5Key, resultData, resultMd5)) {
				play.Logger.info(" 2.0的支付飞猪+招商 飞猪创建订单接口失败->order: " + paraminfo.getOrderno() + " 解密失败");
				methodResult.setResult(MethodResult.FAILURE);
				methodResult.setResultMsg("飞猪创建订单接口失败->order: " + paraminfo.getOrderno() + " 解密失败");
			} else {
				play.Logger.info("飞猪创建订单->order: " + paraminfo.getOrderno() + " 解密成功");
				Map<String, Object> dataMapTemp = secretClient.getData();
				Boolean success = (Boolean) dataMapTemp.get("success");
				if (success) {
					// 记录飞猪订单表
					Flypigorder flypigorder = new Flypigorder();
					flypigorder.setOrderno(paraminfo.getOrderno());
					flypigorder.setStatus("0");
					flypigorder.setMessage("飞猪创建订单成功!");
					flypigorder.setCreatetime(now);
					flypigorder.setUpdatetime(now);
					flypigorder.setCreateby(paraminfo.getPayuserby());
					flypigorder.setUpdateby(paraminfo.getPayuserby());
					dao.merge(flypigorder);
					dao.getEntityManager().flush();
					methodResult.setResult(MethodResult.SUCCESS);
				} else {
					methodResult.setResult(MethodResult.FAILURE);
					methodResult.setResultMsg("飞猪创建订单接口失败");
				}
			}
		} catch (Exception e) {
			play.Logger.error(" 2.0的支付飞猪+招商 飞猪支付接口  order: " + paraminfo.getOrderno() + " 飞猪创建订单接口异常!" + e.getMessage(),
					e);
			methodResult.setResult(MethodResult.FAILURE);
			methodResult.setResultMsg("order: " + paraminfo.getOrderno() + " 飞猪创建订单接口异常!" + e.getMessage());
			e.printStackTrace();
		}
		return methodResult;
	}

	/**
	 * 2.0的支付飞猪+招商 调用公司支付服务器
	 * 
	 * @param paraminfo
	 * @return
	 */
	private MethodResult epayFlyingpigCMBC(BusParamEPaymentInfo paraminfo) {
		MethodResult methodResult = new MethodResult();
		Date currentTime = new Date();
		if (ParamterConst.COMMON_FLAG.FALG_YES.equals(paraminfo.getGateway())) {
			topayinfoid = gatewayid;
		} else {
			topayinfoid = gateway2Webchatid;
		}
		// 优先存储payInfo
		Payinfo payInfo = new Payinfo(paraminfo.getOrderno(), paraminfo.getPayorderno(),
				paraminfo.getTotalprice().doubleValue(), Integer.valueOf(topayinfoid), 0, currentTime,
				paraminfo.getPayuserby(), true, true, "bus365", "0", paraminfo.getPayipby(),
				BigDecimal.valueOf(paraminfo.getTickets()), paraminfo.getTicketprice(),
				BigDecimal.valueOf(paraminfo.getInsures()), paraminfo.getInsurefee(), paraminfo.getPayorderno());
		if (ParamterConst.COMMON_FLAG.FALG_YES.equals(paraminfo.getGateway())) {
			payInfo.setPaymethod("4");
		} else {
			payInfo.setPaymethod("5");
		}
		Payinfo p = (Payinfo) dao.merge(payInfo);
		JPA.em().getTransaction().commit();
		JPA.em().getTransaction().begin();
		SecretClientUtil secretClientUtil = new SecretClientUtil();
		try {
			param.put("orderno", paraminfo.getOrderno());
			param.put("payorderno", paraminfo.getPayorderno());
			param.put("totalprice", paraminfo.getTotalprice().toString());
			// 支付宝
			if (ParamterConst.COMMON_FLAG.FALG_YES.equals(paraminfo.getGateway())) {
				param.put("topayinfoid", topayinfoid);
				param.put("aliPayCode", paraminfo.getPayCode());
			} else {// 微信
				param.put("topayinfoid", topayinfoid);
				param.put("wxPayCode", paraminfo.getPayCode());
			}
			param.put("expiretime", "3000");
			// 封装Data
			data = JsonUtil.parseObject(param);
			// 调用支付接口
			param.clear();
			param = SecretClientUtil.encryptData(payPrivateKey, md5Key, data);
			param.put("paybusinessid", payBusinessId);
			play.Logger.info("2.0的支付飞猪+招商  支付服务器支付接口/pays/createpayparam1请求数据" + data);
			result = RpcUtil.httpPostByLink(EpayUrlApi.allUrl(payUrl, EpayUrlApi.EPAY_PAYMONEY), param, "UTF-8");
			play.Logger.info("2.0的支付飞猪+招商  支付服务器支付接口/pays/createpayparam1返回数据" + result);
			resultMap = cn.nova.openapi.util.JsonUtil.paseJson2Map(result);
			// 解密返回结果
			play.Logger.info("2.0的支付飞猪+招商" + paraminfo.getOrderno() + "解密返回结果后开始解密");
			resultData = resultMap.get("data").toString();
			resultMd5 = resultMap.get("md5").toString();
			boolean success = secretClientUtil.decryptData(payPrivateKey, md5Key, resultData, resultMd5);
			if (success) {// 解密成功
				play.Logger.info("2.0的支付飞猪+招商" + paraminfo.getOrderno() + "解密成功");
				Map<String, Object> dataMap = secretClientUtil.getData();
				message = (String) dataMap.get("message");
				paynum = (String) dataMap.get("paynum");
				if ("支付成功".equals(message)) {
					isSavePayInfo = true;
				} else {
					// 查询订单信息，60秒内，请求3次，超过时间认为支付失败
					msg = paraminfo.getOrderno() + "支付订单失败，进行查询调用……";
					play.Logger.info(msg);
					play.Logger.info("2.0的支付飞猪+招商  支付服务器支付接口Thread.sleep(1000)" + result);
					Thread.sleep(1000);
					play.Logger.info("2.0的支付飞猪+招商  支付服务器支付接口Thread.sleep(1000)" + result);
					payRequery(secretClientUtil, paraminfo.getOrderno(), paraminfo.getPayorderno(), topayinfoid,
							paraminfo.getOrgid());
				}
			} else {
				msg = paraminfo.getOrderno() + "支付订单解密失败，进行查询调用……";
				play.Logger.info(msg);
				// 查询订单信息，60秒内，请求3次，超过时间认为支付失败
				payRequery(secretClientUtil, paraminfo.getOrderno(), paraminfo.getPayorderno(), topayinfoid,
						paraminfo.getOrgid());
			}
			if (isSavePayInfo) {// 支付成功，保存支付信息
				// 从缓存中获取支付网关信息
				Gateway gateWay = this.getGateWay(topayinfoid);
				if (gateWay != null) {
					p.setPaytradename(gateWay.getPaytradename());
					p.setPaytradenameval(gateWay.getPaytradenameval());
				}
				p.setSellorgname(paraminfo.getOrgname());
				p.setPaymethod(paraminfo.getPaymethod());
				p.setPayno(paynum);
				p.setPaystatus(1);
				p.setPaymessage(message);
				p.setOrderstatus("1");
				p.setUpdatetime(new Date());
				p.setInsurancestatus("0");
				dao.merge(p);
				msg = "";// 订单支付成功必须返回为空
				JPA.em().getTransaction().commit();
			}
		} catch (Exception e) {
			try {
				msg = paraminfo.getOrderno() + "支付订单异常，进行查询调用……";
				play.Logger.info(msg);
				payRequery(secretClientUtil, paraminfo.getOrderno(), paraminfo.getPayorderno(), topayinfoid,
						paraminfo.getOrgid());
				if (isSavePayInfo) {// 支付成功，保存支付信息
					// 从缓存中获取支付网关信息
					Gateway gateWay = this.getGateWay(topayinfoid);
					if (gateWay != null) {
						p.setPaytradename(gateWay.getPaytradename());
						p.setPaytradenameval(gateWay.getPaytradenameval());
					}
					p.setSellorgname(paraminfo.getOrgname());
					p.setPaymethod(paraminfo.getPaymethod());
					p.setPayno(paynum);
					p.setPaystatus(1);
					p.setPaymessage(message);
					p.setOrderstatus("1");
					p.setUpdatetime(new Date());
					p.setInsurancestatus("0");
					dao.merge(p);
					msg = "";// 订单支付成功必须返回为空
					JPA.em().getTransaction().commit();
					msg = "";// 订单支付成功必须返回为空
					play.Logger.info("2.0的支付飞猪+招商" + paraminfo.getOrderno() + "订单支付成功-------------------------");
				}
			} catch (Exception ex) {
				play.Logger.error("支付出错，请重新扫码！" + ex.getMessage(), ex);
				msg = "支付异常，请重新扫码。如用户支付成功，请去特殊退款菜单退款！";
			}
		}
		methodResult.setResultMsg(msg);
		methodResult.setResult(isSavePayInfo ? methodResult.SUCCESS : methodResult.FAILURE);
		return methodResult;
	}

	/**
	 * 2.0的支付飞猪+招商 查询支付结果
	 * 
	 * @param secretClientUtil
	 * @param orderNo
	 * @param plateOrderNo
	 * @param topayid
	 * @param orgid
	 */
	public void payRequery(SecretClientUtil secretClientUtil, String orderNo, String plateOrderNo, String topayid,
			long orgid) {
		try {
			play.Logger.info("调用订单查询接口，查询订单:" + orderNo);
			// 电子支付等待时间
			Integer waitSec = 120;
			try {
				waitSec = Integer.valueOf(parameterService.findParamValue(ParamterConst.Param_1092, orgid));
			} catch (Exception e) {
				waitSec = 120;
				play.Logger.error("1092参数值不是一个整数" + e.getMessage());
			}
			if (waitSec > 120) {
				waitSec = 120;
			}
			// 查询订单信息，60秒内，请求3次，超过时间认为支付失败
			for (int i = 0; i < (waitSec / 2); i++) {
				play.Logger.info("第" + i + "次查询订单:" + orderNo);
				param.clear();
				param.put("orderno", orderNo);
				param.put("payorderno", plateOrderNo);
				param.put("topayid", topayid);
				data = cn.nova.openapi.util.JsonUtil.parseObject(param);
				param = SecretClientUtil.encryptData(payPrivateKey, md5Key, data);
				param.put("paybusinessid", payBusinessId);
				result = RpcUtil.httpPostByLink(EpayUrlApi.allUrl(payUrl, EpayUrlApi.EPAY_QUERYPAYRESULT), param,
						"UTF-8");
				play.Logger.info("支付服务器查询订单接口/pays/queryPayResult返回数据" + result);
				resultMap.clear();
				resultMap = cn.nova.openapi.util.JsonUtil.paseJson2Map(result);
				resultData = resultMap.get("data").toString();
				resultMd5 = resultMap.get("md5").toString();
				boolean orderQuerySuccess = secretClientUtil.decryptData(payPrivateKey, md5Key, resultData, resultMd5);
				if (orderQuerySuccess) {
					dataMap = secretClientUtil.getData();
					int status = (Integer) dataMap.get("status");
					paynum = (String) dataMap.get("paynum");
					message = (String) dataMap.get("message");
					play.Logger.info(orderNo + "message:" + message);
					if (status == 1) {
						isSavePayInfo = true;
						break;
					} else {
						Thread.sleep(2000);
					}
				} else {
					msg = "订单查询解密失败！";
					play.Logger.info(orderNo + msg);
				}
			}
			if (!isSavePayInfo) {
				msg = "支付不成功，请重新扫码！";
				play.Logger.info(orderNo + msg);
			} else {
				msg = "支付成功！";
				play.Logger.info(orderNo + msg);
			}
		} catch (Exception e) {
			play.Logger.error("payRequery 支付出错，请重新扫码！" + e.getMessage(), e);
			msg = "支付异常，请重新扫码。如用户支付成功，请去特殊退款菜单退款！";
		}
	}

	// 获取网关名称
	public Gateway getGateWay(String gateId) {
		List<String> gateList = RedisUtil.getList(RedisDBApp.global, "app_gateway");
		for (String json : gateList) {
			if (StringUtils.isNotEmptyString(json)) {
				Gateway gateway = JsonUtil.parseObject(json, Gateway.class);
				if (gateway != null && gateway.getId().equals(gateId)) {
					return gateway;
				}
			}
		}
		Gateway gateway = (Gateway) dao.get(Gateway.class, gateId);
		if (gateway != null) {
			RedisUtil.rPush(RedisDBApp.global, "app_gateway", JsonUtil.toSimpleString(gateway));
		}
		return gateway;
	}

	/**
	 * 2.0的支付飞猪+招商 调用公司支付服务器 特殊订单退款
	 */
	@Override
	public MethodResult ePaySpecialReturnVersionOneTwo(BusParamEPaymentInfo paraminfo) {
		MethodResult methodresult = new MethodResult();
		try {
			// 按订单号查询payinfo信息
			List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
			propertyFilters.add(new PropertyFilter("EQS_t!orderno", paraminfo.getOrderno()));
			Payinfo payInfo = (Payinfo) dao.uniqueResult(Payinfo.class, propertyFilters);
			if (null != payInfo) {
				// 如果是飞猪(支付宝支付)
				if (ParamterConst.COMMON_FLAG.FALG_FOU.equals(payInfo.getPaymethod())) {
					paraminfo.setGateway("1");
				} else {
					paraminfo.setGateway("2");
				}

				if (ParamterConst.COMMON_FLAG.FALG_YES.equals(paraminfo.getGateway())) {
					paraminfo.setBookticketsuccess(false);
					if (dao.countTotalRows(Ticketsell.class, propertyFilters, "id") > 0) {
						paraminfo.setBookticketsuccess(true);
					}
					if (dao.countTotalRows(Insurance.class, propertyFilters, "id") > 0) {
						paraminfo.setBookticketsuccess(true);
					}
					paraminfo.setPayorderno(payInfo.getPayorderno());
					// 通知出票成功或者出票失败
					bookticketresult(paraminfo);
					// 查询出票结果接口
					methodresult = queryBookticketresult(paraminfo);
					if (methodresult.getResult() != MethodResult.SUCCESS) {
						return methodresult;
					} else {
						if ((Boolean) methodresult.getObject()) {// 出票成功
							// 微信退款和飞猪出票成功退款
							methodresult = returnSpecialFlyingpigCMBC(paraminfo);
							return methodresult;
						} else {// 出票失败 飞猪自己退 站务修改记录
							changepayinfo(payInfo, paraminfo.getGlobal(), paraminfo.getIds(), paraminfo.getInsurefee(),
									BigDecimal.valueOf(paraminfo.getInsures()), paraminfo.getTicketprice(),
									BigDecimal.valueOf(paraminfo.getTickets()));
							methodresult.setResult(MethodResult.SUCCESS);
							methodresult.setResultMsg("退款成功!");
							return methodresult;
						}
					}
				} else {
					// 微信退款和飞猪出票成功退款
					methodresult = returnSpecialFlyingpigCMBC(paraminfo);
					return methodresult;
				}
			} else {
				methodresult.setResult(MethodResult.FAILURE);
				methodresult.setResultMsg("根据订单号没有找到对应的支付订单信息!");
				return methodresult;
			}
		} catch (Exception e) {
			methodresult.setResult(MethodResult.FAILURE);
			methodresult.setResultMsg("退款失败!" + e.getMessage());
			play.Logger.error("2.0的支付飞猪+招商  调用公司支付服务器 特殊订单退款 退款失败,订单号:"+ paraminfo.getOrderno() + e.getMessage(), e);
			e.printStackTrace();
		}
		return methodresult;
	}

	/**
	 * 2.0的支付飞猪+招商 调用公司支付服务器 退款 主方法
	 */
	@Override
	public MethodResult ePayReturnVersionOneTwo(BusParamEPaymentInfo paraminfo) {
		MethodResult methodresult = new MethodResult();
		try {
			// 校验退票参数
			methodresult = verificationReturnBusParamEPaymentInfo(paraminfo);
			// 参数不合格 直接返回
			if (methodresult.getResult() != MethodResult.SUCCESS) {
				return methodresult;
			}
			// 按订单号查询payinfo信息
			List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
			propertyFilters.add(new PropertyFilter("EQS_t!orderno", paraminfo.getOrderno()));
			Payinfo payInfo = (Payinfo) dao.uniqueResult(Payinfo.class, propertyFilters);
			if (null != payInfo) {
				// 如果是飞猪(支付宝支付)
				if (ParamterConst.COMMON_FLAG.FALG_FOU.equals(payInfo.getPaymethod())) {
					paraminfo.setGateway(ParamterConst.COMMON_FLAG.FALG_ONE);
				} else {
					paraminfo.setGateway(ParamterConst.COMMON_FLAG.FALG_TWO);
				}
				if (ParamterConst.COMMON_FLAG.FALG_ONE.equals(paraminfo.getGateway())) {
					paraminfo.setPayorderno(payInfo.getPayorderno());
					// 通知出票成功或者出票失败
					bookticketresult(paraminfo);
					// 查询出票结果接口
					methodresult = queryBookticketresult(paraminfo);
					if (methodresult.getResult() != MethodResult.SUCCESS) {
						return methodresult;
					} else {
						if ((Boolean) methodresult.getObject()) {// 出票成功
							// 微信退款和飞猪出票成功退款
							methodresult = returnFlyingpigCMBC(paraminfo);
							return methodresult;
						} else {// 出票失败 飞猪自己退 站务修改记录
							addpayinfo(paraminfo, payInfo);
							methodresult.setResult(MethodResult.SUCCESS);
							methodresult.setResultMsg("退款成功!");
							return methodresult;
						}
					}
				} else {
					methodresult = returnFlyingpigCMBC(paraminfo);
					return methodresult;
				}
			} else {
				methodresult.setResult(MethodResult.FAILURE);
				methodresult.setResultMsg("根据订单号没有找到对应的支付订单信息!");
				return methodresult;
			}
		} catch (Exception e) {
			methodresult.setResult(MethodResult.FAILURE);
			methodresult.setResultMsg("退款失败!" + e.getMessage());
			play.Logger.error("2.0的支付飞猪+招商  调用公司支付服务器 退款 主方法 退款失败,订单号:"+ paraminfo.getOrderno()+ e.getMessage(), e);
			e.printStackTrace();
		}
		return methodresult;
	}

	/**
	 * 2.0的支付飞猪+招商 调用公司支付服务器 特殊退款
	 * 
	 * @param paraminfo
	 * @return
	 */
	private MethodResult returnSpecialFlyingpigCMBC(BusParamEPaymentInfo paraminfo) {
		MethodResult methodresult = new MethodResult();
		Payinfo payInfo = (Payinfo) dao.get(Payinfo.class, paraminfo.getPayinfoid());
		String ids = paraminfo.getIds();
		Global global = paraminfo.getGlobal();
		// 开始退票
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("orderno", payInfo.getOrderno());
		param.put("payorderno", payInfo.getPayorderno() != null ? payInfo.getPayorderno() : "");
		param.put("payno", payInfo.getPayno() != null ? payInfo.getPayno() : "");
		param.put("gatewayid", payInfo.getGatewayid() != null ? payInfo.getGatewayid() : 0);
		param.put("batchno", DateUtils.getPayBatchno(null));
		boolean isreturnmoney = payInfo.getIsreturnmoney() == null ? false : payInfo.getIsreturnmoney();
		if (isreturnmoney) {
			param.put("refundmoney", payInfo.getRefundmoney() != null ? payInfo.getRefundmoney() : "0");
		} else {
			param.put("refundmoney", payInfo.getTotalprice() != null ? payInfo.getTotalprice() : "0");
		}
//		param.put("refundmoney", 0.01);
		param.put("fullprice", payInfo.getTotalprice() != null ? payInfo.getTotalprice() : "0");
		String data = cn.nova.openapi.util.JsonUtil.parseObject(param);
		Map<String, String> params = null;
		try {
			params = SecretClientUtil.encryptData(payPrivateKey, md5Key, data);
			params.put("paybusinessid", payBusinessId);
			String result = RpcUtil.httpPostByLink(payUrl + "/refundMoney/1", params, "UTF-8");
			play.Logger.info("支付服务器查询退票接口/refundMoney/1返回数据" + result);
			Map<String, Object> resultMap = cn.nova.openapi.util.JsonUtil.paseJson2Map(result);
			String resultData = resultMap.get("data").toString();
			String resultMd5 = resultMap.get("md5").toString();

			// 解密返回结果
			SecretClientUtil secretClientUtil = new SecretClientUtil();
			boolean success = secretClientUtil.decryptData(payPrivateKey, md5Key, resultData, resultMd5);// 返回Map集合
			if (success) {
				Map<String, Object> dataMap = secretClientUtil.getData();
				String msg = (String) dataMap.get("message");
				String status = (String) dataMap.get("status");
				if ("1111".equals(status)) {
					// 修改payinfo 和 明细表
					changepayinfo(payInfo, global, ids, paraminfo.getInsurefee(),
							BigDecimal.valueOf(paraminfo.getInsures()), paraminfo.getTicketprice(),
							BigDecimal.valueOf(paraminfo.getTickets()));
					methodresult.setResult(MethodResult.SUCCESS);
					methodresult.setResultMsg("退款成功!");
				} else {
					methodresult.setResult(MethodResult.FAILURE);
					methodresult.setResultMsg("退款失败!");
					play.Logger.error("2.0的支付飞猪+招商  调用公司支付服务器 特殊退款 支付服务器返回失败!订单号:"+ paraminfo.getOrderno() + msg);
				}
			}
		} catch (Exception e) {
			methodresult.setResult(MethodResult.FAILURE);
			methodresult.setResultMsg("退款失败!" + e.getMessage());
			play.Logger.error("2.0的支付飞猪+招商  调用公司支付服务器 特殊退款 退款失败,订单号:"+ paraminfo.getOrderno()+ e.getMessage(), e);
		}
		return methodresult;
	}

	/**
	 * 2.0的支付飞猪+招商 调用公司支付服务器 退款
	 * 
	 * @param paraminfo
	 * @return
	 */
	private MethodResult returnFlyingpigCMBC(BusParamEPaymentInfo paraminfo) {
		MethodResult methodresult = new MethodResult();
		try {
			String orderno = paraminfo.getOrderno();
			Global global = paraminfo.getGlobal();
			Date current = new Date();
			List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
			propertyFilters.add(new PropertyFilter("EQS_t!orderno", orderno));
			Payinfo payInfo = (Payinfo) dao.uniqueResult(Payinfo.class, propertyFilters);
			// 开始退票
			Map<String, Object> param = new HashMap<String, Object>();
			param.put("orderno", payInfo.getOrderno());
			param.put("payorderno", payInfo.getPayorderno() != null ? payInfo.getPayorderno() : "");
			param.put("payno", payInfo.getPayno() != null ? payInfo.getPayno() : "");
			param.put("gatewayid", payInfo.getGatewayid() != null ? payInfo.getGatewayid() : 0);
			param.put("batchno", DateUtils.getPayBatchno(null));
			param.put("refundmoney", paraminfo.getRefundmoney());
//			param.put("refundmoney", 0.01);
			param.put("fullprice", payInfo.getTotalprice() != null ? payInfo.getTotalprice() : "0");
			String data = cn.nova.openapi.util.JsonUtil.parseObject(param);
			Map<String, String> params = null;
			params = SecretClientUtil.encryptData(payPrivateKey, md5Key, data);
			params.put("paybusinessid", payBusinessId);
			String result = RpcUtil.httpPostByLink(EpayUrlApi.allUrl(payUrl, EpayUrlApi.EPAY_REFUNDMONEY), params,
					"UTF-8");
			play.Logger.info("支付服务器接口/refundMoney/1返回数据" + result);
			Map<String, Object> resultMap = cn.nova.openapi.util.JsonUtil.paseJson2Map(result);
			String resultData = resultMap.get("data").toString();
			String resultMd5 = resultMap.get("md5").toString();

			// 解密返回结果
			SecretClientUtil secretClientUtil = new SecretClientUtil();
			boolean success = secretClientUtil.decryptData(payPrivateKey, md5Key, resultData, resultMd5);// 返回Map集合
			if (success) {
				Map<String, Object> dataMap = secretClientUtil.getData();
				String msg = (String) dataMap.get("message");
				String status = (String) dataMap.get("status");
				if ("1111".equals(status)) {// 退款成功
					payInfo.setReturnstatus("1");
					payInfo.setUpdateby(global.getUserinfo().getId());
					payInfo.setUpdatetime(current);
					if (payInfo.getReturnmoneytotal() != null) {
						payInfo.setReturnmoneytotal(
								payInfo.getReturnmoneytotal() + paraminfo.getRefundmoney().doubleValue());
					} else {
						payInfo.setReturnmoneytotal(paraminfo.getRefundmoney().doubleValue());
					}
					if (payInfo.getTotalprice().equals(payInfo.getReturnmoneytotal())) {
						payInfo.setPaystatus(3);
					}
//					payInfo.setRefundmoney(0D);
//					payInfo.setIsreturnmoney(false);
					payInfo.setReturnmessage(msg);
					dao.merge(payInfo);
					// 退款详情表增加记录
					Payinfodetail pd = new Payinfodetail();
					pd.setIp(global.getIpAddress());
					pd.setPayinfoid(payInfo.getId());
					pd.setReturnby(global.getUserinfo().getId());
					pd.setReturnstatus("1");// 退款成功
					pd.setReturnprice(paraminfo.getRefundmoney().doubleValue());
					pd.setReturntime(current);
					pd.setCreateby(global.getUserinfo().getId());
					pd.setCreatetime(current);
					pd.setTickets(new BigDecimal(paraminfo.getTickets()));
					pd.setTicketprice(paraminfo.getTicketprice());
					pd.setInsures(new BigDecimal(paraminfo.getInsures()));
					pd.setInsurefee(paraminfo.getInsurefee());
					dao.merge(pd);
					methodresult.setResult(MethodResult.SUCCESS);
				} else {
					methodresult.setResult(MethodResult.FAILURE);
					methodresult.setResultMsg("退款失败!");
					play.Logger.error(" 2.0的支付飞猪+招商  调用公司支付服务器 退款 退款支付服务器返回失败! 订单号:"+ paraminfo.getOrderno() + msg);
				}
			} else {
				methodresult.setResult(MethodResult.FAILURE);
				methodresult.setResultMsg("退款解密失败!");
				play.Logger.error(" 2.0的支付飞猪+招商  调用公司支付服务器 退款 退款解密失败!订单号:"+ paraminfo.getOrderno());
			}
		} catch (Exception e) {
			methodresult.setResult(MethodResult.FAILURE);
			methodresult.setResultMsg("退款失败!" + e.getMessage());
			play.Logger.error(" 2.0的支付飞猪+招商  调用公司支付服务器 退款 退款失败,订单号:"+ paraminfo.getOrderno() + e.getMessage(), e);
		}
		return methodresult;
	}

	// 校验退款参数	
	private MethodResult verificationReturnBusParamEPaymentInfo(BusParamEPaymentInfo paraminfo) {
		MethodResult result = new MethodResult();
		result.setResult(MethodResult.SUCCESS);
		if (!StringUtils.isNotEmptyString(paraminfo.getOrderno())) {
			result.setResult(MethodResult.FAILURE);
			result.setResultMsg("参数校验失败!订单号为空!");
		}
		if (paraminfo.getRefundmoney().compareTo(BigDecimal.ZERO) <= 0) {
			result.setResult(MethodResult.FAILURE);
			result.setResultMsg("参数校验失败!支付金额小于0!");
		}
		return result;
	}

	//
	/**
	 * 2.0的支付飞猪+招商 调用飞猪出票结果通知接口
	 */
	@Override
	public void bookticketresult(BusParamEPaymentInfo paraminfo) {
		Date currtime = new Date();
		// 封装请求参数
		try {
			HashMap<String, Object> dataMap = new HashMap<String, Object>();
			dataMap.put("orderno", paraminfo.getOrderno());
			dataMap.put("payorderno", paraminfo.getPayorderno());
			dataMap.put("book_time", DateUtils.formatDatetime(currtime));
			dataMap.put("success", paraminfo.isBookticketsuccess());
			dataMap.put("paytype", "alipay");
			String data = JsonUtil.parseObject(dataMap);
			Map<String, String> params = null;
			params = SecretClientUtil.encryptData(payPrivateKey, md5Key, data);
			params.put("paybusinessid", payBusinessId);
			String result = RpcUtil.httpPostByLink(EpayUrlApi.allUrl(payUrl, EpayUrlApi.EPAY_THREE_BOOKORDER), params,
					"UTF-8");
			Map<String, Object> resultMap = cn.nova.openapi.util.JsonUtil.paseJson2Map(result);
			String resultDataTemp = resultMap.get("data").toString();
			String resultMd5Temp = resultMap.get("md5").toString();
			SecretClientUtil secretClient = new SecretClientUtil();
			boolean decrytSuccess = secretClient.decryptData(payPrivateKey, md5Key, resultDataTemp, resultMd5Temp);
			if (!decrytSuccess) {
				play.Logger.info("2.0的支付飞猪+招商 调用飞猪出票结果通知接口 飞猪出票->order: " + paraminfo.getOrderno() + " 解密失败");
			} else {
				play.Logger.info(" 2.0的支付飞猪+招商 调用飞猪出票结果通知接口 飞猪出票->order: " + paraminfo.getOrderno() + " 解密成功");
				Map<String, Object> dataMapTemp = secretClient.getData();
				Boolean isOkay = (Boolean) dataMapTemp.get("success");
				play.Logger.info("2.0的支付飞猪+招商 调用飞猪出票结果通知接口 通知出票接口调用结果 :" + isOkay);
			}
		} catch (Exception e) {
			play.Logger.error("2.0的支付飞猪+招商 调用飞猪出票结果通知接口 飞猪出票结果通知失败  order: " + paraminfo.getOrderno() + e.getMessage(),
					e);
			e.printStackTrace();
		}
	}

	// 查询调用飞猪出票结果通知接口结果
	/**
	 * 2.0的支付飞猪+招商 查询出票通知结果接口
	 */
	@Override
	public MethodResult queryBookticketresult(BusParamEPaymentInfo paraminfo) {
		MethodResult methodresult = new MethodResult();
		try {
			HashMap<String, Object> dataMap = new HashMap<String, Object>();
			dataMap.put("orderno", paraminfo.getOrderno());
			dataMap.put("payorderno", paraminfo.getPayorderno());
			String data = JsonUtil.parseObject(dataMap);
			Map<String, String> params = null;
			params = SecretClientUtil.encryptData(payPrivateKey, md5Key, data);
			params.put("paybusinessid", payBusinessId);
			String result = RpcUtil.httpPostByLink(EpayUrlApi.allUrl(payUrl, EpayUrlApi.EPAY_QUERY_BOOKORDERRESULT),
					params, "UTF-8");
			play.Logger.info(" 查询出票通知结果接口 飞猪出票结果查询接口/three/isbookticket返回数据: " + result);
			Map<String, Object> resultMap = cn.nova.openapi.util.JsonUtil.paseJson2Map(result);
			String resultDataTemp = resultMap.get("data").toString();
			String resultMd5Temp = resultMap.get("md5").toString();
			SecretClientUtil secretClient = new SecretClientUtil();
			boolean decrytSuccess = secretClient.decryptData(payPrivateKey, md5Key, resultDataTemp, resultMd5Temp);
			if (!decrytSuccess) {
				methodresult.setResult(MethodResult.FAILURE);
				methodresult.setResultMsg(" 查询出票通知结果接口 飞猪出票结果查询接口->order: " + paraminfo.getOrderno() + " 解密失败");
				play.Logger.info(" 查询出票通知结果接口 飞猪出票结果查询接口->order: " + paraminfo.getOrderno() + " 解密失败");
			} else {
				play.Logger.info(" 查询出票通知结果接口 飞猪出票结果查询接口->order: " + paraminfo.getOrderno() + " 解密成功");
				Map<String, Object> dataMapTemp = secretClient.getData();
				Integer status = (Integer) dataMapTemp.get("status");
				String message = (String) dataMapTemp.get("message");
				play.Logger.info(" 查询出票通知结果接口 飞猪出票结果查询接口  order: " + paraminfo.getOrderno() + status);
				play.Logger.info(" 查询出票通知结果接口 飞猪出票结果查询接口  order: " + paraminfo.getOrderno() + message);
				// 只有 出票成功或者出票失败才算成功
				/**
				 * -1 该订单支付成功，但是调用出票接口时，传入的是出票失败（success为false） 50 该订单出票成功了 60
				 * 该订单支付成功，处于待出票的状态 70 该订单没有支付（不存在出票的情况） 80
				 * 没有找到该订单（通过传入的订单号，支付订单号没有找到飞猪的订单信息） 90 调用飞猪查询接口返回为空，或异常
				 */
				Flypigorder flypigorder = null;
				params.clear();
				params.put("orderno", paraminfo.getOrderno());
				flypigorder = (Flypigorder) dao.uniqueResult(Flypigorder.class, params);
				flypigorder.setUpdatetime(new Date());
				if (-1 == status) {
					methodresult.setResult(MethodResult.SUCCESS);
					methodresult.setObject(false);
					methodresult.setResultMsg(message);
					if (null != flypigorder) {
						flypigorder.setStatus("1");
						flypigorder.setMessage(message);
						dao.merge(flypigorder);
					}

				} else if (50 == status) {
					methodresult.setResultMsg(message);
					methodresult.setObject(true);
					methodresult.setResult(MethodResult.SUCCESS);
					if (null != flypigorder) {
						flypigorder.setStatus("2");
						flypigorder.setMessage(message);
						dao.merge(flypigorder);
					}
				} else {
					methodresult.setResult(MethodResult.FAILURE);
					methodresult.setResultMsg(message);
					if (null != flypigorder) {
						flypigorder.setMessage(message);
						dao.merge(flypigorder);
					}
				}
				dao.getEntityManager().flush();
			}
		} catch (Exception e) {
			methodresult.setResult(MethodResult.FAILURE);
			methodresult.setResultMsg("飞猪出票结果查询接口  order: " + paraminfo.getOrderno() + e.getMessage());
			play.Logger.error(" 查询出票通知结果接口 飞猪出票结果查询接口  order: " + paraminfo.getOrderno() + e.getMessage(), e);
			e.printStackTrace();
		}
		return methodresult;
	}

	public void changepayinfo(Payinfo payInfo, Global global, String ids, BigDecimal insuancefee, BigDecimal insus,
			BigDecimal ticketprices, BigDecimal tickets) {
		Date current = new Date();
		PayInfoDao payInfoDao = new PayInfoDao();
		boolean isreturnmoney = payInfo.getIsreturnmoney() == null ? false : payInfo.getIsreturnmoney();
		// 退款成功
		payInfo.setReturnstatus("1");
		payInfo.setUpdateby(global.getUserinfo().getId());
		payInfo.setUpdatetime(current);
		if (isreturnmoney) {
			if (payInfo.getReturnmoneytotal() != null) {
				payInfo.setReturnmoneytotal(payInfo.getReturnmoneytotal() + payInfo.getRefundmoney());
			} else {
				payInfo.setReturnmoneytotal(payInfo.getRefundmoney());
			}
			payInfo.setRefundmoney(0D);
			payInfo.setIsreturnmoney(false);
			if (payInfo.getTotalprice().equals(payInfo.getReturnmoneytotal())) {
				payInfo.setPaystatus(3);
			}
		} else {
			payInfo.setReturnmoneytotal(payInfo.getTotalprice());
			payInfo.setPaystatus(3);
		}
		payInfo.setReturnmessage(msg);
		dao.merge(payInfo);
		message = "退款成功！";
		Date currentTime = new Date();
		if ((!"".equals(ids)) || isreturnmoney) {// 说明是退票成功但退款失败
			List<Payinfodetail> listPayinfodetail = payInfoDao.findPayinfodetails(ids);
			for (Payinfodetail pd : listPayinfodetail) {
				pd.setIp(global.getIpAddress());
				pd.setReturnby(global.getUserinfo().getId());
				pd.setReturnstatus("1");// 退款成功
//				pd.setReturnprice(payInfo.getRefundmoney());
				pd.setReturntime(currentTime);
				dao.merge(pd);
			}
		} else {// 售票时 付款成功 出票失败 理论上现在这种情况没有了
				// 退款详情表增加记录
			Payinfodetail pd = new Payinfodetail();
			pd.setIp(global.getIpAddress());
			pd.setPayinfoid(payInfo.getId());
			pd.setReturnby(global.getUserinfo().getId());
			pd.setReturnstatus("1");// 退款成功
			pd.setReturnprice(payInfo.getRefundmoney() != null ? payInfo.getRefundmoney() : 0);
			pd.setReturntime(currentTime);
			pd.setCreateby(global.getUserinfo().getId());
			pd.setCreatetime(currentTime);
			pd.setInsurefee(insuancefee);
			pd.setInsures(insus);
			pd.setTicketprice(ticketprices);
			pd.setTickets(tickets);
			dao.merge(pd);
		}
		dao.getEntityManager().flush();
	}

	public void addpayinfo(BusParamEPaymentInfo paraminfo, Payinfo payInfo) {
		Global global = paraminfo.getGlobal();
		Date current = new Date();
		payInfo.setReturnstatus("1");
		payInfo.setUpdateby(global.getUserinfo().getId());
		payInfo.setUpdatetime(current);
		if (payInfo.getReturnmoneytotal() != null) {
			payInfo.setReturnmoneytotal(payInfo.getReturnmoneytotal() + paraminfo.getRefundmoney().doubleValue());
		} else {
			payInfo.setReturnmoneytotal(paraminfo.getRefundmoney().doubleValue());
		}
		if (payInfo.getTotalprice().equals(payInfo.getReturnmoneytotal())) {
			payInfo.setPaystatus(3);
		}
		payInfo.setRefundmoney(0D);
		payInfo.setIsreturnmoney(false);
		payInfo.setReturnmessage(msg);
		dao.merge(payInfo);
		// 退款详情表增加记录
		Payinfodetail pd = new Payinfodetail();
		pd.setIp(global.getIpAddress());
		pd.setPayinfoid(payInfo.getId());
		pd.setReturnby(global.getUserinfo().getId());
		pd.setReturnstatus("1");// 退款成功
		pd.setReturnprice(paraminfo.getRefundmoney().doubleValue());
		pd.setReturntime(current);
		pd.setCreateby(global.getUserinfo().getId());
		pd.setCreatetime(current);
		pd.setTickets(new BigDecimal(paraminfo.getTickets()));
		pd.setTicketprice(paraminfo.getTicketprice());
		pd.setInsures(new BigDecimal(paraminfo.getInsures()));
		pd.setInsurefee(paraminfo.getInsurefee());
		dao.merge(pd);
		dao.getEntityManager().flush();
	}
	@Override
	public MethodResult queryPayresult(BusParamEPaymentInfo paraminfo) throws Exception {
		MethodResult methodResult = new MethodResult();
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		propertyFilters.add(new PropertyFilter("EQS_t!orderno", paraminfo.getOrderno()));
		propertyFilters.add(new PropertyFilter("EQB_t!isbus365pay", true));
		Payinfo p = (Payinfo) dao.uniqueResult(Payinfo.class, propertyFilters);
		if (null != p) {
			if (p.getPaystatus() == 1) {
				methodResult.setResult(MethodResult.SUCCESS);
				methodResult.setResultMsg("支付成功!");
				return methodResult;
			}
		}
		//该订单有对应的Payordermessage 存在 说明 支付的PayComm已经结束 
		propertyFilters.clear();
		propertyFilters.add(new PropertyFilter("EQS_t!orderno", paraminfo.getOrderno()));
		Payordermessage payordermessage = (Payordermessage) dao.uniqueResult(Payordermessage.class, propertyFilters);
		if (null != payordermessage) {
			methodResult.setResult(2);
			methodResult.setResultMsg(payordermessage.getMessage());
			return methodResult;
		}
		return methodResult;
	}

	@Override
	public void savepayorder(String orderno, String mess) {
		if(!JPA.em().getTransaction().isActive()) {
			JPA.em().getTransaction().begin();
		}
		Date now =  new Date();
		Payordermessage payordermessage =  new Payordermessage(); 
		payordermessage.setOrderno(orderno);
		payordermessage.setMessage(mess);
		payordermessage.setCreatetime(now);
		payordermessage.setUpdatetime(now);
		dao.merge(payordermessage);
		JPA.em().getTransaction().commit();
		JPA.em().getTransaction().begin();
	}
}
