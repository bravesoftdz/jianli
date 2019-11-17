package cn.nova.bus.base.service;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.archive.model.Vip;
import cn.nova.bus.base.model.Cardissue;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;
import cn.nova.utils.orm.PropertyFilter;

public interface CardissueService {

	public Cardissue save(Cardissue card, String ip, Vip vip) throws ServiceException;

	public boolean delete(Cardissue card);

	public boolean delete(Long id);

	public List<Cardissue> query(Date date);

	public Cardissue getById(Long id);

	public List<Map<String, Object>> query(List<PropertyFilter> propertyFilterList);

	// 通过表名得到它在发卡记录里面的最大ID
	public Long getId(String tablename);

	/**
	 * 挂失补卡
	 * @param cardissue
	 * @param ipAddress
	 * @param vip
	 * @return
	 */
	public Cardissue replaceCard(Cardissue cardissue, String ipAddress, Vip vip) throws ServiceException;

	/**
	 * VIP充值
	 * @param cardno
	 * @param money
	 * @param global
	 * @return
	 */
	public Cardissue saveCardRecharge(String cardno, BigDecimal money,Long activityid,//优惠活动ID
			Global global, BigDecimal balancemoney, BigDecimal amount);

	// 判断发卡对象是否已经发卡
	//public boolean isExist(Long typeid);
	/**
	 * 激活卡有效期，只修改卡的有效期，更新时间,更新人，和卡状态改为正常
	 */
	public Cardissue cardActive(Cardissue card);

}
