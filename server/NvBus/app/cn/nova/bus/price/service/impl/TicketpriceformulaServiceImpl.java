package cn.nova.bus.price.service.impl;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.wltea.expression.ExpressionEvaluator;

import cn.nova.bus.base.model.Schedule;
import cn.nova.bus.base.model.Schedulestop;
import cn.nova.bus.base.model.Ticketdiscount;
import cn.nova.bus.common.ConstDefiniens;
import cn.nova.bus.common.ParamterConst;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.price.dao.TicketpriceformulaDao;
import cn.nova.bus.price.model.Formulaitemprice;
import cn.nova.bus.price.model.Standardprice;
import cn.nova.bus.price.model.Standardpriceitem;
import cn.nova.bus.price.model.Ticketpriceformula;
import cn.nova.bus.price.model.Ticketpriceformulaitem;
import cn.nova.bus.price.service.RoutepriceService;
import cn.nova.bus.price.service.TicketpriceformulaService;
import cn.nova.bus.system.service.ParameterService;
import cn.nova.bus.system.service.impl.ParameterServiceImpl;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;

/**
 * @author lck
 * 
 */

public class TicketpriceformulaServiceImpl implements TicketpriceformulaService {
	private TicketpriceformulaDao ticketpriceformulaDao = new TicketpriceformulaDao();
	
	private ParameterService parameterService = new ParameterServiceImpl();
	
	private RoutepriceService routepriceService = new RoutepriceServiceImpl();
	// 
	// private CarrycontrolService carrycontrolService;
	@Override
	public List<Map<String, Object>> query(
			List<PropertyFilter> propertyFilterList) {

		return ListUtil.listToMap(new Object[] { Ticketpriceformula.class,
				"username", "ticketypename", "code", "orgname" },
				ticketpriceformulaDao.query(propertyFilterList), new Object[] {
						Ticketpriceformula.class, String.class, String.class,
						String.class, String.class });
	}

	@Override
	public List<Map<String, Object>> queryitem(String orgids) {
		return ListUtil.listToMap(
				new Object[] { Ticketpriceformulaitem.class },
				ticketpriceformulaDao.queryitem(orgids),
				new Object[] { Ticketpriceformulaitem.class });
	}

	@SuppressWarnings("unchecked")
	@Override
	public boolean saveTicketpriceformula(Ticketpriceformula ticketpriceformula)
			throws ServiceException {
		if (ticketpriceformulaDao.isExistformula(ticketpriceformula)) {
			throw new ServiceException("0035");
		}
		if (ticketpriceformulaDao.isExistFreight(ticketpriceformula)) {
			throw new ServiceException("0050");
		}
		if (ticketpriceformula.getId() != 0) {
			return ticketpriceformulaDao.update(ticketpriceformula);
		} else {
			Ticketpriceformula obj = ticketpriceformulaDao
					.isExistDelFormula(ticketpriceformula);
			if (obj != null) {
				obj.setCreateby(ticketpriceformula.getCreateby());
				obj.setCreatetime(new Date());
				obj.setEnddate(ticketpriceformula.getEnddate());
				obj.setFormula(ticketpriceformula.getFormula());
				obj.setIsactive(true);
				obj.setIsdefault(ticketpriceformula.getIsdefault());
				obj.setRemarks(ticketpriceformula.getRemarks());
				obj.setStartdate(ticketpriceformula.getStartdate());
				obj.setUpdateby(ticketpriceformula.getCreateby());
				obj.setUpdatetime(new Date());
				return ticketpriceformulaDao.update(obj);
			} else
				return ticketpriceformulaDao.save(ticketpriceformula);
		}

	}

	@SuppressWarnings("unchecked")
	@Override
	public boolean delTicketpriceformula(Ticketpriceformula ticketpriceformula)
			throws ServiceException {
		Ticketpriceformula obj = ticketpriceformulaDao.getEntityManager().find(
				Ticketpriceformula.class, ticketpriceformula.getId());
		obj.setIsactive(false);
		obj.setUpdatetime(new Timestamp(System.currentTimeMillis()));
		ticketpriceformulaDao.merge(obj);
		return true;
	}

	@Override
	public List<Map<String, Object>> generateTicketprice(Long orgid,
			Date departdate, Long createby) {
		List<Object> msglist = new ArrayList<Object>();
		try {
			// 全票票价公式
			Ticketpriceformula fullpriceformula = ticketpriceformulaDao
					.qryFormula(orgid, "Q", departdate);
			if (fullpriceformula == null) {
				throw new ServiceException("0044");
			}
			// 半票票价公式
			Ticketpriceformula halfpriceformula = ticketpriceformulaDao
					.qryFormula(orgid, "B", departdate);
			if (halfpriceformula == null) {
				throw new ServiceException("0045");
			}
			// 学生票票价公式
			Ticketpriceformula studentpriceformula = ticketpriceformulaDao
					.qryFormula(orgid, "X", departdate);
			if (studentpriceformula == null) {
				throw new ServiceException("0046");
			}
			// 上限票票价公式
			Ticketpriceformula toppriceformula = ticketpriceformulaDao
					.qryFormula(orgid, "S", departdate);
			if (toppriceformula == null) {
				throw new ServiceException("0051");
			}

			List<Schedule> schedulelist = ticketpriceformulaDao
					.qryOrgSchedule(orgid);

			// 循环所有班次
			for (Schedule schedule : schedulelist) {
				Long scheduleid = schedule.getId();
				Long routeid = schedule.getRoute().getId();
				List<Long> vehicletypeidlist = ticketpriceformulaDao
						.qryCycleschemesvehicle(scheduleid);
				try {
					for (long vehicletypeid : vehicletypeidlist) {
						try {
							genPrice(departdate, orgid, routeid,
									schedule.getId(), vehicletypeid, createby);
						} catch (Exception ex) {
							System.out.println("日期:" + departdate + ",班次号："
									+ schedule.getCode() + "生成标准票价失败！");
							msglist.add("班次号：" + schedule.getCode()
									+ "生成标准票价失败,原因：" + ex.getMessage());
						}
					}
				} catch (Exception ex) {
					System.out.println("日期:" + departdate + ",班次号："
							+ schedule.getCode() + "生成标准票价失败！");
					msglist.add("班次号：" + schedule.getCode() + "生成标准票价失败,原因："
							+ ex.getMessage());
				}
			}
		} catch (ServiceException ex) {
			System.out.println(ex.getMessage());
			msglist.add(ex.getMessage());
		}
		return ListUtil.listToMap(new Object[] { "errorInfo" }, msglist,
				new Object[] { String.class });
	}

	@Override
	public BigDecimal executeFormula(long orgid, long vehicletypeid,
			long routeid, long scheduleid, long departstationid,
			long reachstationid, int distance, String ticketpriceformula,
			List<Ticketpriceformulaitem> ticketpriceformulaitemlist)
			throws ServiceException {
		String formulaitem = "";
		formulaitem = explainFormulaitem(orgid, vehicletypeid, routeid,
				scheduleid, departstationid, reachstationid, distance,
				ticketpriceformula, ticketpriceformulaitemlist);
		// 单独处理票价相关
		BigDecimal price = explainPriceitem(orgid, formulaitem,
				ticketpriceformulaitemlist);
		return price;
	}

	private String explainFormulaitem(Long orgid, Long vehicletypeid,
			Long routeid, Long scheduleid, Long departstationid,
			Long reachstationid, int distance, String formula,
			List<Ticketpriceformulaitem> ticketpriceformulaitemlist)
			throws ServiceException {
		String tempformula = "";
		int pos = 0;
		String value = "";
		char item;
		while (pos < formula.length()) {
			item = formula.charAt(pos);
			pos++;
			if (ConstDefiniens.ITEM.indexOf(item) >= 0) {
				Ticketpriceformulaitem ticketpriceformulaitem = ticketpriceformulaDao
						.qryformulaitem(orgid, item);
				if (ticketpriceformulaitem == null) {
					throw new ServiceException(item+"","0047");
				}
				if (item == 'A') {
					value = String.valueOf(distance);
				} else if (ticketpriceformulaitem.getRelatetype().equals("0")) {
					value = ticketpriceformulaDao.qryAboutVehicletypeValue(
							ticketpriceformulaitem, vehicletypeid).toString();
				} else if (ticketpriceformulaitem.getRelatetype().equals("1")) {
					value = ticketpriceformulaDao.qryAboutRoadgradeValue(
							ticketpriceformulaitem, routeid, departstationid,
							reachstationid).toString();
				} else if (ticketpriceformulaitem.getRelatetype().equals("2")) {
					value = ticketpriceformulaDao.qryVehicletypeRoadValue(
							ticketpriceformulaitem, vehicletypeid, routeid,
							departstationid, reachstationid).toString();
				} else if (ticketpriceformulaitem.getRelatetype().equals("3")) {
					value = ticketpriceformulaDao.qryStationgradeValue(
							ticketpriceformulaitem, orgid).toString();
				} else if (ticketpriceformulaitem.getRelatetype().equals("4")) {
					value = ticketpriceformulaDao.qryAboutScheduleValue(
							ticketpriceformulaitem, scheduleid).toString();
				} else if (ticketpriceformulaitem.getRelatetype().equals("5")) {
					value = ticketpriceformulaDao.qryAboutRouteValue(
							ticketpriceformulaitem, routeid).toString();
				} else if (ticketpriceformulaitem.getRelatetype().equals("6")) {
					value = ticketpriceformulaDao.qryAboutRoutestopValue(
							ticketpriceformulaitem, routeid, reachstationid)
							.toString();
				} else if (ticketpriceformulaitem.getRelatetype().equals("7")) {
					// 票价区间相关,后面处理
					value = String.valueOf(item);
				} else if (ticketpriceformulaitem.getRelatetype().equals("8")) {
					// 公里区间相关
					value = ticketpriceformulaDao.qryAboutDistanceValue(
							ticketpriceformulaitem, routeid, departstationid,
							reachstationid).toString();
				} else if (ticketpriceformulaitem.getRelatetype().equals("9")) {
					// 固定值相关
					value = ticketpriceformulaDao.qryAboutFixValue(
							ticketpriceformulaitem).toString();
				} else if (ticketpriceformulaitem.getRelatetype().equals("10")) {
					// 表达式相关
					String itemformula = ticketpriceformulaDao
							.qryAboutFormulaitemformula(ticketpriceformulaitem);
					value = explainFormulaitem(orgid, vehicletypeid, routeid,
							scheduleid, departstationid, reachstationid,
							distance, itemformula, ticketpriceformulaitemlist);
				}
				if (ticketpriceformulaitem.getIsticketpriceitem()
						&& !ticketpriceformulaitem.getRelatetype().equals("7")) {
					BigDecimal price = new BigDecimal(0);
					try {
						price = new BigDecimal(ExpressionEvaluator.evaluate(
								value).toString());
						// 暂时票价分项四舍五入取整
						// price = new BigDecimal(price.intValue()).setScale(1,
						// BigDecimal.ROUND_UP);
					} catch (IllegalArgumentException ex) {
						play.Logger.error(ex.getMessage(), ex);
						throw new ServiceException("0049");

					}
					ticketpriceformulaitem.setValue(price);
					ticketpriceformulaitemlist.add(ticketpriceformulaitem);
					value = price.toString();
				}
				tempformula = tempformula + value;
			} else {
				tempformula = tempformula + String.valueOf(item);
			}
		}
		return tempformula;
	}

	private BigDecimal explainPriceitem(Long orgid, String formula,
			List<Ticketpriceformulaitem> ticketpriceformulaitemlist) {
		String tempformula = formula;
		int pos = 0;
		char item = '#';
		boolean ispriceitem = false;
		BigDecimal price = new BigDecimal(0);
		Ticketpriceformulaitem ticketpriceformulaitem = null;
		while (pos < tempformula.length()) {
			item = tempformula.charAt(pos);
			pos++;
			if (ConstDefiniens.ITEM.indexOf(item) > 0) {
				ticketpriceformulaitem = ticketpriceformulaDao.qryformulaitem(
						orgid, item);
				if (ticketpriceformulaitem.getRelatetype().equals("7")) {
					// 票价区间相关
					ispriceitem = true;
					break;
				}
			}
		}
		if (ispriceitem && ticketpriceformulaitem != null) {
			List<Formulaitemprice> aboutPricelist = ticketpriceformulaDao
					.qryAboutPriceValue(ticketpriceformulaitem);
			boolean isfind=false;
			//使用克隆，防止引用地址一样而引起值的改变。
			try {
				ticketpriceformulaitem = ticketpriceformulaitem.clone();
			} catch (CloneNotSupportedException e) {
				e.printStackTrace();
			}
			for (Formulaitemprice formulaitemprice : aboutPricelist) {
				String tempformula2 = tempformula.replace(String.valueOf(item),
						formulaitemprice.getValue().toString());
				BigDecimal tempprice = new BigDecimal(ExpressionEvaluator
						.evaluate(tempformula2).toString());
				if (formulaitemprice.getFromprice().compareTo(tempprice) <= 0
						&& formulaitemprice.getEndprice().compareTo(tempprice) >= 0) {
					price = tempprice;
					ticketpriceformulaitem
							.setValue(formulaitemprice.getValue());
					ticketpriceformulaitemlist.add(ticketpriceformulaitem);
					isfind=true;
					break;
				}
			}
			//若在票价区间中未找到该区间的票价则设置为0
			if(!isfind){
				tempformula = tempformula.replace(String.valueOf(item),"0");
				price = new BigDecimal(ExpressionEvaluator
						.evaluate(tempformula).toString());
				ticketpriceformulaitem
						.setValue(new BigDecimal(0));
				ticketpriceformulaitemlist.add(ticketpriceformulaitem);
			}
		} else {
			price = new BigDecimal(ExpressionEvaluator.evaluate(formula)
					.toString());
		}
		// 暂时票价分项四舍五入取整
		// price = new BigDecimal(price.intValue()).setScale(1,
		// BigDecimal.ROUND_UP);
		return price;
	}

	// 根据票种编码以及全票票价等信息计算该票种的票价
	@Override
	public BigDecimal getPrice(long scheduleid, Date departDate, String code,
			BigDecimal fullprice) {
		try {
			Schedule schedule=(Schedule) ticketpriceformulaDao.get(Schedule.class, scheduleid);
			if(schedule==null){
				return fullprice;
			}
			long orgid=schedule.getOrgid();		
			String pricerule = parameterService.findParamValue(ParamterConst.Param_1042,
					orgid);			
			Ticketdiscount td=ticketpriceformulaDao.qryTicketdiscount(fullprice,
					departDate,code, schedule);
			if(td!=null){
				BigDecimal price = fullprice.multiply(td.getDefaultdiscountrate());
				// 1四舍五入、2舍去、3入、4小于5角进到5角，高于5角进到1元
				return routepriceService.mathPriceByRule(pricerule, price);
			}

			Ticketpriceformula ticketpriceformula = ticketpriceformulaDao
					.getformula(orgid, departDate, code);
			if (ticketpriceformula == null) {
				return fullprice;
			} else {
				String formula = ticketpriceformula.getFormula();
				formula = formula.replaceAll("Q", fullprice.toString());
				//System.out.println("formula="+formula);
				BigDecimal price = new BigDecimal(ExpressionEvaluator.evaluate(formula).toString());
				if(price.compareTo(new BigDecimal(0))<0){
					price=new BigDecimal(0);
				}
				// 1四舍五入、2舍去、3入、4小于5角进到5角，高于5角进到1元
				return routepriceService.mathPriceByRule(pricerule, price);
			}
		} catch (Exception ex) {
			play.Logger.error(ex.getMessage(), ex);
			return fullprice;
		}

	}
	private BigDecimal calculatePrice(long orgid,BigDecimal price){
		String pricerule = parameterService.findParamValue(ParamterConst.Param_1042,
				orgid);
		return routepriceService.mathPriceByRule(pricerule, price);
	}

	@SuppressWarnings("unchecked")
	private void addprice(long routeid, Schedulestop endstop,
			long startdistance, long orgid, long vehicletypeid,
			long departstationid, long createby,
			Ticketpriceformula fullpriceformula,
			Ticketpriceformula halfpriceformula,
			Ticketpriceformula studentpriceformula,
			Ticketpriceformula toppriceformula,
			Ticketpriceformula lowpriceformula,
			Ticketpriceformula connectpriceformula, Ticketpriceformula discountpriceformula,
			Ticketpriceformula roundpriceformula) throws ServiceException {
		long scheduleid = endstop.getSchedule().getId();
		Long reachstationid = endstop.getStationid();
		long enddistance = ticketpriceformulaDao.qryOrgStopDistance(routeid,
				reachstationid);
		int distance = (int) (enddistance - startdistance);
		if (distance < 0) {
			distance = -distance;
		}
		BigDecimal fullprice = new BigDecimal(0);
		BigDecimal halfprice = new BigDecimal(0);
		BigDecimal studentprice = new BigDecimal(0);
		BigDecimal discountprice = new BigDecimal(0);
		BigDecimal roundprice = new BigDecimal(0);
		BigDecimal connectprice = new BigDecimal(0);
		Map<String, List<Ticketpriceformulaitem>> ticketpriceformulaitemmap = new HashMap<String, List<Ticketpriceformulaitem>>();

		List<Ticketpriceformulaitem> ticketpriceformulaitemlist = new ArrayList<Ticketpriceformulaitem>();
		fullprice = executeFormula(orgid, vehicletypeid, routeid, scheduleid,
				departstationid, reachstationid, distance,
				fullpriceformula.getFormula(), ticketpriceformulaitemlist);
		//根据进位规则计算票种票价
		fullprice = calculatePrice(orgid,fullprice);
		if (ticketpriceformulaitemlist.size() > 0) {
			ticketpriceformulaitemmap.put("Q", ticketpriceformulaitemlist);
		}

		// 运用进位规则
		// BigDecimal
		// carryfullprice=carrycontrolService.carryControl(fullprice.toString(),
		// "002");
		// BigDecimal carryfullprice=new
		// BigDecimal(fullprice.intValue());

		// 生成上限价票价
		ticketpriceformulaitemlist = new ArrayList<Ticketpriceformulaitem>();
		String topformula = toppriceformula.getFormula();
		BigDecimal toplimitprice = executeFormula(orgid, vehicletypeid,
				routeid, scheduleid, departstationid, reachstationid, distance,
				topformula, ticketpriceformulaitemlist);
		if (ticketpriceformulaitemlist.size() > 0) {
			ticketpriceformulaitemmap.put("S", ticketpriceformulaitemlist);
		}

		BigDecimal lowerlimitprice = new BigDecimal(0);
		// 生成下限票价
		if (lowpriceformula != null) {
			ticketpriceformulaitemlist = new ArrayList<Ticketpriceformulaitem>();
			String lowformula = lowpriceformula.getFormula();
			lowerlimitprice = executeFormula(orgid, vehicletypeid, routeid,
					scheduleid, departstationid, reachstationid, distance,
					lowformula, ticketpriceformulaitemlist);
			if (ticketpriceformulaitemlist.size() > 0) {
				ticketpriceformulaitemmap.put("U", ticketpriceformulaitemlist);
			}
		}
		// 生成半票票价
		ticketpriceformulaitemlist = new ArrayList<Ticketpriceformulaitem>();
		String hpf = halfpriceformula.getFormula();
		halfprice = executeFormula(orgid, vehicletypeid, routeid, scheduleid,
				departstationid, reachstationid, distance, hpf,
				ticketpriceformulaitemlist);
		//根据进位规则计算票种票价
		halfprice = calculatePrice(orgid,halfprice);
		if (ticketpriceformulaitemlist.size() > 0) {
			ticketpriceformulaitemmap.put("B", ticketpriceformulaitemlist);
		}

		// 生成学生价票价
		ticketpriceformulaitemlist = new ArrayList<Ticketpriceformulaitem>();
		String spf = studentpriceformula.getFormula();
		// spf = spf.replaceAll("Q", fullprice.toString());
		studentprice = executeFormula(orgid, vehicletypeid, routeid,
				scheduleid, departstationid, reachstationid, distance, spf,
				ticketpriceformulaitemlist);
		//根据进位规则计算票种票价
		studentprice = calculatePrice(orgid,studentprice);
		if (ticketpriceformulaitemlist.size() > 0) {
			ticketpriceformulaitemmap.put("X", ticketpriceformulaitemlist);
		}
		// 生成优惠价票价===================================================================
		ticketpriceformulaitemlist = new ArrayList<Ticketpriceformulaitem>();
		String dpf = discountpriceformula.getFormula();
		discountprice = executeFormula(orgid, vehicletypeid, routeid, scheduleid, departstationid, reachstationid,
				distance, dpf, ticketpriceformulaitemlist);
		// 根据进位规则计算票种票价
		discountprice = calculatePrice(orgid, discountprice);
		if (ticketpriceformulaitemlist.size() > 0) {
			ticketpriceformulaitemmap.put("Y", ticketpriceformulaitemlist);
		}

		// 生成往返价票价===================================================================
		ticketpriceformulaitemlist = new ArrayList<Ticketpriceformulaitem>();
		String rpf = roundpriceformula.getFormula();
		roundprice = executeFormula(orgid, vehicletypeid, routeid, scheduleid, departstationid, reachstationid,
				distance, rpf, ticketpriceformulaitemlist);
		// 根据进位规则计算票种票价
		roundprice = calculatePrice(orgid, roundprice);
		if (ticketpriceformulaitemlist.size() > 0) {
			ticketpriceformulaitemmap.put("W", ticketpriceformulaitemlist);
		}

		// 生成联程价票价===================================================================
		ticketpriceformulaitemlist = new ArrayList<Ticketpriceformulaitem>();
		String cpf = connectpriceformula.getFormula();
		connectprice = executeFormula(orgid, vehicletypeid, routeid, scheduleid, departstationid, reachstationid,
				distance, cpf, ticketpriceformulaitemlist);
		// 根据进位规则计算票种票价
		connectprice = calculatePrice(orgid, connectprice);
		if (ticketpriceformulaitemlist.size() > 0) {
			ticketpriceformulaitemmap.put("L", ticketpriceformulaitemlist);
		}
		// 删除已经存在的标准票价
		ticketpriceformulaDao.delStandardprice(scheduleid, vehicletypeid,
				departstationid, reachstationid);
		Standardprice standardprice = new Standardprice();
		standardprice.setCreateby(createby);
		standardprice.setCreatetime(new Date());
		standardprice.setDepartstationid(departstationid);
		standardprice.setFullprice(fullprice);
		standardprice.setHalfprice(halfprice);
		standardprice.setLowerlimitprice(lowerlimitprice);
		standardprice.setReachstationid(reachstationid);
		standardprice.setScheduleid(scheduleid);
		standardprice.setStudentprice(studentprice);
		standardprice.setToplimitprice(toplimitprice);
		standardprice.setUpdateby(createby);
		standardprice.setUpdatetime(new Date());
		standardprice.setVehicletypeid(vehicletypeid);
		standardprice.setDiscountprice(discountprice);
		standardprice.setRoundprice(roundprice);
		standardprice.setConnectprice(connectprice);
		List<Standardpriceitem> standardpriceitemlist = new ArrayList<Standardpriceitem>();
		List<Ticketpriceformulaitem> fullpriceitemlist = ticketpriceformulaitemmap
				.get("Q");
		BigDecimal notfullpricefreight = new BigDecimal(0);
		// 先保存全票非基础运价项目
		for (Ticketpriceformulaitem ticketpriceformulaitem : fullpriceitemlist) {
			Standardpriceitem standardpriceitem = new Standardpriceitem();
			if (!ticketpriceformulaitem.getIsfreight()) {
				standardpriceitem.setPrice(ticketpriceformulaitem.getValue());
				notfullpricefreight = notfullpricefreight
						.add(ticketpriceformulaitem.getValue());
				standardpriceitem.setCreateby(createby);
				standardpriceitem.setCreatetime(new Date());
				standardpriceitem.setIsautoadjust(ticketpriceformulaitem
						.getIsautoadjust());
				standardpriceitem
						.setTicketpriceformulaitemid(ticketpriceformulaitem
								.getId());
				standardpriceitem.setStandardprice(standardprice);
				standardpriceitem.setTickettype("Q");
				standardpriceitem.setUpdateby(createby);
				standardpriceitem.setUpdatetime(new Date());
				ticketpriceformulaDao.save(standardpriceitem);
				standardpriceitemlist.add(standardpriceitem);
			}
		}
		// 保存全票基础运价=总票价-非基础运价票价分项和
		for (Ticketpriceformulaitem ticketpriceformulaitem : fullpriceitemlist) {
			Standardpriceitem standardpriceitem = new Standardpriceitem();
			if (ticketpriceformulaitem.getIsfreight()) {
				standardpriceitem.setPrice(fullprice
						.subtract(notfullpricefreight));
				standardpriceitem.setCreateby(createby);
				standardpriceitem.setCreatetime(new Date());
				standardpriceitem.setIsautoadjust(ticketpriceformulaitem
						.getIsautoadjust());
				standardpriceitem
						.setTicketpriceformulaitemid(ticketpriceformulaitem
								.getId());
				standardpriceitem.setStandardprice(standardprice);
				standardpriceitem.setTickettype("Q");
				standardpriceitem.setUpdateby(createby);
				standardpriceitem.setUpdatetime(new Date());
				ticketpriceformulaDao.save(standardpriceitem);
				standardpriceitemlist.add(standardpriceitem);
				break;
			}
		}

		List<Ticketpriceformulaitem> toppriceitemlist = ticketpriceformulaitemmap
				.get("S");
		BigDecimal nottoppricefreight = new BigDecimal(0);
		// 先保存上限票非基础运价项目
		for (Ticketpriceformulaitem ticketpriceformulaitem : toppriceitemlist) {
			Standardpriceitem standardpriceitem = new Standardpriceitem();
			if (!ticketpriceformulaitem.getIsfreight()) {
				standardpriceitem.setPrice(ticketpriceformulaitem.getValue());
				nottoppricefreight = nottoppricefreight
						.add(ticketpriceformulaitem.getValue());
				standardpriceitem.setCreateby(createby);
				standardpriceitem.setCreatetime(new Date());
				standardpriceitem.setIsautoadjust(ticketpriceformulaitem
						.getIsautoadjust());
				standardpriceitem
						.setTicketpriceformulaitemid(ticketpriceformulaitem
								.getId());
				standardpriceitem.setStandardprice(standardprice);
				standardpriceitem.setTickettype("S");
				standardpriceitem.setUpdateby(createby);
				standardpriceitem.setUpdatetime(new Date());
				ticketpriceformulaDao.save(standardpriceitem);
				standardpriceitemlist.add(standardpriceitem);
			}
		}
		// 保存全票基础运价=总票价-非基础运价票价分项和
		for (Ticketpriceformulaitem ticketpriceformulaitem : toppriceitemlist) {
			Standardpriceitem standardpriceitem = new Standardpriceitem();
			if (ticketpriceformulaitem.getIsfreight()) {
				standardpriceitem.setPrice(toplimitprice
						.subtract(nottoppricefreight));
				standardpriceitem.setCreateby(createby);
				standardpriceitem.setCreatetime(new Date());
				standardpriceitem.setIsautoadjust(ticketpriceformulaitem
						.getIsautoadjust());
				standardpriceitem
						.setTicketpriceformulaitemid(ticketpriceformulaitem
								.getId());
				standardpriceitem.setStandardprice(standardprice);
				standardpriceitem.setTickettype("S");
				standardpriceitem.setUpdateby(createby);
				standardpriceitem.setUpdatetime(new Date());
				ticketpriceformulaDao.save(standardpriceitem);
				standardpriceitemlist.add(standardpriceitem);
				break;
			}
		}

		List<Ticketpriceformulaitem> lowpriceitemlist = ticketpriceformulaitemmap
				.get("U");
		if (lowpriceitemlist != null && lowpriceitemlist.size() > 0) {
			BigDecimal notlowpricefreight = new BigDecimal(0);
			// 先保存下限票非基础运价项目
			for (Ticketpriceformulaitem ticketpriceformulaitem : lowpriceitemlist) {
				Standardpriceitem standardpriceitem = new Standardpriceitem();
				if (!ticketpriceformulaitem.getIsfreight()) {
					standardpriceitem.setPrice(ticketpriceformulaitem
							.getValue());
					notlowpricefreight = notlowpricefreight
							.add(ticketpriceformulaitem.getValue());
					standardpriceitem.setCreateby(createby);
					standardpriceitem.setCreatetime(new Date());
					standardpriceitem.setIsautoadjust(ticketpriceformulaitem
							.getIsautoadjust());
					standardpriceitem
							.setTicketpriceformulaitemid(ticketpriceformulaitem
									.getId());
					standardpriceitem.setStandardprice(standardprice);
					standardpriceitem.setTickettype("U");
					standardpriceitem.setUpdateby(createby);
					standardpriceitem.setUpdatetime(new Date());
					ticketpriceformulaDao.save(standardpriceitem);
					standardpriceitemlist.add(standardpriceitem);
				}
			}
			// 保存全票基础运价=总票价-非基础运价票价分项和
			for (Ticketpriceformulaitem ticketpriceformulaitem : lowpriceitemlist) {
				Standardpriceitem standardpriceitem = new Standardpriceitem();
				if (ticketpriceformulaitem.getIsfreight()) {
					standardpriceitem.setPrice(lowerlimitprice
							.subtract(notlowpricefreight));
					standardpriceitem.setCreateby(createby);
					standardpriceitem.setCreatetime(new Date());
					standardpriceitem.setIsautoadjust(ticketpriceformulaitem
							.getIsautoadjust());
					standardpriceitem
							.setTicketpriceformulaitemid(ticketpriceformulaitem
									.getId());
					standardpriceitem.setStandardprice(standardprice);
					standardpriceitem.setTickettype("U");
					standardpriceitem.setUpdateby(createby);
					standardpriceitem.setUpdatetime(new Date());
					ticketpriceformulaDao.save(standardpriceitem);
					standardpriceitemlist.add(standardpriceitem);
					break;
				}
			}
		}
		
		
		BigDecimal connectpricefreight = new BigDecimal(0);
		// 先保存联程票非基础运价项目
		List<Ticketpriceformulaitem> connectpriceitemlist = ticketpriceformulaitemmap
				.get("L");
		for (Ticketpriceformulaitem ticketpriceformulaitem : connectpriceitemlist) {
			
			Standardpriceitem standardpriceitem = new Standardpriceitem();
			if (!ticketpriceformulaitem.getIsfreight()) {
				standardpriceitem.setCreateby(createby);
				standardpriceitem.setCreatetime(new Date());
				standardpriceitem.setIsautoadjust(ticketpriceformulaitem
						.getIsautoadjust());
				standardpriceitem.setPrice(ticketpriceformulaitem.getValue());
				connectpricefreight = connectpricefreight.add(ticketpriceformulaitem.getValue());
				standardpriceitem.setTicketpriceformulaitemid(ticketpriceformulaitem.getId());
				standardpriceitem.setStandardprice(standardprice);
				standardpriceitem.setTickettype("L");
				standardpriceitem.setUpdateby(createby);
				standardpriceitem.setUpdatetime(new Date());
				ticketpriceformulaDao.save(standardpriceitem);
				standardpriceitemlist.add(standardpriceitem);
			}
		}
		// 保存联程票基础运价=总票价-非基础运价票价分项和
		for (Ticketpriceformulaitem ticketpriceformulaitem : connectpriceitemlist) {
			Standardpriceitem standardpriceitem = new Standardpriceitem();
			if (ticketpriceformulaitem.getIsfreight()) {
				standardpriceitem.setCreateby(createby);
				standardpriceitem.setCreatetime(new Date());
				standardpriceitem.setIsautoadjust(ticketpriceformulaitem.getIsautoadjust());
				standardpriceitem.setPrice(connectprice.subtract(connectpricefreight));
				//connectpricefreight = connectpricefreight.add(ticketpriceformulaitem.getValue());
				standardpriceitem.setTicketpriceformulaitemid(ticketpriceformulaitem.getId());
				standardpriceitem.setStandardprice(standardprice);
				standardpriceitem.setTickettype("L");
				standardpriceitem.setUpdateby(createby);
				standardpriceitem.setUpdatetime(new Date());
				ticketpriceformulaDao.save(standardpriceitem);
				standardpriceitemlist.add(standardpriceitem);
				break;
			}
		}
		
		BigDecimal roundpricefreight = new BigDecimal(0);
		// 先保存往返票非基础运价项目
		List<Ticketpriceformulaitem> roundpriceitemlist = ticketpriceformulaitemmap
				.get("W");
		for (Ticketpriceformulaitem ticketpriceformulaitem : roundpriceitemlist) {
			
			Standardpriceitem standardpriceitem = new Standardpriceitem();
			if (!ticketpriceformulaitem.getIsfreight()) {
				standardpriceitem.setCreateby(createby);
				standardpriceitem.setCreatetime(new Date());
				standardpriceitem.setIsautoadjust(ticketpriceformulaitem.getIsautoadjust());
				standardpriceitem.setPrice(ticketpriceformulaitem.getValue());
				roundpricefreight = roundpricefreight.add(ticketpriceformulaitem.getValue());
				standardpriceitem.setTicketpriceformulaitemid(ticketpriceformulaitem.getId());
				standardpriceitem.setStandardprice(standardprice);
				standardpriceitem.setTickettype("W");
				standardpriceitem.setUpdateby(createby);
				standardpriceitem.setUpdatetime(new Date());
				ticketpriceformulaDao.save(standardpriceitem);
				standardpriceitemlist.add(standardpriceitem);
			}
		}
		// 保存往返票基础运价=总票价-非基础运价票价分项和
		for (Ticketpriceformulaitem ticketpriceformulaitem : roundpriceitemlist) {
			
			Standardpriceitem standardpriceitem = new Standardpriceitem();
			if (ticketpriceformulaitem.getIsfreight()) {
				standardpriceitem.setCreateby(createby);
				standardpriceitem.setCreatetime(new Date());
				standardpriceitem.setIsautoadjust(ticketpriceformulaitem.getIsautoadjust());
				standardpriceitem.setPrice(roundprice.subtract(roundpricefreight));
				//roundpricefreight = roundpricefreight.add(ticketpriceformulaitem.getValue());
				standardpriceitem.setTicketpriceformulaitemid(ticketpriceformulaitem.getId());
				standardpriceitem.setStandardprice(standardprice);
				standardpriceitem.setTickettype("W");
				standardpriceitem.setUpdateby(createby);
				standardpriceitem.setUpdatetime(new Date());
				ticketpriceformulaDao.save(standardpriceitem);
				standardpriceitemlist.add(standardpriceitem);
				break;
			}
		}
		
		BigDecimal discountpricefreight = new BigDecimal(0);
		// 先保存优惠票非基础运价项目
		List<Ticketpriceformulaitem> discountpriceitemlist = ticketpriceformulaitemmap.get("Y");
		for (Ticketpriceformulaitem ticketpriceformulaitem : discountpriceitemlist) {
			
			Standardpriceitem standardpriceitem = new Standardpriceitem();
			if (!ticketpriceformulaitem.getIsfreight()) {
				standardpriceitem.setCreateby(createby);
				standardpriceitem.setCreatetime(new Date());
				standardpriceitem.setIsautoadjust(ticketpriceformulaitem.getIsautoadjust());
				standardpriceitem.setPrice(ticketpriceformulaitem.getValue());
				discountpricefreight = discountpricefreight.add(ticketpriceformulaitem.getValue());
				standardpriceitem.setTicketpriceformulaitemid(ticketpriceformulaitem.getId());
				standardpriceitem.setStandardprice(standardprice);
				standardpriceitem.setTickettype("Y");
				standardpriceitem.setUpdateby(createby);
				standardpriceitem.setUpdatetime(new Date());
				ticketpriceformulaDao.save(standardpriceitem);
				standardpriceitemlist.add(standardpriceitem);
			}
		}
		// 保存优惠票基础运价=总票价-非基础运价票价分项和
		for (Ticketpriceformulaitem ticketpriceformulaitem : discountpriceitemlist) {
			Standardpriceitem standardpriceitem = new Standardpriceitem();
			if (ticketpriceformulaitem.getIsfreight()) {
				standardpriceitem.setCreateby(createby);
				standardpriceitem.setCreatetime(new Date());
				standardpriceitem.setIsautoadjust(ticketpriceformulaitem.getIsautoadjust());
				standardpriceitem.setPrice(discountprice.subtract(discountpricefreight));
				//notfullpricefreight = notfullpricefreight.add(ticketpriceformulaitem.getValue());
				standardpriceitem.setTicketpriceformulaitemid(ticketpriceformulaitem.getId());
				standardpriceitem.setStandardprice(standardprice);
				standardpriceitem.setTickettype("Y");
				standardpriceitem.setUpdateby(createby);
				standardpriceitem.setUpdatetime(new Date());
				ticketpriceformulaDao.save(standardpriceitem);
				standardpriceitemlist.add(standardpriceitem);
				break;
			}
		}
		
		BigDecimal nothalfpricefreight = new BigDecimal(0);
		// 先保存半票非基础运价项目
		List<Ticketpriceformulaitem> halfpriceitemlist = ticketpriceformulaitemmap
				.get("B");
		for (Ticketpriceformulaitem ticketpriceformulaitem : halfpriceitemlist) {

			Standardpriceitem standardpriceitem = new Standardpriceitem();
			if (!ticketpriceformulaitem.getIsfreight()) {
				standardpriceitem.setCreateby(createby);
				standardpriceitem.setCreatetime(new Date());
				standardpriceitem.setIsautoadjust(ticketpriceformulaitem
						.getIsautoadjust());
				standardpriceitem.setPrice(ticketpriceformulaitem.getValue());
				nothalfpricefreight = nothalfpricefreight
						.add(ticketpriceformulaitem.getValue());
				standardpriceitem
						.setTicketpriceformulaitemid(ticketpriceformulaitem
								.getId());
				standardpriceitem.setStandardprice(standardprice);
				standardpriceitem.setTickettype("B");
				standardpriceitem.setUpdateby(createby);
				standardpriceitem.setUpdatetime(new Date());
				ticketpriceformulaDao.save(standardpriceitem);
				standardpriceitemlist.add(standardpriceitem);
			}
		}
		// 保存半票基础运价=总票价-非基础运价票价分项和
		for (Ticketpriceformulaitem ticketpriceformulaitem : halfpriceitemlist) {

			Standardpriceitem standardpriceitem = new Standardpriceitem();
			if (ticketpriceformulaitem.getIsfreight()) {
				standardpriceitem.setCreateby(createby);
				standardpriceitem.setCreatetime(new Date());
				standardpriceitem.setIsautoadjust(ticketpriceformulaitem
						.getIsautoadjust());
				standardpriceitem.setPrice(halfprice
						.subtract(nothalfpricefreight));
				notfullpricefreight = notfullpricefreight
						.add(ticketpriceformulaitem.getValue());
				standardpriceitem
						.setTicketpriceformulaitemid(ticketpriceformulaitem
								.getId());
				standardpriceitem.setStandardprice(standardprice);
				standardpriceitem.setTickettype("B");
				standardpriceitem.setUpdateby(createby);
				standardpriceitem.setUpdatetime(new Date());
				ticketpriceformulaDao.save(standardpriceitem);
				standardpriceitemlist.add(standardpriceitem);
				break;
			}
		}
		// 先保存学生票非基础运价项目
		BigDecimal notstudentpricefreight = new BigDecimal(0);
		List<Ticketpriceformulaitem> studentpriceitemlist = ticketpriceformulaitemmap
				.get("X");
		for (Ticketpriceformulaitem ticketpriceformulaitem : studentpriceitemlist) {

			Standardpriceitem standardpriceitem = new Standardpriceitem();
			if (!ticketpriceformulaitem.getIsfreight()) {
				standardpriceitem.setCreateby(createby);
				standardpriceitem.setCreatetime(new Date());
				standardpriceitem.setIsautoadjust(ticketpriceformulaitem
						.getIsautoadjust());
				standardpriceitem.setPrice(ticketpriceformulaitem.getValue());
				notstudentpricefreight = notstudentpricefreight
						.add(ticketpriceformulaitem.getValue());
				standardpriceitem
						.setTicketpriceformulaitemid(ticketpriceformulaitem
								.getId());
				standardpriceitem.setStandardprice(standardprice);
				standardpriceitem.setTickettype("X");
				standardpriceitem.setUpdateby(createby);
				standardpriceitem.setUpdatetime(new Date());
				ticketpriceformulaDao.save(standardpriceitem);
				standardpriceitemlist.add(standardpriceitem);
			}
		}
		// 保存学生票基础运价=总票价-非基础运价票价分项和
		for (Ticketpriceformulaitem ticketpriceformulaitem : studentpriceitemlist) {

			Standardpriceitem standardpriceitem = new Standardpriceitem();
			if (ticketpriceformulaitem.getIsfreight()) {
				standardpriceitem.setCreateby(createby);
				standardpriceitem.setCreatetime(new Date());
				standardpriceitem.setIsautoadjust(ticketpriceformulaitem
						.getIsautoadjust());
				standardpriceitem.setPrice(studentprice
						.subtract(notstudentpricefreight));
				standardpriceitem
						.setTicketpriceformulaitemid(ticketpriceformulaitem
								.getId());
				standardpriceitem.setStandardprice(standardprice);
				standardpriceitem.setTickettype("X");
				standardpriceitem.setUpdateby(createby);
				standardpriceitem.setUpdatetime(new Date());
				ticketpriceformulaDao.save(standardpriceitem);
				standardpriceitemlist.add(standardpriceitem);
			}
		}

		standardprice.setStandardpriceitemlist(standardpriceitemlist);
		ticketpriceformulaDao.save(standardprice);
	}

	@SuppressWarnings("unchecked")
	@Override
	public boolean genPrice(Date departdate, Long orgid, Long routeid,
			Long scheduleid, Long vehicletypeid, Long createby)
			throws ServiceException {

		// 全票票价公式
		Ticketpriceformula fullpriceformula = ticketpriceformulaDao.qryFormula(
				orgid, "Q", departdate);
		if (fullpriceformula == null) {
			throw new ServiceException("0044");
		}

		// 优惠票价公式=============================================================
		Ticketpriceformula discountpriceformula = ticketpriceformulaDao.qryFormula(orgid, "Y", departdate);
		if (discountpriceformula == null) {
//					throw new BusinessException("该机构的优惠票价公式未设置或者已过期");
			discountpriceformula = fullpriceformula;
		}

		// 往返票价公式=============================================================
		Ticketpriceformula roundpriceformula = ticketpriceformulaDao.qryFormula(orgid, "W", departdate);
		if (roundpriceformula == null) {
//					throw new BusinessException("该机构的往返票价公式未设置或者已过期");
			roundpriceformula = fullpriceformula;
		}

		// 联程票价公式=============================================================
		Ticketpriceformula connectpriceformula = ticketpriceformulaDao.qryFormula(orgid, "L", departdate);
		if (connectpriceformula == null) {
//					throw new BusinessException("该机构的联程票价公式未设置或者已过期");
			connectpriceformula = fullpriceformula;
		}

		// 半票票价公式=============================================================
		Ticketpriceformula halfpriceformula = ticketpriceformulaDao.qryFormula(
				orgid, "B", departdate);
		if (halfpriceformula == null) {
			throw new ServiceException("0045");
		}

		// 学生票票价公式
		Ticketpriceformula studentpriceformula = ticketpriceformulaDao
				.qryFormula(orgid, "X", departdate);
		if (studentpriceformula == null) {
			throw new ServiceException("0046");
		}
		Ticketpriceformula toppriceformula = null;
		// 上限票票价公式
		if (toppriceformula == null) {
			toppriceformula = ticketpriceformulaDao.qryFormula(orgid, "S",
					departdate);
			if (toppriceformula == null) {
				throw new ServiceException("0051");
			}
		}
		Ticketpriceformula lowpriceformula = null;
		// 下限票票价公式
		if (lowpriceformula == null) {
			lowpriceformula = ticketpriceformulaDao.qryFormula(orgid, "U",
					departdate);
		}
		Schedule schedule = (Schedule) ticketpriceformulaDao.get(
				Schedule.class, scheduleid);
		long endstatioinid=schedule.getRoute().getEndstationid();
		// 多点配载
		if (schedule.getWorktype().equals("2") || schedule.getWorktype().equals("3")) {
			List<Schedulestop> ststops = ticketpriceformulaDao
					.qryAllSchedulestop(scheduleid);
			List<Schedulestop> rtstops = ticketpriceformulaDao
					.qryAllSchedulestop(scheduleid);
			for (Schedulestop startstop : ststops) {
				if (startstop.getIsdepart() && endstatioinid!=startstop.getStationid()) {
					Long departstationid = startstop.getStationid();
					long startdistance = ticketpriceformulaDao
							.qryOrgStopDistance(routeid, departstationid);
					for (Schedulestop endstop : rtstops) {
						int st = startstop.getOrderno();
						int rt = endstop.getOrderno();
						if (st < rt) {
							//System.out.println("st=" + st + ",rt=" + rt);
							addprice(routeid, endstop, startdistance, orgid,
									vehicletypeid, departstationid, createby,
									fullpriceformula, halfpriceformula,
									studentpriceformula, toppriceformula,
									lowpriceformula, connectpriceformula, discountpriceformula, roundpriceformula);
						}
					}
				}
			}
		} else {

			List<Schedulestop> scheduleStartstoplist = ticketpriceformulaDao
					.qryOrgSchedulestop(scheduleid, true);
			// 循环上车站点
			for (Schedulestop startstop : scheduleStartstoplist) {
				List<Schedulestop> scheduleEndstoplist = ticketpriceformulaDao
						.qryOrgSchedulestop(scheduleid, false);
				if (scheduleEndstoplist == null
						|| scheduleEndstoplist.size() == 0) {
					// 该班次未设置下车停靠站点
					throw new ServiceException("0305");
				}
				Long departstationid = startstop.getStationid();
				long startdistance = ticketpriceformulaDao.qryOrgStopDistance(
						routeid, departstationid);

				// 循环停靠站点
				for (Schedulestop endstop : scheduleEndstoplist) {
					addprice(routeid, endstop, startdistance, orgid,
							vehicletypeid, departstationid, createby,
							fullpriceformula, halfpriceformula,
							studentpriceformula, toppriceformula,
							lowpriceformula,connectpriceformula, discountpriceformula, roundpriceformula);
				}

			}
		}
		return true;
	}

	@Override
	public boolean genPrice(Long orgid, Long routeid, Long scheduleid,
			Long vehicletypeid, Long createby) throws ServiceException {
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		Date departdate = new Date();
		try {
			departdate = sf.parse(sf.format(new Date()));
		} catch (ParseException e) {
			play.Logger.error(e.getMessage(), e);
		}
		return genPrice(departdate, orgid, routeid, scheduleid, vehicletypeid,
				createby);

	}
}
