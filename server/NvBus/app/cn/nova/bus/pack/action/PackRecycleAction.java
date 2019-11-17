package cn.nova.bus.pack.action;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import cn.nova.bus.action.BaseAction;
import cn.nova.bus.pack.service.PackRecycleService;
import cn.nova.bus.pack.service.impl.PackRecycleServiceImpl;
import cn.nova.utils.web.ServletPropertyFilterUtil;

/**
 * 货物结算单结算
 * @author Administrator
 *
 */
public class PackRecycleAction extends BaseAction {
	private Long packid;
	private Long packno;
	private Long vehicleid;

	private List<Map<String, Object>> packList;

	private PackRecycleService packRecycleService;

	//列表查询
	public String getList(){
		packRecycleService = new PackRecycleServiceImpl();
		setPackList(packRecycleService.getList(ServletPropertyFilterUtil.buildFromHttpRequest()));
		return "json";
	}

	//对付回收
	public String recycle(){
		try {
			packRecycleService = new PackRecycleServiceImpl();
			packRecycleService.recycle(packid, vehicleid);
			markSuccess();
			setMsg("结算成功！");
		} catch (Exception e) {
			e.printStackTrace();
			markFail();
			setMsg("结算失败！");
		}
		return "json";
	}
	
	public List<Map<String, Object>> getPackList() {
		return packList;
	}

	public void setPackList(List<Map<String, Object>> packList) {
		this.packList = packList;
	}

	public Long getPackid() {
		return packid;
	}

	public void setPackid(Long packid) {
		this.packid = packid;
	}

	public Long getPackno() {
		return packno;
	}

	public void setPackno(Long packno) {
		this.packno = packno;
	}

	public Long getVehicleid() {
		return vehicleid;
	}

	public void setVehicleid(Long vehicleid) {
		this.vehicleid = vehicleid;
	}
	
}
