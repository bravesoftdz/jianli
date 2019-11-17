package cn.nova.bus.report.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * <b>类描述：营收运量统计表</b><br/>
 * <b>类名称：</b>IncomeDepartivoiceSerivce.java<br/>
 * <b>创建人：</b><a href="mailto:huanghaoze@nova.net.cn">黄浩泽</a><br/>
 * <b>创建时间：</b>2012-05-03  <br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
public interface IncomeDepartivoiceSerivce {
	
	/**
	 * 营收运量统计表
	 * @param month
	 * @param checkstationid
	 * @param routeid
	 * @param unitid
	 * @return
	 */
	public List<Map<String, Object>> queryIncomeDepartivoice(String orgid,Date month,String checkstationid, 
			Long routeid ,Long unitid);

	public List<Map<String, Object>> qryStationUnitBalance(String orgid, Date startdate, Date enddate, long vehicleid,
			Long unitid, String sign);
}
