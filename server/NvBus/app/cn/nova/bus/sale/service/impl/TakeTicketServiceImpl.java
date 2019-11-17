/**
 * 
 */
package cn.nova.bus.sale.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import util.CurrentUtil;
import util.SystemException;
import util.UserTransaction;

import cn.nova.bus.base.model.Schedule;
import cn.nova.bus.base.model.Station;
import cn.nova.bus.bill.dao.BillinuseDao;
import cn.nova.bus.bill.model.Billinuse;
import cn.nova.bus.bill.model.Billinventory;
import cn.nova.bus.bill.service.BillinuseService;
import cn.nova.bus.bill.service.impl.BillinuseServiceImpl;
import cn.nova.bus.common.ParamterConst;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.exception.BusinessException;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.sale.dao.TicketsellotherDao;
import cn.nova.bus.sale.model.NetOrgTakeSetting;
import cn.nova.bus.sale.model.Taketicketlog;
import cn.nova.bus.sale.model.TicketMixChange;
import cn.nova.bus.sale.model.Ticketsell;
import cn.nova.bus.sale.model.Ticketsellother;
import cn.nova.bus.sale.model.Ticketturnoverdetail;
import cn.nova.bus.sale.service.TakeTicketService;
import cn.nova.bus.sale.service.TicketturnoverdetailService;
import cn.nova.bus.system.model.Organization;
import cn.nova.bus.system.service.ParameterService;
import cn.nova.bus.system.service.impl.ParameterServiceImpl;
import cn.nova.utils.commons.DateUtils;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.IDAO;

/**
 * @author Administrator
 *
 */
public class TakeTicketServiceImpl implements TakeTicketService {
	

	private TicketsellotherDao ticketsellotherDao = new TicketsellotherDao();

	private ParameterService parameterService = new ParameterServiceImpl();

	private TicketturnoverdetailService ticketturnoverdetailService = new TicketturnoverdetailServiceImpl();

	private IDAO dao = new EntityManagerDaoSurport();
	private BillinuseService billinuseService = new BillinuseServiceImpl();
	
	private UserTransaction userTransaction = new UserTransaction();

	public List<Map<String,Object>> findETicketInfo(String eticketno,String epassword){
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		Taketicketlog ttl = new Taketicketlog();
		Date now = new Date();
		if(eticketno!=null&&!"".equals(eticketno)){
			ttl.setTicketno(eticketno);
			propertyFilters.add(new PropertyFilter("EQS_tso!eticketno", eticketno));
		}
		else{
			ttl.setPassword(epassword);
			propertyFilters.add(new PropertyFilter("EQS_tso!password", epassword));
		}
		Integer p1085 = 7;
		// 取票天数
		try {
			p1085 = Math.abs(Integer.parseInt(parameterService.findParamValue(ParamterConst.Param_1085,
					CurrentUtil.getGlobal().getOrganization().getId())));
		} catch (Exception e) {
			play.Logger.info("获取参数1085失败，请检查！ 异常信息：" + e.getMessage());
			p1085 = 7;
		}
		propertyFilters.add(new PropertyFilter("GED_ts!departdate", DateUtils.trunc(DateUtils.add(new Date(), -1*p1085))));
		list = ticketsellotherDao.findETicketInfoAndMixChange(propertyFilters);
		if(list.size()<=1){
			list = ticketsellotherDao.findETicketInfo(propertyFilters);
		}
		if(list.size()<=1){
			ttl.setTaketime(now);
			ttl.setTakeway("1");
			ttl.setStatus("失败");
			ttl.setOperatorname(CurrentUtil.getGlobal().getUserinfo().getName());
			ttl.setOperatorgname(CurrentUtil.getGlobal().getOrganization().getName());
			ttl.setTicketoutletsname(CurrentUtil.getGlobal().getTicketoutlets().getName());
			ttl.setTakecompute(CurrentUtil.getGlobal().getIpAddress());
			ttl.setCreateby(CurrentUtil.getGlobal().getUserinfo().getId());
			ttl.setCreatetime(now);
			ttl.setUpdateby(CurrentUtil.getGlobal().getUserinfo().getId());
			ttl.setUpdatetime(now);
			ttl.setRemark("未查询到对应票");
			dao.merge(ttl);
		}
		return list;
	}
	
	public List<Map<String,Object>> findETicketInfoByCustomer(String idcardno,String orderno,String telno){
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		Taketicketlog ttl = new Taketicketlog();
		Date now = new Date();
		String remark = "";
		Integer p1085 = 7;
		// 取票天数
		try {
			p1085 = Math.abs(Integer.parseInt(parameterService.findParamValue(ParamterConst.Param_1085,
					CurrentUtil.getGlobal().getOrganization().getId())));
		} catch (Exception e) {
			play.Logger.info("获取参数1085失败，请检查！ 异常信息：" + e.getMessage());
			p1085 = 7;
		}
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		if(idcardno!=null&&!"".equals(idcardno)){
			ttl.setCertificateno(idcardno);
			remark =idcardno;
			list = ticketsellotherDao.findETicketInfoByCustomeridcardno(DateUtils.trunc(DateUtils.add(new Date(), p1085*-1)),idcardno);
		}
		else{
			ttl.setMobilephone(telno);
			ttl.setOrderno(orderno);
			remark=(telno==""||telno==null ? "":"电话"+telno) + 
					(orderno==""||orderno==null ? "":"订单号"+orderno);
			propertyFilters.add(new PropertyFilter("EQS_cu!mobilephone", telno));
			propertyFilters.add(new PropertyFilter("EQS_tso!orderno", orderno));
			propertyFilters.add(new PropertyFilter("GED_ts!departdate", DateUtils.trunc(DateUtils.add(new Date(), p1085*-1))));
			list = ticketsellotherDao.findETicketInfoByCustomer(propertyFilters);
		}
		if(list.size()<=1){
			ttl.setTaketime(now);
			ttl.setTakeway("1");
			ttl.setStatus("失败");
			ttl.setOperatorname(CurrentUtil.getGlobal().getUserinfo().getName());
			ttl.setOperatorgname(CurrentUtil.getGlobal().getOrganization().getName());
			ttl.setTicketoutletsname(CurrentUtil.getGlobal().getTicketoutlets().getName());
			ttl.setTakecompute(CurrentUtil.getGlobal().getIpAddress());
			ttl.setCreateby(CurrentUtil.getGlobal().getUserinfo().getId());
			ttl.setCreatetime(now);
			ttl.setUpdateby(CurrentUtil.getGlobal().getUserinfo().getId());
			ttl.setUpdatetime(now);
			ttl.setRemark(remark + "---"+ "未查询到对应票");
			dao.merge(ttl);
		}
		return list;
	}
	
	
	/* (non-Javadoc)
	 * @see cn.nova.bus.sale.service.TakeTicketService#takeTicket(java.lang.String, java.lang.String, java.lang.String, java.lang.String)
	 */
	@Override
	public long takeTicket(String ticketno, Long ticketsellotherid,long printbyid,String takeway) throws ServiceException  {
		Ticketsellother ticketsellother = (Ticketsellother) dao.get(Ticketsellother.class, ticketsellotherid);
		return remoteTakeTicket(ticketno,ticketsellother,printbyid,takeway);
	}

	private long remoteTakeTicket(String batchno, String ticketno,
			String eticketno, String epassword,long printbyid,String takeway) throws ServiceException  {
		Ticketsellother ticketsellother = null;
		if(eticketno!=null&&!"".equals(eticketno)){
			ticketsellother = ticketsellotherDao.getByETicketno(eticketno);
		}
		else{
			ticketsellother = ticketsellotherDao.getByPassword(epassword);
		}
		return remoteTakeTicket(batchno, ticketno,ticketsellother,printbyid,takeway);
	}

	private long remoteTakeTicket(String batchno, String ticketno,
			Ticketsellother ticketsellother,long printbyid,String takeway) throws ServiceException  {
		
			try {
				userTransaction.begin();
			} catch (SystemException e) {
				e.printStackTrace();
			}
		play.Logger.info("电子票取票开始，票号："+ticketno);
		Date now = new Date();
		//添加非空取票日志项
		Taketicketlog ttl = new Taketicketlog();
		ttl.setTaketime(now);
		ttl.setOperatorname(CurrentUtil.getGlobal().getUserinfo().getName());
		ttl.setOperatorgname(CurrentUtil.getGlobal().getOrganization().getName());
		ttl.setTicketoutletsname(CurrentUtil.getGlobal().getTicketoutlets().getName());
		ttl.setTakecompute(CurrentUtil.getGlobal().getIpAddress());
		ttl.setCreateby(CurrentUtil.getGlobal().getUserinfo().getId());
		ttl.setCreatetime(now);
		ttl.setUpdateby(CurrentUtil.getGlobal().getUserinfo().getId());
		ttl.setUpdatetime(now);
		ttl.setTakeway(takeway);
		
		if(ticketsellother==null){
			play.Logger.info("电子票取票失败，电子票不存在。票号："+ticketno);
			ttl.setStatus("失败");
			ttl.setTicketno(ticketno);
			ttl.setRemark("电子票不存在");
			dao.merge(ttl);
			try {
				userTransaction.commit();
				play.Logger.info("电子票取票失败，电子票不存在，提交操作日志。票号："+ticketno);
			} catch (SystemException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			throw new ServiceException("0333");//电子票不存在
		}
		else if(ticketsellother.getIstaked()){
			play.Logger.info("电子票取票失败，该电子票已经取票，不能再取。票号："+ticketno);
			ttl.setStatus("失败");
			ttl.setTicketno(ticketsellother.getEticketno());
			ttl.setRemark("该电子票已经取票，不能再取");
			dao.merge(ttl);
			try {
				userTransaction.commit();
				play.Logger.info("电子票取票失败，该电子票已经取票，不能再取，提交操作日志。票号："+ticketno);
			} catch (SystemException e) {
				e.printStackTrace();
			}
			throw new ServiceException("0334");//该电子票已经取票，不能再取
		}
		Ticketsell ticketsell = (Ticketsell) dao.get(Ticketsell.class, ticketsellother.getTicketsellid());
		if(ticketsell.getTicketstatus().equals("1")){
			play.Logger.info("电子票取票失败，该车票已退。票号："+ticketno);
			ttl.setTicketno(ticketsell.getTicketno());
			ttl.setRemark("该车票已退");
			ttl.setStatus("失败");
			ttl = (Taketicketlog)dao.merge(ttl);
			try {
				userTransaction.commit();
				play.Logger.info("电子票取票失败，该车票已退，提交操作日志。票号："+ticketno);
			} catch (SystemException e) {
				e.printStackTrace();
			}
			throw new ServiceException("0121");//该车票已退！
		}
		Organization sellorg = (Organization)dao.get(Organization.class, ticketsell.getOrgid());
		//从NetOrgTakeSetting网售机构取票设置表中查询该票是否可取，若在表中设置该机构售票在窗口不可取票，则给出提示
		NetOrgTakeSetting forbidNetOrg = ticketsellotherDao.qryForbidNetOrgs(sellorg.getCode());
		if(forbidNetOrg != null){
			play.Logger.info(ticketsell.getTicketno() +"该电子票售票机构在数据库NetOrgTakeSetting设置为不可在窗口取票，售票机构code为：" + forbidNetOrg);
			throw new BusinessException(" 该网售票不能在窗口取票！");
		}
		Schedule sch = (Schedule)dao.get(Schedule.class, ticketsell.getScheduleid());
		Organization schorg = (Organization)dao.get(Organization.class,sch.getOrgid());
		Station startstation = (Station) dao.get(Station.class, ticketsell.getDepartstationid());
		Station reachstation = (Station) dao.get(Station.class, ticketsell.getReachstationid());
		//存入取票日志表中车票相关数据
		ttl.setTicketno(ticketsellother.getEticketno());
		ttl.setOrderno(ticketsellother.getOrderno());
		ttl.setTicketprice(ticketsell.getPrice());
		ttl.setSellorgname(sellorg.getName());
		ttl.setSchorgname(schorg.getName());
		ttl.setDepartdate(ticketsell.getDepartdate());
		ttl.setDeparttime(ticketsell.getDeparttime());
		ttl.setSchcode(sch.getCode());
		ttl.setDepartstationname(startstation.getName());
		ttl.setReachstationname(reachstation.getName());
		ttl.setTickettypename(ticketsell.getTickettype());
		ttl.setSeatno(ticketsell.getSeatno());
		ttl.setPassword(ticketsellother.getPassword());
		//防止旅客信息为空是报错
		if(ticketsell.getCustomer()!=null){
			ttl.setCustomername(ticketsell.getCustomer().getName());
			ttl.setCertificateno(ticketsell.getCustomer().getCertificateno());
			ttl.setMobilephone(ticketsell.getCustomer().getMobilephone());
		}
		ttl.setSelltime(ticketsell.getSelltime());
		ttl.setStatus("成功");
		play.Logger.info("电子票取票成功，票号："+ticketno);
		dao.merge(ttl);
		if(printbyid>0){
			//换票人为本站售票员时，插入或修改应缴款表
			Billinuse billinuse = new BillinuseDao().getBilluseBy("Ticket",printbyid,ticketno);
			Ticketturnoverdetail ticketturnoverdetail = ticketturnoverdetailService.getCurTicketturnoverdetail(printbyid, ticketno);
			if("0".equals(ticketturnoverdetail.getTicketstartno())){
				ticketturnoverdetail.setTicketstartno(ticketno);
			}
			if(billinuse != null){
				ticketturnoverdetail.setBillinuseid(billinuse.getId());
			}else{
				ticketturnoverdetail.setBillinuseid(0);
			}
			ticketturnoverdetail.setTicketendno(ticketno);
			ticketturnoverdetail.setEticketnum(ticketturnoverdetail.getEticketnum()+1);
			ticketturnoverdetail.setUpdateby(printbyid);
			ticketturnoverdetail.setUpdatetime(now);
			ticketturnoverdetail = (Ticketturnoverdetail) dao.merge(ticketturnoverdetail);
//			ticketsell.setTurnoverdetailid(ticketturnoverdetail.getId());
		}
		ticketsellother.setIstaked(true);
		ticketsellother.setTaketime(now);
		ticketsellother.setTakeway(takeway);
		ticketsellother.setPrintby(printbyid);
		ticketsellother.setUpdateby(printbyid);
		ticketsellother.setUpdatetime(now);
		ticketsell.setBatchno(batchno);
		ticketsell.setTicketno(ticketno);
		ticketsell.setUpdateby(printbyid);
		ticketsell.setUpdatetime(now);
		dao.merge(ticketsell);
		dao.merge(ticketsellother);
		try {
			userTransaction.commit();
			play.Logger.info("电子票取票成功，提交操作日志。票号："+ticketno);
		} catch (SystemException e) {
			e.printStackTrace();
		}
		return ticketsell.getId();
	}
	private long remoteTakeTicket(String ticketno,
			Ticketsellother ticketsellother,long printbyid,String takeway) throws ServiceException  {
		TicketMixChange tmc = null;
		Ticketsell ticketmix = null;
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		try {
			userTransaction.begin();
		} catch (SystemException e) {
			e.printStackTrace();
		}
		play.Logger.info("电子票取票开始，票号："+ticketno);
		Date now = new Date();
		//添加非空取票日志项
		Taketicketlog ttl = new Taketicketlog();
		ttl.setTaketime(now);
		ttl.setOperatorname(CurrentUtil.getGlobal().getUserinfo().getName());
		ttl.setOperatorgname(CurrentUtil.getGlobal().getOrganization().getName());
		ttl.setTicketoutletsname(CurrentUtil.getGlobal().getTicketoutlets().getName());
		ttl.setTakecompute(CurrentUtil.getGlobal().getIpAddress());
		ttl.setCreateby(CurrentUtil.getGlobal().getUserinfo().getId());
		ttl.setCreatetime(now);
		ttl.setUpdateby(CurrentUtil.getGlobal().getUserinfo().getId());
		ttl.setUpdatetime(now);
		ttl.setTakeway(takeway);
		
		if(ticketsellother==null){
			play.Logger.info("电子票取票失败，电子票不存在。票号："+ticketno);
			ttl.setStatus("失败");
			ttl.setTicketno(ticketno);
			ttl.setRemark("电子票不存在");
			dao.merge(ttl);
			try {
				userTransaction.commit();
				play.Logger.info("电子票取票失败，电子票不存在，提交操作日志。票号："+ticketno);
			} catch (SystemException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			throw new ServiceException("0333");//电子票不存在
		}
		else if(ticketsellother.getIstaked()){
			play.Logger.info("电子票取票失败，该电子票已经取票，不能再取。票号："+ticketno);
			ttl.setStatus("失败");
			ttl.setTicketno(ticketsellother.getEticketno());
			ttl.setRemark("该电子票已经取票，不能再取");
			dao.merge(ttl);
			try {
				userTransaction.commit();
				play.Logger.info("电子票取票失败，该电子票已经取票，不能再取，提交操作日志。票号："+ticketno);
			} catch (SystemException e) {
				e.printStackTrace();
			}
			throw new ServiceException("0334");//该电子票已经取票，不能再取
		}
		Ticketsell ticketsell = (Ticketsell) dao.get(Ticketsell.class, ticketsellother.getTicketsellid());
		if(ticketsell.getTicketstatus().equals("1")){
			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("EQL_t!oldsellid", ticketsellother.getTicketsellid()));
			tmc = (TicketMixChange) dao.uniqueResult(TicketMixChange.class, propertyFilters);
			if(tmc!=null){
				propertyFilters.clear();
				propertyFilters.add(new PropertyFilter("EQL_t!id", tmc.getSellid()));
				ticketmix = (Ticketsell) dao.uniqueResult(Ticketsell.class, propertyFilters);
			}
		}
		if(ticketsell.getTicketstatus().equals("1")&&tmc==null){
			play.Logger.info("电子票取票失败，该车票已退。票号："+ticketno);
			ttl.setTicketno(ticketsell.getTicketno());
			ttl.setRemark("该车票已退");
			ttl.setStatus("失败");
			ttl = (Taketicketlog)dao.merge(ttl);
			try {
				userTransaction.commit();
				play.Logger.info("电子票取票失败，该车票已退，提交操作日志。票号："+ticketno);
			} catch (SystemException e) {
				e.printStackTrace();
			}
			throw new ServiceException("0121");//该车票已退！
		}
		Organization sellorg = (Organization)dao.get(Organization.class, ticketsell.getOrgid());
		//从NetOrgTakeSetting网售机构取票设置表中查询该票是否可取，若在表中设置该机构售票在窗口不可取票，则给出提示
		NetOrgTakeSetting forbidNetOrg = ticketsellotherDao.qryForbidNetOrgs(sellorg.getCode());
		if(forbidNetOrg != null){
			play.Logger.info(ticketsell.getTicketno() +"该电子票售票机构在数据库NetOrgTakeSetting设置为不可在窗口取票，售票机构code为：" + forbidNetOrg);
			throw new BusinessException(" 该网售票不能在窗口取票！");
		}
		Schedule sch = (Schedule)dao.get(Schedule.class, ticketsell.getScheduleid());
		Organization schorg = (Organization)dao.get(Organization.class,sch.getOrgid());
		Station startstation = (Station) dao.get(Station.class, ticketsell.getDepartstationid());
		Station reachstation = (Station) dao.get(Station.class, ticketsell.getReachstationid());
		//存入取票日志表中车票相关数据
		ttl.setTicketno(ticketsellother.getEticketno());
		ttl.setOrderno(ticketsellother.getOrderno());
		ttl.setTicketprice(ticketsell.getPrice());
		ttl.setSellorgname(sellorg.getName());
		ttl.setSchorgname(schorg.getName());
		ttl.setDepartdate(ticketsell.getDepartdate());
		ttl.setDeparttime(ticketsell.getDeparttime());
		ttl.setSchcode(sch.getCode());
		ttl.setDepartstationname(startstation.getName());
		ttl.setReachstationname(reachstation.getName());
		ttl.setTickettypename(ticketsell.getTickettype());
		ttl.setSeatno(ticketsell.getSeatno());
		ttl.setPassword(ticketsellother.getPassword());
		//防止旅客信息为空是报错
		if(ticketsell.getCustomer()!=null){
			ttl.setCustomername(ticketsell.getCustomer().getName());
			ttl.setCertificateno(ticketsell.getCustomer().getCertificateno());
			ttl.setMobilephone(ticketsell.getCustomer().getMobilephone());
		}
		ttl.setSelltime(ticketsell.getSelltime());
		ttl.setStatus("成功");
		play.Logger.info("电子票取票成功，票号："+ticketno);
		dao.merge(ttl);
		Billinuse billinuse = billinuseService.jumpBillinuse(printbyid,"Ticket",ticketno,1);
		Billinventory billinventory = (Billinventory) dao.get(Billinventory.class, billinuse.getBillinventoryid()); 
		String batchno = billinventory.getBatchno();
		if(printbyid>0){
			//换票人为本站售票员时，插入或修改应缴款表
			Ticketturnoverdetail ticketturnoverdetail = ticketturnoverdetailService.getCurTicketturnoverdetail(printbyid, ticketno);
			if("0".equals(ticketturnoverdetail.getTicketstartno())){
				ticketturnoverdetail.setTicketstartno(ticketno);
			}
			ticketturnoverdetail.setTicketendno(ticketno);
			ticketturnoverdetail.setEticketnum(ticketturnoverdetail.getEticketnum()+1);
			ticketturnoverdetail.setUpdateby(printbyid);
			ticketturnoverdetail.setBatchno(batchno);
			ticketturnoverdetail.setUpdatetime(now);
			ticketturnoverdetail.setBillinuseid(billinuse.getId());
			ticketturnoverdetail = (Ticketturnoverdetail) dao.merge(ticketturnoverdetail);
//			ticketsell.setTurnoverdetailid(ticketturnoverdetail.getId());
		}
		ticketsellother.setIstaked(true);
		ticketsellother.setTaketime(now);
		ticketsellother.setTakeway(takeway);
		ticketsellother.setPrintby(printbyid);
		ticketsellother.setUpdateby(printbyid);
		ticketsellother.setUpdatetime(now);
		ticketsell.setBatchno(batchno);
		ticketsell.setTicketno(ticketno);
		ticketsell.setUpdateby(printbyid);
		ticketsell.setUpdatetime(now);
		if(ticketmix!=null){
			ticketmix.setBatchno(batchno);
			ticketmix.setTicketno(ticketno+"01");
			ticketmix.setUpdateby(printbyid);
			ticketmix.setUpdatetime(now);
			tmc.setOldticketno(ticketno);
			tmc.setTicketno(ticketno+"01");
			dao.merge(ticketmix);
			dao.merge(tmc);
		}
		dao.merge(ticketsell);
		dao.merge(ticketsellother);
		try {
			userTransaction.commit();
			play.Logger.info("电子票取票成功，提交操作日志。票号："+ticketno);
		} catch (SystemException e) {
			e.printStackTrace();
		}
		if(tmc!=null){
			return ticketmix.getId();
		}else{
			return ticketsell.getId();
		}
	}
	
	public long remoteTakeTicket(String bathno, String ticketno,
			String eticketno, String epassword,String takeway) throws ServiceException {
		return remoteTakeTicket(bathno, ticketno,eticketno, epassword,0,"2");
	}
	
	public TicketsellotherDao getTicketsellotherDao() {
		return ticketsellotherDao;
	}

	public void setTicketsellotherDao(TicketsellotherDao ticketsellotherDao) {
		this.ticketsellotherDao = ticketsellotherDao;
	}

	public IDAO getDao() {
		return dao;
	}

	public void setDao(IDAO dao) {
		this.dao = dao;
	}

}
