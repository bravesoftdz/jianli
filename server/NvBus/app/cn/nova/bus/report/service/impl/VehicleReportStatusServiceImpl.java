/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b>cn.nova.bus.report.service.impl<br/>
 * <b>文件名：</b>VehicleReportStatusServiceImpl.java<br/>
 * <b>版本信息：</b>v4.0<br/>
 * <b>日期：</b>2012-8-29 下午01:53:38<br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.report.service.impl;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.report.dao.VehicleReportStatusDao;
import cn.nova.bus.report.service.VehicleReportStatusService;
import cn.nova.utils.orm.jpa.ListUtil;

/**
 * <b>类描述：</b><br/>
 * <b>类名称：</b>VehicleReportStatusServiceImpl.java<br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2012-8-29 下午01:53:38<br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
public class VehicleReportStatusServiceImpl implements
		VehicleReportStatusService {

	private VehicleReportStatusDao dao = new VehicleReportStatusDao();

	/*
	 * (non-Javadoc) 车辆报班情况一览表
	 * 
	 * @see cn.nova.bus.report.service.VehicleReportStatusService#
	 * queryVehicleReportStatus(java.util.Date, java.lang.String)
	 */
	@Override
	public List<Map<String, Object>> queryVehicleReportStatus(Date departdate,
			String orgid, String reportway) {
		dao = new VehicleReportStatusDao();
		return ListUtil.listToMap(new Object[] { "name", "code", "starttime",
				"vehicleno", "remark", "reporttime", "reportway" },
				dao.queryVehicleReportStatus(departdate, orgid, reportway), new Object[] {
						String.class, String.class, String.class, String.class,
						String.class, String.class, String.class });
	}

	/*
	 * (non-Javadoc) 车辆售票流量统计
	 * 
	 * @see
	 * cn.nova.bus.report.service.VehicleReportStatusService#queryVehicleTicketCount
	 * (java.lang.String, java.lang.Long, java.util.Date, java.lang.Long,
	 * java.lang.Long, java.lang.Long, java.lang.Long, java.lang.Long)
	 * isEmpty 用来判断是否查询售票数为0的班次
	 */
	@Override
	public List<Map<String, Object>> queryVehicleTicketCount(String orgid,
			long departstation, Date departdate, long routeid, long unitid,
			long vehicletypeid, long stationid, long scheduleid, Date enddate,
			String sellorgid, Date selldate, Date sellenddate, Boolean isEmpty) {
//		List<Object> result = new ArrayList<Object>();
		String schedulecode="";
		dao = new VehicleReportStatusDao();
		if(scheduleid>0){
			schedulecode = dao.queryScheduleCode(scheduleid);
		}
		List<Object> result = dao.queryVehicleTicketCount(orgid, departstation,
				departdate, routeid, unitid, vehicletypeid, stationid,
				schedulecode, enddate, sellorgid, selldate, sellenddate);
//		List<Object> stlist = dao.getStationDetail(orgid, departstation,
//				departdate, routeid, stationid, scheduleid, enddate, sellorgid,
//				selldate, sellenddate);// 站点明细
//		String code = "";
//		String stationdetail = "";
//		Object[] listobj = new Object[] {};
//		Object[] object = new Object[] {};
//		for (int i = 0; i < list.size(); i++) {
//			listobj = (Object[]) list.get(i);
//			code = (String) listobj[3];
//			for (int j = 0; j < stlist.size(); j++) {
//				object = (Object[]) stlist.get(j);
//				if (listobj[0].equals(object[2])) {// 判断发车日期
//					if (code.equals(object[0])) {// 判断班次编码
//						stationdetail = stationdetail + object[1] + ";";
//					}
//				}
//			}
//			Object[] newobject = new Object[] { listobj[0], listobj[1],
//					listobj[2], listobj[3], listobj[4], listobj[5], listobj[6],
//					listobj[7], listobj[8], listobj[9], listobj[10],
//					listobj[11], listobj[12], listobj[13], listobj[14],
//					stationdetail };
//			result.add(newobject);
//			stationdetail = "";
//		}
//		result=list;
		if (isEmpty) {      
			Object[] obj = new Object[]{};
			List<Object> listObj = dao.querySellnumIsEmpty(orgid, departstation,
					departdate, routeid, stationid, schedulecode, enddate, unitid, vehicletypeid );
			for (int i = 0; i < listObj.size(); i++) {
				obj = (Object[]) listObj.get(i);
				Object[] newObj = new Object[]{obj[0], obj[1], obj[2], obj[3],
						obj[4], obj[5], obj[6], obj[7], obj[8], obj[9], obj[10],
						obj[11], obj[12], obj[13], obj[14], obj[15] };
				result.add(newObj);//查询售票数为0的班次
			}
		}
		return ListUtil.listToMap(new Object[] { "departdate", "departtime",
				"stationname", "code", "routename", "totaleprice",
				"soldeatnum", "solddistance", "seatnum", "seatdistance",
				"soldratio", "disratio", "unitname", "vehicletype", "balance",
				"stationdetail" }, result, new Object[] { Date.class,
				String.class, String.class, String.class, String.class,
				BigDecimal.class, Long.class, BigDecimal.class, Long.class,
				BigDecimal.class, String.class, String.class, String.class,
				String.class, BigDecimal.class, String.class });
	}

}