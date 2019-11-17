package cn.nova.bus.report.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * <b>类描述：</b>客运班线调查统计表<br/>
 * <b>类名称：</b>StationRouteReportService.java<br/>
 * <b>创建人：</b><a href="mailto:huanghaoze@nova.net.cn">hhz</a><br/>
 * <b>创建时间：</b>2013-08-08 上午09:34:11 <br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
public interface StationRouteReportService {
	
	public List<Map<String, Object>> query(String scheduleorgid,Date startdate ,Date enddate); 
}
