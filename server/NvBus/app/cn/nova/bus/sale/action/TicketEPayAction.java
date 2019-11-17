package cn.nova.bus.sale.action;

import java.util.List;
import java.util.Map;

import util.CurrentUtil;
import cn.nova.bus.action.BaseAction;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.sale.model.Payinfo;
import cn.nova.bus.sale.model.Ticketsell;
import cn.nova.bus.sale.service.EPayService;
import cn.nova.bus.sale.service.impl.EPayServiceImpl;
import cn.nova.bus.security.Global;
import cn.nova.utils.commons.MethodResult;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.web.ServletPropertyFilterUtil;

public class TicketEPayAction extends BaseAction{

	private String payCode;//支付宝支付条码
	private String orderno;
	private String epaymoney;
	private String paymethod;
	private String tickets;//售票数
	private String ticketprice;//售票金额
	private String insures;//售保险数
	private String insurefee;//售保险金额
	
	private long id;
	private List<Map<String, Object>> ePayInfo;
	private Payinfo payinfo;
	private Double refundmoney;
	private List infoList;
	private String ids;
	
	/**
	 * 银联卡支付成功以后保存日志
	 * @return
	 */
	public String unionPay(){
		Global global = CurrentUtil.getGlobal();
		EPayService ePayService = new EPayServiceImpl();
		try {
			ePayService.unionPay(payinfo,global);
			markSuccess();
		} catch (Exception e) {
			markFailure();
			play.Logger.error("保存银行卡成功流水信息失败！凭证号："+payinfo.getPayno(), e);
		}
		return "json";
	}
	
	/**
	 * 扫码支付
	 * @return
	 */
	public String ePay(){
		Global global = CurrentUtil.getGlobal();
		EPayService ePayService = new EPayServiceImpl();
		try {
			String message = ePayService.ePay(payCode,orderno,epaymoney,paymethod,global,tickets,ticketprice,insures,insurefee);
			if("SUCCESS".equals(message)){
				markSuccess();
			}else{
				markFailure();
				setMsg(message);
			}
		} catch (Exception e) {
			markFailure();
			setMsg("支付失败，请重新扫码！");
			play.Logger.error("平台服务器支付异常！订单号："+orderno, e);
		}
		return "json";
	}
	/**
	 * 查询支付订单
	 * @return
	 */
	public String queryEPay(){
		List<PropertyFilter> propertyFilters = ServletPropertyFilterUtil.buildFromHttpRequest();
		EPayService ePayService = new EPayServiceImpl();
		List<Map<String, Object>> result;
		try {
			result = ePayService.queryEPayInfo(propertyFilters);
			if(result.size()>0){
				markSuccess();
				setMsg("查询成功！");
				setEPayInfo(result); 
			}else{
				markFailure();
				setMsg("查询失败!");
			}
		} catch (Exception e) {
			markFailure();
			play.Logger.error("电子支付订单流水查询异常！"+e.getMessage(),e);
		}
		return "json";
	}
	/**
	 * 特殊退票-原路返还方式
	 * @return
	 */
	public String returnEpay(){
		Global global = CurrentUtil.getGlobal();
		EPayService ePayService = new EPayServiceImpl();
		Payinfo payInfo = ePayService.findById(id);
		if(payInfo!=null){
			/*String orderno = payInfo.getOrderno();
			List ticketList = ePayService.getTicketByOrderNo(orderno);
			if(ticketList.size()>0){
				msg = "车票已出，不能特殊退款！";
				markSuccess();
				return "json";
			}*/
			try {
				msg = ePayService.delPayInfoById(payInfo,global,payinfo,ids);
				markSuccess();
			} catch (ServiceException e) {
				msg = "删除失败！";
				markFail();
			}
		}else{
			msg = "不存在支付信息！";
			markSuccess();
		}
		return "json";
	}
	/**
	 * 窗口电子支付退部分款
	 * @return
	 */
	public String editPayinfo(){
		try {
			EPayService ePayService = new EPayServiceImpl();
			Global global = CurrentUtil.getGlobal();
			ePayService.editPayinfo(payinfo,global);
		} catch (Exception e) {
			play.Logger.error("更新payinfo表失败，订单号:"+payinfo.getOrderno()+",退款金额："+payinfo.getRefundmoney(), e);
		}
		return "json";
	}
	/**
	 * 批次退款(平台支付服务器)
	 * @return
	 */
	public String returnBatchepay(){
		try {
			EPayService ePayService = new EPayServiceImpl();
			Global global = CurrentUtil.getGlobal();
			ePayService.returnBatchepay(orderno,refundmoney,global,tickets,ticketprice,insures,insurefee);
			markSuccess();
		} catch (Exception e) {
			markFail();
			setMsg("退款失败!");
			play.Logger.error("批次退款失败，订单号:"+orderno+",退款金额："+refundmoney, e);
		}
		return "json";
	}
	/**
	 * 查询银行卡支付信息
	 * @return
	 */
	public String queryPayinfoByNo(){
		EPayService ePayService = new EPayServiceImpl();
		infoList = ePayService.queryPayinfoByNo(orderno);
		return "json";
	}
	/**
	 * 吉林支付退款成功，修改流水信息
	 * @return
	 */
	public String updatePayinfoById(){
		EPayService ePayService = new EPayServiceImpl();
		Global global = CurrentUtil.getGlobal();
		try {
			if(payinfo!=null && payinfo.getId()>0){
				ePayService.updatePayinfoById(payinfo,global,ids);
			}
		} catch (Exception e) {
			markFail();
			play.Logger.error("吉林退款成功，更新支付流水信息失败，id:"+id, e);
		}
		return "json";
	}
	/**
	 * 吉林银联初始化订单信息
	 * @return
	 */
	public String initPayinfo(){
		EPayService ePayService = new EPayServiceImpl();
		Global global = CurrentUtil.getGlobal();
		try {
			if(payinfo!=null){
				ePayService.initPayinfo(payinfo,global);
			}
		} catch (Exception e) {
			markFail();
			play.Logger.error("吉林初始化支付流水信息失败，id:"+id, e);
		}
		return "json";	
	}
	/**
	 * 电子票退款详情信息
	 * @return
	 */
	public String queryEPayDetail(){
		EPayService ePayService = new EPayServiceImpl();
		try {
			setEPayInfo(ePayService.queryEPayDetail(id));
		} catch (Exception e) {
			markFail();
			play.Logger.error("查询电子退款详情信息失败，id:"+id, e);
		}
		return "json";	
	}
	
	public String getPayCode() {
		return payCode;
	}

	public void setPayCode(String payCode) {
		this.payCode = payCode;
	}

	public String getOrderno() {
		return orderno;
	}

	public void setOrderno(String orderno) {
		this.orderno = orderno;
	}

	public String getEpaymoney() {
		return epaymoney;
	}

	public void setEpaymoney(String epaymoney) {
		this.epaymoney = epaymoney;
	}

	public String getPaymethod() {
		return paymethod;
	}

	public void setPaymethod(String paymethod) {
		this.paymethod = paymethod;
	}
	public List<Map<String, Object>> getEPayInfo() {
		return ePayInfo;
	}
	public void setEPayInfo(List<Map<String, Object>> ePayInfo) {
		this.ePayInfo = ePayInfo;
	}
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}

	public Payinfo getPayinfo() {
		return payinfo;
	}

	public void setPayinfo(Payinfo payinfo) {
		this.payinfo = payinfo;
	}

	public Double getRefundmoney() {
		return refundmoney;
	}

	public void setRefundmoney(Double refundmoney) {
		this.refundmoney = refundmoney;
	}

	public List getInfoList() {
		return infoList;
	}

	public void setInfoList(List infoList) {
		this.infoList = infoList;
	}

	public String getTickets() {
		return tickets;
	}

	public void setTickets(String tickets) {
		this.tickets = tickets;
	}

	public String getTicketprice() {
		return ticketprice;
	}

	public void setTicketprice(String ticketprice) {
		this.ticketprice = ticketprice;
	}

	public String getInsures() {
		return insures;
	}

	public void setInsures(String insures) {
		this.insures = insures;
	}

	public String getInsurefee() {
		return insurefee;
	}

	public void setInsurefee(String insurefee) {
		this.insurefee = insurefee;
	}

	public String getIds() {
		return ids;
	}

	public void setIds(String ids) {
		this.ids = ids;
	}
	
	
}
