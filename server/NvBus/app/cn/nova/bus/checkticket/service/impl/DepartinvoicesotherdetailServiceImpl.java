package cn.nova.bus.checkticket.service.impl;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import util.SystemException;
import util.UserTransaction;
import cn.nova.bus.checkticket.dao.DepartinvoicesotherDao;
import cn.nova.bus.checkticket.dao.DepartinvoicesotherdetailDao;
import cn.nova.bus.checkticket.model.Departinvoicesother;
import cn.nova.bus.checkticket.model.Departinvoicesotherdetail;
import cn.nova.bus.checkticket.service.DepartinvoicesotherService;
import cn.nova.bus.checkticket.service.DepartinvoicesotherdetailService;
import cn.nova.bus.exception.ServiceException;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;

@SuppressWarnings("unchecked")
public class DepartinvoicesotherdetailServiceImpl implements
		DepartinvoicesotherdetailService {

	private DepartinvoicesotherdetailDao dao = new DepartinvoicesotherdetailDao();
	//private UserTransaction usertransaction = new UserTransaction();

	private DepartinvoicesotherService otherService = new DepartinvoicesotherServiceImpl();

	@Override
	public List<Map<String, Object>> query(List<PropertyFilter> propertyFilters) {
		return ListUtil.listToMap(
				new Object[] { "id", "othterfee", "createby", "price", "agentfee", "balanceamount", "departdate",
						"departtime", "ticketnum", "balanceprice", "balanceamount", "stationservicefee", "totalamount",
						"fromstationname", "reachstationname", "ticketname", "scheduleid", "schedulename", "createname",
						"updatename", "statusname", "departinvoicesno", "isoriginator", "uuname", "ufname", "driver1",
						"driver2", "stewardname", "usiname", "qticketnum", "bticketnum", "xticketnum", "apartprice",
						"routename", "distance", "code", "planseatnum", "stationservicefee", "ticketoutletsname",
						"jianpin", "totalamount", "allotherfee", "uuiname", "uuifullname", "vtname", "vbmbrandname",
						"printname", "printtime", "printstation", "pieces", "createtime", "fromstationid",
						"reachstationid", "totaldistance", "seller", "sellername", "vehicleid", "vehicleno", "datafrom",
						"stationfee", "routeid" },
				dao.query(propertyFilters),
				new Object[] { Long.class, BigDecimal.class, Long.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, Date.class, String.class, Integer.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, String.class, String.class, String.class, Long.class,
						String.class, String.class, String.class, String.class, String.class, boolean.class,
						String.class, String.class, String.class, String.class, String.class, String.class,
						Integer.class, Integer.class, Integer.class, BigDecimal.class, String.class, Long.class,
						String.class, Integer.class, BigDecimal.class, String.class, String.class, BigDecimal.class,
						BigDecimal.class, String.class, String.class, String.class, String.class, String.class,
						String.class, String.class, Integer.class, String.class, Long.class, Long.class, Long.class,
						Long.class, String.class, Long.class, String.class, String.class, BigDecimal.class,
						Long.class });
		
//				dao.query(propertyFilters), new Object[] { Long.class,
//			BigDecimal.class, long.class, BigDecimal.class, BigDecimal.class,
//			BigDecimal.class, Date.class, String.class, long.class,
//			BigDecimal.class, BigDecimal.class, BigDecimal.class, BigDecimal.class,
//						String.class, String.class, String.class, String.class,
//						String.class, String.class, String.class, String.class,
//						boolean.class, String.class, String.class,
//						String.class, String.class, String.class, String.class,
//						String.class, String.class, String.class, String.class,
//						String.class, String.class, String.class, String.class,
//						String.class, String.class, String.class, BigDecimal.class,
//						BigDecimal.class, String.class, String.class, String.class,
//						String.class, String.class, String.class, String.class,
//						Long.class, String.class, Long.class, Long.class,
//						Long.class });
	}

	@Override
	public Long save(Departinvoicesotherdetail detail) throws ServiceException {
		Departinvoicesother departinvoicesother = otherService.getById(detail
				.getDepartinvoicesotherid());
		if ("2".equals(departinvoicesother.getStatus())) {
			throw new ServiceException("0391");
		}

		int distance = dao.getDepartinvoicesOtherDistance(detail.getSchedule()
				.getId(), detail.getReachstationid());

		detail.setDistance(distance);

		if (detail.getId() == 0) {
			detail.setStatus(departinvoicesother.getStatus());
			if (detail.getSchedule().getId() == 0) {
				detail.setSchedule(null);
			}
			detail = (Departinvoicesotherdetail) dao.merge(detail);
			getpriceinfo(detail, departinvoicesother);// 得到对应的票价、站务费等信息
			dao.merge(departinvoicesother);
		} else {
			detail.setStatus(departinvoicesother.getStatus());
			detail = (Departinvoicesotherdetail) dao.merge(detail);
			getpriceinfo(detail, departinvoicesother);
			dao.merge(departinvoicesother);
		}
		return detail.getId();
	}

	private void getpriceinfo(Departinvoicesotherdetail detail,
			Departinvoicesother departinvoicesother) {

		departinvoicesother.setAgentfee(dao.getAgentfee(detail
				.getDepartinvoicesotherid()));

		departinvoicesother.setTicketnum(dao.getTicketnum(detail
				.getDepartinvoicesotherid()));

		departinvoicesother.setTotalmoney(dao.getTotalamount(detail
				.getDepartinvoicesotherid()));

		departinvoicesother.setStationfee(dao.getStationfee(detail
				.getDepartinvoicesotherid()));

		departinvoicesother.setBalancemoney(dao.getBalanceamount(detail
				.getDepartinvoicesotherid()));
	}

	@Override
	public boolean delete(long id) throws ServiceException {
		Departinvoicesotherdetail detail = (Departinvoicesotherdetail) dao.get(
				Departinvoicesotherdetail.class, id);
		if ("2".equals(detail.getStatus())) {
			throw new ServiceException("0391");
		}
		Departinvoicesother departinvoicesother = otherService.getById(detail
				.getDepartinvoicesotherid());
		departinvoicesother.setAgentfee(departinvoicesother.getAgentfee().subtract(detail.getAgentfee()));
		departinvoicesother.setTicketnum(departinvoicesother.getTicketnum()-detail.getTicketnum());
		departinvoicesother.setTotalmoney(departinvoicesother.getTotalmoney().subtract(detail.getTotalamount()));
		departinvoicesother.setStationfee(departinvoicesother.getStationfee().subtract(detail.getStationservicefee()));
		departinvoicesother.setBalancemoney(departinvoicesother.getBalancemoney().subtract(detail.getBalanceamount()));
		departinvoicesother.setOthterfee(departinvoicesother.getOthterfee().subtract(detail.getOthterfee()));
		dao.merge(departinvoicesother);
		dao.delete(Departinvoicesotherdetail.class, id);
		return true;
	}
	/**
	 * @Title ticketnoDelete
	 * @Description 结算单补录票号 删除明细数据
	 * @param id
	 * @return
	 * @throws ServiceException 
	 * boolean 
	 * @author tianhb
	 * @date 2016年6月29日-上午8:49:48
	 * @update 
	 * @throws
	 */
	public Integer ticketnoDelete(long departinvoicesotherdetailId,long departinvoicesotherId) throws ServiceException {
		Departinvoicesother other = (Departinvoicesother) dao.get(Departinvoicesother.class, departinvoicesotherId);
		Departinvoicesotherdetail detail = (Departinvoicesotherdetail) dao.get(Departinvoicesotherdetail.class, departinvoicesotherdetailId);
		otherService.deletedepartinvoicesotherTicketno(departinvoicesotherdetailId);
		List tsoldids = null;
		boolean flag =  dao.delete(Departinvoicesotherdetail.class, departinvoicesotherdetailId);
		if(flag){
			tsoldids = qryTicketsellidByOtherdetailid(departinvoicesotherdetailId);
			otherService.deleteDepartinvoicesothersellByotherid(departinvoicesotherdetailId);
			otherService.updateTicketCheckstatusById(tsoldids);
			if(other.getTicketnum() > detail.getTicketnum()){
				other.setAgentfee(other.getAgentfee().subtract(detail.getAgentfee()));
				other.setTicketnum(other.getTicketnum() - detail.getTicketnum());
				other.setOthterfee(other.getOthterfee().subtract(detail.getOthterfee()));
				other.setStationfee(other.getStationfee().subtract(detail.getStationservicefee()));
				other.setBalancemoney(other.getTotalmoney().subtract(detail.getBalanceamount().subtract(detail.getStationservicefee()).subtract(detail.getOthterfee()).subtract(detail.getAgentfee())));
				dao.merge(other);
				return 1;
			}else{
				dao.delete(Departinvoicesother.class, departinvoicesotherId);
				return 2;
			}
		}else{
			return 0;
		}
	}

	@Override
	public List<Map<String, Object>> queryByotherticketno(List<PropertyFilter> buildFromHttpRequest) {
		return ListUtil.listToMap(new Object[] { "id", "departinvoicesotherdetailid","departinvoicesno", 
				"vehicleid","vehicleno","reachstationid","reachstationname",
				"seller","sellername","scheduleid","schedulename","departdate", "departtime", 
				"ticketnum","price","agentfee","stationfee","othterfee","datafrom","balanceamount"},
				dao.queryByotherticketno(buildFromHttpRequest), new Object[] {
						Long.class,Long.class,String.class,Long.class,String.class,Long.class,String.class,
						Long.class,String.class,Long.class,String.class,Date.class,String.class,
						Long.class,BigDecimal.class,BigDecimal.class,BigDecimal.class,BigDecimal.class,String.class,BigDecimal.class});
	}

	private List qryTicketsellidByOtherdetailid(Long departinvoicesotherdetailId){
		return dao.qryTicketsellidByOtherdetailid(departinvoicesotherdetailId);
	}

}
