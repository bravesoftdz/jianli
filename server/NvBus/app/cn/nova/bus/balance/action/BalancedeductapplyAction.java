package cn.nova.bus.balance.action;

import cn.nova.bus.action.BaseAction;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.persistence.Transient;

import util.CurrentUtil;
import cn.nova.bus.balance.model.Balancedeductapply;
import cn.nova.bus.balance.service.BalancedeductapplyService;
import cn.nova.bus.balance.service.impl.BalancedeductapplyServiceImpl;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;
import cn.nova.utils.web.ServletPropertyFilterUtil;

/**
 * 
 * <p>
 * Title: 结算固定扣费项目应用
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
public class BalancedeductapplyAction extends BaseAction{
	private Long curid;
	private Balancedeductapply balancedeductapply;
	private List<Map<String, Object>> balancedeductapplys;	
	private List<Map<String, Object>> datemap;		
	public List<Map<String, Object>> getDatemap() {
		return datemap;
	}

	public void setDatemap(List<Map<String, Object>> datemap) {
		this.datemap = datemap;
	}

	private BalancedeductapplyService balancedeductapplyService;

	public String qrybalancedeductitemApply() {
		try {
			balancedeductapplyService = new BalancedeductapplyServiceImpl();
			setBalancedeductapplys(balancedeductapplyService.qryDeductitemApply(
					ServletPropertyFilterUtil.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	public String saveBalancedeductapply() {
		Global global = CurrentUtil.getGlobal();
		try {
			balancedeductapplyService = new BalancedeductapplyServiceImpl();
			if (global != null && global.getUserinfo().getId() > 0) {
				balancedeductapply.setIsactive(true);
				if (balancedeductapply.getId() == 0) {
					markSuccess();
					setMsg("添加成功！");
					balancedeductapply.setCreateby(global.getUserinfo().getId());
					balancedeductapply.setUpdateby(global.getUserinfo().getId());
					balancedeductapply.setCreatetime(new Date());
					balancedeductapply.setUpdatetime(new Date());
				} else {
					markSuccess();
					setMsg("修改成功！");
					balancedeductapply.setUpdateby(global.getUserinfo().getId());
					balancedeductapply.setUpdatetime(new Date());
				}
				balancedeductapply = balancedeductapplyService
						.saveBalancedeductapply(balancedeductapply);
				setCurid(balancedeductapply.getId());
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
	
	public String auditDeductApply() {
		balancedeductapplyService = new BalancedeductapplyServiceImpl();
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				if (balancedeductapplyService.auditDeductApply(balancedeductapply,global)){
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

	/*@Action(value = "cancelAuditDeductApply")
	public String cancelAuditDeductApply() {

		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				if (balancedeductapplyService.cancelAuditDeductApply(balancedeductapply)){
					setSuccess();
					setMsg("取消成功！");
				}
			}
		} catch (ServiceException se) {
			setSuccess();
			setMsg(se.getMessage());
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			setSuccess();
			setMsg("系统异常！");
		}
		return "json";
	}*/
	public String delBalancedeductapply() {
		balancedeductapplyService = new BalancedeductapplyServiceImpl();
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				if (balancedeductapplyService.delBalancedeductapply(balancedeductapply)){
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
	
	
	public String qryBalancedeductapplysell() {
		try {
			balancedeductapplyService = new BalancedeductapplyServiceImpl();
			datemap=balancedeductapplyService.qryBalancedeductapplysell(curid);
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
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
	public Balancedeductapply getBalancedeductapply() {
		return balancedeductapply;
	}

	public void setBalancedeductapply(Balancedeductapply balancedeductapply) {
		this.balancedeductapply = balancedeductapply;
	}
	
	public List<Map<String, Object>> getBalancedeductapplys() {
		return balancedeductapplys;
	}

	public void setBalancedeductapplys(List<Map<String, Object>> balancedeductapplys) {
		this.balancedeductapplys = balancedeductapplys;
	}
}
