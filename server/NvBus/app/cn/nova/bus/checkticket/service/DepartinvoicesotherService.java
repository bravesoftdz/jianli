package cn.nova.bus.checkticket.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.checkticket.model.Departinvoicesother;
import cn.nova.bus.exception.ServiceException;
import cn.nova.utils.orm.PropertyFilter;

public interface DepartinvoicesotherService {
	
	//售票员手工单营收汇总表
	public List<Map<String, Object>> querySum(
			List<PropertyFilter> buildFromHttpRequest);

	public List<Map<String, Object>> query(
			List<PropertyFilter> buildFromHttpRequest);

	public Departinvoicesother save(Departinvoicesother departinvoicesother) throws ServiceException;

	public Departinvoicesother getById(Long departinvoicesotherid);

	public boolean delete(long id) throws ServiceException;

	//根据结算车辆获取该车辆的回程结算信息
	//vehicleids参数如：(12,45)
	public List<Departinvoicesother> getInvoicesotherBalance(long balanceunitid);
	
	public List<Departinvoicesother> qryInvoicesotherBalance(String vehicleids);
	
	
	public List<Map<String, Object>> qrySchHelp(Date departdate,String schcode);
	
	public List<Map<String, Object>> qryUnitHelp(long id);
	
	public boolean audit(String departinvoiceid);  //手工单审核
	
	public boolean cancelaudit(String departinvoiceid); //手工单取消审核
	
	/**
	 * 查询  结算单补录（精简）
	 * @param propertyFilterList
	 * @return
	 */
	public List<Map<String, Object>> queryDepartinvoicesotherSimple(List<PropertyFilter> propertyFilterList);
	
	/**
	 * 保存  结算单补录（精简）
	 * @param routeid
	 * @param departinvoicesother
	 * @return
	 */
	public Departinvoicesother saveSimple(Long routeid, Departinvoicesother departinvoicesother) throws ServiceException;
	
	/**
	 * 删除  结算单补录（精简）
	 * @param id
	 * @return
	 * @throws ServiceException
	 */
	public boolean deletedepartinvoicesotherSimple(long id) throws ServiceException;

	public List<Map<String, Object>> departinvoiceisexsit(String departinvoiceno) throws ServiceException;
	
	/**
	 * 查询  结算单补录（票号）
	 * @param propertyFilterList
	 * @return
	 */
	public List<Map<String, Object>> queryDepartinvoicesotherTicketno(List<PropertyFilter> propertyFilterList);
	
	/**
	 * @Title saveTicketno
	 * @Description 保存 结算单补录（票号）
	 * @param departinvoicesother
	 * @param ticketsellids
	 * @return
	 * @throws ServiceException 
	 * Departinvoicesother 
	 * @author tianhb
	 * @date 2016年6月14日-上午9:24:06
	 * @update 
	 * @throws
	 */
	public Departinvoicesother saveTicketno(Departinvoicesother departinvoicesother,String ticketsellids) throws ServiceException;
	
	/**
	 * 删除 结算单补录（票号）
	 * @param id
	 * @return
	 * @throws ServiceException
	 */
	public boolean deletedepartinvoicesotherTicketno(long id) throws ServiceException;
	/**
	 * @Title updateTicketCheckstatusById
	 * @param tsoldids2 
	 * void 
	 * @author tianhb
	 * @date 2016年6月28日-下午7:07:36
	 * @update 
	 * @throws
	 */
	public void updateTicketCheckstatusById(List tsoldids);
	/**
	 * @return 
	 * @Title qryTicketsellidByOtherid
	 * @Description 根据结算单补录 ID 查询车票ID
	 * @param departinvoicesotherdetailid 
	 * void 
	 * @author tianhb
	 * @date 2016年6月28日-下午3:16:16
	 * @update 
	 * @throws
	 */
	public List qryTicketsellidByOtherid(Long otherid);
	/**
	 * @Title qryTicketsellidByOtherdetailid
	 * @Description 根据结算单补录明细 ID 查询车票ID
	 * @param otherdetailid
	 * @return List 
	 * @author tianhb
	 * @date 2016年6月28日-下午7:03:37
	 * @update 
	 * @throws
	 */
	public List qryTicketsellidByOtherdetailid(Long otherdetailid);
	/**
	 * @Title deleteDepartinvoicesothersellByDepartinvoicesotherid
	 * @Description 根据 它站运量单明细 ID 删除 关联表数据
	 * @param departinvoicesotherid 
	 * void 
	 * @author tianhb
	 * @date 2016年6月14日-上午9:34:49
	 * @update 
	 * @throws
	 */
	public void deleteDepartinvoicesothersellByotherid(Long departinvoicesotherid);
	
	public void deleteDepartinvoicesothersellByDetailid(Long departinvoicesotherdetailid);

	public void deleteByticketidAndDepartinvoicesdeatilid(Long departinvoicesotherid);

	public List<Map<String,Object>> checkdepartinvoicesell(Long departinvoicesotherid);
}
