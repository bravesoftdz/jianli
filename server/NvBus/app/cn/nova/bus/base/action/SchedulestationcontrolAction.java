package cn.nova.bus.base.action;

import cn.nova.bus.action.BaseAction;
import java.util.Date;
import java.util.List;
import java.util.Map;

import util.CurrentUtil;
import cn.nova.bus.base.model.Schedulestationcontrol;
import cn.nova.bus.base.service.SchedulestationcontrolService;
import cn.nova.bus.base.service.impl.SchedulestationcontrolServiceImpl;
import cn.nova.bus.security.Global;
import cn.nova.utils.web.ServletPropertyFilterUtil;

/**
 * <b>类描述：班次站点售票控制</b><br/>
 * <b>类名称：</b>SchedulestationcontrolAction.java<br/>
 * <b>创建人：</b><a href="mailto:huanghaoze@nova.net.cn">hhz</a><br/>
 * <b>创建时间：</b><br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
public class SchedulestationcontrolAction extends BaseAction{

	private SchedulestationcontrolService schedulestationcontrolservice;

	private Schedulestationcontrol schedulestationcontrol;
	// 返回结果
	private List<Schedulestationcontrol> stationlist;
	private long routeid;	
	private long orgid;
	private long stationid;
	private List<Map<String, Object>> resultmap;
	boolean isupdate ;	

	/**
	 * 
	 * @return
	 */
	public String edtSchedulestationcontrol() {
		Global global = CurrentUtil.getGlobal();
		schedulestationcontrolservice = new SchedulestationcontrolServiceImpl();
		try {			
			if(isupdate){
				schedulestationcontrol.setUpdateby(global.getUserinfo().getId());
				schedulestationcontrol.setUpdatetime(new Date());
			}else{
				schedulestationcontrol.setCreatetime(new Date());
				schedulestationcontrol.setUpdateby(global.getUserinfo().getId());
				schedulestationcontrol.setUpdatetime(new Date());
			}
			boolean result = schedulestationcontrolservice.edtSchedulestationcontrol(schedulestationcontrol,stationlist);
			
			if(result){
				setFlag( new Long(1) );
				if(isupdate){
					msg="修改成功!";
				}else{
					msg = "添加成功！";
				}					
				markSuccess();
			}else{
				setFlag( new Long(0) );
				if(isupdate){
					msg = "修改失败";
				}else{
					msg = "添加失败";
				}					
				markFail();
			}			
		}
		catch (Exception ex) {
			play.Logger.error(ex.getMessage(), ex);
			setMsg("保存失败！");
			markFail();
		}
		return "json";
	}
	
	public String findSchedulestationcontrolList() {
		schedulestationcontrolservice = new SchedulestationcontrolServiceImpl();
		setResultmap(schedulestationcontrolservice.findSchedulestationcontrolList(
				ServletPropertyFilterUtil.buildFromHttpRequest()));
		return "json";
	}
	
	/**
	 * 根据班次机构和线路 查询线路站点，（如果已经添加了控制，则把控制的信息查询出）
	 * @return
	 */
	public String controlstationList() {
		schedulestationcontrolservice = new SchedulestationcontrolServiceImpl();
		setResultmap(schedulestationcontrolservice.findControlroutestation(
				ServletPropertyFilterUtil.buildFromHttpRequest()));
		setFlag( new Long(0) );
		return "json";
	}
	
	/**
	 * 删除 班次站点售票控制 ，如果stationid =0,则删除整条线路的记录，否则删除指定站点。
	 * @return
	 */
	public String delcontrol(){
		schedulestationcontrolservice = new SchedulestationcontrolServiceImpl();
		if (schedulestationcontrolservice.delSchedulestationcontrol(orgid, routeid, stationid)){			
			setMsg("删除成功！");
			markSuccess();
		}else{
			setMsg("删除失败！");
			markFail();
		}		
		return "json";
	}	
	
	public Schedulestationcontrol getSchedulestationcontrol() {
		return schedulestationcontrol;
	}
	public void setSchedulestationcontrol(
			Schedulestationcontrol schedulestationcontrol) {
		this.schedulestationcontrol = schedulestationcontrol;
	}
	public List<Schedulestationcontrol> getStationlist() {
		return stationlist;
	}
	public void setStationlist(List<Schedulestationcontrol> stationlist) {
		this.stationlist = stationlist;
	}
	public long getRouteid() {
		return routeid;
	}
	public void setRouteid(long routeid) {
		this.routeid = routeid;
	}
	public long getOrgid() {
		return orgid;
	}
	public void setOrgid(long orgid) {
		this.orgid = orgid;
	}

	public List<Map<String, Object>> getResultmap() {
		return resultmap;
	}

	public void setResultmap(
			List<Map<String, Object>> resultmap) {
		this.resultmap = resultmap;
	}

	public boolean isIsupdate() {
		return isupdate;
	}
	
	public void setIsupdate(boolean isupdate) {
		this.isupdate = isupdate;
	}

	public long getStationid() {
		return stationid;
	}

	public void setStationid(long stationid) {
		this.stationid = stationid;
	}
	
}
