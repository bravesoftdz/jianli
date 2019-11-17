/**
 * 
 */
package cn.nova.bus.sale.remote.param;


/**
 * @author ice
 * 锁位结果类 单条记录
 */
public class ParamLockseatOut extends ParamLockseatIn {

	private static final long serialVersionUID = 7540690067245217179L;
	private String seattypename;//座位类型名称 
	private String tickettypename;//价格类型名称 
	
	public ParamLockseatOut clone() throws CloneNotSupportedException{
		return (ParamLockseatOut)super.clone();
	}
	
	/**
	 * @return the seattypename
	 */
	public String getSeattypename() {
		return seattypename;
	}
	/**
	 * @param seattypename the seattypename to set
	 */
	public void setSeattypename(String seattypename) {
		this.seattypename = seattypename;
	}
	/**
	 * @return the pricetypename
	 */
	public String getTickettypename() {
		return tickettypename;
	}
	/**
	 * @param tickettypename the pricetypename to set
	 */
	public void setTickettypename(String tickettypename) {
		this.tickettypename = tickettypename;
	}
}
