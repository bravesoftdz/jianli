package cn.nova.bus.balance.action;

import cn.nova.bus.action.BaseAction;
import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import util.CurrentUtil;
import cn.nova.bus.balance.model.Balancescheduleminimum;
import cn.nova.bus.balance.service.BalancescheduleminimumService;
import cn.nova.bus.balance.service.impl.BalancescheduleminimumServiceImpl;
import cn.nova.bus.security.Global;
import cn.nova.utils.web.ServletPropertyFilterUtil;

/**
 * 
 * <p>
 * Title: 保险公司管理
 * </p>
 * <p>
 * Description:
 * </p>
 * <p>
 * Copyright: Copyright (c) 2011
 * </p>
 * <p>
 * Company: nova
 * </p>
 * 
 * @author lijh
 * @version 0.1
 */
public class BalancescheduleminimumAction extends BaseAction{

	private Balancescheduleminimum minimum;
	private List<Balancescheduleminimum> minimumlist;
	private List<Map<String, Object>> minimummap;

	private BalancescheduleminimumService minimumService;

	public String query() {
		try {
			minimumService = new BalancescheduleminimumServiceImpl();
			setMinimummap(minimumService.query(ServletPropertyFilterUtil.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String save() {
		minimumService = new BalancescheduleminimumServiceImpl();
		Global global = CurrentUtil.getGlobal();
		try {
			if (minimum != null) {
				if (minimum.getId() > 0) {
					msg = "修改成功！";
					markSuccess();
					minimum.setUpdateby(global.getUserinfo().getId());
					minimum.setUpdatetime(new Timestamp(System
							.currentTimeMillis()));
					minimum.setDepartinvoicesid((long) 0);
				} else {
					msg = "添加成功！";
					markSuccess();
					minimum.setCreateby(global.getUserinfo().getId());
					minimum.setCreatetime(new Timestamp(System
							.currentTimeMillis()));
					minimum.setUpdateby(global.getUserinfo().getId());
					minimum.setUpdatetime(new Timestamp(System
							.currentTimeMillis()));
					minimum.setDepartinvoicesid((long) 0);
					//minimum.setDepartdate(minimumService.getdepartdate(minimum
					//		.getScheduleid()));
					minimum.setDepartdate(new Timestamp(System
							.currentTimeMillis()));
				}
				if (!minimumService.save(minimum)) {
					msg = "操作失败！";
					markFail();
				}
			}
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			msg = "操作失败！";
			markFail();
		}
		return "json";
	}

	public String delete() {
		minimumService = new BalancescheduleminimumServiceImpl();
		if (minimum != null) {
			try {
				boolean result = minimumService.delete(minimum.getId());
				if (result) {
					msg = "删除成功！";
					markSuccess();
				} else {
					msg = "删除失败！";
					markFail();
				}
			} catch (Exception ex) {
				play.Logger.error(ex.getMessage(), ex);
				msg = "删除失败:";
				markFail();
			}
		}
		return "json";
	}

	public Balancescheduleminimum getMinimum() {
		return minimum;
	}

	public void setMinimum(Balancescheduleminimum minimum) {
		this.minimum = minimum;
	}

	public List<Balancescheduleminimum> getMinimumlist() {
		return minimumlist;
	}

	public void setMinimumlist(List<Balancescheduleminimum> minimumlist) {
		this.minimumlist = minimumlist;
	}

	public List<Map<String, Object>> getMinimummap() {
		return minimummap;
	}

	public void setMinimummap(List<Map<String, Object>> minimummap) {
		this.minimummap = minimummap;
	}

}
