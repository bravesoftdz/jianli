package cn.nova.bus.price.action;

import cn.nova.bus.action.BaseAction;
import java.util.List;
import java.util.Map;

import util.CurrentUtil;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.price.model.Fuelfeegrade;
import cn.nova.bus.price.model.Fuelfeegradeapply;
import cn.nova.bus.price.model.Fuelfeegradedetail;
import cn.nova.bus.price.service.FuelfeegradeService;
import cn.nova.bus.price.service.impl.FuelfeegradeServiceImpl;
import cn.nova.bus.security.Global;
import cn.nova.utils.web.ServletPropertyFilterUtil;

public class FuelfeegradeAction extends BaseAction{
	private long id;
	private List<Map<String, Object>> datalist;
	private List<Map<String, Object>> routelist;	
	private long orgid;
	private List<Map<String, Object>> fuelfeegradedetaillist;
	private List<Map<String, Object>> fuelfeegradeapplylist;
	private Fuelfeegrade fuelfeegrade;
	private Fuelfeegradedetail fuelfeegradedetail;
	private Fuelfeegradeapply fuelfeegradeapply;
	private String orgids;
	private long fuelfeegradeid;
	private FuelfeegradeService fuelfeegradeService;

	public String saveFuelfeegrade() {
		setMsg("保存成功！");
		markSuccess();
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				fuelfeegradeService = new FuelfeegradeServiceImpl();
				fuelfeegrade = fuelfeegradeService
						.saveFuelfeegrade(fuelfeegrade);
				id = fuelfeegrade.getId();
			}
		} catch (ServiceException e) {
			setMsg(e.getExceptionMessage());
			markFail();
		} catch (Exception e) {
			setMsg("系统异常！");
			markFail();
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String qryFuelfeegrade() {
		try {
			fuelfeegradeService = new FuelfeegradeServiceImpl();
			setDatalist(fuelfeegradeService.qryFuelfeegrade(orgids));
			markSuccess();
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	public String qryFuelfeegrades() {
		try {
			fuelfeegradeService = new FuelfeegradeServiceImpl();
			setDatalist(fuelfeegradeService.qryFuelfeegrade(orgid));
			markSuccess();
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	public String delFuelfeegrade() {
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				fuelfeegradeService = new FuelfeegradeServiceImpl();
				if (fuelfeegradeService.delFuelfeegrade(fuelfeegrade)) {
					setMsg("删除成功！");
					markSuccess();
				} else {
					setMsg("删除失败！");
					markFail();
				}
			}
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			markFail();
			setMsg("删除失败！");
		}
		return "json";
	}

	public String saveFuelfeegradedetail() {
		setMsg("保存成功！");
		markSuccess();
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				fuelfeegradeService = new FuelfeegradeServiceImpl();
				fuelfeegradedetail = fuelfeegradeService
						.saveFuelfeegradedetail(fuelfeegradedetail);
				id = fuelfeegradedetail.getId();
			}
		} catch (ServiceException e) {
			setMsg(e.getExceptionMessage());
			markFail();
		} catch (Exception e) {
			setMsg("系统异常！");
			markFail();
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String qryFuelfeegradedetail() {
		try {
			fuelfeegradeService = new FuelfeegradeServiceImpl();
			fuelfeegradedetaillist=fuelfeegradeService.qryFuelfeegradedetail(fuelfeegradeid);
			markSuccess();
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String delFuelfeegradedetail() {
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				fuelfeegradeService = new FuelfeegradeServiceImpl();
				if (fuelfeegradeService.delFuelfeegradedetail(fuelfeegradedetail)) {
					setMsg("删除成功！");
					markSuccess();
				} else {
					setMsg("删除失败！");
					markFail();
				}
			}
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			markFail();
			setMsg("删除失败！");
		}
		return "json";
	}
	
	public String saveFuelfeegradeapply() {
		setMsg("保存成功！");
		markSuccess();
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				fuelfeegradeService = new FuelfeegradeServiceImpl();
				fuelfeegradeapply = fuelfeegradeService
						.saveFuelfeegradeapply(fuelfeegradeapply);
				id = fuelfeegradeapply.getId();
			}
		} catch (ServiceException e) {
			fuelfeegradeapply=null;
			setMsg(e.getExceptionMessage());
			markFail();
		} catch (Exception e) {
			setMsg("系统异常！");
			markFail();
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String qryFuelfeegradeapply() {
		try {
			fuelfeegradeService = new FuelfeegradeServiceImpl();
			fuelfeegradeapplylist=fuelfeegradeService.qryFuelfeegradeapply(ServletPropertyFilterUtil
					.buildFromHttpRequest());
			markSuccess();
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String delFuelfeegradeapply() {
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				fuelfeegradeService = new FuelfeegradeServiceImpl();
				if (fuelfeegradeService.delFuelfeegradeapply(fuelfeegradeapply)) {
					setMsg("删除成功！");
					markSuccess();
				} else {
					setMsg("删除失败！");
					markFail();
				}
			}
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			markFail();
			setMsg("删除失败！");
		}
		return "json";
	}
	public String qryRoutes() {
		try {
			fuelfeegradeService = new FuelfeegradeServiceImpl();
			routelist=fuelfeegradeService.qryRoutes(orgid);
			markSuccess();
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public List<Map<String, Object>> getDatalist() {
		return datalist;
	}

	public void setDatalist(List<Map<String, Object>> datalist) {
		this.datalist = datalist;
	}

	public Fuelfeegrade getFuelfeegrade() {
		return fuelfeegrade;
	}

	public void setFuelfeegrade(Fuelfeegrade fuelfeegrade) {
		this.fuelfeegrade = fuelfeegrade;
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getOrgids() {
		return orgids;
	}

	public void setOrgids(String orgids) {
		this.orgids = orgids;
	}

	public List<Map<String, Object>> getFuelfeegradedetaillist() {
		return fuelfeegradedetaillist;
	}

	public void setFuelfeegradedetaillist(
			List<Map<String, Object>> fuelfeegradedetaillist) {
		this.fuelfeegradedetaillist = fuelfeegradedetaillist;
	}

	public List<Map<String, Object>> getFuelfeegradeapplylist() {
		return fuelfeegradeapplylist;
	}

	public void setFuelfeegradeapplylist(
			List<Map<String, Object>> fuelfeegradeapplylist) {
		this.fuelfeegradeapplylist = fuelfeegradeapplylist;
	}

	public Fuelfeegradedetail getFuelfeegradedetail() {
		return fuelfeegradedetail;
	}

	public void setFuelfeegradedetail(Fuelfeegradedetail fuelfeegradedetail) {
		this.fuelfeegradedetail = fuelfeegradedetail;
	}

	public Fuelfeegradeapply getFuelfeegradeapply() {
		return fuelfeegradeapply;
	}

	public void setFuelfeegradeapply(Fuelfeegradeapply fuelfeegradeapply) {
		this.fuelfeegradeapply = fuelfeegradeapply;
	}
	public long getFuelfeegradeid() {
		return fuelfeegradeid;
	}

	public void setFuelfeegradeid(long fuelfeegradeid) {
		this.fuelfeegradeid = fuelfeegradeid;
	}
	
	public long getOrgid() {
		return orgid;
	}

	public void setOrgid(long orgid) {
		this.orgid = orgid;
	}	
	public List<Map<String, Object>> getRoutelist() {
		return routelist;
	}

	public void setRoutelist(List<Map<String, Object>> routelist) {
		this.routelist = routelist;
	}
	
}
