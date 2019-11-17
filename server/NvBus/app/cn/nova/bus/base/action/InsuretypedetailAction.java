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
import cn.nova.bus.base.model.Insuretypedetail;
import cn.nova.bus.base.service.InsuretypedetailService;
import cn.nova.bus.base.service.impl.InsuretypedetailServiceImpl;
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
public class InsuretypedetailAction extends BaseAction{

	private Insuretypedetail insuretypedetail;
	private Long id;
	private List<Insuretypedetail> detaillist;
	private List<Map<String, Object>> detailmap;

	private InsuretypedetailService detailService;

	public String query() {
		try {
			detailService = new InsuretypedetailServiceImpl();
			setDetailmap(detailService.query(ServletPropertyFilterUtil
					.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String save() {
		detailService = new InsuretypedetailServiceImpl();
		Global global = CurrentUtil.getGlobal();
		try {
			if (insuretypedetail != null) {
				if (insuretypedetail.getId() > 0) {
					msg = "修改成功！";
					markSuccess();
					insuretypedetail.getInsuretype().setId(
							insuretypedetail.getInsuretype().getId());
					insuretypedetail.setUpdateby(global.getUserinfo().getId());
					insuretypedetail.setUpdatetime(new Timestamp(System
							.currentTimeMillis()));
				} else {
					msg = "添加成功！";
					markSuccess();
					insuretypedetail.setCreateby(global.getUserinfo().getId());
					insuretypedetail.setCreatetime(new Timestamp(System
							.currentTimeMillis()));
					insuretypedetail.setUpdateby(global.getUserinfo().getId());
					insuretypedetail.setUpdatetime(new Timestamp(System
							.currentTimeMillis()));
				}
				detailService.save(insuretypedetail);
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

	public String delete() {
		if (insuretypedetail != null) {
			try {
				detailService = new InsuretypedetailServiceImpl();
				boolean result = detailService.delete(insuretypedetail.getId());
				if (result) {
					msg = "删除成功！";
					markSuccess();
				} else {
					msg = "删除失败！";
					markFail();
				}
			} catch (ServiceException e){
				play.Logger.error(e.getMessage(), e);
				setMsg(e.getMessage());
				markSuccess();
			} catch (Exception ex) {
				play.Logger.error(ex.getMessage(), ex);
				setMsg(ex.getMessage());
				markSuccess();
			}
		}
		return "json";
	}

	public Insuretypedetail getInsuretypedetail() {
		return insuretypedetail;
	}

	public void setInsuretypedetail(Insuretypedetail insuretypedetail) {
		this.insuretypedetail = insuretypedetail;
	}

	public List<Insuretypedetail> getDetaillist() {
		return detaillist;
	}

	public void setDetaillist(List<Insuretypedetail> detaillist) {
		this.detaillist = detaillist;
	}

	public List<Map<String, Object>> getDetailmap() {
		return detailmap;
	}

	public void setDetailmap(List<Map<String, Object>> detailmap) {
		this.detailmap = detailmap;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

}
