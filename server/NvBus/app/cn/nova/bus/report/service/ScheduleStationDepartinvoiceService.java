/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b>cn.nova.bus.price.service<br/>
 * <b>文件名：</b>ScheduleStationDepartinvoiceService.java<br/>
 * <b>版本信息：</b>0.1<br/>
 * <b>日期：</b> 2012-2-29 下午01:37:57 <br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.report.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * <b>类描述：班线和停靠点运量汇总表</b><br/>
 * <b>类名称：</b>ScheduleStationDepartinvoiceService.java<br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2012-2-29 下午01:37:57 <br/>
 * <b>关键修改：添加线路查询条件</b><br/>
 * <b>修改时间：2012-06-29</b><br/>
 * <b>修改人：hhz</b><br/>
 */
public interface ScheduleStationDepartinvoiceService {

	public List<Map<String, Object>> query(String orgid, Date startdate,
			Date enddate, Long routeid,Long scheduleid);

}
