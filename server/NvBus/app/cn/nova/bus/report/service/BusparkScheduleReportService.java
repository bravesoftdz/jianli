/**
 * 
 */
package cn.nova.bus.report.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * @author ice
 *
 */
public interface BusparkScheduleReportService {
	/**
	 * 查询车库发车情况
	 * @param orgid
	 * @param departdate
	 * @return
	 */
   public List<Map<String,Object>> query(long orgid,Date departdate);
}
