/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b>cn.nova.bus.archive.service<br/>
 * <b>文件名：</b>VipService.java<br/>
 * <b>版本信息：</b>0.1<br/>
 * <b>日期：</b> 2011-7-20 下午04:32:29 <br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.archive.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.archive.model.Vip;
import cn.nova.bus.archive.model.Vipcardreturn;
import cn.nova.bus.security.Global;
import cn.nova.utils.orm.PropertyFilter;

/**
 * <b>类描述：</b><br/>
 * <b>类名称：</b>VipService.java<br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2011-7-20 下午04:32:29 <br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
public interface VipService {

	public boolean save(Vip vip);

	public Vip findById(Long id, String status);

	/**
	 * 按VIP卡号获取VIP卡信息
	 * 
	 * @param cardno
	 * @return
	 */
	public Vip findByCardNo(String cardno, String status);

	/**
	 * 按顾客ID获取VIP卡信息
	 * 
	 * @param cardno
	 * @return
	 */
	public Vip findByCustomerID(long customerid, String status);

	/**
	 * 退卡时用来获取顾客姓名及发卡工本费等信息
	 * 
	 * @param propertyFilterList
	 * @return
	 */
	List<Map<String, Object>> getVipByCardno(
			List<PropertyFilter> propertyFilterList);

	/**
	 * 退卡
	 * 
	 * @param vipreturn
	 * @param global
	 * @return
	 */
	public Long saveVipreturn(Vipcardreturn vipreturn, Global global);

	/**
	 * 补卡后明细查询
	 */
	public List<Map<String, Object>> queryVipremainmoneytransfer(
			List<PropertyFilter> propertyFilterList);
	
}
