package cn.nova.bus.pack.action;

import java.util.Date;
import java.util.List;
import java.util.Map;

import play.db.jpa.JPA;
import util.CurrentUtil;
import util.UserTransaction;
import cn.nova.bus.action.BaseAction;
import cn.nova.bus.pack.model.PackDilivery;
import cn.nova.bus.pack.model.PackDiliveryDetail;
import cn.nova.bus.pack.service.impl.PackDiliveryDetailServiceImpl;
import cn.nova.bus.pack.service.impl.PackDiliveryServiceImpl;
import cn.nova.bus.pack.service.impl.PackServiceImpl;
import cn.nova.bus.security.Global;
import cn.nova.utils.web.ServletPropertyFilterUtil;

public class PackDiliveryDetailAction extends BaseAction{
	
	private String packids;
	private PackDilivery packdilivery;
	private Long id;
	private List<PackDiliveryDetail> packdiliverydetails;
	private List<Map<String, Object>> packdiliverydetaillist;
	private List<Map<String, Object>> samepackdilivery;

	private PackDiliveryServiceImpl pdService = null;
	private PackDiliveryDetailServiceImpl pddService = null;
	private PackServiceImpl pService = null;
	
	private UserTransaction tr = new UserTransaction();
	
	public String listPackDiliveryDetail() {
		pddService = new PackDiliveryDetailServiceImpl();
		setPackdiliverydetaillist(pddService.query(packids.substring(0, packids.length() - 1)));
		return "json";
	}
	
	public String listPackDiliveryDetailByPackdiliveryId(){
		try {
			pddService = new PackDiliveryDetailServiceImpl();
			setPackdiliverydetaillist(pddService.queryByDiliveryid(ServletPropertyFilterUtil
					.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	public String savePackDiliveryDetails() {
		pdService = new PackDiliveryServiceImpl();
		pddService = new PackDiliveryDetailServiceImpl();
		pService = new PackServiceImpl();
		String packids = "";	//需要更新status的所有packid
		
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				//插入 packdilivery 记录
				if (packdilivery != null) {
					packdilivery.setOrgid(global.getUserinfo().getOrgid());
					packdilivery.setCreateby(global.getUserinfo().getId());
					packdilivery.setCreatetime(new Date());
					packdilivery.setUpdateby(global.getUserinfo().getId());
					packdilivery.setUpdatetime(new Date());
					packdilivery = pdService.savePackDilivery(packdilivery);
					setId(packdilivery.getId());
				}
				//插入 packdiliverydetail 子记录
				if (packdiliverydetails != null){
					for (PackDiliveryDetail pdd : packdiliverydetails) {
						packids += pdd.getPackid()+",";
						pdd.setPackdiliveryid(packdilivery.getId());
						pdd.setCreateby(global.getUserinfo().getId());
						pdd.setCreatetime(new Date());
						pdd.setUpdateby(global.getUserinfo().getId());
						pdd.setUpdatetime(new Date());
						pddService.savePackDiliveryDetail(pdd);
					}
					// 更新已出库的pack记录状态
					packids = packids.substring(0, packids.length() - 1);
					pService.updatePackStatus(packids, "6");	// 已出库状态
				}
				setMsg("添加成功！");
				markSuccess();
			}
		} catch (Exception ex) {
			play.Logger.error(ex.getMessage(), ex);
			setMsg("操作失败！");
			markFail();
		}
		return "json";
	}
	public String samediliveno(){
		PackDilivery pd = null;
		pdService = new PackDiliveryServiceImpl();
		pd = pdService.existDiliveno(packdilivery.getDiliveno());
		if (pd!= null && pd.getId() > 0) {
			setMsg("送货单号已存在！");
			markFail();
			return "json";
		} 
		setMsg("送货单号合法！");
		markSuccess();
		return "json";
	}
	
	public String getPackids() {
		return packids;
	}

	public void setPackids(String packids) {
		this.packids = packids;
	}

	public PackDilivery getPackdilivery() {
		return packdilivery;
	}

	public void setPackdilivery(PackDilivery packdilivery) {
		this.packdilivery = packdilivery;
	}

	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}

	public List<Map<String, Object>> getSamepackdilivery() {
		return samepackdilivery;
	}

	public void setSamepackdilivery(List<Map<String, Object>> samepackdilivery) {
		this.samepackdilivery = samepackdilivery;
	}

	public List<PackDiliveryDetail> getPackdiliverydetails() {
		return packdiliverydetails;
	}

	public void setPackdiliverydetails(List<PackDiliveryDetail> packdiliverydetails) {
		this.packdiliverydetails = packdiliverydetails;
	}

	public List<Map<String, Object>> getPackdiliverydetaillist() {
		return packdiliverydetaillist;
	}

	public void setPackdiliverydetaillist(
			List<Map<String, Object>> packdiliverydetaillist) {
		this.packdiliverydetaillist = packdiliverydetaillist;
	}
}
