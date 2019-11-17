package cn.nova.bus.balance.action;

import cn.nova.bus.action.BaseAction;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.persistence.Transient;

import util.CurrentUtil;
import cn.nova.bus.balance.model.Balanceformulaapply;
import cn.nova.bus.balance.service.BalanceformulaapplyService;
import cn.nova.bus.balance.service.impl.BalanceformulaapplyServiceImpl;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;
import cn.nova.utils.web.ServletPropertyFilterUtil;

/**
 * 
 * <p>
 * Title: 结算公式扣费项目应用
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
 * @author lanckun
 * @version 0.1
 */
public class BalanceformulaapplyAction extends BaseAction{
	private String orgids;

	private Long curid;
	private Balanceformulaapply balanceformulaapply;
	private List<Map<String, Object>> balanceformulas;
	private List<Map<String, Object>> balanceformulaapplys;

	private BalanceformulaapplyService balanceformulaapplyService;

	public String qryBalanceformulas() {
		try {
			balanceformulaapplyService = new BalanceformulaapplyServiceImpl();
			setBalanceformulas(balanceformulaapplyService
					.qryBalanceformula(orgids));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String qryBalanceformulaApply() {
		try {
			balanceformulaapplyService = new BalanceformulaapplyServiceImpl();
			setBalanceformulaapplys(balanceformulaapplyService
					.qryBalanceformulaApply(ServletPropertyFilterUtil
							.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String saveBalanceformulaApply() {
		Global global = CurrentUtil.getGlobal();
		try {
			balanceformulaapplyService = new BalanceformulaapplyServiceImpl();
			if (global != null && global.getUserinfo().getId() > 0) {
				balanceformulaapply.setIsactive(true);
				if (balanceformulaapply.getId() == 0) {
					markSuccess();
					setMsg("添加成功！");
					balanceformulaapply.setCreateby(global.getUserinfo()
							.getId());
					balanceformulaapply.setUpdateby(global.getUserinfo()
							.getId());
					balanceformulaapply.setCreatetime(new Date());
					balanceformulaapply.setUpdatetime(new Date());
				} else {
					markSuccess();
					setMsg("修改成功！");
					balanceformulaapply.setUpdateby(global.getUserinfo()
							.getId());
					balanceformulaapply.setUpdatetime(new Date());
				}
				balanceformulaapply = balanceformulaapplyService
						.saveBalanceformulaapply(balanceformulaapply);
				setCurid(balanceformulaapply.getId());
			}
		} catch (ServiceException se) {
			markFail();
			setMsg(se.getMessage());
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			markFail();
			setMsg("系统异常！");
		}
		return "json";
	}

	public String auditBalanceformulaapply() {
		balanceformulaapplyService = new BalanceformulaapplyServiceImpl();
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				if (balanceformulaapplyService.auditBalanceformulaapply(
						balanceformulaapply, global)) {
					markSuccess();
					setMsg("审核成功！");
				}
			}
		} catch (ServiceException se) {
			markSuccess();
			setMsg(se.getMessage());
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			markSuccess();
			setMsg("系统异常！");
		}
		return "json";
	}

	public String delBalanceformulaapply() {
		balanceformulaapplyService = new BalanceformulaapplyServiceImpl();
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				if (balanceformulaapplyService
						.delBalancedeductapply(balanceformulaapply)) {
					markSuccess();
					setMsg("删除成功！");
				}
			}
		} catch (ServiceException se) {
			markSuccess();
			setMsg(se.getMessage());
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			markSuccess();
			setMsg("系统异常！");
		}
		return "json";
	}

	public Long getCurid() {
		return curid;
	}

	public void setCurid(Long curid) {
		this.curid = curid;
	}

	@Transient
	public Balanceformulaapply getBalanceformulaapply() {
		return balanceformulaapply;
	}

	public void setBalanceformulaapply(Balanceformulaapply balanceformulaapply) {
		this.balanceformulaapply = balanceformulaapply;
	}

	public List<Map<String, Object>> getBalanceformulaapplys() {
		return balanceformulaapplys;
	}

	public void setBalanceformulaapplys(
			List<Map<String, Object>> balanceformulaapplys) {
		this.balanceformulaapplys = balanceformulaapplys;
	}

	public List<Map<String, Object>> getBalanceformulas() {
		return balanceformulas;
	}

	public void setBalanceformulas(List<Map<String, Object>> balanceformulas) {
		this.balanceformulas = balanceformulas;
	}
	
	public String getOrgids() {
		return orgids;
	}

	public void setOrgids(String orgids) {
		this.orgids = orgids;
	}
}
