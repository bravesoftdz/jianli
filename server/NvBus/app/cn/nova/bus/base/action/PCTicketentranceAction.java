package cn.nova.bus.base.action;

import cn.nova.bus.action.BaseAction;
import java.util.Date;
import java.util.List;
import java.util.Map;

import util.CurrentUtil;
import cn.nova.bus.base.model.Pcticketentrance;
import cn.nova.bus.base.service.PCTicketentranceService;
import cn.nova.bus.base.service.impl.PCTicketentranceServiceImpl;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;
import cn.nova.utils.web.ServletPropertyFilterUtil;

public class PCTicketentranceAction extends BaseAction{
	PCTicketentranceService pcticketentranceService;
	
	Pcticketentrance pcticketentrance;
	//返回结果
	private List<Map<String,Object>>  pcentrancemap;
	private List<Map<String,Object>>  entrancenames;
	private List<Map<String,Object>>  ticketentrancename;
	
	//参数
	private Long orgid;
	private String ip;
	private String ticketentranceids;
	private boolean isupdate;
	
	private long createby;
	private Date createtime;

	public String savePCTicketentrance(){
		String show ="";
		pcticketentranceService = new PCTicketentranceServiceImpl();
		Global global = CurrentUtil.getGlobal();
		pcticketentrance.setUpdateby(global.getUserinfo().getId());
		pcticketentrance.setCreateby(global.getUserinfo().getId());
		boolean b = false;
		try{
			if(isupdate){
				b = pcticketentranceService.updatePcticketentrance(pcticketentrance, ticketentranceids);
				show=show+"修改";
			}else{
				b = pcticketentranceService.savePcticketentrance(pcticketentrance, ticketentranceids);
				show=show+"添加";
			}
			if(b){
				setMsg(show+"成功");
				markSuccess();
			}else{
				setMsg(show+"失败");
				markFailure();
			}
		}catch(ServiceException ex){
			setMsg(show+"失败;"+ex.getExceptionMessage());
			markFail();
		}
		return "json";
	}
	
	public String findPCticketentrance(){
		pcticketentranceService = new PCTicketentranceServiceImpl();
		pcentrancemap = pcticketentranceService.findPCTicketentrance(ServletPropertyFilterUtil.buildFromHttpRequest());
		return "json";
	}

	public String findPCEntranceName(){
		pcticketentranceService = new PCTicketentranceServiceImpl();
		entrancenames = pcticketentranceService.findPCEntranceName(ServletPropertyFilterUtil.buildFromHttpRequest());
		return "json";
	}
	
	public String findTicketentranceName(){
		pcticketentranceService = new PCTicketentranceServiceImpl();
		ticketentrancename = pcticketentranceService.findTicketentrancename(ServletPropertyFilterUtil.buildFromHttpRequest());
		return "json";
	}
	
	public String delPCentrance(){
		pcticketentranceService = new PCTicketentranceServiceImpl();
			boolean result = pcticketentranceService.delpcticketentrance(orgid,ip);
			if (result) {
				msg = "删除成功！";
				markSuccess();
			} else {
				msg = "删除失败！";
				markFail();
			}
		return "json";
	}
	
	public Pcticketentrance getPcticketentrance() {
		return pcticketentrance;
	}

	public void setPcticketentrance(Pcticketentrance pcticketentrance) {
		this.pcticketentrance = pcticketentrance;
	}

	public List<Map<String, Object>> getPcentrancemap() {
		return pcentrancemap;
	}

	public void setPcentrancemap(List<Map<String, Object>> pcentrancemap) {
		this.pcentrancemap = pcentrancemap;
	}

	public Long getOrgid() {
		return orgid;
	}

	public void setOrgid(Long orgid) {
		this.orgid = orgid;
	}

	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

	public String getTicketentranceids() {
		return ticketentranceids;
	}

	public void setTicketentranceids(String ticketentranceids) {
		this.ticketentranceids = ticketentranceids;
	}

	public List<Map<String, Object>> getEntrancenames() {
		return entrancenames;
	}

	public void setEntrancenames(List<Map<String, Object>> entrancenames) {
		this.entrancenames = entrancenames;
	}

	public long getCreateby() {
		return createby;
	}

	public void setCreateby(long createby) {
		this.createby = createby;
	}

	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	public List<Map<String, Object>> getTicketentrancename() {
		return ticketentrancename;
	}

	public void setTicketentrancename(List<Map<String, Object>> ticketentrancename) {
		this.ticketentrancename = ticketentrancename;
	}

	public boolean isIsupdate() {
		return isupdate;
	}

	public void setIsupdate(boolean isupdate) {
		this.isupdate = isupdate;
	}
	
}
