package cn.nova.bus.report.service.impl;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.report.dao.QueryBillinuseDao;
import cn.nova.bus.report.service.QueryBillinuseService;
import cn.nova.bus.sale.model.Ticketreprint;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;

public class QueryBillinuseServiceImpl implements QueryBillinuseService {
	
	private QueryBillinuseDao dao = new QueryBillinuseDao();
	/**
	 * 售票员票证使用情况查询
	 * 
	 * @param monty
	 * @return
	 */
	@Override
	public List<Map<String, Object>> queryBillinuseReport(Date startdate,
			Date enddate, Long recipients, String status) {
		dao = new QueryBillinuseDao();
		return ListUtil.listToMap(new Object[] { "code", "name", "startno",
				"endno", "nextno", "total", "leftnum", "usenum", "returnnum",
				"sellnum", "cancelnum", "damagednum" },
				dao.qryBillinuseReport(startdate, enddate, recipients, status),
				new Object[] { String.class, String.class, Long.class,
						Long.class, Long.class, Long.class, Long.class,
						Long.class, Long.class, Long.class, Long.class,
						Long.class });
	}

	/**
	 * 客运站结算单汇总表
	 * 
	 * @param month
	 * @return
	 */
	@Override
	public List<Map<String, Object>> queryDepartinvoices(
			List<PropertyFilter> propertyFilter) {
		return null;
	}

	/**
	 * 客运结算单明细查询
	 * 
	 * @param month
	 * @return
	 */
	@Override
	public List<Map<String, Object>> queryDepartinvoicesdetail(
			List<PropertyFilter> propertyFilter) {
		return null;
	}

	@Override
	public List<Map<String, Object>> queryBilldetailReport(String orgids,
			Date startdate, Date enddate, Long recipients, String status,
			Long billtype, Long storageid) {
		dao = new QueryBillinuseDao();
		return ListUtil.listToMap(new Object[] { "orgname", "sellbyname",
				"createtime", "bsname", "btcode", "btname", "startno",
				"nextno", "billno", "total", "leftnum", "caoffnum" }, dao
				.queryBilldetailReport(orgids, startdate, enddate, recipients,
						status, billtype, storageid), new Object[] {
				String.class, String.class, Timestamp.class, String.class,
				String.class, String.class, BigDecimal.class, BigDecimal.class,
				String.class, BigDecimal.class, BigDecimal.class,
				BigDecimal.class });
	}

	@Override
	public List<Map<String, Object>> queryTicketReport(
			List<PropertyFilter> propertyFilter, String startticketno,
			String endticketno) {
		dao = new QueryBillinuseDao();
		String orgids = null;
		Long sellby = null;
		String ticketstatus = null;
		Date startselltime = null;
		Date endselltime = null;
		if (propertyFilter != null && propertyFilter.size() > 0) {
			for (int t = 0; t < propertyFilter.size(); t++) {
				if (propertyFilter.get(t).getPropertyFullName()
						.equals("t!orgid")) {
					orgids = (String) propertyFilter.get(t).getMatchValue();
					continue;
				}
				if (propertyFilter.get(t).getPropertyFullName()
						.equals("t!sellby")) {
					sellby = (Long) propertyFilter.get(t).getMatchValue();
					continue;
				}

				if (propertyFilter.get(t).getPropertyFullName()
						.equals("t!ticketstatus")) {
					ticketstatus = (String) propertyFilter.get(t)
							.getMatchValue();
					continue;
				}
				if (propertyFilter.get(t).getPropertyFullName()
						.equals("t!startselltime")) {
					startselltime = (Date) propertyFilter.get(t)
							.getMatchValue();
					continue;
				}
				if (propertyFilter.get(t).getPropertyFullName()
						.equals("t!endselltime")) {
					endselltime = (Date) propertyFilter.get(t).getMatchValue();
					continue;
				}
			}
		}

		return ListUtil.listToMap(new Object[] { "orgname", "startselltime",
				"endselltime", "startticketno", "endticketno", "z_sellnum",
				"z_totalamount", "r_sellnum", "r_totalamount", "c_sellnum",
				"c_totalamount", "sellnum", "totalamount", "b_sellnum",
				"returnvouchernum", "totalnum" }, dao.queryTicketReport(orgids,
				sellby, ticketstatus, startticketno, endticketno,
				startselltime, endselltime), new Object[] { String.class,
				String.class, String.class, String.class, String.class,
				Long.class, BigDecimal.class, Long.class, BigDecimal.class,
				Long.class, BigDecimal.class, Long.class, BigDecimal.class,
				Long.class, Long.class, Long.class });
	}

	/**
	 * 车票换号重打查询
	 * 
	 * @param propertyFilters
	 * @return
	 */
	public List<Map<String, Object>> queryTicketReprint(
			List<PropertyFilter> propertyFilters) {
		dao = new QueryBillinuseDao();
		return ListUtil.listToMap(new Object[] { Ticketreprint.class,
				"orgname", "sellname", "changename", "departstationname",
				"reachstationname" }, dao.queryTicketReprint(propertyFilters),
				new Object[] { Ticketreprint.class, String.class, String.class,
						String.class, String.class, String.class });
	}
}
