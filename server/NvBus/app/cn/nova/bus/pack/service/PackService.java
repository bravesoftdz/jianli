package cn.nova.bus.pack.service;

import java.text.ParseException;
import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.pack.model.Pack;
import cn.nova.bus.pack.model.PackBalance;
import cn.nova.bus.pack.model.PackIntegraterPay;
import cn.nova.bus.pack.model.Packdepartinvoices;
import cn.nova.bus.security.Global;
import cn.nova.utils.orm.PropertyFilter;

public interface PackService {
	
	public List<Map<String, Object>> query(List<PropertyFilter> propertyFilters);
	public List<Map<String, Object>> queryTotal(Global global,Date startdate,Date enddate,long scheduleid,String isbukai);
	public Pack savePack(Pack pack) throws ServiceException;
	public Pack savePack(Pack pack,PackIntegraterPay packIntegraterPay) throws ServiceException;
	int updatePackStatus(String packids, String status);
	
	/**
	 * 作废
	 * @param pack
	 * @param userid
	 * @return
	 * @throws ServiceException
	 * @throws ParseException 
	 */
	public boolean wastePack(Pack pack,long userid) throws ServiceException; 
	/**
	 * 根据起点站至终点站获取最大里程数 
	 * @param propertyFilters
	 * @return
	 */
	public int queryDistance(List<PropertyFilter> propertyFilters);
	
	
	/**
	 * 根据里程数件数重量查找托运费
	 * @param propertyFilters
	 * @return
	 */
	public Map<String, Float> getShipprice(long orgid,int distance,float weight,long pieces);
	
	/**
	 * 查找班次
	 * @param propertyFilters
	 * @return
	 */
	public List<Map<String, Object>> queryschedule(String param,List<PropertyFilter> propertyFilters);
	
	/**
	 * 查找与登陆站点相关联的站点
	 * @param stationid
	 * @return
	 */
	public List<Map<String, Object>> querystation(String param,long stationid,long routeid);
	
	/**
	 *修改行包领用票据
	 * @param recipients
	 * @param status
	 * @param nextno
	 * @return
	 * @throws ServiceException
	 */
	public boolean updateBillinuse(long recipients,String billtypecode,String status,long nextno,long nextform)throws ServiceException;
	
	
	/**
	 * 重打受理单时新添加一条记录同时把重打的数据改为废弃状态
	 * @param packid
	 * @param userinfoid
	 * @return
	 * @throws ServiceException
	 */
	public Pack whackpack(Pack pack)throws ServiceException;
	
	/**
	 * 查找客户
	 * @param propertyFilters
	 * @return
	 */
	public List<Map<String, Object>> queryclient(String param,List<PropertyFilter> propertyFilters);
	/**
	 * 保存新的行包包装类型到数据字典
	 * @param buildFromHttpRequest
	 * @return
	 */
	public List<Map<String, Object>> saveNewPackType(Global global,String newPackType);
	public Pack savepaymentrecycle(Global global, Pack pack)throws ServiceException;
	/**
	 * 查询出库结算列表
	 * @param packarriverno
	 * @param arriverdate
	 * @param vehicleid
	 * @param status 
	 * @param arriverenddate 
	 * @param ids 
	 * @return
	 */
	public List<Map<String, Object>> qryPackArrive(String packarriverno, Date arriverdate, long vehicleid, String status, Date arriverenddate, String ids);
	
	/**
	 * 保存结算单
	 * @param global
	 * @param packbalance
	 * @return
	 * @throws ServiceException
	 */
	public PackBalance savePackBalance(Global global, PackBalance packbalance) throws ServiceException;
	/**
	 * 查询行包结算单
	 * @param packarriverno
	 * @param senddepartdate
	 * @param sendenddate
	 * @param status
	 * @param ids 
	 * @param vehicleid 
	 * @return
	 */
	public List<Map<String, Object>> qryPackBalance(String departinvoicesno, Date senddepartdate,
			Date sendenddate, String status, String ids, long vehicleid,long orgid);
	/**
	 * 行包转至它站
	 * @param global
	 * @param pack
	 * @return
	 * @throws ServiceException
	 */
	public int transferPack(Global global, Pack pack)throws ServiceException;
	public String qryBalanceByNo(String departinvoicesno, int tflag);
	/**
	 * 行包结算单注销
	 * @param packarriverid
	 * @param tflag 
	 * @param packdepartinvoiceid 
	 * @param global 
	 * @return
	 */
	public boolean canclePackBalance(long packarriverid, int tflag, long packdepartinvoiceid, Global global);
	public List<Map<String, Object>> adjustPackinfo(Global global,Date startdate,Date enddate,long scheduleid);
	/**
	 * 行包已结算查询
	 * @param senddepartdate
	 * @param sendenddate
	 * @param status
	 * @param packbalanceno
	 * @param datatype 
	 * @param unitid 
	 * @return
	 */
	public List<Map<String, Object>> queryPackBalanced(Date senddepartdate, Date sendenddate,
			String status, String packbalanceno, String datatype, String unitid);
	/**
	 * 根据packbalanceid 查询相关明细
	 * @param packbalanceid
	 * @return
	 */
	public List<Map<String, Object>> qryDetail(Long packbalanceid);
	/**
	 * 根据packbalanceid注销结账单
	 * @param packbalanceid
	 * @param global 
	 * @return
	 */
	public boolean cancelPackBalanced(Long packbalanceid, Global global);
	/**
	 * 货物月结算表
	 * @param buildFromHttpRequest
	 * @return
	 */
	public List<Map<String, Object>> qryPackMonthBalance(
			List<PropertyFilter> buildFromHttpRequest);
	/**
	 * 货物日结算表
	 * @param buildFromHttpRequest
	 * @return
	 */
	public List<Map<String, Object>> qryPackDayBalance(List<PropertyFilter> buildFromHttpRequest);
	public Packdepartinvoices qryPackDayBalancequery(
			Packdepartinvoices packdepartinvoices);
	public boolean packDayBalanceaudit(Global global,
			Packdepartinvoices packdepartinvoices);
	
	
}
