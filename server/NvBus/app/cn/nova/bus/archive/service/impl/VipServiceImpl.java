/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b>cn.nova.bus.archive.service.impl<br/>
 * <b>文件名：</b>VipServiceImpl.java<br/>
 * <b>版本信息：</b>0.1<br/>
 * <b>日期：</b> 2011-7-20 下午04:34:05 <br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.archive.service.impl;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.archive.dao.VipDao;
import cn.nova.bus.archive.model.Vip;
import cn.nova.bus.archive.model.Vipcardreturn;
import cn.nova.bus.archive.service.VipService;
import cn.nova.bus.base.dao.CardissueDao;
import cn.nova.bus.base.model.Cardissue;
import cn.nova.bus.security.Global;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;

/**
 * <b>类描述：</b><br/>
 * <b>类名称：</b>VipServiceImpl.java<br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2011-7-20 下午04:34:05 <br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
@SuppressWarnings("unchecked")
public class VipServiceImpl implements VipService {

	
	private VipDao vipdao = new VipDao();
	
	private CardissueDao issueDao = new CardissueDao();

	@Override
	public boolean save(Vip vip) {
		if (vip.getCustomerid() > 0) {
			return vipdao.save(vip);
		} else {
			return vipdao.update(vip);
		}
	}

	@Override
	public Vip findById(Long customerid, String status) {
		return (Vip) vipdao.getByCustomerid(customerid, status);
	}

	/**
	 * 按VIP卡号获取VIP卡信息
	 * 
	 * @param cardno
	 * @return
	 */
	public Vip findByCardNo(String cardno, String status) {
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		propertyFilters.add(new PropertyFilter("EQS_t!vipcardno", cardno));
		propertyFilters.add(new PropertyFilter("EQS_t!status", status));
		return (Vip) vipdao.uniqueResult(Vip.class, propertyFilters);
	}

	/**
	 * 按顾客ID获取VIP卡信息
	 * 
	 * @param cardno
	 * @return
	 */
	public Vip findByCustomerID(long customerid, String status) {
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		propertyFilters.add(new PropertyFilter("EQL_t!customerid", customerid));
		propertyFilters.add(new PropertyFilter("EQS_t!status", status));
		return (Vip) vipdao.uniqueResult(Vip.class, propertyFilters);
	}

	/**
	 * 退卡时用来获取顾客信息及VIP信息
	 */
	@Override
	public List<Map<String, Object>> getVipByCardno(
			List<PropertyFilter> propertyFilterList) {
		return ListUtil.listToMap(new Object[] { "name", "id", "vipcardno",
				"amount", "money", "cardcost" },
				vipdao.queryVipBycardno(propertyFilterList), new Object[] {
						String.class, Long.class, String.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class });
	}

	/*
	 * (non-Javadoc) 退卡
	 * 
	 * @see
	 * cn.nova.bus.archive.service.VipService#saveVipreturn(cn.nova.bus.archive
	 * .model.Vip, cn.nova.bus.security.Global)
	 */
	@Override
	public Long saveVipreturn(Vipcardreturn vipreturn, Global global) {
		if (vipreturn.getId() == 0) {
			vipreturn.setCreateby(global.getUserinfo().getId());
			vipreturn.setCreatetime(new Date());
			vipreturn.setUpdateby(global.getUserinfo().getId());
			vipreturn.setUpdatetime(new Date());
			vipreturn.setReturnby(global.getUserinfo().getId());
			vipreturn.setReturntime(new Date());
			vipreturn.setIsturnover(false);
			vipreturn.setTurnoverid(new Long(0)); //vip缴款id
			vipdao.merge(vipreturn);
			Vip vip = (Vip) vipdao.get(Vip.class, vipreturn.getVipid());// 查询出该VIP的信息，将状态改为已退
			vip.setStatus("1");
			BigDecimal value = new BigDecimal(0);
			vip.setMoney(value);
			vip.setVipamount(value);
			vip.setUpdateby(global.getUserinfo().getId());
			vip.setUpdatetime(new Date());
			vipdao.merge(vip);
			Cardissue cardissue = (Cardissue) issueDao.get(Cardissue.class,
					issueDao.getidByCardno(vip.getVipcardno(), "3", "0"));
			cardissue.setStatus("1");
			cardissue.setUpdateby(global.getUserinfo().getId());
			cardissue.setUpdatetime(new Date());
			issueDao.merge(cardissue);
			return cardissue.getId();
		} else {
			return (long) 0;
		}
	}

	/*
	 * (non-Javadoc) VIP卡补卡后新卡的明细查询
	 * 
	 * @see
	 * cn.nova.bus.archive.service.VipService#queryVipremainmoneytransfer(java
	 * .util.List)
	 */
	@Override
	public List<Map<String, Object>> queryVipremainmoneytransfer(
			List<PropertyFilter> propertyFilterList) {
		return ListUtil.listToMap(new Object[] { "money", "vipamount",
				"vipcardno", "newcardno", "createname", "updatename",
				"createtime", "updatetime" },
				vipdao.queryVipremainmoneytransfer(propertyFilterList),
				new Object[] { BigDecimal.class, BigDecimal.class,
						String.class, String.class, String.class, String.class,
						Timestamp.class, Timestamp.class });
	}
}
