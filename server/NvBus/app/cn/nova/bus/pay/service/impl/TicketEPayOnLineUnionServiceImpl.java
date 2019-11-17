package cn.nova.bus.pay.service.impl;

import java.math.BigDecimal;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.pay.param.BusParamEPaymentInfo;
import cn.nova.bus.pay.service.TicketEPayOnLineUnionService;
import cn.nova.bus.sale.model.Payinfo;
import cn.nova.bus.sale.service.EPayService;
import cn.nova.bus.sale.service.impl.EPayServiceImpl;
import cn.nova.bus.security.Global;
import cn.nova.utils.commons.MethodResult;
import cn.nova.utils.orm.jpa.IDAO;
import util.CurrentUtil;

public class TicketEPayOnLineUnionServiceImpl implements TicketEPayOnLineUnionService {
	private IDAO dao = new EntityManagerDaoSurport();

	private EPayService epays = new EPayServiceImpl();

	@Override
	public MethodResult ePaymentVersionOne(BusParamEPaymentInfo paraminfo) {

		// 流程微信 获取订单号接口 ----> 支付接口

		MethodResult result = new MethodResult();
		// 校验参数
		// 调用原来的支付接口
		String message = epays.ePay(paraminfo.getPayCode(), paraminfo.getOrderno(),
				paraminfo.getTotalprice().toString(), paraminfo.getPaymethod(), paraminfo.getGlobal(),
				paraminfo.getTickets().toString(), paraminfo.getTicketprice().toString(),
				paraminfo.getInsures().toString(), paraminfo.getInsurefee().toString());

		if ("SUCCESS".equals(message)) {
			result.setResult(MethodResult.SUCCESS);
		} else {
			result.setResult(MethodResult.FAILURE);
			result.setResultMsg(message);
		}
		return result;
	}

	@Override
	public MethodResult ePayReturnVersionOne(BusParamEPaymentInfo paraminfo) {
		MethodResult result = new MethodResult();
		try {
			epays.returnBatchepay(paraminfo.getOrderno(), paraminfo.getRefundmoney().doubleValue(),
					paraminfo.getGlobal(), paraminfo.getTickets().toString(), paraminfo.getTicketprice().toString(),
					paraminfo.getInsures().toString(), paraminfo.getInsurefee().toString());
			result.setResult(MethodResult.SUCCESS);
		} catch (Exception e) {
			result.setResult(MethodResult.FAILURE);
			result.setResultMsg(e.getMessage());
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public MethodResult ePaySpecialReturnVersionOne(BusParamEPaymentInfo paraminfo) {
		MethodResult result = new MethodResult();
		try {
			EPayService ePayService = new EPayServiceImpl();
			Payinfo payInfo = ePayService.findById(paraminfo.getPayinfoid());
			if (payInfo != null) {
				try {
					Payinfo payinfo = new Payinfo();
					payinfo.setInsurefee(paraminfo.getInsurefee());
					payinfo.setInsures(BigDecimal.valueOf(paraminfo.getInsures()));
					payinfo.setTicketprice(paraminfo.getTicketprice());
					payinfo.setTickets(BigDecimal.valueOf(paraminfo.getTickets()));
					ePayService.delPayInfoById(payInfo, paraminfo.getGlobal(), payinfo, paraminfo.getIds());
					result.setResult(MethodResult.SUCCESS);
					result.setResultMsg("退票成功!");
				} catch (ServiceException e) {
					result.setResult(MethodResult.FAILURE);
					result.setResultMsg(e.getMessage());
					e.printStackTrace();
				}
			} else {
				result.setResult(MethodResult.FAILURE);
				result.setResultMsg("不存在支付信息！");
			}
		} catch (Exception e) {
			result.setResult(MethodResult.FAILURE);
			result.setResultMsg(e.getMessage());
			e.printStackTrace();
		}
		return result;
	}

}
