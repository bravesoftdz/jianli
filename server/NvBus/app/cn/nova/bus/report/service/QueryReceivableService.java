/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b>cn.nova.bus.report.service.impl<br/>
 * <b>文件名：</b>QueryAdvanceTicketService.java<br/>
 * <b>版本信息：</b>0.1<br/>
 * <b>日期：</b> 2012-4-11  <br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.report.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.query.param.Qryparam;


/**
 * <b>接口描述：</b>应收报表<br/>
 * <b>创建人：</b>李林青<br/>
 */
public interface QueryReceivableService {

	public List<Map<String, Object>> queryReceivable(
			String orgid,Date startdate, Date enddate,String orgordate,String sellway,Qryparam qp);

}
