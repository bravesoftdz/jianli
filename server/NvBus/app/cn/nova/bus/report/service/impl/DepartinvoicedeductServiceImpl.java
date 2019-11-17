/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b>cn.nova.bus.report.service.impl<br/>
 * <b>文件名：</b>DepartinvoicedeductServiceImpl.java<br/>
 * <b>版本信息：</b>v4.0<br/>
 * <b>日期：</b> 2012-4-25 下午04:53:48 <br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.report.service.impl;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.report.dao.DepartinvoicedeductDao;
import cn.nova.bus.report.service.DepartinvoicedeductService;
import cn.nova.utils.commons.DateUtils;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;

/**
 * <b>类描述：</b><br/>
 * <b>类名称：</b>DepartinvoicedeductServiceImpl.java<br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2012-4-25 下午04:53:48 <br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */

public class DepartinvoicedeductServiceImpl implements
		DepartinvoicedeductService {
	private DepartinvoicedeductDao deductDao = new DepartinvoicedeductDao();
	/**
	 * 查询固定扣费项目
	 * 
	 */
	@Override
	public List<Map<String, Object>> queryDeduct(Date startdate, Date enddate,
			String orgids, Long printorgid) {
		deductDao = new DepartinvoicedeductDao();
		List<Object> list = deductDao.queryDeduct(startdate, enddate, orgids,
				printorgid);
		return ListUtil.listToMap(new Object[] { "rname", "stationfee",
				"computefee", "additionfee", "collairfee", "waterfee",
				"insurefee", "otherfee" }, list, new Object[] { String.class,
				BigDecimal.class, BigDecimal.class, BigDecimal.class,
				BigDecimal.class, BigDecimal.class, BigDecimal.class,
				BigDecimal.class });
	}

	/**
	 * 车辆结算汇总查询
	 */
	@Override
	public List<Map<String, Object>> queryVehicleDepartinvoices(
			List<PropertyFilter> buildFromHttpRequest,String balancetypeflag,String orgid) {
		deductDao = new DepartinvoicedeductDao();
		List<Object> list = null;
		if("1".equals(balancetypeflag)){
			list = deductDao.queryVehicleDepartinvoices(buildFromHttpRequest,orgid);
		}else if("2".equals(balancetypeflag)){
			list = deductDao.queryHandVehicleDepartinvoices(buildFromHttpRequest,orgid);
		}else{
			list = deductDao.queryVehicleDepartinvoices(buildFromHttpRequest,orgid);
			List<Object> handlist=deductDao.queryHandVehicleDepartinvoices(buildFromHttpRequest,orgid);
			list.addAll(handlist);
		}
		return ListUtil.listToMap(
				new Object[] { "unitname", "vehicleno", "ticketnum",
						"totalamount", "stationservicefee", "balanceamount",
						"agentfee", "computefee", "coolairfee", "additionfee",
						"fuelfee", "insurefee", "waterfee", "otherfee" ,"allsum","balancetype","schedulenum","contactperson"},
				list,
				new Object[] { String.class, String.class, Long.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class , BigDecimal.class,String.class, Long.class,String.class});
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public List<Map<String, Object>> queryDepartinvoices(String orgids,
			Long routeid, Long vehicleid, Date startdate, Date enddate) {
		deductDao = new DepartinvoicedeductDao();
		List<Object> result = new ArrayList();
		List<Object> resultList = new ArrayList();
		String name = "";
		Object[] obj = new Object[] {};
		List<Object> list = deductDao.queryDepartinvoices(orgids, routeid,
				vehicleid, startdate, enddate);
		for (int i = 0; i < list.size(); i++) {
			obj = (Object[]) list.get(i);
			if (!name.equals(obj[0])) {
				name = (String) obj[0];
				Object[] object = new Object[] {};
				result.add(list.get(i));
				for (int j = i + 1; j < list.size(); j++) {// 用来判断终点站相同的数据
					object = (Object[]) list.get(j);
					if (name.equals(object[0])) {
						result.add(list.get(j));
					}
				}
				Object[] helfobject = getTicketNumber(startdate, enddate,
						result, name, "B");
				resultList.add(helfobject);
				Object[] newobject = getTicketNumber(startdate, enddate,
						result, name, "Q");
				resultList.add(newobject);
			}
		}
		return ListUtil.listToMap(new Object[] { "num1", "num2", "num3", "num4",
				"num5", "num6", "num7", "num8", "num9", "num10", "num11", "num12", "num13",
				"num14", "num15", "num16", "num17", "num18", "num19", "num20", "num21", "num22",
				"num23", "num24", "num25", "num26", "num27", "num28", "num29", "name",
				"number", "distance", "sumdistance", "price", "sumprice", "tickettype" },
				resultList);
	}

	private Object[] getTicketNumber(Date startdate, Date enddate,
			List<Object> result, String name, String type) {
		Date date;
		int day = DateUtils.getIntervalDays(startdate, enddate);
		Object[] newobject = new Object[day + 7];
		int number = 0;// 人数总计
		int distance = 0;// 站距
		int sumdistance = 0;// 人公里合计
		BigDecimal price = new BigDecimal(0);// 票面金额
		BigDecimal sumprice = new BigDecimal(0);// 金额合计
		for (int j = 0; j < day; j++) {
			Object[] array = new Object[] {};
			date = DateUtils.add(startdate, j);
			for (int k = 0; k < result.size(); k++) {//该循环里面newobject[j]=array[3]还存问题
				array = (Object[]) result.get(k);
				if (date.equals(array[1])) {
					if (array[2].toString().equals(type)) {
						newobject[j] = array[3];// 人数
						number = number + Integer.parseInt(array[3].toString());
						distance = Integer.parseInt(array[6].toString()) / Integer.parseInt(array[3].toString());
						sumdistance = sumdistance + Integer.parseInt(array[5].toString());
						price = new BigDecimal(array[4].toString()).divide(new BigDecimal(array[3].toString()));
						sumprice = sumprice.add(new BigDecimal(array[4].toString()));
						break;
					}
				} else {
					newobject[j] = "0";
				}
			}
			newobject[day] = name;
			newobject[day + 1] = number;
			newobject[day + 2] = distance;
			newobject[day + 3] = sumdistance;
			newobject[day + 4] = price;
			newobject[day + 5] = sumprice;
			newobject[day + 6] = type;
		}
		return newobject;
	}
	/**
	 * 线路结算汇总查询
	 */
	@Override
	public List<Map<String, Object>> routebalancereport(
			List<PropertyFilter> buildFromHttpRequest) {
		deductDao = new DepartinvoicedeductDao();
		return ListUtil.listToMap(
				new Object[] { "routename", "ticketnum", "totalamount","agentfee","stationservicefee", 
						"fuelfee","computefee", "coolairfee","additionfee",
						"waterfee","insurefee", "overtimefee", "otherfee" ,"allsum","balanceamount"},
				deductDao.routebalancereport(buildFromHttpRequest),
				new Object[] { String.class, Long.class,BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class , BigDecimal.class});
	}
}
