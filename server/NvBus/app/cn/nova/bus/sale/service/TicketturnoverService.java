package cn.nova.bus.sale.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.sale.model.Ticketturnover;
import cn.nova.bus.security.Global;
import cn.nova.utils.orm.PropertyFilter;

public interface TicketturnoverService {

	public Ticketturnover save(Ticketturnover ticketticnover,
			String ticketdetail, String insuredetail) throws ServiceException;

	public boolean delete(long id);

	/**
	 * 查询售票员已缴款信息，用来重打缴款单
	 * @param propertyFilter
	 * @return
	 */
	public List<Map<String, Object>> query(List<PropertyFilter> propertyFilter,Global global);
	/**
	 * 查询日营收数据
	 * @param propertyFilter
	 * @return
	 */
	public List<Map<String, Object>> queryRevenueOfDay(Long billtypeid,List<PropertyFilter> propertyFilter);

	public Ticketturnover getById(long id);

	public List<Map<String, Object>> queryTicketturnover(long id,
			String returnticketno, String cancelticketno,
			String damagedticketno, String returninsureno,
			String cancelinsureno, String damagedinsureno);

	public List<Map<String, Object>> queryTurnover(long seller);

	/**
	 * 根据缴款ID，获取缴款的信息，用来打印缴款单
	 * @param ticketturnoverid
	 * @return
	 */
	public List<Map<String, Object>> queryTicketturnover(Long ticketturnoverid);

	/**
	 * 根据缴款ID，获取缴款员实缴金额
	 * @param buildFromHttpRequest
	 * @return
	 */
	public List<Map<String, Object>> queryTurnoverMoney(
			List<PropertyFilter> buildFromHttpRequest);

	/**
	 * 售票员解款情况查询
	 * @param moneydate
	 * @param seller
	 * @return
	 */
	public List<Map<String, Object>> queryTicketseller(Date moneydate,
			long seller);
	/**
	 * 查询缴款明细的退票和废票记录
	 */
	public List<Map<String, Object>> queryticketturnoverReturnAndCancel(Long ticketturnoverid);
	
	/**
	 * 查询未缴款营收或已缴款营收的  退票/废票  票号和金额
	 * @param buildFromHttpRequest：包含多个或单个ticketturnoverdeatilid和是否已缴款isturnover
	 * 此类似于上面的方法，上面的方法只能查询  某个tickturnover 对应的记录
	 * @return
	 */
	public List<Map<String, Object>> qryRtnCelByTktoverDetails(List<PropertyFilter> buildFromHttpRequest);

	/**
	 * 查询保险明细
	 */
	public List<Map<String, Object>> queryinsurenceturnover(Long ticketturnoverid);

	public List<Map<String, Object>> queryinsurenceturnoverReturnAndCancel(Long ticketturnoverid);

	public List<Map<String, Object>> qryRtnCelByIstoverDetails(List<PropertyFilter> buildFromHttpRequest);
	
	/**
	 * 取消缴款功能
	 * @param turnoverid
	 * @param seller
	 * @param global
	 * @return
	 */
	public Boolean cancelTurnover(String turnoverid,Global global);

	public Ticketturnover saveTicketturnover(Ticketturnover ticketturnover,
			String ticketdetail, String insuredetail) throws ServiceException;
	
	/**
	 * 缴款之后查询网售取票张数和金额
	 * turnover/queryWebTakedInfo
	 * @return
	 */
	public List<Map<String, Object>> queryWebTakedInfo(List<PropertyFilter> propertyFilter);
	
	/**
	 * 根据缴款id 查询电子退票相关的打印数据源
	 * @return
	 */
	public List<Map<String, Object>> qryReturnMoney(String ticketturnoverids);
	
	/**
	 * 营收缴款打印模板增加打印项【网售票价】、【网售张数】和【网售金额】打印数据集，并且按照票价分组
	 * @param id
	 * @return
	 */
	public List<Map<String, Object>> queryWebInfoGroup(long id);
}
