/**
 * <b>项目名：</b>NvBusWeb<br/>
 * <b>包名：</b>cn.nova.bus.price.action<br/>
 * <b>文件名：</b>StationPriceAction.java<br/>
 * <b>版本信息：</b>v4.0<br/>
 * <b>日期：</b> 2013-4-25  <br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.price.action;

import cn.nova.bus.action.BaseAction;
import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import util.CurrentUtil;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.price.model.Stationprice;
import cn.nova.bus.price.service.StationPriceService;
import cn.nova.bus.price.service.impl.StationPriceServiceImpl;
import cn.nova.bus.security.Global;
import cn.nova.utils.web.ServletPropertyFilterUtil;

/**
 * <b>类描述：站点平时票价管理</b><br/>
 * <b>类名称：</b>StationPriceAction.java<br/>
 * <b>创建人：</b><a href="mailto:huanghaoze@nova.net.cn">hhz</a><br/>
 * <b>创建时间：</b>2013-4-25  <br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
public class StationPriceAction extends BaseAction{

	private Stationprice stationprice;
	private boolean issave;
	private long id;

	private List<Map<String, Object>> results;

	private StationPriceService stationpriceservice;

	/**
	 * 查询站点平时票价
	 */
	public String qrystationprice() {
		try {
			stationpriceservice = new StationPriceServiceImpl();
			setResults(stationpriceservice.qryStationPrice(ServletPropertyFilterUtil
							.buildFromHttpRequest()));
		}catch(Exception e){
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	 
	/**
	 * 添加或修改站点平时票价
	 */
	public String Savestationprice(){
		try{
			Global global = CurrentUtil.getGlobal();
			stationprice.setUpdateby(global.getUserinfo().getId());
			stationprice.setUpdatetime(new Timestamp(System.currentTimeMillis()));
			if(stationprice.getId()<=0){
				stationprice.setCreateby(global.getUserinfo().getId());
				stationprice.setCreatetime(new Timestamp(System.currentTimeMillis()));
			}
			stationpriceservice = new StationPriceServiceImpl();
			Stationprice sp = stationpriceservice.save(stationprice);
			if(sp !=null ){
				if(stationprice.getId()<=0){
					setMsg( "添加成功!");
				}else{
					setMsg("修改成功!");
				}				
				markSuccess();
				id=sp.getId();
			}else{
				setMsg("保存失败!");
				markFail();
			}			
		}catch(ServiceException e){
			setMsg(e.getExceptionMessage());
			markFail();
		}		
		return "json";
	}
	
	/**
	 * 删除站点平时票价
	 */
	public String delstationprice(){
		try {
			stationpriceservice = new StationPriceServiceImpl();
			boolean isdel = stationpriceservice.delete(id);
			if(isdel){
				msg = "删除成功!";
				markSuccess();
			}else{
				msg = "删除失败!";
				markFail();
			}
		} catch ( Exception e) {
			play.Logger.error(e.getMessage(), e);
		}		
		return "json";
	}
	
	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}
	
	public boolean isIssave() {
		return issave;
	}

	public void setIssave(boolean issave) {
		this.issave = issave;
	}
//	@JSON(serialize=false)
	public Stationprice getStationprice() {
		return stationprice;
	}

	public void setStationprice(Stationprice stationprice) {
		this.stationprice = stationprice;
	}

	public List<Map<String, Object>> getResults() {
		return results;
	}

	public void setResults(List<Map<String, Object>> results) {
		this.results = results;
	}
	
}
