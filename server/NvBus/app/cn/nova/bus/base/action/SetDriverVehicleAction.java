package cn.nova.bus.base.action;

import java.util.List;
import java.util.Map;

import util.CurrentUtil;
import cn.nova.bus.action.BaseAction;
import cn.nova.bus.base.model.SetDriverVehicle;
import cn.nova.bus.base.service.SetDriverVehicleService;
import cn.nova.bus.base.service.impl.SetDriverVehicleServiceImpl;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;
import cn.nova.utils.web.ServletPropertyFilterUtil;

public class SetDriverVehicleAction extends BaseAction{
	//参数
	SetDriverVehicleService setDriverVehicleService;
	//返回结果
	private List<Map<String,Object>> setDriverVehileList;
	
	private long setDriverVehicleid;
	private SetDriverVehicle setDriverVehicle;
	//机构
	private String orgids;
	private String orgid;
	private String driverid;
	private List<Map<String,Object>> list;
	
	
	/*
	 * 查询
	 */
	public String qrySetDriverVehicle(){
		setDriverVehicleService = new SetDriverVehicleServiceImpl();
		try{
			setSetDriverVehileList(setDriverVehicleService
					.querySetDriverVehicle(ServletPropertyFilterUtil.buildFromHttpRequest()));			
		} catch (Exception e) {
				play.Logger.error(e.getMessage(), e);
		}		
		return "json";
	}

	/*
	 * 删除
	 */
	public String delSetDriverVehicle(){
		setDriverVehicleService = new SetDriverVehicleServiceImpl();
		if( setDriverVehicleService.delSetDriverVehicle(setDriverVehicleid) ){
			setMsg("删除驾驶员的驾驶车辆成功");
			markSuccess();
		}else{
			setMsg("删除驾驶员的驾驶车辆失败");
			markFail();
		}
		return "json";
	}
	
	/*
	 * 添加
	 */
	public String saveSetDriverVehicle() throws Exception{
		Global global = CurrentUtil.getGlobal();
		setDriverVehicleService = new SetDriverVehicleServiceImpl();
		String show = "添加";
		try {
			SetDriverVehicle s = setDriverVehicleService.saveSetDriverVehicle(setDriverVehicle);
			if(s != null){
				setMsg(show+"成功");
				markSuccess();
			}
			else{
				setMsg("出现空值，请检查！");
				markError();
			}
		}catch(ServiceException e){
			setMsg(show+"失败:"+e.getExceptionMessage());
			markFail();
		}catch(Exception ex){
			setMsg(show+"失败:"+ex.getMessage());
			markFail();
		}
		return "json";
	}
	
	/*
	 * 修改
	 */
	public String modifySetDriverVehicle() throws Exception{
		Global global = CurrentUtil.getGlobal();
		setDriverVehicleService = new SetDriverVehicleServiceImpl();
		String show = "修改";
		try {
			String str = setDriverVehicleService.modifySetDriverVehicle(setDriverVehicle);
			if(str == null){
				setMsg(show+"成功");
				markSuccess();
			}
			else{
				setMsg(str);
				markError();
			}
		}catch(ServiceException e){
			setMsg(show+"失败:"+e.getExceptionMessage());
			markFail();
		}catch(Exception ex){
			setMsg(show+"失败:"+ex.getMessage());
			markFail();
		}
		
		return "json";
	}

	/*
	 * 查询本地机构
	 */
	public String qryCurOrg() {
		try {
			setDriverVehicleService = new SetDriverVehicleServiceImpl();
			setList(setDriverVehicleService.queryCurOrg(orgids));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	/*
	 * 由驾驶员联动显示未关联的车牌
	 */
	public String findvehicleno(){
		setDriverVehicleService = new SetDriverVehicleServiceImpl();
		try{
			setList(setDriverVehicleService.queryvehicleno(orgid,driverid));
		}catch(Exception e)
		{
			markFail();
	 		setMsg("操作失败");
		}
		return "json";
	}
	
	//set and get
	public SetDriverVehicleService getSetDriverVehicleService() {
		return setDriverVehicleService;
	}

	public void setSetDriverVehicleService(
			SetDriverVehicleService setDriverVehicleService) {
		this.setDriverVehicleService = setDriverVehicleService;
	}

	public List<Map<String, Object>> getSetDriverVehileList() {
		return setDriverVehileList;
	}

	public void setSetDriverVehileList(List<Map<String, Object>> setDriverVehileList) {
		this.setDriverVehileList = setDriverVehileList;
	}

	public long getSetDriverVehicleid() {
		return setDriverVehicleid;
	}

	public void setSetDriverVehicleid(long setDriverVehicleid) {
		this.setDriverVehicleid = setDriverVehicleid;
	}

	public SetDriverVehicle getSetDriverVehicle() {
		return setDriverVehicle;
	}

	public void setSetDriverVehicle(SetDriverVehicle setDriverVehicle) {
		this.setDriverVehicle = setDriverVehicle;
	}

	public String getOrgids() {
		return orgids;
	}

	public void setOrgids(String orgids) {
		this.orgids = orgids;
	}

	public List<Map<String, Object>> getList() {
		return list;
	}

	public void setList(List<Map<String, Object>> list) {
		this.list = list;
	}

	public String getOrgid() {
		return orgid;
	}

	public void setOrgid(String orgid) {
		this.orgid = orgid;
	}

	public String getDriverid() {
		return driverid;
	}

	public void setDriverid(String driverid) {
		this.driverid = driverid;
	}
}
