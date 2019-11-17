/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b>cn.nova.bus.report.service.impl<br/>
 * <b>文件名：</b>QueryAdvanceTicketServiceImpl.java<br/>
 * <b>版本信息：</b>0.1<br/>
 * <b>日期：</b> 2012-4-11  <br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.report.service.impl;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.report.dao.QueryAdvanceTicketDao;
import cn.nova.bus.report.service.QueryAdvanceTicketService;
import cn.nova.utils.orm.jpa.ListUtil;

/**
 * <b>类描述：</b>预售票情况查询月报表<br/>
 * <b>类名称：</b>QueryAdvanceTicketServiceImpl.java<br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b> <br/>
 * <b>关键修改：</b>整个查询语句都修改<br/>
 * <b>修改时间：</b>2012-4-11 <br/>
 * <b>修改人：</b><a href="mailto:huanghaoze@nova.net.cn">hhz</a><br/>
 */
public class QueryAdvanceTicketServiceImpl implements QueryAdvanceTicketService {
	private QueryAdvanceTicketDao dao = new QueryAdvanceTicketDao();
	/**
	 * 预售票情况查询月报表
	 * 
	 * @param monty
	 * @return
	 */
	@Override
	public List<Map<String, Object>> queryAdvanceTicket(String orgid,Long sellid,
			Date startdate, Date enddate,Long routeid,Long tosid,Boolean isgroupbyroute,Date dptstartdate, Date dptenddate) {
		dao = new QueryAdvanceTicketDao();
		return ListUtil.listToMap(new Object[] { 
				"orgname","selldate","routename","sellcount","sellprice","returncount","returnprice",
				"charges","checkcount","ckprice","stationservicefee",
				"computefee","coolairfee","additionfee"},
				dao.queryAdvanceTicket(orgid,sellid, startdate, enddate, routeid, tosid,isgroupbyroute,dptstartdate,dptenddate), new Object[] {
						String.class,Date.class,String.class,Long.class, BigDecimal.class, Long.class, BigDecimal.class,
						BigDecimal.class,Long.class,BigDecimal.class,BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class});
	}

}
