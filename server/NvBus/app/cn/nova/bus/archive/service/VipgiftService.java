package cn.nova.bus.archive.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.archive.model.Vipgift;
import cn.nova.bus.archive.model.Vipgiftexchangelog;
import cn.nova.bus.archive.model.Vipgiftstoragelog;
import cn.nova.bus.exception.ServiceException;
import cn.nova.utils.orm.PropertyFilter;

public interface VipgiftService {

	/**
	 * 添加或修改
	 * @param Employe
	 * @return boolean操作是否成功
	 * @throws ServiceException 
	 */
	public  Vipgift  saveVipgift(Vipgift vipgift,String vipgrade,String needamount)
	throws ServiceException;
	
	
	/**
	 * 根据ID删除
	 * @param id
	 * @return boolean删除是否成功
	 * @throws ServiceException 
	 */
	public Boolean delVipgift(long id);
	
	/**
	 * 查找
	 * @param where
	 * @return  List<Map<String,Object>>
	 */
	public List<Map<String, Object>> queryVipgift(
			Date startdate,Date enddate,String vipgrade,float beginamount,float endamount);
	
	public List<Map<String, Object>> queryVipGrade(long vipgiftid);
	

	/**
	 * 礼品出入库管理
	 * @param story
	 * @return
	 */
	public Vipgiftstoragelog sevaStory(Vipgiftstoragelog story);
	

	/**
	 * 查询礼品出入库明细信息
	 * @param vipgiftname
	 * @param opration
	 * @param createby
	 * @param startdate
	 * @param enddate
	 * @return
	 */
	public List<Map<String, Object>> findStorageDetail(String vipgifname,String opration,long createby,Date startdate,Date enddate);
	

	/**
	 * 查询可供兑换的会员礼品信息
	 * @param name
	 * @param enddate
	 * @param vipgrade
	 * @return
	 */
	public List<Map<String, Object>> queryVipgiftinfo(String name,long vipgrade);
	
	
	/**
	 * 顾客积分兑换
	 * @param exchangelog
	 * @return
	 */
	public Vipgiftexchangelog saveExchangelog(Vipgiftexchangelog exchangelog);
	

	/**
	 * 根据卡号，获取vip卡信息
	 * @param cardno
	 * @return
	 */
	public List<Map<String, Object>> queryVipbyCardno(String cardno);
	
	/**
	 * 积分兑换明细
	 * @param propertyFilterList
	 * @return
	 */
	public List<Map<String, Object>> findExchangelogDetail(List<PropertyFilter> propertyFilterList);
}
