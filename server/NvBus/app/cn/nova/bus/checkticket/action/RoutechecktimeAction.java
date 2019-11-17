package cn.nova.bus.checkticket.action;

import cn.nova.bus.action.BaseAction;
import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import util.CurrentUtil;
import cn.nova.bus.checkticket.model.Routechecktime;
import cn.nova.bus.checkticket.service.RoutechecktimeService;
import cn.nova.bus.checkticket.service.impl.RoutechecktimeServiceImpl;
import cn.nova.bus.security.Global;
import cn.nova.utils.web.ServletPropertyFilterUtil;

/**
 * 检票时间管理
 * @author haobin
 *
 */
public class RoutechecktimeAction extends BaseAction{

	// 返回给 客户端 用于定位列表添加修改后，数据的 id 值
	private Long routechecktimeid;
	private Routechecktime routechecktime;
	private List<Map<String, Object>> routechecktimeList;

	private RoutechecktimeService routechecktimeService ;

	public String qryRoutechecktime() {
		routechecktimeService = new RoutechecktimeServiceImpl();
		try {
			setRoutechecktimeList(routechecktimeService
					.query(ServletPropertyFilterUtil
							.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	public String saveRoutechecktime(){
		Global global = (Global)CurrentUtil.getGlobal();
		routechecktimeService = new RoutechecktimeServiceImpl();
		if(routechecktime != null){
			try {
				if(routechecktime.getId() > 0){
					msg = "修改成功";
					markSuccess();
					Routechecktime rct = routechecktimeService.findById(routechecktime.getId());
					routechecktime.setCreateby(rct.getCreateby());
					routechecktime.setCreatetime(rct.getCreatetime());
					routechecktime.setUpdateby(global.getUserinfo().getId());
					routechecktime.setUpdatetime(new Timestamp(System.currentTimeMillis()));
				} else {
					msg = "添加成功";
					markSuccess();
					routechecktime.setCreateby(global.getUserinfo().getId());
					routechecktime.setCreatetime(new Timestamp(System.currentTimeMillis()));
					routechecktime.setUpdateby(global.getUserinfo().getId());
					routechecktime.setUpdatetime(new Timestamp(System.currentTimeMillis()));
					if(routechecktimeService.getRoutechecktimeId(routechecktime.getOrgid(), routechecktime.getRouteid()) > 0){
						msg = "此机构线路的相应记录已存在！";
						markFail();
						return "json";
					}
				}
				
				routechecktime = routechecktimeService.save(routechecktime);
				setRoutechecktimeid(routechecktime.getId());
			} catch (Exception e) {
				setMsg(e.getMessage());
				markFail();
				play.Logger.error(e.getMessage(), e);
			}
		}
		
		return "json";
	}
	
	public String delRoutechecktime(){
		routechecktimeService = new RoutechecktimeServiceImpl();
		if(routechecktime.getId() > 0){
			try {
				msg = "删除成功！";
				markSuccess();
				routechecktimeService.delete(routechecktime.getId());
			} catch (Exception e) {
				setMsg(e.getMessage());
				markFail();
				play.Logger.error(e.getMessage(), e);
			}
		}else{
			msg = "请选择你要删除的记录！";
			markFail();
		}
		
		return "json";
	}

	public Long getRoutechecktimeid() {
		return routechecktimeid;
	}

	public void setRoutechecktimeid(Long routechecktimeid) {
		this.routechecktimeid = routechecktimeid;
	}

	public Routechecktime getRoutechecktime() {
		return routechecktime;
	}

	public void setRoutechecktime(Routechecktime routechecktime) {
		this.routechecktime = routechecktime;
	}

	public List<Map<String, Object>> getRoutechecktimeList() {
		return routechecktimeList;
	}

	public void setRoutechecktimeList(List<Map<String, Object>> routechecktimeList) {
		this.routechecktimeList = routechecktimeList;
	}

}
