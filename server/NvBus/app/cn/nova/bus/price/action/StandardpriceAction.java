package cn.nova.bus.price.action;

import cn.nova.bus.action.BaseAction;
import java.util.List;
import java.util.Map;

import util.CurrentUtil;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.price.service.StandardpriceService;
import cn.nova.bus.price.service.impl.StandardpriceServiceImpl;
import cn.nova.bus.security.Global;
import cn.nova.utils.web.ServletPropertyFilterUtil;

public class StandardpriceAction extends BaseAction{
	private Long scheduleid;
	private Long createby;
	private List<Map<String, Object>> standardpricemlist;
	private List<Map<String, Object>> standardpriceitemlist;

	public List<Map<String, Object>> getStandardpriceitemlist() {
		return standardpriceitemlist;
	}

	public void setStandardpriceitemlist(
			List<Map<String, Object>> standardpriceitemlist) {
		this.standardpriceitemlist = standardpriceitemlist;
	}

	private StandardpriceService standardpriceService;

	public String query() {
		try {
			standardpriceService = new StandardpriceServiceImpl();
			setStandardpricemlist(standardpriceService
					.query(ServletPropertyFilterUtil
							.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String qryStandardPriceItem() {
		try {
			standardpriceService = new StandardpriceServiceImpl();
			setStandardpriceitemlist(standardpriceService
					.qryStandardPriceItem(ServletPropertyFilterUtil
							.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String genStandardPrice() {
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				standardpriceService = new StandardpriceServiceImpl();
				if (standardpriceService.genPrice(scheduleid, createby)) {
					markSuccess();
					setMsg("生成成功！");
				}
			}
		} catch (ServiceException se) {
			markFail();
			setMsg(se.getMessage());
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			markFail();
			setMsg("公式票价生成失败！");
		}
		return "json";
	}

	public List<Map<String, Object>> getStandardpricemlist() {
		return standardpricemlist;
	}

	public void setStandardpricemlist(
			List<Map<String, Object>> standardpricemlist) {
		this.standardpricemlist = standardpricemlist;
	}

	public Long getScheduleid() {
		return scheduleid;
	}

	public void setScheduleid(Long scheduleid) {
		this.scheduleid = scheduleid;
	}

	public Long getCreateby() {
		return createby;
	}

	public void setCreateby(Long createby) {
		this.createby = createby;
	}

}
