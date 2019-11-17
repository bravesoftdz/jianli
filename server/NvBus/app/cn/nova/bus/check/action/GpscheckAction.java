package cn.nova.bus.check.action;

import cn.nova.bus.action.BaseAction;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.check.model.Gpscheck;
import cn.nova.bus.check.service.GpscheckService;
import cn.nova.bus.check.service.impl.GpscheckServiceImpl;
import cn.nova.utils.web.ServletPropertyFilterUtil;

public class GpscheckAction extends BaseAction{
	private GpscheckService GPScheckService;

	private Gpscheck gpscheck;
	
	private boolean issummary;
	private String notenum ;
	
	private long id;
	
	private List<Map<String, Object>> resultmap;
	
	public String queryGpscheck() {
		GPScheckService = new GpscheckServiceImpl();
		try {
			setResultmap(GPScheckService.query(issummary,ServletPropertyFilterUtil
					.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String saveGpscheck() {
		GPScheckService = new GpscheckServiceImpl();
		try {
			gpscheck.setCreatetime(new Date());
			gpscheck.setUpdatetime(new Date());
			notenum = new Timestamp(System.currentTimeMillis())
			.toString().replace("-", "").substring(0, 8)
			+ GPScheckService.qryCheckno (gpscheck.getOperater());
			gpscheck.setCheckno(notenum);  //年月日3位序号
			Gpscheck gps = GPScheckService.save(gpscheck);
			if (gps!=null){
				msg = "保存成功";
				markSuccess();
				id = gps.getId();
			}else{
				msg = "保存失败";
				markFail();
			}
		} catch (Exception e) {
			msg = "保存操作失败";
			markFail();
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	public String delGpscheck() {
		GPScheckService = new GpscheckServiceImpl();
		try {
			boolean result = GPScheckService.delete(id);
			if (result){
				msg = "删除成功";
				markSuccess();
			}else{
				msg = "删除失败";
				markFail();
			}
		} catch (Exception e) {
			msg = "删除操作失败";
			markFail();
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	public Gpscheck getGpscheck() {
		return gpscheck;
	}

	public void setGpscheck(Gpscheck gpscheck) {
		this.gpscheck = gpscheck;
	}

	public boolean isIssummary() {
		return issummary;
	}

	public void setIssummary(boolean issummary) {
		this.issummary = issummary;
	}

	public List<Map<String, Object>> getResultmap() {
		return resultmap;
	}

	public void setResultmap(List<Map<String, Object>> resultmap) {
		this.resultmap = resultmap;
	}
	
	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getNotenum() {
		return notenum;
	}

	public void setNotenum(String notenum) {
		this.notenum = notenum;
	}

}
