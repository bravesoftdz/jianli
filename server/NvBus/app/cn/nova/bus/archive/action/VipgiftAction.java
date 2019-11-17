package cn.nova.bus.archive.action;

import cn.nova.bus.action.BaseAction;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;
import java.util.Map;

import util.CurrentUtil;
import cn.nova.bus.archive.model.Vipgift;
import cn.nova.bus.archive.model.Vipgiftdetail;
import cn.nova.bus.archive.model.Vipgiftexchangelog;
import cn.nova.bus.archive.model.Vipgiftstoragelog;
import cn.nova.bus.archive.service.VipgiftService;
import cn.nova.bus.archive.service.impl.VipgiftServiceImpl;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.web.ServletPropertyFilterUtil;

public class VipgiftAction extends BaseAction{
	private VipgiftService vipgiftService;	
	private Vipgift vipgift;
	//返回结果
	private List<Map<String,Object>> vipgiftmap;
	private List<Map<String,Object>> vipgradeinfo;
	private List<Vipgiftdetail> opratevipgradeinfo;
	private long vipgiftid;
	private String vipgrade; //可参与卡类型
	private long id;
	private float needamount;
	private float beginamount;
	private float endamount;	
	private Date startdate;
	private Date enddate;
	private String amount;	
	private List<Map<String,Object>> storagedetail;
	private long createby;
	private String vipgiftname;
	private long vipgradeid; 
	private String operation;	
	private Vipgiftexchangelog exchangelog;	
	private String cardno;
	private List<Map<String,Object>> vipmap;	
	private List<Map<String,Object>> exchangeDetailmap;
	
	//礼品出入库日志表
	private Vipgiftstoragelog storage;
	
	public String findVipgift(){	
		vipgiftService = new VipgiftServiceImpl();
		setVipgiftmap(vipgiftService.queryVipgift(startdate,enddate,vipgrade,beginamount,endamount));		
		return "json";
	}
	
	/**
	 * 查询卡等级
	 * @return
	 */
	public String queryVipGrade(){		
		vipgiftService = new VipgiftServiceImpl();
		setVipgradeinfo(vipgiftService.queryVipGrade(vipgiftid));
		return "json";
	}
	
	public String saveVipgift(){
		vipgiftService = new VipgiftServiceImpl();
		Vipgift v = null;
		String show ="";		
		Global global = CurrentUtil.getGlobal();
		try{			
			if(vipgift.getId()!=0){
				vipgift.setUpdatetime(new Timestamp(System.currentTimeMillis()));
				vipgift.setUpdateby(global.getUserinfo().getId());
				show="修改";
			}else{
				vipgift.setCreateby(global.getUserinfo().getId());
				vipgift.setCreatetime(new Timestamp(System.currentTimeMillis()));	
				vipgift.setUpdatetime(new Timestamp(System.currentTimeMillis()));
				vipgift.setUpdateby(global.getUserinfo().getId());
				show="添加";
			}
			v = vipgiftService.saveVipgift(vipgift,vipgrade,amount);
			if(v!=null){
				id = v.getId();
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

	public String delVipgift(){		
		vipgiftService = new VipgiftServiceImpl();
		if(vipgiftService.delVipgift(id)){
			setMsg("删除成功");
			markSuccess();
		}else{
			setMsg("删除失败");
			markFail();
		}
		return "json";
	}
	
	/**
	 * 保存礼品出入库信息
	 * @return
	 */
	public String saveStorage(){	
		vipgiftService = new VipgiftServiceImpl();
		Global global = CurrentUtil.getGlobal();	
		storage.setCreateby(global.getUserinfo().getId());
		storage.setCreatetime(new Timestamp(System.currentTimeMillis()));	
		Vipgiftstoragelog v= vipgiftService.sevaStory(storage);
		if(v!=null){
			vipgiftid = v.getVipgiftid();
			setMsg("成功");
			markSuccess();
		}
		else{
			setMsg("失败");
			markFailure();
		}
		return "json";
	}
	
	/**
	 * 查询礼品类型出入库明细
	 * @return
	 */
	public String findStorageDetail(){	
		vipgiftService = new VipgiftServiceImpl();
		setStoragedetail(vipgiftService.findStorageDetail(vipgiftname,operation,createby,startdate,enddate));			
		return "json";
	}
	
	/**
	 *  查询可供兑换的会员礼品信息
	 * @return
	 */
	public String queryVipgiftinfo(){	
		vipgiftService = new VipgiftServiceImpl();
		setVipgiftmap(vipgiftService.queryVipgiftinfo(vipgiftname,vipgradeid));			
			
		return "json";
	}
	
	/**
	 * 根据卡号获取VIp卡信息
	 * @return
	 */
	public String queryVipinfo(){	
		vipgiftService = new VipgiftServiceImpl();
		setVipmap(vipgiftService.queryVipbyCardno(cardno));			
			
		return "json";
	}

	/**
	 * 顾客积分兑换
	 * @return
	 */
	public String saveExchangelog(){	
		vipgiftService = new VipgiftServiceImpl();
		Global global = CurrentUtil.getGlobal();		
		exchangelog.setCreateby(global.getUserinfo().getId());
		exchangelog.setCreatetime(new Date());	
		exchangelog.setUpdateby(exchangelog.getCreateby());
		exchangelog.setUpdatetime(exchangelog.getCreatetime());	
		Vipgiftexchangelog v= vipgiftService.saveExchangelog(exchangelog);
		if(v!=null){
			id = v.getVipgiftid();
			setMsg("成功");
			markSuccess();
		}
		else{
			setMsg("失败");
			markFailure();
		}
		return "json";
	}

	/**
	 * 积分兑换明细
	 * @return
	 */
	public String findExchangelogDetail(){	
		List<PropertyFilter> propertyFilterList = ServletPropertyFilterUtil
						.buildFromHttpRequest();
		vipgiftService = new VipgiftServiceImpl();
		setExchangeDetailmap(vipgiftService.findExchangelogDetail(propertyFilterList));
		return "json";
	}
	
	public Vipgift getVipgift() {
		return vipgift;
	}

	public void setVipgift(Vipgift vipgift) {
		this.vipgift = vipgift;
	}

	public List<Map<String, Object>> getVipgiftmap() {
		return vipgiftmap;
	}

	public void setVipgiftmap(List<Map<String, Object>> vipgiftmap) {
		this.vipgiftmap = vipgiftmap;
	}

	public long getVipgiftid() {
		return vipgiftid;
	}

	public void setVipgiftid(long vipgiftid) {
		this.vipgiftid = vipgiftid;
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

	public float getNeedamount() {
		return needamount;
	}

	public void setNeedamount(float needamount) {
		this.needamount = needamount;
	}

	public float getBeginamount() {
		return beginamount;
	}

	public void setBeginamount(float beginamount) {
		this.beginamount = beginamount;
	}

	public float getEndamount() {
		return endamount;
	}

	public void setEndamount(float endamount) {
		this.endamount = endamount;
	}

	public List<Map<String, Object>> getVipgradeinfo() {
		return vipgradeinfo;
	}

	public void setVipgradeinfo(List<Map<String, Object>> vipgradeinfo) {
		this.vipgradeinfo = vipgradeinfo;
	}

	public List<Vipgiftdetail> getOpratevipgradeinfo() {
		return opratevipgradeinfo;
	}

	public void setOpratevipgradeinfo(List<Vipgiftdetail> opratevipgradeinfo) {
		this.opratevipgradeinfo = opratevipgradeinfo;
	}

	public String getAmount() {
		return amount;
	}

	public void setAmount(String amount) {
		this.amount = amount;
	}

	public Vipgiftstoragelog getStorage() {
		return storage;
	}

	public void setStorage(Vipgiftstoragelog storage) {
		this.storage = storage;
	}

	public List<Map<String, Object>> getStoragedetail() {
		return storagedetail;
	}

	public void setStoragedetail(List<Map<String, Object>> storagedetail) {
		this.storagedetail = storagedetail;
	}

	public long getCreateby() {
		return createby;
	}

	public void setCreateby(long createby) {
		this.createby = createby;
	}

	public String getVipgiftname() {
		return vipgiftname;
	}

	public void setVipgiftname(String vipgiftname) {
		this.vipgiftname = vipgiftname;
	}

	public long getVipgradeid() {
		return vipgradeid;
	}

	public void setVipgradeid(long vipgradeid) {
		this.vipgradeid = vipgradeid;
	}

	public Vipgiftexchangelog getExchangelog() {
		return exchangelog;
	}

	public void setExchangelog(Vipgiftexchangelog exchangelog) {
		this.exchangelog = exchangelog;
	}

	public String getCardno() {
		return cardno;
	}

	public void setCardno(String cardno) {
		this.cardno = cardno;
	}

	public List<Map<String, Object>> getVipmap() {
		return vipmap;
	}

	public void setVipmap(List<Map<String, Object>> vipmap) {
		this.vipmap = vipmap;
	}

	public List<Map<String, Object>> getExchangeDetailmap() {
		return exchangeDetailmap;
	}

	public void setExchangeDetailmap(List<Map<String, Object>> exchangeDetailmap) {
		this.exchangeDetailmap = exchangeDetailmap;
	}

	public String getOperation() {
		return operation;
	}

	public void setOperation(String operation) {
		this.operation = operation;
	}

	public VipgiftService getVipgiftService() {
		return vipgiftService;
	}

	public void setVipgiftService(VipgiftService vipgiftService) {
		this.vipgiftService = vipgiftService;
	}	
}