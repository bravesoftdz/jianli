package cn.nova.bus.bill.action;

import cn.nova.bus.action.BaseAction;
import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import util.CurrentUtil;
import cn.nova.bus.bill.model.Billstorage;
import cn.nova.bus.bill.service.BillstorageService;
import cn.nova.bus.bill.service.impl.BillstorageServiceImpl;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;
import cn.nova.utils.web.ServletPropertyFilterUtil;

/**
 * 票据仓库
 * 
 * @author 蒋伟
 * @version 0.1
 */
public class BillstorageAction extends BaseAction{

	private List<Map<String, Object>> billstoragemap;
	public HttpServletRequest httpServletRequest;
	private Billstorage billstorage;
	private Long id;
	
	private BillstorageService billstorageService;

	public String save() {
		billstorageService = new BillstorageServiceImpl();
		Global global = CurrentUtil.getGlobal();

		if (billstorage != null) {
			if (billstorage.getId() > 0) {
				billstorage.setUpdateby(global.getUserinfo().getId());
				billstorage.setUpdatetime(new Timestamp(System
						.currentTimeMillis()));
			} else {
				billstorage.setCreateby(global.getUserinfo().getId());
				billstorage.setCreatetime(new Timestamp(System
						.currentTimeMillis()));
				billstorage.setUpdateby(global.getUserinfo().getId());
				billstorage.setUpdatetime(new Timestamp(System
						.currentTimeMillis()));
			}
			if (billstorage.getId() > 0) {
				msg = "修改成功！";
				markSuccess();
			} else {
				msg = "添加成功！";
				markSuccess();
			}
			try {
				billstorage = billstorageService.save(billstorage);
				setId(billstorage.getId());
			} catch (ServiceException e) {
				setMsg(e.getMessage());
				markFail();
			} catch (Exception ex){
				setMsg(ex.getMessage());
				markFail();
				play.Logger.error(ex.getMessage(), ex);
			}
		}
		return "json";

	}

	public String list() {
		try {
			billstorageService = new BillstorageServiceImpl();
			setBillstoragemap(billstorageService
					.query(ServletPropertyFilterUtil
							.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String delete() {
		if (billstorage.getId() > 0) {
			boolean result = false;
			try {
				billstorageService = new BillstorageServiceImpl();
				result = billstorageService.delete(billstorage.getId());
			} catch (Exception e) {
				msg = e.getMessage();
				markFail();
				return "json";
			}
			if (result) {
				msg = "删除成功！";
				markSuccess();
			} else {
				msg = "删除失败！";
				markFail();
			}
		}
		return "json";
	}

	public List<Map<String, Object>> getBillstoragemap() {
		return billstoragemap;
	}

	public void setBillstoragemap(List<Map<String, Object>> billstoragemap) {
		this.billstoragemap = billstoragemap;
	}

	public Billstorage getBillstorage() {
		return billstorage;
	}

	public void setBillstorage(Billstorage billstorage) {
		this.billstorage = billstorage;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

}
