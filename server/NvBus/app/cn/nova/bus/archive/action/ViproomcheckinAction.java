package cn.nova.bus.archive.action;

import cn.nova.bus.action.BaseAction;
import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import util.CurrentUtil;
import cn.nova.bus.archive.model.Viproomcheckin;
import cn.nova.bus.archive.service.ViproomcheckinService;
import cn.nova.bus.archive.service.impl.ViproomcheckinServiceImpl;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;
import cn.nova.utils.web.ServletPropertyFilterUtil;

public class ViproomcheckinAction extends BaseAction{
	 ViproomcheckinService  viproomcheckinService;
	private long id;
	
	//返回结果
	private List<Map<String,Object>>  resultmap;
	private List<Map<String,Object>> viproomcheckinmap;
	
	private long vipid;
	private String vipcardno;
	private String ticketsellids;
	
	private  Viproomcheckin  viproomcheckin;

	/**
	 * 查找会员进入贵宾室历史记录
	 * @return
	 */
	public String findViproomcheckin(){	
		viproomcheckinService = new ViproomcheckinServiceImpl();
		setViproomcheckinmap(viproomcheckinService.queryViproomcheckin(
				ServletPropertyFilterUtil.buildFromHttpRequest()));			
		return "json";
	}
	
	/**
	 * 根据卡号查找会员 当天发车的购票明细
	 * @return
	 */
	public String findTicketdetail(){	
		viproomcheckinService = new ViproomcheckinServiceImpl();
		setResultmap(viproomcheckinService.queryTicketdetail(vipcardno));
		return "json";
	}
	
	/**
	 * 会员进入贵宾室登记
	 * @return
	 */
	public String saveViproomcheckin(){
		viproomcheckinService = new ViproomcheckinServiceImpl();
		viproomcheckin = new Viproomcheckin();
		Global global = CurrentUtil.getGlobal();
		viproomcheckin.setUpdatetime(new Timestamp(System.currentTimeMillis()));
		viproomcheckin.setUpdateby(global.getUserinfo().getId());
		viproomcheckin.setCreateby(global.getUserinfo().getId());
		viproomcheckin.setCreatetime(new Timestamp(System.currentTimeMillis()));
		viproomcheckin.setCheckinby(global.getUserinfo().getId());
		viproomcheckin.setCheckintime(new Timestamp(System.currentTimeMillis()));
		viproomcheckin.setVipid(vipid);
		try{
			viproomcheckin = viproomcheckinService.saveViproomcheckin(viproomcheckin, ticketsellids);
			if(viproomcheckin!=null){
				id = viproomcheckin.getId();
				msg="登记成功！";
				markSuccess();
			}else{
				msg="登记失败！";
				markFail();
			}
		}catch(ServiceException ex){
			this.setMsg("失败;" +ex.getExceptionMessage());
			markFail();
		}catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			markFail();
		}
		return "json";
	}

	public List<Map<String, Object>> getResultmap() {
		return resultmap;
	}

	public void setResultmap(List<Map<String, Object>> resultmap) {
		this.resultmap = resultmap;
	}

	public long getVipid() {
		return vipid;
	}

	public void setVipid(long vipid) {
		this.vipid = vipid;
	}

	public String getVipcardno() {
		return vipcardno;
	}

	public void setVipcardno(String vipcardno) {
		this.vipcardno = vipcardno;
	}

	public String getTicketsellids() {
		return ticketsellids;
	}

	public void setTicketsellids(String ticketsellids) {
		this.ticketsellids = ticketsellids;
	}

	public Viproomcheckin getViproomcheckin() {
		return viproomcheckin;
	}

	public void setViproomcheckin(Viproomcheckin viproomcheckin) {
		this.viproomcheckin = viproomcheckin;
	}

	public List<Map<String, Object>> getViproomcheckinmap() {
		return viproomcheckinmap;
	}

	public void setViproomcheckinmap(List<Map<String, Object>> viproomcheckinmap) {
		this.viproomcheckinmap = viproomcheckinmap;
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}
			
}
