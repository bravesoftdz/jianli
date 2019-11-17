/**
 * 
 */
package cn.nova.bus.sale.remote.param;

import java.util.List;

import cn.nova.utils.commons.MethodResult;

/**
 * @author ice
 *
 */
public class ParamTicketReturnQrysOut extends MethodResult {
	private static final long serialVersionUID = -909729323496285849L;
	private List<ParamTicketReturnQryOut> paramTicketReturnQryOut;

	public List<ParamTicketReturnQryOut> getParamTicketReturnQryOut() {
		return paramTicketReturnQryOut;
	}

	public void setParamTicketReturnQryOut(List<ParamTicketReturnQryOut> paramTicketReturnQryOut) {
		this.paramTicketReturnQryOut = paramTicketReturnQryOut;
	}

}
