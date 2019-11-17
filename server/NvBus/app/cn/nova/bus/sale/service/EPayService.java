package cn.nova.bus.sale.service;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.sale.model.Payinfo;
import cn.nova.bus.sale.model.Ticketsell;
import cn.nova.bus.security.Global;
import cn.nova.utils.commons.MethodResult;
import cn.nova.utils.orm.PropertyFilter;

/**
 * 电子支付
 * @author qingfeng
 *
 */
public interface EPayService {
	/**
	 * 付款
	 * @param payCode
	 * @param orderno
	 * @param epaymoney
	 * @param paymethod 
	 * @param global
	 * @return
	 */
	String ePay(String payCode, String orderno, String epaymoney, String paymethod, Global global);
	/**
	 * 付款
	 * @param payCode
	 * @param orderno
	 * @param epaymoney
	 * @param paymethod
	 * @param globalString
	 * @return
	 */
	String ePay(String payCode, String orderno, String epaymoney, String paymethod, Global globalString,String tickets,String ticketprice,String insures,String insurefee);
	/**
	 * 同步支付网关
	 * @throws ServiceException
	 */
	void syncPayGate() throws ServiceException;
	/**
	 * 退款
	 * @param eleReturnTicket
	 * @param global
	 * @return
	 */
	//String refundEleTicket(Map<String, BigDecimal> eleReturnTicket,Global global);
	/**
	 * 查询电子支付订单日志
	 * @param propertyFilters
	 * @return
	 */
	List<Map<String, Object>> queryEPayInfo(List<PropertyFilter> propertyFilters);
	/**
	 * 根据id查询电子支付日志
	 * @param id
	 * @return
	 */
	Payinfo findById(long id);
	/**
	 * 删除电子支付日志
	 * @param payInfo
	 * @param global 
	 * @return
	 * @throws ServiceException 
	 */
	String delPayInfoById(Payinfo payInfo, Global global,Payinfo payinfoc,String ids) throws ServiceException;
	/**
	 * 根据订单号获取票
	 * @param orderno
	 * @return
	 */
	List getTicketByOrderNo(String orderno);
	/**
	 * job同步支付失败的订单支付状态
	 * @throws Exception 
	 */
	void syncOrderEpay() throws Exception;
	/**
	 * 保存银联卡支付信息
	 * @param payinfo
	 * @param global
	 * @return
	 */
	void unionPay(Payinfo payinfo, Global global);
	/**
	 * 窗口电子支付退部分款
	 * @param payinfo
	 * @param global
	 */
	void editPayinfo(Payinfo payinfo, Global global);
	/**
	 * 批量退款
	 * @param orderno
	 * @param refundmoney
	 * @param global
	 */
	void returnBatchepay(String orderno, Double refundmoney, Global global) throws Exception;
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
	void returnBatchepay(String orderno, Double refundmoney, Global global,String tickets,String ticketprice,String insures,String insurefee) throws Exception;
	/**
	 * 查询银行卡退款流水信息
	 * @param orderno
	 * @return
	 */
	List queryPayinfoByNo(String orderno);
	/**
	 * 吉林支付退款成功，修改流水信息
	 * @param payinfo
	 * @param global
	 */
	void updatePayinfoById(Payinfo payinfo, Global global,String ids);
	/**
	 * 吉林银联初始化订单信息
	 * @param payinfo
	 * @param global
	 */
	void initPayinfo(Payinfo payinfo, Global global);
	/**
	 * 电子票退款详情信息
	 * @param id
	 * @return
	 */
	List<Map<String, Object>> queryEPayDetail(long id);
	
}
