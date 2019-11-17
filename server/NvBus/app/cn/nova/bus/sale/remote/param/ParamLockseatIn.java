/**
 * 
 */
package cn.nova.bus.sale.remote.param;

import java.io.Serializable;
import java.math.BigDecimal;

/**
 * @author ice
 * 锁位输入参数类 单条记录
 */
public class ParamLockseatIn implements Serializable,Cloneable {

	private static final long serialVersionUID = 7197965674868602238L;
	private String seattypecode;//座位类型编码
	private String tickettypecode;//价格类型编码
	private Integer seatno;//座位号 做为输入参数时可为空
	private BigDecimal price;//座位价格
	
	public ParamLockseatIn clone() throws CloneNotSupportedException{
		return (ParamLockseatIn)super.clone();
	}
	
	/**
	 * @return the seattypecode
	 */
	public String getSeattypecode() {
		return seattypecode;
	}
	/**
	 * @param seattypecode the seattypecode to set
	 */
	public void setSeattypecode(String seattypecode) {
		this.seattypecode = seattypecode;
	}
	/**
	 * @return the pricetypecode
	 */
	public String getTickettypecode() {
		return tickettypecode;
	}
	/**
	 * @param tickettypecode the pricetypecode to set
	 */
	public void setTickettypecode(String tickettypecode) {
		this.tickettypecode = tickettypecode;
	}
	/**
	 * @return the seatno
	 */
	public Integer getSeatno() {
		return seatno;
	}
	/**
	 * @param seatno the seatno to set
	 */
	public void setSeatno(Integer seatno) {
		this.seatno = seatno;
	}
	/**
	 * @return the price
	 */
	public BigDecimal getPrice() {
		return price;
	}
	/**
	 * @param price the price to set
	 */
	public void setPrice(BigDecimal price) {
		this.price = price;
	}
}
