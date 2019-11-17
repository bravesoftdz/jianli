package cn.nova.bus.report.service.impl;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.map.HashedMap;

import cn.nova.bus.report.dao.TicketTurnOverReportDao;
import cn.nova.bus.report.service.TicketTurnOverReportService;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;

public class TicketTurnOverReportServiceImpl implements
		TicketTurnOverReportService {
	private TicketTurnOverReportDao dao = new TicketTurnOverReportDao();

	@Override
	public Map<String, Object> queryTicketErrorReport(
			List<PropertyFilter> propertyFilter, int querytype) {
		List<Object> list = dao.queryTicketErrorReport(propertyFilter);
		dao = new TicketTurnOverReportDao();

		// 记录横坐标
		Map<String, Integer> x = new HashedMap();
		// 记录纵坐标
		Map<String, Integer> y = new HashedMap();
		List<Object> panels = new ArrayList<Object>();
		panels.add("票款日期");
		List<Object> results = new ArrayList<Object>();
		int j = 1;
		// 生成横向坐标
		for (Object result : list) {
			Object[] rs = (Object[]) result;
			if (x.get(rs[2] + "") == null) {
				x.put(rs[2] + "", j);
				if (querytype == 0) {// 默认全部查询，使用复合表头显示长短款
					panels.add( rs[2] + "|长款");
					panels.add( rs[2] + "|短款");
//					panels.add(rs[1] + " " + rs[2] + "|长款");
//					panels.add(rs[1] + " " + rs[2] + "|短款");
					j += 2;
				} else {// 二选一显示
					panels.add(rs[2]);
//					panels.add(rs[1] + " " + rs[2]);
					j += 1;
				}
			}
		}
		// querytype为0时默认查询长短款
		int length = querytype == 0 ? x.size() * 2 + 2: x.size() + 2;
		for (Object result : list) {
			Object[] rs = (Object[]) result;
			// 生成纵向坐标
			if (y.get(rs[0] + "") == null) {
				Object[] datas = new Object[length];
				datas[0] = rs[0];
				datas[length - 1] = 0;
				results.add(datas);
				y.put(rs[0] + "", results.size() - 1);
			}

			// 根据坐标设置数据
			Float d = new Float(rs[3] + "");
			if (querytype == 0) {// 长短款复合显示
				if (d > 0) {
					((Object[]) results.get(y.get(rs[0] + "")))[x.get(rs[2]
							+ "")] = rs[3];
				} else if (d < 0) {
					((Object[]) results.get(y.get(rs[0] + "")))[x.get(rs[2]
							+ "") + 1] = rs[3];
				}
				// 计算横向小计
				((Object[]) results.get(y.get(rs[0] + "")))[length - 1] = new BigDecimal(
						((Object[]) results.get(y.get(rs[0] + "")))[length - 1]
								+ "").add(new BigDecimal(rs[3] + ""));

			} else if (querytype == 1 && d > 0) {// 长款
				((Object[]) results.get(y.get(rs[0] + "")))[x.get(rs[2] + "")] = rs[3];
				// 计算横向小计
				((Object[]) results.get(y.get(rs[0] + "")))[length - 1] = new BigDecimal(
						((Object[]) results.get(y.get(rs[0] + "")))[length - 1]
								+ "").add(new BigDecimal(rs[3] + ""));
			} else if (querytype == 2 && d < 0) {// 短款
				((Object[]) results.get(y.get(rs[0] + "")))[x.get(rs[2] + "")] = rs[3];
				// 计算横向小计
				((Object[]) results.get(y.get(rs[0] + "")))[length - 1] = new BigDecimal(
						((Object[]) results.get(y.get(rs[0] + "")))[length - 1]
								+ "").add(new BigDecimal(rs[3] + ""));
			}

		}

		// 返回数据集类型
		Object[] fieldtypes = new Object[length];
		// 固定类型设置
		fieldtypes[0] = Date.class;
		for (int i = 1; i < fieldtypes.length; i++) {
			fieldtypes[i] = BigDecimal.class;
		}
		// 返回数据集表头字段名称
		String title = "";
		panels.add("小计");
		for (int i = 0; i < panels.size(); i++) {
			title += "".equals(title) ? panels.get(i) : ":" + panels.get(i);
		}
		play.Logger.info("title:%s", title);
		// 返回多个数据
		Map<String, Object> returndatas = new HashMap<String, Object>();
		returndatas.put("title", title);
		returndatas.put("resultmap",
				ListUtil.listToMap(panels.toArray(), results, fieldtypes));
		return returndatas;

	}
	
	@Override
	public List<Map<String, Object>> qryticketusedetail(String orgids, Date departdate, Date enddate, String tickettype,
			String ticketusetype) {
		return ListUtil.listToMap(
				new Object[] { "tickettype","usenum","ticketstartno","ticketendno","ticketusetype" },
				dao.qryticketusedetail(orgids,departdate,enddate,tickettype,ticketusetype),
				new Object[] { String.class, long.class, String.class,
						String.class, String.class });
	}
}
