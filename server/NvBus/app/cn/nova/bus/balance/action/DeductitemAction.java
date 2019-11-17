package cn.nova.bus.balance.action;

import cn.nova.bus.action.BaseAction;
import java.util.Date;
import java.util.List;
import java.util.Map;

import util.CurrentUtil;
import cn.nova.bus.balance.model.Deductitem;
import cn.nova.bus.balance.model.Deductroutestop;
import cn.nova.bus.balance.service.DeductitemService;
import cn.nova.bus.balance.service.impl.DeductitemServiceImpl;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;
import cn.nova.utils.web.ServletPropertyFilterUtil;

/**
 * 
 * <b>类描述：</b><br/>
 * <b>类名称：</b>DeductitemAction<br/>
 * <b>创建人：</b><a href="mailto:lanchengkun@nova.net.cn">兰成坤</a><br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 * 
 */
public class DeductitemAction extends BaseAction{
	private long deductitemid;
	private List<Map<String, Object>> deductitemlist;
	private Deductitem deductitem;
	private Deductroutestop deductroutestop;
	private long routeid;
	private List<Deductroutestop> drlist;

	private DeductitemService deductitemService;

	public String qrydeductitems() {
		try {
			deductitemService = new DeductitemServiceImpl();
			Global global = CurrentUtil.getGlobal();
			if (global != null && global.getUserinfo().getId() > 0) {
				deductitemlist = deductitemService
						.qryDeductitem(ServletPropertyFilterUtil
								.buildFromHttpRequest());
			}
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	public String qryStationDeducts() {
		try {
			deductitemService = new DeductitemServiceImpl();
			Global global = CurrentUtil.getGlobal();
			if (global != null && global.getUserinfo().getId() > 0) {
				deductitemlist = deductitemService.qryStationDeduct(routeid);
			}
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	//保存站点扣费
	public String saveStationDeducts() {
		try {		
			deductitemService = new DeductitemServiceImpl();
			Global global = CurrentUtil.getGlobal();
			if (global != null && global.getUserinfo().getId() > 0) {
				if (deductitemService.saveStationDeduct(drlist)){
					markSuccess();
					setMsg("保存成功！");
				}else{
					markSuccess();
					setMsg("保存失败！");
				}
			}
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			markSuccess();
			setMsg("保存失败！");			
		}
		return "json";
	}
	//删除扣费
	public String deldeductitems() {
		try {		
			deductitemService = new DeductitemServiceImpl();
			Global global = CurrentUtil.getGlobal();
			if (global != null && global.getUserinfo().getId() > 0) {
				if (deductitemService.delDeductitem(deductitem)){
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
	// 保存
	public String saveDeductitems() {
		Global global = CurrentUtil.getGlobal();
		try {
			deductitemService = new DeductitemServiceImpl();
			if (global != null && global.getUserinfo().getId() > 0) {
				if (deductitem.getId() == 0) {
					markSuccess();
					setMsg("添加成功！");
					deductitem.setCreateby(global.getUserinfo().getId());
					deductitem.setUpdateby(global.getUserinfo().getId());
					deductitem.setCreatetime(new Date());
					deductitem.setUpdatetime(new Date());
				} else {
					markSuccess();
					setMsg("修改成功！");
					deductitem.setUpdateby(global.getUserinfo().getId());
					deductitem.setUpdatetime(new Date());
				}
				deductitem = deductitemService.saveDeductitem(deductitem);
				deductitemid = deductitem.getId();
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
	public String qryRouteDeduct() {
		try {
			deductitemService = new DeductitemServiceImpl();
			Global global = CurrentUtil.getGlobal();
			if (global != null && global.getUserinfo().getId() > 0) {
				deductitemlist = deductitemService
						.qryRouteDeduct(ServletPropertyFilterUtil
								.buildFromHttpRequest());
			}
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	//删除线路站点扣费
	public String delDeductroutestop() {
		try {		
			deductitemService = new DeductitemServiceImpl();
			Global global = CurrentUtil.getGlobal();
			if (global != null && global.getUserinfo().getId() > 0) {
				if (deductitemService.delDeductroutestop(deductroutestop)){
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
	
	public long getDeductitemid() {
		return deductitemid;
	}

	public void setDeductitemid(long deductitemid) {
		this.deductitemid = deductitemid;
	}

	public List<Map<String, Object>> getDeductitemlist() {
		return deductitemlist;
	}

	public void setDeductitemlist(List<Map<String, Object>> deductitemlist) {
		this.deductitemlist = deductitemlist;
	}

	public Deductitem getDeductitem() {
		return deductitem;
	}

	public void setDeductitem(Deductitem deductitem) {
		this.deductitem = deductitem;
	}
	public long getRouteid() {
		return routeid;
	}

	public void setRouteid(long routeid) {
		this.routeid = routeid;
	}
	public Deductroutestop getDeductroutestop() {
		return deductroutestop;
	}

	public void setDeductroutestop(Deductroutestop deductroutestop) {
		this.deductroutestop = deductroutestop;
	}
	public List<Deductroutestop> getDrlist() {
		return drlist;
	}

	public void setDrlist(List<Deductroutestop> drlist) {
		this.drlist = drlist;
	}
}
