package cn.nova.bus.archive.action;

import cn.nova.bus.action.BaseAction;
import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import util.CurrentUtil;
import cn.nova.bus.archive.model.Vipbooktime;
import cn.nova.bus.archive.service.VipbooktimeService;
import cn.nova.bus.archive.service.impl.VipbooktimeServiceImpl;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;
import cn.nova.utils.web.ServletPropertyFilterUtil;

/**
 * <b>类描述：VIP订票取消时间设置</b><br/>
 * <b>类名称：</b>VipbooktimeAction.java<br/>
 * <b>创建人：</b><a href="mailto:huanghaoze@nova.net.cn">hhz</a><br/>
 * <b>创建时间：</b><br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
public class VipbooktimeAction extends BaseAction{

	private VipbooktimeService vipbooktimeservice;
	
	private Vipbooktime vipbooktime;
	private Long id;
	private List<Map<String, Object>> booktimemap;
	
	public String query() {
		vipbooktimeservice = new VipbooktimeServiceImpl();
		setBooktimemap(vipbooktimeservice.query((ServletPropertyFilterUtil
					.buildFromHttpRequest())));
		return "json";
	}

	public String save() {
		vipbooktimeservice = new VipbooktimeServiceImpl();
		Global global = CurrentUtil.getGlobal();
		if (vipbooktime != null) {
			if (vipbooktime.getId() > 0) {
				msg = "修改成功！";
				vipbooktime.setUpdateby(global.getUserinfo().getId());
				vipbooktime.setUpdatetime(new Timestamp(System.currentTimeMillis()));
			} else {
				msg = "添加成功！";
				vipbooktime.setCreateby(global.getUserinfo().getId());
				vipbooktime.setUpdateby(global.getUserinfo().getId());
				vipbooktime.setUpdatetime(new Timestamp(System.currentTimeMillis()));
				vipbooktime.setCreatetime(new Timestamp(System.currentTimeMillis()));
			}
			try {
				vipbooktime = vipbooktimeservice.merge(vipbooktime);
				setId(vipbooktime.getId());
				markSuccess();
			} catch (ServiceException ex) {
				setMsg(ex.getMessage());
				markFail();
			}
		}
		return "json";
	}

	public String delete() {
		vipbooktimeservice = new VipbooktimeServiceImpl();
		if(vipbooktimeservice.delete(vipbooktime)){
			msg = "删除成功！";
			markSuccess();
		}else{
			msg = "删除失败！";
			markFail();
		}
		return "json";
	}

	public Vipbooktime getVipbooktime() {
		return vipbooktime;
	}

	public void setVipbooktime(Vipbooktime vipbooktime) {
		this.vipbooktime = vipbooktime;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public List<Map<String, Object>> getBooktimemap() {
		return booktimemap;
	}

	public void setBooktimemap(List<Map<String, Object>> booktimemap) {
		this.booktimemap = booktimemap;
	}

}
