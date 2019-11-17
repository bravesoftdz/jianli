package cn.nova.bus.price.action;

import cn.nova.bus.action.BaseAction;
import java.util.Date;
import java.util.List;
import java.util.Map;

import util.CurrentUtil;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.price.model.Formulaitemdistance;
import cn.nova.bus.price.model.Formulaitemorggrade;
import cn.nova.bus.price.model.Formulaitemprice;
import cn.nova.bus.price.model.Formulaitemroadgrade;
import cn.nova.bus.price.model.Formulaitemroute;
import cn.nova.bus.price.model.Formulaitemroutestop;
import cn.nova.bus.price.model.Formulaitemschedule;
import cn.nova.bus.price.model.Formulaitemvehcile;
import cn.nova.bus.price.model.Formulaitemvehcileroadgrad;
import cn.nova.bus.price.model.Ticketpriceformulaitem;
import cn.nova.bus.price.service.FormulaitemService;
import cn.nova.bus.price.service.impl.FormulaitemServiceImpl;
import cn.nova.bus.security.Global;

public class FormulaitemAboutAction extends BaseAction{
	private String item;
	private Ticketpriceformulaitem ticketpriceformulaitem;
	private List<Map<String, Object>> formulaitemlist;
	private Formulaitemvehcile formulaitemvehcile;
	private Formulaitemroute formulaitemroute;
	private Formulaitemroutestop formulaitemroutestop;
	private Formulaitemdistance formulaitemdistance;	
	private Formulaitemprice formulaitemprice;
	private Formulaitemorggrade formulaitemorggrade;
	private Formulaitemroadgrade formulaitemroadgrade;
	private Formulaitemvehcileroadgrad formulaitemvehcileroadgrad;	
	private Formulaitemschedule formulaitemschedule;

	private FormulaitemService formulaitemService;

	public String queryformulaitem() {
		try {
			formulaitemService = new FormulaitemServiceImpl();
			setFormulaitemlist(formulaitemService.query(item,
					ticketpriceformulaitem));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	// 保存车型相关
	public String saveformulaitemvehcile() {
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				if (formulaitemvehcile != null) {
					if (formulaitemvehcile.getId() != 0) {
						formulaitemvehcile.setUpdateby(global.getUserinfo().getId());
						formulaitemvehcile.setUpdatetime(new Date());
						setMsg("修改成功！");
						markSuccess();
					} else {
						formulaitemvehcile.setCreateby(global.getUserinfo().getId());
						formulaitemvehcile.setCreatetime(new Date());
						formulaitemvehcile.setUpdateby(global.getUserinfo().getId());
						formulaitemvehcile.setUpdatetime(new Date());
						setMsg("添加成功！");
						markSuccess();
					}
					formulaitemService = new FormulaitemServiceImpl();
					formulaitemService
							.saveformulaitemvehcile(formulaitemvehcile);
				}
			}
		} catch (ServiceException ex) {
			setMsg(ex.getMessage());
			markFail();
		} catch (Exception ex) {
			play.Logger.error(ex.getMessage(), ex);
			setMsg("操作失败！");
			markFail();
		}
		return "json";
	}

	// 删除车型相关
	public String delformulaitemvehcile() {
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				formulaitemService = new FormulaitemServiceImpl();
				if (formulaitemService
						.delformulaitemvehcile(formulaitemvehcile)) {
					setMsg("删除成功！");
					markSuccess();
				}
			}
		} catch (ServiceException ex) {
			msg = ex.getMessage();
			markFail();
		} catch (Exception ex) {
			play.Logger.error(ex.getMessage(), ex);
			setMsg("操作失败！");
			markFail();
		}
		return "json";
	}

	// 保存线路相关
	public String saveformulaitemroute() {
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				if (formulaitemroute != null) {
					if (formulaitemroute.getId()!=0){
						formulaitemroute.setUpdateby(global.getUserinfo().getId());
						formulaitemroute.setUpdatetime(new Date());	
						setMsg("修改成功！");
						markSuccess();
					}
					else{
						formulaitemroute.setCreateby(global.getUserinfo().getId());
						formulaitemroute.setCreatetime(new Date());
						formulaitemroute.setUpdateby(global.getUserinfo().getId());
						formulaitemroute.setUpdatetime(new Date());	
						setMsg("添加成功！");
						markSuccess();
					}
				}
				formulaitemService = new FormulaitemServiceImpl();
				formulaitemService.saveformulaitemroute(formulaitemroute);
			}
		} catch (ServiceException ex) {
			setMsg(ex.getMessage());
			markFail();
		} catch (Exception ex) {
			play.Logger.error(ex.getMessage(), ex);
			setMsg("操作失败！");
			markFail();
		}
		return "json";
	}

	// 删除线路相关
	public String delformulaitemroute() {
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				formulaitemService = new FormulaitemServiceImpl();
				if (formulaitemService.delformulaitemroute(formulaitemroute)) {
					setMsg("删除成功！");
					markSuccess();
				}
			}
		} catch (ServiceException ex) {
			msg = ex.getMessage();
			markFail();
		} catch (Exception ex) {
			play.Logger.error(ex.getMessage(), ex);
			setMsg("操作失败！");
			markFail();
		}
		return "json";
	}
	// 保存线路停靠点相关
	public String saveaboutroutestop() {
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				if (formulaitemroutestop != null) {
					if (formulaitemroutestop.getId()!=0){
						formulaitemroutestop.setUpdateby(global.getUserinfo().getId());
						formulaitemroutestop.setUpdatetime(new Date());	
						setMsg("修改成功！");
						markSuccess();
					}
					else{
						formulaitemroutestop.setCreateby(global.getUserinfo().getId());
						formulaitemroutestop.setCreatetime(new Date());
						formulaitemroutestop.setUpdateby(global.getUserinfo().getId());
						formulaitemroutestop.setUpdatetime(new Date());	
						setMsg("添加成功！");
						markSuccess();
					}
				}
				formulaitemService = new FormulaitemServiceImpl();
				formulaitemService.saveformulaitemrouteStop(formulaitemroutestop);
			}
		} catch (ServiceException ex) {
			setMsg(ex.getMessage());
			markFail();
		} catch (Exception ex) {
			play.Logger.error(ex.getMessage(), ex);
			setMsg("操作失败！");
			markFail();
		}
		return "json";
	}
	// 删除线路停靠点相关
	public String delaboutroutestop() {
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				formulaitemService = new FormulaitemServiceImpl();
				if (formulaitemService.delformulaitemrouteStop(formulaitemroutestop)) {
					setMsg("删除成功！");
					markSuccess();
				}
			}
		} catch (ServiceException ex) {
			msg = ex.getMessage();
			markFail();
		} catch (Exception ex) {
			play.Logger.error(ex.getMessage(), ex);
			setMsg("操作失败！");
			markFail();
		}
		return "json";
	}
	// 保存里程区间相关
	public String saveaboutdistance() {
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				if (formulaitemdistance != null) {
					if (formulaitemdistance.getId()!=0){
						formulaitemdistance.setUpdateby(global.getUserinfo().getId());
						formulaitemdistance.setUpdatetime(new Date());	
						setMsg("修改成功！");
						markSuccess();
					}
					else{
						formulaitemdistance.setCreateby(global.getUserinfo().getId());
						formulaitemdistance.setCreatetime(new Date());
						formulaitemdistance.setUpdateby(global.getUserinfo().getId());
						formulaitemdistance.setUpdatetime(new Date());	
						setMsg("添加成功！");
						markSuccess();
					}
				}
				formulaitemService = new FormulaitemServiceImpl();
				formulaitemService.saveformulaitemdistance(formulaitemdistance);
			}
		} catch (ServiceException ex) {
			setMsg(ex.getMessage());
			markFail();
		} catch (Exception ex) {
			play.Logger.error(ex.getMessage(), ex);
			setMsg("操作失败！");
			markFail();
		}
		return "json";
	}
	// 删除
	public String delaboutdistance() {
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				formulaitemService = new FormulaitemServiceImpl();
				if (formulaitemService.delformulaitemdistance(formulaitemdistance)) {
					setMsg("删除成功！");
					markSuccess();
				}
			}
		} catch (ServiceException ex) {
			msg = ex.getMessage();
			markFail();
		} catch (Exception ex) {
			play.Logger.error(ex.getMessage(), ex);
			setMsg("操作失败！");
			markFail();
		}
		return "json";
	}
	// 保存票价区间相关
	public String saveaboutprice() {
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				if (formulaitemprice != null) {
					if (formulaitemprice.getId()!=0){
						formulaitemprice.setUpdateby(global.getUserinfo().getId());
						formulaitemprice.setUpdatetime(new Date());	
						setMsg("修改成功！");
						markSuccess();
					}
					else{
						formulaitemprice.setCreateby(global.getUserinfo().getId());
						formulaitemprice.setCreatetime(new Date());
						formulaitemprice.setUpdateby(global.getUserinfo().getId());
						formulaitemprice.setUpdatetime(new Date());	
						setMsg("添加成功！");
						markSuccess();
					}
				}
				formulaitemService = new FormulaitemServiceImpl();
				formulaitemService.saveformulaitemprice(formulaitemprice);
			}
		} catch (ServiceException ex) {
			setMsg(ex.getMessage());
			markFail();
		} catch (Exception ex) {
			play.Logger.error(ex.getMessage(), ex);
			setMsg("操作失败！");
			markFail();
		}
		return "json";
	}
	// 删除
	public String delaboutprice() {
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				formulaitemService = new FormulaitemServiceImpl();
				if (formulaitemService.delformulaitemprice(formulaitemprice)) {
					setMsg("删除成功！");
					markSuccess();
				}
			}
		} catch (ServiceException ex) {
			msg = ex.getMessage();
			markFail();
		} catch (Exception ex) {
			play.Logger.error(ex.getMessage(), ex);
			setMsg("操作失败！");
			markFail();
		}
		return "json";
	}

	// 保存公路等级相关
	public String saveaboutroadgrade() {
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				if (formulaitemroadgrade != null) {
					if (formulaitemroadgrade.getId()!=0){
						formulaitemroadgrade.setUpdateby(global.getUserinfo().getId());
						formulaitemroadgrade.setUpdatetime(new Date());	
						setMsg("修改成功！");
						markSuccess();
					}
					else{
						formulaitemroadgrade.setCreateby(global.getUserinfo().getId());
						formulaitemroadgrade.setCreatetime(new Date());
						formulaitemroadgrade.setUpdateby(global.getUserinfo().getId());
						formulaitemroadgrade.setUpdatetime(new Date());	
						setMsg("添加成功！");
						markSuccess();
					}
				}
				formulaitemService = new FormulaitemServiceImpl();
				formulaitemService.saveformulaitemRoadGrade(formulaitemroadgrade);
			}
		} catch (ServiceException ex) {
			setMsg(ex.getMessage());
			markFail();
		} catch (Exception ex) {
			play.Logger.error(ex.getMessage(), ex);
			setMsg("操作失败！");
			markFail();
		}
		return "json";
	}
	// 删除
	public String delaboutroadgrade() {
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				formulaitemService = new FormulaitemServiceImpl();
				if (formulaitemService.delformulaitemRoadGrade(formulaitemroadgrade)) {
					setMsg("删除成功！");
					markSuccess();
				}
			}
		} catch (ServiceException ex) {
			msg = ex.getMessage();
			markFail();
		} catch (Exception ex) {
			play.Logger.error(ex.getMessage(), ex);
			setMsg("操作失败！");
			markFail();
		}
		return "json";
	}	
	// 保存客运站等级相关
	public String saveaboutstationgrade() {
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				if (formulaitemorggrade != null) {
					if (formulaitemorggrade.getId()!=0){
						formulaitemorggrade.setUpdateby(global.getUserinfo().getId());
						formulaitemorggrade.setUpdatetime(new Date());	
						setMsg("修改成功！");
						markSuccess();
					}
					else{
						formulaitemorggrade.setCreateby(global.getUserinfo().getId());
						formulaitemorggrade.setCreatetime(new Date());
						formulaitemorggrade.setUpdateby(global.getUserinfo().getId());
						formulaitemorggrade.setUpdatetime(new Date());	
						setMsg("添加成功！");
						markSuccess();
					}
				}
				formulaitemService = new FormulaitemServiceImpl();
				formulaitemService.saveformulaitemStationGrade(formulaitemorggrade);
			}
		} catch (ServiceException ex) {
			setMsg(ex.getMessage());
			markFail();
		} catch (Exception ex) {
			play.Logger.error(ex.getMessage(), ex);
			setMsg("操作失败！");
			markFail();
		}
		return "json";
	}
	// 删除
	public String delaboutstationgrade() {
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				formulaitemService = new FormulaitemServiceImpl();
				if (formulaitemService.delformulaitemStationGrade(formulaitemorggrade)) {
					setMsg("删除成功！");
					markSuccess();
				}
			}
		} catch (ServiceException ex) {
			msg = ex.getMessage();
			markFail();
		} catch (Exception ex) {
			play.Logger.error(ex.getMessage(), ex);
			setMsg("操作失败！");
			markFail();
		}
		return "json";
	}	
	
	// 保存车型公路等级相关
	public String saveaboutvchroadgrade() {
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				if (formulaitemvehcileroadgrad != null) {
					if (formulaitemvehcileroadgrad.getId()!=0){
						formulaitemvehcileroadgrad.setUpdateby(global.getUserinfo().getId());
						formulaitemvehcileroadgrad.setUpdatetime(new Date());	
						setMsg("修改成功！");
						markSuccess();
					}
					else{
						formulaitemvehcileroadgrad.setCreateby(global.getUserinfo().getId());
						formulaitemvehcileroadgrad.setCreatetime(new Date());
						formulaitemvehcileroadgrad.setUpdateby(global.getUserinfo().getId());
						formulaitemvehcileroadgrad.setUpdatetime(new Date());	
						setMsg("添加成功！");
						markSuccess();
					}
				}
				formulaitemService = new FormulaitemServiceImpl();
				formulaitemService.saveformulaitemVehRoadGrade(formulaitemvehcileroadgrad);
			}
		} catch (ServiceException ex) {
			setMsg(ex.getMessage());
			markFail();
		} catch (Exception ex) {
			play.Logger.error(ex.getMessage(), ex);
			setMsg("操作失败！");
			markFail();
		}
		return "json";
	}
	// 删除
	public String delaboutvchroadgrade() {
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				formulaitemService = new FormulaitemServiceImpl();
				if (formulaitemService.delformulaitemVehRoadGrade(formulaitemvehcileroadgrad)) {
					setMsg("删除成功！");
					markSuccess();
				}
			}
		} catch (ServiceException ex) {
			msg = ex.getMessage();
			markFail();
		} catch (Exception ex) {
			play.Logger.error(ex.getMessage(), ex);
			setMsg("操作失败！");
			markFail();
		}
		return "json";
	}	
	// 保存班次相关
	public String saveaboutschedule() {
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				if (formulaitemschedule != null) {
					if (formulaitemschedule.getId()!=0){
						formulaitemschedule.setUpdateby(global.getUserinfo().getId());
						formulaitemschedule.setUpdatetime(new Date());	
						setMsg("修改成功！");
						markSuccess();
					}
					else{
						formulaitemschedule.setCreateby(global.getUserinfo().getId());
						formulaitemschedule.setCreatetime(new Date());
						formulaitemschedule.setUpdateby(global.getUserinfo().getId());
						formulaitemschedule.setUpdatetime(new Date());	
						setMsg("添加成功！");
						markSuccess();
					}
				}
				formulaitemService = new FormulaitemServiceImpl();
				formulaitemService.saveformulaitemSchedule(formulaitemschedule);
			}
		} catch (ServiceException ex) {
			setMsg(ex.getMessage());
			markFail();
		} catch (Exception ex) {
			play.Logger.error(ex.getMessage(), ex);
			setMsg("操作失败！");
			markFail();
		}
		return "json";
	}
	// 删除
	public String delaboutschedule() {
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				formulaitemService = new FormulaitemServiceImpl();
				if (formulaitemService.delformulaitemSchedule(formulaitemschedule)) {
					setMsg("删除成功！");
					markSuccess();
				}
			}
		} catch (ServiceException ex) {
			msg = ex.getMessage();
			markFail();
		} catch (Exception ex) {
			play.Logger.error(ex.getMessage(), ex);
			setMsg("操作失败！");
			markFail();
		}
		return "json";
	}	
	
	public Ticketpriceformulaitem getTicketpriceformulaitem() {
		return ticketpriceformulaitem;
	}

	public void setTicketpriceformulaitem(
			Ticketpriceformulaitem ticketpriceformulaitem) {
		this.ticketpriceformulaitem = ticketpriceformulaitem;
	}

	public String getItem() {
		return item;
	}

	public void setItem(String item) {
		this.item = item;
	}

	public List<Map<String, Object>> getFormulaitemlist() {
		return formulaitemlist;
	}

	public void setFormulaitemlist(List<Map<String, Object>> formulaitemlist) {
		this.formulaitemlist = formulaitemlist;
	}

	public Formulaitemvehcile getFormulaitemvehcile() {
		return formulaitemvehcile;
	}

	public void setFormulaitemvehcile(Formulaitemvehcile formulaitemvehcile) {
		this.formulaitemvehcile = formulaitemvehcile;
	}

	public Formulaitemroute getFormulaitemroute() {
		return formulaitemroute;
	}

	public void setFormulaitemroute(Formulaitemroute formulaitemroute) {
		this.formulaitemroute = formulaitemroute;
	}
	public Formulaitemroutestop getFormulaitemroutestop() {
		return formulaitemroutestop;
	}

	public void setFormulaitemroutestop(Formulaitemroutestop formulaitemroutestop) {
		this.formulaitemroutestop = formulaitemroutestop;
	}
	public Formulaitemdistance getFormulaitemdistance() {
		return formulaitemdistance;
	}

	public void setFormulaitemdistance(Formulaitemdistance formulaitemdistance) {
		this.formulaitemdistance = formulaitemdistance;
	}
	public Formulaitemprice getFormulaitemprice() {
		return formulaitemprice;
	}

	public void setFormulaitemprice(Formulaitemprice formulaitemprice) {
		this.formulaitemprice = formulaitemprice;
	}
	public Formulaitemorggrade getFormulaitemorggrade() {
		return formulaitemorggrade;
	}

	public void setFormulaitemorggrade(Formulaitemorggrade formulaitemorggrade) {
		this.formulaitemorggrade = formulaitemorggrade;
	}	
	public Formulaitemroadgrade getFormulaitemroadgrade() {
		return formulaitemroadgrade;
	}

	public void setFormulaitemroadgrade(Formulaitemroadgrade formulaitemroadgrade) {
		this.formulaitemroadgrade = formulaitemroadgrade;
	}

	public Formulaitemvehcileroadgrad getFormulaitemvehcileroadgrad() {
		return formulaitemvehcileroadgrad;
	}

	public void setFormulaitemvehcileroadgrad(
			Formulaitemvehcileroadgrad formulaitemvehcileroadgrad) {
		this.formulaitemvehcileroadgrad = formulaitemvehcileroadgrad;
	}	
	public Formulaitemschedule getFormulaitemschedule() {
		return formulaitemschedule;
	}

	public void setFormulaitemschedule(Formulaitemschedule formulaitemschedule) {
		this.formulaitemschedule = formulaitemschedule;
	}	
}
