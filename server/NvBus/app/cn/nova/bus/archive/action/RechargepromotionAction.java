package cn.nova.bus.archive.action;

import cn.nova.bus.action.BaseAction;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;
import java.util.Map;

import util.CurrentUtil;
import cn.nova.bus.archive.model.Rechargepromotionactivity;
import cn.nova.bus.archive.service.RechargepromotionService;
import cn.nova.bus.archive.service.impl.RechargepromotionServiceImpl;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;

public class RechargepromotionAction extends BaseAction{
	RechargepromotionService rechargepromotionService;
	
	private Rechargepromotionactivity rechargepromotion;
	//返回结果
	private List<Map<String,Object>> rechargepromotionmap;
	private long rechargepromotionid;
	private String vipgrade; //可参与卡类型
	private long id;
	
	private Date startdate;
	private Date enddate;
	
	private BigDecimal money;//充值金额
	private String cardno;//卡号

	private List<Map<String,Object>> resultmap;
	
	public String findRecharge(){		
		rechargepromotionService = new RechargepromotionServiceImpl();
		setResultmap(rechargepromotionService.queryRechargepromotion(startdate,enddate,vipgrade));				
		return "json";
	}
	
	public String saveRechargepromotion(){
		rechargepromotionService = new RechargepromotionServiceImpl();
		Rechargepromotionactivity r = null;
		String show ="";
		Global global = CurrentUtil.getGlobal();
		try{
			rechargepromotion.setIsactive(true);
			if(rechargepromotion.getId()!=0){
				rechargepromotion.setUpdatetime(new Timestamp(System.currentTimeMillis()));
				rechargepromotion.setUpdateby(global.getUserinfo().getId());
				show="修改";
			}else{
				rechargepromotion.setCreateby(global.getUserinfo().getId());
				rechargepromotion.setCreatetime(new Timestamp(System.currentTimeMillis()));	
				rechargepromotion.setUpdatetime(new Timestamp(System.currentTimeMillis()));
				rechargepromotion.setUpdateby(global.getUserinfo().getId());
				show="添加";
			}
			r = rechargepromotionService.saveRechargepromotion(rechargepromotion,vipgrade);
			if(r!=null){
				id = r.getId();
				setMsg(show+"成功");
				markSuccess();
			}
			else{
				setMsg(show+"失败");
				markFailure();
			}
		}catch(ServiceException ex){
			setMsg(show+"失败;" +ex.getExceptionMessage());
			markFail();
		}
		return "json";
	}

	public String delrechargepromotion(){	
		rechargepromotionService = new RechargepromotionServiceImpl();
		try{
			if(rechargepromotionService.delRechargepromotion(id)){
				setMsg("删除成功");
				markSuccess();
			}else{
				setMsg("删除失败");
				markFail();
			}
		}catch(ServiceException ex){
			setMsg("删除失败;" +ex.getExceptionMessage());
			markFail();
		}
		return "json";
	}

	public String getRechargepromo(){//VIP充值时获取相应的优惠活动
		rechargepromotionService = new RechargepromotionServiceImpl();
		try {
			setRechargepromotionmap(rechargepromotionService.queryRechargepromotionByMoney(money,new Date(), cardno));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	public Rechargepromotionactivity getRechargepromotion() {
		return rechargepromotion;
	}

	public void setRechargepromotion(Rechargepromotionactivity rechargepromotion) {
		this.rechargepromotion = rechargepromotion;
	}

	public List<Map<String, Object>> getRechargepromotionmap() {
		return rechargepromotionmap;
	}

	public void setRechargepromotionmap(
			List<Map<String, Object>> rechargepromotionmap) {
		this.rechargepromotionmap = rechargepromotionmap;
	}

	public long getRechargepromotionid() {
		return rechargepromotionid;
	}

	public void setRechargepromotionid(long rechargepromotionid) {
		this.rechargepromotionid = rechargepromotionid;
	}

	public String getVipgrade() {
		return vipgrade;
	}

	public void setVipgrade(String vipgrade) {
		this.vipgrade = vipgrade;
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public Date getStartdate() {
		return startdate;
	}

	public void setStartdate(Date startdate) {
		this.startdate = startdate;
	}

	public Date getEnddate() {
		return enddate;
	}

	public void setEnddate(Date enddate) {
		this.enddate = enddate;
	}

	public BigDecimal getMoney() {
		return money;
	}

	public void setMoney(BigDecimal money) {
		this.money = money;
	}

	public String getCardno() {
		return cardno;
	}

	public void setCardno(String cardno) {
		this.cardno = cardno;
	}

	public List<Map<String, Object>> getResultmap() {
		return resultmap;
	}

	public void setResultmap(List<Map<String, Object>> resultmap) {
		this.resultmap = resultmap;
	}
	
}
