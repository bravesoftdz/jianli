package cn.nova.bus.base.action;

import cn.nova.bus.action.BaseAction;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.persistence.Transient;

import util.CurrentUtil;
import cn.nova.bus.base.model.Cycleschemes;
import cn.nova.bus.base.model.Cycleschemesdriver;
import cn.nova.bus.base.model.Cycleschemesschedule;
import cn.nova.bus.base.model.Cycleschemessteward;
import cn.nova.bus.base.model.Cycleschemesvehicle;
import cn.nova.bus.base.model.Schedulecycle;
import cn.nova.bus.base.service.CycleschemeService;
import cn.nova.bus.base.service.impl.CycleschemeServiceImpl;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;
import cn.nova.utils.web.ServletPropertyFilterUtil;

public class CycleschemeAction extends BaseAction{
	private Long cycleschemeid;
	private Cycleschemes cyclescheme;
	private Long types;
	private Schedulecycle schedulecycle;
	private Cycleschemesschedule cycleschemesschedule;
	private Cycleschemesvehicle cycleschemesvehicle;
	private Cycleschemesdriver cycleschemesdriver;
	private Cycleschemessteward cycleschemessteward;

	private List<Map<String, Object>> cycleschemelist;
	private List<Map<String, Object>> schedulecyclelist;
	private List<Map<String, Object>> cycleschemesschedulelist;
	private List<Map<String, Object>> cycleschemesvehiclelist;
	private List<Map<String, Object>> cycleschemesdriverlist;
	private List<Map<String, Object>> cycleschemesstewardlist;

	private CycleschemeService cycleschemeService;

	public String querycyclescheme() {
		try {
			cycleschemeService = new CycleschemeServiceImpl();
			setCycleschemelist(cycleschemeService
					.query(ServletPropertyFilterUtil
							.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String qrySchedulecycle() {
		try {
			cycleschemeService = new CycleschemeServiceImpl();
			setSchedulecyclelist(cycleschemeService
					.qrySchedulecycle(cyclescheme));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String save() {
		Global global = CurrentUtil.getGlobal();
		try {
			cycleschemeService = new CycleschemeServiceImpl();
			if (global != null && global.getUserinfo().getId() > 0) {
				if (cyclescheme != null) {
					if (cyclescheme.getId() != 0) {
						cyclescheme.setUpdateby(global.getUserinfo().getId());
						cyclescheme.setUpdatetime(new Date());
						cyclescheme.setOrgid(global.getOrganization().getId());
						setMsg("修改成功！");
						markSuccess();
					} else {
						cyclescheme.setCreateby(global.getUserinfo().getId());
						cyclescheme.setCreatetime(new Date());
						cyclescheme.setUpdateby(global.getUserinfo().getId());
						cyclescheme.setUpdatetime(new Date());
						setMsg("添加成功！");
						markSuccess();
					}
				}

				cyclescheme = cycleschemeService.save(cyclescheme);
				cycleschemeid = cyclescheme.getId();
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

	// 删除循环组
	public String delcyclescheme() {
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				cycleschemeService = new CycleschemeServiceImpl();
				if (cycleschemeService.delCyclescheme(cyclescheme)) {
					setMsg("删除成功！");
					markSuccess();
				}else{
					setMsg("该循环组中存在循环驾驶员或循环乘务员,删除失败");
					markFail();
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

	public String saveSchedulecycle() {
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				if (schedulecycle != null) {
					schedulecycle.setCreateby(global.getUserinfo().getId());
					schedulecycle.setCreatetime(new Date());
					schedulecycle.setUpdateby(global.getUserinfo().getId());
					schedulecycle.setUpdatetime(new Date());
					setMsg("设置成功！");
					markSuccess();
				}
				cycleschemeService = new CycleschemeServiceImpl();
				cycleschemeService.saveSchedulecycle(schedulecycle);
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

	public String qrySchedulecycles() {
		try {
			cycleschemeService = new CycleschemeServiceImpl();
			setSchedulecyclelist(cycleschemeService
					.qrySchedulecycles(cyclescheme));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	// 删除循环策略
	public String delSchedulecycle() {
		Global global = CurrentUtil.getGlobal();
		try {
			cycleschemeService = new CycleschemeServiceImpl();
			if (global != null && global.getUserinfo().getId() > 0) {
				if (cycleschemeService.delSchedulecycle(schedulecycle)) {
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

	// 循环班次
	public String saveCycleschemesschedule() {
		Global global = CurrentUtil.getGlobal();
		cycleschemeService = new CycleschemeServiceImpl();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				if (cycleschemesschedule != null) {
					if (types.equals(0L)) {
						cycleschemesschedule.setUpdateby(global.getUserinfo()
								.getId());
						cycleschemesschedule.setUpdatetime(new Date());
						setMsg("修改成功！");
						markSuccess();
					} else {
						cycleschemesschedule.setCreateby(global.getUserinfo()
								.getId());
						cycleschemesschedule.setCreatetime(new Date());
						cycleschemesschedule.setUpdateby(global.getUserinfo()
								.getId());
						cycleschemesschedule.setUpdatetime(new Date());
						setMsg("添加成功！");
						markSuccess();
					}
				}
				if(!cycleschemeService.saveCycleschemesschedule(cycleschemesschedule,types)){
					setMsg("该班次号已经被添加");
					markFail();
				}
			}
		} catch (ServiceException ex) {
			System.out.println("*******"+ex.getMessage());
			setMsg(ex.getMessage());
			markFail();
		} catch (Exception ex) {
			play.Logger.error(ex.getMessage(), ex);
			setMsg("操作失败！");
			markFail();
		}
		return "json";

	}

	// 删除循环班次
	public String delCycleschemesschedule() {
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				cycleschemeService = new CycleschemeServiceImpl();
				if (cycleschemeService
						.delCycleschemesschedule(cycleschemesschedule)) {
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

	// 下移循环班次
	public String nextCycleschemesschedule() {
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				cycleschemeService = new CycleschemeServiceImpl();
				if (cycleschemeService
						.nextCycleschemesschedule(cycleschemesschedule)) {
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

	// 上移循环班次
	public String priorCycleschemesschedule() {
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				cycleschemeService = new CycleschemeServiceImpl();
				if (cycleschemeService
						.priorCycleschemesschedule(cycleschemesschedule)) {
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

	public String qryCycleschemesschedule() {
		try {
			cycleschemeService = new CycleschemeServiceImpl();
			setCycleschemesschedulelist(cycleschemeService
					.qryCycleschemesschedule(cyclescheme));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	// 循环车辆
	public String saveCycleschemesvehicle() {
		Global global = CurrentUtil.getGlobal();
		try {
			cycleschemeService = new CycleschemeServiceImpl();
			if (global != null && global.getUserinfo().getId() > 0) {
				if (cycleschemesvehicle != null) {
					if (cycleschemesvehicle.getId() != 0) {
						cycleschemesvehicle.setUpdateby(global.getUserinfo()
								.getId());
						cycleschemesvehicle.setUpdatetime(new Date());
						setMsg("修改成功！");
						markSuccess();
					} else {
						cycleschemesvehicle.setCreateby(global.getUserinfo()
								.getId());
						cycleschemesvehicle.setCreatetime(new Date());
						cycleschemesvehicle.setUpdateby(global.getUserinfo()
								.getId());
						cycleschemesvehicle.setUpdatetime(new Date());
						setMsg("添加成功！");
						markSuccess();
					}
				}
				cycleschemeService.saveCycleschemesvehicle(cycleschemesvehicle);
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

	public String qryCycleschemesvehicle() {
		try {
			cycleschemeService = new CycleschemeServiceImpl();
			setCycleschemesvehiclelist(cycleschemeService
					.qryCycleschemesvehicle(cyclescheme));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	// 删除循环车辆
	public String delCycleschemesvehicle() {
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				cycleschemeService = new CycleschemeServiceImpl();
				if (cycleschemeService
						.delCycleschemesvehicle(cycleschemesvehicle)) {
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

	// 下移循环车辆
	public String nextCycleschemesvehicle() {
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				cycleschemeService = new CycleschemeServiceImpl();
				if (cycleschemeService
						.nextCycleschemesvehicle(cycleschemesvehicle)) {
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

	// 上移循环车辆
	public String priorCycleschemesvehicle() {
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				cycleschemeService = new CycleschemeServiceImpl();
				if (cycleschemeService
						.priorCycleschemesvehicle(cycleschemesvehicle)) {
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

	// 循环驾驶员
	public String saveCycleschemesdriver() {
		Global global = CurrentUtil.getGlobal();
		try {
			cycleschemeService = new CycleschemeServiceImpl();
			if (global != null && global.getUserinfo().getId() > 0) {
				if (cycleschemesdriver != null) {
					if (cycleschemesdriver.getId() != 0) {
						cycleschemesdriver.setUpdateby(global.getUserinfo()
								.getId());
						cycleschemesdriver.setUpdatetime(new Date());
						setMsg("修改成功！");
						markSuccess();
					} else {
						cycleschemesdriver.setCreateby(global.getUserinfo()
								.getId());
						cycleschemesdriver.setCreatetime(new Date());
						cycleschemesdriver.setUpdateby(global.getUserinfo()
								.getId());
						cycleschemesdriver.setUpdatetime(new Date());
						setMsg("添加成功！");
						markSuccess();
					}
				}
				cycleschemeService.saveCycleschemesdrive(cycleschemesdriver);
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

	public String qryCycleschemesdriver() {
		try {
			cycleschemeService = new CycleschemeServiceImpl();
			setCycleschemesdriverlist(cycleschemeService
					.qryCycleschemesdrive(cyclescheme));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	// 删除循环驾驶员
	public String delCycleschemesdriver() {
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				cycleschemeService = new CycleschemeServiceImpl();
				if (cycleschemeService.delCycleschemesdrive(cycleschemesdriver)) {
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

	// 下移循环驾驶员
	public String nextCycleschemesdriver() {
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				cycleschemeService = new CycleschemeServiceImpl();
				if (cycleschemeService
						.nextCycleschemesdrive(cycleschemesdriver)) {
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

	// 上移循环驾驶员
	public String priorCycleschemesdriver() {
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				cycleschemeService = new CycleschemeServiceImpl();
				if (cycleschemeService
						.priorCycleschemesdrive(cycleschemesdriver)) {
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

	// 循环乘务员
	public String saveCycleschemessteward() {
		Global global = CurrentUtil.getGlobal();
		try {
			cycleschemeService = new CycleschemeServiceImpl();
			if (global != null && global.getUserinfo().getId() > 0) {
				if (cycleschemessteward != null) {
					if (cycleschemessteward.getId() != 0) {
						cycleschemessteward.setUpdateby(global.getUserinfo()
								.getId());
						cycleschemessteward.setUpdatetime(new Date());
						setMsg("修改成功！");
						markSuccess();
					} else {
						cycleschemessteward.setCreateby(global.getUserinfo()
								.getId());
						cycleschemessteward.setCreatetime(new Date());
						cycleschemessteward.setUpdateby(global.getUserinfo()
								.getId());
						cycleschemessteward.setUpdatetime(new Date());
						setMsg("添加成功！");
						markSuccess();
					}
				}
				cycleschemeService.saveCycleschemessteward(cycleschemessteward);
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

	public String qryCycleschemessteward() {
		try {
			cycleschemeService = new CycleschemeServiceImpl();
			setCycleschemesstewardlist(cycleschemeService
					.qryCycleschemessteward(cyclescheme));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	// 删除循环乘务员
	public String delCycleschemessteward() {
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				cycleschemeService = new CycleschemeServiceImpl();
				if (cycleschemeService
						.delCycleschemessteward(cycleschemessteward)) {
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

	// 下移循环乘务员
	public String nextCycleschemessteward() {
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				cycleschemeService = new CycleschemeServiceImpl();
				if (cycleschemeService
						.nextCycleschemessteward(cycleschemessteward)) {
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

	// 上移循环乘务员
	public String priorCycleschemessteward() {
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				cycleschemeService = new CycleschemeServiceImpl();
				if (cycleschemeService
						.priorCycleschemessteward(cycleschemessteward)) {
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

	@Transient
	public Cycleschemes getCyclescheme() {
		return cyclescheme;
	}

	public void setCyclescheme(Cycleschemes cyclescheme) {
		this.cyclescheme = cyclescheme;
	}

	public List<Map<String, Object>> getCycleschemelist() {
		return cycleschemelist;
	}

	public void setCycleschemelist(List<Map<String, Object>> cycleschemelist) {
		this.cycleschemelist = cycleschemelist;
	}

	public List<Map<String, Object>> getSchedulecyclelist() {
		return schedulecyclelist;
	}

	public void setSchedulecyclelist(List<Map<String, Object>> schedulecyclelist) {
		this.schedulecyclelist = schedulecyclelist;
	}

	public Schedulecycle getSchedulecycle() {
		return schedulecycle;
	}

	public void setSchedulecycle(Schedulecycle schedulecycle) {
		this.schedulecycle = schedulecycle;
	}

	public Cycleschemesschedule getCycleschemesschedule() {
		return cycleschemesschedule;
	}

	public void setCycleschemesschedule(
			Cycleschemesschedule cycleschemesschedule) {
		this.cycleschemesschedule = cycleschemesschedule;
	}

	public List<Map<String, Object>> getCycleschemesschedulelist() {
		return cycleschemesschedulelist;
	}

	public void setCycleschemesschedulelist(
			List<Map<String, Object>> cycleschemesschedulelist) {
		this.cycleschemesschedulelist = cycleschemesschedulelist;
	}

	public Cycleschemesvehicle getCycleschemesvehicle() {
		return cycleschemesvehicle;
	}

	public void setCycleschemesvehicle(Cycleschemesvehicle cycleschemesvehicle) {
		this.cycleschemesvehicle = cycleschemesvehicle;
	}

	public List<Map<String, Object>> getCycleschemesvehiclelist() {
		return cycleschemesvehiclelist;
	}

	public void setCycleschemesvehiclelist(
			List<Map<String, Object>> cycleschemesvehiclelist) {
		this.cycleschemesvehiclelist = cycleschemesvehiclelist;
	}

	public Cycleschemesdriver getCycleschemesdriver() {
		return cycleschemesdriver;
	}

	public void setCycleschemesdriver(Cycleschemesdriver cycleschemesdriver) {
		this.cycleschemesdriver = cycleschemesdriver;
	}

	public Cycleschemessteward getCycleschemessteward() {
		return cycleschemessteward;
	}

	public void setCycleschemessteward(Cycleschemessteward cycleschemessteward) {
		this.cycleschemessteward = cycleschemessteward;
	}

	public List<Map<String, Object>> getCycleschemesdriverlist() {
		return cycleschemesdriverlist;
	}

	public void setCycleschemesdriverlist(
			List<Map<String, Object>> cycleschemesdriverlist) {
		this.cycleschemesdriverlist = cycleschemesdriverlist;
	}

	public List<Map<String, Object>> getCycleschemesstewardlist() {
		return cycleschemesstewardlist;
	}

	public void setCycleschemesstewardlist(
			List<Map<String, Object>> cycleschemesstewardlist) {
		this.cycleschemesstewardlist = cycleschemesstewardlist;
	}
	public Long getCycleschemeid() {
		return cycleschemeid;
	}

	public void setCycleschemeid(Long cycleschemeid) {
		this.cycleschemeid = cycleschemeid;
	}

	public Long getTypes() {
		return types;
	}

	public void setTypes(Long types) {
		this.types = types;
	}
	
}
