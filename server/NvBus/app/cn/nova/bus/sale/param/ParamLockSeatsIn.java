/**
 * 
 */
package cn.nova.bus.sale.param;

import java.util.ArrayList;
import java.util.List;

import cn.nova.bus.sale.remote.param.ParamLockseatIn;

/**
 * @author ice
 * 查找锁位参数类
 */
public class ParamLockSeatsIn extends cn.nova.bus.sale.remote.param.ParamLockSeatsIn {

	private static final long serialVersionUID = -504937804349031440L;
	private long sellOrgId;//调用者机构
	private long sellerId;//用户id 
	private long ticketoutletsid;
	
//	private long departOrgID;//发车机构ID 不允许为空

	private long scheduleplanId; //班次计划id
	
	//用于校验
	private long departStationId;//始发车站id 不允许为空
	private Long reachStationId;//到达车站id
	
	public ParamLockSeatsIn(cn.nova.bus.sale.remote.param.ParamLockSeatsIn paramLockSeatsIn) throws CloneNotSupportedException{
		setOrderno(paramLockSeatsIn.getOrderno());
		setSellway(paramLockSeatsIn.getSellway());
		setSellOrgCode(paramLockSeatsIn.getSellOrgCode());
		setSellIp(paramLockSeatsIn.getSellIp());
		setSellerCode(paramLockSeatsIn.getSellerCode());
		setTicketoutletsCode(paramLockSeatsIn.getTicketoutletsCode());
		setTicketoutletsname(paramLockSeatsIn.getTicketoutletsname());
		setDepartDate(paramLockSeatsIn.getDepartDate());
		setScheduleCode(paramLockSeatsIn.getScheduleCode());
		setScheduleSyncCode(paramLockSeatsIn.getScheduleSyncCode());
		setLocktime(paramLockSeatsIn.getLocktime());
		setSelectSeatStatus(paramLockSeatsIn.getSelectSeatStatus());
		setDepartStationCode(paramLockSeatsIn.getDepartStationCode());
		setReachStationCode(paramLockSeatsIn.getReachStationCode());
		setDeparttime(paramLockSeatsIn.getDeparttime());
		List<ParamLockseatIn> paramLockseatIns = new ArrayList<ParamLockseatIn>();
		for (ParamLockseatIn paramLockseatIn : paramLockSeatsIn.getLockseats()) {
			paramLockseatIns.add(paramLockseatIn.clone());
		}
		setLockseats(paramLockseatIns);
	}

	/**
	 * @return the sellOrgId
	 */
	public long getSellOrgId() {
		return sellOrgId;
	}

	/**
	 * @param sellOrgId the sellOrgId to set
	 */
	public void setSellOrgId(long sellOrgId) {
		this.sellOrgId = sellOrgId;
	}

	/**
	 * @return the sellerId
	 */
	public long getSellerId() {
		return sellerId;
	}

	/**
	 * @param sellerId the sellerId to set
	 */
	public void setSellerId(long sellerId) {
		this.sellerId = sellerId;
	}

	/**
	 * @return the ticketoutletsid
	 */
	public long getTicketoutletsid() {
		return ticketoutletsid;
	}

	/**
	 * @param ticketoutletsid the ticketoutletsid to set
	 */
	public void setTicketoutletsid(long ticketoutletsid) {
		this.ticketoutletsid = ticketoutletsid;
	}

	/**
	 * @return the scheduleplanId
	 */
	public long getScheduleplanId() {
		return scheduleplanId;
	}

	/**
	 * @param scheduleplanId the scheduleplanId to set
	 */
	public void setScheduleplanId(long scheduleplanId) {
		this.scheduleplanId = scheduleplanId;
	}

	/**
	 * @return the departStationId
	 */
	public long getDepartStationId() {
		return departStationId;
	}

	/**
	 * @param departStationId the departStationId to set
	 */
	public void setDepartStationId(long departStationId) {
		this.departStationId = departStationId;
	}

	/**
	 * @return the reachStationId
	 */
	public Long getReachStationId() {
		return reachStationId;
	}

	/**
	 * @param reachStationId the reachStationId to set
	 */
	public void setReachStationId(Long reachStationId) {
		this.reachStationId = reachStationId;
	}

}
