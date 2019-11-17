package cn.nova.bus.archive.service.impl;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.archive.dao.VipgiftDao;
import cn.nova.bus.archive.model.Vip;
import cn.nova.bus.archive.model.Vipgift;
import cn.nova.bus.archive.model.Vipgiftdetail;
import cn.nova.bus.archive.model.Vipgiftexchangelog;
import cn.nova.bus.archive.model.Vipgiftstoragelog;
import cn.nova.bus.archive.service.VipgiftService;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.exception.ServiceException;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.IDAO;
import cn.nova.utils.orm.jpa.ListUtil;


public class VipgiftServiceImpl implements VipgiftService {

	
	private IDAO<Vipgift> vipgiftIdao = new EntityManagerDaoSurport<Vipgift>();
	
	private IDAO<Vipgiftdetail> detaildao = new EntityManagerDaoSurport<Vipgiftdetail>();

	
	private IDAO<Vipgiftstoragelog> storagdao = new EntityManagerDaoSurport<Vipgiftstoragelog>();
	
	
	private IDAO<Vipgiftexchangelog> exchangelogdao = new EntityManagerDaoSurport<Vipgiftexchangelog>();
	
	
	private IDAO<Vip> vipdao = new EntityManagerDaoSurport<Vip>();
	
	
	private VipgiftDao vipgiftdao = new VipgiftDao();
	
	/**
	 * 添加或修改会有礼品
	 */
	@Override
	public Vipgift saveVipgift(Vipgift vipgift, String vipgrade,String needamount)
			throws ServiceException {
		Vipgift gift = vipgiftdao.existVipgift(vipgift.getName());		
		if(gift != null ){
			if(vipgift.getId()==0 || (vipgift.getId()!=0 && gift.getId() != vipgift.getId())){
				throw new ServiceException("0409");
			}
		}
		boolean isupdate = vipgift.getId()==0?false:true;
		Vipgift newgift = vipgiftIdao.merge(vipgift);
		if(newgift != null){
			 sevaDetail(newgift.getId(),vipgrade,needamount,isupdate);
		}
		return newgift;
		
	}

	/**
	 * 保存或修改充值优惠活动明细表
	 * @param id
	 * @param vipgrade
	 * @return
	 */
	public Boolean sevaDetail(long vipgiftid,String vipgrade,String needamount,boolean isupdate){
		Vipgiftdetail vd=new Vipgiftdetail();
		List<Vipgiftdetail> detaillist ;
		//如果是修改，先把原先添加的都删除，再重新添加新的。
		if(isupdate){
			detaillist = vipgiftdao.existVipgiftdetail(null,vipgiftid);
			if(detaillist!=null){ 
				vipgiftdao.deldetail(vipgiftid);				
			}
		}
		String[] vipgrades = vipgrade.split(",");
		String[] need = needamount.split(",");
		for (int i = 0; i < vipgrades.length; i++) {
			BigDecimal amount = BigDecimal.valueOf(Long.parseLong(need[i]));
			String vipgradeid =vipgrades[i];			
			vd.setVipgrade(vipgradeid);
			vd.setVipgiftid(vipgiftid);
			vd.setNeedamount(amount);
			detaildao.merge(vd);					
		}
		return true;	
	}
	
	@Override
	public Boolean delVipgift(long id) {
		Vipgift v =findById(id);
		return vipgiftIdao.delete(v);
	}

	public Vipgift findById(long id){
		return vipgiftIdao.get(Vipgift.class, id);
	}
	
	/**
	 * 查询会员礼品类别
	 */
	@Override
	public List<Map<String, Object>> queryVipgift(Date startdate, Date enddate,
			String vipgrade,float beginamount,float endamount) {
		Object[] fileds = {"vipgradename","vipgrade","needamount",
				"id","name","valuation","quantity","startdate","enddate","remarks",
				"createtime","updatetime","createname","updatename","createby"};
		Object[] filedtypes = {
				String.class,String.class,String.class,
				Long.class,String.class,BigDecimal.class,BigDecimal.class,Date.class,Date.class,String.class,
				Timestamp.class,Timestamp.class,String.class,String.class,long.class};
		return ListUtil.listToMap(
				fileds, vipgiftdao.queryVipgiftlist(startdate,enddate,vipgrade,beginamount,endamount),filedtypes);
	}
	
	@Override
	public List<Map<String, Object>> queryVipGrade(long vipgiftid) {
		Object[] fileds = { "ischecked","needamount","gradename","vipgrade" };
		return ListUtil.listToMap(fileds,
				vipgiftdao.queryVipGrade(vipgiftid),
				new Object[] { boolean.class,BigDecimal.class,String.class,String.class });
	}
	
	/**
	 * 礼品出入库管理
	 * @param story
	 * @return
	 */
	@Override
	public Vipgiftstoragelog sevaStory(Vipgiftstoragelog storage){	
		Vipgiftstoragelog  newstorag = storagdao.merge(storage);
		if (newstorag != null){
			Vipgift upvipgift = vipgiftIdao.get(Vipgift.class, newstorag.getVipgiftid());
			upvipgift.setQuantity(newstorag.getAfterstoragequantity());
			upvipgift.setUpdateby(newstorag.getCreateby());
			upvipgift.setUpdatetime(newstorag.getCreatetime());
			vipgiftIdao.merge(upvipgift);
		}
		return newstorag;			
	}	
	
	/**
	 * 礼品出入库明细 
	 */
	@Override
	public List<Map<String, Object>> findStorageDetail(String vipgiftname, String opration,
			long createby, Date startdate, Date enddate) {
		Object[] fileds = { "vipgiftname", "oprationname","cretaname","beforestoragequantity",
				"quantity","afterstoragequantity","remarks","createtime","vipamount" };
		return ListUtil.listToMap(fileds,
				vipgiftdao.findStorageDetail( vipgiftname,  opration, createby,  startdate,  enddate),
				new Object[] { String.class,String.class,String.class,BigDecimal.class, 
			BigDecimal.class, BigDecimal.class,String.class,Timestamp.class,BigDecimal.class });
	}	
	
	/**
	 * 查询可供兑换的会员礼品信息
	 */
	@Override
	public List<Map<String, Object>> queryVipgiftinfo(String name,long vipgrade) {
		Object[] fileds = { "id","name" ,"quantity","vipgrade","needamount" };
		return ListUtil.listToMap(fileds,
				vipgiftdao.queryVipgiftinfo(name,vipgrade),
				new Object[] { long.class,String.class,BigDecimal.class,String.class,BigDecimal.class });
	}
	
	/**
	 * 根据卡号，获取vip卡信息
	 */
	@Override
	public List<Map<String, Object>> queryVipbyCardno(String cardno) {
		Object[] fileds = { "customername","gragename","vipamount","vipgrade","money",
				"vipid","customerid" };		
		return ListUtil.listToMap(fileds,
				vipgiftdao.queryVipbyCardno(cardno),
				new Object[] { String.class,String.class,BigDecimal.class,String.class,BigDecimal.class,
				long.class,long.class });
	}
	/**
	 * 顾客积分兑换
	 */
	@Override
	public Vipgiftexchangelog saveExchangelog(Vipgiftexchangelog exchangelog){
		Vipgiftexchangelog  newexchangelog = exchangelogdao.merge(exchangelog);
		long operatQuantity = exchangelog.getQuantity();
		if (newexchangelog != null){		
			Vipgift upvipgift = vipgiftIdao.get(Vipgift.class, newexchangelog.getVipgiftid());
			
			//礼品出入库记录
			Vipgiftstoragelog  addstorag = new Vipgiftstoragelog();
			addstorag.setVipgiftid(newexchangelog.getVipgiftid());
			addstorag.setBeforestoragequantity(upvipgift.getQuantity());
			addstorag.setQuantity(operatQuantity);			
			addstorag.setAfterstoragequantity(upvipgift.getQuantity()-operatQuantity);
			addstorag.setOperation("2");
			addstorag.setCreateby(exchangelog.getCreateby());
			addstorag.setCreatetime(exchangelog.getCreatetime());
			storagdao.merge(addstorag);
			
			//减少礼品库存
			upvipgift.setQuantity(newexchangelog.getRemainstoragequantity());
			upvipgift.setUpdateby(newexchangelog.getCreateby());
			upvipgift.setUpdatetime(newexchangelog.getCreatetime());
			vipgiftIdao.merge(upvipgift);
			
			//减少会员积分
			Vip upvip= vipdao.get(Vip.class, newexchangelog.getVipid());
			upvip.setVipamount(exchangelog.getRemainvipamount());
			vipdao.merge(upvip);			
		}
		return newexchangelog;
	}
	

	/**
	 * 积分兑换明细
	 */
	@Override
	public List<Map<String, Object>> findExchangelogDetail(List<PropertyFilter> propertyFilterList) {
		Object[] fileds = { "vipgiftname","vipcardno","customername","mobilephone",
		 "gragename","statusname","quantity","vipamount","createtime","createbyname","remarks"};
		return ListUtil.listToMap(fileds,
				vipgiftdao.findExchangelogDetail(propertyFilterList),
				new Object[] { String.class,String.class,String.class,String.class,
			String.class,String.class,BigDecimal.class, BigDecimal.class,Timestamp.class,String.class,String.class });
	}	
	
}
