package cn.nova.bus.system.action;

import cn.nova.bus.action.BaseAction;
import java.util.Date;
import java.util.List;
import java.util.Map;

import util.CurrentUtil;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;
import cn.nova.bus.system.model.Printtemplateitemset;
import cn.nova.bus.system.service.PrinttemplateitemsetService;
import cn.nova.bus.system.service.impl.PrinttemplateitemsetServiceImpl;
import cn.nova.utils.web.ServletPropertyFilterUtil;

public class PrintItemSetAction extends BaseAction{
	private List<Map<String, Object>> printlist;
	private Printtemplateitemset printtemplateitemset;
	private long operationid; // 添加修改结果回传
	
	private long orgid;
	private long vehicleid;
	private String templatename;

	private PrinttemplateitemsetService printtemplateitemsetService;

	public String qryprintitem() {
		try {
			printtemplateitemsetService = new PrinttemplateitemsetServiceImpl();
			printlist = printtemplateitemsetService
					.query(orgid,vehicleid,templatename);
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String queryPrinttemplatetype() {
		try {
			printtemplateitemsetService = new PrinttemplateitemsetServiceImpl();
			printlist = printtemplateitemsetService
					.query(ServletPropertyFilterUtil
							.buildFromHttpRequest());
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	public String savePrinttemplatetype() {
		try {
			Global global = CurrentUtil.getGlobal();
			if (global != null && global.getUserinfo().getId() > 0) {
				if (printtemplateitemset.getId() <= 0) {
					printtemplateitemset.setCreatetime(new Date());
					printtemplateitemset.setUpdateby(printtemplateitemset
							.getCreateby());
					printtemplateitemset.setUpdatetime(new Date());
					setMsg("添加成功！");

				} else {
					setMsg("修改成功！");
					printtemplateitemset.setUpdateby(global.getUserinfo().getId());
					printtemplateitemset.setUpdatetime(new Date());
				}
				printtemplateitemsetService = new PrinttemplateitemsetServiceImpl();
				printtemplateitemset = printtemplateitemsetService
						.save(printtemplateitemset);
				setOperationid(printtemplateitemset.getId());
				markSuccess();
			}
		} catch (ServiceException e) {
			markFail();
			setMsg(e.getExceptionMessage());
		} catch (Exception e) {
			markFail();
			setMsg(e.getMessage());
		}
		return "json";
	}

	public String deletePrintItemSet() {
		try {
			printtemplateitemsetService = new PrinttemplateitemsetServiceImpl();
			if (printtemplateitemsetService
					.delete(printtemplateitemset.getId())) {
				setMsg("删除成功！");
				markSuccess();
			}
		} catch (Exception e) {
			markFail();
			setMsg(e.getMessage());
		}
		return "json";
	}

	public long getOperationid() {
		return operationid;
	}

	public void setOperationid(long operationid) {
		this.operationid = operationid;
	}

	public Printtemplateitemset getPrinttemplateitemset() {
		return printtemplateitemset;
	}

	public void setPrinttemplateitemset(
			Printtemplateitemset printtemplateitemset) {
		this.printtemplateitemset = printtemplateitemset;
	}

	public List<Map<String, Object>> getPrintlist() {
		return printlist;
	}

	public void setPrintlist(List<Map<String, Object>> printlist) {
		this.printlist = printlist;
	}
	
	public long getOrgid() {
		return orgid;
	}

	public void setOrgid(long orgid) {
		this.orgid = orgid;
	}

	public long getVehicleid() {
		return vehicleid;
	}

	public void setVehicleid(long vehicleid) {
		this.vehicleid = vehicleid;
	}

	public String getTemplatename() {
		return templatename;
	}

	public void setTemplatename(String templatename) {
		this.templatename = templatename;
	}
}
