package cn.nova.bus.sale.service.impl;

import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.persistence.LockModeType;

import org.apache.commons.lang.StringUtils;
import org.jasypt.commons.CommonUtils;

import play.db.jpa.JPA;

import com.sun.jmx.snmp.Timestamp;

import sun.net.www.content.text.plain;
import util.AppConstant;
import util.DateUtils;
import util.JsonUtil;
import util.RedisUtil;
import util.RpcUtil;
import util.SecretClientUtil;
import util.RedisUtil.RedisDBApp;

import cn.nova.bus.archive.model.Contractor;
import cn.nova.bus.archive.model.Customer;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.exception.BusinessException;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.insure.model.Insurance;
import cn.nova.bus.sale.dao.PayInfoDao;
import cn.nova.bus.sale.model.Gateway;
import cn.nova.bus.sale.model.Payinfo;
import cn.nova.bus.sale.model.Payinfodetail;
import cn.nova.bus.sale.model.Ticketsell;
import cn.nova.bus.sale.service.EPayService;
import cn.nova.bus.security.Global;
import cn.nova.bus.system.service.ParameterService;
import cn.nova.bus.system.service.impl.ParameterServiceImpl;
import cn.nova.openapi.util.Md5Digest;
import cn.nova.openapi.util.RSAUtils;
import cn.nova.utils.commons.MethodResult;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.IDAO;
import cn.nova.utils.orm.jpa.ListUtil;
/**
 * 电子支付
 * @author feng
 *
 */
public class EPayServiceImpl implements EPayService {
	private static final String payBusinessId = AppConstant.getValue("pay.payBusinessId");
	private static final String payPrivateKey = AppConstant.getValue("pay.payPrivateKey");
	private static final String md5Key = AppConstant.getValue("pay.md5Key");
	private static final String payUrl = AppConstant.getValue("pay.payUrl");
	private static final String gatewayid = AppConstant.getValue("pay.gatewayid");
	private static final String gateway2Webchatid = AppConstant.getValue("pay.gateway2Webchatid");
	private static final String UNIONPAYNAME = AppConstant.getValue("paytradenameval");
	
	private PayInfoDao playInfoDao = new PayInfoDao();
	private IDAO dao = new EntityManagerDaoSurport();
	
	
	private Map<String, String> params = null;
	private Map<String,Object> param = new HashMap<String,Object>();
	private Map<String,Object> resultMap=new HashMap<String,Object>();
	private Map<String, Object> dataMap = new HashMap<String,Object>();
	private String data = "";
	private String result="";
	private String msg="";
	private String resultData = "";
	private String resultMd5 = "";
	private String paynum="";
	private boolean isSavePayInfo=false;
	private String topayid = "";
	private String message = "";
	private ParameterService parameterService =new ParameterServiceImpl();
	
	/**
	 * 付款
	 */
	@Override
	public String ePay(String payCode, String orderno, String epaymoney,
			String paymethod, Global global) {
		return ePay(payCode,orderno,epaymoney,paymethod,global,"","","","");
	}
	/**
	 * @param payCode
	 * @param orderno
	 * @param epaymoney
	 * @param paymethod
	 * @param global
	 * @param tickets
	 * @param ticketprice
	 * @param insures
	 * @param insurefee
	 * @return
	 */
	public String ePay(String payCode, String orderno, String epaymoney,
			String paymethod, Global global,String tickets,String ticketprice,String insures,String insurefee) {
		String result = "SUCCESS";
		//步骤一：获取平台订单号
		String plateOrderNo = getplateOrderno(orderno);
		if(org.apache.commons.lang.StringUtils.isNotEmpty(plateOrderNo)){
			//步骤二：创建支付订单
			String msg = "";
			if(CommonUtils.isNotEmpty(tickets) && CommonUtils.isNotEmpty(ticketprice) && CommonUtils.isNotEmpty(insures) && CommonUtils.isNotEmpty(insurefee)){
				msg = this.pay(payCode,orderno,epaymoney,plateOrderNo,global,paymethod,tickets,ticketprice,insures,insurefee);
			}else{
				msg = this.pay(payCode,orderno,epaymoney,plateOrderNo,global,paymethod);
			}
			if(org.apache.commons.lang.StringUtils.isNotEmpty(msg)){
				result = msg;
			}
		}else{
			result = "获取支付平台订单交易号出错";
		}
		return result;
	}
	/**
	 * 获取平台订单号
	 */
	public String getplateOrderno(String orderno){
		String msg = "";
		Map<String,String> param = new HashMap<String,String>();
		param.put("orderno", orderno);
		String data = cn.nova.openapi.util.JsonUtil.parseObject(param);
		Map<String, String> params = null;
		try {
			params = SecretClientUtil.encryptData(payPrivateKey,
					md5Key, data);
			params.put("paybusinessid", payBusinessId);
			String result = RpcUtil.httpPostByLink(payUrl+"/payorderno" , params,"UTF-8");
			play.Logger.info("支付服务器申请平台订单号接口/payorderno返回数据"+result);
			Map<String,Object> resultMap = cn.nova.openapi.util.JsonUtil.paseJson2Map(result);
			String resultData = resultMap.get("data").toString();
			String resultMd5 = resultMap.get("md5").toString();
			//解密返回结果
			SecretClientUtil secretClientUtil = new SecretClientUtil();
			boolean  success = secretClientUtil.decryptData(payPrivateKey,md5Key, resultData, resultMd5);
			if(success){
				Map<String, Object> dataMap = secretClientUtil.getData();
				msg = (String) dataMap.get("payorderno");
			}
		} catch (Exception e) {
			play.Logger.error("获取支付平台订单交易号出错,请重新刷码！"+e.getMessage());
		}
		return msg;
	}
	/**
	 * 支付
	 * @param payCode
	 * @param orderNo
	 * @param totalPrice
	 * @param plateOrderNo
	 * @param global 
	 * @return
	 */
	public String pay(String payCode, String orderNo, String totalPrice, String plateOrderNo, Global global, String paymethod){
		return this.pay(payCode, plateOrderNo, totalPrice, plateOrderNo, global, paymethod,"","","","");
	}
	/**
	 * @param payCode
	 * @param orderNo
	 * @param totalPrice
	 * @param plateOrderNo
	 * @param global
	 * @param paymethod
	 * @param tickets
	 * @param ticketprice
	 * @param insures
	 * @param insurefee
	 * @return
	 */
	public String pay(String payCode, String orderNo, String totalPrice, String plateOrderNo, Global global, String paymethod,String tickets,String ticketprice,String insures,String insurefee) {
		//String msg = "";
		//String topayid = "";
		//Map<String,Object> param = new HashMap<String,Object>();
		param.put("orderno", orderNo);
		param.put("payorderno", plateOrderNo);
		param.put("totalprice", totalPrice);
		if("5".equals(paymethod)){//微信条码支付
			topayid = gateway2Webchatid;
		}else{//支付宝条码支付
			topayid = gatewayid;
		}
		param.put("topayinfoid", topayid);
		param.put("aliPayCode", payCode);
		param.put("expiretime", "3000");
		String data = cn.nova.openapi.util.JsonUtil.parseObject(param);
		//按照兰经理要求实现先保存，在更新操作
		Date currentTime = new Date();
		Payinfo payInfo = new Payinfo();
		payInfo.setOrderno(orderNo);
		payInfo.setPayorderno(plateOrderNo);
		payInfo.setMerchantpayorderno(plateOrderNo);
		payInfo.setGatewayid(Integer.valueOf(topayid));
		payInfo.setPaystatus(0);
		payInfo.setCreatetime(currentTime);
		payInfo.setCreateby(global.getUserinfo().getId());
		payInfo.setIsactive(true);
		payInfo.setTotalprice(Double.valueOf(totalPrice));
		payInfo.setGatewayid(Integer.valueOf(topayid));
		payInfo.setIsbus365pay(true);
		payInfo.setPaygateway("bus365");//支付网关
		payInfo.setOrderstatus("0");
		payInfo.setIp(global.getIpAddress());
		//增加保存 payinfo 售票数、售票金额；售保险数、售保险金额
		if(CommonUtils.isNotEmpty(tickets) && CommonUtils.isNotEmpty(ticketprice) && CommonUtils.isNotEmpty(insures) && CommonUtils.isNotEmpty(insurefee)){
			payInfo.setTickets(new BigDecimal(tickets));
			payInfo.setTicketprice(new BigDecimal(ticketprice));
			payInfo.setInsures(new BigDecimal(insures));
			payInfo.setInsurefee(new BigDecimal(insurefee));
		}
		SecretClientUtil secretClientUtil = new SecretClientUtil();
		Payinfo p = (Payinfo) dao.merge(payInfo);
		JPA.em().getTransaction().commit();
		JPA.em().getTransaction().begin();
		//Map<String, String> params = null;
		try {
			params = SecretClientUtil.encryptData(payPrivateKey,
					md5Key, data);
			params.put("paybusinessid", payBusinessId);
			result = RpcUtil.httpPostByLink(payUrl+"/pays/createpayparam1" , params,"UTF-8");
			play.Logger.info("支付服务器支付接口/pays/createpayparam1返回数据"+result);
			resultMap = cn.nova.openapi.util.JsonUtil.paseJson2Map(result);
			resultData = resultMap.get("data").toString();
			resultMd5 = resultMap.get("md5").toString();
			//boolean isSavePayInfo = false;
			//解密返回结果
			play.Logger.info(orderNo+"解密返回结果后开始解密");
			boolean  success = secretClientUtil.decryptData(payPrivateKey,md5Key, resultData, resultMd5);
			//String paynum = "";
			//String message = "";
			if(success){
				play.Logger.info(orderNo+"解密成功");
				Map<String, Object> dataMap = secretClientUtil.getData();
				message = (String) dataMap.get("message");
				paynum = (String) dataMap.get("paynum");
				if("支付成功".equals(message)){
					isSavePayInfo = true;
				}else{					
					//查询订单信息，60秒内，请求3次，超过时间认为支付失败
					msg = orderNo+"支付订单失败，进行查询调用……";
					play.Logger.info(msg);
					payRequery(secretClientUtil,orderNo,plateOrderNo,topayid,global);
				}
			}else{
				msg =orderNo+"支付订单解密失败，进行查询调用……";
				play.Logger.info(msg);
				//查询订单信息，60秒内，请求3次，超过时间认为支付失败
				payRequery(secretClientUtil,orderNo,plateOrderNo,topayid,global);
			}
			if(isSavePayInfo){//支付成功，保存支付信息
				play.Logger.info("session:"+global.getSessionID()+",orderNo"+orderNo);
				//从缓存中获取支付网关信息
				Gateway gateWay = this.getGateWay(topayid);
				if(gateWay!=null){
					p.setPaytradename(gateWay.getPaytradename());
					p.setPaytradenameval(gateWay.getPaytradenameval());
				}
				p.setSellorgname(global.getOrganization().getName());
				p.setPaymethod(paymethod);
				p.setPayno(paynum);
				//p.setTotalprice(Double.valueOf(totalPrice));
				p.setPaystatus(1);
				p.setPaymessage(message);
				p.setOrderstatus("1");
				p.setUpdatetime(new Date());
				p.setInsurancestatus("0");
				dao.merge(p);
				msg="";//订单支付成功必须返回为空				
				JPA.em().getTransaction().commit();
			}
			play.Logger.info("session:"+global.getSessionID()+","+orderNo+"订单支付成功-------------------------");
		} catch (Exception e) {
			try{
				msg = orderNo+"支付订单异常，进行查询调用……";
				play.Logger.info(msg);
				payRequery(secretClientUtil,orderNo,plateOrderNo,topayid,global);
				if(isSavePayInfo){//支付成功，保存支付信息
					//从缓存中获取支付网关信息
					Gateway gateWay = this.getGateWay(topayid);
					if(gateWay!=null){
						p.setPaytradename(gateWay.getPaytradename());
						p.setPaytradenameval(gateWay.getPaytradenameval());
					}
					p.setSellorgname(global.getOrganization().getName());
					p.setPaymethod(paymethod);
					p.setPayno(paynum);
					//p.setTotalprice(Double.valueOf(totalPrice));
					p.setPaystatus(1);
					p.setPaymessage(message);
					p.setOrderstatus("1");
					p.setUpdatetime(new Date());
					p.setInsurancestatus("0");
					dao.merge(p);
					JPA.em().getTransaction().commit();
					msg="";//订单支付成功必须返回为空
					play.Logger.info(orderNo+"订单支付成功-------------------------");							
				}		
			}catch(Exception ex){
				play.Logger.error("支付出错，请重新扫码！"+ex.getMessage());
				msg = "支付异常，请重新扫码。如用户支付成功，请去特殊退款菜单退款！";
			}
		}
		return msg;
	}
	
	private void payRequery(SecretClientUtil secretClientUtil,String orderNo,String plateOrderNo,String topayid,Global global){
		try {
			play.Logger.info("调用订单查询接口，查询订单:"+orderNo);
			//电子支付等待时间
			Integer waitSec = 120;
			try {
				waitSec = Integer.valueOf( parameterService.findParamValue("1092", global.getOrganization().getId()));
			} catch (Exception e) {
				waitSec = 120;
				play.Logger.error("1092参数值不是一个整数"+e.getMessage());
			}
			if(waitSec>120){
				waitSec = 120;
			}
			//查询订单信息，60秒内，请求3次，超过时间认为支付失败
			for (int i = 0; i <(waitSec/10); i++) {
				play.Logger.info("第"+i+"次查询订单:"+orderNo);
				param.clear();
				param.put("orderno", orderNo);
				param.put("payorderno", plateOrderNo);
				param.put("topayid", topayid);
				data = cn.nova.openapi.util.JsonUtil.parseObject(param);
				params = SecretClientUtil.encryptData(payPrivateKey,
						md5Key, data);
				params.put("paybusinessid", payBusinessId);
				result = RpcUtil.httpPostByLink(payUrl+"/pays/queryPayResult" , params,"UTF-8");
				play.Logger.info("支付服务器查询订单接口/pays/queryPayResult返回数据"+result);
				resultMap.clear();
				resultMap = cn.nova.openapi.util.JsonUtil.paseJson2Map(result);
				resultData = resultMap.get("data").toString();
				resultMd5 = resultMap.get("md5").toString();
				boolean orderQuerySuccess = secretClientUtil.decryptData(payPrivateKey,md5Key, resultData, resultMd5);
				if(orderQuerySuccess){
					dataMap = secretClientUtil.getData();
					int status = (Integer) dataMap.get("status");
					paynum = (String) dataMap.get("paynum");
					message = (String) dataMap.get("message");
					play.Logger.info(orderNo+"message:"+message);
					if(status==1){
						isSavePayInfo = true;
						break;
					}else{
						Thread.sleep(10000);
					}
				}else{
					msg = "订单查询解密失败！";
					play.Logger.info(orderNo+msg);
				}
			}
			if(!isSavePayInfo){
				msg = "支付不成功，请重新扫码！";
				play.Logger.info(orderNo+msg);
			}else{
				msg = "支付成功！";
				play.Logger.info(orderNo+msg);
			}
		} catch (Exception e) {
			play.Logger.error("payRequery 支付出错，请重新扫码！"+e.getMessage());
			msg = "支付异常，请重新扫码。如用户支付成功，请去特殊退款菜单退款！";
		}
	}
	
	
	/**
	 * 从redis获取gateWay信息
	 * @param gatewayid2
	 * @return
	 */
	public Gateway getGateWay(String gateId) {
		List<String> gateList = RedisUtil.getList(RedisDBApp.global, "app_gateway");
		for (String json : gateList) {
			if(StringUtils.isEmpty(json)){
				continue;
			}
			Gateway gateway = JsonUtil.parseObject(json,Gateway.class);
			if(gateway!=null && gateway.getId().equals(gateId)){
				return gateway;
			}
		}
		Gateway gateway = (Gateway) dao.get(Gateway.class, gateId);
		if(gateway!=null){
			RedisUtil.rPush(RedisDBApp.global, "app_gateway", JsonUtil.toSimpleString(gateway));
		}
		return gateway;
	}
	/**
	 * 同步商家支付网关
	 */
	@Override
	public void syncPayGate() throws ServiceException {
		if(org.apache.commons.lang.StringUtils.isNotEmpty(payBusinessId)){
			//要加密的参数
			Map<String,String> param = new HashMap<String,String>();
			param.put("paybusinessid", payBusinessId);
			String data = cn.nova.openapi.util.JsonUtil.parseObject(param);
			
			Map<String, String> params = null;
			try {
				params = SecretClientUtil.encryptData(payPrivateKey,
						md5Key, data);
				params.put("paybusinessid", payBusinessId);
				String result = RpcUtil.httpPostByLink(payUrl+"/pays/gateways" , params,"UTF-8");
				play.Logger.info("支付服务器同步网关接口/pays/gateways返回数据"+result);
				Map<String,Object> resultMap = cn.nova.openapi.util.JsonUtil.paseJson2Map(result);
				String resultData = resultMap.get("data").toString();
				String resultMd5 = resultMap.get("md5").toString();
				//解密返回结果
				List<Map> gateMap = decryptData(payPrivateKey,md5Key, resultData, resultMd5);
				for (Map map : gateMap) {
					Integer id = (Integer) map.get("id");
					Integer paywaytype = (Integer) map.get("paywaytype");
					Integer paytradename = (Integer) map.get("paytradename");
					String paytradenameval = (String) map.get("paytradenameval");
					String picturepath = (String) map.get("picturepath");
					String bankcode = (String) map.get("bankcode");
					String bankname = (String) map.get("bankname");
					Gateway gateway = (Gateway) dao.get(Gateway.class, id.toString());
					if(gateway==null){
						gateway = new Gateway();
					}
					gateway.setId(id.toString());
					gateway.setPaytradename(paytradename);
					gateway.setPaytradenameval(paytradenameval);
					gateway.setPaywaytype(paywaytype);
					gateway.setPicturepath(picturepath);
					gateway.setBankcode(bankcode);
					gateway.setBankname(bankname);
					dao.merge(gateway);
				}
			} catch (Exception e) {
				play.Logger.error("获取支付网关信息失败！"+e.getMessage());
			}
		}
	}
	/**
	 * 解密支付平台返回集合信息
	 * @param privateKey
	 * @param md5key
	 * @param checkdata
	 * @param md5
	 * @return
	 */
	public  List<Map> decryptData(String privateKey,String md5key,String checkdata,String md5){
		List<Map> manList = new ArrayList<Map>();
		try {
			//RSA私钥解密
			String data = RSAUtils.decryptByPrivateKey(checkdata, privateKey);
			String md5new = Md5Digest.md5WithKey(data, md5key);
			if(!md5new.equals(md5)){
				return manList;
			}
			manList = (List<Map>) cn.nova.openapi.util.JsonUtil.paseJson2Collection(data, Map.class);
		} catch (Exception e) {
			play.Logger.error("解密支付网关信息失败！"+e.getMessage());
		}
		return manList;
	}
	
	/**
	 * 电子退票
	 */
	/*@Override
	public String refundEleTicket(
			Map<String, java.math.BigDecimal> eleReturnTicket, Global global) {
		String message = "success";
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		if(eleReturnTicket.size()>0){
			Date current = new Date();
			for (Entry<String, java.math.BigDecimal> entry : eleReturnTicket.entrySet()) {
				String orderno = entry.getKey();
				BigDecimal returnprice = entry.getValue();
				propertyFilters.clear();
				propertyFilters.add(new PropertyFilter("EQS_t!orderno", orderno));
				Payinfo payinfo = (cn.nova.bus.sale.model.Payinfo) dao.uniqueResult(Payinfo.class, propertyFilters);
				if(payinfo!=null){
					if("1111".equals(payinfo.getReturnstatus())){//已经有过原路返回订单，该订单中的其他车票不能原路返回，只能车站垫付
						message = "订单号："+orderno+"只能进行车站垫付方式退票";
						break;
					}
					//开始退票
					Map<String,Object> param = new HashMap<String,Object>();
					param.put("orderno", orderno);
					param.put("payorderno", payinfo.getPayorderno()!=null?payinfo.getPayorderno():"");
					param.put("payno",payinfo.getPayno()!=null?payinfo.getPayno():"");
					param.put("gatewayid", payinfo.getGatewayid()!=null?payinfo.getGatewayid():0);
					param.put("refundmoney",returnprice.doubleValue());
					param.put("refundmoney",0.01);
					param.put("fullprice",payinfo.getTotalprice()!=null?payinfo.getTotalprice():"0");
					String data = cn.nova.openapi.util.JsonUtil.parseObject(param);
					Map<String, String> params = null;
					try {
						params = SecretClientUtil.encryptData(payPrivateKey,
								md5Key, data);
						params.put("paybusinessid", payBusinessId);
						String result = RpcUtil.httpPostByLink(payUrl+"/refundMoney/1" , params,"UTF-8");
						
						Map<String,Object> resultMap = cn.nova.openapi.util.JsonUtil.paseJson2Map(result);
						String resultData = resultMap.get("data").toString();
						String resultMd5 = resultMap.get("md5").toString();
						
						//解密返回结果
						SecretClientUtil secretClientUtil = new SecretClientUtil();
						//decryptData(payPrivateKey,md5Key, resultData, resultMd5);
						boolean  success = secretClientUtil.decryptData(payPrivateKey,md5Key, resultData, resultMd5);
						if(success){
							Map<String, Object> dataMap = secretClientUtil.getData();
							String msg = (String) dataMap.get("message");
							String status = (String) dataMap.get("status");
							if("1111".equals(status)){//退款成功
								payinfo.setReturnstatus(status);
								payinfo.setUpdateby(global.getUserinfo().getId());
								payinfo.setUpdatetime(current);
								payinfo.setRefundmoney(returnprice.doubleValue());
								payinfo.setReturnmessage(msg);
								dao.merge(payinfo);
							}else{
								message = "订单号："+orderno+msg;
								break;
							}
						}
					} catch (Exception e) {
						play.Logger.error(e.getMessage(), e);
						message = "订单号："+orderno+"原路返回失败";
						break;
					}
				}
			}
		}
		return message;
	}*/
	@Override
	public List<Map<String, Object>>  queryEPayInfo(List<PropertyFilter> propertyFilters) {
	
		Object[] fileds = { "id", "orderno", "payno","totalprice","returnmoney","paytradenameval","returnmethod",
				"paystatus","createtime","updatetime","updateby","isbus365pay",
				"paydate","payorderno","lrc","paymethod","paygateway","tickets","ticketprice","insures","insurefee","ids","merchantpayorderno"};// 初始化要查询的字段
		Object[] filedtypes = { long.class, String.class, String.class, BigDecimal.class,BigDecimal.class,String.class, String.class,
				String.class, Timestamp.class, Timestamp.class, String.class,Boolean.class,
				String.class,String.class,String.class,String.class,String.class,
				long.class,BigDecimal.class,long.class,BigDecimal.class,String.class,String.class};// 初始化要查询的字段 类型
		List<Object> result = playInfoDao.queryEPayInfo(propertyFilters);
		return ListUtil.listToMap(fileds, result,
				filedtypes);
	}
	
	@Override
	public Payinfo findById(long id) {
		return (Payinfo) dao.get(Payinfo.class, id);
	}
	@Override
	public String delPayInfoById(Payinfo payInfo, Global global,Payinfo payinfoc,String ids) throws ServiceException{
		//特殊退票-原路返还
		String msg = this.returnSpecilTicket(payInfo,global, payinfoc, ids);
		dao.merge(payInfo);
		return msg;
	}
	
	
	
	/**
	 * 退票-原路返还
	 * @param payInfo
	 * @return
	 */
	private String returnSpecilTicket(Payinfo payInfo, Global global,Payinfo payinfoc,String ids) {
		String message = "";
		if("1111".equals(payInfo.getReturnstatus())){//已经有过原路返回订单，该订单中的其他车票不能原路返回，只能车站垫付
			message = "该订单已经退票";
		}
		Date current = new Date();
		//开始退票
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("orderno", payInfo.getOrderno());
		param.put("payorderno", payInfo.getPayorderno()!=null?payInfo.getPayorderno():"");
		param.put("payno",payInfo.getPayno()!=null?payInfo.getPayno():"");
		param.put("gatewayid", payInfo.getGatewayid()!=null?payInfo.getGatewayid():0);
		param.put("batchno", DateUtils.getPayBatchno(null));
		boolean isreturnmoney = payInfo.getIsreturnmoney()==null?false:payInfo.getIsreturnmoney();
		if(isreturnmoney){
			param.put("refundmoney",payInfo.getRefundmoney()!=null?payInfo.getRefundmoney():"0");
		}else{
			param.put("refundmoney",payInfo.getTotalprice()!=null?payInfo.getTotalprice():"0");
		}
//		param.put("refundmoney",42.5);
		param.put("fullprice",payInfo.getTotalprice()!=null?payInfo.getTotalprice():"0");
		String data = cn.nova.openapi.util.JsonUtil.parseObject(param);
		Map<String, String> params = null;
		try {
			params = SecretClientUtil.encryptData(payPrivateKey,
					md5Key, data);
			params.put("paybusinessid", payBusinessId);
			String result = RpcUtil.httpPostByLink(payUrl+"/refundMoney/1" , params,"UTF-8");
			play.Logger.info("支付服务器查询退票接口/refundMoney/1返回数据"+result);
			Map<String,Object> resultMap = cn.nova.openapi.util.JsonUtil.paseJson2Map(result);
			String resultData = resultMap.get("data").toString();
			String resultMd5 = resultMap.get("md5").toString();
			
			//解密返回结果
			SecretClientUtil secretClientUtil = new SecretClientUtil();
			//this.decryptData(payPrivateKey,md5Key, resultData, resultMd5);  //解密list集合
			boolean  success = secretClientUtil.decryptData(payPrivateKey,md5Key, resultData, resultMd5);//返回Map集合
			if(success){
				Map<String, Object> dataMap = secretClientUtil.getData();
				String msg = (String) dataMap.get("message");
				String status = (String) dataMap.get("status");
				if("1111".equals(status)){//退款成功
					payInfo.setReturnstatus("1");
					payInfo.setUpdateby(global.getUserinfo().getId());
					payInfo.setUpdatetime(current);
					if(isreturnmoney){
						if(payInfo.getReturnmoneytotal()!=null){
							payInfo.setReturnmoneytotal(payInfo.getReturnmoneytotal()+payInfo.getRefundmoney());
						}else{
							payInfo.setReturnmoneytotal(payInfo.getRefundmoney());
						}	
						payInfo.setRefundmoney(0D);
						payInfo.setIsreturnmoney(false);
						if(payInfo.getTotalprice().equals(payInfo.getReturnmoneytotal())){
							payInfo.setPaystatus(3);
						}
					}else{
						payInfo.setReturnmoneytotal(payInfo.getTotalprice());
						payInfo.setPaystatus(3);
					}
					payInfo.setReturnmessage(msg);
					dao.merge(payInfo);
					message = "退款成功！";
					Date currentTime = new Date();
					if((!"".equals(ids)) || isreturnmoney){//  说明是退票成功但退款失败
						List<Payinfodetail> listPayinfodetail = playInfoDao.findPayinfodetails(ids);
						for (Payinfodetail pd : listPayinfodetail) {
							pd.setIp(global.getIpAddress());
							pd.setReturnby(global.getUserinfo().getId());
							pd.setReturnstatus("1");//退款成功
							pd.setReturnprice(payInfo.getRefundmoney());
							pd.setReturntime(currentTime);
							dao.merge(pd);
						}
					}else{// 售票时 付款成功 出票失败
						//退款详情表增加记录
						Payinfodetail pd = new Payinfodetail();
						pd.setIp(global.getIpAddress());
						pd.setPayinfoid(payInfo.getId());
						pd.setReturnby(global.getUserinfo().getId());
						pd.setReturnstatus("1");//退款成功
						pd.setReturnprice(payInfo.getRefundmoney()!=null?payInfo.getRefundmoney():0);
						pd.setReturntime(currentTime);
						pd.setCreateby(global.getUserinfo().getId());
						pd.setCreatetime(currentTime);
						pd.setInsurefee(payinfoc.getInsurefee());
						pd.setInsures(payinfoc.getInsures());
						pd.setTicketprice(payinfoc.getTicketprice());
						pd.setTickets(payinfoc.getTickets());
						dao.merge(pd);
					}
					//退款详情表增加记录
//					Payinfodetail pd = new Payinfodetail();
//					pd.setIp(global.getIpAddress());
//					pd.setPayinfoid(payInfo.getId());
//					pd.setReturnby(global.getUserinfo().getId());
//					pd.setReturnstatus("1");//退款成功
//					pd.setTickets(payinfoc.getTickets());
//					pd.setTicketprice(payinfoc.getTicketprice());
//					pd.setInsures(payinfoc.getInsures());
//					pd.setInsurefee(payinfoc.getInsurefee());
//					if(isreturnmoney){
//						pd.setReturnprice(payInfo.getRefundmoney()!=null?payInfo.getRefundmoney():0);
//					}else{
//						pd.setReturnprice(payInfo.getTotalprice()!=null?payInfo.getTotalprice():0);
//					}
//					pd.setReturntime(current);
//					pd.setCreateby(global.getUserinfo().getId());
//					pd.setCreatetime(current);
//					dao.merge(pd);
				}else{
					message = msg;
				}
			}
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			message = "退票失败！";
		}
		return message;
	}
	@SuppressWarnings("deprecation")
	@Override
	public List getTicketByOrderNo(String orderno) {
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		propertyFilters.add(new PropertyFilter("EQS_t!orderno",orderno));
		List list = dao.query(Ticketsell.class, propertyFilters);
		return list;
	}
	@Override
	public void syncOrderEpay() throws Exception {
		//第一步：查询系统十分钟内支付失败的订单信息
		List<Payinfo> list = qryOrderEpay(); 
		//第二步：跟支付服务器查询订单支付状态，如成功则更新状态
		for (Payinfo payinfo : list) {
			dealWith(payinfo);
		}
	}
	/**
	 * 查询订单支付状态，如果成功则修改支付信息
	 * @param payinfo
	 * @throws Exception 
	 */
	private void dealWith(Payinfo payinfo) throws Exception {
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("orderno", payinfo.getOrderno());
		param.put("payorderno", payinfo.getPayorderno());
		param.put("topayid", payinfo.getGatewayid());
		String data = cn.nova.openapi.util.JsonUtil.parseObject(param);
		Map<String, String> params = SecretClientUtil.encryptData(payPrivateKey,
				md5Key, data);
		params.put("paybusinessid", payBusinessId);
		String result = RpcUtil.httpPostByLink(payUrl+"/pays/queryPayResult" , params,"UTF-8");
		play.Logger.info("支付服务器查询订单接口/pays/queryPayResult返回数据"+result);
		play.Logger.info(payinfo.getOrderno()+"syncOrderEpay查询支付情况result:"+result);
		Map<String,Object> resultMap = cn.nova.openapi.util.JsonUtil.paseJson2Map(result);
		String resultData = resultMap.get("data").toString();
		String resultMd5 = resultMap.get("md5").toString();
		SecretClientUtil secretClientUtil = new SecretClientUtil();
		boolean orderQuerySuccess = secretClientUtil.decryptData(payPrivateKey,md5Key, resultData, resultMd5);
		if(orderQuerySuccess){
			Map<String, Object> dataMap = secretClientUtil.getData();
			int status = (Integer) dataMap.get("status");
			String paynum = (String) dataMap.get("paynum");
			String message = (String) dataMap.get("message");
			if(status==1){//支付成功，则修改订单状态
				payinfo.setPayno(paynum);
				payinfo.setPaystatus(1);
				payinfo.setPaymessage(message);
				dao.merge(payinfo);
			}
		}
		
	}
	/**
	 * 查询系统一天内支付失败的订单信息
	 * @return
	 */
	@SuppressWarnings({ "deprecation" })
	private List<Payinfo> qryOrderEpay() {
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		Calendar c = Calendar.getInstance();
		c.add(Calendar.DAY_OF_MONTH, -1);
		propertyFilters.add(new PropertyFilter("EQI_t!paystatus",0));
		propertyFilters.add(new PropertyFilter("GED_t!createtime",c.getTime()));
		propertyFilters.add(new PropertyFilter("LED_t!createtime",new Date()));
		propertyFilters.add(new PropertyFilter("EQB_t!isbus365pay",true));
		List<Payinfo> list = dao.query(Payinfo.class, propertyFilters);
		return list;
	}
	@Override
	public void unionPay(Payinfo payinfo, Global global) {
		if(payinfo != null){
			Date currentTime = new Date();
			if(payinfo.getId()>0){//修改银行卡流水信息
				Payinfo p = playInfoDao.get(LockModeType.PESSIMISTIC_READ,Payinfo.class, payinfo.getId());
				if(p!=null){
					if(p.getReturnmoneytotal()!=null){
						p.setReturnmoneytotal(p.getReturnmoneytotal()+payinfo.getRefundmoney());
					}else{
						p.setReturnmoneytotal(payinfo.getRefundmoney());
					}
					p.setReturnstatus("1");
				}
				//PAYSTATUS : 支付状态0-未支付或支付失败1-支付成功2-查询失败3-退票成功
				if(p.getReturnmoneytotal().equals(p.getTotalprice())){
					p.setPaystatus(3);
				}
				p.setReturnmessage(payinfo.getReturnmessage());
				p.setUpdatetime(currentTime);
				p.setUpdateby(global.getUserinfo().getId());
				//退款详情表增加记录
				Payinfodetail pd = new Payinfodetail();
				pd.setIp(global.getIpAddress());
				pd.setPayinfoid(p.getId());
				pd.setReturnby(global.getUserinfo().getId());
				pd.setReturnstatus("1");//退款成功
				pd.setReturnprice(payinfo.getRefundmoney());
				pd.setReturntime(currentTime);
				pd.setCreateby(global.getUserinfo().getId());
				pd.setCreatetime(currentTime);
				//增加 payinfodetail 退票数、退票金额；退保险数、退保险金额 add by tianhb 2018年4月19日 begin
				pd.setTickets(payinfo.getTickets());
				pd.setTicketprice(payinfo.getTicketprice());
				pd.setInsures(payinfo.getInsures());
				pd.setInsurefee(payinfo.getInsurefee());
				//增加 payinfodetail 退票数、退票金额；退保险数、退保险金额 add by tianhb 2018年4月19日 end
				dao.merge(pd);
			}else{//新增银行卡流水记录
				//设置默认值
				List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
				propertyFilters.add(new PropertyFilter("EQS_t!orderno",payinfo.getOrderno()));
				propertyFilters.add(new PropertyFilter("EQB_t!isbus365pay",false));
				Payinfo p =   (Payinfo) playInfoDao.uniqueResult(Payinfo.class, propertyFilters);
				if(p==null){
					if(payinfo.getTotalprice()>0){
						payinfo.setTotalprice(payinfo.getTotalprice());
					}
					if(payinfo.getPaydate()!=null){
						int year = Calendar.getInstance().get(Calendar.YEAR);
						payinfo.setPaydate(year+payinfo.getPaydate());
					}
					payinfo.setPaystatus(1);
					payinfo.setGatewayid(0);
					payinfo.setIsbus365pay(false);
					payinfo.setCreatetime(currentTime);
					payinfo.setCreateby(global.getUserinfo().getId());
					payinfo.setSellorgname(global.getOrganization().getName());
					payinfo.setPaygateway("银联");//支付网关
					if(UNIONPAYNAME!=null){
						try {
							payinfo.setPaytradenameval(new String(UNIONPAYNAME.getBytes("ISO8859-1"), "UTF-8"));
						} catch (UnsupportedEncodingException e) {
							play.Logger.error("银联支付商名称转码失败", e.getMessage());
						}
					}else{
						payinfo.setPaytradenameval("吉林银联商务");
					}
					payinfo.setOrderstatus("1");
					payinfo.setIp(global.getIpAddress());
					payinfo.setInsurancestatus("0");
					dao.merge(payinfo);
				}else{
					p.setPayorderno(payinfo.getPayorderno());
					p.setPayno(payinfo.getPayno());
					p.setPaymessage(payinfo.getPaymessage());
					p.setPaymethod(payinfo.getPaymethod());
					p.setPaytradename(payinfo.getPaytradename());
					p.setCardcode(payinfo.getCardcode());
					p.setBatchcode(payinfo.getBatchcode());
					p.setBankcode(payinfo.getBankcode());
					p.setTerterminalcode(payinfo.getTerterminalcode());
					p.setPaytime(payinfo.getPaytime());
					p.setAuthorizationcode(payinfo.getAuthorizationcode());
					p.setClearingdate(payinfo.getClearingdate());
					p.setLrc(payinfo.getLrc());
					p.setDiscounts(payinfo.getDiscounts());
					p.setRespcode(payinfo.getRespcode());
					p.setMerchantpayorderno(payinfo.getMerchantpayorderno());
					if(payinfo.getPaydate()!=null){
						int year = Calendar.getInstance().get(Calendar.YEAR);
						p.setPaydate(year+payinfo.getPaydate());
					}
					p.setPaystatus(1);
					p.setOrderstatus("1");
					p.setInsurancestatus("0");
				}
			}
		}
	}
	@Override
	public void editPayinfo(Payinfo payinfo, Global global) {
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		propertyFilters.add(new PropertyFilter("EQS_t!orderno",payinfo.getOrderno()));
		Payinfo p = (Payinfo) dao.uniqueResult(Payinfo.class, propertyFilters);
		if(p!=null){
			if(p.getRefundmoney()!=null){
				p.setRefundmoney(p.getRefundmoney()+payinfo.getRefundmoney());
			}else{
				p.setRefundmoney(payinfo.getRefundmoney());
			}
			p.setIsreturnmoney(true);
			//退款详情表增加记录
			Date currentTime = new Date();
			Payinfodetail pd = new Payinfodetail();
			pd.setIp(global.getIpAddress());
			pd.setPayinfoid(p.getId());
			pd.setReturnby(global.getUserinfo().getId());
			pd.setReturnstatus("0");//退款失败
			pd.setReturnprice(payinfo.getRefundmoney());
			pd.setReturntime(currentTime);
			pd.setCreateby(global.getUserinfo().getId());
			pd.setCreatetime(currentTime);
			//增加 payinfodetail 退票数、退票金额；退保险数、退保险金额 add by tianhb 2018年4月19日 begin
			pd.setTickets(payinfo.getTickets());
			pd.setTicketprice(payinfo.getTicketprice());
			pd.setInsures(payinfo.getInsures());
			pd.setInsurefee(payinfo.getInsurefee());
			//增加 payinfodetail 退票数、退票金额；退保险数、退保险金额 add by tianhb 2018年4月19日 end
			dao.merge(pd);
		}
	}
	@Override
	public void returnBatchepay(String orderno, Double refundmoney, Global global) throws Exception {
		returnBatchepay(orderno,refundmoney,global,null,null,null,null);
	}
	/**
	 * 批量退款
	 * @param orderno
	 * @param refundmoney
	 * @param global
	 * @param tickets
	 * @param ticketprice
	 * @param insures
	 * @param insurefee
	 * @throws Exception
	 */
	public void returnBatchepay(String orderno, Double refundmoney, Global global,String tickets,String ticketprice,String insures,String insurefee) throws Exception {
		Date current = new Date();
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		propertyFilters.add(new PropertyFilter("EQS_t!orderno",orderno));
		Payinfo payInfo = (Payinfo) dao.uniqueResult(Payinfo.class, propertyFilters);
		//开始退票
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("orderno", payInfo.getOrderno());
		param.put("payorderno", payInfo.getPayorderno()!=null?payInfo.getPayorderno():"");
		param.put("payno",payInfo.getPayno()!=null?payInfo.getPayno():"");
		param.put("gatewayid", payInfo.getGatewayid()!=null?payInfo.getGatewayid():0);
		param.put("batchno", DateUtils.getPayBatchno(null));
		param.put("refundmoney",refundmoney);
//		param.put("refundmoney",100);
		param.put("fullprice",payInfo.getTotalprice()!=null?payInfo.getTotalprice():"0");
		String data = cn.nova.openapi.util.JsonUtil.parseObject(param);
		Map<String, String> params = null;
		params = SecretClientUtil.encryptData(payPrivateKey,
				md5Key, data);
		params.put("paybusinessid", payBusinessId);
		String result = RpcUtil.httpPostByLink(payUrl+"/refundMoney/1" , params,"UTF-8");
		play.Logger.info("支付服务器接口/refundMoney/1返回数据"+result);
		Map<String,Object> resultMap = cn.nova.openapi.util.JsonUtil.paseJson2Map(result);
		String resultData = resultMap.get("data").toString();
		String resultMd5 = resultMap.get("md5").toString();
		
		//解密返回结果
		SecretClientUtil secretClientUtil = new SecretClientUtil();
		//this.decryptData(payPrivateKey,md5Key, resultData, resultMd5);  //解密list集合
		boolean  success = secretClientUtil.decryptData(payPrivateKey,md5Key, resultData, resultMd5);//返回Map集合
		if(success){
			Map<String, Object> dataMap = secretClientUtil.getData();
			String msg = (String) dataMap.get("message");
			String status = (String) dataMap.get("status");
			if("1111".equals(status)){//退款成功
				payInfo.setReturnstatus("1");
				payInfo.setUpdateby(global.getUserinfo().getId());
				payInfo.setUpdatetime(current);
				if(payInfo.getReturnmoneytotal()!=null){
					payInfo.setReturnmoneytotal(payInfo.getReturnmoneytotal()+refundmoney);
				}else{
					payInfo.setReturnmoneytotal(refundmoney);
				}
				if(payInfo.getTotalprice().equals(payInfo.getReturnmoneytotal())){
					payInfo.setPaystatus(3);
				}
				payInfo.setRefundmoney(0D);
				payInfo.setIsreturnmoney(false);
				payInfo.setReturnmessage(msg);
				dao.merge(payInfo);
				//退款详情表增加记录
				Payinfodetail pd = new Payinfodetail();
				pd.setIp(global.getIpAddress());
				pd.setPayinfoid(payInfo.getId());
				pd.setReturnby(global.getUserinfo().getId());
				pd.setReturnstatus("1");//退款成功
				pd.setReturnprice(refundmoney);
				pd.setReturntime(current);
				pd.setCreateby(global.getUserinfo().getId());
				pd.setCreatetime(current);
				//增加 payinfodetail 退票数、退票金额；退保险数、退保险金额 add by tianhb 2018年4月20日 begin
				pd.setTickets(new BigDecimal(tickets));
				pd.setTicketprice(new BigDecimal(ticketprice));
				pd.setInsures(new BigDecimal(insures));
				pd.setInsurefee(new BigDecimal(insurefee));
				//增加 payinfodetail 退票数、退票金额；退保险数、退保险金额 add by tianhb 2018年4月20日 end
				dao.merge(pd);
			}else{
				throw new  Exception("支付服务器退款失败"); 
			}
		}else{
			throw new  Exception("支付服务器退款失败"); 
		}
		
	}
	@Override
	public List queryPayinfoByNo(String orderno) {
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		propertyFilters.add(new PropertyFilter("EQS_t!orderno",orderno));
		List list = dao.query(Payinfo.class, propertyFilters);
		return ListUtil.listToMap(new Object[]{Payinfo.class}, list);
	}
	@Override
	public void updatePayinfoById(Payinfo payinfo, Global global,String ids) throws BusinessException{
		Payinfo p =  playInfoDao.get(LockModeType.PESSIMISTIC_READ,Payinfo.class, payinfo.getId());
		if(p!=null){
			Date currentTime = new Date();
			if(!"".equals(ids) || (p.getIsreturnmoney()!=null && p.getIsreturnmoney())){//  说明是退票成功但退款失败
				List<Payinfodetail> listPayinfodetail = playInfoDao.findPayinfodetails(ids);
				BigDecimal totalmoney = BigDecimal.ZERO;
				for (Payinfodetail pd : listPayinfodetail) {
					totalmoney = totalmoney.add(pd.getTicketprice().add(pd.getInsurefee()));
					pd.setIp(global.getIpAddress());
					pd.setReturnby(global.getUserinfo().getId());
					pd.setReturnstatus("1");//退款成功
					pd.setReturnprice(payinfo.getRefundmoney());
					pd.setReturntime(currentTime);
					dao.merge(pd);
				}
				if(totalmoney.compareTo(BigDecimal.valueOf(payinfo.getRefundmoney()))!=0){
					throw new  BusinessException("本次特殊退款金额与明细数据不一致,请联系管理员!"); 
				}
			}else{// 售票时 付款成功 出票失败
				//退款详情表增加记录
				Payinfodetail pd = new Payinfodetail();
				pd.setIp(global.getIpAddress());
				pd.setPayinfoid(p.getId());
				pd.setReturnby(global.getUserinfo().getId());
				pd.setReturnstatus("1");//退款成功
				pd.setReturnprice(payinfo.getRefundmoney());
				pd.setReturntime(currentTime);
				pd.setCreateby(global.getUserinfo().getId());
				pd.setCreatetime(currentTime);
				pd.setInsurefee(payinfo.getInsurefee());
				pd.setInsures(payinfo.getInsures());
				pd.setTicketprice(payinfo.getTicketprice());
				pd.setTickets(payinfo.getTickets());
				dao.merge(pd);
			}
			if(p.getIsreturnmoney()!=null && p.getIsreturnmoney()){
				p.setIsreturnmoney(false);
				p.setRefundmoney(0D);
			}
			p.setReturnstatus("1");
			if(p.getReturnmoneytotal()!=null){
				p.setReturnmoneytotal(p.getReturnmoneytotal()+payinfo.getRefundmoney());
			}else{
				p.setReturnmoneytotal(payinfo.getRefundmoney());
			}
			if(p.getTotalprice().equals(p.getReturnmoneytotal())){
				p.setPaystatus(3);
			}
			p.setUpdatetime(currentTime);
			p.setUpdateby(global.getUserinfo().getId());
			dao.merge(p);
		}
	}
	@Override
	public void initPayinfo(Payinfo payinfo, Global global) {
		Date currentTime = new Date();
		if(payinfo.getTotalprice()>0){
			payinfo.setTotalprice(payinfo.getTotalprice());
		}
		payinfo.setPaystatus(0);
		payinfo.setPayorderno(payinfo.getOrderno());
		payinfo.setGatewayid(0);
		payinfo.setIsbus365pay(false);
		payinfo.setCreatetime(currentTime);
		payinfo.setCreateby(global.getUserinfo().getId());
		payinfo.setSellorgname(global.getOrganization().getName());
		payinfo.setOrderstatus("0");
		payinfo.setPaygateway("银联");//支付网关
		if(UNIONPAYNAME!=null){
			try {
				payinfo.setPaytradenameval(new String(UNIONPAYNAME.getBytes("ISO8859-1"), "UTF-8"));
			} catch (UnsupportedEncodingException e) {
				play.Logger.error("银联支付商名称转码失败", e.getMessage());
			}
		}else{
			payinfo.setPaytradenameval("银联商务");
		}
		payinfo.setIp(global.getIpAddress());
		dao.merge(payinfo);
	}
	@Override
	public List<Map<String, Object>> queryEPayDetail(long id) {
		Object[] fileds = { "orderno", "returntime", "returnstatus","returnby","ip",
				"returnprice"};// 初始化要查询的字段
		Object[] filedtypes = { String.class, Timestamp.class, String.class, String.class,String.class,
				BigDecimal.class};// 初始化要查询的字段 类型
		List<Object> result = playInfoDao.queryEPayDetail(id);
		return ListUtil.listToMap(fileds, result,
				filedtypes);
	}
}
