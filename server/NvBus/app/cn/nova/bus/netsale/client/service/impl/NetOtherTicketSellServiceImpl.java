package cn.nova.bus.netsale.client.service.impl;

import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.ListIterator;
import java.util.Map;
import java.util.UUID;

import javax.persistence.LockModeType;
import javax.persistence.Query;

import play.db.jpa.JPA;
import util.CurrentUtil;
import util.JsonUtil;
import util.TransactionUtil;
import cn.nova.bus.archive.dao.CustomerDao;
import cn.nova.bus.archive.model.Customer;
import cn.nova.bus.archive.service.CustomerService;
import cn.nova.bus.archive.service.impl.CustomerServiceImpl;
import cn.nova.bus.balance.service.BalancedeductService;
import cn.nova.bus.balance.service.impl.BalancedeductServiceImpl;
import cn.nova.bus.balance.vo.DeductInfo;
import cn.nova.bus.base.dao.ScheduleDao;
import cn.nova.bus.base.model.Schedule;
import cn.nova.bus.base.model.Schedulestop;
import cn.nova.bus.base.model.Station;
import cn.nova.bus.base.model.Ticketoutletsctr;
import cn.nova.bus.base.service.ScheduleperselldaysService;
import cn.nova.bus.base.service.VehicleseatplanService;
import cn.nova.bus.base.service.impl.ScheduleperselldaysServiceImpl;
import cn.nova.bus.base.service.impl.VehicleseatplanServiceImpl;
import cn.nova.bus.common.ParamterConst;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.dispatch.dao.SchPlanDao;
import cn.nova.bus.dispatch.dao.SeatlockDao;
import cn.nova.bus.dispatch.model.Seatreserve;
import cn.nova.bus.dispatch.model.SeatreserveIn;
import cn.nova.bus.dispatch.model.Seatreserveno;
import cn.nova.bus.dispatch.model.UpdateScheduleSeats;
import cn.nova.bus.dispatch.model.UpdateSeatReserve;
import cn.nova.bus.dispatch.model.UpdateTicketSell;
import cn.nova.bus.dispatch.service.ScheduleseatsService;
import cn.nova.bus.dispatch.service.TicketpriceService;
import cn.nova.bus.dispatch.service.impl.ScheduleseatsServiceImpl;
import cn.nova.bus.dispatch.service.impl.TicketpriceServiceImpl;
import cn.nova.bus.encrypt.AuthcodeEncode;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.netsale.client.service.NetOtherTicketSellService;
import cn.nova.bus.price.model.Scheduleplan;
import cn.nova.bus.price.model.Scheduleseats;
import cn.nova.bus.price.model.Schedulestatus;
import cn.nova.bus.price.model.Schedulevehiclepeopleplan;
import cn.nova.bus.price.model.Ticketprice;
import cn.nova.bus.sale.model.Seatlock;
import cn.nova.bus.sale.model.SeatlockPK;
import cn.nova.bus.sale.model.Ticketsell;
import cn.nova.bus.sale.model.Ticketsellother;
import cn.nova.bus.system.dao.DigitaldictionarydetailDao;
import cn.nova.bus.system.dao.ExceptioninfoDao;
import cn.nova.bus.system.model.Digitaldictionarydetail;
import cn.nova.bus.system.model.Organization;
import cn.nova.bus.system.service.OrganizationService;
import cn.nova.bus.system.service.ParameterService;
import cn.nova.bus.system.service.impl.OrganizationServiceImpl;
import cn.nova.bus.system.service.impl.ParameterServiceImpl;
import cn.nova.utils.commons.DateUtils;
import cn.nova.utils.commons.MethodResult;
import cn.nova.utils.commons.RemoteInvokeAuxiliaryProperty;
import cn.nova.utils.commons.StringUtils;
import cn.nova.utils.commons.TicketOrder;
import cn.nova.utils.commons.TicketPrintInfo;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.IDAO;
import cn.nova.utils.orm.jpa.ListUtil;

@SuppressWarnings({"rawtypes","unchecked"})
//@TransactionManagement(TransactionManagementType.BEAN)
public class NetOtherTicketSellServiceImpl implements NetOtherTicketSellService {
	
	private IDAO dao = new EntityManagerDaoSurport();
	private ParameterService parameterService = new ParameterServiceImpl();
	private ExceptioninfoDao exceptioninfoDao = new ExceptioninfoDao();
	private BalancedeductService balancedeductService = new BalancedeductServiceImpl();
	private VehicleseatplanService vehicleseatplanService = new VehicleseatplanServiceImpl();
	private ScheduleDao scheduleDao = new ScheduleDao();
	private SchPlanDao schPlanDao = new SchPlanDao();
	private CustomerDao customerDao = new CustomerDao();
	private ScheduleperselldaysService scheduleperselldaysService = new ScheduleperselldaysServiceImpl();
	private OrganizationService organizationService = new OrganizationServiceImpl();
	private DigitaldictionarydetailDao dictionaryDao = new DigitaldictionarydetailDao();
	
	private boolean checkClientOrgIp(){
//		try {
//			String clientIp = RemoteServer.getClientHost();
//			if(!checkOrgIp(clientIp)){
//				throw new EJBException("调用者不合法");
//			}
//		} catch (ServerNotActiveException e) {
//			play.Logger.error(e.getMessage(), e);
//		}
		return false;
	}
	
	private boolean checkOrgIp(String ip){
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		List<Organization> organizations = dao.find(Organization.class, propertyFilters);
		for (Organization organization : organizations) {
			if(ip.equals(organization.getServersaddressIp())){
				return true;
			}
		}
		return false;
	}

	public void setParameterService(ParameterService parameterService) {
		this.parameterService = parameterService;
	}

	public ParameterService getParameterService() {
		return parameterService;
	}
	
	private MethodResult checkCanSell(Schedulestatus schedulestatus,boolean issaleafterreport,String sellway){
		MethodResult methodResult = new MethodResult();
		if(schedulestatus==null){
			//班次状态记录不存在
			methodResult.setResultMsg(exceptioninfoDao.getExceptioninfo("0203"));
			return methodResult;
		}
		else if(schedulestatus.getIsdeparted()&&!"2".equals(sellway)){
			//该班次已发班
			methodResult.setResultMsg(exceptioninfoDao.getExceptioninfo("0198"));
			return methodResult;
		}
		else if("1".equals(schedulestatus.getStatus())){
			//该班次班次已报停
			methodResult.setResultMsg(exceptioninfoDao.getExceptioninfo("0199"));
			return methodResult;
		}
		else if("3".equals(schedulestatus.getStatus())){
			//该班次班次已被并
			methodResult.setResultMsg(exceptioninfoDao.getExceptioninfo("0200"));
			return methodResult;
		}
		else if("4".equals(schedulestatus.getStatus())){
			//该班次班次已脱班
			methodResult.setResultMsg(exceptioninfoDao.getExceptioninfo("0201"));
			return methodResult;
		}
		else if("5".equals(schedulestatus.getStatus())){
			//该班次班次已停售
			methodResult.setResultMsg(exceptioninfoDao.getExceptioninfo("0202"));
			return methodResult;
		}
		//检查是否是专营班次
		if(schedulestatus.getScheduleplan().getIsproprietary()){
			methodResult.setResultMsg(exceptioninfoDao.getExceptioninfo("0351"));//该班次为发车站专营班次，不允许售联网票
			return methodResult;
		}
		//验证不可售
		if(!schedulestatus.getScheduleplan().getIssellable()){
			//班次不可售
			methodResult.setResultMsg("班次不可售");
			return methodResult;
		}
		//报到后可售
		if( (schedulestatus.getScheduleplan().getIsoriginator()
				 || schedulestatus.getScheduleplan().getIssaleafterreport()
				 || issaleafterreport
				)
				&&!schedulestatus.getIsreported()
			  ){
				methodResult.setResultMsg("该班次报到后才允许售票");
				return methodResult;
			}
		methodResult.setResult(1);
		return methodResult;
	}

	@Override
	public MethodResult sellTicket(RemoteInvokeAuxiliaryProperty remoteInvokeAuxiliaryProperty,TicketOrder order){
		checkClientOrgIp();		
		MethodResult methodResult = new MethodResult();
		//取发车机构
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		Organization organization = organizationService.getOrgByCode(remoteInvokeAuxiliaryProperty.getOppositeOrgcode());
		//取售票机构
		Organization organization_sell = organizationService.getOrgByCode(remoteInvokeAuxiliaryProperty.getOperateOrgcode());
		//取班次
		Schedule schedule = scheduleDao.getScheduleByCode(order.getTickets().get(0).getSchedulecode(),organization.getId(),order.getTickets().get(0).getDepartdate());
		//取班次计划
		propertyFilters.clear();
		propertyFilters.add(new PropertyFilter("EQL_t!scheduleid", schedule.getId()));
		propertyFilters.add(new PropertyFilter("EQD_t!departdate", order.getTickets().get(0).getDepartdate()));
		play.Logger.info("stl11:find scheduleplan");
		Scheduleplan scheduleplan = (Scheduleplan) dao.uniqueResult(LockModeType.PESSIMISTIC_READ,Scheduleplan.class, propertyFilters);
		//取班次状态
		propertyFilters.clear();
		propertyFilters.add(new PropertyFilter("EQL_t!scheduleplan.id", scheduleplan.getId()));
		propertyFilters.add(new PropertyFilter("EQL_t!departstationid", organization.getStation().getId()));
		play.Logger.info("stl12:find schedulestatus");
		Schedulestatus schedulestatus = (Schedulestatus) dao.uniqueResult(LockModeType.PESSIMISTIC_READ,Schedulestatus.class, propertyFilters);

		String paramValue = parameterService.findParamValue(ParamterConst.Param_1020,organization.getId());//报到后才允许售票
		boolean issaleafterreport ="1".equals(paramValue);//报到后售票
		//检查可售状态
		MethodResult tmpResult =  checkCanSell(schedulestatus,issaleafterreport,order.getSellway());
		if(tmpResult.getResult()!=1){
			TransactionUtil.setRollbackOnly();
			return tmpResult;
		}
		//取班次车辆人员计划
		propertyFilters.clear();
		propertyFilters.add(new PropertyFilter("EQL_t!scheduleplan.id",scheduleplan.getId()));
		propertyFilters.add(new PropertyFilter("EQR_t!orderno",(short)0));
		play.Logger.info("stl13:find schedulevehiclepeopleplan");
		Schedulevehiclepeopleplan schedulevehiclepeopleplan = (Schedulevehiclepeopleplan) dao.uniqueResult(Schedulevehiclepeopleplan.class, propertyFilters);

		Date now = new Date();
		Long ticketno = new Long(order.getStartTicketNO());
		
		Map<TicketPrintInfo,Ticketsell> ticketsells = new HashMap<TicketPrintInfo, Ticketsell>();
		ticketno = ticketno -1;
//		float CarrychildRate = Float.valueOf(parameterService.findParamValue("1012", organization.getId()))/100;
		String param1012 = parameterService.findParamValue(ParamterConst.Param_1012, organization.getId());
		String param1061 = parameterService.findParamValue(ParamterConst.Param_1061, organization.getId());

		//计算半票数
		int bNum = 0;
		for (TicketPrintInfo ticketPrintInfo : order.getTickets()) {
			if("B".equals(ticketPrintInfo.getTickettype())){
				bNum++;
				break;
			}
		}
		float bRate = 1;
		if(bNum>0){
			bRate = Float.valueOf(parameterService.findParamValue("1036", organization.getId()))/100;
			if(bRate<=0){
				methodResult.setResultMsg(exceptioninfoDao.getExceptioninfo("0371"));//半票数超出设定比例		
				TransactionUtil.setRollbackOnly();
				return methodResult;
			}
		}
		for (TicketPrintInfo detail : order.getTickets()) {
			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("EQS_t!code", detail.getDepartstationcode()));
			Station station_depart = (Station) dao.uniqueResult(Station.class, propertyFilters);
			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("EQS_t!code", detail.getReachstationcode()));
			Station station_reach = (Station) dao.uniqueResult(Station.class, propertyFilters);
			if(!scheduleplan.getIslinework()&&"2".equals(scheduleplan.getWorktype())){
				//如果是非流水班而且是本区配客班次，再次校验座位是否可售
				//根据发车站、到达站查售票表。交叉的座位不可售
				play.Logger.info("stl14:find cross seat");
				List<Ticketsell> selledseat =findSectionTicketsells(scheduleplan,station_depart.getId(),station_reach.getId(),detail.getSeatno());
				if(selledseat!=null&&selledseat.size()>0){
					//该座位已经被售出，重新选位
					//查出所有不可售的座位
					List<Ticketsell> selledseats =findSectionTicketsells(scheduleplan,station_depart.getId(),station_reach.getId(),null);
					short selseatno = 0; //可售空位
					short beforeSelledSeatno = 0;//前一个已售座位号
					for (Ticketsell ticketsell : selledseats) {
						if(ticketsell.getSeatno()>beforeSelledSeatno+1){
							selseatno = (short) (beforeSelledSeatno+1);
							break;
						}
						beforeSelledSeatno = ticketsell.getSeatno();
					}
					if(selseatno==0&&beforeSelledSeatno>0){
						selseatno = (short) (beforeSelledSeatno+1);
					}
					//如果还没有合适的座位，则返回错误
					if(selseatno==0||selseatno>scheduleplan.getSeatnum()){
						methodResult.setResultMsg("日期:"+detail.getDepartdate()+"班次号:"+detail.getSchedulecode()+"座位号:"+detail.getSeatno()
												+exceptioninfoDao.getExceptioninfo("0205"));//座位不是锁定状态
						TransactionUtil.setRollbackOnly();
						return methodResult;
					}else{
						detail.setSeatno(selseatno);
					}
				}
			}
			//锁定班次并更新剩余票数
			play.Logger.info("stl15:lock seat");
			scheduleplan.setSoldeatnum((short) (scheduleplan.getSoldeatnum()+1));
			int maxchildnum = 0;
			if (param1012.equals("0")){
				maxchildnum=new Integer(param1061);
			}else{
				float CarrychildRate = Float.valueOf(param1061)/100;
				maxchildnum=(int) (CarrychildRate*(scheduleplan.getSeatnum()-scheduleplan.getFixedreserveseatnum()));
			}
			if(detail.getCarrychildnum()>0
					&&maxchildnum*(scheduleplan.getSeatnum()-scheduleplan.getFixedreserveseatnum())<scheduleplan.getCarrychildnum()+detail.getCarrychildnum()){
				//该班次带儿童数量超过最大允许带儿童数量
				methodResult.setResultMsg(exceptioninfoDao.getExceptioninfo("0270"));
				TransactionUtil.setRollbackOnly();
				return methodResult;
			}
			scheduleplan.setCarrychildnum((short) (scheduleplan.getCarrychildnum()+detail.getCarrychildnum()));
			//检验半票百分比
			if(bRate<1&&"B".equals(detail.getTickettype())){
				//计算已售半票
				propertyFilters.clear();
				propertyFilters.add(new PropertyFilter("EQL_t!scheduleplanid", detail.getScheduleplanid()));
				propertyFilters.add(new PropertyFilter("EQD_t!departdate", detail.getDepartdate()));
				propertyFilters.add(new PropertyFilter("EQS_t!ticketstatus", "0"));
				propertyFilters.add(new PropertyFilter("EQS_t!tickettype", "B"));
				List<Object> ll = dao.find(Ticketsell.class,propertyFilters);
				int bNumed = ll==null?0:ll.size();
				if(bRate*(scheduleplan.getSeatnum()-scheduleplan.getFixedreserveseatnum())<bNumed+1){
					methodResult.setResultMsg(exceptioninfoDao.getExceptioninfo("0371"));//半票数超出设定比例	
					TransactionUtil.setRollbackOnly();
					return methodResult;
				}
			}
			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("EQL_t!scheduleplan.id", scheduleplan.getId()));
			propertyFilters.add(new PropertyFilter("EQL_t!departstationid", station_depart.getId()));
			propertyFilters.add(new PropertyFilter("EQL_t!reachstationid", station_reach.getId()));
			propertyFilters.add(new PropertyFilter("EQS_t!seattype", detail.getSeattype()));
			play.Logger.info("stl15:find ticketprice");
			Ticketprice ticketprice = (Ticketprice) dao.uniqueResult(LockModeType.PESSIMISTIC_READ,Ticketprice.class, propertyFilters);
			
			//验证不可售、报到后可售
			if(!ticketprice.getIssellable()){
				//班次不可售
				methodResult.setResultMsg("该到达站不可售");
				TransactionUtil.setRollbackOnly();
				return methodResult;
			}
			
			ticketprice.setSoldeatnum((short) (ticketprice.getSoldeatnum()+1));
			//0售票、1补票、2特权补票、3代售票、4改票、5手工票、6留票销售、7网上售票、8订票
			
			Ticketsell ticketsell = new Ticketsell();
			if(!detail.getIslinework()){
				play.Logger.info("stl16:not linework and sellTicket");
				ticketsell.setSeatno(detail.getSeatno());
				if(!"2".equals(scheduleplan.getWorktype())
						&&!"3".equals(scheduleplan.getWorktype())){
						//检查座位状态
					propertyFilters.clear();
					propertyFilters.add(new PropertyFilter("EQL_t!scheduleplan.id", scheduleplan.getId()));
					propertyFilters.add(new PropertyFilter("EQR_t!seatno", detail.getSeatno()));
					Scheduleseats scheduleseat = (Scheduleseats) dao.uniqueResult(LockModeType.PESSIMISTIC_READ,Scheduleseats.class, propertyFilters);
					if(scheduleseat==null){
						//班次座位记录不存在
						methodResult.setResultMsg("日期:"+detail.getDepartdate()+"班次号:"+detail.getSchedulecode()+"座位号:"+detail.getSeatno()+exceptioninfoDao.getExceptioninfo("0204"));
						TransactionUtil.setRollbackOnly();
						return methodResult;
					}
					else if(!"1".equals(scheduleseat.getStatus())){
						//座位不是锁定状态
						methodResult.setResultMsg("日期:"+detail.getDepartdate()+"班次号:"+detail.getSchedulecode()+"座位号:"+detail.getSeatno()+exceptioninfoDao.getExceptioninfo("0205"));
						TransactionUtil.setRollbackOnly();
						return methodResult;
					}
					propertyFilters.clear();
					propertyFilters.add(new PropertyFilter("EQL_t!id.scheduleplanid", scheduleplan.getId()));
					propertyFilters.add(new PropertyFilter("EQR_t!id.seatno", detail.getSeatno()));
					Seatlock seatlock = (Seatlock) dao.uniqueResult(LockModeType.PESSIMISTIC_READ,Seatlock.class, propertyFilters);
					if(seatlock==null){
						//锁位记录不存在
						methodResult.setResultMsg("日期:"+detail.getDepartdate()+"班次号:"+detail.getSchedulecode()+"座位号:"+detail.getSeatno()+exceptioninfoDao.getExceptioninfo("0206"));
						TransactionUtil.setRollbackOnly();
						return methodResult;
					}
					if("4".equals(seatlock.getOldstatus())||"5".equals(seatlock.getOldstatus())){
						//留座位记录不存在,无法售出留座。
						propertyFilters.clear();
						propertyFilters.add(new PropertyFilter("EQL_t!scheduleplanid", scheduleplan.getId()));
						propertyFilters.add(new PropertyFilter("EQR_t!seatno", detail.getSeatno()));
						Seatreserve seatreserve = (Seatreserve) dao.uniqueResult(LockModeType.PESSIMISTIC_READ,Seatreserve.class, propertyFilters);
						if(seatreserve==null){
							methodResult.setResultMsg("日期:"+detail.getDepartdate()+"班次号:"+detail.getSchedulecode()+"座位号:"+detail.getSeatno()+exceptioninfoDao.getExceptioninfo("0207"));
							TransactionUtil.setRollbackOnly();
							return methodResult;
						}
						else{
							if("R".equals(seatreserve.getSellstate())){
								seatreserve.setSellstate("S");
								seatreserve.setUpdateby(0L);
								seatreserve.setUpdatetime(now);
								dao.merge(seatreserve);
							}
							else{
								if("C".equals(seatreserve.getSellstate())){
									//留座位记录状态为已取消,无法售出留座。
									methodResult.setResultMsg("日期:"+detail.getDepartdate()+"班次号:"+detail.getSchedulecode()+"座位号:"+detail.getSeatno()+exceptioninfoDao.getExceptioninfo("0208"));
									TransactionUtil.setRollbackOnly();
									return methodResult;
								}
								else if("S".equals(seatreserve.getSellstate())){
									//留座位记录状态为已售,无法售出留座。
									methodResult.setResultMsg("日期:"+detail.getDepartdate()+"班次号:"+detail.getSchedulecode()+"座位号:"+detail.getSeatno()+exceptioninfoDao.getExceptioninfo("0209"));
									TransactionUtil.setRollbackOnly();
									return methodResult;
								}
							}
						}
						if("4".equals(seatlock.getOldstatus())){
							ticketprice.setAutocancelreserveseatnum((short) (ticketprice.getAutocancelreserveseatnum()-1));
							scheduleplan.setAutocancelreserveseatnum((short) (scheduleplan.getAutocancelreserveseatnum()-1));
						}
						else if("5".equals(seatlock.getOldstatus())){
							ticketprice.setUnautocancelreserveseatnum((short) (ticketprice.getUnautocancelreserveseatnum()-1));
							scheduleplan.setUnautocancelreserveseatnum((short) (scheduleplan.getUnautocancelreserveseatnum()-1));
						} 
					}
					//更新座位状态
					scheduleseat.setStatus("2");
					scheduleseat.setTickettype(detail.getTickettype());
					detail.setSeatnostr(vehicleseatplanService.getSeatnoRemark(schedulevehiclepeopleplan.getPlanvehiclebrandmodelid(), detail.getSeatno()));
					dao.delete(seatlock);
					scheduleseat.setUpdateby(0L);
					scheduleseat.setUpdatetime(now);
					dao.merge(scheduleseat);
				}
			}
			else{
				play.Logger.info("stl17: linework and sellTicket");
				//流水班次没有留位
				//取已售张数的最大值作为座位号
				propertyFilters.clear();
				propertyFilters.add(new PropertyFilter("EQL_t!scheduleplanid", scheduleplan.getId()));
				ticketsell.setSeatno((short)(dao.countTotalRows(Ticketsell.class, propertyFilters, "id")+1));
				//往回更新
				detail.setSeatno(ticketsell.getSeatno());
				detail.setSeatnostr(String.valueOf(ticketsell.getSeatno()));
			}
			ticketprice.setUpdateby(0L);
			ticketprice.setUpdatetime(now);
			dao.merge(ticketprice);
			//票价表要更新不区分发车站到达站
			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("EQL_t!scheduleplan.id", scheduleplan.getId()));
			propertyFilters.add(new PropertyFilter("EQS_t!seattype", detail.getSeattype()));
			List<Ticketprice> ticketprices = dao.find(LockModeType.PESSIMISTIC_READ,Ticketprice.class, propertyFilters);
			play.Logger.info("stl17:update ticketprice");
			if(ticketprices.size()>1){
				for (Ticketprice _ticketprice : ticketprices){
					_ticketprice.setSoldeatnum(ticketprice.getSoldeatnum());
					_ticketprice.setAutocancelreserveseatnum(ticketprice.getAutocancelreserveseatnum());
					_ticketprice.setUnautocancelreserveseatnum(ticketprice.getUnautocancelreserveseatnum());
					_ticketprice.setUpdateby(0L);
					_ticketprice.setUpdatetime(now);
					dao.merge(_ticketprice);
				}
			}
			
			scheduleplan.setUpdateby(0L);
			scheduleplan.setUpdatetime(now);
			dao.merge(scheduleplan);
			ticketsell.setBuspark(detail.getBuspark());
			ticketsell.setCarrychildnum(detail.getCarrychildnum());
			ticketsell.setCheckedby(null);
			ticketsell.setCheckstation(null);
			ticketsell.setChecktime(null);
			ticketsell.setCreateby(0L);
			ticketsell.setCreatetime(now);
			//由相关证件类型 号码值计算出Customerid,并保存本地。 TicketPrintInfo类要加相关属性
			if(detail.getCertificatetype()!=null&&detail.getCertificateno()!=null
			  &&!detail.getCertificatetype().equals("")&&!detail.getCertificateno().equals("")){
				Customer customer = getCustomerDao().findByTrueMajorKey(detail.getCertificatetype(), detail.getCertificateno());
				if(customer!=null){
					ticketsell.setCustomer(customer);
					customer.setName(detail.getCustomername());
					customer.setSex(detail.getCustomersex());
					customer = (Customer) dao.merge(customer);
				}
				else{
					customer = new Customer();
					customer.setCertificateno(detail.getCertificateno());
					customer.setCertificatetype(detail.getCertificatetype());
					customer.setCreateby(Long.parseLong("0"));
					customer.setCreatetime(new Date());
					customer.setInputway("0");
					customer.setIsactive(true);
					customer.setName(detail.getCustomername());
					customer.setOrgid(organization_sell.getId());
					customer.setSex(detail.getCustomersex());
					customer.setLastbuytickettime(new Date());
					customer.setIslocaldelete(false);
					customer.setUpdateby(Long.parseLong("0"));
					customer.setUpdatetime(new Date());
					customer = (Customer) dao.merge(customer);		
					ticketsell.setCustomer(customer);
				}
				if(null != customer){
					Digitaldictionarydetail certificatetype = dictionaryDao.qryDigitaldictionarydetail("customer", "certificatetype", customer.getCertificatetype());
					if(certificatetype != null){
						ticketsell.setCertificatetypename(certificatetype.getValue());//证件类型名称
					}
					ticketsell.setCustomername(customer.getName());
					ticketsell.setCertificateno(customer.getCertificateno());
				}
				
			}
			else{
				ticketsell.setCustomer(null);
				detail.setCustomerid(null);
			}
//			if(detail.getCustomerid()==null||detail.getCustomerid()<=0){
//				ticketsell.setCustomer(null);
//			}
//			else{
//				Customer customer = new Customer();
//				customer.setId(detail.getCustomerid());
//				ticketsell.setCustomer(customer);
//			}
			play.Logger.info("stl18:make ticketsell bean");
			ticketsell.setDepartdate(detail.getDepartdate());
			ticketsell.setDepartinvoicesby(null);
			ticketsell.setDepartinvoices(null);
			ticketsell.setDepartinvoicestime(null);
			ticketsell.setDepartstationid(station_depart.getId());
			ticketsell.setDeparttime(schedulestatus.getDeparttime());
			detail.setDeparttime(ticketsell.getDeparttime());
			ticketsell.setDiscountrate(detail.getDiscountrate());
			ticketsell.setDistance(detail.getDistance());
			ticketsell.setFullprice(detail.getFullprice());
			ticketsell.setHandticketoutlets(null);
			ticketsell.setIschecked(false);
			ticketsell.setIsdepartinvoices(false);
			ticketsell.setIslinework(detail.getIslinework());
			ticketsell.setOrgid(organization_sell.getId());
			ticketsell.setPaymethod(detail.getPaymethod());
			ticketsell.setPrice(detail.getPrice());
			ticketsell.setMoreprice(ticketprice.getMoreprice());
			ticketsell.setServicefee(detail.getServicefee());
			ticketsell.setReachstationid(station_reach.getId());
			ticketsell.setScheduleid(scheduleplan.getScheduleid());
			ticketsell.setScheduleplanid(scheduleplan.getId());
			//售票表增加冗余字段：报到车辆ID、计划报到车辆品牌型号ID
			if(schedulevehiclepeopleplan != null){
				if(schedulevehiclepeopleplan.getPlanvehicle() != null){
					ticketsell.setVehicleid(schedulevehiclepeopleplan.getPlanvehicle().getId());
				}
				ticketsell.setVehiclebrandmodelid(schedulevehiclepeopleplan.getPlanvehiclebrandmodelid());
			}
			ticketsell.setSellby(0L);
			ticketsell.setSellip(order.getIp());
			ticketsell.setSelltime(now);
			ticketsell.setSellway(order.getSellway());
			ticketsell.setBatchno(order.getBatchno());
			ticketsell.setTicketentrance(detail.getTicketentrance());
			ticketno=ticketno+1;
			
			if("T".equals(detail.getTickettype())){
				//团体票第一张售票记录的票号为真实票号、其它车票生成虚拟票号
				if(ticketno.longValue()==Long.parseLong(order.getStartTicketNO())){
					ticketsell.setTicketno(order.getStartTicketNO());
				}else{
					ticketsell.setTicketno(order.getStartTicketNO()+new Long(ticketno-Long.parseLong(order.getStartTicketNO())));
				}
			}else{
				ticketsell.setTicketno(StringUtils.strPad(ticketno.toString(),order.getStartTicketNO().length(), "0"));
			}
			
//			ticketsell.setTicketno(StringUtils.strPad(ticketno.toString(),order.getStartTicketNO().length(), "0"));
			DateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");
			String datestr = df.format(ticketsell.getSelltime());
			String cipherStr = ticketsell.getOrgid()+datestr+ticketsell.getSellby();
			String tiksno=AuthcodeEncode.authcodeEncode(cipherStr);
			if("".equals(tiksno)||tiksno==null){
				methodResult.setResult(0);
				methodResult.setResultMsg("数据加密失败！");
				return methodResult;
			}
			ticketsell.setTiksno(tiksno);
			
			//往回更新
			detail.setTicketno(ticketsell.getTicketno());
			detail.setMoreprice(ticketprice.getMoreprice());
			ticketsell.setTicketoutletsid(0);
			ticketsell.setTicketoutletsname(order.getTicketoutletsname());
			ticketsell.setTicketstatus("0"); //正常
			ticketsell.setTickettype(detail.getTickettype());
			ticketsell.setUpdateby(0L);
			ticketsell.setUpdatetime(now);
			ticketsell.setSeattype(detail.getSeattype());
			ticketsell.setToplimitprice(detail.getToplimitprice());
			//取票价组成项费用
			DeductInfo deductInfo = balancedeductService.getDeductfee(ticketsell);
			ticketsell.setFueladditionfee(deductInfo.getFueladditionfee());
			ticketsell.setStationservicefee(deductInfo.getStationfee());
			ticketsell.setComputefee(deductInfo.getComputefee());
			ticketsell.setCoolairfee(deductInfo.getCoolairfee());
			ticketsell.setAdditionfee(deductInfo.getAdditionfee());
			ticketsell.setWaterfee(deductInfo.getWaterfee());
			ticketsell.setInsurefee(deductInfo.getInsurefee());
			ticketsell.setOtherfee(deductInfo.getOtherfee());
			detail.setFueladditionfee(ticketsell.getFueladditionfee());
			detail.setStationservicefee(ticketsell.getStationservicefee());
			detail.setComputefee(ticketsell.getComputefee());
			detail.setCoolairfee(ticketsell.getCoolairfee());
			detail.setAdditionfee(ticketsell.getAdditionfee());
			detail.setWaterfee(ticketsell.getWaterfee());
			detail.setInsurefee(ticketsell.getInsurefee());
			detail.setOtherfee(ticketsell.getOtherfee());
			ticketsell.setTurnoverdetailid(null);
			ticketsell.setOrderno(order.getOrderno());
			ticketsell = (Ticketsell) dao.merge(ticketsell);
			detail.setId(ticketsell.getId());
			dao.getEntityManager().flush();
			ticketsells.put(detail,ticketsell);
			play.Logger.info("stl19:end make ticketsell bean");
		}
		methodResult.setResult(1);
		methodResult.setObject(order.getTickets());
		return methodResult;
	}

	public MethodResult sellTicketUndo(String transactionId, RemoteInvokeAuxiliaryProperty remoteInvokeAuxiliaryProperty,TicketOrder order){
		MethodResult methodResult = new MethodResult();
		Date now = new Date();
		ArrayList<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		
		propertyFilters.add(new PropertyFilter("EQS_t!orderno", order.getOrderno()));
		List<Ticketsell> ticketsells = dao.find(LockModeType.PESSIMISTIC_READ,Ticketsell.class, propertyFilters);
		
		for (Ticketsell ticketsell : ticketsells) {
			Scheduleplan scheduleplan = (Scheduleplan) dao.get(LockModeType.PESSIMISTIC_READ,Scheduleplan.class, ticketsell.getScheduleplanid());
			if(!ticketsell.getIslinework()&&!"2".equals(scheduleplan.getWorktype())&&!"3".equals(scheduleplan.getWorktype())){
				//检查座位状态
				propertyFilters.clear();
				propertyFilters.add(new PropertyFilter("EQL_t!scheduleplan.id", ticketsell.getScheduleplanid()));
				propertyFilters.add(new PropertyFilter("EQR_t!seatno", ticketsell.getSeatno()));
				Scheduleseats scheduleseat = (Scheduleseats) dao.uniqueResult(LockModeType.PESSIMISTIC_READ,Scheduleseats.class, propertyFilters);
				if(scheduleseat==null){
					methodResult.setResultMsg(exceptioninfoDao.getExceptioninfo("0204")+":票号"+ticketsell.getTicketno());
					return methodResult;
				}
				else if(!"2".equals(scheduleseat.getStatus())){
					methodResult.setResultMsg(exceptioninfoDao.getExceptioninfo("0263")+":票号"+ticketsell.getTicketno());
					return methodResult;
				}
				scheduleseat.setStatus("0");
				scheduleseat.setUpdateby(0L);
				scheduleseat.setUpdatetime(now);
				dao.merge(scheduleseat);
			}
			
			scheduleplan.setSoldeatnum((short) (scheduleplan.getSoldeatnum()-1));
			scheduleplan.setCarrychildnum((short) (scheduleplan.getCarrychildnum()-ticketsell.getCarrychildnum()));
			scheduleplan.setUpdateby(0L);
			scheduleplan.setUpdatetime(now);
			dao.merge(scheduleplan);
			
			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("EQL_t!scheduleplan.id", ticketsell.getScheduleplanid()));
			propertyFilters.add(new PropertyFilter("EQS_t!seattype", ticketsell.getSeattype()));
			List<Ticketprice> ticketprices = dao.find(LockModeType.PESSIMISTIC_READ,Ticketprice.class, propertyFilters);
			for (Ticketprice _ticketprice : ticketprices){
				_ticketprice.setSoldeatnum((short) (_ticketprice.getSoldeatnum()-1));
				_ticketprice.setUpdateby(0L);
				_ticketprice.setUpdatetime(now);
				dao.merge(_ticketprice);
			}
			
			dao.delete(ticketsell);
		}
		methodResult.setResult(1);
		return methodResult;	
	}

	@Override
	public MethodResult lockSeat(RemoteInvokeAuxiliaryProperty remoteInvokeAuxiliaryProperty,Date departdate,String schedulesynccode,UUID orderno,
			List<Short> seatnos, List<String> selectSeatStatus,
			String selectSeattype) {
		checkClientOrgIp();		
		MethodResult methodResult = new MethodResult();
		Date locktime = new Date();
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		//取发车机构
		Organization organization_depart = organizationService.getOrgByCode(remoteInvokeAuxiliaryProperty.getOppositeOrgcode());
		//取调用者机构
		Organization organization_client = organizationService.getOrgByCode(remoteInvokeAuxiliaryProperty.getOperateOrgcode());
		//取班次
		Schedule schedule = scheduleDao.getScheduleBySyncCode(schedulesynccode);
		if(!scheduleperselldaysService.inPreSalePeriod(schedule.getId(), departdate)){
			methodResult.setResultMsg(exceptioninfoDao.getExceptioninfo("0394"));//该班次不在预售期内
			TransactionUtil.setRollbackOnly();
			return methodResult;
		}
		//取班次计划
		propertyFilters.clear();
		propertyFilters.add(new PropertyFilter("EQL_t!scheduleid", schedule.getId()));
		propertyFilters.add(new PropertyFilter("EQD_t!departdate", departdate));
		Scheduleplan scheduleplan = (Scheduleplan) dao.uniqueResult(LockModeType.PESSIMISTIC_READ,Scheduleplan.class, propertyFilters);
		//取班次状态
		propertyFilters.clear();
		propertyFilters.add(new PropertyFilter("EQL_t!scheduleplan.id", scheduleplan.getId()));
		propertyFilters.add(new PropertyFilter("EQL_t!departstationid", organization_depart.getStation().getId()));
		Schedulestatus schedulestatus = (Schedulestatus) dao.uniqueResult(Schedulestatus.class, propertyFilters);
		
		String paramValue = parameterService.findParamValue(ParamterConst.Param_1020,organization_depart.getId());//报到后才允许售票
		boolean issaleafterreport ="1".equals(paramValue);//报到后售票
		//检查可售状态
		MethodResult tmpResult =  checkCanSell(schedulestatus,issaleafterreport,"2");
		if(tmpResult.getResult()!=1){
			TransactionUtil.setRollbackOnly();
			return tmpResult;
		}

		//联网售票不支持订单购票
		int locktimeout=0;
		locktimeout=new Integer(parameterService.findParamValue("1008", organization_depart.getId()));  //普通购票锁位时长，单位为秒钟
		Calendar cld= Calendar.getInstance();
		cld.setTime(locktime);
		cld.add(Calendar.SECOND, locktimeout);
		Date unlocktime = cld.getTime(); 
		propertyFilters.clear();
		propertyFilters.add(new PropertyFilter("EQL_t!scheduleplan.id", scheduleplan.getId()));
		List<Scheduleseats> scheduleseats = dao.find(LockModeType.PESSIMISTIC_READ,Scheduleseats.class,propertyFilters);
		ListIterator<Short> itSeatnos = seatnos.listIterator();
		while(itSeatnos.hasNext()){
			Short seatno = itSeatnos.next();
			Scheduleseats scheduleseat = null;
			for (Scheduleseats _scheduleseat : scheduleseats) {
				if(_scheduleseat.getSeatno()==seatno.shortValue()){
					scheduleseat = _scheduleseat;
					break;
				}
			}
			//座位状态：0空位、1锁定、2已售、3固定留位、4自动取消留位、5不自动取消留位  取数据字典
			if(scheduleseat==null){
				//班次座位记录不存在
				methodResult.setResultMsg(exceptioninfoDao.getExceptioninfo("0204"));
				TransactionUtil.setRollbackOnly();
				return methodResult;
			}else if(scheduleseat.getStatus().equals("2")||scheduleseat.getStatus().equals("1")){
				for (Scheduleseats _scheduleseat : scheduleseats) {
					if(selectSeatStatus.contains(_scheduleseat.getStatus())
						&&(selectSeattype==null||selectSeattype.equals("")||selectSeattype.equals(_scheduleseat.getSeattype()))
						&&!seatnos.contains(_scheduleseat.getSeatno())){
						scheduleseat = _scheduleseat;
						itSeatnos.set(_scheduleseat.getSeatno());
						seatno=_scheduleseat.getSeatno();
						break;
					}
				}
			}
			if(scheduleseat==null){
				//剩余座位数不够
				methodResult.setResultMsg(exceptioninfoDao.getExceptioninfo("0298"));
				TransactionUtil.setRollbackOnly();
				return methodResult;
			}
			Seatlock seatlock = new Seatlock();
			seatlock.setOldstatus(scheduleseat.getStatus());
			scheduleseat.setStatus("1"); //锁定
			SeatlockPK seatlockPK = new SeatlockPK();
			seatlockPK.setScheduleplanid(scheduleplan.getId());
			seatlockPK.setSeatno(seatno);
			seatlock.setId(seatlockPK);
			seatlock.setLocktime(locktime);
			seatlock.setAutounlocktime(unlocktime);
			seatlock.setDepartdate(scheduleplan.getDepartdate());
			seatlock.setLockby(0L);
			seatlock.setLockip(remoteInvokeAuxiliaryProperty.getOperateOrgIp());
			seatlock.setLockorgid(organization_client.getId());
			seatlock.setLockticketoutletsid(0);
			
			seatlock.setOrderno(orderno.toString());
			seatlock.setScheduleid(scheduleplan.getScheduleid());
			scheduleseat.setUpdateby(0L);
			scheduleseat.setUpdatetime(locktime);
			dao.merge(scheduleseat);
			dao.merge(seatlock);
		}
		methodResult.setResult(1);
		methodResult.setObject(new Object[]{unlocktime,seatnos});
		return methodResult;
	}


	@Override
	public MethodResult unlockSeat(RemoteInvokeAuxiliaryProperty remoteInvokeAuxiliaryProperty,UUID orderno) {
		checkClientOrgIp();	
		MethodResult methodResult = new MethodResult();
		Date locktime = new Date();
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		
		propertyFilters.clear();
		propertyFilters.add(new PropertyFilter("EQS_t!orderno", orderno.toString()));
		List<Seatlock> seatlocks = dao.find(LockModeType.PESSIMISTIC_READ,Seatlock.class,propertyFilters);
		if(seatlocks==null  ||seatlocks.size() <=0 ){
			methodResult.setResult(1);
			return methodResult;
		}
		for (Seatlock seatlock : seatlocks) {
			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("EQL_t!scheduleplan.id", seatlock.getId().getScheduleplanid()));
			propertyFilters.add(new PropertyFilter("EQR_t!seatno", seatlock.getId().getSeatno()));
			Scheduleseats scheduleseat = (Scheduleseats) dao.uniqueResult(LockModeType.PESSIMISTIC_READ,Scheduleseats.class,propertyFilters);
			if(scheduleseat!=null){
				scheduleseat.setStatus(seatlock.getOldstatus());
				scheduleseat.setUpdateby(0L);
				scheduleseat.setUpdatetime(locktime);
				dao.merge(scheduleseat);
			}
			dao.delete(seatlock);
		}
		methodResult.setResult(1);
		return methodResult;
	}

	@Override
	public MethodResult findTicketPrices(Date departdate, String schedulesynccode,String departstationcode,String reachstationcode,
			String seattype) {
		MethodResult methodResult = new MethodResult();
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		//取班次
		Schedule schedule = scheduleDao.getScheduleBySyncCode(schedulesynccode);
		//取站点
		propertyFilters.clear();
		propertyFilters.add(new PropertyFilter("EQS_t!code", departstationcode));
		Station departstation = (Station) dao.uniqueResult(Station.class, propertyFilters);
		propertyFilters.clear();
		propertyFilters.add(new PropertyFilter("EQS_t!code", reachstationcode));
		Station reachstation = (Station) dao.uniqueResult(Station.class, propertyFilters);
		
		//取班次最新票价与座位数
		propertyFilters.clear();
		propertyFilters.add(new PropertyFilter("EQD_t!departdate", departdate));
		propertyFilters.add(new PropertyFilter("EQL_t!scheduleid", schedule.getId()));
		propertyFilters.add(new PropertyFilter("EQL_t!departstationid", departstation.getId()));
		propertyFilters.add(new PropertyFilter("EQL_t!reachstationid", reachstation.getId()));
		propertyFilters.add(new PropertyFilter("EQS_t!seattype", seattype));
		List<Ticketprice> ticketprices = dao.find(Ticketprice.class, propertyFilters);
		for (Ticketprice ticketprice : ticketprices) {
			dao.getEntityManager().detach(ticketprice);//后面要更新ticketprices，不能存入数据库
		}
		
		//取发车时间
		propertyFilters.clear();
		propertyFilters.add(new PropertyFilter("EQL_t!scheduleplan.id", ticketprices.get(0).getScheduleplan().getId()));
		propertyFilters.add(new PropertyFilter("EQL_t!departstationid", departstation.getId()));
		Schedulestatus schedulestatus = (Schedulestatus) dao.uniqueResult(Schedulestatus.class, propertyFilters);

		//合并查询票价格和座位列表
		List<Map<String,Object>> scheduleseatslist = null;
		Scheduleplan scheduleplan = ticketprices.get(0).getScheduleplan();
		//worktype=2时，座位列表从售票表取
		if(!scheduleplan.getIslinework()
			&&"2".equals(scheduleplan.getWorktype())){//2 本区配载
			//模拟座位图
			List<Object> scheduleseatss = new ArrayList<Object>();
			Date now = new Date();
			for (int i = 0; i < scheduleplan.getSeatnum(); i++) {
				Scheduleseats scheduleseats = new Scheduleseats();
				dao.getEntityManager().detach(scheduleseats);
				scheduleseats.setCreateby(0L);
				scheduleseats.setCreatetime(now);
				scheduleseats.setDepartdate(scheduleplan.getDepartdate());
				scheduleseats.setId(i);
				scheduleseats.setOrgid(scheduleplan.getOrgid());
				scheduleseats.setScheduleid(scheduleplan.getScheduleid());
				scheduleseats.setSeatno((short) (i+1));
				scheduleseats.setSeattype(ticketprices.get(0).getSeattype());
				scheduleseats.setStatus("0");
				scheduleseats.setTickettype(null);
				scheduleseats.setUpdateby(0L);
				scheduleseats.setUpdatetime(now);
				scheduleseatss.add(scheduleseats);
			}
			//根据发车站、到达站查售票表。交叉的座位不可售
			List<Ticketsell> selledseats =findSectionTicketsells(scheduleplan,ticketprices.get(0).getDepartstationid(),ticketprices.get(0).getReachstationid(),null);
			ticketprices.get(0).setSoldeatnum((short) 0);
			for (Ticketsell selledseat : selledseats) {
				try {
					Scheduleseats scheduleseats = ((Scheduleseats)scheduleseatss.get(selledseat.getSeatno()-1));
					scheduleseats.setStatus("2");
					scheduleseats.setTickettype(selledseat.getTickettype());
					ticketprices.get(0).setSoldeatnum((short) (ticketprices.get(0).getSoldeatnum()+1));
				} catch (Exception e) {
				}
			}
			scheduleseatslist = ListUtil.listToMap(new Object[]{Scheduleseats.class}, scheduleseatss);
		}else{
			//取班次
//			if(!schedule.getIsactive()){
//				methodResult.setResult(0);
//				methodResult.setResultMsg("该班次已经注销!");
//				scheduleseatslist = ListUtil.listToMap(new Object[]{Scheduleseats.class}, null);
//				return methodResult;
//			}
			//取班次座位表
			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("EQD_t!departdate", departdate));
			propertyFilters.add(new PropertyFilter("EQL_t!scheduleid", schedule.getId()));
			scheduleseatslist = ListUtil.listToMap(new Object[]{Scheduleseats.class}, dao.find(Scheduleseats.class, propertyFilters,new String[]{"t.seatno"}));
		}
		if("2".equals(scheduleplan.getWorktype())){
			for (int i = 1; i < ticketprices.size(); i++) {
				Ticketprice ticketprice = ticketprices.get(i);
				ticketprice.setSoldeatnum(ticketprices.get(0).getSoldeatnum());
			}
		}
		Organization organ = (Organization) dao.get(Organization.class, schedule.getOrgid());
		String param9393 = new ParameterServiceImpl().findParamValue("9393", organ.getId());
		boolean isrealnameticket = false;
		if("1".equals(param9393) ||("2".equals(param9393)&&schedule.getRoute().isIsrealnameticket())){
			isrealnameticket = true;
		}
		methodResult.setObject(new Object[]{ ConvertTicketpriceToCentre(ticketprices),schedulestatus.getDeparttime(),scheduleseatslist,isrealnameticket});
		
//		methodResult.setObject(new Object[]{ ConvertTicketpriceToCentre(ticketprices),schedulestatus.getDeparttime(),scheduleseatslist});
		methodResult.setResult(1);
		return methodResult;
	}
	
	private List<Ticketsell> findSectionTicketsells(Scheduleplan scheduleplan,long departstationid,long reachstationid,Short seatno){
		List<Ticketsell> selledseats = null;
		//取出发车站、到达站在班次停靠点的序号
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		propertyFilters.clear();
		propertyFilters.add(new PropertyFilter("EQL_t!schedule.id", scheduleplan.getScheduleid()));
		propertyFilters.add(new PropertyFilter("EQL_t!stationid", departstationid));
		List<Schedulestop> ssd = dao.find(Schedulestop.class, propertyFilters);
		propertyFilters.clear();
		propertyFilters.add(new PropertyFilter("EQL_t!schedule.id", scheduleplan.getScheduleid()));
		propertyFilters.add(new PropertyFilter("EQL_t!stationid", reachstationid));
		List<Schedulestop> ssr = dao.find(Schedulestop.class, propertyFilters);
		//根据发车站、到达站查售票表。交叉的座位不可售
		StringBuilder sql = new StringBuilder();
		sql.append("select ts.* from Ticketsell ts ");
		if(ssd!=null && ssd.size()>0 && ssr!=null && ssr.size()>0){
			//班次停靠点如果取不到数据，则当做交叉了
			sql.append(" left join Schedulestop ssd on ts.scheduleid=ssd.scheduleid and ts.departstationid=ssd.stationid ")
			.append(" left join Schedulestop ssr on ts.scheduleid=ssr.scheduleid and ts.reachstationid=ssr.stationid ");
		}
		sql.append(" where ts.departdate=:departdate ")
		.append("   and ts.scheduleplanid=:scheduleplanid ")
		.append("   and ts.ticketstatus='0' ");
		if(seatno!=null&&seatno>0){
			sql.append(" and ts.seatno=").append(seatno);
		}
		if(ssd!=null && ssd.size()>0 && ssr!=null && ssr.size()>0){
			sql.append(" and (ssd.stationid is null ")
			.append(" or ssr.stationid is null ")
			.append(" or (not ssd.orderno >").append(ssr.get(0).getOrderno()).append(")")
			.append(" or (not ssr.orderno <").append(ssd.get(0).getOrderno()).append(")")
			.append(" )");
		}
		sql.append("   order by ts.seatno ");
		Query query = dao.getEntityManager().createNativeQuery(sql.toString(),Ticketsell.class);
		query.setParameter("departdate", scheduleplan.getDepartdate());
		query.setParameter("scheduleplanid", scheduleplan.getId());
		selledseats = query.getResultList();
		return selledseats;
	}
	
	private List<cn.nova.bus.netsale.model.Ticketprice> ConvertTicketpriceToCentre(List<Ticketprice> ticketprices){
		if(ticketprices==null){
			return null;
		}
		else{
			List<cn.nova.bus.netsale.model.Ticketprice> result = new ArrayList<cn.nova.bus.netsale.model.Ticketprice>();
			for (Ticketprice ticketprice : ticketprices) {
				cn.nova.bus.netsale.model.Ticketprice centreTicketprice = new cn.nova.bus.netsale.model.Ticketprice();
				centreTicketprice.setAutocancelreserveseatnum(ticketprice.getAutocancelreserveseatnum());
				centreTicketprice.setBalancedistance(ticketprice.getBalancedistance());
				centreTicketprice.setDepartdate(ticketprice.getDepartdate());
//				centreTicketprice.setDepartstationcode(departstationcode)
				centreTicketprice.setDistance(ticketprice.getDistance());
				centreTicketprice.setFixedreserveseatnum(ticketprice.getFixedreserveseatnum());
				centreTicketprice.setFueladditionfee(ticketprice.getFueladditionfee());
				centreTicketprice.setFullprice(ticketprice.getFullprice());
				centreTicketprice.setIssellable(ticketprice.getIssellable());
				centreTicketprice.setHalfprice(ticketprice.getHalfprice());
				centreTicketprice.setLowerlimitprice(ticketprice.getLowerlimitprice());
//				centreTicketprice.setOrgcode(orgcode);
//				centreTicketprice.setReachstationcode(reachstationcode);
				centreTicketprice.setRuntime(ticketprice.getRuntime());
//				centreTicketprice.setSchedulecode(schedulecode);
				centreTicketprice.setSeatnos(ticketprice.getSeatnos());
				centreTicketprice.setSeatnum(ticketprice.getSeatnum());
				centreTicketprice.setSeattype(ticketprice.getSeattype());
				centreTicketprice.setSoldeatnum(ticketprice.getSoldeatnum());
				centreTicketprice.setStationservicefee(ticketprice.getStationservicefee());
				centreTicketprice.setStudentprice(ticketprice.getStudentprice());
				centreTicketprice.setToplimitprice(ticketprice.getToplimitprice());
				centreTicketprice.setUnautocancelreserveseatnum(ticketprice.getUnautocancelreserveseatnum());
				centreTicketprice.setRoundprice(ticketprice.getRoundprice() != null ? ticketprice.getRoundprice() :BigDecimal.ZERO);
				centreTicketprice.setConnectprice(ticketprice.getConnectprice() != null ? ticketprice.getConnectprice() : BigDecimal.ZERO);
				centreTicketprice.setDiscountprice(ticketprice.getDiscountprice() != null ? ticketprice.getDiscountprice() : BigDecimal.ZERO);
				result.add(centreTicketprice);
			}
			return result;
		}
	}

	@Override
	public MethodResult findScheduleseats(Date departdate, String schedulesynccode) {
		MethodResult methodResult = new MethodResult();
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		//取班次
		Schedule schedule = scheduleDao.getScheduleBySyncCode(schedulesynccode);
//		if(!schedule.getIsactive()){
//			methodResult.setResult(0);
//			methodResult.setResultMsg("该班次已经注销!");
//			methodResult.setObject(ListUtil.listToMap(new Object[]{Scheduleseats.class}, null));
//			return methodResult;
//		}
		//取班次座位表
		propertyFilters.clear();
		propertyFilters.add(new PropertyFilter("EQD_t!departdate", departdate));
		propertyFilters.add(new PropertyFilter("EQL_t!scheduleid", schedule.getId()));
		List<Map<String,Object>> scheduleseats = ListUtil.listToMap(new Object[]{Scheduleseats.class}, dao.find(Scheduleseats.class, propertyFilters,new String[]{"t.seatno"}));
		methodResult.setResult(1);
		methodResult.setObject(scheduleseats);
		return methodResult;
	}

	@Override
	public MethodResult changeTicketNo(RemoteInvokeAuxiliaryProperty remoteInvokeAuxiliaryProperty,String oldTicketno, String newTicketNo){
		MethodResult methodResult = new MethodResult();
		Date now = new Date();
		//只有售票人或者换票人才允许重打
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		propertyFilters.add(new PropertyFilter("EQS_t!ticketno", oldTicketno));
		propertyFilters.add(new PropertyFilter("GED_t!departdate", DateUtils.trunc(now)));
		Ticketsell ticketsell = (Ticketsell) dao.uniqueResult(Ticketsell.class, propertyFilters);
		if(ticketsell==null){
			methodResult.setResultMsg("票源地找不到票号为"+oldTicketno+"的售票记录");
			TransactionUtil.setRollbackOnly();
			return methodResult;
		}
		//判断售票人是否为异站用户
		if(ticketsell.getSellby()>0){
			//换票号重打车票不允许重打他人售出的车票
			methodResult.setResultMsg(new ServiceException("0344").getExceptionMessage());
			TransactionUtil.setRollbackOnly();
			return methodResult;
		}
		else if(ticketsell.getSellby()==0){
			//判断是否是电子票
			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("EQL_t!ticketsellid", ticketsell.getId()));
			Ticketsellother ticketsellother = (Ticketsellother) dao.uniqueResult(Ticketsellother.class, propertyFilters);
			if(ticketsellother!=null){
				//换票号重打车票不允许重打他人售出的车票
				methodResult.setResultMsg(new ServiceException("0344").getExceptionMessage());
				TransactionUtil.setRollbackOnly();
				return methodResult;
			}
		}
		//取调用者机构
		Organization organization_client = organizationService.getOrgByCode(remoteInvokeAuxiliaryProperty.getOperateOrgcode());
		if(organization_client.getId()!=ticketsell.getOrgid()){
			//换票号重打车票不允许重打他人售出的车票
			methodResult.setResultMsg(new ServiceException("0344").getExceptionMessage());
			TransactionUtil.setRollbackOnly();
			return methodResult;
		}
		if(ticketsell.getIschecked()){
			methodResult.setResultMsg("该车票已检，不允许换票号");
			TransactionUtil.setRollbackOnly();
			return methodResult;
		}else if("1".equals(ticketsell.getTicketstatus())){
			methodResult.setResultMsg("该车票已退，不允许换票号");
			TransactionUtil.setRollbackOnly();
			return methodResult;
		}else if("2".equals(ticketsell.getTicketstatus())){
			methodResult.setResultMsg("该车票已废，不允许换票号");
			TransactionUtil.setRollbackOnly();
			return methodResult;
		}
//		Station reachstation = (Station) dao.get(Station.class, ticketsell.getReachstationid());
//		if(reachstation.getIsroundtrip()){
//			propertyFilters.clear();
//			propertyFilters.add(new PropertyFilter("EQB_t!isselfschedule", true));
//			propertyFilters.add(new PropertyFilter("EQL_t!sellid", ticketsell.getId()));
//			Returntripticket returntripticket = (Returntripticket) dao.uniqueResult(Returntripticket.class,propertyFilters);
//		}

		//修改票号
		ticketsell.setTicketno(newTicketNo);
		ticketsell.setUpdatetime(now);
		dao.merge(ticketsell);
		methodResult.setResult(MethodResult.SUCCESS);
		return methodResult;
	}

	public BalancedeductService getBalancedeductService() {
		return balancedeductService;
	}

	public void setBalancedeductService(BalancedeductService balancedeductService) {
		this.balancedeductService = balancedeductService;
	}

	public VehicleseatplanService getVehicleseatplanService() {
		return vehicleseatplanService;
	}

	public void setVehicleseatplanService(VehicleseatplanService vehicleseatplanService) {
		this.vehicleseatplanService = vehicleseatplanService;
	}

	public ScheduleDao getScheduleDao() {
		return scheduleDao;
	}

	public void setScheduleDao(ScheduleDao scheduleDao) {
		this.scheduleDao = scheduleDao;
	}

	public ScheduleperselldaysService getScheduleperselldaysService() {
		return scheduleperselldaysService;
	}

	public void setScheduleperselldaysService(ScheduleperselldaysService scheduleperselldaysService) {
		this.scheduleperselldaysService = scheduleperselldaysService;
	}

	public CustomerDao getCustomerDao() {
		return customerDao;
	}

	public void setCustomerDao(CustomerDao customerDao) {
		this.customerDao = customerDao;
	}

	public OrganizationService getOrganizationService() {
		return organizationService;
	}

	public void setOrganizationService(OrganizationService organizationService) {
		this.organizationService = organizationService;
	}

	@Override
	public String findSchedulestatus(Date departdate, String schedulesynccode) {
		//取班次
		play.Logger.info("ssl11:getschedule");
		Schedule schedule = scheduleDao.getScheduleBySyncCode(schedulesynccode);
		if(schedule==null){
			return "1"; //找不到班次时，返回停班状态
		}
		//取班次计划
		List<PropertyFilter> propertyFilters =  new ArrayList<PropertyFilter>();
		propertyFilters.clear();
		propertyFilters.add(new PropertyFilter("EQL_t!scheduleid", schedule.getId()));
		propertyFilters.add(new PropertyFilter("EQD_t!departdate", departdate));
		//Scheduleplan scheduleplan = (Scheduleplan) dao.uniqueResult(LockModeType.PESSIMISTIC_READ,Scheduleplan.class, propertyFilters);
		play.Logger.info("ssl112:getscheduleplan");
		Scheduleplan scheduleplan = (Scheduleplan) dao.uniqueResult(Scheduleplan.class, propertyFilters);
		if(scheduleplan==null){
			return "1"; //找不到班次计划时，返回停班状态
		}
		//取班次状态
		propertyFilters.clear();
		propertyFilters.add(new PropertyFilter("EQL_t!scheduleplan.id", scheduleplan.getId()));
		play.Logger.info("ssl113:getschedulestatus");
		List<Schedulestatus> schedulestatuss = dao.find(Schedulestatus.class, propertyFilters);
		if (schedulestatuss!=null&&schedulestatuss.size()>0){
			//将营运模式视为班次状态的一种，如果班次状态为正常0，这再取运营模式，看其是否为跨区配载3，如果不是则返回10
			return "0".equals(schedulestatuss.get(0).getStatus()) ? ("3".equals(scheduleplan.getWorktype()) ? "0" : "10") : schedulestatuss.get(0).getStatus();
		}else{
			return "1"; //找不到班次状态时，返回停班状态
		}
	}

	@Override
	public MethodResult modifySchedulePlanStatus(Date departdate,
			String schedulesynccode, String worktype) {
		MethodResult mr = new MethodResult(MethodResult.SUCCESS,"");
		//取班次
		Schedule schedule = scheduleDao.getScheduleBySyncCode(schedulesynccode);
		if(schedule==null){
			mr.setResultMsg("找不到班次，或者班次非正常状态");
		}
		//取班次计划
		List<PropertyFilter> propertyFilters =  new ArrayList<PropertyFilter>();
		propertyFilters.clear();
		propertyFilters.add(new PropertyFilter("EQL_t!scheduleid", schedule.getId()));
		propertyFilters.add(new PropertyFilter("EQD_t!departdate", departdate));
		//Scheduleplan scheduleplan = (Scheduleplan) dao.uniqueResult(LockModeType.PESSIMISTIC_READ,Scheduleplan.class, propertyFilters);
		Scheduleplan scheduleplan = (Scheduleplan) dao.uniqueResult(Scheduleplan.class, propertyFilters);
		if(scheduleplan==null){
			mr.setResultMsg("找不到班次计划，或者班次非正常状态");
		}
		schedule.setWorktype(worktype);
		scheduleplan.setWorktype(worktype);
		dao.merge(schedule);
		dao.merge(scheduleplan);
		
		List<UpdateSeatReserve> seatReserve = schPlanDao.querySeatReserve4Update(scheduleplan.getId());
		List<UpdateTicketSell> ticketSell = schPlanDao.queryTicketSell4Update(scheduleplan.getId());
		List<UpdateScheduleSeats> scheduleSeats = schPlanDao.queryScheduleSeat4Update(scheduleplan.getId());
		
		Object[] data = {seatReserve, ticketSell,scheduleSeats};
		mr.setObject(data);
		return mr;
	}
	
	/**
	 * 联网订票
	 * @param remoteInvokeAuxiliaryProperty
	 * @param paramSeatreserve
	 */
	public MethodResult reserveSeat(RemoteInvokeAuxiliaryProperty remoteInvokeAuxiliaryProperty, SeatreserveIn sin){
		MethodResult result = new MethodResult();
		
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		propertyFilters.clear();
		propertyFilters.add(new PropertyFilter("EQS_t!code", sin.getDepartStationCode()));
		Station dpstation = (Station) dao.uniqueResult(Station.class, propertyFilters);//发车站

		propertyFilters.clear();
		propertyFilters.add(new PropertyFilter("EQS_t!code", sin.getReachStationCode()));
		Station rpstation = (Station) dao.uniqueResult(Station.class, propertyFilters);//到达站

		propertyFilters.clear();
		propertyFilters.add(new PropertyFilter("EQS_t!code", remoteInvokeAuxiliaryProperty.getOperateOrgcode()));
		Organization reseveorg = (Organization) dao.uniqueResult(Organization.class,
				propertyFilters);// 调用者机构
		
		propertyFilters.clear();
		propertyFilters.add(new PropertyFilter("EQS_t!code", sin.getOrgcode()));
		Organization departOrg = (Organization) dao.uniqueResult(Organization.class,
				propertyFilters);//发车机构(本站)

		StringBuilder sql = new StringBuilder();
		sql.append("select sp from Scheduleplan sp, Schedule s ")
			.append(" where sp.departdate = :departdate ")
			.append("  and sp.scheduleid = s.id and s.synccode = :synccode");
		Query query = dao.getEntityManager().createQuery(sql.toString());
		query.setParameter("departdate", sin.getDepartDate());
		query.setParameter("synccode", sin.getSchedulesynccode());		
		List<Scheduleplan> sps = query.getResultList();
		if (sps == null ||sps.size()==0) {
			play.Logger.info("该班次不存在班次计划，班次同步码为：" + sin.getSchedulesynccode());
			result.setResult(0);
			result.setResultMsg("不存在该班次计划！");
			return result;
		}
		Scheduleplan scheduleplan = sps.get(0);//班次计划

		sql = new StringBuilder();
		sql.append("select ts from Ticketsell ts ")
			.append(" where ts.departdate = :departdate ")
			.append("   and ts.ticketstatus = '0' and ts.carrychildnum > 0")
			.append("   and ts.scheduleplanid = :scheduleplanid");
		query = dao.getEntityManager().createQuery(sql.toString());
		query.setParameter("departdate", scheduleplan.getDepartdate());
		query.setParameter("scheduleplanid", scheduleplan.getId());		
		List<Object> tickets = query.getResultList();
		int carrychildnum = 0;
		if(tickets != null && tickets.size()>0){
			carrychildnum = tickets.size();	//已售儿童数		
		}
		
		//存在免票儿童
		if(sin.getCarrychildnum() > 0){
			//查询售票点售票管理儿童数量以及售票点最大售票金额,携带儿童数量与系统配置取其低
			String ticketoutletName = sin.getTicketoutletsname();
			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("EQS_t!name", ticketoutletName));
			Ticketoutletsctr ticketoutletsctr = (Ticketoutletsctr) dao.uniqueResult(LockModeType.PESSIMISTIC_READ,Ticketoutletsctr.class,propertyFilters);
			int letoutCarryChild = 0;
			if(ticketoutletsctr != null ){
				double CarrychildRate = ticketoutletsctr.getCarrychildrate() / 100;
				letoutCarryChild = (int) (CarrychildRate * (scheduleplan.getSeatnum() - scheduleplan.getFixedreserveseatnum()));
			}else{
				letoutCarryChild = 99999999;
			}
			
			//1012班次最多免票带儿童数，0固定个数，1班次座位数的百分比，默认为1。提示:设置此参数后需设置参数1061才生效
			//1061班次最多免票带儿童数/班次最多带儿童占班次座位数的百分比。提示：设置此参数前需先设置参数1012
			//取售票点带儿童数量
			long maxChildNums = 0;
			String param1061 = parameterService.findParamValue(ParamterConst.Param_1061, departOrg.getId());
			if("1".equals(parameterService.findParamValue(ParamterConst.Param_1012, departOrg.getId()))){//比例
				float CarrychildRate = Float.valueOf(param1061) / 100;
				maxChildNums =(int) (CarrychildRate * (scheduleplan.getSeatnum() - scheduleplan.getFixedreserveseatnum()));
			}else{//固定数
				maxChildNums = new Integer(param1061);
			}
			
			maxChildNums = Math.min(letoutCarryChild, maxChildNums) + sin.getCarrychildnum();
			if(maxChildNums < scheduleplan.getCarrychildnum()){
				play.Logger.info("该班次剩余免票儿童数不够，已售免票儿童数" + carrychildnum);
				result.setResult(0);
				result.setResultMsg("该班次剩余免票儿童数不够，已售免票儿童数" + carrychildnum);
				return result;
			}
		}
		
		long createby = 0;
		Date now = new Date();
		
		Customer customer = null;
		if (sin.getCustomersynccode() != null) {
			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("EQS_t!synccode", sin.getCustomersynccode()));
			propertyFilters.add(new PropertyFilter("EQB_t!isactive", true));
			customer = (Customer) dao.uniqueResult(Customer.class, propertyFilters);
		} 
		if(customer == null){
			customer = new Customer();
			customer.setOrgid(reseveorg.getId());// 录入车站
			customer.setCertificateno(sin.getCertificateno());
			customer.setCertificatetype(sin.getCertificatetype());
			customer.setMobilephone(sin.getMobilephone());
			customer.setName(sin.getName());
			customer.setSex(sin.getSex());
			customer.setInputway("3");// 3订票
			customer.setCreateby(0L);
			customer.setCreatetime(new Date());
			customer.setUpdateby(0L);
			customer.setUpdatetime(new Date());
			customer.setLastbuytickettime(new Date());
		}
		try {
			CustomerService customerService = new CustomerServiceImpl();
			customer = customerService.saveCustomer(customer);
//			dao.getEntityManager().flush();
		} catch (Exception e) {
			play.Logger.error("保存顾客信息报错：" + e.getMessage());
			result.setResult(0);
			result.setResultMsg("保存顾客信息报错：" + e.getMessage());
			return result;
		}

		List<Schedulestatus> schedulestatus = scheduleplan
				.getSchedulestatuslist();
		// 判断Scheduleplan schedulestatus是否为空、是否已发班
		// 判断Scheduleseats是否为空、是否允许留位

		if (schedulestatus.size() <= 0) {
			result.setResult(0);
			result.setResultMsg("不存在该班次计划！");
			return result;
		}
		
		String departtime = "";
		for (int i = 0; i < schedulestatus.size(); i++) {
			if (dpstation.getId() == schedulestatus.get(i).getDepartstationid()) {
				departtime = (schedulestatus.get(i).getDeparttime());
				if (schedulestatus.get(i).getIsdeparted()) {
					result.setResult(0);
					result.setResultMsg("该班次已经发班！");
					return result;
				}
			}
		}

		for (Seatreserveno seat : sin.getSeatlist()) {
			short seatno = seat.getSeatno();
			Seatreserve seatreserve = new Seatreserve();
			seatreserve.setDepartdate(scheduleplan.getDepartdate());
			byte curcarrychildnum = sin.getCarrychildnum();
			if(curcarrychildnum > 0){
				seatreserve.setCarrychildnum((byte) 1);
				curcarrychildnum = (byte) (curcarrychildnum - 1);
			}else{
				seatreserve.setCarrychildnum((byte) 0);
			}
			seatreserve.setAutocanceltime(sin.getAutocanceltime());
			seatreserve.setCreateby(createby);
			seatreserve.setCreatetime(now);
			seatreserve.setCustomer(customer);
			seatreserve.setDeparttime(departtime);
			seatreserve.setDepartstationid(dpstation.getId());
			seatreserve.setDepartstation(dpstation);
			seatreserve.setReachstation(rpstation);
			seatreserve.setOrgid(scheduleplan.getOrgid());
			seatreserve.setFullprice(seat.getPrice());
			seatreserve.setIsautocancel(sin.isIsautocancel());
			seatreserve.setReserveorgid(reseveorg.getId());//留票机构
			seatreserve.setReachstationid(dpstation.getId());
			seatreserve.setReserveby((long) 0);
			seatreserve.setReserveip(sin.getReserveIp());
			seatreserve.setReservetime(now);
			seatreserve.setReserveway("1");// 订票
			seatreserve.setScheduleid(scheduleplan.getScheduleid());
			seatreserve.setScheduleplanid(scheduleplan.getId());
			seatreserve.setSeatno(seatno);
			seatreserve.setSellstate("R");
			seatreserve.setServiceprice(sin.getServiceprice());
			seatreserve.setTicketoutletsid((long) 0);
			seatreserve.setTickettype(seat.getTickettype());
			seatreserve.setUpdateby((long) 0);
			seatreserve.setUpdatetime(now);
            //锁住座位
			ScheduleseatsService scheduleseatsService = new ScheduleseatsServiceImpl();
			Scheduleseats scheduleseats = scheduleseatsService.findBySeatno(
					seatreserve.getScheduleplanid(), seatreserve.getSeatno());
			seatreserve.setSeatno(seatreserve.getSeatno());
			SeatlockDao seatlockDao = new SeatlockDao();
			if ("1".equals(scheduleseats.getStatus())) {
				Seatlock seatlock = seatlockDao.getSeatlock(
						seatreserve.getScheduleplanid(),
						seatreserve.getSeatno());
				if (seatlock != null) {
					if (seatreserve.getCreateby() == seatlock.getLockby()) {
						seatlockDao.delete(seatlock);// 如果是自己锁的位子可以留位，并将锁位表的这个座位号删除
					} else {
//						context.setRollbackOnly();
						play.Logger.info("座位号：" + seatreserve.getSeatno()+ "已经发生变化");
						result.setResult(0);
						result.setResultMsg("座位号：" + seatreserve.getSeatno()+ "已经发生变化");
						return result;
					}
				}
			} else if (!"0".equals(scheduleseats.getStatus())) {
//				context.setRollbackOnly();
				play.Logger.info("座位号：" + seatreserve.getSeatno()+ "已经发生变化");
				result.setResult(0);
				result.setResultMsg("座位号：" + seatreserve.getSeatno() + "已经发生变化");
				return result;
			}
			if (seatreserve.isIsautocancel()) {
				scheduleseats.setStatus("4");
			} else {
				scheduleseats.setStatus("5");
			}

			scheduleseats.setUpdateby(seatreserve.getUpdateby());
			scheduleseats.setUpdatetime(seatreserve.getUpdatetime());
			dao.merge(seatreserve);// 座位预留时增加记录
			dao.merge(scheduleseats);// 更新班次的座位状态

			// 更新 ticketprice
			TicketpriceService ticketpriceService = new TicketpriceServiceImpl();
			List<Ticketprice> list = ticketpriceService
					.getByScheduleplanSeattype(LockModeType.PESSIMISTIC_READ,
							seatreserve.getScheduleplanid(),
							scheduleseats.getSeattype());
			for (Ticketprice ticketprice : list) {
				// 不能改所有票价记录，只能改座位号对应的座位类型票价
				if (ticketprice.getSeatnos() != null
						&& !ticketprice.getSeatnos().trim().equals("")
						&& !ticketprice.getSeatnos().trim().equals("0")) {
					String seattypeSeatnos = ","
							+ ticketprice.getSeatnos().trim() + ",";
					if (!seattypeSeatnos.contains("," + seatreserve.getSeatno()
							+ ",")) {
						if (!ticketprice.getSeatnos().trim().equals("全部")) {
							continue;
						}
					}
				}
				if (seatreserve.isIsautocancel()) {
					short num = (short) (ticketprice
							.getAutocancelreserveseatnum() + 1);
					ticketprice.setAutocancelreserveseatnum(num);
				} else {
					short num = (short) (ticketprice
							.getUnautocancelreserveseatnum() + 1);
					ticketprice.setUnautocancelreserveseatnum(num);
				}
				ticketprice.setUpdateby(seatreserve.getUpdateby());
				// 暂时不更新修改时间
				// ticketprice.setUpdatetime(seatreserve.getUpdatetime());
				dao.merge(ticketprice);
			}

			if (seatreserve.isIsautocancel()) {
				short s = (short) (scheduleplan.getAutocancelreserveseatnum() + 1);
				scheduleplan.setAutocancelreserveseatnum(s);// 设置计划班次的自动取消留位数(之前预留的+留位的)
			} else {
				short s = (short) (scheduleplan.getUnautocancelreserveseatnum() + 1);
				scheduleplan.setUnautocancelreserveseatnum(s);// 设置计划班次的不自动取消留位数(之前预留的+留位的)
			}
			scheduleplan.setCarrychildnum((short) (scheduleplan
					.getCarrychildnum() + seatreserve.getCarrychildnum()));
			dao.merge(scheduleplan);// 更新scheduleplan
		}
		
		result.setResult(MethodResult.SUCCESS);
		result.setObject(sin);
		result.setResultMsg("订票成功！");
		return result;
	}
}
