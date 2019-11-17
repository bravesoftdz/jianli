package cn.nova.bus.checkticket.service.impl;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import cn.nova.bus.balance.model.Balancedeductdetail;
import cn.nova.bus.base.model.Route;
import cn.nova.bus.base.model.Schedule;
import cn.nova.bus.base.model.Station;
import cn.nova.bus.base.model.Ticketoutlets;
import cn.nova.bus.base.model.Tickettype;
import cn.nova.bus.base.model.Unit;
import cn.nova.bus.base.model.Vehicle;
import cn.nova.bus.base.model.Vehiclebrandmodel;
import cn.nova.bus.base.model.Vehicletype;
import cn.nova.bus.bill.model.Billinuse;
import cn.nova.bus.bill.model.Billtype;
import cn.nova.bus.bill.service.BillinuseService;
import cn.nova.bus.bill.service.BilltypeService;
import cn.nova.bus.bill.service.impl.BillinuseServiceImpl;
import cn.nova.bus.bill.service.impl.BilltypeServiceImpl;
import cn.nova.bus.checkticket.dao.DepartinvoicesManagerDao;
import cn.nova.bus.checkticket.dao.PackDepartinvoicesDao;
import cn.nova.bus.checkticket.model.Departinvoices;
import cn.nova.bus.checkticket.model.Departinvoicesdeductdetail;
import cn.nova.bus.checkticket.model.Departinvoicesdetail;
import cn.nova.bus.checkticket.model.Departinvoicesother;
import cn.nova.bus.checkticket.model.Departinvoicesotherdetail;
//import cn.nova.bus.checkticket.model.Departinvoicesothersell;
import cn.nova.bus.checkticket.service.DepartinvoiceService;
import cn.nova.bus.checkticket.service.DepartinvoicesManagerService;
import cn.nova.bus.checkticket.service.PackDepartinvoicesService;
import cn.nova.bus.checkticket.vo.DepartinvoicesVo;
import cn.nova.bus.common.ConstDefiniens;
import cn.nova.bus.common.ParamterConst;
import cn.nova.bus.dispatch.model.Vehiclereport;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.pack.dao.PackdepartinvoicespackDao;
import cn.nova.bus.pack.model.Packdepartinvoices;
import cn.nova.bus.price.model.Routeprice;
import cn.nova.bus.price.model.Scheduleplan;
import cn.nova.bus.price.model.Scheduleseats;
import cn.nova.bus.price.model.Schedulestatus;
import cn.nova.bus.price.model.Ticketprice;
import cn.nova.bus.sale.dao.TicketDao;
import cn.nova.bus.sale.model.RemoteTicketsell;
import cn.nova.bus.sale.model.Ticketsell;
import cn.nova.bus.security.Global;
import cn.nova.bus.system.model.Organization;
import cn.nova.bus.system.model.Userinfo;
import cn.nova.bus.system.service.ParameterService;
import cn.nova.bus.system.service.impl.ParameterServiceImpl;
import cn.nova.utils.commons.DateUtils;
import cn.nova.utils.commons.StringUtils;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;

@SuppressWarnings("unchecked")
public class PackDepartinvoicesServiceImpl implements PackDepartinvoicesService {
	
	private PackDepartinvoicesDao departinvoicesManagerDao = new PackDepartinvoicesDao();
	
	private ParameterService parameterService = new ParameterServiceImpl();
	
	private PackdepartinvoicespackDao packdeppackdao = new PackdepartinvoicespackDao();
	/**
	 * 查询行包结算单信息
	 */
	@Override
	public List<Map<String, Object>> query(
			List<PropertyFilter> propertyFilterList) {
		return ListUtil
				.listToMap(new Object[] { "id","departinvoicesno","scheduleplanid","departdate","scheduleid",
						"departtime","vehicleid","reportid","printorgid","printip",
						"printby","printtime","pieces","shipprice","packfee",
						"handfee","custodial","transitfee","insuredamount","insurancefee",
						"deliveryfee","otherfee","packprice","servicefee","totalfee",
						"balanceamount","cancelstationid","cancelby","canceltime","status",
						"packbalanceid","printway","datatype","createtime","createby",
						"updatetime","updateby",
						"schedulename","statusname", "vehiclename","reportname", "orgname", 
						"printname","createname", "updatename","cancelname", "cancelstationname", 
						"routename","endstationname", "seatnum", "unitname","printwayname","datatypename","vehicletypename","startstationname" },
						departinvoicesManagerDao.query(propertyFilterList),
						new Object[] { 
                        long.class,String.class,long.class,Date.class,long.class,
					    String.class,long.class,long.class,long.class,String.class,
					    long.class,Timestamp.class,short.class,BigDecimal.class,BigDecimal.class,
					    BigDecimal.class,BigDecimal.class,BigDecimal.class,BigDecimal.class,BigDecimal.class,
					    BigDecimal.class,BigDecimal.class,BigDecimal.class,BigDecimal.class,BigDecimal.class,
					    BigDecimal.class,long.class,long.class,Timestamp.class,String.class,
					    long.class,String.class,String.class,Timestamp.class,long.class,
					    Timestamp.class,long.class,
					String.class,String.class, String.class, String.class,String.class, 
					String.class, String.class,String.class, String.class, String.class,
					String.class, String.class, Short.class,String.class,String.class,String.class,String.class,String.class });
	}

	@Override
	public Packdepartinvoices getById(long id) {
		// TODO Auto-generated method stub
		return (Packdepartinvoices) departinvoicesManagerDao.get(
				Packdepartinvoices.class, id);
	}

	@Override
	public boolean cancel(Packdepartinvoices departinvoices)
			throws ServiceException {
		// TODO Auto-generated method stub
		
		Packdepartinvoices dd = (Packdepartinvoices) departinvoicesManagerDao.get(
				Packdepartinvoices.class, departinvoices.getId());
		int limitday = new Integer(parameterService.findParamValue(ParamterConst.Param_3042,  
				dd.getPrintorgid()));
		if (DateUtils.getIntervalDays(dd.getDepartdate(), new Date()) >= limitday) {
			// 已超过注销结算单天数
			throw new ServiceException("0368");
		}
		
		packdeppackdao.deletePackdepartPack(departinvoices.getId());  //删除行包结算单与行包关系表中的数据
		
		return departinvoicesManagerDao.update(departinvoices);
		
	}

	@Override
	public List<Map<String, Object>> qryDepartDetail(
			List<PropertyFilter> propertyList) {
		// TODO Auto-generated method stub
		return ListUtil.listToMap(
				new Object[]{"fromstationname","reachstationname","pieces","shipprice","packfee",
				"handfee","custodial","transitfee","insuredamount","insurancefee",
				"deliveryfee","otherfee","packprice","servicefee","totalfee",
				"balanceamount"}, 
				departinvoicesManagerDao.qryDepartDetail(propertyList),
				new Object[]{String.class,String.class,short.class,BigDecimal.class,BigDecimal.class,
					BigDecimal.class,BigDecimal.class,BigDecimal.class,BigDecimal.class,BigDecimal.class,
					BigDecimal.class,BigDecimal.class,BigDecimal.class,BigDecimal.class,BigDecimal.class,
					BigDecimal.class});
	}

	@Override
	public List<Map<String, Object>> FindPackDepNum(Date departdate,
			long scheduleplanid, long scheduleid) {
		// TODO Auto-generated method stub
		
		return ListUtil.listToMap(
				new Object[]{"yesfaban","nofaban"}, 
				departinvoicesManagerDao.FindPackDepNum(departdate,scheduleplanid,scheduleid),
				new Object[]{short.class,short.class});
		
	}

}
