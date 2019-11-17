package cn.nova.bus.price.service;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.price.model.Ticketpriceformula;
import cn.nova.bus.price.model.Ticketpriceformulaitem;
import cn.nova.utils.orm.PropertyFilter;

public interface TicketpriceformulaService {
	public List<Map<String, Object>> query(
			List<PropertyFilter> propertyFilterList);

	public List<Map<String, Object>> queryitem(String orgids);

	public boolean saveTicketpriceformula(Ticketpriceformula ticketpriceformula)
			throws ServiceException;

	public boolean delTicketpriceformula(Ticketpriceformula ticketpriceformula)
			throws ServiceException;

	public List<Map<String, Object>> generateTicketprice(Long orgid,Date departdate,Long createby);
	//根据票种编码以及全票票价等信息计算该票种的票价
	public BigDecimal getPrice(long scheduleid,Date departDate,String code,BigDecimal fullprice);	
	
	public boolean genPrice(Date departdate, Long orgid, Long routeid,
			Long scheduleid, Long vehicletypeid, Long createby) throws ServiceException;	
	//生成公式票价成功,
	public boolean genPrice(Long orgid, Long routeid,
			Long scheduleid, Long vehicletypeid, Long createby) throws ServiceException;		
	
	
	public BigDecimal executeFormula(long orgid, long vehicletypeid,
			long routeid, long scheduleid, long departstationid,
			long reachstationid, int distance, String ticketpriceformula,List<Ticketpriceformulaitem> ticketpriceformulaitemlist)
			throws ServiceException ;
}
