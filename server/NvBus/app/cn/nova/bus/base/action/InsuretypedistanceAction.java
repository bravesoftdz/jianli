package cn.nova.bus.base.action;

import cn.nova.bus.action.BaseAction;
import java.util.List;
import java.util.Map;

import util.CurrentUtil;
import cn.nova.bus.base.model.Insurancetypefares;
import cn.nova.bus.base.model.Insuretypedistance;
import cn.nova.bus.base.model.Insuretypeticketprice;
import cn.nova.bus.base.service.InsuretypedistanceService;
import cn.nova.bus.base.service.impl.InsuretypedistanceServiceImpl;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;
import cn.nova.utils.web.ServletPropertyFilterUtil;

public class InsuretypedistanceAction extends BaseAction{
	private List<Map<String, Object>> map;
	private Insuretypedistance insuretypedistance;
	private Insuretypeticketprice insuretypeticketprice;
	private long id;
	private List<Map<String, Object>> qryInsuranceTypeFaresList;
	private Insurancetypefares insurancetypefares;

	private InsuretypedistanceService insuretypedistanceService;

	
	
	public String saveinsuretypeprice() {
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				id=0;
				if (insuretypeticketprice.getId() > 0) {
					setMsg("修改成功！");
					markSuccess();
				} else {
					setMsg("添加成功！");
					markSuccess();
				}
				insuretypedistanceService = new InsuretypedistanceServiceImpl();
				insuretypeticketprice = insuretypedistanceService
						.saveinsuretypeprice(insuretypeticketprice);
				id = insuretypeticketprice.getId();
			}
		} catch (ServiceException se) {
			id=0;
			setMsg(se.getMessage());
			markFail();
		} catch (Exception ex) {
			play.Logger.error(ex.getMessage(), ex);
			msg = "保存失败！";
			markFail();
		}
		return "json";
	}

	public String deleteinsuretypeprice() {
		if (insuretypeticketprice != null) {
			try {
				insuretypedistanceService = new InsuretypedistanceServiceImpl();
				boolean result = insuretypedistanceService
						.deleteinsuretypeprice(insuretypeticketprice);
				if (result) {
					msg = "删除成功！";
					markSuccess();
				} else {
					msg = "删除失败！";
					markFail();
				}
			} catch (Exception ex) {
				play.Logger.error(ex.getMessage(), ex);
				msg = "删除失败:" + ex.getMessage();
				markFail();
			}
		}
		return "json";
	}
	
	
	/**
	 * 查询保险类型票价相关
	 * @return
	 */
	public String qryinsuretypeprice(){
		try {
			insuretypedistanceService = new InsuretypedistanceServiceImpl();
			setMap(insuretypedistanceService.qryinsuretypeprice(ServletPropertyFilterUtil
					.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	public String query() {
		try {
			insuretypedistanceService = new InsuretypedistanceServiceImpl();
			setMap(insuretypedistanceService.query(ServletPropertyFilterUtil
					.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	public String qryInsuranceTypeFares() {
		try {
			insuretypedistanceService = new InsuretypedistanceServiceImpl();
			setQryInsuranceTypeFaresList(insuretypedistanceService.qryInsuranceTypeFares(ServletPropertyFilterUtil
					.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	public String save() {
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				id=0;
				if (insuretypedistance.getId() > 0) {
					setMsg("修改成功！");
					markSuccess();
				} else {
					setMsg("添加成功！");
					markSuccess();
				}
				insuretypedistanceService = new InsuretypedistanceServiceImpl();
				insuretypedistance = insuretypedistanceService
						.save(insuretypedistance);
				id = insuretypedistance.getId();
			}
		} catch (ServiceException se) {
			id=0;
			setMsg(se.getMessage());
			markFail();
		} catch (Exception ex) {
			play.Logger.error(ex.getMessage(), ex);
			msg = "保存失败！";
			markFail();
		}
		return "json";
	}


	
	public String saveinsuretypeFares() {
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				if (insurancetypefares.getId() > 0) {
					setMsg("修改成功！");
					markSuccess();
				} else {
					setMsg("添加成功！");
					markSuccess();
				}
				insuretypedistanceService = new InsuretypedistanceServiceImpl();
				insurancetypefares = insuretypedistanceService
						.saveinsuretypeFares(global,insurancetypefares);
				setFlag(Long.valueOf(insurancetypefares.getId()));
			}
		} catch (ServiceException se) {
			setFlag(Long.valueOf(0));
			setMsg(se.getMessage());
			markFail();
		} catch (Exception ex) {
			play.Logger.error(ex.getMessage(), ex);
			msg = "保存失败！";
			markFail();
		}
		return "json";
	}
	public String delete() {
		if (insuretypedistance != null) {
			try {
				insuretypedistanceService = new InsuretypedistanceServiceImpl();
				boolean result = insuretypedistanceService
						.delete(insuretypedistance);
				if (result) {
					msg = "删除成功！";
					markSuccess();
				} else {
					msg = "删除失败！";
					markFail();
				}
			} catch (Exception ex) {
				play.Logger.error(ex.getMessage(), ex);
				msg = "删除失败:" + ex.getMessage();
				markFail();
			}
		}
		return "json";
	}
	
	public String deletefares() {
		if (insurancetypefares != null) {
			try {
				insuretypedistanceService = new InsuretypedistanceServiceImpl();
				boolean result = insuretypedistanceService
						.deletefares(insurancetypefares);
				if (result) {
					setMsg("删除成功！");
					markSuccess();
				} else {
					setMsg("删除失败！");
					markFail();
				}
			} catch (Exception ex) {
				play.Logger.error(ex.getMessage(), ex);
				setMsg("删除失败:" + ex.getMessage());
				markFail();
			}
		}
		return "json";
	}
	public List<Map<String, Object>> getMap() {
		return map;
	}

	public void setMap(List<Map<String, Object>> map) {
		this.map = map;
	}

	public void setInsuretypedistance(Insuretypedistance insuretypedistance) {
		this.insuretypedistance = insuretypedistance;
	}
	public Insuretypedistance getInsuretypedistance() {
		return insuretypedistance;
	}
	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public Insuretypeticketprice getInsuretypeticketprice() {
		return insuretypeticketprice;
	}

	public void setInsuretypeticketprice(Insuretypeticketprice insuretypeticketprice) {
		this.insuretypeticketprice = insuretypeticketprice;
	}

	public List<Map<String, Object>> getQryInsuranceTypeFaresList() {
		return qryInsuranceTypeFaresList;
	}

	public void setQryInsuranceTypeFaresList(
			List<Map<String, Object>> qryInsuranceTypeFaresList) {
		this.qryInsuranceTypeFaresList = qryInsuranceTypeFaresList;
	}

	public Insurancetypefares getInsurancetypefares() {
		return insurancetypefares;
	}

	public void setInsurancetypefares(Insurancetypefares insurancetypefares) {
		this.insurancetypefares = insurancetypefares;
	}
	
	
}
