/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b>cn.nova.bus.report.service.impl<br/>
 * <b>文件名：</b>StopDepartinvoiceServiceImpl.java<br/>
 * <b>版本信息：</b>0.1<br/>
 * <b>日期：</b> 2012-2-21 上午09:35:26 <br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.report.service.impl;

import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.report.dao.VehicleStationDepartinvoiceDao;
import cn.nova.bus.report.service.VehicleStationDepartinvoiceService;
import cn.nova.utils.orm.jpa.ListUtil;

/**
 * <b>类描述：车辆停靠点运量汇总表</b><br/>
 * <b>类名称：</b>StopDepartinvoiceServiceImpl.java<br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2012-2-21 上午09:35:26 <br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
public class VehicleStationDepartinvoiceServiceImpl implements
		VehicleStationDepartinvoiceService {

	private VehicleStationDepartinvoiceDao dao = new VehicleStationDepartinvoiceDao();

	@Override
	public List<Map<String, Object>> query(String orgid, Date startdate,
			Date enddate, Long vehicleid, Long routeid, Long stationid) {
		dao = new VehicleStationDepartinvoiceDao();
		return ListUtil.listToMap(new Object[] { "orgname", "vehicleno",
				"stationname", "routename", "dpticketnum", "dticketnum",
				"percentnum", "dpamount", "damount", "percentamount",
				"dpdistance", "ddistance", "percentdistance" }, dao.query(
				orgid, startdate, enddate, vehicleid, routeid, stationid),
				new Object[] { String.class, String.class, String.class,
						String.class, Long.class, Long.class, String.class,
						Double.class, Double.class, String.class, Long.class,
						Long.class, String.class });
	}

}
