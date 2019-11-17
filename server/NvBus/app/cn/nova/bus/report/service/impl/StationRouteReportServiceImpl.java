package cn.nova.bus.report.service.impl;

import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.report.dao.StationRouteReportDao;
import cn.nova.bus.report.service.StationRouteReportService;
import cn.nova.utils.orm.jpa.ListUtil;


/**
 * <b>类描述：</b>客运班线调查统计表<br/>
 * <b>类名称：</b>StationRouteReportServiceImpl.java<br/>
 * <b>创建人：</b><a href="mailto:huanghaoze@nova.net.cn">hhz</a><br/>
 * <b>创建时间：</b>2013-08-08 上午09:34:11 <br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
public class StationRouteReportServiceImpl implements StationRouteReportService {

	private StationRouteReportDao stationroutrpdao = new StationRouteReportDao();
	@Override
	public List<Map<String, Object>> query(String scheduleorgid, Date startdate,
			Date enddate) {
		stationroutrpdao = new StationRouteReportDao();
		return ListUtil.listToMap(new Object[] { 
				"startname","endname","uintnum",
				"s1","s2","s3",
				"v1","v2","v3",
				"p1","p2","p3",
				"rate","remark" }, 
				stationroutrpdao.query(scheduleorgid,startdate,enddate),
				new Object[] {
				String.class, String.class,long.class,
				Long.class, Long.class,Long.class,
				Long.class, Long.class,Long.class,
				Long.class, Long.class,Long.class,
				String.class,String.class });
	}
	

}
