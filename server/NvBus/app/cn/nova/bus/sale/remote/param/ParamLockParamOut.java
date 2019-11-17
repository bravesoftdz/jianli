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
public class ParamLockParamOut extends MethodResult {
	private static final long serialVersionUID = -778480043543388351L;
	private int lockabletime;//可锁定时间
	private int lockablesum;//可锁定数量
	private int preselldays;//预售天数
	private List<String> saleablepricetypecodes;//可售价格类型编码列表
	
	public int getLockabletime() {
		return lockabletime;
	}
	public void setLockabletime(int lockabletime) {
		this.lockabletime = lockabletime;
	}
	public int getLockablesum() {
		return lockablesum;
	}
	public void setLockablesum(int lockablesum) {
		this.lockablesum = lockablesum;
	}
	public int getPreselldays() {
		return preselldays;
	}
	public void setPreselldays(int preselldays) {
		this.preselldays = preselldays;
	}
	public List<String> getSaleablepricetypecodes() {
		return saleablepricetypecodes;
	}
	public void setSaleablepricetypecodes(List<String> saleablepricetypecodes) {
		this.saleablepricetypecodes = saleablepricetypecodes;
	}
}
