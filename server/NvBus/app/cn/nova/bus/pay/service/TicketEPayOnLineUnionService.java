package cn.nova.bus.pay.service;

import cn.nova.bus.pay.param.BusParamEPaymentInfo;
import cn.nova.utils.commons.MethodResult;

public interface TicketEPayOnLineUnionService {

	public	MethodResult ePaymentVersionOne(BusParamEPaymentInfo paraminfo);

	public  MethodResult ePayReturnVersionOne(BusParamEPaymentInfo paraminfo);
	
	public	MethodResult ePaySpecialReturnVersionOne(BusParamEPaymentInfo paraminfo);
}
