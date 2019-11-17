package cn.nova.bus.report.service.impl;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.report.dao.VehicleStowageReportDao;
import cn.nova.bus.report.service.VehicleStowageReportService;
import cn.nova.utils.orm.jpa.ListUtil;

/**
 * <b>类描述：车辆营运配载统计表</b><br/>
 * <b>类名称：</b>VehicleStowageReportService.java<br/>
 * <b>创建人：</b><a href="mailto:huanghaoze@nova.net.cn">黄浩泽</a><br/>
 * <b>创建时间：</b>2012-4-28 <br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
public class VehicleStowageReportServiceImpl implements
		VehicleStowageReportService {

	private VehicleStowageReportDao dao = new VehicleStowageReportDao();

	/**
	 * 车辆营运配载统计表
	 * 
	 * @param startdate
	 * @return
	 */
	@Override
	public List<Map<String, Object>> queryVehicleStowage(Date startdate,
			Date enddate, String orgid, Long routeid, String isovertime) {
		dao = new VehicleStowageReportDao();
		return ListUtil.listToMap(new Object[] { "orgname", "departdate",
				"schnum", "ticketnum", "peopledistance", "balanceamount",
				"schedulenum" }, dao.queryVehicleStowage(startdate, enddate,
				orgid, routeid, isovertime), new Object[] { String.class,
				Date.class, Long.class, Long.class, BigDecimal.class,
				BigDecimal.class, Long.class });
	}

}
