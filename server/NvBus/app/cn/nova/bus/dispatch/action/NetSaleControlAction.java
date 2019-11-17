package cn.nova.bus.dispatch.action;

import java.util.Date;
import java.util.List;
import java.util.Map;

import util.CurrentUserID;
import util.CurrentUtil;
import util.SystemException;
import util.UserTransaction;
import cn.nova.bus.action.BaseAction;
import cn.nova.bus.dispatch.model.TicketLoss;
import cn.nova.bus.dispatch.service.NetSaleControlService;
import cn.nova.bus.dispatch.service.TicketLossService;
import cn.nova.bus.dispatch.service.impl.NetSaleControlServiceImpl;
import cn.nova.bus.dispatch.service.impl.TicketLossServiceImpl;
import cn.nova.bus.sale.model.Ticketsell;
import cn.nova.bus.sale.service.TicketSellService;
import cn.nova.bus.sale.service.impl.TicketSellServiceImpl;
import cn.nova.utils.commons.MethodResult;
import cn.nova.utils.web.ServletPropertyFilterUtil;

/**
 * 网售机构不可售班次控制
 * 
 * @author shotacon
 *
 */
public class NetSaleControlAction extends BaseAction {

	private List<Map<String, Object>> resultlist;
	private NetSaleControlService netSaleControlService = null;
	private String scheduleidlist;
	private String orgid;
	private String netorgid;
	private long routeid;
	private long id;
	private String savestyle;
	
	
	/**
	 * 删除
	 * 
	 * @return
	 */
	public String delNetSaleControl() {
		try {
			netSaleControlService = new NetSaleControlServiceImpl();
			if(netSaleControlService.delNetSaleControl(id)){
				setMsg("删除成功!");
				markSuccess();
			}else{
				setMsg("删除失败!");
				markFail();
			}
		} catch (Exception e) {
			setMsg("删除失败!" + e.getMessage());
			markFail();
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	
	/**
	 * 查询
	 * 
	 * @return
	 */
	public String queryNetSaleControl() {
		try {
			netSaleControlService = new NetSaleControlServiceImpl();
			setResultlist(netSaleControlService.queryNetSaleControl(ServletPropertyFilterUtil.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	/**
	 * 保存
	 * 
	 * @return
	 */
	public String saveNetSaleControl() {
		try {
			netSaleControlService = new NetSaleControlServiceImpl();
			MethodResult mr = netSaleControlService.saveNetSaleControl(scheduleidlist, orgid, netorgid, routeid, savestyle);
			setMsg(mr.getResultMsg());
			markSuccess();
		} catch (Exception e) {
			setMsg("保存失败!" + e.getMessage());
			markFail();
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	/**
	 * 通过线路ID查询班次
	 * 
	 * @return
	 */
	public String queryschbyrouteid() {
		try {
			netSaleControlService = new NetSaleControlServiceImpl();
			setResultlist(netSaleControlService.queryschbyrouteid(ServletPropertyFilterUtil.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public List<Map<String, Object>> getResultlist() {
		return resultlist;
	}

	public void setResultlist(List<Map<String, Object>> resultlist) {
		this.resultlist = resultlist;
	}

	public String getScheduleidlist() {
		return scheduleidlist;
	}

	public void setScheduleidlist(String scheduleidlist) {
		this.scheduleidlist = scheduleidlist;
	}

	public String getOrgid() {
		return orgid;
	}

	public void setOrgid(String orgid) {
		this.orgid = orgid;
	}

	public String getNetorgid() {
		return netorgid;
	}

	public void setNetorgid(String netorgid) {
		this.netorgid = netorgid;
	}

	public long getRouteid() {
		return routeid;
	}

	public void setRouteid(long routeid) {
		this.routeid = routeid;
	}


	public long getId() {
		return id;
	}


	public void setId(long id) {
		this.id = id;
	}


	public String getSavestyle() {
		return savestyle;
	}


	public void setSavestyle(String savestyle) {
		this.savestyle = savestyle;
	}

	
}
