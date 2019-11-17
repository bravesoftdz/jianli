package cn.nova.bus.archive.action;

import cn.nova.bus.action.BaseAction;
import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import util.CurrentUtil;
import cn.nova.bus.archive.model.Driverrewardpenalize;
import cn.nova.bus.archive.model.Stewardrewardpenalize;
import cn.nova.bus.archive.service.RewardpenalizeService;
import cn.nova.bus.archive.service.impl.RewardpenalizeServiceImpl;
import cn.nova.bus.security.Global;
import cn.nova.utils.web.ServletPropertyFilterUtil;

public class RewardpenalizeAction extends BaseAction{
	RewardpenalizeService rpService;
	
	private Driverrewardpenalize rewardpenalize;
	private Stewardrewardpenalize stewardrp;
	private String pictures;
	//返回结果
	private List<Map<String,Object>>  driverrpmap;
	private List<Map<String,Object>>  stewardrpmap;
	private long srewardid;
	private long drewardid;
	private long delid;

	public String saveDrewardpenalize(){
		Driverrewardpenalize dwp = null;
		String showMsg = "";
		rpService = new RewardpenalizeServiceImpl();
		
		Global global = CurrentUtil.getGlobal();
		rewardpenalize.setIsactive(true);
		rewardpenalize.setIslocaldelete(false);
		if(rewardpenalize.getId()!=0){
			rewardpenalize.setUpdatetime(new Timestamp(System.currentTimeMillis()));
			rewardpenalize.setUpdateby(global.getUserinfo().getId());
			showMsg = "修改";
		}else{
			rewardpenalize.setCreateby(global.getUserinfo().getId());
			rewardpenalize.setCreatetime(new Timestamp(System.currentTimeMillis()));	
			rewardpenalize.setUpdatetime(new Timestamp(System.currentTimeMillis()));
			rewardpenalize.setUpdateby(global.getUserinfo().getId());			
			showMsg="添加";
		}
		dwp = rpService.saveDriverrewardpenalize(rewardpenalize);
		if(dwp!=null){
			drewardid = dwp.getId();
			setMsg(showMsg+"驾驶员奖惩信息成功");
			markSuccess();
		}else{
			this.setMsg(showMsg+"驾驶员奖惩信息失败");
			markFail();
		}
		return "json";
	}
	
	public String saveSrewardpenalizwe(){
		rpService = new RewardpenalizeServiceImpl();
		Stewardrewardpenalize swp = null;
		String show ="";
		try{
			Global global = CurrentUtil.getGlobal();
		stewardrp.setIsactive(true);
		if(stewardrp.getId()!=0){
			stewardrp.setUpdatetime(new Timestamp(System.currentTimeMillis()));
			stewardrp.setUpdateby(global.getUserinfo().getId());
			show="修改乘务员奖惩信息";
		}else{
			stewardrp.setCreateby(global.getUserinfo().getId());
			stewardrp.setCreatetime(new Timestamp(System.currentTimeMillis()));	
			stewardrp.setUpdatetime(new Timestamp(System.currentTimeMillis()));
			stewardrp.setUpdateby(global.getUserinfo().getId());
			show="添加乘务员奖惩信息";
		}
		swp = rpService.saveStewardrewardpenalize(stewardrp);
		if(swp!=null){
			srewardid = swp.getId(); 
			setMsg(show+"成功");
			markSuccess();
		}
		else{
			setMsg(show+"失败");
			markFailure();
		}
		}catch(Exception ex){
			setMsg(show+"失败");
			markFail();
		}
		return "json";
	}
	
	public String findDriverRP(){
		rpService = new RewardpenalizeServiceImpl();
		try{
		 this.setDriverrpmap(rpService.queryDriverrewardpenalize(ServletPropertyFilterUtil.buildFromHttpRequest()));			
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	public String findStewardrp(){
		rpService = new RewardpenalizeServiceImpl();
		try{
		this.setStewardrpmap(rpService.queryStewardrewardpenalize(ServletPropertyFilterUtil.buildFromHttpRequest()));			
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	public String delDriverrp(){		
		rpService = new RewardpenalizeServiceImpl();
		if(rpService.delDriverrewardpenalize(delid)){
			setMsg("删除记录成功");
			markSuccess();
		}else{
			setMsg("删除记录失败");
			markFail();
		}
		return "json";
	}
	
	public String delStewardrp(){		
		rpService = new RewardpenalizeServiceImpl();
		if(rpService.delStewardrewardpenalize(delid)){
			setMsg("删除记录成功");
			markSuccess();
		}else{
			setMsg("删除记录失败");
			markFail();
		}
		return "json";
	}

	public Driverrewardpenalize getRewardpenalize() {
		return rewardpenalize;
	}

	public void setRewardpenalize(Driverrewardpenalize rewardpenalize) {
		this.rewardpenalize = rewardpenalize;
	}

	public Stewardrewardpenalize getStewardrp() {
		return stewardrp;
	}

	public void setStewardrp(Stewardrewardpenalize stewardrp) {
		this.stewardrp = stewardrp;
	}

	public String getPictures() {
		return pictures;
	}

	public void setPictures(String pictures) {
		this.pictures = pictures;
	}

	public List<Map<String, Object>> getDriverrpmap() {
		return driverrpmap;
	}

	public void setDriverrpmap(List<Map<String, Object>> driverrpmap) {
		this.driverrpmap = driverrpmap;
	}

	public List<Map<String, Object>> getStewardrpmap() {
		return stewardrpmap;
	}

	public void setStewardrpmap(List<Map<String, Object>> stewardrpmap) {
		this.stewardrpmap = stewardrpmap;
	}

	public long getDelid() {
		return delid;
	}

	public void setDelid(long delid) {
		this.delid = delid;
	}

	public long getSrewardid() {
		return srewardid;
	}

	public void setSrewardid(long srewardid) {
		this.srewardid = srewardid;
	}

	public long getDrewardid() {
		return drewardid;
	}

	public void setDrewardid(long drewardid) {
		this.drewardid = drewardid;
	}
	
}
