package cn.nova.bus.archive.service.impl;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.archive.dao.RechargepromotionDao;
import cn.nova.bus.archive.model.Rechargeactivitydetail;
import cn.nova.bus.archive.model.Rechargepromotionactivity;
import cn.nova.bus.archive.service.RechargepromotionService;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.exception.ServiceException;
import cn.nova.utils.orm.jpa.IDAO;
import cn.nova.utils.orm.jpa.ListUtil;


public class RechargepromotionServiceImpl implements RechargepromotionService {
	
	private IDAO<Rechargepromotionactivity> dao = new EntityManagerDaoSurport<Rechargepromotionactivity>();
	
	private IDAO<Rechargeactivitydetail> detaildao = new EntityManagerDaoSurport<Rechargeactivitydetail>();
	
	private RechargepromotionDao rechargepromotiondao = new RechargepromotionDao();

	/**
	 * 保存充值优惠活动主表
	 */
	@Override
	public Rechargepromotionactivity saveRechargepromotion(
			Rechargepromotionactivity rechargepromotion, String vipgrade)
			throws ServiceException {
		Rechargepromotionactivity exitRechargepromotionname = rechargepromotiondao
				.existrechargepromotion(rechargepromotion.getName());
		if (exitRechargepromotionname != null) {
			if (rechargepromotion.getId() == 0
					|| (rechargepromotion.getId() != 0
							&& exitRechargepromotionname.getIsactive() && rechargepromotion
							.getId() != exitRechargepromotionname.getId())) {
				throw new ServiceException("0408");
			} else if (!exitRechargepromotionname.getIsactive()) {
				rechargepromotion.setId(exitRechargepromotionname.getId());
				rechargepromotion.setIsactive(true);
				sevaDetail(exitRechargepromotionname.getId(), vipgrade, true);
				return dao.merge(rechargepromotion);
			}
		}
		boolean isupdate = rechargepromotion.getId() == 0 ? false : true;
		Rechargepromotionactivity newRechargepromotionname = dao
				.merge(rechargepromotion);
		if (newRechargepromotionname != null) {
			sevaDetail(newRechargepromotionname.getId(), vipgrade, isupdate);
		}
		return newRechargepromotionname;
	}

	/**
	 * 保存或修改充值优惠活动明细表
	 * 
	 * @param id
	 * @param vipgrade
	 * @param isupdate
	 * @return
	 */
	public Boolean sevaDetail(long id, String vipgrade, boolean isupdate) {
		Rechargeactivitydetail rechargeactivitydetail = new Rechargeactivitydetail();
		List<Rechargeactivitydetail> detaillist;
		Rechargeactivitydetail olddetail;
		// 如果是修改，先把原先添加的都删除，再重新添加新的。
		if (isupdate) {
			rechargepromotiondao.deldetail(id);
		}
		char[] b = new char[vipgrade.length() - 2];
		// 遍历参与卡类型复选框，逐个保存到rechargeactivitydetail表中
		for (int j = 1; j < vipgrade.length() - 1; j++) {
			b[j - 1] = vipgrade.charAt(j);
		}
		// 将"（A,B,C）"转换成"A,B,C"-->去掉括号,再逐个逐个保存
		String types = new String(b);
		String[] objects = types.split(",");
		for (int i = 0; i < objects.length; i++) {
			String vipgradeid = objects[i];
			rechargeactivitydetail.setVipgrade(vipgradeid);
			rechargeactivitydetail.setRechargepromotionactivityid(id);
			detaildao.merge(rechargeactivitydetail);
		}
		return true;
	}

	@Override
	public Boolean delRechargepromotion(long id) throws ServiceException {
		if (rechargepromotiondao.isExitViprecharge(id)) {
			throw new ServiceException("0410");// 该充值优惠活动已经被会员充值享受过，不能删除!
		}
		Rechargepromotionactivity rechargepromotionactivity = findById(id);
		rechargepromotionactivity.setIsactive(false);
		return dao.merge(rechargepromotionactivity) != null ? true : false;
	}

	public Rechargepromotionactivity findById(long id) {
		return dao.get(Rechargepromotionactivity.class, id);
	}

	@Override
	public List<Map<String, Object>> queryRechargepromotion(Date startdate,
			Date enddate, String vipgrade) {
		Object[] fileds = { "vipgradename", "vipgrade", "id", "name",
				"rechargeamount", "presentvoucher", "presentoncepercard",
				"startdate", "enddate", "remarks", "createtime", "updatetime",
				"createname", "updatename", "createby" };
		Object[] filedtypes = { String.class, String.class, Long.class,
				String.class, BigDecimal.class, BigDecimal.class,
				boolean.class, Date.class, Date.class, String.class,
				Timestamp.class, Timestamp.class, String.class, String.class,
				long.class };
		return ListUtil.listToMap(fileds, rechargepromotiondao
				.queryRechargepromotion(startdate, enddate, vipgrade),
				filedtypes);
	}

	/*
	 * (non-Javadoc) 通过VIP充值金额获取对应的优惠活动
	 * 
	 * @see cn.nova.bus.archive.service.RechargepromotionService#
	 * queryRechargepromotionByMoney(java.math.BigDecimal, java.util.Date)
	 */
	@Override
	public List<Map<String, Object>> queryRechargepromotionByMoney(
			BigDecimal money, Date date, String cardno) {
		List<Rechargepromotionactivity> relist = rechargepromotiondao
				.getRechargepromo(money, date);
		List<Object> list = new ArrayList<Object>();
		for (int i = 0; i < relist.size(); i++) {
			if (relist.get(i).getPresentoncepercard()) {
				if (rechargepromotiondao.getViprecharge(
						relist.get(i).getId(), cardno) == null) {
					list.add(relist.get(i));
					break;
				}
			} else {
				list.add(relist.get(i));
				break;
			}
		}
		return ListUtil.listToMap(
				new Object[] { Rechargepromotionactivity.class }, list,
				new Object[] { Rechargepromotionactivity.class });
	}
}
