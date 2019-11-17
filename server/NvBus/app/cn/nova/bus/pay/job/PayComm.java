package cn.nova.bus.pay.job;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.persistence.Query;

import cn.nova.bus.common.ParamterConst;
import cn.nova.bus.job.model.Jobconfig;
import cn.nova.bus.pay.dao.PubEPayServiceDao;
import cn.nova.bus.pay.model.Paystationway;
import cn.nova.bus.pay.param.BusParamEPaymentInfo;
import cn.nova.bus.pay.param.ParamScheduleRiderIn;
import cn.nova.bus.pay.service.TicketEpayFlyingpigCMBCService;
import cn.nova.bus.pay.service.impl.TicketCommEPayServiceImpl;
import cn.nova.bus.pay.service.impl.TicketEpayFlyingpigCMBCImpl;
import cn.nova.bus.sale.model.Payinfo;
import cn.nova.bus.security.Global;
import cn.nova.utils.commons.MethodResult;
import cn.nova.utils.commons.TicketOrder;
import play.db.jpa.JPA;
import play.jobs.Every;
import play.jobs.Job;
import util.BusJobUtil;
import util.CurrentUtil;

public class PayComm extends Job {
	
	private BusParamEPaymentInfo paraminfo;
	
	private List<ParamScheduleRiderIn> scheduleriders;
	
	private Global global;
	
	public PayComm(BusParamEPaymentInfo paraminfo,List<ParamScheduleRiderIn> scheduleriders,Global global ) {
		super();
		this.paraminfo = paraminfo;
		this.scheduleriders=scheduleriders;
		this.global =global;
		
	}
	@Override
	public void doJob() {
		TicketCommEPayServiceImpl ser = new TicketCommEPayServiceImpl();
		BusParamEPaymentInfo paraminfook = ser.converterParam(paraminfo, scheduleriders,global);
		MethodResult result = ser.ePaymentComm(paraminfook);
		ser.savepayorder(paraminfo.getOrderno(),result.getResultMsg());
		play.Logger.info("订单号 : "+paraminfo.getOrderno()+result.getResultMsg());
	}
}
