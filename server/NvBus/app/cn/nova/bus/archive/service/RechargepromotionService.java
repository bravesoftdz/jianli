package cn.nova.bus.archive.service;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.archive.model.Rechargepromotionactivity;
import cn.nova.bus.exception.ServiceException;

/**
 * 充值优惠活动
 * @author Administrator
 *
 */
public interface RechargepromotionService {

	/**
	 * 添加或修改
	 * @param Employe
	 * @return boolean操作是否成功
	 * @throws ServiceException 
	 */
	public  Rechargepromotionactivity  saveRechargepromotion(Rechargepromotionactivity rechargepromotion,String vipgrade)
	throws ServiceException;
	
	
	/**
	 * 根据ID删除
	 * @param id
	 * @return boolean删除是否成功
	 * @throws ServiceException 
	 */
	public Boolean delRechargepromotion(long id) throws ServiceException;
	
	/**
	 * 查找
	 * @param where
	 * @return  List<Map<String,Object>>
	 */
	public List<Map<String, Object>> queryRechargepromotion(
			Date startdate,Date enddate,String vipgrade);


	/**
	 * 通过VIP充值金额获取对应的优惠活动
	 * @param money
	 * @param date
	 * @return
	 */
	public List<Map<String, Object>> queryRechargepromotionByMoney(
			BigDecimal money, Date date, String cardno);
}
