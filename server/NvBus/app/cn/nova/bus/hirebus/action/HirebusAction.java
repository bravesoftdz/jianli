package cn.nova.bus.hirebus.action;

import cn.nova.bus.action.BaseAction;
import java.util.Date;
import java.util.List;
import java.util.Map;

import util.CurrentUtil;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.hirebus.model.Hirebus;
import cn.nova.bus.hirebus.service.HirebusService;
import cn.nova.bus.hirebus.service.Impl.HirebusServiceImpl;
import cn.nova.bus.security.Global;
import cn.nova.utils.web.ServletPropertyFilterUtil;

public class HirebusAction extends BaseAction{
	private List<Map<String, Object>> hirebusmap;
	private Hirebus hirebus;
	private long hirebusid;
	
	private HirebusService hirebusService;
                                          
	public String listHirebus() {
		hirebusService = new HirebusServiceImpl();
		setHirebusmap(hirebusService.query(ServletPropertyFilterUtil
				.buildFromHttpRequest()));
		return "json";
	}

	public String saveHirebus() {
		hirebusService = new HirebusServiceImpl();
		Global global = CurrentUtil.getGlobal();
		try {
			hirebusService = new HirebusServiceImpl();
			if (global != null && global.getUserinfo().getId() > 0) {
				if (hirebus != null) {
					if (hirebus.getId() != 0) {
						hirebus.setUpdateby(global.getUserinfo().getId());
						hirebus.setUpdatetime(new Date());
						setMsg("修改成功！");
						markSuccess();
					} else {
						hirebus.setCreateby(global.getUserinfo().getId());
						hirebus.setCreatetime(new Date());
						hirebus.setUpdateby(global.getUserinfo().getId());
						hirebus.setUpdatetime(new Date());
						setMsg("添加成功！");
						markSuccess();
					}
					hirebus = hirebusService.saveHirebus(hirebus,global);
					setHirebusid(hirebus.getId());
				}
			}
		} catch (ServiceException ex) {
			setMsg(ex.getMessage());
			markFail();
		} catch (Exception ex) {
			play.Logger.error(ex.getMessage(), ex);
			setMsg("操作失败！");
			markFail();
		}
		return "json";
	}
	
	public String wasteHirebus() {
		hirebusService = new HirebusServiceImpl();
		Global global = CurrentUtil.getGlobal();
		try {
			hirebusService = new HirebusServiceImpl();
			hirebus.setUpdateby(global.getUserinfo().getId());
			hirebus.setUpdatetime(new Date());
			hirebusService.wastePack(hirebus);
			setMsg("废弃成功");
			markSuccess();
		} catch (ServiceException e) {
			setMsg("废弃失败，" + e.getExceptionMessage());
			markFail();
		}
		return "json";
	}
	
	/**
	 * 重打受理单时新添加一条记录同时把重打的数据改为废弃状态
	 */
	public String whackhirebus(){
		hirebusService = new HirebusServiceImpl();
		Global global = CurrentUtil.getGlobal();
		try {
			hirebusService = new HirebusServiceImpl();
			if (global != null && global.getUserinfo().getId() > 0) {
				if (hirebus != null) {
					hirebus.setUpdateby(global.getUserinfo().getId());
					hirebus.setUpdatetime(new Date());
					hirebus = hirebusService.whackhirebus(hirebus);
					setHirebusid(hirebus.getId());
					setMsg("");
					markSuccess();
				}
			}
		} catch (ServiceException ex) {
			setMsg(ex.getMessage());
			markFail();
		} catch (Exception ex) {
			play.Logger.error(ex.getMessage(), ex);
			setMsg("操作失败！");
			markFail();
		}
		return "json";
	}

	public List<Map<String, Object>> getHirebusmap() {
		return hirebusmap;
	}

	public void setHirebusmap(List<Map<String, Object>> hirebusmap) {
		this.hirebusmap = hirebusmap;
	}

	public Hirebus getHirebus() {
		return hirebus;
	}

	public void setHirebus(Hirebus hirebus) {
		this.hirebus = hirebus;
	}

	public long getHirebusid() {
		return hirebusid;
	}

	public void setHirebusid(long hirebusid) {
		this.hirebusid = hirebusid;
	}

}
