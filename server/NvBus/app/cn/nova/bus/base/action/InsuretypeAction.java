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

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import util.CurrentUtil;
import cn.nova.bus.base.model.Insuretype;
import cn.nova.bus.base.model.Insuretypedetail;
import cn.nova.bus.base.service.InsuretypeService;
import cn.nova.bus.base.service.impl.InsuretypeServiceImpl;
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
public class InsuretypeAction extends BaseAction{

	private Insuretype insuretype;
	private Insuretypedetail insuretypedetail;
	private Long id;
	private List<Insuretype> insuretypelist;
	private List<Map<String, Object>> insuretypemap;
	private long fullprice;
	private InsuretypeService insuretypeService;
	private Long distance;

	public String query() {
		try {
			insuretypeService = new InsuretypeServiceImpl();
			setInsuretypemap(insuretypeService.query(ServletPropertyFilterUtil
					.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	 
	public String queryInsuretype(){
		try {
			Global global = CurrentUtil.getGlobal();
			insuretypeService=new InsuretypeServiceImpl();
			setInsuretypemap(insuretypeService.qryInsuretype(global.getOrganization().getId()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	/*
	 * 根据里程查询保险类型
	 */
	public String qryInsuretypeByDistance(){
		try {
			insuretypeService=new InsuretypeServiceImpl();
			setInsuretypemap(insuretypeService.qryInsuretypeByDistance(distance));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	/*
	 * 根据票价查询保险类型
	 */
	public String qryInsuretypeByPrice(){
		try {
			insuretypeService=new InsuretypeServiceImpl();
			setInsuretypemap(insuretypeService.qryInsuretypeByPrice(fullprice));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		} 
		return "json";
		
	}
	
	public String save() {
		insuretypeService = new InsuretypeServiceImpl();
		Global global = CurrentUtil.getGlobal();
		try {
			if (insuretype != null) {
				if (insuretype.getId() > 0) {
					msg = "修改成功！";
					markSuccess();
					insuretype.setUpdateby(global.getUserinfo().getId());
					insuretype.setUpdatetime(new Timestamp(System
							.currentTimeMillis()));
				} else {
					msg = "添加成功！";
					markSuccess();
					insuretype.setCreateby(global.getUserinfo().getId());
					insuretype.setCreatetime(new Timestamp(System
							.currentTimeMillis()));
					insuretype.setUpdateby(global.getUserinfo().getId());
					insuretype.setUpdatetime(new Timestamp(System
							.currentTimeMillis()));
				}
				insuretype = insuretypeService.save(insuretype);
				setId(insuretype.getId());
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
		if (insuretype != null) {
			try {
				insuretypeService = new InsuretypeServiceImpl();
				boolean result = insuretypeService.delete(insuretype.getId());
				if (result) {
					msg = "删除成功！";
					markSuccess();
				} else {
					msg = "删除失败！";
					markFail();
				}
			} catch (ServiceException se) {
				setMsg(se.getMessage());
				markSuccess();
			} catch (Exception ex) {
				play.Logger.error(ex.getMessage(), ex);
				msg = "删除失败:" + ex.getMessage();
				markFail();
			}
		}
		return "json";
	}
	
	public Insuretype getInsuretype() {
		return insuretype;
	}

	public void setInsuretype(Insuretype insuretype) {
		this.insuretype = insuretype;
	}

	public List<Insuretype> getInsuretypelist() {
		return insuretypelist;
	}

	public void setInsuretypelist(List<Insuretype> insuretypelist) {
		this.insuretypelist = insuretypelist;
	}

	public List<Map<String, Object>> getInsuretypemap() {
		return insuretypemap;
	}

	public void setInsuretypemap(List<Map<String, Object>> insuretypemap) {
		this.insuretypemap = insuretypemap;
	}

	public Insuretypedetail getInsuretypedetail() {
		return insuretypedetail;
	}

	public void setInsuretypedetail(Insuretypedetail insuretypedetail) {
		this.insuretypedetail = insuretypedetail;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}
	public Long getDistance() {
		return distance;
	}
	public void setDistance(Long distance) {
		this.distance = distance;
	}
	public long getFullprice() {
		return fullprice;
	}
	public void setFullprice(long fullprice) {
		this.fullprice = fullprice;
	}
	
}
