package cn.nova.bus.pack.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.pack.model.Packdepartinvoices;
import cn.nova.bus.pack.model.Packtturnover;
import cn.nova.bus.pack.vo.PackDeparVO;
import cn.nova.bus.pack.vo.PacktturnoverVO;
import cn.nova.bus.security.Global;
import cn.nova.utils.orm.PropertyFilter;

public interface PacktturnoverService {
	public List<Map<String, Object>> query(String orgid,Long userid,Date fromdate,Date enddate);
	
	public List<Map<String, Object>> queryRevenueOfDay(String packdatafrom,List<PropertyFilter> propertyFilter);
	
	public Packtturnover savePacktturnover(Packtturnover packtturnover,String pactturnoverdetailid) throws ServiceException;
	
	public Packtturnover auditPacktturnover(Global global,String pactturnoverdetailid) throws ServiceException;
	
	public Map<String,Object> queryTicketErrorReport(
			List<PropertyFilter> propertyFilter,int querytype,String packdatafrom);
	
	public List<Map<String, Object>> qryPacktturnoverinfo(long packtturndetailid);

	public List<Map<String, Object>> packManualMakeup(
			List<PropertyFilter> buildFromHttpRequest);

	public List<Map<String, Object>> findpackAndDepinfo(String packno);
	
	public boolean packManualsave(Global global,PackDeparVO packDeparvo) throws ServiceException;

	public boolean packManualdel(Packdepartinvoices packdepartinvoices);
	public List<Map<String, Object>> findpackedepartinvoiceAndDepinfo(
			String packdepartinvoicesno);
	
}
