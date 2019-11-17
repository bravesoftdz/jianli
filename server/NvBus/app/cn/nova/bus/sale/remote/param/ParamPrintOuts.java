package cn.nova.bus.sale.remote.param;

import java.util.List;

import cn.nova.utils.commons.MethodResult;

public class ParamPrintOuts extends MethodResult{
	/**
	 * 
	 */
	private static final long serialVersionUID = 4921467335746642020L;
	private List<ParamPrintOut> paramPrintOuts;

	public List<ParamPrintOut> getParamPrintOuts() {
		return paramPrintOuts;
	}

	public void setParamPrintOuts(List<ParamPrintOut> paramPrintOuts) {
		this.paramPrintOuts = paramPrintOuts;
	}
}
