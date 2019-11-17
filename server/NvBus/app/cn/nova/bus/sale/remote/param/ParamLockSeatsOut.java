/**
 * 
 */
package cn.nova.bus.sale.remote.param;

import java.util.Date;
import java.util.List;

import cn.nova.utils.commons.MethodResult;

/**
 * @author ice
 * 锁位返回结果类
 */
public class ParamLockSeatsOut extends MethodResult {
	
	private static final long serialVersionUID = -4738546773914454639L;
	private String orderno;//订单号
	private int seatnums;//订单成功锁定座位总数
	private String departtime;//发车时间 eg:20:15
	private Date autounlocktime; //解锁时间
	private List<ParamLockseatOut> lockedseats; //锁定成功座位列表
	
	/**
	 * @return the orderno
	 */
	public String getOrderno() {
		return orderno;
	}
	/**
	 * @param orderno the orderno to set
	 */
	public void setOrderno(String orderno) {
		this.orderno = orderno;
	}
	/**
	 * @return the seatnums
	 */
	public int getSeatnums() {
		return seatnums;
	}
	/**
	 * @param seatnums the seatnums to set
	 */
	public void setSeatnums(int seatnums) {
		this.seatnums = seatnums;
	}
	/**
	 * @return the departtime
	 */
	public String getDeparttime() {
		return departtime;
	}
	/**
	 * @param departtime the departtime to set
	 */
	public void setDeparttime(String departtime) {
		this.departtime = departtime;
	}
	/**
	 * @return the autounlocktime
	 */
	public Date getAutounlocktime() {
		return autounlocktime;
	}
	/**
	 * @param autounlocktime the autounlocktime to set
	 */
	public void setAutounlocktime(Date autounlocktime) {
		this.autounlocktime = autounlocktime;
	}
	/**
	 * @return the lockedseats
	 */
	public List<ParamLockseatOut> getLockedseats() {
		return lockedseats;
	}
	/**
	 * @param lockedseats the lockedseats to set
	 */
	public void setLockedseats(List<ParamLockseatOut> lockedseats) {
		this.lockedseats = lockedseats;
	}
	
	
}
