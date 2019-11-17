package cn.nova.bus.balance.service.impl;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.wltea.expression.ExpressionEvaluator;

import cn.nova.bus.balance.dao.BalancedeductDao;
import cn.nova.bus.balance.dao.BalancedeductitemDao;
import cn.nova.bus.balance.model.Balancedeductapply;
import cn.nova.bus.balance.model.Balancedeductapplysell;
import cn.nova.bus.balance.model.Balancedeductdetail;
import cn.nova.bus.balance.model.Balancedeductitem;
import cn.nova.bus.balance.model.Balancedeductitemprice;
import cn.nova.bus.balance.model.Balanceformula;
import cn.nova.bus.balance.model.Balanceformulaapply;
import cn.nova.bus.balance.model.Balanceformulaitem;
import cn.nova.bus.balance.service.BalancedeductService;
import cn.nova.bus.balance.vo.DeductInfo;
import cn.nova.bus.base.model.Schedule;
import cn.nova.bus.base.model.Ticketoutlets;
import cn.nova.bus.base.model.Unit;
import cn.nova.bus.base.model.Vehicle;
import cn.nova.bus.checkticket.model.Departinvoices;
import cn.nova.bus.checkticket.model.Departinvoicesdeductdetail;
import cn.nova.bus.checkticket.model.Departinvoicesdetail;
import cn.nova.bus.common.ConstDefiniens;
import cn.nova.bus.common.ParamterConst;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.price.dao.RoutePriceDao;
import cn.nova.bus.price.model.Fuelfeegradeapply;
import cn.nova.bus.price.model.Routeprice;
import cn.nova.bus.price.model.Scheduleplan;
import cn.nova.bus.price.model.Schedulevehiclepeopleplan;
import cn.nova.bus.sale.dao.TicketsellotherDao;
import cn.nova.bus.sale.model.Ticketsell;
import cn.nova.bus.sale.model.Ticketsellother;
import cn.nova.bus.security.Global;
import cn.nova.bus.system.service.ParameterService;
import cn.nova.bus.system.service.impl.ParameterServiceImpl;
import cn.nova.utils.commons.DateUtils;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;


public class BalancedeductServiceImpl implements BalancedeductService {

	
	private BalancedeductDao balancedeductDao = new BalancedeductDao();
	
	private ParameterService parameterService = new ParameterServiceImpl();
	
	private BalancedeductitemDao balancedeductitemDao = new  BalancedeductitemDao();
	
	private RoutePriceDao routePriceDao = new RoutePriceDao();

	@SuppressWarnings("unchecked")
	@Override
	public Departinvoicesdeductdetail getAgentfee(Date departdate,
			Schedule schedule, Vehicle vehicle,
			List<Balanceformulaitem> balanceformulaitems)
			throws ServiceException {
		Departinvoicesdeductdetail dv = new Departinvoicesdeductdetail();
		BigDecimal result = new BigDecimal("0");
		String formula = "";
		// 根级公式
		Balanceformulaapply ba = balancedeductDao.getFormulaapply(departdate,
				vehicle, schedule);
		if (ba == null) {
			return null;
		}
		// 查找子扣费公式
		/*
		 * Balanceformulaapply bfa = balancedeductDao.findChildFormulaapply( ba.getBalanceformulaid(), departdate,
		 * schedule, vehicle); if (bfa != null) { ba = bfa; }
		 */
		Balanceformula bf = (Balanceformula) balancedeductDao.get(
				Balanceformula.class, ba.getBalanceformulaid());
		formula = bf.getFormula();
		for (Balanceformulaitem bi : balanceformulaitems) {
			if (!bi.getShortname().equals("") && bi.getCalValue() != null) {
				formula = formula.replaceAll(bi.getShortname(), bi
						.getCalValue().toString());
			}
		}
		for (int i = 0; i < formula.length(); i++) {
			char item = formula.charAt(i);
			if (ConstDefiniens.ITEM.indexOf(item) > 0) {
				formula = formula.replaceAll(String.valueOf(item), "0");
			}
		}
		try {
			result = new BigDecimal(ExpressionEvaluator.evaluate(formula)
					.toString());
			result = result.divide(new BigDecimal(1), 2,
					BigDecimal.ROUND_HALF_UP);
		} catch (Exception ex) {
			System.out.println("扣费公式计算出现异常：" + formula);
		}
		dv.setBalanceapplyid(ba.getId());
		dv.setBalanceitemid(ba.getBalanceformulaid());
		dv.setDeductmoney(result);
		dv.setDepartdate(departdate);
		dv.setIsdeductbeforebalance(true);
		dv.setParentbalanceitemid(bf.getParentid());
		dv.setScheduleid(schedule.getId());
		dv.setStatus("0");
		dv.setType("1");// 1扣费公式 2固定扣费
		return dv;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Departinvoicesdeductdetail> getOthterfee(Date departdate,
			Schedule schedule, Vehicle vehicle, long ticketnum,
			boolean isdeductbeforebalance) throws ServiceException {
		List<Departinvoicesdeductdetail> departinvoicesdeductdetails = new ArrayList<Departinvoicesdeductdetail>();
		Balancedeductapply bp;
		// 查询其他扣费应用
		List<Balancedeductapply> balancedeductapplys = balancedeductDao
				.findBalancedeductitemapply(schedule.getOrgid(), departdate,
						schedule, vehicle, isdeductbeforebalance);
		for (Balancedeductapply ba : balancedeductapplys) {
			bp = balancedeductDao
					.findChilddeductitemapply(ba.getBalancedeductitemid(),
							departdate, schedule, vehicle.getUnitid(),
							vehicle.getId(), isdeductbeforebalance);
			if (bp == null) {
				bp = ba;
			}
			Departinvoicesdeductdetail dv = new Departinvoicesdeductdetail();
			dv.setBalanceapplyid(bp.getId());
			dv.setBalanceitemid(bp.getBalancedeductitemid());
			Balancedeductitem bi = (Balancedeductitem) balancedeductDao.get(
					Balancedeductitem.class, bp.getBalancedeductitemid());
			// 打单时其他扣费类型必须都为 0为按人扣款
			// 1为按班次扣款,2为按天扣款，3为按月扣款，4为手工输入
			if ("0".equals(bi.getDeducttype())) {
				dv.setDeductmoney(bi.getDeductmoney().multiply(
						new BigDecimal(ticketnum)));
			} else {
				continue;
			}
			dv.setDepartdate(departdate);
			dv.setParentbalanceitemid(bi.getParentid());
			dv.setScheduleid(schedule.getId());
			dv.setIsdeductbeforebalance(true);
			dv.setStatus("0");
			dv.setType("2");// 1扣费公式 2固定扣费
			departinvoicesdeductdetails.add(dv);
		}
		return departinvoicesdeductdetails;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Balancedeductdetail> genOthterfee(Departinvoices departinvoices, long createby,long balanceunitid)
			throws ServiceException {
		//定义一个List来存放扣费项目
		List<Balancedeductdetail> balancedeductdetaillist = new ArrayList<Balancedeductdetail>();
		// 是否取上次的结算扣费
		String gentype = parameterService.findParamValue(ParamterConst.Param_4006,
				departinvoices.getPrintorgid());
		if (gentype.equals(ParamterConst.COMMON_FLAG.FALG_YES)) {
			genBalanceDeductdetail(departinvoices, createby);
		} else {
			Schedule schedule = (Schedule) balancedeductDao.get(Schedule.class,
					departinvoices.getScheduleid());
			Vehicle vehicle = (Vehicle) balancedeductDao.get(Vehicle.class,
					departinvoices.getVehicleid());
			Date departdate = departinvoices.getDepartdate();
			// 开单人数+补录人数
			long ticketnum = departinvoices.getTicketnum()
					+ departinvoices.getSupplyticketnum();
			Balancedeductapply bp;
			// 查询其他扣费应用,
			List<Balancedeductapply> balancedeductapplys = balancedeductDao
					.findBalancedeductitemapply(schedule.getOrgid(),
							departdate, schedule, vehicle, false);
			List<PropertyFilter> filters = new ArrayList<PropertyFilter>();
			//记录扣费项，防止重复
			Map<Long,Long> bimap=new HashMap<Long,Long>();
			for (Balancedeductapply ba : balancedeductapplys) {
				bp = balancedeductDao.findChilddeductitemapply(
						ba.getBalancedeductitemid(), departdate, schedule,
						vehicle.getUnitid(), vehicle.getId(), false);
				if (bp == null) {
					bp = ba;
				}
				// 生成扣费信息

				Balancedeductitem bi = (Balancedeductitem) balancedeductDao
						.get(Balancedeductitem.class,
								bp.getBalancedeductitemid());
				
				//清除重复的扣费项
				if(bimap.containsKey(bi.getId())){
					continue;
				}
				bimap.put(bi.getId(), bi.getId());
				Balancedeductdetail bd = null;
				// 6、手工输入,显示为固定扣费处设置的费用
				if ("6".equals(bi.getDeducttype())) {
					filters.clear();
					filters.add(new PropertyFilter("EQL_t!balanceunitid",
							balanceunitid));
					filters.add(new PropertyFilter("EQL_t!orgid",
							departinvoices.getPrintorgid()));
					filters.add(new PropertyFilter("EQL_t!balancedeductitemid",
							bi.getId()));
					List<Balancedeductdetail> lists = balancedeductDao
							.qryBalanceDeduct(filters);
					if (lists == null || lists.size() == 0) {
						bd = new Balancedeductdetail();
						bd.setBalancedeductitemid(bi.getId());
						bd.setOrgid(departinvoices.getPrintorgid());
						bd.setBalanceunitid(balanceunitid);
						bd.setDeductmoney(bi.getDeductmoney());
						bd.setBalancevehicleid(departinvoices.getVehicleid());
						bd.setDivdedeductmoney(new BigDecimal(0));
						bd.setStatus("0");
						bd.setCreateby(createby);
						bd.setUpdateby(createby);
						bd.setCreatetime(new Date());
						bd.setUpdatetime(new Date());
						balancedeductDao.merge(bd);
						balancedeductDao.getEntityManager().flush();
					}else
					{
						bd = lists.get(0);
						bd.setDeductmoney(bd.getDeductmoney().add(bi.getDeductmoney()));
						bd.setUpdateby(createby);
						bd.setUpdatetime(new Date());
//						balancedeductDao.merge(bd);
//						balancedeductDao.getEntityManager().flush();
						balancedeductdetaillist.add(bd);
					}
				} else if ("2".equals(bi.getDeducttype())) {
					// 2、按车天扣款
					if (balancedeductDao.isDeductedByVehicleDay(departdate,
							bi.getId(), departinvoices.getVehicleid())) {
						continue;
					} else {
						bd=balancedeductDao.qryDeductByVehicleDay(
								bi.getId(), departinvoices.getVehicleid());
						Date fristDay = DateUtils.getFirstDayOfMonth(departdate);
						Date lastDay = DateUtils.getLastDayOfMonth(departdate);
						int days=DateUtils.getIntervalDays(fristDay, lastDay)+1;
						
						if(bd!=null){	
							bd.setDeductmoney(bi.getDeductmoney().multiply(new BigDecimal(days)));
							balancedeductdetaillist.add(bd);
//							balancedeductDao.merge(bd);
//							balancedeductDao.getEntityManager().flush();
						} else {
							bd = new Balancedeductdetail();
							bd.setBalancedeductitemid(bi.getId());
							bd.setOrgid(departinvoices.getPrintorgid());
							bd.setBalancevehicleid(departinvoices
									.getVehicleid());
							bd.setBalanceunitid(departinvoices
									.getBalanceunitid());
							bd.setDeductmoney(bi.getDeductmoney().multiply(new BigDecimal(days)));
							bd.setDivdedeductmoney(new BigDecimal(0));
							bd.setStatus("0");
							bd.setCreateby(createby);
							bd.setUpdateby(createby);
							bd.setCreatetime(new Date());
							bd.setUpdatetime(new Date());
							balancedeductDao.merge(bd);
							balancedeductDao.getEntityManager().flush();
						}
					}
				} else if ("3".equals(bi.getDeducttype())) {
					// 3、按月车扣款
					Date fristDay = DateUtils.getFirstDayOfMonth(departdate);
					Date lastDay = DateUtils.getLastDayOfMonth(departdate);
					if (!balancedeductDao.isDeductByVehicleMonth(fristDay,
							lastDay, bi.getId(), departinvoices.getVehicleid())) {
						filters.clear();
						//按车辆进行查询
						filters.add(new PropertyFilter("EQL_t!balancevehicleid",departinvoices.getVehicleid()));
						filters.add(new PropertyFilter("EQL_t!orgid",
								departinvoices.getPrintorgid()));
						filters.add(new PropertyFilter(
								"EQL_t!balancedeductitemid", bi.getId()));
						List<Balancedeductdetail> lists = balancedeductDao
								.qryBalanceDeduct(filters);
						if (lists == null || lists.size() == 0) {
							bd = new Balancedeductdetail();
							bd.setBalancedeductitemid(bi.getId());
							bd.setOrgid(departinvoices.getPrintorgid());
							bd.setBalancevehicleid(departinvoices
									.getVehicleid());
							bd.setBalanceunitid(departinvoices
									.getBalanceunitid());
							bd.setDeductmoney(bi.getDeductmoney());
							bd.setDivdedeductmoney(new BigDecimal(0));
							bd.setStatus("0");
							bd.setCreateby(createby);
							bd.setUpdateby(createby);
							bd.setCreatetime(new Date());
							bd.setUpdatetime(new Date());
							balancedeductDao.merge(bd);
							balancedeductDao.getEntityManager().flush();
						}
						else
						{
							bd = lists.get(0);
							bd.setDeductmoney(bd.getDeductmoney().add(bi.getDeductmoney()));
							bd.setUpdateby(createby);
							bd.setUpdatetime(new Date());
							balancedeductdetaillist.add(bd);
//							balancedeductDao.merge(bd);
//							balancedeductDao.getEntityManager().flush();
						}
					}
				} else if ("7".equals(bi.getDeducttype())) {
					// 7、按运输单张数扣费
					filters.clear();
					filters.add(new PropertyFilter("EQL_t!balanceunitid",
							balanceunitid));
					filters.add(new PropertyFilter("EQL_t!orgid",
							departinvoices.getPrintorgid()));
					filters.add(new PropertyFilter("EQL_t!balancedeductitemid",
							bi.getId()));
					List<Balancedeductdetail> lists = balancedeductDao
							.qryBalanceDeduct(filters);
					if (lists == null || lists.size() == 0) {
						bd = new Balancedeductdetail();
						bd.setBalancedeductitemid(bi.getId());
						bd.setOrgid(departinvoices.getPrintorgid());
						bd.setBalanceunitid(balanceunitid);
						bd.setDeductmoney(bi.getDeductmoney());
						bd.setDivdedeductmoney(new BigDecimal(0));
						bd.setBalancevehicleid(departinvoices.getVehicleid());
						// bd.setVehicle(vehicle);
						bd.setStatus("0");
						bd.setCreateby(createby);
						bd.setUpdateby(createby);
						bd.setCreatetime(new Date());
						bd.setUpdatetime(new Date());
						balancedeductDao.merge(bd);
						balancedeductDao.getEntityManager().flush();
					}else
					{
						bd = lists.get(0);
						bd.setDeductmoney(bd.getDeductmoney().add(bi.getDeductmoney()));
						bd.setUpdateby(createby);
						bd.setUpdatetime(new Date());
						balancedeductdetaillist.add(bd);
//						balancedeductDao.merge(bd);
//						balancedeductDao.getEntityManager().flush();
					}
				} else if ("0".equals(bi.getDeducttype())) {
					// 0为按人扣款
					filters.clear();
					filters.add(new PropertyFilter("EQL_t!balanceunitid",
							balanceunitid));
					filters.add(new PropertyFilter("EQL_t!orgid",
							departinvoices.getPrintorgid()));
					filters.add(new PropertyFilter("EQL_t!balancedeductitemid",
							bi.getId()));
					List<Balancedeductdetail> lists = balancedeductDao
							.qryBalanceDeduct(filters);
					if (lists == null || lists.size() == 0) {
					bd = new Balancedeductdetail();
					bd.setBalancedeductitemid(bi.getId());
					bd.setOrgid(departinvoices.getPrintorgid());
					bd.setBalanceunitid(balanceunitid);
					
					if(!bi.isIsexpress())//按固定值收费
					{
						bd.setDeductmoney(bi.getDeductmoney().multiply(new BigDecimal(ticketnum)));
					}
					else//按公式收费
					{
						String formula = bi.getFormula();
						BigDecimal formularesult = replaceFormula(formula, departinvoices); 
						bd.setDeductmoney(formularesult);
					}
					/*bd.setDeductmoney(bi.getDeductmoney().multiply(
							new BigDecimal(ticketnum)));*/
					bd.setDivdedeductmoney(new BigDecimal(0));
					bd.setBalancevehicleid(departinvoices.getVehicleid());
					// bd.setVehicle(vehicle);
					bd.setStatus("0");
					bd.setCreateby(createby);
					bd.setUpdateby(createby);
					bd.setCreatetime(new Date());
					bd.setUpdatetime(new Date());
					balancedeductDao.merge(bd);
					balancedeductDao.getEntityManager().flush();
				}else
				{
					bd = lists.get(0);
					
					if(!bi.isIsexpress())//按固定值收费
					{
						bd.setDeductmoney(bd.getDeductmoney().add(bi.getDeductmoney().multiply(new BigDecimal(ticketnum))));
					}
					else//按公式收费
					{
						String formula = bi.getFormula();
						BigDecimal formularesult = replaceFormula(formula, departinvoices); 
						bd.setDeductmoney(bd.getDeductmoney().add(formularesult));
					}
					
					bd.setUpdateby(createby);
					bd.setUpdatetime(new Date());
					balancedeductdetaillist.add(bd);
//					balancedeductDao.merge(bd);
//					balancedeductDao.getEntityManager().flush();
				}
				}
				/*
				 * boolean isapply = false; List<Departinvoicesdeductdetail> olddds = departinvoices
				 * .getDepartinvoicesdeductdetails(); for (Departinvoicesdeductdetail dd : olddds) { if
				 * (dd.getBalanceitemid() == bi.getId() && dd.getBalanceapplyid() == bp.getId()) { isapply = true;
				 * break; } } // 若还没生成该扣费项目 if (!isapply) { Departinvoicesdeductdetail dv = new
				 * Departinvoicesdeductdetail(); dv.setBalanceapplyid(bp.getId());
				 * dv.setBalanceitemid(bp.getBalancedeductitemid()); // 打单时其他扣费类型必须都为 0为按人扣款 //
				 * 1、按班次扣款，2、按车天扣款，3、按月车扣款，4、按运输单位天，5、按运输单位月，6、手工输入 if ("0".equals(bi.getDeducttype())) {
				 * dv.setDeductmoney(bi.getDeductmoney().multiply( new BigDecimal(ticketnum))); } else if
				 * ("1".equals(bi.getDeducttype())) { // 1为按班次扣款, if (balancedeductDao.isDeductitemBySchedule(
				 * departinvoices.getReportid(), bi.getId())) { continue; } else {
				 * dv.setDeductmoney(bi.getDeductmoney()); } } else if ("2".equals(bi.getDeducttype())) { // 2、按车天扣款 if
				 * (balancedeductDao.isDeductitemByVehicleDay(departdate, bi.getId(), departinvoices.getVehicleid())) {
				 * continue; } else { dv.setDeductmoney(bi.getDeductmoney()); } } else if
				 * ("3".equals(bi.getDeducttype())) { continue; // 3、按月车扣款
				 * 
				 * //Date fristDay = DateUtils.getFirstDayOfMonth(departdate); // Date lastDay =
				 * DateUtils.getLastDayOfMonth(departdate); // if (balancedeductDao.isDeductitemByVehicleMonth(fristDay,
				 * // lastDay, bi.getId(), departinvoices.getVehicleid())) { // continue; } else { //
				 * dv.setDeductmoney(bi.getDeductmoney()); }
				 * 
				 * } else if ("4".equals(bi.getDeducttype())) { // 4、按运输单位天 if
				 * (balancedeductDao.isDeductitemByUnitDay(departdate, bi.getId(), vehicle.getUnitid())) { continue; }
				 * else { dv.setDeductmoney(bi.getDeductmoney()); } } else if ("5".equals(bi.getDeducttype())) { //
				 * 5、按运输单位月 Date fristDay = DateUtils.getFirstDayOfMonth(departdate); Date lastDay =
				 * DateUtils.getLastDayOfMonth(departdate); if (balancedeductDao.isDeductitemByUnitMonth(fristDay,
				 * lastDay, bi.getId(), vehicle.getUnitid())) { continue; } else {
				 * dv.setDeductmoney(bi.getDeductmoney()); } } else if ("7".equals(bi.getDeducttype())) { // 7、按运输单张数扣费
				 * //dv.setDeductmoney(bi.getDeductmoney()); continue; } else {// 6、手工输入,显示为固定扣费处设置的费用 //
				 * dv.setDeductmoney(bi.getDeductmoney()); continue; } dv.setDepartdate(departdate);
				 * dv.setParentbalanceitemid(bi.getParentid()); dv.setScheduleid(schedule.getId());
				 * dv.setIsdeductbeforebalance(false); dv.setDepartinvoices(departinvoices); dv.setStatus("0");
				 * dv.setType("2");// 1扣费公式 2固定扣费 dv.setCreateby(createby); dv.setCreatetime(new Date());
				 * dv.setUpdateby(createby); dv.setUpdatetime(new Date()); balancedeductDao.merge(dv); }
				 */
			}
			}
		return balancedeductdetaillist;
	}

	@SuppressWarnings("unchecked")
	public void genBalanceDeductdetail(Departinvoices departinvoices,
			long createby) throws ServiceException {

		List<PropertyFilter> filters = new ArrayList<PropertyFilter>();
		filters.clear();
		filters.add(new PropertyFilter("EQL_t!orgid", departinvoices
				.getPrintorgid()));
		filters.add(new PropertyFilter("EQL_t!balanceunitid", departinvoices
				.getBalanceunitid()));
		// 当前已生成的扣费信息
		List<Balancedeductdetail> curddlists = balancedeductDao
				.qryBalanceDeduct(filters);
		List<Balancedeductitem> bds = balancedeductDao
				.qryBalancedeductitem(departinvoices.getPrintorgid());
		// 取最近的结算扣费信息
		List<Balancedeductdetail> maxbdlist = balancedeductDao
				.qryMaxBalancedeductdetail(departinvoices.getPrintorgid(),
						departinvoices.getBalanceunitid());
		// 若还没有结算扣费信息
		if (maxbdlist == null || maxbdlist.size() == 0) {
			// 若还没生成扣费信息
			if (curddlists == null || curddlists.size() == 0) {
				Date departdate = departinvoices.getDepartdate();
				for (Balancedeductitem bi : bds) {
					Balancedeductdetail bd = new Balancedeductdetail();
					bd.setBalancedeductitemid(bi.getId());
					bd.setOrgid(departinvoices.getPrintorgid());
					bd.setBalanceunitid(departinvoices.getBalanceunitid());
					bd.setBalancevehicleid(departinvoices.getVehicleid());
					bd.setDeductmoney(bi.getDeductmoney());
					bd.setStatus("0");
					bd.setCreateby(createby);
					bd.setUpdateby(createby);
					bd.setCreatetime(new Date());
					bd.setUpdatetime(new Date());
					if ("3".equals(bi.getDeducttype())) {
						// 3、按月车扣款
						Date fristDay = DateUtils
								.getFirstDayOfMonth(departdate);
						Date lastDay = DateUtils.getLastDayOfMonth(departdate);
						if (!balancedeductDao.isDeductByVehicleMonth(fristDay,
								lastDay, departinvoices.getId(),
								departinvoices.getVehicleid())) {
							bd.setDeductmoney(bi.getDeductmoney());
						}
					}
					bd.setDivdedeductmoney(new BigDecimal(0));
					balancedeductDao.merge(bd);
					balancedeductDao.getEntityManager().flush();
				}
			}

		} else {
			// 若还没生成扣费信息
			if (curddlists == null || curddlists.size() == 0) {
				// 取最近的一次扣费信息来生成
				for (Balancedeductdetail b : maxbdlist) {
					filters.clear();
					filters.add(new PropertyFilter("EQL_t!orgid",
							departinvoices.getPrintorgid()));
					filters.add(new PropertyFilter("EQL_t!balanceunitid",
							departinvoices.getBalanceunitid()));
					filters.add(new PropertyFilter("EQL_t!balancedeductitemid",
							b.getBalancedeductitemid()));
					List<Balancedeductdetail> bdlists = balancedeductDao
							.qryBalanceDeduct(filters);
					if (bdlists == null || bdlists.size() == 0) {
						Balancedeductdetail bd = new Balancedeductdetail();
						bd.setBalancedeductitemid(b.getBalancedeductitemid());
						bd.setOrgid(departinvoices.getPrintorgid());
						bd.setBalanceunitid(departinvoices.getBalanceunitid());
						bd.setDeductmoney(b.getDeductmoney());
						bd.setDivdedeductmoney(b.getDivdedeductmoney());
						bd.setBalancevehicleid(departinvoices.getVehicleid());
						bd.setStatus("0");
						bd.setCreateby(createby);
						bd.setUpdateby(createby);
						bd.setCreatetime(new Date());
						bd.setUpdatetime(new Date());
						balancedeductDao.merge(bd);
						balancedeductDao.getEntityManager().flush();
					}
				}
			} else {
				for (Balancedeductitem b : bds) {
					boolean isexist = false;
					for (Balancedeductdetail bdd : curddlists) {
						if (b.getId() == bdd.getBalancedeductitemid()) {
							isexist = true;
							continue;
						}
					}
					if (!isexist) {
						Balancedeductdetail bd = new Balancedeductdetail();
						bd.setBalancedeductitemid(b.getId());
						bd.setOrgid(departinvoices.getPrintorgid());
						bd.setBalanceunitid(departinvoices.getBalanceunitid());
						bd.setBalancevehicleid(departinvoices.getVehicleid());
						bd.setDeductmoney(b.getDeductmoney());
						bd.setDivdedeductmoney(new BigDecimal(0));
						bd.setStatus("0");
						bd.setCreateby(createby);
						bd.setUpdateby(createby);
						bd.setCreatetime(new Date());
						bd.setUpdatetime(new Date());
						balancedeductDao.merge(bd);
						balancedeductDao.getEntityManager().flush();
					}
				}
			}
		}

	}

	@Override
	public Balancedeductapply getStationservicefeeApp(Date departdate,
			Schedule schedule, Unit unit, long vehicleid) {
		long unitid = 0;
		if (unit != null) {
			unitid = unit.getId();
		}
		// 查询其他扣费应用
		Balancedeductapply balancedeductapply = balancedeductDao
				.getBalancedeductitemapply(schedule.getOrgid(), departdate,
						schedule, unitid, vehicleid, "站务费");
		if (balancedeductapply == null) {
			return null;
		} else {
			Balancedeductapply bp = balancedeductDao.findChilddeductitemapply(
					balancedeductapply.getBalancedeductitemid(), departdate,
					schedule, unitid, vehicleid, true);
			if (bp == null) {
				bp = balancedeductapply;
			}
			return bp;
		}

	}

	@Override
	@SuppressWarnings("unchecked")
	public BigDecimal getStationservicefee(Balancedeductapply bp,
			long distance, BigDecimal price, long orgid) {
		BigDecimal deduct = new BigDecimal(0);
		if (bp == null) {
			return deduct;
		}
		Balancedeductitem bi = (Balancedeductitem) balancedeductDao.get(
				Balancedeductitem.class, bp.getBalancedeductitemid());
		deduct = bi.getDeductmoney();
		return deduct;
	}

	@Override
	public Balancedeductapply getFueladditionfeeApp(Date departdate,
			Schedule schedule, Unit unit, long vehicleid) {
		long unitid = 0;
		if (unit != null) {
			unitid = unit.getId();
		}
		// 查询其他扣费应用
		Balancedeductapply balancedeductapply = balancedeductDao
				.getBalancedeductitemapply(schedule.getOrgid(), departdate,
						schedule, unitid, vehicleid, "燃油费");
		if (balancedeductapply == null) {
			return null;
		} else {
			Balancedeductapply bp = balancedeductDao.findChilddeductitemapply(
					balancedeductapply.getBalancedeductitemid(), departdate,
					schedule, unitid, vehicleid, true);
			if (bp == null) {
				bp = balancedeductapply;
			}
			return bp;
		}
	}

	@SuppressWarnings("unchecked")
	@Override
	public BigDecimal getFueladditionfee(Balancedeductapply bp, long distance,
			BigDecimal price, long orgid) {
		BigDecimal deduct = new BigDecimal(0);
		if (bp == null) {
			return deduct;
		}
		Balancedeductitem bi = (Balancedeductitem) balancedeductDao.get(
				Balancedeductitem.class, bp.getBalancedeductitemid());
		deduct = bi.getDeductmoney();

		return deduct;
	}

	@SuppressWarnings("unchecked")
	@Override
	public Departinvoicesdeductdetail getDeductdetail(
			Balancedeductapply stationfeeapply) {
		Departinvoicesdeductdetail dd = new Departinvoicesdeductdetail();
		Balancedeductapply ba = (Balancedeductapply) balancedeductDao.get(
				Balancedeductapply.class, stationfeeapply.getId());
		Balancedeductitem bi = (Balancedeductitem) balancedeductDao.get(
				Balancedeductitem.class, ba.getBalancedeductitemid());
		dd.setBalanceapplyid(stationfeeapply.getId());
		dd.setBalanceitemid(ba.getBalancedeductitemid());
		dd.setIsdeductbeforebalance(true);
		dd.setParentbalanceitemid(bi.getParentid());
		dd.setStatus("0");
		dd.setType("2");
		return dd;
	}

	@SuppressWarnings("unchecked")
	@Override
	public Departinvoicesdeductdetail getDeductdetail(long stationfeeapplyid) {
		Departinvoicesdeductdetail dd = new Departinvoicesdeductdetail();
		Balancedeductapply ba = (Balancedeductapply) balancedeductDao.get(
				Balancedeductapply.class, stationfeeapplyid);
		Balancedeductitem bi = (Balancedeductitem) balancedeductDao.get(
				Balancedeductitem.class, ba.getBalancedeductitemid());
		dd.setBalanceapplyid(stationfeeapplyid);
		dd.setBalanceitemid(ba.getBalancedeductitemid());
		dd.setIsdeductbeforebalance(true);
		dd.setParentbalanceitemid(bi.getParentid());
		dd.setStatus("0");
		dd.setType("2");
		return dd;
	}

	/*
	 * getOthterfee方法：查询结算时的固定扣费金额,<br/> 除公式扣费、站务费、燃油费等打单时的扣费项目外， 即生成的扣费项目<br/> <br/>
	 * 
	 * @param invoicesids
	 * 
	 * @return
	 * 
	 * @see cn.nova.bus.balance.service.BalancedeductService#getOthterfee(java.lang .String)
	 * 
	 * @exception
	 */
	@Override
	public BigDecimal getOthterfee(String invoicesids) {
		BigDecimal deductmoeny = new BigDecimal(0);
		try {
			deductmoeny = balancedeductDao.qryOthterDeductfee(invoicesids);
		} catch (Exception ex) {
			play.Logger.error(ex.getMessage(), ex);
		}
		return deductmoeny;
	}

	/*
	 * qryBalanceDeduct方法：<br/> <br/>
	 * 
	 * @param balanceid
	 * 
	 * @return
	 * 
	 * @see cn.nova.bus.balance.service.BalancedeductService#qryBalanceDeduct(long)
	 * 
	 * @exception
	 */
	@Override
	public List<Map<String, Object>> qryBalanceDeduct(long balanceid,
			Boolean isdeductbeforebalance) {
		return ListUtil.listToMap(new Object[] { "name", "deductmoney",
				"isticketpriceitem" }, balancedeductDao.qryBalanceDeduct(
				balanceid, isdeductbeforebalance), new Object[] { String.class,
				BigDecimal.class, boolean.class });

	}

	/*
	 * getAllDeductfee方法：<br/> <br/>
	 * 
	 * @param departdate
	 * 
	 * @param schedule
	 * 
	 * @param vehicle
	 * 
	 * @param ticketnum
	 * 
	 * @param isdeductbeforebalance
	 * 
	 * @return
	 * 
	 * @throws ServiceException
	 * 
	 * @see cn.nova.bus.balance.service.BalancedeductService#getAllDeductfee(java .util.Date,
	 * cn.nova.bus.base.model.Schedule, cn.nova.bus.base.model.Vehicle, long, boolean)
	 * 
	 * @exception
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<Departinvoicesdeductdetail> getAllDeductfee(
			Scheduleplan scheduleplan, Vehicle vehicle, String ticketids,
			long ticketnum, boolean isdeductbeforebalance)
			throws ServiceException {
		Date departdate = scheduleplan.getDepartdate();
		Schedule schedule = (Schedule) balancedeductDao.get(Schedule.class,
				scheduleplan.getScheduleid());
		List<Departinvoicesdeductdetail> departinvoicesdeductdetails = new ArrayList<Departinvoicesdeductdetail>();

		List<Balancedeductitem> ditems = balancedeductDao.findBalancedeductite(
				scheduleplan.getOrgid(), departdate, schedule, vehicle,
				isdeductbeforebalance,false);
		Balancedeductapply bp;
		for (Balancedeductitem ditem : ditems) {
			Balancedeductapply ba = balancedeductDao
					.findBalancedeductitemapply(scheduleplan.getOrgid(),
							departdate, schedule, vehicle,
							isdeductbeforebalance, ditem.getId());
			if (ba == null) {
				continue;
			}
			bp = balancedeductDao
					.findChilddeductitemapply(ba.getBalancedeductitemid(),
							departdate, schedule, vehicle.getUnitid(),
							vehicle.getId(), isdeductbeforebalance);
			Balancedeductitem bi = null;
			String deductname = "";
			if (bp == null) {
				bp = ba;
				bi = (Balancedeductitem) balancedeductDao.get(
						Balancedeductitem.class, bp.getBalancedeductitemid());
				deductname = bi.getName();
			} else {
				bi = (Balancedeductitem) balancedeductDao.get(
						Balancedeductitem.class, bp.getBalancedeductitemid());
				deductname = ditem.getName();
			}
			Departinvoicesdeductdetail dv = new Departinvoicesdeductdetail();
			dv.setBalanceapplyid(bp.getId());
			dv.setBalanceitemid(bp.getBalancedeductitemid());

			// 若是票价组成项目
			if (bi.isIsticketpriceitem()) {
				BigDecimal deductmoney = balancedeductDao.qryTicketDeduct(
						scheduleplan.getId(), ticketids, bi.getName());
				dv.setDeductmoney(deductmoney);
			} else {
				// 打单时其他扣费类型必须都为 0为按人扣款
				// 1为按班次扣款,2为按天扣款，3为按月扣款，4为手工输入
				if ("0".equals(bi.getDeducttype())) {
					dv.setDeductmoney(bi.getDeductmoney().multiply(
							new BigDecimal(ticketnum)));
				} else if ("7".equals(bi.getDeducttype())) {
					// 按运量单张数扣
					dv.setDeductmoney(bi.getDeductmoney());
				} else {
					continue;
				}
			}
			dv.setName(deductname);
			dv.setDepartdate(departdate);
			dv.setParentbalanceitemid(bi.getParentid());
			dv.setScheduleid(schedule.getId());
			dv.setIsdeductbeforebalance(true);
			dv.setStatus("0");
			dv.setType("2");// 1扣费公式 2固定扣费
			departinvoicesdeductdetails.add(dv);

		}

		// 查询所有固定扣费应用
		/*
		 * List<Balancedeductapply> balancedeductapplys = balancedeductDao
		 * .findBalancedeductitemapply(scheduleplan.getOrgid(), departdate, schedule, vehicle, isdeductbeforebalance);
		 * for (Balancedeductapply ba : balancedeductapplys) { bp = balancedeductDao
		 * .findChilddeductitemapply(ba.getBalancedeductitemid(), departdate, schedule, vehicle.getUnitid(),
		 * vehicle.getId(), isdeductbeforebalance); if (bp == null) { bp = ba; } Departinvoicesdeductdetail dv = new
		 * Departinvoicesdeductdetail(); dv.setBalanceapplyid(bp.getId());
		 * dv.setBalanceitemid(bp.getBalancedeductitemid()); Balancedeductitem bi = (Balancedeductitem)
		 * balancedeductDao.get( Balancedeductitem.class, bp.getBalancedeductitemid()); // 若是票价组成项目 if
		 * (bi.isIsticketpriceitem()) { BigDecimal deductmoney = balancedeductDao.qryTicketDeduct( scheduleplan.getId(),
		 * ticketids, bi.getName()); dv.setDeductmoney(deductmoney); } else { // 打单时其他扣费类型必须都为 0为按人扣款 //
		 * 1为按班次扣款,2为按天扣款，3为按月扣款，4为手工输入 if ("0".equals(bi.getDeducttype())) {
		 * dv.setDeductmoney(bi.getDeductmoney().multiply( new BigDecimal(ticketnum))); } else { continue; } }
		 * dv.setName(bi.getName()); dv.setDepartdate(departdate); dv.setParentbalanceitemid(bi.getParentid());
		 * dv.setScheduleid(schedule.getId()); dv.setIsdeductbeforebalance(true); dv.setStatus("0"); dv.setType("2");//
		 * 1扣费公式 2固定扣费 departinvoicesdeductdetails.add(dv); }
		 */
		return departinvoicesdeductdetails;
	}

	@SuppressWarnings("unchecked")
	@Override
	public DeductInfo getDeductfee(Ticketsell ticket) {
		DeductInfo deductInfo = new DeductInfo();
		Schedule schedule = (Schedule) balancedeductDao.get(Schedule.class,
				ticket.getScheduleid());
		try {
			List<Object> list=balancedeductDao.qryPriceItem(ticket,schedule.getOrgid());
			for (Object obj : list) {
				Object[] ob = (Object[]) obj;
				String code = ob[0].toString();
				if (code.equalsIgnoreCase("C")) {
					deductInfo.setStationfee(new BigDecimal(ob[1].toString()));
				} else if (code.equalsIgnoreCase("D")) {
					deductInfo.setAdditionfee(new BigDecimal(ob[1].toString()));
				} else if (code.equalsIgnoreCase("E")) {
					deductInfo.setComputefee(new BigDecimal(ob[1].toString()));
				} else if (code.equalsIgnoreCase("G")) {
					deductInfo.setCoolairfee(new BigDecimal(ob[1].toString()));
				} else if (code.equalsIgnoreCase("K")) {
					deductInfo.setFueladditionfee(new BigDecimal(ob[1].toString()));
				} else if (code.equalsIgnoreCase("H")) {
					deductInfo.setWaterfee(new BigDecimal(ob[1].toString()));
				} else if (code.equalsIgnoreCase("I")) {
					deductInfo.setInsurefee(new BigDecimal(ob[1].toString()));
				}else if (code.equalsIgnoreCase("J")) {
					deductInfo.setOtherfee(new BigDecimal(ob[1].toString()));
				}
			}
			// 燃油费备注
			String isfuadedcut = parameterService.findParamValue("0015",
					schedule.getOrgid());
			// 是否需要把燃油费生成到票价中
			if ("1".equals(isfuadedcut)) {
				Scheduleplan scheduleplan = (Scheduleplan) balancedeductDao.get(
						Scheduleplan.class, ticket.getScheduleplanid());
				Schedulevehiclepeopleplan svp = scheduleplan
						.getSchedulevehiclepeopleplanlist().get(0);
				// 查询是否存在燃油费应用
				List<Fuelfeegradeapply> fuelist = balancedeductDao
						.qryFuelfeegradeapply(ticket.getDepartdate(), schedule
								.getRoute().getId(), svp.getPlanvehicletypeid());
				// 获取燃油费
				if (fuelist != null && fuelist.size() > 0) {
					long fuelfeegradeid = fuelist.get(0).getFuelfeegradeid();
					BigDecimal price = balancedeductDao.qryFuelfeegradedetail(
							fuelfeegradeid, ticket.getDistance());
					deductInfo.setFueladditionfee(price);
				}
			}			
			/*
			// 站务费 C
			deductInfo.setStationfee(balancedeductDao.qryTicketDeduct(ticket,
					"C", schedule.getOrgid()));
			// 附加费D
			deductInfo.setAdditionfee(balancedeductDao.qryTicketDeduct(ticket,
					"D", schedule.getOrgid()));
			// 微机费E
			deductInfo.setComputefee(balancedeductDao.qryTicketDeduct(ticket,
					"E", schedule.getOrgid()));
			// 空调费G
			deductInfo.setCoolairfee(balancedeductDao.qryTicketDeduct(ticket,
					"G", schedule.getOrgid()));
			// 燃油费K
			deductInfo.setFueladditionfee(balancedeductDao.qryTicketDeduct(
					ticket, "K", schedule.getOrgid()));
			// 燃油费备注
			String isfuadedcut = parameterService.findParamValue("0015",
					schedule.getOrgid());
			// 是否需要把燃油费生成到票价中
			if ("1".equals(isfuadedcut)) {
				// 查询是否存在燃油费应用
				List<Fuelfeegradeapply> fuelist = balancedeductDao
						.qryFuelfeegradeapply(ticket.getDepartdate(), schedule
								.getRoute().getId(), svp.getPlanvehicletypeid());
				// 获取燃油费
				if (fuelist != null && fuelist.size() > 0) {
					long fuelfeegradeid = fuelist.get(0).getFuelfeegradeid();
					BigDecimal price = balancedeductDao.qryFuelfeegradedetail(
							fuelfeegradeid, ticket.getDistance());
					deductInfo.setFueladditionfee(price);
				}
			} else {
				// 燃油费K
				deductInfo.setFueladditionfee(balancedeductDao.qryTicketDeduct(
						ticket, "K", schedule.getOrgid()));
			}
			// 配水费H
			deductInfo.setWaterfee(balancedeductDao.qryTicketDeduct(ticket,
					"H", schedule.getOrgid()));
			// 保险费I
			deductInfo.setInsurefee(balancedeductDao.qryTicketDeduct(ticket,
					"I", schedule.getOrgid()));
			// 其他J
			deductInfo.setOtherfee(balancedeductDao.qryTicketDeduct(ticket,
					"J", schedule.getOrgid()));
			*/
		} catch (Exception ex) {
			play.Logger.error(ex.getMessage(), ex);
		}
		return deductInfo;
	}

	@SuppressWarnings("unchecked")
	@Override
	public Departinvoices createDepartinvoices(Scheduleplan scheduleplan,
			Vehicle vehicle, List<Ticketsell> ticketsells, String departtime,
			long createdby,Global global) throws ServiceException {

		long totalpsdistance = 0;// 总 人公里
		boolean isexist = false;
		//无纸质车票张数(包含未取票的电子票,网售票,手持机等)
		boolean isnopaper = false;
		boolean ispaper = false;
		Departinvoices departinvoices = new Departinvoices();
		List<Departinvoicesdetail> departinvoicesdetails = new ArrayList<Departinvoicesdetail>();
		List<Departinvoicesdeductdetail> departinvoicesdeductdetails = new ArrayList<Departinvoicesdeductdetail>();

		Date departdate = scheduleplan.getDepartdate();
		Schedule schedule = (Schedule) balancedeductDao.get(Schedule.class,
				scheduleplan.getScheduleid());

		// 若系统使用了票价差功能，则计算结算票款金额时应减去票价差得金额
		boolean isusemoreprice = false;
		if (ParamterConst.COMMON_FLAG.FALG_YES.equals(parameterService.findParamValue(ParamterConst.Param_5001, global.getOrganization().getId()))) {
			isusemoreprice = true;
		}
		boolean isusebalanceprice = false;
		if (ParamterConst.COMMON_FLAG.FALG_YES.equals(parameterService.findParamValue(ParamterConst.Param_5050, global.getOrganization().getId()))){
			isusebalanceprice = true;
		}
		List<Routeprice> listRouteprice = new ArrayList<Routeprice>();
		if(isusebalanceprice){
		//根据线路ID获取线路票价
		   listRouteprice = routePriceDao.qryRoutePricesForDepartinvoices(schedule.getRoute().getId());
		}
		BigDecimal totalaprice = new BigDecimal(0);// 总票价
		int markbalancepriceT = 0;
		int markbalancepriceH = 0;
		int ticketnumT = 0;
		int ticketnumH = 0;
		if(isusebalanceprice){
			for(Ticketsell ticket : ticketsells){
				if(ticket.getTickettype().equals("T")){
					ticketnumT++;
				}
				if(ticket.getTickettype().equals("H")){
					ticketnumH++;	
				}
			}
		}
		
		int eticketnum = 0;//电子票总票数，包含：电子票取票、未取票总张数
		int handticketnum = 0;//手持机总票数，包含：手持机售票的总张数
		// 生成结算单明细表信息
		for (Ticketsell ticket : ticketsells) {
			
			totalaprice=totalaprice.add(ticket.getPrice());
			isexist = false;
			isnopaper = false;
			ispaper  = false;
			if(!"13".equals(ticket.getSellway())){//手持机的票不算到这两个字段
//			    -- 判断是否是nopaper 
				Ticketsellother other =  new TicketsellotherDao().qryTicketsellotherByTicketsellid(ticket.getId());
				if(other != null){
					if(!other.getIstaked()){
						isnopaper = true;
					}
					if(!"7".equals(ticket.getSellway()) && !"10".equals(ticket.getSellway())){
						eticketnum++;//电子票总票数，包含：窗口电子票取票、未取票总张数
					}
				}
				if(!isnopaper){
					ispaper= true;
				}
			}else{
				handticketnum++;
			}
			BigDecimal moreprice = ticket.getMoreprice();
			BigDecimal curprice = ticket.getPrice();
			if (isusemoreprice) {
				// 若有票价差
				curprice = ticket.getPrice().subtract(ticket.getMoreprice());
			}
			if(isusebalanceprice){
				for(Routeprice rp:listRouteprice){
					if(rp.getFromstationid()==ticket.getDepartstationid() && rp.getReachstationid()==ticket.getReachstationid()){
						if(ticket.getTickettype().equals("T")&&markbalancepriceT==0){
						    curprice = ticket.getPrice().subtract(rp.getPrice().subtract(rp.getBalanceprice()).multiply(new BigDecimal(ticketnumT)));										
						}else if(ticket.getTickettype().equals("H")&&markbalancepriceH == 0){
							curprice = ticket.getPrice().subtract(rp.getPrice().subtract(rp.getBalanceprice()).multiply(new BigDecimal(ticketnumH)));
						}else if(!(ticket.getTickettype().equals("T")||ticket.getTickettype().equals("H"))){
							curprice = ticket.getPrice().subtract(rp.getPrice().subtract(rp.getBalanceprice()));
						}
					}
				}
				if(ticket.getTickettype().equals("T")){
					markbalancepriceT++;
				}
				if(ticket.getTickettype().equals("H")){
					markbalancepriceH++;
				}
			}
						
			for (Departinvoicesdetail dd : departinvoicesdetails) {
				// 起点站、到达站、票种、票价都相等才归一类
				//优惠票、团体票不算票价
				if (dd.getFromstationid() == ticket.getDepartstationid()
						&& dd.getReachstationid() == ticket.getReachstationid()
						&& dd.getTickettype().equals(ticket.getTickettype())
						&& (dd.getPrice().compareTo(curprice) == 0 || ticket.getTickettype().equals("T")|| ticket.getTickettype().equals("H") )
						) {
					totalpsdistance = totalpsdistance + ticket.getDistance();
					dd.setTicketnum(dd.getTicketnum() + 1);
					dd.setTotalamount(dd.getTotalamount().add(curprice));
					dd.setStationservicefee(dd.getStationservicefee().add(
							ticket.getStationservicefee()));
					dd.setFueladditionfee(dd.getFueladditionfee().add(
							ticket.getFueladditionfee()));
					dd.setMoreprice(dd.getMoreprice().add(moreprice));
					if(isnopaper){
						dd.setNopaperticketnum(dd.getNopaperticketnum()+1);
					}
					if(ispaper){
						dd.setPaperticketnum(dd.getPaperticketnum()+1);
					}
					dd.setTicketids(dd.getTicketids() + ticket.getId() + ",");
					isexist = true;
				}
			}
			if (!isexist) {
				Departinvoicesdetail departinvoicesdetail = new Departinvoicesdetail();
				departinvoicesdetail.setTicketids(ticket.getId() + ",");
				departinvoicesdetail.setCreateby(createdby);
				departinvoicesdetail.setCreatetime(new Date());
				departinvoicesdetail.setDepartdate(departdate);
				departinvoicesdetail.setDeparttime(departtime);
				departinvoicesdetail.setDepartinvoices(departinvoices);
				departinvoicesdetail.setDistance(ticket.getDistance());
				totalpsdistance = ticket.getDistance();
				departinvoicesdetail.setFromstationid(ticket
						.getDepartstationid());
				departinvoicesdetail.setPrice(curprice);
				departinvoicesdetail.setTotalamount(curprice);
				departinvoicesdetail.setStationservicefee(ticket
						.getStationservicefee());
				departinvoicesdetail.setFueladditionfee(ticket
						.getFueladditionfee());
				departinvoicesdetail.setOthterfee(new BigDecimal(0));
				departinvoicesdetail.setAgentfee(new BigDecimal(0));
				departinvoicesdetail.setIssupply(false);
				departinvoicesdetail.setReachstationid(ticket
						.getReachstationid());
				departinvoicesdetail.setScheduleid(schedule.getId());
				departinvoicesdetail.setTicketnum(1);
				departinvoicesdetail.setTickettype(ticket.getTickettype());
				departinvoicesdetail.setUpdateby(createdby);
				departinvoicesdetail.setUpdatetime(new Date());
				departinvoicesdetail.setMoreprice(moreprice);
				if(isnopaper){
					departinvoicesdetail.setNopaperticketnum(1);
				}else{
					departinvoicesdetail.setNopaperticketnum(0);
				}
				if(ispaper){
					departinvoicesdetail.setPaperticketnum(1);
				}else{
					departinvoicesdetail.setPaperticketnum(0);
				}
				List<Departinvoicesdeductdetail> ddts = new ArrayList<Departinvoicesdeductdetail>();
				departinvoicesdetail.setDepartinvoicesdeductdetails(ddts);
				departinvoicesdetails.add(departinvoicesdetail);
			}
		}
		//取固定扣费不是表达式的begin
		List<Balancedeductitem> ditems = balancedeductDao.findBalancedeductite(
				scheduleplan.getOrgid(), departdate, schedule, vehicle, true,false);

		Balancedeductapply bp;
		boolean ischilditem;
		BigDecimal paperfee = new BigDecimal(0);// 若有按张数扣的合计到该值
		BigDecimal deductfee = new BigDecimal(0);// 若有按班次扣的合计到该值,并扣客运代理费后再扣该金额
		boolean isexitstationfee = false;
		boolean isexistfulfee = false;
		for (Balancedeductitem ditem : ditems) {
			Balancedeductapply ba = balancedeductDao
					.findBalancedeductitemapply(scheduleplan.getOrgid(),
							departdate, schedule, vehicle, true, ditem.getId());
			if (ba == null) {
				continue;
			}

			bp = balancedeductDao.findChilddeductitemapply(
					ba.getBalancedeductitemid(), departdate, schedule,
					vehicle.getUnitid(), vehicle.getId(), true);
			Balancedeductitem bi = null;
			String deductname = "";
			if (bp == null) {
				bp = ba;
				bi = (Balancedeductitem) balancedeductDao.get(
						Balancedeductitem.class, bp.getBalancedeductitemid());
				deductname = bi.getName();
				ischilditem = false;
			} else {
				bi = (Balancedeductitem) balancedeductDao.get(
						Balancedeductitem.class, bp.getBalancedeductitemid());
				deductname = ditem.getName();
				ischilditem = true;
			}
			Departinvoicesdeductdetail dv = new Departinvoicesdeductdetail();
			dv.setDepartinvoices(departinvoices);
			dv.setCreateby(createdby);
			dv.setCreatetime(new Date());
			dv.setUpdateby(createdby);
			dv.setUpdatetime(new Date());
			dv.setBalanceapplyid(bp.getId());
			dv.setBalanceitemid(bp.getBalancedeductitemid());
			BigDecimal deductmoney = new BigDecimal(0);
			dv.setName(deductname);
			dv.setCode(bi.getCode());
			// 若是票价组成项目
			if (bi.isIsticketpriceitem()) {
				for (Departinvoicesdetail dd : departinvoicesdetails) {
					BigDecimal curdectmoney = new BigDecimal(0);
					Departinvoicesdeductdetail ddt = new Departinvoicesdeductdetail();
					ddt.setName(deductname);
					if (deductname.indexOf("站务费") >= 0) {
						isexitstationfee = true;
						if (ischilditem) {
							dd.setStationservicefee(bi
									.getDeductmoney()
									.multiply(new BigDecimal(dd.getTicketnum())));
							curdectmoney = dd.getStationservicefee();
							deductmoney = deductmoney.add(dd
									.getStationservicefee());
						} else {
							curdectmoney = dd.getStationservicefee();
							deductmoney = deductmoney.add(dd
									.getStationservicefee());
						}
					} else if (deductname.indexOf("燃油费") >= 0) {
						isexistfulfee = true;
						if (ischilditem) {
							dd.setFueladditionfee(bi.getDeductmoney().multiply(
									new BigDecimal(dd.getTicketnum())));
							curdectmoney = dd.getFueladditionfee();
							deductmoney = deductmoney.add(dd
									.getFueladditionfee());
						} else {
							deductmoney = deductmoney.add(dd
									.getFueladditionfee());
							curdectmoney = dd.getFueladditionfee();
						}
					} else {
						if (ischilditem) {
							curdectmoney = (bi.getDeductmoney()
									.multiply(new BigDecimal(dd.getTicketnum())));
						} else {
							//curdectmoney = balancedeductDao.qryTicketDeduct(
							//		scheduleplan.getId(),
							//		trunc(dd.getTicketids()), deductname);
							//扣费改为取售票表的扣费数据，不在票价分项里的也可以
							curdectmoney = balancedeductDao.qryTicketDeduct(trunc(dd.getTicketids()),bi.getCode());
						}
						deductmoney = deductmoney.add(curdectmoney);
						dd.setOthterfee(dd.getOthterfee().add(curdectmoney));
					}
					ddt.setCode(bi.getCode());
					ddt.setDeductmoney(curdectmoney);
					dd.getDepartinvoicesdeductdetails().add(ddt);

				}

			} else {
				// 打单时其他扣费类型必须都为 0为按人扣款
				// 1为按班次扣款,2为按天扣款，3为按月扣款，4为手工输入
				if ("0".equals(bi.getDeducttype())) {
					List<Balancedeductapplysell> bplist=balancedeductitemDao.qryBalancedeductapplysell(ba.getId());
					if(bplist!=null&&bplist.size()>0){
						for(Balancedeductapplysell bs:bplist){
							for (Departinvoicesdetail dd : departinvoicesdetails) {
								int tickets = 0;
								// 按售票点扣费
								for (Ticketsell ticket : ticketsells) {
									if (ticket.getTicketoutletsid() == bs
											.getDataid() && ticket.getTickettype().equals(dd.getTickettype())
										&& ticket.getReachstationid()==dd.getReachstationid()) {
										tickets = tickets + 1;
									}
								}
								BigDecimal curdectmoney = new BigDecimal(0);
								Departinvoicesdeductdetail ddt = new Departinvoicesdeductdetail();
								curdectmoney = bi.getDeductmoney().multiply(
										new BigDecimal(tickets));
								dd.setOthterfee(dd.getOthterfee().add(curdectmoney));
								deductmoney = deductmoney.add(curdectmoney);
								ddt.setName(deductname);
								ddt.setDeductmoney(deductmoney);
								dd.getDepartinvoicesdeductdetails().add(ddt);
							}
						}
					}else{
						for (Departinvoicesdetail dd : departinvoicesdetails) {
							BigDecimal curdectmoney = new BigDecimal(0);
							Departinvoicesdeductdetail ddt = new Departinvoicesdeductdetail();
							curdectmoney = bi.getDeductmoney().multiply(
									new BigDecimal(dd.getTicketnum()));
							dd.setOthterfee(dd.getOthterfee().add(curdectmoney));
							deductmoney = deductmoney.add(curdectmoney);
							ddt.setName(deductname);
							ddt.setDeductmoney(deductmoney);
							dd.getDepartinvoicesdeductdetails().add(ddt);
						}
					}
					
				} else if ((bi.getDeducttype().equals("7"))) {
					deductmoney = bi.getDeductmoney();
					paperfee = paperfee.add(deductmoney);
				}
				// 按班次扣
				else if ((bi.getDeducttype().equals("1"))) {
					deductmoney = bi.getDeductmoney();
					deductfee = deductfee.add(deductmoney);
				} else if ((bi.getDeducttype().equals("8"))) {
					//按票价相关扣款
					
					List<Balancedeductitemprice> blist = balancedeductitemDao.qryBalanceDeductitemdetail(bi.getId());
		            //Map<Long,String> ids=new HashMap<Long,String>();
					//按售票点进行扣费
					List<Balancedeductapplysell> bplist=balancedeductitemDao.qryBalancedeductapplysell(ba.getId());
					if(bplist!=null&&bplist.size()>0){
						for (Departinvoicesdetail dd : departinvoicesdetails) {
							BigDecimal tranfee=new BigDecimal(0);
							for(Balancedeductapplysell bs:bplist){
								//ids.clear();
								Ticketoutlets let=(Ticketoutlets) balancedeductitemDao.get(Ticketoutlets.class, bs.getDataid());
								if(let!=null){
									//团体票\包车票单独处理
									if(dd.getTickettype().equals("T") || dd.getTickettype().equals("H")){
										Ticketsell ticket= ticketsells.get(0);
										//暂时以第一张售票点进行判断
										if(ticket.getTicketoutletsid()==bs.getId() ||
												(ticket.getTicketoutletsname()!=null && ticket.getTicketoutletsname().equals(let.getName()))){
											for(Balancedeductitemprice bprice:blist){
												if(bprice.getFromprice().compareTo(dd.getPrice().divide(new BigDecimal(dd.getTicketnum())))<=0
													&& bprice.getEndprice().compareTo(dd.getPrice().divide(new BigDecimal(dd.getTicketnum())))>=0
													){
												        //ids.put(ticket.getId(), ticket.getTicketno());
														tranfee=tranfee.add(bprice.getValue().multiply(new BigDecimal(dd.getTicketnum())));
														break;
													}
											}
										}
									}
									else{
										for (Ticketsell ticket : ticketsells) {	
											if((ticket.getTicketoutletsid()==bs.getId() ||(ticket.getTicketoutletsname()!=null && ticket.getTicketoutletsname().equals(let.getName())) )
											&&dd.getFromstationid()==ticket.getDepartstationid()
											&&dd.getReachstationid()==ticket.getReachstationid()
											&&dd.getTickettype().equals(ticket.getTickettype())
											&&dd.getPrice().compareTo(ticket.getPrice())==0){
												for(Balancedeductitemprice bprice:blist){
													if(bprice.getFromprice().compareTo(ticket.getPrice())<=0
														&& bprice.getEndprice().compareTo(ticket.getPrice())>=0
														){
													        //ids.put(ticket.getId(), ticket.getTicketno());
															tranfee=tranfee.add(bprice.getValue());
															break;
														}
												}
										  }
								      }
								  }
							   }
							}
							if(tranfee.compareTo(new BigDecimal(0))>0){
								Departinvoicesdeductdetail ddt = new Departinvoicesdeductdetail();
								ddt.setName(deductname);
								ddt.setDeductmoney(tranfee);							
								dd.setOthterfee(dd.getOthterfee().add(tranfee));	
								deductmoney = deductmoney.add(tranfee);
								dd.getDepartinvoicesdeductdetails().add(ddt);
							}
						}		
					}
															
				} else {
					deductmoney = new BigDecimal(0);
				}
			}
			//0扣费不保存
			if(deductmoney.compareTo(new BigDecimal(0))>0){
				dv.setDeductmoney(deductmoney);
				dv.setDepartinvoices(departinvoices);
				dv.setDepartdate(departdate);
				dv.setParentbalanceitemid(bi.getParentid());
				dv.setScheduleid(schedule.getId());
				dv.setIsdeductbeforebalance(true);
				dv.setStatus("0");
				dv.setType("2");// 1扣费公式 2固定扣费
				departinvoicesdeductdetails.add(dv);
			}
		}
		//取固定扣费不是表达式的end
		//取固定扣费是表达式的begin
		departinvoices.setDepartinvoicesdeductdetails(departinvoicesdeductdetails);
		ditems = balancedeductDao.findBalancedeductite(
				scheduleplan.getOrgid(), departdate, schedule, vehicle, true,true);

		for (Balancedeductitem ditem : ditems) {
			Balancedeductapply ba = balancedeductDao
					.findBalancedeductitemapply(scheduleplan.getOrgid(),
							departdate, schedule, vehicle, true, ditem.getId());
			if (ba == null) {
				continue;
			}
			Departinvoicesdeductdetail dv = new Departinvoicesdeductdetail();
			BigDecimal deduct=new BigDecimal(0);
			for (Departinvoicesdetail dd : departinvoicesdetails) {
				BigDecimal ddt = getExpressfee(dd.getDepartinvoicesdeductdetails(),
						dd.getTotalamount(),ditem.getFormula(), ba);
				deduct=deduct.add(ddt);
				dd.setOthterfee(dd.getOthterfee().add(ddt));
			}
			dv.setCreateby(createdby);
			dv.setCreatetime(new Date());
			dv.setUpdateby(createdby);
			dv.setUpdatetime(new Date());
			dv.setBalanceapplyid(ba.getId());
			dv.setBalanceitemid(ba.getBalancedeductitemid());
			dv.setDeductmoney(deduct);
			dv.setDepartdate(departdate);
			dv.setIsdeductbeforebalance(true);
			dv.setDepartinvoices(departinvoices);
			dv.setParentbalanceitemid(0);
			dv.setScheduleid(schedule.getId());
			dv.setStatus("0");
			dv.setType("2");// 1扣费公式 2固定扣费
			departinvoicesdeductdetails.add(dv);
		}
		//取固定扣费是表达式的end
		
		BigDecimal totalamount = new BigDecimal(0);//
		BigDecimal stationservicefee = new BigDecimal(0);// 站务费
		BigDecimal fueladditionfee = new BigDecimal(0);// 燃油费
		BigDecimal otherfee = new BigDecimal(0);// 其他扣费
		long ticketnum = 0;
		// 获取客运代理费
		BigDecimal agentfee = new BigDecimal(0);
		BigDecimal totalmoreprice = new BigDecimal(0);
		Departinvoicesdeductdetail ds1 = null;
		int nopapernum = 0;
		int papernum = 0;
		for (Departinvoicesdetail dd : departinvoicesdetails) {
			ticketnum = ticketnum + dd.getTicketnum();
			totalamount = totalamount.add(dd.getTotalamount());
			totalmoreprice = totalmoreprice.add(dd.getMoreprice());
			nopapernum = nopapernum+dd.getNopaperticketnum();
			papernum = papernum+dd.getPaperticketnum();
			if (!isexitstationfee) {
				dd.setStationservicefee(new BigDecimal(0));
			}
			stationservicefee = stationservicefee
					.add(dd.getStationservicefee());

			otherfee = otherfee.add(dd.getOthterfee());
			List<Balanceformulaitem> balanceformulaitems = setBalanceformulaitem(dd);
			ds1 = getAgentfee(departdate, schedule, vehicle,
					balanceformulaitems);
			if (ds1 != null) {
				dd.setAgentfee(ds1.getDeductmoney());
			} else {
				dd.setAgentfee(new BigDecimal(0));
			}
			agentfee = agentfee.add(dd.getAgentfee());
			if (!isexistfulfee) {
				dd.setFueladditionfee(new BigDecimal(0));
			}
			fueladditionfee = fueladditionfee.add(dd.getFueladditionfee());

			BigDecimal bamount = dd.getTotalamount().subtract(dd.getAgentfee())
					.subtract(dd.getFueladditionfee())
					.subtract(dd.getStationservicefee())
					.subtract(dd.getOthterfee());
			dd.setBalanceamount(bamount);
			// 客运代理费
		}
		if (ds1 != null) {
			ds1.setCreateby(createdby);
			ds1.setCreatetime(new Date());
			ds1.setDepartdate(scheduleplan.getDepartdate());
			ds1.setScheduleid(scheduleplan.getScheduleid());
			ds1.setDepartinvoices(departinvoices);
			ds1.setDeductmoney(agentfee);
			ds1.setUpdateby(createdby);
			ds1.setUpdatetime(new Date());
			departinvoicesdeductdetails.add(ds1);
		}
		departinvoices.setMoreprice(totalmoreprice);
		departinvoices.setTicketnum(ticketnum);
		departinvoices.setTotalamount(totalamount);
		departinvoices.setAgentfee(agentfee);
		departinvoices.setStationservicefee(stationservicefee);
		departinvoices.setFueladditionfee(fueladditionfee);
		departinvoices.setTicketoutletsid(global.getTicketoutlets().getId());
		departinvoices.setNopaperticketnum(nopapernum);
		departinvoices.setPaperticketnum(papernum);;
		departinvoices.setEticketnum(eticketnum);//电子票总票数，包含：电子票取票、未取票总张数
		departinvoices.setHandticketnum(handticketnum);//手持机总票数，包含：手持机售票的总张数
		if (paperfee != null) {
			departinvoices.setOthterfee(otherfee.add(paperfee));
		} else {
			departinvoices.setOthterfee(otherfee);
		}
		departinvoices.setOthterfee(departinvoices.getOthterfee()
				.add(deductfee));
		BigDecimal balanceamount = departinvoices.getTotalamount()
				.subtract(departinvoices.getAgentfee())
				.subtract(departinvoices.getFueladditionfee())
				.subtract(departinvoices.getStationservicefee())
				.subtract(departinvoices.getOthterfee());
		departinvoices.setBalanceamount(balanceamount);
		departinvoices
				.setDepartinvoicesdeductdetails(departinvoicesdeductdetails);
		departinvoices.setDepartinvoicesdetails(departinvoicesdetails);
		return departinvoices;
	}

	private BigDecimal getExpressfee(List<Departinvoicesdeductdetail> ddlist,
			BigDecimal ticketprices, String formula, Balancedeductapply ba)
			throws ServiceException {
		BigDecimal result = new BigDecimal("0");
		for (Departinvoicesdeductdetail bi : ddlist) {
			if (!bi.getName().equals("") && bi.getCode() != null
					&& bi.getDeductmoney() != null) {
				formula = formula.replaceAll(bi.getCode(), bi.getDeductmoney()
						.toString());
			}
		}
		formula = formula.replaceAll("A", ticketprices + "");
		for (int i = 0; i < formula.length(); i++) {
			char item = formula.charAt(i);
			if (ConstDefiniens.ITEM.indexOf(item) > 0) {
				formula = formula.replaceAll(String.valueOf(item), "0");
			}
		}
		try {
			result = new BigDecimal(ExpressionEvaluator.evaluate(formula)
					.toString());
			result = result.divide(new BigDecimal(1), 2,
					BigDecimal.ROUND_HALF_UP);
		} catch (Exception ex) {
			System.out.println("扣费公式计算出现异常：" + formula);
			return result;
		}
		return result;
	}
	private String trunc(String str) {
		return "(" + str.substring(0, str.length() - 1) + ")";
	}

	private List<Balanceformulaitem> setBalanceformulaitem(
			Departinvoicesdetail dd) {
		List<Balanceformulaitem> balanceformulaitems = new ArrayList<Balanceformulaitem>();
		balanceformulaitems
				.add(addBalanceformulaitem("A", dd.getTotalamount()));
		balanceformulaitems.add(addBalanceformulaitem("B",
				new BigDecimal(dd.getTicketnum())));// 人数
		balanceformulaitems.add(addBalanceformulaitem("K",
				dd.getFueladditionfee()));// 燃油费
		for (Departinvoicesdeductdetail ddi : dd
				.getDepartinvoicesdeductdetails()) {
			String shortname = balancedeductDao
					.getBalanceformulaitemShortname(ddi.getName());
			balanceformulaitems.add(addBalanceformulaitem(shortname,
					ddi.getDeductmoney()));
		}
		return balanceformulaitems;
	}

	private Balanceformulaitem addBalanceformulaitem(String shortname,
			BigDecimal calvalue) {
		Balanceformulaitem balanceformulaitem = new Balanceformulaitem();
		balanceformulaitem.setShortname(shortname);
		balanceformulaitem.setCalValue(calvalue);
		return balanceformulaitem;
	}

	@Override
	public List<Map<String, Object>> qryDeductfee(long departinvoiceid)
			throws ServiceException {
		return ListUtil.listToMap(new Object[] { "code", "deductmoney"},
				balancedeductDao.qryDeductfee(departinvoiceid),
				new Object[] { String.class, String.class});

	}
	//获取结算公式组成项目表
	@Override
	public Map getBalanceformulaitemAndValue(Departinvoices departinvoices) {
		Map map = new HashMap<String,Object>();
		map.put("A", departinvoices.getTotalamount());
		map.put("B", departinvoices.getTicketnum());
		Map mmap = balancedeductDao.qryBalanceformulaitemcodeAndValue();
		Set<String> set1 = mmap.keySet();
		for(String key : set1)
		{
			map.put(key, mmap.get(key));
		}
		map.put("C", departinvoices.getStationservicefee()); //将结算单中的站务费赋值给 站务费扣费项C
		return map;
	}
	//结算固定扣费项目，公式扣费时候通过传入的公式把公式的对应项替换成对应项的值
	@Override
	public BigDecimal replaceFormula(String formula,Departinvoices departinvoices) {
		char[] formulaitem = formula.toCharArray();
		Map map = getBalanceformulaitemAndValue(departinvoices);
		Set<String> set = map.keySet();
		boolean flag = false;
		for(int i=0;i<formulaitem.length;i++)//外层循环是传入到公式
		{
			if(65<=formulaitem[i]&&formulaitem[i]<=90)//只有大写字母才进行替换
			{
				String formulaitemkey = formulaitem[i]+""; 
				for(String key : set)
				{	flag=false;
					if(formulaitemkey.equals(key))
					{
//						formulaitem[i]= map.get(formulaitemkey).toString();
						formula = formula.replace(formulaitemkey, map.get(formulaitemkey).toString());
						flag=true;
						break;
					}
					
				}
				if(!flag)
					formula = formula.replace(formulaitemkey, "0");
			}
			
		}

		String result = new String(formula);//把字符数组在转成String
		BigDecimal rr = new BigDecimal(0);
		try {
			rr = new BigDecimal(ExpressionEvaluator.evaluate(result).toString());
		} catch (Exception e) {
			play.Logger.error("结算单结算", e);
		}
//		rr = rr.divide(new BigDecimal(1), 2,BigDecimal.ROUND_HALF_UP);//四舍五入
		/**注释掉此处代码原因：
		 * 1.用除以1的值再四舍五入，这不是一个太好的完成四舍五入的方法，最好用BigDecimal的setScale方法
		 * 2.此处如果执行四舍五入，当对N张结算单进行扣费计算时每一张结算单的扣费都进行四舍五入，
		 * 导致最后balancedeductdetail中deductmoney与    总结算金额*相应比例   得到的扣费金额有偏差，
		 * 应该在将每张结算单的扣费总和加起来之后在进行四舍五入，
		 * 即BalanceServiceImpl.java方法genBalanceData中  生成结算扣费数据  之后的这段代码
		 * balancedeductdetaillist.get(i).setDeductmoney(balancedeductdetaillist.get(i).getDeductmoney().setScale(2, BigDecimal.ROUND_HALF_UP));
		 */
		return rr;
	}
}
