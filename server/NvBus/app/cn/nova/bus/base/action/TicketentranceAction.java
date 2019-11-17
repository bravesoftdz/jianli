package cn.nova.bus.base.action;

import cn.nova.bus.action.BaseAction;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import util.CurrentUtil;
import cn.nova.bus.base.model.Ticketentrance;
import cn.nova.bus.base.service.TicketentranceService;
import cn.nova.bus.base.service.impl.TicketentranceServiceImpl;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;
import cn.nova.utils.web.ServletPropertyFilterUtil;
/**
 * 检票口管理
 * @author huanghaoze
 *
 */
public class TicketentranceAction extends BaseAction{

	TicketentranceService ticketentranceservice;
	//返回结果
	private List<Map<String,Object>>  entrancemap;
	//条件
	private Ticketentrance ticketentrance;
	
	private Long orgid;
	private String name;
	private String isactive;
	private long id;
	private long delID;
	public HttpServletRequest httpServletRequest;
	
	public String saveTicketentrance(){
		Ticketentrance t=null;
		ticketentranceservice = new TicketentranceServiceImpl();
		Global global = CurrentUtil.getGlobal();
		if(ticketentrance!=null){
			String show = "";
			ticketentrance.setIsactive(true);
			if(ticketentrance.getId()!=0){
				ticketentrance.setUpdateby(global.getUserinfo().getId());
				ticketentrance.setUpdatetime(new Date());
				show = show +"修改";
			}else{
				ticketentrance.setCreateby(global.getUserinfo().getId());
				ticketentrance.setCreatetime(new Date());
				ticketentrance.setUpdateby(global.getUserinfo().getId());
				ticketentrance.setUpdatetime(new Date());
				show = show+"添加";
			}
			try {
				t=ticketentranceservice.saveTicketentrance(ticketentrance);
				if(t!=null){
					id = t.getId();
					msg = show+"成功！";
					markSuccess();
				}else {			
					msg =  show +"失败！";
					markFail();
				}
			} catch (ServiceException e) {
				msg =  show +"失败:"+e.getExceptionMessage();
				markFail();
				play.Logger.error(e.getMessage(), e);
			}
		}
		return "json";
	}
	
	public String delticketentrance(){
		ticketentranceservice = new TicketentranceServiceImpl();
		Ticketentrance t = ticketentranceservice.findbyid(delID);
		t.setIsactive(false);
		try {
			if(ticketentranceservice.delTicketentrance(t)){ 
				msg = "删除成功！";
				markSuccess();
			}else {			
				msg = "删除失败！";
				markFail();
			}
		} catch (ServiceException e) {
			msg = "删除失败:"+e.getExceptionMessage();
			markFail();
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	public String findticketentrance(){
		ticketentranceservice = new TicketentranceServiceImpl();
		entrancemap = ticketentranceservice.query(ServletPropertyFilterUtil.buildFromHttpRequest());
		return "json";
	}
	
	public Ticketentrance getTicketentrance() {
		return ticketentrance;
	}

	public void setTicketentrance(Ticketentrance ticketentrance) {
		this.ticketentrance = ticketentrance;
	}

	public List<Map<String, Object>> getEntrancemap() {
		return entrancemap;
	}
	public void setEntrancemap(List<Map<String, Object>> entrancemap) {
		this.entrancemap = entrancemap;
	}
	public Long getOrgid() {
		return orgid;
	}
	public void setOrgid(Long orgid) {
		this.orgid = orgid;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getIsactive() {
		return isactive;
	}
	public void setIsactive(String isactive) {
		this.isactive = isactive;
	}
	public Long getDelID() {
		return delID;
	}
	public void setDelID(Long delID) {
		this.delID = delID;
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}
	
}
