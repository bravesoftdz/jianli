package cn.nova.bus.base.action;

import cn.nova.bus.action.BaseAction;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import util.CurrentUtil;
import cn.nova.bus.base.model.Vehiclepark;
import cn.nova.bus.base.service.VehicleparkService;
import cn.nova.bus.base.service.impl.VehicleparkServiceImpl;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;
import cn.nova.utils.web.ServletPropertyFilterUtil;

public class VehicleparkAction extends BaseAction{
	VehicleparkService Vehicleparkservice;
	//返回结果
	private List<Map<String,Object>>  parkmap;
	//条件
	private Vehiclepark park;
	private String org;
	private String name;
	private long delid;
	private String oldname;

	public HttpServletRequest httpServletRequest;
	
	public String saveVehiclepark() {
		Vehicleparkservice = new VehicleparkServiceImpl();
		Global global = CurrentUtil.getGlobal();
		if(park!=null){
			park.setIsactive(true);
			if(park.getId()!=0){
				park.setUpdateby(global.getUserinfo().getId());
				park.setUpdatetime(new Date());
				msg = "修改";
			}else{
				park.setCreateby(global.getUserinfo().getId());
				park.setCreatetime(new Date());
				park.setUpdateby(global.getUserinfo().getId());
				park.setUpdatetime(new Date());
				msg="添加";
			}
			try {
					if(Vehicleparkservice.saveVehiclepark(park,oldname)){ //如果要删除整条记录；将 t 改为 delID 便可删除所选记录
						msg =msg+ "成功！";
						markSuccess();
					}else {			
						msg = msg+"失败！";
						markFail();
					}
				} catch (ServiceException e) {
					msg = msg+"失败！"+e.getExceptionMessage();
					markFail();
				}			
		}
		
		return "json";
	}
	
	public String delVehiclepark(){
		Vehicleparkservice = new VehicleparkServiceImpl();
		Vehiclepark v = Vehicleparkservice.findbyid(delid);
		v.setIsactive(false);								//用户删除记录，便将是否激活修改为false，在进行更新
		try {
			if (Vehicleparkservice.delVehiclepark(v)) {		
				msg = "删除成功！";
				markSuccess();
			} else {
				msg = "删除失败！";
				markFail();
			}
		} catch (ServiceException e) {
			msg = "删除失败:"+e.getExceptionMessage();
			markFail();
		}
		return "json";
	}
	
	public String findVehiclepark(){
//		Map<Object,Object> where=new HashMap();
//		System.out.println("org is "+org);
//		where.put("org", org);
//		where.put("name", name);
//		parkmap= Vehicleparkservice.query(where);
		try {
			Vehicleparkservice = new VehicleparkServiceImpl();
			setParkmap(Vehicleparkservice.query(ServletPropertyFilterUtil.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public List<Map<String, Object>> getParkmap() {
		return parkmap;
	}

	public void setParkmap(List<Map<String, Object>> parkmap) {
		this.parkmap = parkmap;
	}

	public Vehiclepark getPark() {
		return park;
	}

	public void setPark(Vehiclepark park) {
		this.park = park;
	}

	public long getDelid() {
		return delid;
	}

	public void setDelid(long delid) {
		this.delid = delid;
	}

	public String getOrg() {
		return org;
	}

	public void setOrgid(String org) {
		this.org= org;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getOldname() {
		return oldname;
	}

	public void setOldname(String oldname) {
		this.oldname = oldname;
	}
	

}
