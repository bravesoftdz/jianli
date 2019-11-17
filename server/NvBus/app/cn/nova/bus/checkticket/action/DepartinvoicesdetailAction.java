package cn.nova.bus.checkticket.action;

import cn.nova.bus.action.BaseAction;

import java.util.Date;
import java.util.List;
import java.util.Map;

import util.CurrentUtil;

import cn.nova.bus.checkticket.model.Departinvoicesdetail;
import cn.nova.bus.checkticket.service.DepartinvoicesdetailService;
import cn.nova.bus.checkticket.service.impl.DepartinvoicesdetailServiceImpl;
import cn.nova.bus.checkticket.service.impl.DepartinvoicesotherdetailServiceImpl;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;
import cn.nova.utils.web.ServletPropertyFilterUtil;

public class DepartinvoicesdetailAction extends BaseAction{
	private Departinvoicesdetail departinvoicesdeail;
	private long departinvoicesid;
	private long id;
	private int iscomputerno;
	private List<Map<String, Object>> invoicesdetailMap;

	private DepartinvoicesdetailService departinvoicesdetailService;

	public String query() {
		departinvoicesdetailService = new DepartinvoicesdetailServiceImpl();
		try {
			setInvoicesdetailMap(departinvoicesdetailService
					.query(ServletPropertyFilterUtil
							.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	public String qrydeailBydepartinvoicesid(){
		departinvoicesdetailService = new DepartinvoicesdetailServiceImpl();
		try {
			setInvoicesdetailMap(departinvoicesdetailService.qrydeailBydepartinvoicesid(departinvoicesid));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	public String save() {
		departinvoicesdetailService = new DepartinvoicesdetailServiceImpl();
		Global global = CurrentUtil.getGlobal();
		try {
			if (departinvoicesdeail != null) {
				if (departinvoicesdeail.getId() > 0) {
					
					departinvoicesdeail.setUpdateby(global.getUserinfo()
							.getId());
					departinvoicesdeail.setUpdatetime(new Date());
					setMsg("修改成功！");
					markSuccess();
				} 
				id=departinvoicesdetailService.savedetail(departinvoicesdeail);
			}
		} catch (ServiceException se) {
			setMsg(se.getMessage());
			markFail();
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			setMsg("操作失败：" + e.getMessage());
			markFail();
		}
		return "json";
	}

	public Departinvoicesdetail getDepartinvoicesdeail() {
		return departinvoicesdeail;
	}

	public void setDepartinvoicesdeail(Departinvoicesdetail departinvoicesdeail) {
		this.departinvoicesdeail = departinvoicesdeail;
	}

	public long getDepartinvoicesid() {
		return departinvoicesid;
	}

	public void setDepartinvoicesid(long departinvoicesid) {
		this.departinvoicesid = departinvoicesid;
	}

	public List<Map<String, Object>> getInvoicesdetailMap() {
		return invoicesdetailMap;
	}

	public void setInvoicesdetailMap(List<Map<String, Object>> invoicesdetailMap) {
		this.invoicesdetailMap = invoicesdetailMap;
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public int getIscomputerno() {
		return iscomputerno;
	}

	public void setIscomputerno(int iscomputerno) {
		this.iscomputerno = iscomputerno;
	}
	

}
