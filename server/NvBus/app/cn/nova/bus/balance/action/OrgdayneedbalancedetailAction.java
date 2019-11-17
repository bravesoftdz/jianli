/**
 * <b>项目名：</b>NvBusWeb<br/>
 * <b>包名：</b>cn.nova.bus.balance.action<br/>
 * <b>文件名：</b>OrgdayneedbalancedetailAction.java<br/>
 * <b>版本信息：</b>0.1<br/>
 * <b>日期：</b> 2011-7-14 上午09:41:59 <br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.balance.action;

import cn.nova.bus.action.BaseAction;
import java.util.List;
import java.util.Map;

import cn.nova.bus.balance.model.Orgdayneedbalancedetail;
import cn.nova.bus.balance.service.OrgdayneedbalancedetailService;
import cn.nova.bus.balance.service.impl.OrgdayneedbalancedetailServiceImpl;
import cn.nova.utils.web.ServletPropertyFilterUtil;

/**
 * <b>类描述：</b><br/>
 * <b>类名称：</b>OrgdayneedbalancedetailAction.java<br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2011-7-14 上午09:41:59 <br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
public class OrgdayneedbalancedetailAction extends BaseAction{

	private Orgdayneedbalancedetail orgdayneedbalancedetail;
	private List<Map<String, Object>> orgdaydetailMap;

	private OrgdayneedbalancedetailService orgdaydetailService;

	public String query() {
		try {
			orgdaydetailService = new OrgdayneedbalancedetailServiceImpl();
			setOrgdaydetailMap(orgdaydetailService
					.query(ServletPropertyFilterUtil
							.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public Orgdayneedbalancedetail getOrgdayneedbalancedetail() {
		return orgdayneedbalancedetail;
	}

	public void setOrgdayneedbalancedetail(
			Orgdayneedbalancedetail orgdayneedbalancedetail) {
		this.orgdayneedbalancedetail = orgdayneedbalancedetail;
	}

	public List<Map<String, Object>> getOrgdaydetailMap() {
		return orgdaydetailMap;
	}

	public void setOrgdaydetailMap(List<Map<String, Object>> orgdaydetailMap) {
		this.orgdaydetailMap = orgdaydetailMap;
	}

}
