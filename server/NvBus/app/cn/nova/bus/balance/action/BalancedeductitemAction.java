package cn.nova.bus.balance.action;

import cn.nova.bus.action.BaseAction;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.persistence.Transient;

import util.CurrentUtil;
import cn.nova.bus.balance.model.Balancedeductitem;
import cn.nova.bus.balance.model.Balancedeductitemdistance;
import cn.nova.bus.balance.model.Balancedeductitemprice;
import cn.nova.bus.balance.service.BalancedeductitemService;
import cn.nova.bus.balance.service.impl.BalancedeductitemServiceImpl;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;
import cn.nova.utils.web.ServletPropertyFilterUtil;

/**
 * 
 * <p>
 * Title: 结算固定扣费项目管理
 * </p>
 * <p>
 * Description:
 * </p>
 * <p>
 * Copyright: Copyright (c) 2011
 * </p>
 * <p>
 * Company: nova
 * </p>
 * 
 * @author lanckun
 * @version 0.1
 */
public class BalancedeductitemAction extends BaseAction{
	private Long balancedeductitemid;
	private Long curid;
	private Balancedeductitem balancedeductitem;
	private Balancedeductitemprice balancedeductitemprice;	
	private Balancedeductitemdistance balancedeductitemdistance;
	private List<Map<String, Object>> balancedeductitems;
	private List<Map<String, Object>> balancedeductitemdetails;
	private List<Map<String, Object>> balancedeductitemtree;	
	private long orgid;
	
	private  BalancedeductitemService balancedeductitemService;
	
	public String createDeductitemTree() {
		try {
			balancedeductitemService = new BalancedeductitemServiceImpl();
			setBalancedeductitemtree(balancedeductitemService.createTree(orgid));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	public String qrybalancedeductitem() {
		try {
			balancedeductitemService = new BalancedeductitemServiceImpl();
			setBalancedeductitems(balancedeductitemService.qryDeductitem(
					ServletPropertyFilterUtil.buildFromHttpRequest(),balancedeductitemid));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	public String qrybalancedeductitemdetail() {
		try {
			balancedeductitemService = new BalancedeductitemServiceImpl();
			setBalancedeductitemdetails(balancedeductitemService.qryDeductitemdetail(balancedeductitemid));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	public String saveDeductitem() {
		Global global = CurrentUtil.getGlobal();
		try {
			balancedeductitemService = new BalancedeductitemServiceImpl();
			if (global != null && global.getUserinfo().getId() > 0) {
				balancedeductitem.setIsactive(true);
				if(balancedeductitem.getId()==0){
					markSuccess();
					setMsg("添加成功！");
					balancedeductitem.setCreateby(global.getUserinfo().getId());
					balancedeductitem.setUpdateby( global.getUserinfo().getId());
					balancedeductitem.setCreatetime(new Date());
					balancedeductitem.setUpdatetime(new Date());
				}else{
					markSuccess();
					setMsg("修改成功！");
					balancedeductitem.setUpdateby( global.getUserinfo().getId());
					balancedeductitem.setUpdatetime(new Date());
				}
				balancedeductitem = balancedeductitemService.saveDeductitem(balancedeductitem);
				setBalancedeductitemid(balancedeductitem.getId());
			}
		} catch (ServiceException se) {
			markSuccess();
			setMsg(se.getMessage());
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			markSuccess();
			setMsg("系统异常！");
		}
		return "json";
	}
	
	public String deleteDeductitem() {
		balancedeductitemService = new BalancedeductitemServiceImpl();
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				if (balancedeductitemService.delDeductitem(balancedeductitem)){
					markSuccess();
					setMsg("删除成功！");
				}
			}
		} catch (ServiceException se) {
			markSuccess();
			setMsg(se.getMessage());
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			markSuccess();
			setMsg("系统异常！");
		}
		return "json";
	}
	
	public String saveDeductitemaboutdistance() {
		Global global = CurrentUtil.getGlobal();
		try {
			balancedeductitemService = new BalancedeductitemServiceImpl();
			if (global != null && global.getUserinfo().getId() > 0) {
				if(balancedeductitemdistance.getId()==0){
					markSuccess();
					setMsg("添加成功！");
					balancedeductitemdistance.setCreateby(global.getUserinfo().getId());
					balancedeductitemdistance.setUpdateby( global.getUserinfo().getId());
					balancedeductitemdistance.setCreatetime(new Date());
					balancedeductitemdistance.setUpdatetime(new Date());
				}else{
					markSuccess();
					setMsg("修改成功！");
					balancedeductitemdistance.setUpdateby( global.getUserinfo().getId());
					balancedeductitemdistance.setUpdatetime(new Date());
				}
				balancedeductitemdistance = balancedeductitemService.saveDeductitemdistance(balancedeductitemdistance);
				setCurid(balancedeductitemdistance.getId());
			}
		} catch (ServiceException se) {
			markSuccess();
			setMsg(se.getMessage());
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			markSuccess();
			setMsg("系统异常！");
		}
		return "json";
	}
	public String delDeductitemaboutdistance() {
		balancedeductitemService = new BalancedeductitemServiceImpl();
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				if (balancedeductitemService.delaboutDistance(balancedeductitemdistance.getId())){
					markSuccess();
					setMsg("删除成功！");
				}
			}
		} catch (ServiceException se) {
			markSuccess();
			setMsg(se.getMessage());
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			markSuccess();
			setMsg("系统异常！");
		}
		return "json";
	}
	
	public String saveDeductitemaboutprice() {
		Global global = CurrentUtil.getGlobal();
		try {
			balancedeductitemService = new BalancedeductitemServiceImpl();
			if (global != null && global.getUserinfo().getId() > 0) {
				if(balancedeductitemprice.getId()==0){
					markSuccess();
					setMsg("添加成功！");
					balancedeductitemprice.setCreateby(global.getUserinfo().getId());
					balancedeductitemprice.setUpdateby( global.getUserinfo().getId());
					balancedeductitemprice.setCreatetime(new Date());
					balancedeductitemprice.setUpdatetime(new Date());
				}else{
					markSuccess();
					setMsg("修改成功！");
					balancedeductitemdistance.setUpdateby( global.getUserinfo().getId());
					balancedeductitemdistance.setUpdatetime(new Date());
				}
				balancedeductitemprice = balancedeductitemService.saveBalancedeductitemprice(balancedeductitemprice);
				setCurid(balancedeductitemprice.getId());
			}
		} catch (ServiceException se) {
			markSuccess();
			setMsg(se.getMessage());
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			markSuccess();
			setMsg("系统异常！");
		}
		return "json";
	}
	public String delDeductitemaboutPrice() {
		balancedeductitemService = new BalancedeductitemServiceImpl();
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				if (balancedeductitemService.delaboutPrice(balancedeductitemprice.getId())){
					markSuccess();
					setMsg("删除成功！");
				}
			}
		} catch (ServiceException se) {
			markSuccess();
			setMsg(se.getMessage());
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			markSuccess();
			setMsg("系统异常！");
		}
		return "json";
	}	
	
	public Long getBalancedeductitemid() {
		return balancedeductitemid;
	}

	public void setBalancedeductitemid(Long balancedeductitemid) {
		this.balancedeductitemid = balancedeductitemid;
	}
	@Transient
	public Balancedeductitem getBalancedeductitem() {
		return balancedeductitem;
	}

	public void setBalancedeductitem(Balancedeductitem balancedeductitem) {
		this.balancedeductitem = balancedeductitem;
	}

	public List<Map<String, Object>> getBalancedeductitems() {
		return balancedeductitems;
	}

	public void setBalancedeductitems(List<Map<String, Object>> balancedeductitems) {
		this.balancedeductitems = balancedeductitems;
	}
	@Transient
	public Balancedeductitemprice getBalancedeductitemprice() {
		return balancedeductitemprice;
	}

	public void setBalancedeductitemprice(
			Balancedeductitemprice balancedeductitemprice) {
		this.balancedeductitemprice = balancedeductitemprice;
	}
	@Transient
	public Balancedeductitemdistance getBalancedeductitemdistance() {
		return balancedeductitemdistance;
	}

	public void setBalancedeductitemdistance(
			Balancedeductitemdistance balancedeductitemdistance) {
		this.balancedeductitemdistance = balancedeductitemdistance;
	}
	public List<Map<String, Object>> getBalancedeductitemtree() {
		return balancedeductitemtree;
	}

	public void setBalancedeductitemtree(
			List<Map<String, Object>> balancedeductitemtree) {
		this.balancedeductitemtree = balancedeductitemtree;
	}
	public List<Map<String, Object>> getBalancedeductitemdetails() {
		return balancedeductitemdetails;
	}

	public void setBalancedeductitemdetails(
			List<Map<String, Object>> balancedeductitemdetails) {
		this.balancedeductitemdetails = balancedeductitemdetails;
	}
	
	public Long getCurid() {
		return curid;
	}

	public void setCurid(Long curid) {
		this.curid = curid;
	}
	public long getOrgid() {
		return orgid;
	}

	public void setOrgid(long orgid) {
		this.orgid = orgid;
	}
}
