/**
 * <b>项目名：</b>NvBusWeb<br/>
 * <b>包名：</b>cn.nova.bus.balance.action<br/>
 * <b>文件名：</b>OrgdayneedbalanceAction.java<br/>
 * <b>版本信息：</b>0.1<br/>
 * <b>日期：</b> 2011-7-14 上午09:41:08 <br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.balance.action;

import cn.nova.bus.action.BaseAction;
import java.util.List;
import java.util.Map;

import cn.nova.bus.balance.model.Orgdayneedbalance;
import cn.nova.bus.balance.service.OrgdayneedbalanceService;
import cn.nova.bus.balance.service.impl.OrgdayneedbalanceServiceImpl;
import cn.nova.utils.web.ServletPropertyFilterUtil;

/**
 * <b>类描述：</b><br/>
 * <b>类名称：</b>OrgdayneedbalanceAction.java<br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2011-7-14 上午09:41:08 <br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
public class OrgdayneedbalanceAction extends BaseAction{

	private Orgdayneedbalance orgdayneedbalance;
	private List<Map<String, Object>> orgdayMap;

	private OrgdayneedbalanceService orgdayService;

	public String query() {
		try {
			orgdayService = new OrgdayneedbalanceServiceImpl();
			setOrgdayMap(orgdayService.query(ServletPropertyFilterUtil
					.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			e.getMessage();
		}
		return "json";
	}

	public Orgdayneedbalance getOrgdayneedbalance() {
		return orgdayneedbalance;
	}

	public void setOrgdayneedbalance(Orgdayneedbalance orgdayneedbalance) {
		this.orgdayneedbalance = orgdayneedbalance;
	}

	public List<Map<String, Object>> getOrgdayMap() {
		return orgdayMap;
	}

	public void setOrgdayMap(List<Map<String, Object>> orgdayMap) {
		this.orgdayMap = orgdayMap;
	}

}
