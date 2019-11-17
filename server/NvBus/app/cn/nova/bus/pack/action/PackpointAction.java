package cn.nova.bus.pack.action;

import java.util.List;
import java.util.Map;
import util.CurrentUtil;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.pack.model.Packpoint;
import cn.nova.bus.pack.service.PackpointService;
import cn.nova.bus.pack.service.impl.PackpointServiceImpl;
import cn.nova.bus.security.Global;

public class PackpointAction {
	
	private List<Map<String, Object>> packpointlist;
	private Packpoint packpoint;//添加、修改、删除
	private long packpointid;  //添加修改结果回传
	
	private PackpointService packpointService;
	
	private String msg;
	private long flag;
	
	
	public String listPackpoint(){
		packpointService = new PackpointServiceImpl();
		setPackpointlist(packpointService.query(null));
		return "json";
	}
	
	public String deletePackpoint() {
		Global global = CurrentUtil.getGlobal();
		
		try {
			packpointService = new PackpointServiceImpl();
			packpointService.delete(packpoint, global.getUserinfo().getId());
			setMsg("删除成功");
			setFlag(1);  //成功
			
		}catch(Exception e) {
			setMsg("删除失败，"+e.getMessage());
			setFlag(-1);  //失败
		}
		
		return "json";
	}
	
	public String savePackpoint() {
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				if (packpoint != null) {
					if (packpoint.getId() != 0) {
						//packpoint.setUpdateby(global.getUserinfo().getId());
						//packpoint.setUpdatetime(new Date());
						setMsg("修改成功！");
						setFlag(1);
					} else {
						//packpoint.setCreateby(global.getUserinfo().getId());
						//packpoint.setCreatetime(new Date());
						//packpoint.setUpdateby(global.getUserinfo().getId());
						//packpoint.setUpdatetime(new Date());
						setMsg("添加成功！");
						setFlag(1);
					}
					packpointService = new PackpointServiceImpl();
					packpoint = packpointService.savePackpoint(packpoint);
					setPackpointid(packpoint.getId());
				}
			}
//		} catch (ServiceException ex) {
//			setMsg(ex.getMessage());
//			setFlag(-1);
		} catch (Exception ex) {
			play.Logger.error(ex.getMessage(), ex);
			setMsg("操作失败！");
			setFlag(-1);
		}
		return "json";
	}
	
	
	
	public long getPackpointid() {
		return packpointid;
	}

	public void setPackpointid(long packpointid) {
		this.packpointid = packpointid;
	}

	public Packpoint getPackpoint() {
		return packpoint;
	}

	public void setPackpoint(Packpoint packpoint) {
		this.packpoint = packpoint;
	}

	public List<Map<String, Object>> getPackpointlist() {
		return packpointlist;
	}
	public void setPackpointlist(List<Map<String, Object>> packpointlist) {
		this.packpointlist = packpointlist;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public long getFlag() {
		return flag;
	}
	public void setFlag(long flag) {
		this.flag = flag;
	}
	
	

}
