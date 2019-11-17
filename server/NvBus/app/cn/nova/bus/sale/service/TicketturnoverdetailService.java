package cn.nova.bus.sale.service;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import cn.nova.bus.sale.model.Ticketturnoverdetail;
import cn.nova.bus.sale.model.Ticketturnoverdetailepay;
import cn.nova.bus.security.Global;
import cn.nova.utils.orm.PropertyFilter;

public interface TicketturnoverdetailService {

	public Ticketturnoverdetail getTicketturnoverdetail(Long ticketturnoverid,
			long startno);

	public boolean save(Ticketturnoverdetail detail);

	public long getMaxid();

	/**
	 * 查询车票票款缴款明细
	 * @param buildFromHttpRequest
	 * @param seller 
	 * @return
	 */
	public List<Map<String, Object>> query(
			List<PropertyFilter> buildFromHttpRequest, long seller, Global global);

	public Ticketturnoverdetail getById(long id);

	/**
	 * 查询车票票款对应的退票数
	 * @param buildFromHttpRequest
	 * @return
	 */
	public List<Map<String, Object>> queryReturnTicketno(
			List<PropertyFilter> buildFromHttpRequest);

	/**
	 * 查询车票票款对应的坏票登记数
	 * @param buildFromHttpRequest
	 * @return
	 */
	public List<Map<String, Object>> queryBillTicketno(
			List<PropertyFilter> buildFromHttpRequest);

	/**
	 * 查询车票票款对应的废票数
	 * @param buildFromHttpRequest
	 * @return
	 */
	public List<Map<String, Object>> queryCancelTicketno(
			List<PropertyFilter> buildFromHttpRequest);

	/**
	 * 按用户取出当前应缴款明细记录
	 * @param sellerid  用户id
	 * @param startvoucherno 当前业务使用的票证号，可为空
	 * @return 用户出当前应缴款明细记录
	 */
	public Ticketturnoverdetail getCurTicketturnoverdetail(long sellerid,String startvoucherno);
	
	//查询当前用户的未缴款金额
	public BigDecimal qryNoTicketturnoverPrice(long sellerid);
	
	
	/**
	 * 统计某日,月票款明细信息，用来打营收表 
	 * @param propertyFilterList
	 * @return
	 */
	public List<Map<String, Object>> queryTicketRevenue(List<PropertyFilter> propertyFilterList);
	
	public String qrylastlostmoney(long seller);
	/**
	 * 获取当前用户营收明细电子表信息
	 * @param ticketturnoverdetail
	 * @param id
	 * @param payMethod 
	 * @return
	 */
	public Ticketturnoverdetailepay getCurTicketturnoverdetailepay(
			Ticketturnoverdetail ticketturnoverdetail, long id, String payMethod);

	/**
	 * 获取营收支付信息
	 * @param buildFromHttpRequest
	 * @return
	 */
	public List<Map<String, Object>> qryticketturnoverdetailEPay(
			List<PropertyFilter> buildFromHttpRequest);

	public List<Ticketturnoverdetail> getByIds(String[] ids);

	public List<Map<String, Object>> queryDetailBalanceAllow(String ticketturnoverdetailids, String ticketturnoverids);
}
