package cn.nova.bus.price.service.impl;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.balance.model.Balancedeductitem;
import cn.nova.bus.balance.model.Balanceformulaitem;
import cn.nova.bus.balance.service.BalancedeductitemService;
import cn.nova.bus.balance.service.impl.BalancedeductitemServiceImpl;
import cn.nova.bus.common.ParamterConst;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.price.dao.TicketpriceformulaitemDao;
import cn.nova.bus.price.model.Formulaitemfixedvalue;
import cn.nova.bus.price.model.Formulaitemformula;
import cn.nova.bus.price.model.Ticketpriceformulaitem;
import cn.nova.bus.price.service.TicketpriceformulaitemService;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;

/**
 * 
 * <p>
 * Title: 票价公式组成项信息服务实现
 * </p>
 * <p>
 * Description:
 * </p>
 * <p>
 * Copyright: Copyright (c) 2011
 * </p>
 * <p>
 * Company: nova
 * </p>
 * 
 * @author lanckun
 * @version 0.1
 */

public class TicketpriceformulaitemServiceImpl implements
		TicketpriceformulaitemService {

	
	private TicketpriceformulaitemDao ticketpriceformulaitemDao = new TicketpriceformulaitemDao();

	
	private BalancedeductitemService balancedeductitemService = new BalancedeductitemServiceImpl();

	@Override
	public List<Map<String, Object>> query(
			List<PropertyFilter> propertyFilterList) {
		return ListUtil.listToMap(new Object[] { Ticketpriceformulaitem.class,
				"username", "orgname" },
				ticketpriceformulaitemDao.query(propertyFilterList),
				new Object[] { Ticketpriceformulaitem.class, String.class,
						String.class });
	}

	@SuppressWarnings("unchecked")
	@Override
	public Ticketpriceformulaitem save(
			Ticketpriceformulaitem ticketpriceformulaitem)
			throws ServiceException {
		if (ticketpriceformulaitemDao
				.checkTicketpriceformulaitem(ticketpriceformulaitem)) {
			throw new ServiceException("0016");
		}

		if ("11".equals(ticketpriceformulaitem.getRelatetype())) {
			if (ticketpriceformulaitemDao
					.checkTicketpriceitem(ticketpriceformulaitem)) {
				throw new ServiceException("0036");
			}
		}
		// 若是票价分项，则加入到扣费项目表中
		if (ticketpriceformulaitem.getIsticketpriceitem()
				&& !ticketpriceformulaitem.getIsfreight()
				&& (!ticketpriceformulaitem.getCode().equals("A")&&!ticketpriceformulaitem.getCode().equals("B")
					&&!ticketpriceformulaitem.getCode().equals("F"))) {
			// 作为固定扣费项进行保存
			Balancedeductitem balancedeductitem = new Balancedeductitem();
			balancedeductitem.setName(ticketpriceformulaitem.getName());
			balancedeductitem.setOrgid(ticketpriceformulaitem.getOrgid());
			Balancedeductitem item = balancedeductitemService
					.qryBalancedeductitem(balancedeductitem);
			if (item == null) {
				balancedeductitem.setCreateby(ticketpriceformulaitem
						.getUpdateby());
				balancedeductitem.setCreatetime(new Date());
				if (ticketpriceformulaitem.getValue() == null) {
					balancedeductitem.setDeductmoney(new BigDecimal(0));
				} else {
					balancedeductitem.setDeductmoney(ticketpriceformulaitem
							.getValue());
				}
				balancedeductitem.setDeducttype("0");// 按人扣费
				balancedeductitem.setDescription("");
				balancedeductitem.setIsactive(true);
				balancedeductitem.setIsaudited(false);
				balancedeductitem.setIsauditpass(false);
				balancedeductitem.setIsdeductbeforebalance(true);
				balancedeductitem.setIsticketpriceitem(true);
				balancedeductitem.setParentid(0);
				balancedeductitem.setUpdateby(ticketpriceformulaitem
						.getUpdateby());
				balancedeductitem.setUpdatetime(new Date());
				balancedeductitemService.saveDeductitem(balancedeductitem);
			} else {
				if (ticketpriceformulaitem.getValue() == null) {
					item.setDeductmoney(new BigDecimal(0));
				} else {
					item.setDeductmoney(ticketpriceformulaitem.getValue());
				}
				item.setIsticketpriceitem(true);
				item.setUpdateby(ticketpriceformulaitem.getUpdateby());
				item.setUpdatetime(new Date());
				balancedeductitemService.saveDeductitem(item);
			}
			// 作为公式扣费项进行保存
			Balanceformulaitem bi = ticketpriceformulaitemDao
					.queryBalanceformulaitem(ticketpriceformulaitem.getName());
			if (bi == null) {
				bi = new Balanceformulaitem();
				bi.setCreateby(ticketpriceformulaitem.getUpdateby());
				bi.setCreatetime(new Date());
				bi.setDescription("");
				bi.setFormulaitemname(ticketpriceformulaitem.getName());
				bi.setIsactive(true);
				bi.setIsticketpriceitem(true);
				bi.setShortname(ticketpriceformulaitem.getCode());
				bi.setUpdateby(ticketpriceformulaitem.getUpdateby());
				bi.setUpdatetime(new Date());
				ticketpriceformulaitemDao.getEntityManager().merge(bi);
			} else {
				bi.setIsticketpriceitem(true);
				bi.setShortname(ticketpriceformulaitem.getCode());
				bi.setUpdateby(ticketpriceformulaitem.getUpdateby());
				bi.setUpdatetime(new Date());
				ticketpriceformulaitemDao.getEntityManager().merge(bi);
			}
		}

		Ticketpriceformulaitem oldticketpriceformulaitem = ticketpriceformulaitemDao
				.isExistTicketpriceformulaitem(ticketpriceformulaitem);

		if (oldticketpriceformulaitem == null) {
			if (ticketpriceformulaitem.getId() == 0) {
				ticketpriceformulaitem.setCreatetime(new Date());
				ticketpriceformulaitem.setUpdatetime(new Date());
				if ("9".equals(ticketpriceformulaitem.getRelatetype())) {
					// 固定值相关
					Formulaitemfixedvalue formulaitemfixedvalue = new Formulaitemfixedvalue();
					formulaitemfixedvalue.setValue(ticketpriceformulaitem
							.getValue());
					formulaitemfixedvalue.setCreateby(ticketpriceformulaitem
							.getCreateby());
					formulaitemfixedvalue.setCreatetime(new Date());
					formulaitemfixedvalue.setUpdateby(ticketpriceformulaitem
							.getCreateby());
					formulaitemfixedvalue.setUpdatetime(new Date());
					ticketpriceformulaitem = ticketpriceformulaitemDao
							.getEntityManager().merge(ticketpriceformulaitem);
					formulaitemfixedvalue
							.setTicketpriceformulaitem(ticketpriceformulaitem);
					ticketpriceformulaitemDao.save(formulaitemfixedvalue);
					return ticketpriceformulaitem;
				} else if ("10".equals(ticketpriceformulaitem.getRelatetype())) {

					Formulaitemformula formulaitemformula = new Formulaitemformula();
					formulaitemformula.setItemformula(ticketpriceformulaitem
							.getItemformula());
					formulaitemformula.setCreateby(ticketpriceformulaitem
							.getCreateby());
					formulaitemformula.setCreatetime(new Date());
					formulaitemformula.setUpdateby(ticketpriceformulaitem
							.getCreateby());
					formulaitemformula.setUpdatetime(new Date());
					ticketpriceformulaitem = ticketpriceformulaitemDao
							.getEntityManager().merge(ticketpriceformulaitem);
					formulaitemformula
							.setTicketpriceformulaitem(ticketpriceformulaitem);
					ticketpriceformulaitemDao.save(formulaitemformula);
					return ticketpriceformulaitem;

				}
				ticketpriceformulaitem = ticketpriceformulaitemDao
						.getEntityManager().merge(ticketpriceformulaitem);
				return ticketpriceformulaitem;

			} else {
				ticketpriceformulaitem.setUpdatetime(new Date());
				ticketpriceformulaitem.setUpdateby(ticketpriceformulaitem
						.getCreateby());
				if ("9".equals(ticketpriceformulaitem.getRelatetype())) {
					// 固定值相关
					Formulaitemfixedvalue formulaitemfixedvalue = ticketpriceformulaitemDao
							.getEntityManager().find(
									Formulaitemfixedvalue.class,
									ticketpriceformulaitem.getId());
					if (formulaitemfixedvalue == null) {
						formulaitemfixedvalue = new Formulaitemfixedvalue();
						formulaitemfixedvalue
								.setCreateby(ticketpriceformulaitem
										.getUpdateby());
						formulaitemfixedvalue.setCreatetime(new Date());
						// formulaitemfixedvalue.setTicketpriceformulaitem(ticketpriceformulaitem);
						formulaitemfixedvalue
								.setUpdateby(ticketpriceformulaitem
										.getUpdateby());
						formulaitemfixedvalue.setUpdatetime(new Date());
						formulaitemfixedvalue.setValue(ticketpriceformulaitem
								.getValue());
					} else {
						formulaitemfixedvalue.setValue(ticketpriceformulaitem
								.getValue());
						formulaitemfixedvalue
								.setUpdateby(ticketpriceformulaitem
										.getCreateby());
						formulaitemfixedvalue.setUpdatetime(new Date());
					}
					ticketpriceformulaitem = ticketpriceformulaitemDao
							.getEntityManager().merge(ticketpriceformulaitem);
					formulaitemfixedvalue
							.setTicketpriceformulaitem(ticketpriceformulaitem);
					ticketpriceformulaitemDao.save(formulaitemfixedvalue);
					return ticketpriceformulaitem;
				} else if ("10".equals(ticketpriceformulaitem.getRelatetype())) {
					// 表达式相关
					Formulaitemformula formulaitemformula = ticketpriceformulaitemDao
							.getEntityManager().find(Formulaitemformula.class,
									ticketpriceformulaitem.getId());
					if (formulaitemformula == null) {
						formulaitemformula = new Formulaitemformula();
						formulaitemformula.setCreateby(ticketpriceformulaitem
								.getCreateby());
						formulaitemformula
								.setItemformula(ticketpriceformulaitem
										.getItemformula());
						formulaitemformula.setCreatetime(new Date());
						formulaitemformula.setUpdateby(ticketpriceformulaitem
								.getCreateby());
						formulaitemformula.setUpdatetime(new Date());
						ticketpriceformulaitem = ticketpriceformulaitemDao
								.getEntityManager().merge(
										ticketpriceformulaitem);
						formulaitemformula
								.setTicketpriceformulaitem(ticketpriceformulaitem);
						ticketpriceformulaitemDao.save(formulaitemformula);
						return ticketpriceformulaitem;

					} else {
						formulaitemformula
								.setItemformula(ticketpriceformulaitem
										.getItemformula());
						formulaitemformula.setUpdateby(ticketpriceformulaitem
								.getCreateby());
						formulaitemformula.setUpdatetime(new Date());
						ticketpriceformulaitemDao.update(formulaitemformula);
						ticketpriceformulaitemDao
								.update(ticketpriceformulaitem);
						return ticketpriceformulaitem;
					}
				} else {
					ticketpriceformulaitem = ticketpriceformulaitemDao
							.getEntityManager().merge(ticketpriceformulaitem);
					return ticketpriceformulaitem;
				}
			}
		} else {
			oldticketpriceformulaitem.setCreateby(ticketpriceformulaitem
					.getCreateby());
			oldticketpriceformulaitem.setCreatetime(new Date());
			oldticketpriceformulaitem.setIsactive(true);
			oldticketpriceformulaitem.setIsautoadjust(ticketpriceformulaitem
					.getIsautoadjust());
			oldticketpriceformulaitem.setIsdefault(ticketpriceformulaitem
					.getIsdefault());
			oldticketpriceformulaitem
					.setIsticketpriceitem(ticketpriceformulaitem
							.getIsticketpriceitem());
			oldticketpriceformulaitem.setName(ticketpriceformulaitem.getName());
			oldticketpriceformulaitem.setRelatetype(ticketpriceformulaitem
					.getRelatetype());
			oldticketpriceformulaitem.setIsfreight(ticketpriceformulaitem
					.getIsfreight());
			oldticketpriceformulaitem.setUpdateby(ticketpriceformulaitem
					.getCreateby());
			oldticketpriceformulaitem.setUpdatetime(new Date());
			oldticketpriceformulaitem = ticketpriceformulaitemDao
					.getEntityManager().merge(oldticketpriceformulaitem);
			return oldticketpriceformulaitem;
		}
	}

	@SuppressWarnings("unchecked")
	@Override
	public boolean delete(long id, long userid) throws ServiceException {
		Ticketpriceformulaitem ticketpriceformulaitem = ticketpriceformulaitemDao
				.getEntityManager().find(Ticketpriceformulaitem.class, id);
		if (ticketpriceformulaitemDao
				.isExistformulaitemDetail(ticketpriceformulaitem)) {
			throw new ServiceException("0027");
		}
		if (ticketpriceformulaitemDao.isExistStandardPriceItem(id)) {
			// '该票价组成项已经生成了公式票价分项，不允许删除！
			throw new ServiceException("0321");
		}
		if (ticketpriceformulaitemDao.isExistFormalitem(
				ticketpriceformulaitem.getOrgid(),
				ticketpriceformulaitem.getCode())) {
			// 票价公式中包含该票价分项，不允许删除！
			throw new ServiceException("0322");
		}
		// 逻辑删除固定扣费项目
		Balancedeductitem bi = ticketpriceformulaitemDao
				.queryBalancedeductitem(ticketpriceformulaitem.getName(),
						ticketpriceformulaitem.getOrgid());
		bi.setIsactive(false);
		bi.setUpdateby(userid);
		bi.setUpdatetime(new Date());
		ticketpriceformulaitemDao.merge(bi);
		// 逻辑删除公式扣费组成项目
		Balanceformulaitem bf = ticketpriceformulaitemDao
				.queryBalanceformulaitem(ticketpriceformulaitem.getName());
		bf.setIsactive(false);
		bf.setUpdateby(userid);
		bf.setUpdatetime(new Date());
		ticketpriceformulaitemDao.merge(bf);
		ticketpriceformulaitem.setIsactive(false);
		ticketpriceformulaitem.setUpdateby(userid);
		ticketpriceformulaitem.setUpdatetime(new Timestamp(System
				.currentTimeMillis()));
		ticketpriceformulaitemDao.merge(ticketpriceformulaitem);
		return true;
	}

	/*
	 * @SuppressWarnings("unchecked")
	 * 
	 * @Override public BigDecimal getFormulaitemfee(BigDecimal fullprice, long
	 * orgid, long scheduleid, long departstationid, long reachstationid, int
	 * distance, String formulaname) {
	 * 
	 * Ticketpriceformulaitem tpitem = ticketpriceformulaitemDao
	 * .queryFormulaitem(formulaname, orgid); BigDecimal itemfee = new
	 * BigDecimal(0); if (tpitem == null) { return itemfee; } if
	 * (tpitem.getRelatetype().equals("7")) { // 票价区间相关 Formulaitemprice fp =
	 * ticketpriceformulaitemDao .queryFormulaitemprice(tpitem.getId(),
	 * fullprice); if (fp != null) { itemfee = fp.getValue(); } } else if
	 * (tpitem.getRelatetype().equals("8")) { // 公里区间相关 Formulaitemdistance fd =
	 * ticketpriceformulaitemDao .queryFormulaitemdistance(tpitem.getId(),
	 * distance); if (fd != null) { itemfee = fd.getValue(); } } else if
	 * (tpitem.getRelatetype().equals("10")) { try { Schedule schedule =
	 * (Schedule) ticketpriceformulaitemDao.get( Schedule.class, scheduleid); //
	 * 表达式相关 String itemformula = ticketpriceformulaDao
	 * .qryAboutFormulaitemformula(tpitem);
	 * 
	 * String value = explainFormulaitem(orgid, 0, schedule.getRoute() .getId(),
	 * schedule.getId(), departstationid, reachstationid, distance,
	 * itemformula); itemfee = new
	 * BigDecimal(ExpressionEvaluator.evaluate(value) .toString()); } catch
	 * (ServiceException e) { play.Logger.error(e.getMessage(), e); }
	 * 
	 * } return itemfee; }
	 * 
	 * private String explainFormulaitem(Long orgid, long vehicletypeid, long
	 * routeid, long scheduleid, long departstationid, long reachstationid, int
	 * distance, String formula) throws ServiceException { String tempformula =
	 * ""; int pos = 0; String value = ""; char item; while (pos <
	 * formula.length()) { item = formula.charAt(pos); pos++; if
	 * (ConstDefiniens.ITEM.indexOf(item) >= 0) { Ticketpriceformulaitem
	 * ticketpriceformulaitem = ticketpriceformulaDao .qryformulaitem(orgid,
	 * item); if (ticketpriceformulaitem == null) { throw new
	 * ServiceException("0047"); } if (item == 'A') { value =
	 * String.valueOf(distance); } else if
	 * (ticketpriceformulaitem.getRelatetype().equals("0")) { value =
	 * ticketpriceformulaDao.qryAboutVehicletypeValue( ticketpriceformulaitem,
	 * vehicletypeid).toString(); } else if
	 * (ticketpriceformulaitem.getRelatetype().equals("1")) { value =
	 * ticketpriceformulaDao.qryAboutRoadgradeValue( ticketpriceformulaitem,
	 * routeid, departstationid, reachstationid).toString(); } else if
	 * (ticketpriceformulaitem.getRelatetype().equals("2")) { value =
	 * ticketpriceformulaDao.qryVehicletypeRoadValue( ticketpriceformulaitem,
	 * vehicletypeid, routeid, departstationid, reachstationid).toString(); }
	 * else if (ticketpriceformulaitem.getRelatetype().equals("3")) { value =
	 * ticketpriceformulaDao.qryStationgradeValue( ticketpriceformulaitem,
	 * orgid).toString(); } else if
	 * (ticketpriceformulaitem.getRelatetype().equals("4")) { value =
	 * ticketpriceformulaDao.qryAboutScheduleValue( ticketpriceformulaitem,
	 * scheduleid).toString(); } else if
	 * (ticketpriceformulaitem.getRelatetype().equals("5")) { value =
	 * ticketpriceformulaDao.qryAboutRouteValue( ticketpriceformulaitem,
	 * routeid).toString(); } else if
	 * (ticketpriceformulaitem.getRelatetype().equals("6")) { value =
	 * ticketpriceformulaDao.qryAboutRoutestopValue( ticketpriceformulaitem,
	 * routeid, reachstationid) .toString(); } else if
	 * (ticketpriceformulaitem.getRelatetype().equals("7")) { // 票价区间相关,后面处理
	 * value = String.valueOf(item); } else if
	 * (ticketpriceformulaitem.getRelatetype().equals("8")) { // 公里区间相关 value =
	 * ticketpriceformulaDao.qryAboutDistanceValue( ticketpriceformulaitem,
	 * routeid, departstationid, reachstationid).toString(); } else if
	 * (ticketpriceformulaitem.getRelatetype().equals("9")) { // 固定值相关 value =
	 * ticketpriceformulaDao.qryAboutFixValue(
	 * ticketpriceformulaitem).toString(); } else if
	 * (ticketpriceformulaitem.getRelatetype().equals("10")) { // 表达式相关 String
	 * itemformula = ticketpriceformulaDao
	 * .qryAboutFormulaitemformula(ticketpriceformulaitem); value =
	 * explainFormulaitem(orgid, vehicletypeid, routeid, scheduleid,
	 * departstationid, reachstationid, distance, itemformula); } if
	 * (ticketpriceformulaitem.getIsticketpriceitem() &&
	 * !ticketpriceformulaitem.getRelatetype().equals("7")) { BigDecimal price =
	 * new BigDecimal(0); try { price = new
	 * BigDecimal(ExpressionEvaluator.evaluate( value).toString()); //
	 * 暂时票价分项四舍五入取整 // price = new BigDecimal(price.intValue()).setScale(1, //
	 * BigDecimal.ROUND_UP); } catch (IllegalArgumentException ex) {
	 * play.Logger.error(ex.getMessage(), ex); throw new ServiceException("0049");
	 * 
	 * } // ticketpriceformulaitem.setValue(price); //
	 * ticketpriceformulaitemlist.add(ticketpriceformulaitem); value =
	 * price.toString(); } tempformula = tempformula + value; } else {
	 * tempformula = tempformula + String.valueOf(item); } } return tempformula;
	 * }
	 */
}
