/**
 * 
 */
package cn.nova.bus.sale.remote.param;

import java.math.BigDecimal;

/**
 * @author ice
 * 退票输出参数类 单条记录
 */
public class ParamReturnTicketOut extends ParamCancelTicketOut {

	private static final long serialVersionUID = 9031086388620565767L;
	private BigDecimal charge;//退票手续费		
	
	/**
	 * @return the charge
	 */
	public BigDecimal getCharge() {
		return charge;
	}
	/**
	 * @param charge the charge to set
	 */
	public void setCharge(BigDecimal charge) {
		this.charge = charge;
	}
	
}
