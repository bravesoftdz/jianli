/**
 * <b>项目名：</b>NvBusWeb<br/>
 * <b>包名：</b>cn.nova.bus.check.action<br/>
 * <b>文件名：</b>VehicledistanceAction.java<br/>
 * <b>版本信息：</b>v4.0<br/>
 * <b>日期：</b> 2013-5  <br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.check.action;

import cn.nova.bus.action.BaseAction;

import java.util.Date;
import java.util.List;
import java.util.Map;

import play.data.binding.As;
import util.CurrentUtil;
import cn.nova.bus.check.model.Vehicledistanceactive;
import cn.nova.bus.check.service.VehicledistanceactiveService;
import cn.nova.bus.check.service.impl.VehicledistanceactiveServiceImpl;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;
import cn.nova.utils.web.ServletPropertyFilterUtil;

/**
 * <b>类描述：车辆行驶里程管理</b><br/>
 * <b>类名称：</b>VehicledistanceAction.java<br/>
 * <b>创建人：</b><a href="mailto:huanghaoze@nova.net.cn">hhz</a><br/>
 * <b>创建时间：</b>2013-5-3  <br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
public class VehicledistanceAction extends BaseAction{
	private VehicledistanceactiveService vservice;
	
	private List<Map<String, Object>> lastactivemap;
	private List<Map<String, Object>> historyactivemap;
	private Vehicledistanceactive vehicledistance;
	private Date startdate;
	private Date enddate;
	private long vehicleid;
	private long userid;
	private boolean iscomparedate;
	
	/**
	 * 查询最后激活的记录，用于查看到目前时刻 已发班里程
	 * @return
	 */
	public String queryLastvehicledistance(){
		vservice = new VehicledistanceactiveServiceImpl();
		Global global = CurrentUtil.getGlobal();
		lastactivemap = vservice.queryLastActive(startdate,enddate,vehicleid,userid,global.getOrganization().getId());		
		return "json";
	}
	
	/**
	 * 查询历史激活记录。
	 * @return
	 */
	public String queryHistoryvehicledistance(){
		vservice = new VehicledistanceactiveServiceImpl();
		setHistoryactivemap(vservice.queryHistoryActive(ServletPropertyFilterUtil
					.buildFromHttpRequest()));
		return "json";
	}
	
	/**
	 * 判断车辆行驶里程和有效期，是否达到期限
	 * @return
	 */
	public String qryVheicledistiance(){	
		vservice = new VehicledistanceactiveServiceImpl();
		Global global = CurrentUtil.getGlobal();
		try {
			String temp = vservice.qryVheicledistiance(vehicleid,global.getOrganization().getId(),iscomparedate);
			markSuccess();
			setMsg(temp);
		} catch (ServiceException se) {
			markFail();
			setMsg(se.getMessage());
		} catch (Exception e) {
			markFail();
			setMsg("判断里程失败！");
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	/**
	 * 激活车辆操作：向车辆行驶里程激活记录表添加一条记录，
	 * 	已发班里程从激活的时刻开发重新计算，
	 * @return
	 */
	public String savevehicleactive(){
		vservice = new VehicledistanceactiveServiceImpl();
		Global global = CurrentUtil.getGlobal();
		Date datetime = new Date(); 
		vehicledistance.setCreateby(global.getUserinfo().getId());
		vehicledistance.setCreatetime(datetime);
		Vehicledistanceactive vda= vservice.saveVehicledistanceactive(vehicledistance);
		if(vda!=null){
			vehicleid= vda.getId();
			msg ="激活成功！";
			markSuccess();
		}else{
			msg ="激活失败！";
			markFail();
		}		
		return "json";
	}
	
	public List<Map<String, Object>> getLastactivemap() {
		return lastactivemap;
	}

	public void setLastactivemap(List<Map<String, Object>> lastactivemap) {
		this.lastactivemap = lastactivemap;
	}

	public List<Map<String, Object>> getHistoryactivemap() {
		return historyactivemap;

	}
	public void setHistoryactivemap(List<Map<String, Object>> historyactivemap) {
		this.historyactivemap = historyactivemap;
	}

	public long getVehicleid() {
		return vehicleid;
	}

	public void setVehicleid(long vehicleid) {
		this.vehicleid = vehicleid;
	}

	public Vehicledistanceactive getVehicledistance() {
		return vehicledistance;
	}

	public void setVehicledistance(Vehicledistanceactive vehicledistance) {
		this.vehicledistance = vehicledistance;
	}

	public Date getStartdate() {
		return startdate;
	}

	public void setStartdate(Date startdate) {
		this.startdate = startdate;
	}

	public Date getEnddate() {
		return enddate;
	}

	@As("yyyy-MM-dd HH:mm:ss")
	public void setEnddate(Date enddate) {
		this.enddate = enddate;
	}

	public long getUserid() {
		return userid;
	}

	public void setUserid(long userid) {
		this.userid = userid;
	}

	public boolean isIscomparedate() {
		return iscomparedate;
	}

	public void setIscomparedate(boolean iscomparedate) {
		this.iscomparedate = iscomparedate;
	}
	
}
