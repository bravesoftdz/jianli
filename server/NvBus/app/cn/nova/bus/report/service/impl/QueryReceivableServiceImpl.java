/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b>cn.nova.bus.report.service.impl<br/>
 * <b>文件名：</b>QueryReceivableServiceImpl.java<br/>
 * <b>版本信息：</b>0.1<br/>
 * <b>日期：</b> 2012-4-11  <br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.report.service.impl;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.query.param.Qryparam;
import cn.nova.bus.report.dao.QueryReceivableDao;
import cn.nova.bus.report.service.QueryReceivableService;
import cn.nova.utils.orm.jpa.ListUtil;

/**
 * <b>类描述：</b>网购对账报表<br/>
 * <b>类名称：</b>QueryReceivableServiceImpl.java<br/>
 *
 */
public class QueryReceivableServiceImpl implements QueryReceivableService {

	private QueryReceivableDao dao = new QueryReceivableDao();

	/**
	 * 应收报表
	 * 
	 * @param monty
	 * @return
	 */
	@Override
	public List<Map<String, Object>> queryReceivable(String orgid,
			Date startdate, Date enddate,String orgordate,String sellway,Qryparam qp) {
		dao = new QueryReceivableDao();
		return ListUtil.listToMap(new Object[] { "sellorgname",
				"balanceaccountdate","sellcount","sellprice","returncount","returnamount","returncharge","returncount1","returnamount1","charges1","daycount","stationservicefee"
				, "returnwebnum", "returnwebamount", "returnwebcharges" },
				dao.queryReceivable(orgid, startdate, enddate,orgordate,sellway, qp), new Object[] {String.class,
			Date.class,Long.class, BigDecimal.class,Long.class,BigDecimal.class,BigDecimal.class,Long.class,BigDecimal.class,BigDecimal.class,BigDecimal.class,BigDecimal.class
			, Long.class, BigDecimal.class, BigDecimal.class });
	}

}
