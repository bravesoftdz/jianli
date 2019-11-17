package cn.nova.bus.checkticket.service.impl;

import java.math.BigDecimal;
import java.sql.Date;
import java.util.List;
import java.util.Map;

import util.SystemException;
import util.UserTransaction;

import cn.nova.bus.checkticket.dao.DepartinvoicesdetailDao;
import cn.nova.bus.checkticket.model.Departinvoices;
import cn.nova.bus.checkticket.model.Departinvoicesdetail;
import cn.nova.bus.checkticket.model.Departinvoicesother;
import cn.nova.bus.checkticket.model.Departinvoicesotherdetail;
import cn.nova.bus.checkticket.service.DepartinvoiceService;
import cn.nova.bus.checkticket.service.DepartinvoicesdetailService;
import cn.nova.bus.exception.ServiceException;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;

@SuppressWarnings("unchecked")
public class DepartinvoicesdetailServiceImpl implements
		DepartinvoicesdetailService {


	private DepartinvoicesdetailDao dao = new DepartinvoicesdetailDao();
	private UserTransaction usertransaction = new UserTransaction();

	@Override
	public boolean save(Departinvoicesdetail departinvoicesdetail) {
		if (departinvoicesdetail.getId() == 0) {
			return dao.save(departinvoicesdetail);
		} else {
			return dao.update(departinvoicesdetail);
		}
	}

	@Override
	public List<Map<String, Object>> query(
			List<PropertyFilter> propertyFilterList) {
		return ListUtil.listToMap(new Object[] { Departinvoicesdetail.class,
				"fromstationname", "reachstationname", "schedulename",
				"createname", "updatename", "typename", "statusname" },
				dao.query(propertyFilterList), new Object[] {
						Departinvoicesdetail.class, String.class, String.class,
						String.class, String.class, String.class, String.class,
						String.class });
	}

	@Override
	public List<Departinvoicesdetail> getResult(Long departinvoicesid){
		return dao.getResult(departinvoicesid);
	}
	
	@Override
	public Departinvoicesdetail getDepartinvoicesdetail(Long id){
		return (Departinvoicesdetail) dao.get(Departinvoicesdetail.class, id);
	}

	@Override
	public List<Map<String, Object>> qrydeailBydepartinvoicesid(
			long departinvoicesid) {
		// TODO Auto-generated method stub
//		return ListUtil.listToMap(new Object[] { "id","issupply","pid","fromstationid","reachstationid","tickettype","distance","price","ticketnum","totalamount","stationservicefee","fueladditionfee","othterfee","agentfee","balanceamount","scheduleid","departdate","departtime","createtime","createby","updatetime","updateby","balanceprice",
//				"fromstationname", "reachstationname", "schedulename",
//				"createname", "updatename", "typename", "statusname" },dao.qrydeailBydepartinvoicesid(departinvoicesid, iscomputerno)
//                        , new Object[] {
//						long.class,boolean.class,long.class,long.class,long.class,String.class,long.class,BigDecimal.class,long.class,BigDecimal.class,BigDecimal.class,BigDecimal.class,BigDecimal.class,BigDecimal.class,BigDecimal.class,long.class,Date.class,String.class,Date.class,long.class,Date.class,long.class,BigDecimal.class,
//						String.class, String.class,
//						String.class, String.class, String.class, String.class,
//						String.class });
		return ListUtil.listToMap(new Object[] { "id","isselect","departdate","ticketno","price","seatno","departinvoicesid","schedulename",
				 "reachstationname", "typename","fromstationname","fromstationid","reachstationid","tickettype"},dao.qrydeailBydepartinvoicesid(departinvoicesid)
                        , new Object[] {
						long.class,Boolean.class,Date.class,String.class,BigDecimal.class,String.class,long.class,
						String.class, String.class,
						String.class, String.class,long.class,long.class,String.class });
	}

	@Override
	public Long savedetail(Departinvoicesdetail detail) throws ServiceException {
		// TODO Auto-generated method stub
		Departinvoices departinvoices = getDepartinvoicesById(detail.getDepartinvoices().getId());
		try {
			usertransaction.begin();
			detail=(Departinvoicesdetail) dao.merge(detail);
			usertransaction.commit();
		} catch (SystemException e) {
			// TODO Auto-generated catch block
			try {
				usertransaction.rollback();
			} catch (SystemException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			e.printStackTrace();
		}
		
		try {
			usertransaction.begin();
			getpriceinfo(detail, departinvoices);
			dao.merge(departinvoices);
			usertransaction.commit();
		} catch (SystemException e) {
			// TODO Auto-generated catch block
			try {
				usertransaction.rollback();
			} catch (SystemException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			e.printStackTrace();
		}
		
		
		return detail.getId();
	}
	
	public Departinvoices getDepartinvoicesById(Long departinvoicesid) {
		return (Departinvoices) dao.get(Departinvoices.class,
				departinvoicesid);
	}
	
	private void getpriceinfo(Departinvoicesdetail detail,
			Departinvoices departinvoices) {
		
		departinvoices.setTicketnum(dao.getTicketnum(detail.getDepartinvoices().getId()));
		
		departinvoices.setAgentfee(dao.getAgentfee(detail.getDepartinvoices().getId()));		
		
		departinvoices.setTotalamount(dao.getTotalamount(detail.getDepartinvoices().getId()));
		
		departinvoices.setStationservicefee(dao.getStationfee(detail.getDepartinvoices().getId()));
		
		departinvoices.setBalanceamount(dao.getBalanceamount(detail.getDepartinvoices().getId()));
		
		departinvoices.setFueladditionfee(dao.getFueladditionfee(detail.getDepartinvoices().getId()));
		
		departinvoices.setOthterfee(dao.getOtherfee(detail.getDepartinvoices().getId()));
	}
	
}
