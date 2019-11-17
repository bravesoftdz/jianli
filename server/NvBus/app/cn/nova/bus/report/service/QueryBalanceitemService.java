/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b>cn.nova.bus.report.service<br/>
 * <b>文件名：</b>QueryBalanceitemService.java<br/>
 * <b>版本信息：</b>v4.0<br/>
 * <b>日期：</b>2012-11-1 上午11:16:53<br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.report.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * <b>类描述：</b><br/>
 * <b>类名称：</b>QueryBalanceitemService.java<br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2012-11-1 上午11:16:53<br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
public interface QueryBalanceitemService {

	/**
	 * 运费结算明细表 (网页嵌套)
	 * @param vehicleno 
	 * @param unitid 
	 * @return
	 */
	public List<Map<String, Object>> getBalanceitem(String orgid, Date startdate, Date enddate, Long unitid, String vehicleno);
	
	/**
	 * 运费结算明细表 Delphi
	 * @param vehicleno 
	 * @param unitid 
	 * @return
	 */
	public List<Map<String, Object>> getBalanceitemDelphi(String orgid, Date startdate, Date enddate, Long unitid, String vehicleno,String routename,String balanceno);

	public String genDelphiField(String orgid);

	public List<Map<String, Object>> queryBalanceitem(String orgid, Date startdate, Date enddate, Long unitid,
			String vehicleno, String routename, String balanceno, String delphiField);
	
}
