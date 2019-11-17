package cn.nova.bus.query.action;

import cn.nova.bus.action.BaseAction;
import java.util.List;
import java.util.Map;

import util.CurrentUtil;

import cn.nova.bus.query.service.PackQueryService;
import cn.nova.bus.query.service.impl.PackQueryServiceImpl;
import cn.nova.bus.security.Global;
import cn.nova.utils.web.ServletPropertyFilterUtil;

public class PackQueryAction extends BaseAction{
	private List<Map<String, Object>> packshipmentlist;
	private List<Map<String, Object>> packReceivelist;
	private List<Map<String, Object>> goodslist;
	private List<Map<String, Object>> vehiclePricelist;
	private List<Map<String, Object>> packdetails;
	private List<Map<String, Object>> qryLibraryDetails;
	private List<Map<String, Object>> queryCollectDetail;
	private List<Map<String, Object>> querySendGoodsdGetails;
	
	private Boolean isbysellgroup;
	
	private PackQueryService packQueryService;
	
	public String queryPackShipment(){
		packQueryService = new PackQueryServiceImpl();
		setPackshipmentlist(packQueryService.queryPackShipment(ServletPropertyFilterUtil.buildFromHttpRequest()));
		return "json";
	}

	public String queryPackReceive(){
		packQueryService = new PackQueryServiceImpl();
		setPackReceivelist(packQueryService.queryPackReceive(ServletPropertyFilterUtil.buildFromHttpRequest()));
		return "json";
	}
	 
	public String queryGoods(){
		packQueryService = new PackQueryServiceImpl();
		setGoodslist(packQueryService.queryGoods(ServletPropertyFilterUtil.buildFromHttpRequest(),
				isbysellgroup));
		return "json";
	}
	
	public String queryPackVehiclePrice(){
		packQueryService = new PackQueryServiceImpl();
		setVehiclePricelist(packQueryService.queryPackVehiclePrice(ServletPropertyFilterUtil.buildFromHttpRequest()));
		return "json";
	}
	
	public String queryPackDetails(){
		packQueryService = new PackQueryServiceImpl();
		Global global = CurrentUtil.getGlobal();
		setPackdetails(packQueryService.queryPackDetails(global,ServletPropertyFilterUtil.buildFromHttpRequest()));
		return "json";
	}
	public String qryLibraryDetails(){
		packQueryService = new PackQueryServiceImpl();
		setQryLibraryDetails(packQueryService.qryLibraryDetails(ServletPropertyFilterUtil.buildFromHttpRequest()));
		return "json";
	}
	public String queryCollectDetail(){
		packQueryService = new PackQueryServiceImpl();
		setQueryCollectDetail(packQueryService.queryCollectDetail(ServletPropertyFilterUtil.buildFromHttpRequest()));
		return "json";
	}

	public String querySendGoodsdGetails(){
		packQueryService = new PackQueryServiceImpl();
		setQuerySendGoodsdGetails(packQueryService.querySendGoodsdGetails(ServletPropertyFilterUtil.buildFromHttpRequest()));
		return "json";
	}
	
	public List<Map<String, Object>> getPackshipmentlist() {
		return packshipmentlist;
	}

	public void setPackshipmentlist(List<Map<String, Object>> packshipmentlist) {
		this.packshipmentlist = packshipmentlist;
	}

	public List<Map<String, Object>> getPackReceivelist() {
		return packReceivelist;
	}

	public void setPackReceivelist(List<Map<String, Object>> packReceivelist) {
		this.packReceivelist = packReceivelist;
	}

	public List<Map<String, Object>> getGoodslist() {
		return goodslist;
	}

	public void setGoodslist(List<Map<String, Object>> goodslist) {
		this.goodslist = goodslist;
	}

	public Boolean getIsbysellgroup() {
		return isbysellgroup;
	}

	public void setIsbysellgroup(Boolean isbysellgroup) {
		this.isbysellgroup = isbysellgroup;
	}
	
	public List<Map<String, Object>> getVehiclePricelist() {
		return vehiclePricelist;
	}

	public void setVehiclePricelist(List<Map<String, Object>> vehiclePricelist) {
		this.vehiclePricelist = vehiclePricelist;
	}

	public List<Map<String, Object>> getPackdetails() {
		return packdetails;
	}

	public void setPackdetails(List<Map<String, Object>> packdetails) {
		this.packdetails = packdetails;
	}

	public List<Map<String, Object>> getQryLibraryDetails() {
		return qryLibraryDetails;
	}

	public void setQryLibraryDetails(List<Map<String, Object>> qryLibraryDetails) {
		this.qryLibraryDetails = qryLibraryDetails;
	}

	public List<Map<String, Object>> getQueryCollectDetail() {
		return queryCollectDetail;
	}

	public void setQueryCollectDetail(List<Map<String, Object>> queryCollectDetail) {
		this.queryCollectDetail = queryCollectDetail;
	}

	public List<Map<String, Object>> getQuerySendGoodsdGetails() {
		return querySendGoodsdGetails;
	}

	public void setQuerySendGoodsdGetails(
			List<Map<String, Object>> querySendGoodsdGetails) {
		this.querySendGoodsdGetails = querySendGoodsdGetails;
	}
	
}
