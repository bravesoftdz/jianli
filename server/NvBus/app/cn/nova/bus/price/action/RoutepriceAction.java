package cn.nova.bus.price.action;

import java.util.List;
import java.util.Map;

import util.CurrentUtil;
import cn.nova.bus.action.BaseAction;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.price.model.Routeprice;
import cn.nova.bus.price.service.RoutepriceService;
import cn.nova.bus.price.service.impl.RoutepriceServiceImpl;
import cn.nova.bus.security.Global;

public class RoutepriceAction extends BaseAction{
	private RoutepriceService service = new RoutepriceServiceImpl();
	private List<Map<String, Object>> results;
	private List<Routeprice> routepricelist;
	private Routeprice	routeprice;
	private Long id;
	private String ids;
	private long routeid;
	private boolean isdepart;
	private long scheduleid;
	private boolean savestandprice;
	private String departdate;
	public String getDepartdate() {
		return departdate;
	}
	public void setDepartdate(String departdate) {
		this.departdate = departdate;
	}
	public String qryRouteprice(){
		Global global=CurrentUtil.getGlobal();
		try {
			List<Map<String, Object>> routeprices = service.qryRoutepriceOrHardprice(routeid,scheduleid,global,departdate);
			setResults(routeprices);
			markSuccess();
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			markFail();
		}
		return "json";
	}
	public String qryRoutepricenew(){
		try {
			List<Map<String, Object>> routeprices = service.qryRouteprice(routeid);
			setResults(routeprices);
			markSuccess();
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			markFail();
		}
		return "json";
	}
	
	public String qryRoutestops(){
		try {
			List<Map<String, Object>> rps = service.qryRoutestops(routeid,isdepart);
			if(rps.size()<2){
				setMsg("该线路不存在上车站，无法添加线路票价信息！");
			}else{
				setMsg("");
			}
			setResults(rps);
			markSuccess();
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			markFail();
		}
		return "json";
	}
	public String qryRoutepriceedt(){
		try {
			List<Map<String, Object>> routeprices = service.qryRoutepriceedt(routeid);
			setResults(routeprices);
			markSuccess();
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			markFail();
		}
		return "json";
	}
	public String save(){
		Global global = CurrentUtil.getGlobal();
		try {
			setResults(service.save(routepricelist, global));
			markSuccess();			
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			markFail();
		}
		return "json";
	}
	public String saveall(){
		Global global = CurrentUtil.getGlobal();
		try {
			setResults(service.saveall(routepricelist,savestandprice, global));
			markSuccess();			
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			markFail();
		}
		return "json";
	}
	public String delRouteprice(){
		try {
			service.delRouteprice(ids);
			markSuccess();
		} catch (ServiceException e) {
			play.Logger.error(e.getMessage(), e);
			markFail();
		}
		return "json";
	}
	
	public String add(){
		Global global = CurrentUtil.getGlobal();
		try {
			setId(service.add(routeprice, global));
			markSuccess();
		} catch (ServiceException e) {
			markFail();
			setMsg(e.getMessage());
		}
		return "json";
	}
	
	public List<Map<String, Object>> getResults() {
		return results;
	}

	public void setResults(List<Map<String, Object>> results) {
		this.results = results;
	}

	public long getRouteid() {
		return routeid;
	}

	public void setRouteid(long routeid) {
		this.routeid = routeid;
	}

	public List<Routeprice> getRoutepricelist() {
		return routepricelist;
	}

	public void setRoutepricelist(List<Routeprice> routepricelist) {
		this.routepricelist = routepricelist;
	}

	public Routeprice getRouteprice() {
		return routeprice;
	}

	public void setRouteprice(Routeprice routeprice) {
		this.routeprice = routeprice;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getIds() {
		return ids;
	}

	public void setIds(String ids) {
		this.ids = ids;
	}
	public boolean isIsdepart() {
		return isdepart;
	}

	public void setIsdepart(boolean isdepart) {
		this.isdepart = isdepart;
	}

	public long getScheduleid() {
		return scheduleid;
	}

	public void setScheduleid(long scheduleid) {
		this.scheduleid = scheduleid;
	}
	public boolean isSavestandprice() {
		return savestandprice;
	}
	public void setSavestandprice(boolean savestandprice) {
		this.savestandprice = savestandprice;
	}
	
	
}
