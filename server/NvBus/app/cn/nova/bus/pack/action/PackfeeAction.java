package cn.nova.bus.pack.action;

import cn.nova.bus.action.BaseAction;
import java.util.Date;
import java.util.List;
import java.util.Map;

import util.CurrentUtil;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.pack.model.Packfee;
import cn.nova.bus.pack.model.Packfeetype;
import cn.nova.bus.pack.service.PackfeeService;
import cn.nova.bus.pack.service.impl.PackfeeServiceImpl;
import cn.nova.bus.security.Global;
import cn.nova.utils.web.ServletPropertyFilterUtil;

public class PackfeeAction extends BaseAction{
	private List<Map<String, Object>> packfeelist;
	private Packfee packfee;//添加、修改、删除
	private long packfeeid;  //添加修改结果回传
	
	private PackfeeService packfeeService;
	
	public String listPackfee(){
		packfeeService = new PackfeeServiceImpl();
		setPackfeelist(packfeeService.query(ServletPropertyFilterUtil.buildFromHttpRequest()));
		return "json";
	}
	
	public String list(){
		packfeeService = new PackfeeServiceImpl();
		setPackfeelist(packfeeService.query());
		return "json";
	}
	
	public String savePackfee(){
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				if (packfee != null) {
					if (packfee.getId() != 0) {
						packfee.setUpdateby(global.getUserinfo().getId());
						packfee.setUpdatetime(new Date());
						setMsg("修改成功！");
						markSuccess();
					} else {
						packfee.setCreateby(global.getUserinfo().getId());
						packfee.setCreatetime(new Date());
						packfee.setUpdateby(global.getUserinfo().getId());
						packfee.setUpdatetime(new Date());
						setMsg("添加成功！");
						markSuccess();
					}
					packfeeService = new PackfeeServiceImpl();
					packfee = packfeeService.savePackfee(packfee);
					setPackfeeid(packfee.getId());
				}
			}
		} catch (ServiceException ex) {
			setMsg(ex.getMessage());
			markFail();
		} catch (Exception ex) {
			play.Logger.error(ex.getMessage(), ex);
			setMsg("操作失败！");
			markFail();
		}
		return "json";
	}
	
	public String deletePackfee(){
		Global global = CurrentUtil.getGlobal();
		try {
			packfeeService = new PackfeeServiceImpl();
			packfeeService.deletePackfee(packfee, global.getUserinfo().getId());
			setMsg("删除成功");
			markSuccess();
		} catch (ServiceException e) {
			setMsg("删除失败，"+e.getExceptionMessage());
			markFail();
		}
		return "json";
	}

	public List<Map<String, Object>> getPackfeelist() {
		return packfeelist;
	}

	public void setPackfeelist(List<Map<String, Object>> packfeelist) {
		this.packfeelist = packfeelist;
	}

	public Packfee getPackfee() {
		return packfee;
	}

	public void setPackfee(Packfee packfee) {
		this.packfee = packfee;
	}

	public long getPackfeeid() {
		return packfeeid;
	}

	public void setPackfeeid(long packfeeid) {
		this.packfeeid = packfeeid;
	}

}
