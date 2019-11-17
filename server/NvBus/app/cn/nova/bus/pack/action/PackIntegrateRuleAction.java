package cn.nova.bus.pack.action;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import cn.nova.bus.action.BaseAction;
import cn.nova.bus.pack.model.PackIntegrateRule;
import cn.nova.bus.pack.service.PackIntegrateRuleService;
import cn.nova.bus.pack.service.PackService;
import cn.nova.bus.pack.service.impl.PackIntegrateRuleServiceImpl;
import cn.nova.utils.web.ServletPropertyFilterUtil;

public class PackIntegrateRuleAction extends BaseAction {
	private List<Map<String, Object>> packIntegrateRuleList;
	private long orgid;
	private BigDecimal money;
	private String clienttype;
	private Long integrater;
	private PackIntegrateRuleService packIntegrateRuleService;
	private PackIntegrateRule packIntegrateRule;

	public PackIntegrateRuleService getPackIntegrateRuleService() {
		return packIntegrateRuleService;
	}

	public void setPackIntegrateRuleService(
			PackIntegrateRuleService packIntegrateRuleService) {
		this.packIntegrateRuleService = packIntegrateRuleService;
	}

	public PackIntegrateRule getPackIntegrateRule() {
		return packIntegrateRule;
	}

	public void setPackIntegrateRule(PackIntegrateRule packIntegrateRule) {
		this.packIntegrateRule = packIntegrateRule;
	}

	public List<Map<String, Object>> getPackIntegrateRuleList() {
		return packIntegrateRuleList;
	}

	public void setPackIntegrateRuleList(
			List<Map<String, Object>> packIntegrateRuleList) {
		this.packIntegrateRuleList = packIntegrateRuleList;
	}

	public long getOrgid() {
		return orgid;
	}

	public void setOrgid(long orgid) {
		this.orgid = orgid;
	}

	public BigDecimal getMoney() {
		return money;
	}

	public void setMoney(BigDecimal money) {
		this.money = money;
	}

	public String getClienttype() {
		return clienttype;
	}

	public void setClienttype(String clienttype) {
		this.clienttype = clienttype;
	}

	public Long getIntegrater() {
		return integrater;
	}

	public void setIntegrater(Long integrater) {
		this.integrater = integrater;
	}

	public String integraterToMoney() {
		packIntegrateRuleService = new PackIntegrateRuleServiceImpl();
		packIntegrateRuleList = packIntegrateRuleService.integraterToMoney(
				integrater, clienttype, orgid);

		return "json";
	}

	public String queryPercent() {
		packIntegrateRuleService = new PackIntegrateRuleServiceImpl();
		packIntegrateRuleList = packIntegrateRuleService.queryPercent(
				clienttype, orgid);
		return "json";
	}

	public String queryPackIntegrateRule() {
		packIntegrateRuleService = new PackIntegrateRuleServiceImpl();
		packIntegrateRuleList = packIntegrateRuleService
				.queryPackIntegrateRule(ServletPropertyFilterUtil
						.buildFromHttpRequest());
		return "json";
	}

	/**
	 * 设置积分规则
	 * 
	 * @return
	 */
	public String savePackIntegrateRule() {
		packIntegrateRuleService = new PackIntegrateRuleServiceImpl();
		try {
//			if (packIntegrateRule.getId() == 0) {
//				packIntegrateRule = packIntegrateRuleService
//						.query(packIntegrateRule);
//				if (packIntegrateRule != null) {
//					setMsg("数据库已存在该配置，请做修改或删除操作！");
//					markFail();
//					return "json";
//				}
//			}
			packIntegrateRule = packIntegrateRuleService
					.savePackIntegrateRule(packIntegrateRule);
			setMsg("保存成功！");
			markSuccess();
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			setMsg("保存失败！");
			markFail();
		}
		return "json";
	}

	public String delPackIntegrateRule() {
		packIntegrateRuleService = new PackIntegrateRuleServiceImpl();
		if (packIntegrateRule != null) {
			if (packIntegrateRuleService
					.delPackIntegrateRule(packIntegrateRule)) {
				setMsg("删除成功！");
				markSuccess();
			} else {
				setMsg("删除失败！");
				markFail();
			}
		} else {
			setMsg("删除失败！");
			markFail();
		}
		return "json";
	}

}
