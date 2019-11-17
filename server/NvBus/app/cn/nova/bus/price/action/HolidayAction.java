package cn.nova.bus.price.action;

import cn.nova.bus.action.BaseAction;
import java.util.Date;
import java.util.List;
import java.util.Map;

import util.CurrentUtil;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.price.model.Holiday;
import cn.nova.bus.price.service.HolidayService;
import cn.nova.bus.price.service.impl.HolidayServiceImpl;
import cn.nova.bus.security.Global;
import cn.nova.utils.commons.MethodResult;
import cn.nova.utils.web.ServletPropertyFilterUtil;

public class HolidayAction extends BaseAction{
	private List<Map<String, Object>> holidaylist;
	private List<Map<String, Object>> importprice;
	private Holiday holiday;
	private long holidayid;

	public long getHolidayid() {
		return holidayid;
	}

	public void setHolidayid(long holidayid) {
		this.holidayid = holidayid;
	}

	private HolidayService holidayService;

	public String queryholiday() {
		try {
			holidayService = new HolidayServiceImpl();
			setHolidaylist(holidayService.query(ServletPropertyFilterUtil
					.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String saveholiday() {
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				if (holiday != null) {
					if (holiday.getId() != 0) {
						holiday.setUpdateby(global.getUserinfo().getId());
						holiday.setUpdatetime(new Date());
						setMsg("修改成功！");
						markSuccess();
					} else {
						holiday.setCreatetime(new Date());
						holiday.setUpdatetime(new Date());
						holiday.setCreateby(global.getUserinfo().getId());
						holiday.setUpdateby(global.getUserinfo().getId());
						setMsg("添加成功！");
						markSuccess();
					}
					holidayService = new HolidayServiceImpl();
					//校验节日日期是否交叉并通过节日ID获取节日票价信息并更新其中的节日信息
					MethodResult methodresult = holidayService.updateHolidayPrices(holiday); 
					if(methodresult.getResult()==0){
						setMsg(methodresult.getResultMsg());
						markFail();
					}else{
						setMsg(msg+methodresult.getResultMsg());
						markSuccess();
						holiday = holidayService.save(holiday);
						holidayid=holiday.getId();
					}
				}
			}
		} catch (ServiceException e) {
			setMsg(e.getMessage());
			markFail();
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			markFail();
			setMsg("保存失败！");
		}
		return "json";
	}

	public String delholiday() {
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				if (holiday != null) {
					holiday.setOrgid(global.getOrganization().getId());
					holidayService = new HolidayServiceImpl();
					if (holidayService.delete(holiday.getId(),
							holiday.getCreateby())) {
						setMsg("删除成功！");
						markSuccess();
					} else {
						setMsg("删除失败！");
						markFail();
					}
				}
			}
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			markFail();
			setMsg("删除失败！");
		}
		return "json";
	}
	
	public String importholidayprice(){
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				holidayService = new HolidayServiceImpl();
				setImportprice(holidayService.importholidayprice());
				markSuccess();
				
			}
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			markFail();
			setMsg("导出节日票价失败！");
		}
		return "json";
	}

	public List<Map<String, Object>> getHolidaylist() {
		return holidaylist;
	}

	public void setHolidaylist(List<Map<String, Object>> holidaylist) {
		this.holidaylist = holidaylist;
	}

	public Holiday getHoliday() {
		return holiday;
	}

	public void setHoliday(Holiday holiday) {
		this.holiday = holiday;
	}

	public List<Map<String, Object>> getImportprice() {
		return importprice;
	}

	public void setImportprice(List<Map<String, Object>> importprice) {
		this.importprice = importprice;
	}

}
