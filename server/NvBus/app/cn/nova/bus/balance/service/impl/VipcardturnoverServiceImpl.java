/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b>cn.nova.bus.balance.service.impl<br/>
 * <b>文件名：</b>VipcardturnoverServiceImpl.java<br/>
 * <b>版本信息：</b>v4.0<br/>
 * <b>日期：</b>2012-12-6 下午02:46:23<br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.balance.service.impl;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.archive.dao.VipDao;
import cn.nova.bus.archive.model.Vip;
import cn.nova.bus.archive.model.Vipcardreturn;
import cn.nova.bus.archive.model.Vipcardturnover;
import cn.nova.bus.archive.model.Viprecharge;
import cn.nova.bus.balance.dao.VipcardturnoverDao;
import cn.nova.bus.balance.service.VipcardturnoverService;
import cn.nova.bus.base.dao.ViprechargeDao;
import cn.nova.bus.security.Global;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;

/**
 * <b>类描述：</b><br/>
 * <b>类名称：</b>VipcardturnoverServiceImpl.java<br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2012-12-6 下午02:46:23<br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */

public class VipcardturnoverServiceImpl implements VipcardturnoverService {


	private VipcardturnoverDao turnoverDao = new VipcardturnoverDao();

	private ViprechargeDao rechargeDao = new ViprechargeDao();

	private VipDao vipDao = new VipDao();

	/*
	 * (non-Javadoc)
	 * 已缴款查询
	 * @see
	 * cn.nova.bus.balance.service.VipcardturnoverService#query(java.util.List)
	 */
	@Override
	public List<Map<String, Object>> query(
			List<PropertyFilter> propertyFilterList) {
		return ListUtil.listToMap(new Object[] { "sellname", "createname",
				"updatename", "id", "turnoverdate", "money", "lastlost",
				"lost", "issuenum", "moneypayable", "rechargemoney",
				"returnnum", "returnmoney", "cardcost", "remark", "createtime",
				"updatetime", "rechargecount", "returncardcost" },
				turnoverDao.query(propertyFilterList), new Object[] {
						String.class, String.class, String.class, Long.class,
						Timestamp.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, Long.class, BigDecimal.class,
						BigDecimal.class, Long.class, BigDecimal.class,
						BigDecimal.class, String.class, Timestamp.class,
						Timestamp.class, Long.class, BigDecimal.class });
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * cn.nova.bus.balance.service.VipcardturnoverService#queryTurnover(java
	 * .util.Date, java.util.Date, java.lang.Long)
	 */
	@Override
	public List<Map<String, Object>> queryTurnover(Date startdate,
			Date enddate, Long userid) {
		return ListUtil.listToMap(new Object[] { "choose", "sellid", "name",
				"moneydate", "issuenum", "issuemoney", "rechargenum",
				"rechargemoney", "returnnum", "returnmoney", "cardcose" },
				turnoverDao.queryTurnover(startdate, enddate, userid),
				new Object[] { Boolean.class, Long.class, String.class,
						Timestamp.class, Long.class, BigDecimal.class,
						Long.class, BigDecimal.class, Long.class,
						BigDecimal.class, BigDecimal.class });
	}

	/*
	 * (non-Javadoc) 根据缴款人ID，查出上次缴款的信息
	 * 
	 * @see
	 * cn.nova.bus.balance.service.VipcardturnoverService#queryVipturnover(java
	 * .lang.Long)
	 */
	@Override
	public List<Map<String, Object>> queryVipturnover(Long userid) {
		return ListUtil.listToMap(new Object[] { Vipcardturnover.class },
				turnoverDao.qryVipturnover(userid),
				new Object[] { Vipcardturnover.class });
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * cn.nova.bus.balance.service.VipcardturnoverService#save(cn.nova.bus.archive
	 * .model.Vipcardturnover)
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public Vipcardturnover save(Vipcardturnover vipcardturnover, Global global,
			String moneydate) {
		if (vipcardturnover.getId() <= 0) {
			vipcardturnover.setCreateby(global.getUserinfo().getId());
			vipcardturnover.setUpdateby(global.getUserinfo().getId());
			vipcardturnover.setCreatetime(new Date());
			vipcardturnover.setUpdatetime(new Date());
			vipcardturnover.setTurnoverdate(new Date());
			vipcardturnover = (Vipcardturnover) turnoverDao
					.merge(vipcardturnover);

			String[] str = moneydate.split(",");
			for (int k = 0; k < str.length; k++) {
				SimpleDateFormat spf = new SimpleDateFormat(
						"yyyy-MM-dd HH:mm:ss");
				try {
					Date startdate = spf.parse(str[k].toString() + " 00:00:01");
					Date enddate = spf.parse(str[k].toString() + " 23:59:59");

					List vipList = vipDao.query(startdate, enddate,
							vipcardturnover.getSellerid());
					List rechargeList = rechargeDao.query(startdate, enddate,
							vipcardturnover.getSellerid());
					List returnList = vipDao.queryVipcardreturn(startdate,
							enddate, vipcardturnover.getSellerid());
					if (vipList.size() > 0) {// 给VIP表已缴款的记录插入缴款ID
						for (int i = 0; i < vipList.size(); i++) {
							Vip vip = (Vip) vipList.get(i);
							vip.setIsturnover(true);
							vip.setTurnoverid(vipcardturnover.getId());
							vip.setUpdateby(global.getUserinfo().getId());
							vip.setUpdatetime(new Date());
							vipDao.merge(vip);
						}
					}
					if (rechargeList.size() > 0) {// 给VIP充值表已缴款的记录插入缴款ID
						for (int i = 0; i < rechargeList.size(); i++) {
							Viprecharge recharge = (Viprecharge) rechargeList
									.get(i);
							recharge.setIsturnover(true);
							recharge.setTurnoverid(vipcardturnover.getId());
							recharge.setUpdateby(global.getUserinfo().getId());
							recharge.setUpdatetime(new Date());
							rechargeDao.merge(recharge);
						}
					}
					if (returnList.size() > 0) {// 给VIP退卡表已缴款的记录插入缴款ID
						for (int i = 0; i < returnList.size(); i++) {
							Vipcardreturn cardreturn = (Vipcardreturn) returnList
									.get(i);
							cardreturn.setIsturnover(true);
							cardreturn.setTurnoverid(vipcardturnover.getId());
							cardreturn
									.setUpdateby(global.getUserinfo().getId());
							cardreturn.setUpdatetime(new Date());
							vipDao.merge(cardreturn);
						}
					}
				} catch (ParseException e) {
					play.Logger.error(e.getMessage(), e);
				}
			}
		}
		return vipcardturnover;
	}

}
