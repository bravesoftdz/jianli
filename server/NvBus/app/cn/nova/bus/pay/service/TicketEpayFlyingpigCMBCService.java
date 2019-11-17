package cn.nova.bus.pay.service;

import cn.nova.bus.pay.param.BusParamEPaymentInfo;
import cn.nova.utils.commons.MethodResult;

public interface TicketEpayFlyingpigCMBCService {

	public MethodResult ePaymentVersionTwo(BusParamEPaymentInfo paraminfo);
		
	public MethodResult ePayReturnVersionOneTwo(BusParamEPaymentInfo paraminfo);

	public void bookticketresult(BusParamEPaymentInfo paraminfo);

	public MethodResult queryBookticketresult(BusParamEPaymentInfo paraminfo);

	public MethodResult ePaySpecialReturnVersionOneTwo(BusParamEPaymentInfo paraminfo);

	public MethodResult queryPayresult(BusParamEPaymentInfo paraminfo) throws Exception;

	public void savepayorder(String orderno, String mess);

}
