/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b><br/>
 * <b>文件名：</b>.java<br/>
 * <b>版本信息：</b>南凌客运信息管理系统 v4.0<br/>
 * <b>日期：</b> 2011-8-11 下午02:38:39 <br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 * 
 */
package cn.nova.bus.balance.action;

import cn.nova.bus.action.BaseAction;
import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import util.CurrentUtil;
import cn.nova.bus.balance.model.Scheduleminimum;
import cn.nova.bus.balance.service.ScheduleminimumService;
import cn.nova.bus.balance.service.impl.ScheduleminimumServiceImpl;
import cn.nova.bus.security.Global;
import cn.nova.utils.web.ServletPropertyFilterUtil;

/**
 * <b>类描述：</b> <b>类名称：</b><br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2011-8-11 下午02:38:39 <br/>
 * <b>关键修改：添加和修改时的唯一判断和提示</b><br/>
 * <b>修改时间：20130522</b><br/>
 * <b>修改人：hhz</b><br/>
 */
public class ScheduleminimumAction extends BaseAction{

	private Scheduleminimum minimum;
	private Long id;
	private List<Scheduleminimum> minimumlist;
	private List<Map<String, Object>> minimummap;

	private ScheduleminimumService minimumService;

	public String query() {
		try {
			minimumService = new ScheduleminimumServiceImpl();
			setMinimummap(minimumService.query(ServletPropertyFilterUtil
					.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String save() {
		minimumService = new ScheduleminimumServiceImpl();
		Global global = CurrentUtil.getGlobal();
		try {
			String ms;
			Scheduleminimum scheduleminimum = null;
			if (minimum != null) {
				if(minimum.getId()>0){
					minimum.setUpdateby(global.getUserinfo().getId());
					minimum.setUpdatetime(new Timestamp(System
							.currentTimeMillis()));
					ms="修改";
				}else{
					minimum.setCreateby(global.getUserinfo().getId());
					minimum.setCreatetime(new Timestamp(System
							.currentTimeMillis()));
					minimum.setUpdateby(global.getUserinfo().getId());
					minimum.setUpdatetime(new Timestamp(System
							.currentTimeMillis()));
					ms="添加";
				}
				scheduleminimum = minimumService.save(minimum);
				if(scheduleminimum!=null){
					ms = ms +"成功!";
					markSuccess();
					setId(scheduleminimum.getId());
				}else{
					ms = ms +"失败!";
					markFail();
				}		
				setMsg(ms);
			}
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			setMsg(e.getMessage());
			markFailure();
		}
		return "json";
	}

	public String delete() {
		if (minimum != null) {
			try {
				minimumService = new ScheduleminimumServiceImpl();
				boolean result = minimumService.delete(minimum.getId());
				if (result) {
					setMsg("删除成功！");
					markSuccess();
				} else {
					setMsg("删除失败！");
					markFail();
				}
			} catch (Exception ex) {
				play.Logger.error(ex.getMessage(), ex);
				setMsg("删除失败:" + ex.getMessage());
				markFail();
			}
		}
		return "json";
	}

	public Scheduleminimum getMinimum() {
		return minimum;
	}

	public void setMinimum(Scheduleminimum minimum) {
		this.minimum = minimum;
	}

	public List<Scheduleminimum> getMinimumlist() {
		return minimumlist;
	}

	public void setMinimumlist(List<Scheduleminimum> minimumlist) {
		this.minimumlist = minimumlist;
	}

	public List<Map<String, Object>> getMinimummap() {
		return minimummap;
	}

	public void setMinimummap(List<Map<String, Object>> minimummap) {
		this.minimummap = minimummap;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

}
