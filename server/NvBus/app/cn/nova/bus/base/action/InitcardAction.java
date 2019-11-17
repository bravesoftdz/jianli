/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b><br/>
 * <b>文件名：</b>.java<br/>
 * <b>版本信息：</b>南凌客运信息管理系统 v4.0<br/>
 * <b>日期：</b> 2011-8-11 下午02:38:39 <br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 * 
 */
package cn.nova.bus.base.action;

import cn.nova.bus.action.BaseAction;
import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import util.CurrentUtil;
import cn.nova.bus.base.model.Initcard;
import cn.nova.bus.base.service.InitcardService;
import cn.nova.bus.base.service.impl.InitcardServiceImpl;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;
import cn.nova.utils.web.ServletPropertyFilterUtil;

/**
 * <b>类描述：</b>
 * <b>类名称：</b><br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2011-8-11 下午02:38:39	<br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
public class InitcardAction extends BaseAction{

	private Initcard initcard;
	private List<Initcard> initlist;
	private List<Map<String, Object>> initmap;
	private Long count;
	private Long id;
	
	private InitcardService initService;

	public String query() {
		try {
			initService = new InitcardServiceImpl();
			setInitmap(initService.query(ServletPropertyFilterUtil
					.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String save() {
		Global global = CurrentUtil.getGlobal();
		initService = new InitcardServiceImpl();
		try {
			if (initcard != null) {
				if (initcard.getId() > 0) {
					msg = "修改成功！";
					markSuccess();
					initcard.setUpdateby(global.getUserinfo().getId());
					initcard.setUpdatetime(new Timestamp(System.currentTimeMillis()));
				} else {
					msg = "添加成功！";
					markSuccess();
					initcard.setCreateby(global.getUserinfo().getId());
					initcard.setOrgid(global.getOrganization().getId());
					initcard.setUpdateby(global.getUserinfo().getId());
					initcard.setUpdatetime(new Timestamp(System.currentTimeMillis()));
					initcard.setCreatetime(new Timestamp(System
							.currentTimeMillis()));
				}
				initcard = initService.save(initcard, count, global.getIpAddress());
				setId(initcard.getId());
			}
		} catch (ServiceException ex) {
			setMsg(ex.getMessage());
			markFail();
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			setMsg(e.getMessage());
			markFail();
		}
		return "json";
	}

	public String delete() {
		if (initcard != null) {
			try {
				initService = new InitcardServiceImpl();
				boolean result = initService.delete(initcard.getId());
				if (result) {
					msg = "删除成功！";
					markSuccess();
				} else {
					msg = "删除失败！";
					markFail();
				}
			} catch (Exception ex) {
				play.Logger.error(ex.getMessage(), ex);
				msg = "删除失败:";
				markFail();
			}

		}
		return "json";
	}

	public Initcard getInitcard() {
		return initcard;
	}

	public void setInitcard(Initcard initcard) {
		this.initcard = initcard;
	}

	public List<Initcard> getInitlist() {
		return initlist;
	}

	public void setInitlist(List<Initcard> initlist) {
		this.initlist = initlist;
	}

	public List<Map<String, Object>> getInitmap() {
		return initmap;
	}

	public void setInitmap(List<Map<String, Object>> initmap) {
		this.initmap = initmap;
	}

	public Long getCount() {
		return count;
	}

	public void setCount(Long count) {
		this.count = count;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

}
