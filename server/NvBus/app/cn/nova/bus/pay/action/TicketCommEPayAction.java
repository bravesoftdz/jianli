package cn.nova.bus.pay.action;

import java.util.List;
import java.util.Map;

import cn.nova.bus.action.BaseAction;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.pay.job.PayComm;
import cn.nova.bus.pay.param.BusParamEPaymentInfo;
import cn.nova.bus.pay.param.BusRider;
import cn.nova.bus.pay.param.ParamScheduleRiderIn;
import cn.nova.bus.pay.service.impl.TicketCommEPayServiceImpl;
import cn.nova.bus.sale.model.Payinfo;
import cn.nova.bus.sale.model.Ticketreturn;
import cn.nova.bus.sale.service.EPayService;
import cn.nova.bus.sale.service.impl.EPayServiceImpl;
import cn.nova.bus.security.Global;
import cn.nova.utils.commons.MethodResult;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;
import cn.nova.utils.web.ServletPropertyFilterUtil;
import util.CurrentUtil;

public class TicketCommEPayAction extends BaseAction {


	private List<Map<String, Object>> ePayInfo;
	private BusParamEPaymentInfo paraminfo;
	private List<ParamScheduleRiderIn> scheduleriders;
	//查询支付结果
	public String queryPayresult() {
		try {
			TicketCommEPayServiceImpl ser = new TicketCommEPayServiceImpl();
			MethodResult result = ser.queryPayresult(paraminfo);
			if(result.getResult() == MethodResult.SUCCESS) {
				markSuccess();
				setMsg("支付成功!");
			}else if(result.getResult() == 2) {
				//没有支付就报错或者支付报错等
				setFlag(2L);
				setMsg(result.getResultMsg());
			}else {
				markFailure();
				setMsg("未查到对应的支付记录!");
			}
		} catch (Exception e) {
			markFailure();
			setMsg("支付失败，请重新扫码！");
			play.Logger.error("平台服务器支付异常！订单号：" + paraminfo.getOrderno(), e);
		}
		return "json";
	}
	
	/**
	 * 站务支付服务器电子支付统一支付接口
	 * 
	 * @return
	 */
	public String ePaymentComm() {
		try {
			Global global = CurrentUtil.getGlobal();
			TicketCommEPayServiceImpl ser = new TicketCommEPayServiceImpl();
			// 创建参数
			BusParamEPaymentInfo paraminfook = ser.converterParam(paraminfo, scheduleriders, global);
			// 站务支付服务器电子支付统一支付接口
			MethodResult result = ser.ePaymentComm(paraminfook);
			if (result.getResult() != MethodResult.SUCCESS) {
				markFailure();
				setMsg(result.getResultMsg());
			} else {
				markSuccess();
				setMsg("支付成功!");
			}
		} catch (Exception e) {
			markFailure();
			setMsg("支付失败，请重新扫码！");
			play.Logger.error("平台服务器支付异常！订单号：" + paraminfo.getOrderno(), e);
		}
		return "json";
	}

	public String ePaymentCommNoback() {
		try {
			play.Logger.info(" 支付服务器支付开始......");
			Global global = CurrentUtil.getGlobal();
			PayComm paycomm = new PayComm(paraminfo,scheduleriders,global); 
			paycomm.now();
			play.Logger.info(" 支付服务器支付中......");
		} catch (Exception e) {
			markFailure();
			setMsg("支付失败，请重新扫码！");
			play.Logger.error("平台服务器支付异常！订单号：" + paraminfo.getOrderno(), e);
		}
		markSuccess();
		return "json";
	}
	public String findEmpty() {
		setEPayInfo(ListUtil.listToMap(new Object[] { ParamScheduleRiderIn.class }, null));
		return "json";
	}

	/**
	 * 站务支付服务器统一退款接口
	 * 
	 * @return
	 */
	public String ePayReturnComm() {
		try {
			TicketCommEPayServiceImpl ser = new TicketCommEPayServiceImpl();
			Global global = CurrentUtil.getGlobal();
			paraminfo.setGlobal(global);
			MethodResult result = ser.ePayReturnComm(paraminfo);
			if (result.getResult() != MethodResult.SUCCESS) {
				markFail();
				setMsg(result.getResultMsg());
			} else {
				markSuccess();
				setMsg("退款成功!");
			}
		} catch (Exception e) {
			markFail();
			setMsg("退款失败!");
			play.Logger.error("批次退款失败，订单号:" + paraminfo.getOrderno() + ",退款金额：" + paraminfo.getRefundmoney(), e);
		}
		return "json";
	}

	/**
	 * 站务支付服务器统一特殊退款接口
	 * 
	 * @return
	 */
	public String ePaySpecialReturnComm() {
		try {
			TicketCommEPayServiceImpl ser = new TicketCommEPayServiceImpl();
			Global global = CurrentUtil.getGlobal();
			paraminfo.setGlobal(global);
			MethodResult result = ser.ePaySpecialReturnComm(paraminfo);
			if (result.getResult() != MethodResult.SUCCESS) {
				markFail();
				setMsg(result.getResultMsg());
			} else {
				markSuccess();
				setMsg("退款成功!");
			}
		} catch (Exception e) {
			markFail();
			setMsg("退款失败!");
			play.Logger.error("批次退款失败，订单号:" + paraminfo.getOrderno() + ",退款金额：" + paraminfo.getRefundmoney(), e);
		}
		return "json";
	}
	public List<Map<String, Object>> getEPayInfo() {
		return ePayInfo;
	}

	public void setEPayInfo(List<Map<String, Object>> ePayInfo) {
		this.ePayInfo = ePayInfo;
	}

	public BusParamEPaymentInfo getParaminfo() {
		return paraminfo;
	}

	public void setParaminfo(BusParamEPaymentInfo paraminfo) {
		this.paraminfo = paraminfo;
	}

	public List<ParamScheduleRiderIn> getScheduleriders() {
		return scheduleriders;
	}

	public void setScheduleriders(List<ParamScheduleRiderIn> scheduleriders) {
		this.scheduleriders = scheduleriders;
	}

	


}
