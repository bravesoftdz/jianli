/**
 * <b>项目名：</b>NvBusWeb<br/>
 * <b>包名：</b>cn.nova.bus.base.action<br/>
 * <b>文件名：</b>ScheduleseatreserveAction.java<br/>
 * <b>版本信息：</b><br/>
 * <b>日期：</b>2011-8-11-下午07:10:26<br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.base.action;

import cn.nova.bus.action.BaseAction;
import java.util.List;
import java.util.Map;

import javax.persistence.Transient;

import util.CurrentUtil;
import cn.nova.bus.base.model.Scheduleseatreserve;
import cn.nova.bus.base.service.ScheduleseatreserveService;
import cn.nova.bus.base.service.impl.ScheduleseatreserveServiceImpl;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;

/**
 * <b>类描述：</b><br/>
 * <b>类名称：</b>ScheduleseatreserveAction<br/>
 * <b>创建人：</b><a href="mailto:lanchengkun@nova.net.cn">兰成坤</a><br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 * 
 */
public class ScheduleseatreserveAction extends BaseAction{

	private Long scheduleid;
	private Long scheduleseatreserveid;
	private boolean issameroute;
	private Scheduleseatreserve scheduleseatreserve;
	private List<Map<String, Object>> reservelist;
	private List<Map<String, Object>> brandlist;

	private ScheduleseatreserveService scheduleseatreserveService;

	public String query() {
		try {
			scheduleseatreserveService = new ScheduleseatreserveServiceImpl();
			reservelist = scheduleseatreserveService
					.qryScheduleseatreserve(scheduleid);
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String save() {
		scheduleseatreserveService = new ScheduleseatreserveServiceImpl();
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				if (scheduleseatreserve != null) {
					if (scheduleseatreserve.getId() == 0) {
						setMsg("添加成功！");

						markSuccess();
					} else {
						setMsg("修改成功！");
						markSuccess();
					}
					scheduleseatreserve = scheduleseatreserveService
							.saveScheduleseatreserve(scheduleseatreserve,issameroute);
					scheduleseatreserveid = scheduleseatreserve.getId();
				}
			}
		} catch (ServiceException ex) {
			msg = ex.getMessage();
			markFail();
		} catch (Exception ex) {
			play.Logger.error(ex.getMessage(), ex);
			msg = "操作失败！";
			markFail();
		}
		return "json";
	}
	
	public String delschedule() {
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				scheduleseatreserveService = new ScheduleseatreserveServiceImpl();
				if (scheduleseatreserveService.delScheduleseatreserve(scheduleseatreserve)) {
					setMsg("删除成功！");
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
	
	// 查询班次循环中得车辆厂牌
	public String qryVehiclebrandmodel() {
		try {
			scheduleseatreserveService = new ScheduleseatreserveServiceImpl();
			setBrandlist(scheduleseatreserveService
					.qryScheduleVehiclebrandmodel(scheduleid));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	public boolean isIssameroute() {
		return issameroute;
	}

	public void setIssameroute(boolean issameroute) {
		this.issameroute = issameroute;
	}

	public Long getScheduleid() {
		return scheduleid;
	}

	public void setScheduleid(Long scheduleid) {
		this.scheduleid = scheduleid;
	}

	public Long getScheduleseatreserveid() {
		return scheduleseatreserveid;
	}

	public void setScheduleseatreserveid(Long scheduleseatreserveid) {
		this.scheduleseatreserveid = scheduleseatreserveid;
	}

	@Transient
	public Scheduleseatreserve getScheduleseatreserve() {
		return scheduleseatreserve;
	}

	public void setScheduleseatreserve(Scheduleseatreserve scheduleseatreserve) {
		this.scheduleseatreserve = scheduleseatreserve;
	}

	public List<Map<String, Object>> getReservelist() {
		return reservelist;
	}

	public void setReservelist(List<Map<String, Object>> reservelist) {
		this.reservelist = reservelist;
	}
	
	public List<Map<String, Object>> getBrandlist() {
		return brandlist;
	}

	public void setBrandlist(List<Map<String, Object>> brandlist) {
		this.brandlist = brandlist;
	}
}
