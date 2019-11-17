package cn.nova.bus.price.service;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.price.model.Handprice;
import cn.nova.bus.price.model.Routeprice;
import cn.nova.bus.price.model.Ticketoutletstypeprice;
import cn.nova.bus.security.Global;
import cn.nova.utils.commons.MethodResult;
import cn.nova.utils.orm.PropertyFilter;

public interface RoutepriceService {

	//查询线路票价
	public List<Map<String, Object>> qryRouteprice(long routeid) throws ServiceException;
	
	//查询线路票价
	public List<Map<String, Object>> qryRoutepriceedt(long routeid) throws ServiceException;
	
	//保存线路票价
	public List<Map<String, Object>> save(List<Routeprice> routepricelist, Global global) throws ServiceException;
	
	//删除线路票价
	public boolean delRouteprice(String ids) throws ServiceException;

	//保存线路票价
	public Long add(Routeprice routeprice, Global global) throws ServiceException;
	
	public List<Map<String, Object>> qryRoutestops(long routeid,boolean isdepart) throws ServiceException;

	public List<Map<String, Object>> qryRoutepriceOrHardprice(long routeid,
			long scheduleid, Global global,String departdate) throws ServiceException;

	public List<Map<String, Object>> saveall(List<Routeprice> routepricelist,boolean savestandprice, Global global);
	
	
	/**
	 * 根据1042参数的规则，计算相应的票价
	 * @param pricerule  1042参数规则
	 * @param price   需要处理的票价
	 * @return   返回按规则处理之后的票价
	 */
	public BigDecimal mathPriceByRule(String pricerule,BigDecimal price);

	public List<Map<String, Object>> qryTicketoutletstypeprice(List<PropertyFilter> buildFromHttpRequest);

	public MethodResult saveTicketoutletstypeprice(Ticketoutletstypeprice ttp, String ticketoutletsids,
			String scheduleids);

	public boolean deleteTicketoutletstypeprice(String id);

}
