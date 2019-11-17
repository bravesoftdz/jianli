package cn.nova.bus.bill.action;

import cn.nova.bus.action.BaseAction;
import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import util.CurrentUtil;
import cn.nova.bus.bill.model.Billtype;
import cn.nova.bus.bill.service.BilltypeService;
import cn.nova.bus.bill.service.impl.BilltypeServiceImpl;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;
import cn.nova.utils.web.ServletPropertyFilterUtil;

/**
 * 票据类型
 * 
 * @author 蒋伟
 * @version 0.1
 */
public class BilltypeAction extends BaseAction{

	private Billtype billtype;
	private List<Map<String, Object>> billtypemap;
	public HttpServletRequest httpServletRequest;
	private Long id;
	private String name;

	private BilltypeService billtypeService;
	
	/**
	 * 根据票据类型查询票据价格
	 * @return
	 */
	public String qryvalue(){
		billtypeService = new BilltypeServiceImpl();
		billtypemap  = billtypeService.qryvalue(name);
		return "json";
	}

	public String save() {
		billtypeService = new BilltypeServiceImpl();
		Global global = CurrentUtil.getGlobal();

		try {
			if (billtype != null) {
				if (billtype.getId() > 0) {
					billtype.setUpdateby(global.getUserinfo().getId());
					billtype.setUpdatetime(new Timestamp(System
							.currentTimeMillis()));

				} else {

					billtype.setCreateby(global.getUserinfo().getId());
					billtype.setCreatetime(new Timestamp(System
							.currentTimeMillis()));
					billtype.setUpdateby(global.getUserinfo().getId());
					billtype.setUpdatetime(new Timestamp(System
							.currentTimeMillis()));
				}
				if (billtype.getId() > 0) {
					msg = "修改成功！";
					markSuccess();
				} else {
					msg = "添加成功！";
					markSuccess();
				}
				billtype = billtypeService.save(billtype);
				id = billtype.getId();
			}
		} catch (ServiceException e) {
			markFail();
			setMsg(e.getMessage());
			play.Logger.error(e.getMessage(), e);
		} catch (Exception ex) {
			markFail();
			setMsg(ex.getMessage());
			play.Logger.error(ex.getMessage(), ex);
		}
		return "json";

	}

	public String list() {
		try {
			billtypeService = new BilltypeServiceImpl();
			setBilltypemap(billtypeService.query(ServletPropertyFilterUtil
					.buildFromHttpRequest()));
			billtypeService=null;
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	public String queryUsableBillType(){
		try {
			billtypeService = new BilltypeServiceImpl();
			setBilltypemap(billtypeService.queryUsableBillType());
			billtypeService=null;
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
		
	}

	public List<Map<String, Object>> getBilltypemap() {
		return billtypemap;
	}

	public void setBilltypemap(List<Map<String, Object>> billtypemap) {
		this.billtypemap = billtypemap;
	}

	public Billtype getBilltype() {
		return billtype;
	}

	public void setBilltype(Billtype billtype) {
		this.billtype = billtype;
	}

	public String delete() {
		billtypeService = new BilltypeServiceImpl();
		if (billtype.getId() > 0) {
			boolean result = false;
			try {
				result = billtypeService.delete(billtype.getId());
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

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

}
