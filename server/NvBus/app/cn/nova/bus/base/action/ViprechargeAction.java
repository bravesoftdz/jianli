/**
 * <b>项目名：</b>NvBusWeb<br/>
 * <b>包名：</b>cn.nova.bus.base.action<br/>
 * <b>文件名：</b>ViprechargeAction.java<br/>
 * <b>版本信息：</b>v4.0<br/>
 * <b>日期：</b>2012-11-30 下午05:26:39<br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.base.action;

import cn.nova.bus.action.BaseAction;
import java.util.List;
import java.util.Map;

import cn.nova.bus.base.service.ViprechargeService;
import cn.nova.bus.base.service.impl.ViprechargeServiceImpl;
import cn.nova.utils.web.ServletPropertyFilterUtil;

/**
 * <b>类描述：</b><br/>
 * <b>类名称：</b>ViprechargeAction.java<br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2012-11-30 下午05:26:39<br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
public class ViprechargeAction extends BaseAction{

	private ViprechargeService rechargeService;
	private List<Map<String, Object>> viprechargeMap;

	/**
	 * VIP充值明细查询
	 * 
	 * @return
	 */
	public String queryViprecharge() {
		try {
			rechargeService = new ViprechargeServiceImpl();
			setViprechargeMap(rechargeService
					.queryViprecharge(ServletPropertyFilterUtil
							.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	/**
	 * VIP消费查询
	 * 
	 * @return
	 */
	public String queryViconsume() {
		try {
			rechargeService = new ViprechargeServiceImpl();
			setViprechargeMap(rechargeService
					.queryVipconsume(ServletPropertyFilterUtil
							.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	/**
	 * VIP消费明细查询
	 * 
	 * @return
	 */
	public String queryViconsumeldetail() {
		try {
			rechargeService = new ViprechargeServiceImpl();
			setViprechargeMap(rechargeService
					.queryVipconsumeldetail(ServletPropertyFilterUtil
							.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	/**
	 * VIP购票明细汇总
	 * 
	 * @return
	 */
	public String querySellticket() {
		try {
			rechargeService = new ViprechargeServiceImpl();
			setViprechargeMap(rechargeService
					.qryVipsellticket(ServletPropertyFilterUtil
							.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public List<Map<String, Object>> getViprechargeMap() {
		return viprechargeMap;
	}

	public void setViprechargeMap(List<Map<String, Object>> viprechargeMap) {
		this.viprechargeMap = viprechargeMap;
	}

}
