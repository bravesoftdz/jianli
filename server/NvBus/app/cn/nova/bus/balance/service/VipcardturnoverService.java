/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b>cn.nova.bus.balance.service<br/>
 * <b>文件名：</b>VipcardturnoverService.java<br/>
 * <b>版本信息：</b>v4.0<br/>
 * <b>日期：</b>2012-12-6 下午02:40:12<br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.balance.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.archive.model.Vipcardturnover;
import cn.nova.bus.security.Global;
import cn.nova.utils.orm.PropertyFilter;

/**
 * <b>类描述：</b><br/>
 * <b>类名称：</b>VipcardturnoverService.java<br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2012-12-6 下午02:40:12<br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
public interface VipcardturnoverService {

	/**
	 * @param propertyFilterList
	 * @return
	 */
	List<Map<String, Object>> query(List<PropertyFilter> propertyFilterList);

	/**
	 * 应缴款查询
	 * 
	 * @param startdate
	 * @param enddate
	 * @param userid
	 * @return
	 */
	List<Map<String, Object>> queryTurnover(Date startdate, Date enddate,
			Long userid);

	/**
	 * @param userid
	 * @return
	 */
	List<Map<String, Object>> queryVipturnover(Long userid);

	/**
	 * @param vipcardturnover
	 * @return
	 */
	Vipcardturnover save(Vipcardturnover vipcardturnover, Global global,
			String moneydate);

}
