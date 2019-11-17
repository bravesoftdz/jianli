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
import cn.nova.bus.base.model.Insurers;
import cn.nova.bus.base.service.InsurerService;
import cn.nova.bus.base.service.impl.InsurerServiceImpl;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;
import cn.nova.utils.web.ServletPropertyFilterUtil;

/**
 * <b>类描述：</b> <b>类名称：</b><br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2011-8-11 下午02:38:39 <br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
public class InsurerAction extends BaseAction{

	private Insurers insurer;
	private Long id;
	private List<Insurers> insurerlist;
	private List<Map<String, Object>> insurermap;

	private InsurerService insurerService;

	public String query() {
		try {
			insurerService = new InsurerServiceImpl();
			setInsurermap(insurerService.query(ServletPropertyFilterUtil
					.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String save() {
		Global global = CurrentUtil.getGlobal();
		insurerService = new InsurerServiceImpl();
		try {
			if (insurer != null) {
				if (insurer.getId() > 0) {
					msg = "修改成功！";
					markSuccess();
					insurer.setUpdateby(global.getUserinfo().getId());
					insurer.setUpdatetime(new Timestamp(System
							.currentTimeMillis()));
				} else {
					msg = "添加成功！";
					markSuccess();
					insurer.setCreateby(global.getUserinfo().getId());
					insurer.setOrgid(global.getOrganization().getId());
					insurer.setCreatetime(new Timestamp(System
							.currentTimeMillis()));
					insurer.setUpdateby(global.getUserinfo().getId());
					insurer.setUpdatetime(new Timestamp(System
							.currentTimeMillis()));
				}
				insurer = insurerService.save(insurer, global.getIpAddress());
				setId(insurer.getId());
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
		Global global = CurrentUtil.getGlobal();
		try {
			insurerService = new InsurerServiceImpl();
			if (insurer != null) {
				boolean result = insurerService.delete(insurer.getId(), global.getIpAddress());
				if (result) {
					msg = "删除成功！";
					markSuccess();
				} else {
					msg = "删除失败！";
					markFail();
				}
			}
		} catch (ServiceException ex) {
			setMsg(ex.getMessage());
			markSuccess();
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			setMsg(e.getMessage());
			markSuccess();
		}
		return "json";
	}

	public Insurers getInsurer() {
		return insurer;
	}

	public void setInsurer(Insurers insurer) {
		this.insurer = insurer;
	}

	public List<Insurers> getInsurerlist() {
		return insurerlist;
	}

	public void setInsurerlist(List<Insurers> insurerlist) {
		this.insurerlist = insurerlist;
	}

	public List<Map<String, Object>> getInsurermap() {
		return insurermap;
	}

	public void setInsurermap(List<Map<String, Object>> insurermap) {
		this.insurermap = insurermap;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

}
