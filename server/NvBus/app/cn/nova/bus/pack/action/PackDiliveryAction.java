package cn.nova.bus.pack.action;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.Map;

import util.CurrentUtil;
import cn.nova.bus.action.BaseAction;
import cn.nova.bus.bill.service.impl.BilltypeServiceImpl;
import cn.nova.bus.pack.model.PackDilivery;
import cn.nova.bus.pack.service.PackDiliveryService;
import cn.nova.bus.pack.service.impl.PackDiliveryServiceImpl;
import cn.nova.bus.security.Global;
import cn.nova.utils.web.ServletPropertyFilterUtil;

public class PackDiliveryAction extends BaseAction{
	
	private List<Map<String, Object>> packdiliverylist;
	private PackDilivery packdilivery;
//	private List<Map<String, Object>> existPackDilivery;
	private PackDiliveryService pdService = null;

	
	public String list(){
		try {
			pdService = new PackDiliveryServiceImpl();
			setPackdiliverylist(pdService.query(ServletPropertyFilterUtil
					.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	public String savePackDilivery() {
		/*Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				if (packdilivery != null) {
					PackDilivery p0 = PackDilivery.find("byPackid", packdilivery.getPackid()).first();
						if (p0 != null) {
							setMsg("同城送货记录已存在！");
							markSuccess();
						} else {
							packdilivery.setCreateby(global.getUserinfo().getId());
							packdilivery.setCreatetime(new Date());
							packdilivery.setUpdateby(global.getUserinfo().getId());
							packdilivery.setUpdatetime(new Date());
							setMsg("添加成功！");
							markSuccess();
							packdilivery = pdService.savePackDilivery(packdilivery);
							setId(packdilivery.getId());
						}
					}
				}
		} catch (Exception ex) {
			play.Logger.error(ex.getMessage(), ex);
			setMsg("操作失败！");
			markFail();
		}*/
		return "json";
	}
	
	public String updatePackDilivery() {
		pdService = new PackDiliveryServiceImpl(); 
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				if (packdilivery != null) {
					if (null != packdilivery.getId() && packdilivery.getId() > 0) {
						packdilivery.setUpdateby(global.getUserinfo().getId());
						packdilivery.setUpdatetime(new Date());
						int i = pdService.updatePackDilivery(packdilivery);
						if (i > 0) {
							setMsg("修改成功！");
							markSuccess();
						} else {
							setMsg("修改失败！");
							markFail();
						}
					}
				}
			}
		} catch (Exception ex) {
			play.Logger.error(ex.getMessage(), ex);
			setMsg("操作失败！");
			markFail();
		}
		return "json";
	}
	
	public String delPackDilivery() {
		pdService = new PackDiliveryServiceImpl(); 
		if (packdilivery != null) {
			pdService.delPackDilivery(packdilivery);
		    msg = "同城送货记录删除成功！";
		}
		markSuccess();
		return "json";
	}
	
	public List<Map<String, Object>> getPackdiliverylist() {
		return packdiliverylist;
	}

	public void setPackdiliverylist(List<Map<String, Object>> packdiliverylist) {
		this.packdiliverylist = packdiliverylist;
	}
 
	public void setPackdilivery(PackDilivery packdilivery) {
		this.packdilivery = packdilivery;
	}
}
