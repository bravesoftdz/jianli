package cn.nova.bus.checkticket.service.impl;

import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.LockModeType;

import models.ActionNode;

import org.apache.commons.lang.ArrayUtils;

import util.Appvar;
import util.CurrentUtil;
import cn.nova.bus.balance.model.Vehicleviolation;
import cn.nova.bus.balance.service.BalancedeductService;
import cn.nova.bus.balance.service.impl.BalancedeductServiceImpl;
import cn.nova.bus.balance.vo.TicketoutletsTicket;
import cn.nova.bus.base.model.Schedule;
import cn.nova.bus.base.model.Schedulestop;
import cn.nova.bus.base.model.Station;
import cn.nova.bus.base.model.Ticketoutlets;
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
import cn.nova.bus.checkticket.dao.DepartinvoiceDao;
import cn.nova.bus.checkticket.model.Departinvoices;
import cn.nova.bus.checkticket.model.Departinvoicesdeductdetail;
import cn.nova.bus.checkticket.model.Departinvoicesdetail;
import cn.nova.bus.checkticket.service.DepartinvoiceService;
import cn.nova.bus.checkticket.vo.DepartinvoicesVo;
import cn.nova.bus.common.ConstDefiniens;
import cn.nova.bus.common.ParamterConst;
import cn.nova.bus.dispatch.model.Vehicledriverreport;
import cn.nova.bus.dispatch.model.Vehiclereport;
import cn.nova.bus.dispatch.plugin.PluginFunction;
import cn.nova.bus.exception.BusinessException;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.log.model.Operationlog;
import cn.nova.bus.log.service.OperationLogService;
import cn.nova.bus.log.service.impl.OperationLogServiceImpl;
import cn.nova.bus.pack.model.Pack;
import cn.nova.bus.price.model.Scheduleplan;
import cn.nova.bus.price.model.Scheduleseats;
import cn.nova.bus.price.model.Schedulestatus;
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

/**
 * @author lck
 * 
 */
public class DepartinvoiceServiceImpl implements DepartinvoiceService {

	
	private BilltypeService billtypeService = new BilltypeServiceImpl();
	
	
	private OperationLogService operationLogService = new OperationLogServiceImpl();
	
//	private BillinventoryService billinventoryService = new BillinventoryServiceImpl();

	
	private DepartinvoiceDao departinvoiceDao = new DepartinvoiceDao();
	
	private BalancedeductService balancedeductService = new BalancedeductServiceImpl();

	
	private ParameterService parameterService = new ParameterServiceImpl();

	
	private BillinuseService billinuseService = new BillinuseServiceImpl();
	
	//private OrganizationService organService = new OrganizationServiceImpl(); 
	
	@SuppressWarnings("unchecked")
	private List<Map<String, Object>> vehicleDepartinvoice(Global global,
			long scheduleplanid, long vehiclereportid, String printip,Billtype billtype ,
			String departinvoicesno, String printway, boolean iscomputeno) throws ServiceException, ParseException {
		long createdby=global.getUserinfo().getId();
		Billinuse billinuse = billinuseService.getBilluse(billtype.getId(),
				createdby, new Long(departinvoicesno));
		String curDepartinvoicesno =departinvoicesno;
		if (iscomputeno) {
			if (billinuse == null || "2".equals(billinuse.getStatus())) {
				// 您的票据已经用完
				throw new ServiceException("0143");
			}
			// 补零操作
			curDepartinvoicesno = String.valueOf(billinuse.getNextno());

			if (billtype.getTicketnolength() != curDepartinvoicesno.length()) {
				curDepartinvoicesno = StringUtils.strPad(curDepartinvoicesno,
						(int) billtype.getTicketnolength(), "0");
			}
			if (!curDepartinvoicesno.equals(departinvoicesno)) {
				// 您的票据当前号码与系统的号码不一致，请重置票号！
				throw new ServiceException("0144");
			}
		}
		Userinfo departinvoicesby = global.getUserinfo();
		long orgid=global.getOrganization().getId();
		Scheduleplan scheduleplan = (Scheduleplan) departinvoiceDao.get(
				Scheduleplan.class, scheduleplanid);
		int limitday = new Integer(parameterService.findParamValue(ParamterConst.Param_3041,
				orgid));
		if (DateUtils.getIntervalDays(scheduleplan.getDepartdate(), new Date()) > limitday) {
			// 已超过补开结算单天数
			throw new ServiceException("0367");
		}
		Vehiclereport vehiclereport = null;
		if (scheduleplan.getIslinework()) {
			play.Logger.info("---------------流水班自助发班打印结算单开始--------------------");
			if (vehiclereportid == 0) {
				// 请选择你要打单的报到车辆！
				throw new ServiceException("0145");
			} else {
				vehiclereport = (Vehiclereport) departinvoiceDao.get(
						Vehiclereport.class, vehiclereportid);
				play.Logger.info("---流水班报到班次的班次计划---"+vehiclereport.getScheduleplanid()+"--流水班报到车辆"+vehiclereport.getVehicleid());
				play.Logger.info("---流水班报到班次报到主键---"+vehiclereport.getId()+"--流水班报到时间----"+vehiclereport.getReporttime()+"流水班报到序号"+vehiclereport.getOrderno());
			}
			play.Logger.info("---------------流水班自助发班打印结算单结束--------------------");
		} else {
			play.Logger.info("---------------非流水班自助发班打印结算单开始--------------------");
			vehiclereport = departinvoiceDao.getVehiclereport(scheduleplan,
					orgid);
			play.Logger.info("---非流水班报到班次的班次计划---"+vehiclereport.getScheduleplanid()+"--非流水班报到车辆"+vehiclereport.getVehicleid());
			play.Logger.info("---非流水班报到班次报到主键---"+vehiclereport.getId()+"--非流水班报到时间----"+vehiclereport.getReporttime());
			play.Logger.info("---------------非流水班自助发班打印结算单结束--------------------");
		}
		if (vehiclereport == null) {
			throw new ServiceException("0145");
		}

		//如果是隔天班次
		if (DateUtils.compare(scheduleplan.getDepartdate(),new Date())==-1){
			//隔天班次开运量时是否必须用补开
			String ismastbe = parameterService.findParamValue(ParamterConst.Param_3101,departinvoicesby.getOrgid());
			if(ismastbe.equals(ParamterConst.COMMON_FLAG.FALG_YES)&&printway.equals("0")){
				//隔天班次开运量时必须用补开
				throw new ServiceException("0433");
			}
		}
		long departstationid=global.getOrganization().getStation().getId();
		// 获取班次状态并锁住
		Schedulestatus schedulestatus = departinvoiceDao.getSchedulestatus(
				scheduleplanid, departstationid);
		Schedule schedule =(Schedule) departinvoiceDao.get(Schedule.class, scheduleplan.getScheduleid());
		if (schedulestatus == null) {
			if(schedule.getWorktype().equals("2")||
					schedule.getWorktype().equals("3")){
				long startstationid=schedule.getRoute().getStartstationid();
				schedulestatus = departinvoiceDao.getSchedulestatus(scheduleplanid, startstationid);						
			}
			else{
				// 当前站点不是发班站点，不能进行发班操作！
				throw new ServiceException("0182");
			}
		}
		if (iscomputeno && !printway.equals("2") &&!printway.equals("1")
				&& !scheduleplan.getIslinework()
				&& schedulestatus.getIsdeparted()) {
			// 该班次已经发班！
			throw new ServiceException("0183");
		}
		// 查询所有已检车票,但是本站上车未开结算单的车票信息
		
		
		String isprintbyorgid = parameterService.findParamValue(ParamterConst.Param_9080,departinvoicesby.getOrgid());

		List<Ticketsell> ticketsells = null;
		List<TicketoutletsTicket> tslists = null;
		List<RemoteTicketsell> rtickets= new ArrayList<RemoteTicketsell>();
		//long[] orgids = null;  //售票机构数组
		int ticketnum = 0;
		TicketoutletsTicket curtslist = new TicketoutletsTicket();//保存本站的售票
		if (isprintbyorgid.equals(ParamterConst.COMMON_FLAG.FALG_YES)){ //发班时是否按售票站打印结算单,0:否;1:是
			// 本地票
			ticketsells = departinvoiceDao.getUnDepartTickets(
					scheduleplanid, vehiclereport.getId(), departstationid);
			//远检的票
			rtickets= departinvoiceDao.qryRemoteTicketsell(scheduleplanid, vehiclereport.getId());
			for(RemoteTicketsell rs:rtickets){
					Ticketsell ts=new Ticketsell();
					ts.setAdditionfee(rs.getAdditionfee());
					ts.setBatchno(rs.getBatchno());
					ts.setCarrychildnum(rs.getCarrychildnum());
					ts.setComputefee(rs.getComputefee());
					ts.setCoolairfee(rs.getCoolairfee());
					ts.setDepartdate(rs.getDepartdate());
					ts.setFueladditionfee(rs.getFueladditionfee());
					ts.setFullprice(rs.getFullprice());
					ts.setInsurefee(rs.getInsurefee());
					ts.setIschecked(true);
					ts.setTicketoutletsid(0);
					ts.setTicketoutletsname(rs.getTicketoutletsname());
					ts.setId(0);
					ts.setMoreprice(rs.getMoreprice());
					ts.setOtherfee(rs.getOtherfee());
					ts.setDepartstationid(rs.getDepartstationid());
					ts.setPrice(rs.getPrice());
					ts.setReachstationid(rs.getReachstationid());
					ts.setScheduleid(schedule.getId());
					ts.setScheduleplanid(scheduleplan.getId());
					ts.setSeatno(rs.getSeatno());
					ts.setStationservicefee(rs.getStationservicefee());
					ts.setTicketno(rs.getTicketno());
					ts.setTicketstatus(rs.getTicketstatus());
					ts.setTickettype(rs.getTickettype());
					ts.setWaterfee(rs.getWaterfee());
					ts.setDistance(rs.getDistance());
					ticketsells.add(ts);
			}	
			//要打印的售票点
            List<Ticketoutlets> outletslist=departinvoiceDao.qryTicketoutlets();
            List<TicketoutletsTicket> _tslists =  new ArrayList<TicketoutletsTicket>();		
			//TicketoutletsTicket curtslist = new TicketoutletsTicket();//保存本站的售票
			for(Ticketoutlets lets:outletslist){
				//初始化其他售票点要打印的售票点
				if(lets.getType().equals("0") && global.getOrganization().getId()==lets.getOrgid()){
					curtslist.setTicketoutlet(lets);
				}else{
					TicketoutletsTicket clets = new TicketoutletsTicket();
					clets.setTicketoutlet(lets);
					_tslists.add(clets);
				}				
			}
		
			for(Ticketsell ts:ticketsells){			
				boolean isfind=false;
				for(TicketoutletsTicket lets:_tslists){
					//其他售票点的售票	
					Ticketoutlets let=lets.getTicketoutlet();
					if (ts.getTicketoutletsid()==let.getId() || (ts.getTicketoutletsname()!=null && ts.getTicketoutletsname().equals(let.getName()))){
						//其他售票点的售票
						lets.getTicketlist().add(ts);
						isfind=true;
						break;
				    }			    				    
			    }
				if(!isfind){
			    	curtslist.getTicketlist().add(ts);
				}
			}
			tslists=  new ArrayList<TicketoutletsTicket>();	
			for(TicketoutletsTicket lets:_tslists){
				if(lets.getTicketlist().size()>0){
					tslists.add(lets);
				}
			}
			ticketnum = ticketsells.size();// 人数 			
			if(curtslist.getTicketlist().size()>0){
				tslists.add(curtslist);							
			}
				
		}else{						
			 ticketsells = departinvoiceDao.getUnDepartTickets(
					scheduleplanid, vehiclereport.getId(), departstationid);
			 ticketnum = ticketsells.size();// 人数	       	   			
		}
		//发班时，将（检票数）实载人数记录到车辆应班登记表中
		if (!"0".equals(scheduleplanid) ){
			modifyVehicledriverreport(scheduleplanid,ticketnum);
		}		
		// 若为正班要判断发班时间
		if (iscomputeno && !scheduleplan.getIslinework()) {
			// 已售数大于已检数
			if (scheduleplan.getSoldeatnum() > ticketnum
					|| (scheduleplan.getSeatnum()
							- scheduleplan.getFixedreserveseatnum()
							- scheduleplan.getAutocancelreserveseatnum()
							- scheduleplan.getUnautocancelreserveseatnum() - scheduleplan
							.getSoldeatnum()) > 0) {
				String departmin = parameterService.findParamValue(ParamterConst.Param_3008,
						orgid);
				int minutes = 0;
				try {
					minutes = new Integer(departmin);
				} catch (Exception e) {
					play.Logger.error(e.getMessage(), e);
				}
				if (minutes > 0) {
					// 判断班次发班时间
					SimpleDateFormat sf = new SimpleDateFormat(
							"yyyy-MM-dd HH:mm");
					try {
						Date curdatetime = sf.parse(sf.format(new Date()));
						Date depardatetime = sf.parse(scheduleplan
								.getDepartdate()
								+ " "
								+ schedulestatus.getDeparttime());
						long departtimel = (depardatetime.getTime()) / 1000 / 60;
						long curtimel = (curdatetime.getTime() + minutes * 60 * 1000) / 1000 / 60;
						if (departtimel > curtimel) {
							// 未到发班时间，不允许发班！
							throw new ServiceException("0303");
						}
					} catch (ParseException e) {
						play.Logger.error(e.getMessage(), e);
					}
				}
			}
		}
		
		Date now=new Date();
		Vehicle vehicle = (Vehicle) departinvoiceDao.get(Vehicle.class,
				vehiclereport.getVehicleid());
		Vehicletype vehicletype = (Vehicletype) departinvoiceDao.get(
				Vehicletype.class, vehicle.getVehicletypeid());
		Vehiclebrandmodel vb = (Vehiclebrandmodel) departinvoiceDao.get(
				Vehiclebrandmodel.class, vehicle.getVehiclebrandmodelid());		
		Unit unit = (Unit) departinvoiceDao.get(Unit.class, vehicle.getUnitid());
		Unit balanceunit = (Unit) departinvoiceDao.get(Unit.class,vehicle.getBalanceunitid());
		List<Object> dvlist=new ArrayList<Object>();
		DepartinvoicesVo departinvoicesVo=new DepartinvoicesVo();
		
		String isprintZeroBalance = parameterService.findParamValue(ParamterConst.Param_8044,departinvoicesby.getOrgid());//是否打印空结算单

		if(isprintbyorgid.equals(ParamterConst.COMMON_FLAG.FALG_YES)){     //发班时是否按售票站打印结算单,0:否;1:是
				if(ticketsells.size()==0){//若是无票打印空单
				  if(isprintZeroBalance.equals(ParamterConst.COMMON_FLAG.FALG_YES)){//发班时是否打印空结算单,0:否;1:是
					departinvoicesVo =createDepartinvoice(global,scheduleplan,vehicle,
							ticketsells,vehiclereport,now,vehicletype,vb ,unit ,balanceunit,schedulestatus.getDeparttime(),
							iscomputeno, printip,departinvoicesno,printway);
					if(curtslist.getTicketoutlet()!=null){
						departinvoicesVo.setTicketoutname(curtslist.getTicketoutlet().getName());
						departinvoicesVo.setTicketoutshort(curtslist.getTicketoutlet().getJianpin());
					}
					departinvoicesVo.setVehiclecolor(departinvoiceDao.qryVehicleColor(vehiclereport.getId()));//车牌颜色
					departinvoicesVo.setBupiaonum(departinvoiceDao.qryBupiaoNum(vehiclereport.getScheduleplanid()));//补票人数
					dvlist.add(departinvoicesVo);
					if (iscomputeno) {
						billinuse.setNextno(billinuse.getNextno() + 1);
						curDepartinvoicesno = billinuse.getNextno() + "";
						if (billtype.getTicketnolength() != curDepartinvoicesno
								.length()) {
							curDepartinvoicesno = StringUtils.strPad(
									curDepartinvoicesno,
									(int) billtype.getTicketnolength(), "0");
						}
					}
					long  dinvoicesno = Long.parseLong(departinvoicesno);
					dinvoicesno++;
					departinvoicesno = String.valueOf(dinvoicesno);
					departinvoicesno = StringUtils.strPad(departinvoicesno,
							(int) billtype.getTicketnolength(), "0");
				  }
				}else{
					for (TicketoutletsTicket ticketselllist : tslists) {
						departinvoicesVo = createDepartinvoice(global,
									scheduleplan, vehicle, ticketselllist.getTicketlist(),
									vehiclereport, now, vehicletype, vb, unit,
									balanceunit, schedulestatus.getDeparttime(),
									iscomputeno, printip, departinvoicesno,
									printway);
							
							//Logger.info("ticketselllist.getTicketoutlet()  ==  " +ticketselllist.getTicketoutlet());
							//售票点不能为空
							if (ticketselllist.getTicketoutlet() != null 
									&& !"".equals(ticketselllist.getTicketoutlet()) ){
								departinvoicesVo.setTicketoutname(ticketselllist.getTicketoutlet().getName());
								departinvoicesVo.setTicketoutshort(ticketselllist.getTicketoutlet().getJianpin());
							}
							departinvoicesVo.setVehiclecolor(departinvoiceDao.qryVehicleColor(vehiclereport.getId()));//车牌颜色
							departinvoicesVo.setBupiaonum(departinvoiceDao.qryBupiaoNum(vehiclereport.getScheduleplanid()));//补票人数
							dvlist.add(departinvoicesVo);
							if (iscomputeno) {
								billinuse.setNextno(billinuse.getNextno() + 1);
								curDepartinvoicesno = billinuse.getNextno() + "";
								if (billtype.getTicketnolength() != curDepartinvoicesno
										.length()) {
									curDepartinvoicesno = StringUtils
											.strPad(curDepartinvoicesno,
													(int) billtype
															.getTicketnolength(),
													"0");
								}
							}
							long dinvoicesno = Long.parseLong(departinvoicesno);
							dinvoicesno++;
							departinvoicesno = String.valueOf(dinvoicesno);
							departinvoicesno = StringUtils.strPad(departinvoicesno,
									(int) billtype.getTicketnolength(), "0");	
							
						//远检车票结算单号要进行的操作
							if(rtickets.size()>0&&ticketselllist.getTicketoutlet().getName().equals(rtickets.get(0).getTicketoutletsname())){
								  for(RemoteTicketsell rs:rtickets){
									rs.setDepartinvoicesid(departinvoicesVo.getId());
									rs.setIsdepartinvoices(true);
									rs.setUpdateby(createdby);
									rs.setUpdatetime(new Date());
									rs.setDepartinvoicesby(departinvoicesby.getId());
									rs.setDepartinvoicestime(new Date());
									departinvoiceDao.getEntityManager().merge(rs);
								 }
							    }
	
					}
					
				}		
			}else{	
				if(ticketsells.size()==0){//若是无票打印空单
					  if(isprintZeroBalance.equals(ParamterConst.COMMON_FLAG.FALG_YES)){//发班时是否打印空结算单,0:否;1:是
						departinvoicesVo =createDepartinvoice(global,scheduleplan,vehicle,
								ticketsells,vehiclereport,now,vehicletype,vb ,unit ,balanceunit,schedulestatus.getDeparttime(),
								iscomputeno, printip,departinvoicesno,printway);
						if(curtslist.getTicketoutlet()!=null){
							departinvoicesVo.setTicketoutname(curtslist.getTicketoutlet().getName());
							departinvoicesVo.setTicketoutshort(curtslist.getTicketoutlet().getJianpin());
						}
						departinvoicesVo.setVehiclecolor(departinvoiceDao.qryVehicleColor(vehiclereport.getId()));//车牌颜色
						departinvoicesVo.setBupiaonum(departinvoiceDao.qryBupiaoNum(vehiclereport.getScheduleplanid()));//补票人数
						dvlist.add(departinvoicesVo);	
						if (iscomputeno) {
							billinuse.setNextno(billinuse.getNextno() + 1);
							curDepartinvoicesno = billinuse.getNextno() + "";
							if (billtype.getTicketnolength() != curDepartinvoicesno
									.length()) {
								curDepartinvoicesno = StringUtils.strPad(
										curDepartinvoicesno,
										(int) billtype.getTicketnolength(), "0");
							}
						}
						long  dinvoicesno = Long.parseLong(departinvoicesno);
						dinvoicesno++;
						departinvoicesno = String.valueOf(dinvoicesno);
						departinvoicesno = StringUtils.strPad(departinvoicesno,
								(int) billtype.getTicketnolength(), "0");
					  }
				}else{
					if((printway.equals("0"))|| (ticketsells.size()>0) ){	
						departinvoicesVo =createDepartinvoice(global,scheduleplan,vehicle,
								ticketsells,vehiclereport,now,vehicletype,vb ,unit ,balanceunit,schedulestatus.getDeparttime(),
								iscomputeno, printip,departinvoicesno,printway);
						departinvoicesVo.setVehiclecolor(departinvoiceDao.qryVehicleColor(vehiclereport.getId()));//车牌颜色
						departinvoicesVo.setBupiaonum(departinvoiceDao.qryBupiaoNum(vehiclereport.getScheduleplanid()));//补票人数
						dvlist.add(departinvoicesVo);	
						if (iscomputeno) {
							billinuse.setNextno(billinuse.getNextno() + 1);
							curDepartinvoicesno = billinuse.getNextno() + "";
							if (billtype.getTicketnolength() != curDepartinvoicesno
									.length()) {
								curDepartinvoicesno = StringUtils.strPad(
										curDepartinvoicesno,
										(int) billtype.getTicketnolength(), "0");
							}
						}
					}
					
					List<Object> remoteorgids=departinvoiceDao.qryRemoteTickOrgid(scheduleplanid, vehiclereport.getId());
					for(Object orgido:remoteorgids){
						long remoteorgid=new Long(orgido.toString());
						ticketsells.clear();
						rtickets=departinvoiceDao.getUnRemoteTicket(scheduleplanid, vehiclereport.getId(),remoteorgid);
						for(RemoteTicketsell rs:rtickets){
							Ticketsell ts=new Ticketsell();
							ts.setAdditionfee(rs.getAdditionfee());
							ts.setBatchno(rs.getBatchno());
							ts.setCarrychildnum(rs.getCarrychildnum());
							ts.setComputefee(rs.getComputefee());
							ts.setCoolairfee(rs.getCoolairfee());
							ts.setDepartdate(rs.getDepartdate());
							ts.setFueladditionfee(rs.getFueladditionfee());
							ts.setFullprice(rs.getFullprice());
							ts.setInsurefee(rs.getInsurefee());
							ts.setIschecked(true);
							ts.setId(0);
							ts.setMoreprice(rs.getMoreprice());
							ts.setOtherfee(rs.getOtherfee());
							ts.setDepartstationid(rs.getDepartstationid());
							ts.setPrice(rs.getPrice());
							ts.setReachstationid(rs.getReachstationid());
							ts.setScheduleid(schedule.getId());
							ts.setScheduleplanid(scheduleplan.getId());
							ts.setSeatno(rs.getSeatno());
							ts.setStationservicefee(rs.getStationservicefee());
							ts.setTicketno(rs.getTicketno());
							ts.setTicketstatus(rs.getTicketstatus());
							ts.setTickettype(rs.getTickettype());
							ts.setWaterfee(rs.getWaterfee());
							ts.setDistance(rs.getDistance());
							ticketsells.add(ts);
						}
						curDepartinvoicesno=billinuse.getNextno()+"";
						if (billtype.getTicketnolength() != curDepartinvoicesno.length()) {
							curDepartinvoicesno = StringUtils.strPad(curDepartinvoicesno,
									(int) billtype.getTicketnolength(), "0");
						}					
						departinvoicesVo =createDepartinvoice(global,scheduleplan,vehicle,
								ticketsells,vehiclereport,now,vehicletype,vb ,unit ,balanceunit,schedulestatus.getDeparttime(),
								iscomputeno, printip,curDepartinvoicesno,printway);
						departinvoicesVo.setVehiclecolor(departinvoiceDao.qryVehicleColor(vehiclereport.getId()));//车牌颜色
						departinvoicesVo.setBupiaonum(departinvoiceDao.qryBupiaoNum(vehiclereport.getScheduleplanid()));//补票人数
						dvlist.add(departinvoicesVo);
						for(RemoteTicketsell rs:rtickets){
							rs.setDepartinvoicesid(departinvoicesVo.getId());
							rs.setIsdepartinvoices(true);
							rs.setUpdateby(createdby);
							rs.setUpdatetime(new Date());
							rs.setDepartinvoicesby(departinvoicesby.getId());
							rs.setDepartinvoicestime(new Date());
							departinvoiceDao.getEntityManager().merge(rs);
						}
						if (iscomputeno) {
							billinuse.setNextno(billinuse.getNextno() + 1);
						}
						
					}
				}
	
			}
			
		
		if (iscomputeno) {
			if (billinuse.getNextno() > billinuse.getEndno()+1) {
				// 当前票段剩余票数不够打印
				throw new ServiceException("0171");
			}
			// 本次若是最后一张票据
			if (billinuse.getNextno() > billinuse.getEndno()) {
				billinuse.setStatus("2");
			}
			billinuse.setUpdateby(createdby);
			billinuse.setUpdatetime(new Date());
			departinvoiceDao.getEntityManager().merge(billinuse);
		}
		// 更新班次状态,更新报道表vehiclereport
		// 若是流水班,判断以发报到车辆数
		if (scheduleplan.getIslinework()) {
			//流水班暂定为不修改状态
			/*int departcount = departinvoiceDao
					.getVehiclereportCount(vehiclereport);
			departcount++;
			int plancouont = scheduleplan.getSchedulevehiclepeopleplanlist()
					.size();
			if (departcount == plancouont) {
				// 若是最后一次报到车辆，则更新班次状态为发班状态
				schedulestatus.setIsdeparted(true);
			} else {
				if (departinvoiceDao.isexistVehiclereport(vehiclereport)) {
					schedulestatus.setIsdeparted(false);
				} else
				// 没有可发班报到车辆
				{
					schedulestatus.setIsreported(false);
					schedulestatus.setIsbegincheck(false);
					schedulestatus.setIsdeparted(false);
				}
			}*/
		} else {
			schedulestatus.setIsdeparted(true);
			if(schedule.getWorktype().equals("2")){
				List<Schedulestatus> sslist=scheduleplan.getSchedulestatuslist();
				for(Schedulestatus ss:sslist){
					ss.setUpdatetime(new Date());
					ss.setUpdateby(createdby);
					ss.setIsdeparted(true);
					departinvoiceDao.getEntityManager().merge(ss);
				}
			}
		}
		schedulestatus.setUpdateby(createdby);
		schedulestatus.setUpdatetime(new Date());
		vehiclereport.setIsdeparted(true);
		vehiclereport.setUpdateby(createdby);
		vehiclereport.setUpdatetime(new Date());
		departinvoiceDao.getEntityManager().merge(vehiclereport);
		departinvoiceDao.getEntityManager().merge(scheduleplan);
		return ListUtil.listToMap( new Object[]{DepartinvoicesVo.class},dvlist, new Object[]{DepartinvoicesVo.class});
	}
	
	/**
	 * //修改站外售票点的发车时间  禅道编号：9105  甘肃合作北站  涉及参数 3050
	 * @param scheduleplan
	 * @param departstationid
	 * @param scheduleid
	 * @param departinvoices
	 * @return
	 * @throws ParseException
	 */
	public boolean changeOutStationDeptime(Scheduleplan scheduleplan, long departstationid, long scheduleid,
			Departinvoices departinvoices) throws ParseException {
		// 集中式环境下，始发站未按正常点发班是否修改下一个配客站发车时间，0不修改，1修改，默认为0.参数设置为1时，按始发站延时时长自动延长/缩短配客站计划发车时间。
		String p3050 = parameterService.findParamValue(ParamterConst.Param_3050, scheduleplan.getOrgid());
		if ("1".equals(p3050)) {
			Schedulestatus nextschedulestatus = departinvoiceDao.getSchedulestatus(scheduleplan.getId(), departstationid,scheduleplan.getScheduleid());
			if(nextschedulestatus==null){
				return false;
			}
			Schedulestop nextschedulestop = departinvoiceDao.getTwoStationDepTime(scheduleplan.getId(), departstationid);
			Scheduleplan nextscheduleplan = nextschedulestatus.getScheduleplan();
			SimpleDateFormat dep = new SimpleDateFormat("yyyy-MM-dd HH:mm"); 
			// 应发班时间
			Date deptime = dep.parse(scheduleplan.getDepartdate() + " "+ scheduleplan.getStarttime());
			//下一班应发班时间
			Date nextdeptime = dep.parse(nextschedulestatus.getDepartdate() + " "+ nextschedulestop.getDeparttime());
			// (实际发班时间 - 应发班时间) + 下一班应发班时间
			nextdeptime = new Date(nextdeptime.getTime() + (departinvoices.getCreatetime().getTime() - deptime.getTime()));
			dep = new SimpleDateFormat("HH:mm"); 
			nextschedulestatus.setDeparttime(dep.format(nextdeptime));
			departinvoiceDao.merge(nextschedulestatus);
		}
		return true;
	}
	//创建结算单
	public DepartinvoicesVo createDepartinvoice(Global global,Scheduleplan scheduleplan,Vehicle vehicle,
			List<Ticketsell> ticketsells,Vehiclereport vehiclereport,Date now,Vehicletype vehicletype,
			Vehiclebrandmodel vb ,Unit unit ,Unit balanceunit,String departtime,
			boolean iscomputeno, String printip,String departinvoicesno, String printway)
	 throws ServiceException, ParseException {
		long createby=global.getUserinfo().getId();
		long departstationid=global.getOrganization().getStation().getId();
		long printorgid=global.getOrganization().getId();
		Userinfo departinvoiceby=global.getUserinfo();
		String ticketids = "";// 售票ID用于更新车票
		int ticketnum = 0;// 人数
        int freetickets=0;
        int armtickets=0;
        int otherticketnum = 0;
		for (Ticketsell ticket : ticketsells) {
			ticketids = ticketids + "," + ticket.getId();
			ticketnum++;
			freetickets=freetickets+ticket.getCarrychildnum();
			if(ticket.getTickettype().equals("J")){
				armtickets=armtickets+1;
			}
			if(!("B").equals(ticket.getTickettype())){
				otherticketnum = otherticketnum+1;
			}
		}
		if (ticketids.length() > 0) {
			ticketids = "(" + ticketids.substring(1) + ")";
		} else {
			ticketids = "(0)";
		}
		// 创建结算单

		Departinvoices	departinvoices = balancedeductService
					.createDepartinvoices(scheduleplan, vehicle, ticketsells,
							departtime, createby,global);

		departinvoices.setDepartdate(scheduleplan.getDepartdate());
		departinvoices.setDepartinvoicesno(departinvoicesno);
		departinvoices.setDepartstationid(departstationid);
		SimpleDateFormat sf=new SimpleDateFormat("HH:mm");
		departinvoices.setDeparttime(scheduleplan.getStarttime());
		departinvoices.setPrintip(printip);
		departinvoices.setPrintorgid(printorgid);
		departinvoices.setReportid(vehiclereport.getId());
		//新增驾驶员ID，乘务员ID，通过车辆报道表中进行获取
//		departinvoices.setDriver1id(12L);
//		departinvoices.setDriver2id(13L);
//		departinvoices.setSteward1id(14L);
		
		departinvoices.setDriver1id(vehiclereport.getDriver1()==null ? 0L:vehiclereport.getDriver1().getId());
		departinvoices.setDriver2id(vehiclereport.getDriver2()==null ? 0L:vehiclereport.getDriver2().getId());
		departinvoices.setSteward1id(vehiclereport.getSteward1()==null ? 0L:vehiclereport.getSteward1().getId());
		//新增 end
		departinvoices.setIscomputeno(iscomputeno);
		departinvoices.setScheduleid(scheduleplan.getScheduleid());
		departinvoices.setScheduleplanid(scheduleplan.getId());
		departinvoices.setStatus("0");
		departinvoices.setPrintway(printway);
		departinvoices.setBalanceunitid(vehicle.getBalanceunitid());
		departinvoices.setSupplyamount(new BigDecimal("0"));
		departinvoices.setSupplybalanceamount(new BigDecimal("0"));
		departinvoices.setSupplyticketnum(0);
		departinvoices.setVehicleid(vehicle.getId());
		departinvoices.setCreateby(createby);
		departinvoices.setCreatetime(now);
		departinvoices.setPrintby(createby);   
		departinvoices.setPrinttime(now);
		departinvoices.setUpdateby(createby);
		departinvoices.setUpdatetime(now);
		departinvoices.setIsreplace(vehiclereport.isIsreplace());
		departinvoices.setSeller(createby);
		departinvoiceDao.getEntityManager().merge(vehiclereport);
		departinvoices = departinvoiceDao.getEntityManager().merge(
				departinvoices);
		
		//新增呼市移植功能，IC卡发班打单时候打印行包结算金额 20151023 by liyi
		String p8084 = parameterService.findParamValue(ParamterConst.Param_8084,
				departinvoices.getPrintorgid());
		BigDecimal packbalanceprice=new BigDecimal(0);
		int packes=0;
		if (p8084.equals(ParamterConst.COMMON_FLAG.FALG_YES)){
			List<Pack> plist=departinvoiceDao.qyrPack(departinvoices.getScheduleid(),
					departinvoices.getDepartdate(), departinvoices.getVehicleid());
			//packes=plist.size();
			for(Pack pp:plist){
				packes=packes+pp.getPieces();
				packbalanceprice=packbalanceprice.add(pp.getTotalfee());
				pp.setDepartinvoicesid(departinvoices.getId());
				pp.setUpdateby(departinvoices.getCreateby());
				pp.setUpdatetime(new Date());
				departinvoiceDao.merge(pp);
			}
			String p8083 = parameterService.findParamValue(ParamterConst.Param_8083,
					departinvoices.getPrintorgid());
			packbalanceprice=packbalanceprice.multiply(new BigDecimal(1).subtract(new BigDecimal(p8083))).divide(new BigDecimal(1), 0,
					BigDecimal.ROUND_HALF_UP);
			
		}
		departinvoices.setPackes(packes);		
		departinvoices.setPackbalanceprice(packbalanceprice);
		//end  20151023 by liyi
		//获取脱班罚金
		BigDecimal lostfee = departinvoiceDao.queryLostfee(scheduleplan.getId());
		// 设置主表打印信息

		DepartinvoicesVo departinvoicesVo = new DepartinvoicesVo();
		departinvoicesVo.setFreetickets(freetickets);
		departinvoicesVo.setArmtickets(armtickets);
		departinvoicesVo.setVehicleno(vehicle.getVehicleno());
//		if (vehicle.getSeattype() != null) {//获取字典表中座位类型
//			List<Object> lisSeattype = departinvoiceDao.getVehicleSeatTypeName(vehicle.getSeattype());
//			departinvoicesVo.setVehicleseattype((String)lisSeattype.get(0));//车辆座位类型
//		}
		Vehicle v = (Vehicle) departinvoiceDao.get(Vehicle.class, departinvoices.getVehicleid());
		Unit u = (Unit) departinvoiceDao.get(Unit.class, v.getUnitid());
		departinvoicesVo.setFullname(u.getFullname());
		departinvoicesVo.setCheckedname(departinvoiceDao.getCheckedName(
				scheduleplan.getId(), vehiclereport.getId()));
		departinvoicesVo.setAgentfee(departinvoices.getAgentfee().toString());
		departinvoicesVo.setSeatnum(vehicle.getSeatnum());
		departinvoicesVo.setDistance(scheduleplan.getDistance());
		departinvoicesVo.setRemarks(scheduleplan.getRemarks());
		departinvoicesVo.setVehicletype(vehicletype.getName());
		departinvoicesVo.setLostfee(lostfee.toString());
		if (vb != null) {
			departinvoicesVo.setBrandname(vb.getBrandname());
		}
		departinvoicesVo.setBalanceamount(departinvoices.getBalanceamount()
				.toString());
		if (vehiclereport.getDriver1() != null)
			departinvoicesVo.setDriver1(vehiclereport.getDriver1().getName());
		else
			departinvoicesVo.setDriver1("0");
		if (vehiclereport.getDriver2() != null)
			departinvoicesVo.setDriver2(vehiclereport.getDriver2().getName());
		else
			departinvoicesVo.setDriver2("0");
		if (vehiclereport.getDriver3() != null)
			departinvoicesVo.setDriver3(vehiclereport.getDriver3().getName());
		else
			departinvoicesVo.setDriver3("0");
		if (vehiclereport.getDriver4() != null)
			departinvoicesVo.setDriver4(vehiclereport.getDriver4().getName());
		else
			departinvoicesVo.setDriver4("0");
		if (vehiclereport.getSteward1() != null)
			departinvoicesVo.setSteward(vehiclereport.getSteward1().getName());
		else
			departinvoicesVo.setSteward("0");
		departinvoicesVo.setFueladditionfee(departinvoices.getFueladditionfee()
				.toString());
		departinvoicesVo.setId(departinvoices.getId());
		departinvoicesVo.setInvoicesno(departinvoicesno);
		departinvoicesVo.setOtherfee(departinvoices.getOthterfee().toString());
		departinvoicesVo.setStationfee(departinvoices.getStationservicefee()
				.toString());
		departinvoicesVo.setTicketnum(ticketnum);
		departinvoicesVo.setOtherticketnum(otherticketnum);
		departinvoicesVo.setUnitcode(u.getCode());
		//结算单位编码
		departinvoicesVo.setBalanceunitcode(balanceunit.getCode());
		departinvoicesVo.setTotalamount(departinvoices.getTotalamount()
				.toString());
		//呼市移植到5041，IC卡报班界面，发班打单，打印出行包结算金额 20151023 by liyi
		departinvoicesVo.setPackes(packes);		
		departinvoicesVo.setPackbalanceprice(packbalanceprice);
		//end 20151023 by liyi
		departinvoicesVo.setUnit(unit.getName());
		departinvoicesVo.setBalanceunit(balanceunit.getName());
		departinvoicesVo.setBalanceunitfullname(balanceunit.getFullname());
		departinvoicesVo.setIsovertime(scheduleplan.getIsovertime());
		List<Scheduleseats> seatslist = scheduleplan.getScheduleseatslist();
		for (Ticketsell ticket : ticketsells) {
			if (!scheduleplan.getIslinework()) {
				for (Scheduleseats seats : seatslist) {
					if (ticket.getSeatno() == seats.getSeatno()) {
						seats.setStatus("8");// 已开运量
						seats.setUpdateby(createby);
						seats.setUpdatetime(new Date());
					}
				}
			}
			if(ticket.getId()>0){//新增若是本地票则进行更新运量单ID号,远检票不更新
				ticket.setDepartinvoices(departinvoices);
				//售票表增加冗余字段：结算单单号
				ticket.setDepartinvoicesno(departinvoices.getDepartinvoicesno());
				ticket.setVehicleid(vehicle.getId());
				ticket.setVehiclebrandmodelid(vehicle.getVehiclebrandmodelid());
				ticket.setIsdepartinvoices(true);
				ticket.setUpdateby(createby);
				ticket.setUpdatetime(now);
				ticket.setDepartinvoicesby(departinvoiceby);
				ticket.setDepartinvoicestime(now);
				departinvoiceDao.getEntityManager().merge(ticket);
			}
		}
		changeOutStationDeptime(scheduleplan, departstationid, scheduleplan.getScheduleid(), departinvoices);
		//参数4008: 车辆打印运量单，参数4008值为0时，该车对应状态为“未结算”的违规记录更新为“已打单”
		String p4008 = parameterService.findParamValue(ParamterConst.Param_4008,
				global.getUserinfo().getOrgid());
		if ("0".equals(p4008)) {
			//获取本车所有的违规记录
			BigDecimal totalViolation=new BigDecimal(0);
			List<Vehicleviolation> vehicleviolationlist = departinvoiceDao.queryVehicleviolation(vehicle.getId());
			for (Vehicleviolation vehicleviolation : vehicleviolationlist) {			
					vehicleviolation.setStatus("4");    //该车对应状态为“未结算”的违规记录更新为“已打单”     
					vehicleviolation.setDepartinvoicesid(departinvoices.getId());  //运量单ID插入到该车对应的违规记录中
					vehicleviolation.setUpdateby(createby);
					vehicleviolation.setUpdatetime(now);
					totalViolation=totalViolation.add(vehicleviolation.getDebit());
					departinvoiceDao.merge(vehicleviolation);          //更新到表中
			}
			departinvoicesVo.setDebit(totalViolation);  //违规罚金的获取
		}
		departinvoicesVo.setEticketnumtotal(departinvoices.getEticketnum());//电子票总票数，包含：电子票取票、未取票总张数
		departinvoicesVo.setHandticketnumtotal(departinvoices.getHandticketnum());//手持机总票数，包含：手持机售票的总张数
		departinvoicesVo.setNopaperticketnumtotal(departinvoices.getNopaperticketnum());////非纸质票总票数：结算单中包含网售未取票、窗口售电子票且未换纸质票和自助机售电子票未换纸质票
		departinvoicesVo.setPaperticketnumtotal(departinvoices.getPaperticketnum());////纸质票总票数：结算单中包含窗口售非电子票、窗口售电子票且已换纸质票、网售已取票、自助机售非电子票和自助机售电子票已换纸质票
		return departinvoicesVo;
	}
	
	
	@Override
	public List<Map<String, Object>> schDepartinvoice(Global global,
			long scheduleplanid, long vehiclereportid, String printip,
			 String departinvoicesno, String printway,
			boolean iscomputeno) throws ServiceException, ParseException {
		//long departstationid=global.getOrganization().getStation().getId();
		//long createdby=global.getUserinfo().getId();
		play.Logger.info("-------------------发班打印开始---------------------");
		Organization org = global.getOrganization();
		Billtype billtype = billtypeService
				.findByCode(ConstDefiniens.BalanceBill);
		// 补零操作
		if (billtype.getTicketnolength() != departinvoicesno.length()) {
			departinvoicesno = StringUtils.strPad(departinvoicesno,
					(int) billtype.getTicketnolength(), "0");
		}
		if (qryDepartinvoices(org.getId(), departinvoicesno)) {
			// 该运量单号已经存在！
			throw new ServiceException("0385");
		}
		if (iscomputeno) {
			return vehicleDepartinvoice(global,
					scheduleplanid, vehiclereportid, printip,billtype, 
					departinvoicesno, printway, iscomputeno);
			
		} else {
			return departinvoiceSch(global, scheduleplanid,
					vehiclereportid, printip,billtype, departinvoicesno,
					printway);
		}

	}

	private void modifyVehicledriverreport(long scheduleplanid,int ticketnum) {
		List<Vehicledriverreport> vdr=departinvoiceDao.queryVehicledriverreport(scheduleplanid);
		for (Vehicledriverreport v : vdr) {
			v.setActtickets(ticketnum);
			departinvoiceDao.getEntityManager().merge(v);
		}
	}
	// 没票据并且不打印结算单，即手动开已检票运量单，只保存运量单数据)
	public List<Map<String, Object>> departinvoiceSch(Global global,
			long scheduleplanid, long vehiclereportid, String printip,Billtype billtype,
			String departinvoicesno, String printway)
			throws ServiceException, ParseException {
		return vehicleDepartinvoice(global, scheduleplanid,
				vehiclereportid, printip,billtype, departinvoicesno,
				printway,false);
	}

	@SuppressWarnings("unchecked")
	@Override
	public boolean save(Departinvoices departinvoices) {
		if (departinvoices.getId() == 0) {
			return departinvoiceDao.save(departinvoices);
		}
		return departinvoiceDao.update(departinvoices);
	}

	@Override
	public List<Map<String, Object>> query(
			List<PropertyFilter> propertyFilterList) {
		return ListUtil.listToMap(new Object[] { Departinvoices.class },
				departinvoiceDao.query(propertyFilterList),
				new Object[] { Departinvoices.class });
	}

	@SuppressWarnings("unchecked")
	@Override
	public boolean delete(long id) {
		return departinvoiceDao.delete(Departinvoices.class, id);
	}

	// 查询结算单明细打印信息
	@Override
	public List<Map<String, Object>> qryInvoicesDetailPrintInfo(
			long departinvoicesid) {

		// 查询明细信息
		return ListUtil.listToMap(new Object[] { "fromstation", "reachstation",
				"fullpeople","fullpeoples","reachstationpeople", "halfpeople", "totalamount", "distance", "price",
				"balanceamount", "balanceprice","noservicestationfee","noagentbalanceamount","discountpeople","stationservicefee",
				"fulltickets","halftickets","nopaperticketnum","paperticketnum"},
				departinvoiceDao.findDepartinvoicesdetail(departinvoicesid),
				new Object[] { String.class, String.class, Integer.class,
						Integer.class,Integer.class,Integer.class, BigDecimal.class, Long.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,BigDecimal.class, BigDecimal.class,Integer.class,BigDecimal.class
						,Integer.class,Integer.class,Integer.class,Integer.class});

	}

	@Override
	public List<Map<String, Object>> qryInvoicePrintInfo(long departinvoicesid) {
		// 查询主表信息
		return ListUtil.listToMap(new Object[] { DepartinvoicesVo.class },
				departinvoiceDao.findDepartinvoices(departinvoicesid),
				new Object[] { DepartinvoicesVo.class });

	}

	/*
	 * printDepartinvoices方法：补开结算单<br/> <br/>
	 * 
	 * @param departstationid
	 * 
	 * @param scheduleplanid
	 * 
	 * @param vehiclereportid
	 * 
	 * @param departinvoicesno
	 * 
	 * @param printip
	 * 
	 * @param balanceby
	 * 
	 * @return
	 * 
	 * @throws ServiceException
	 * 
	 * @see
	 * cn.nova.bus.checkticket.service.DepartinvoiceService#printDepartinvoices
	 * (long, long, long, java.lang.String, java.lang.String, long)
	 * 
	 * @exception
	 */
	@Override
	public List<Map<String, Object>> printDepartinvoices(Global global,
			long scheduleplanid, long vehiclereportid, String printip,
			String departinvoicesno) throws ServiceException, ParseException {
		return schDepartinvoice(global,
				 scheduleplanid,  vehiclereportid,  printip,
				 departinvoicesno, "1",
				true);
		
		/*
		Organization org = departinvoiceDao.getOrganization(departstationid);
		Billtype billtype = billtypeService
				.findByCode(ConstDefiniens.BalanceBill);
		// 补零操作
		if (billtype.getTicketnolength() != departinvoicesno.length()) {
			departinvoicesno = StringUtils.strPad(departinvoicesno,
					(int) billtype.getTicketnolength(), "0");
		}
		Billinuse billinuse = billinuseService.getBilluse(billtype.getId(),
				balanceby, new Long(departinvoicesno));
		if (billinuse == null || "2".equals(billinuse.getStatus())) {
			// 您的票据已经用完
			throw new ServiceException("0143");
		}
		// 补零操作
		String curDepartinvoicesno = String.valueOf(billinuse.getNextno());
		if (billtype.getTicketnolength() != curDepartinvoicesno.length()) {
			curDepartinvoicesno = StringUtils.strPad(curDepartinvoicesno,
					(int) billtype.getTicketnolength(), "0");
		}
		if (!curDepartinvoicesno.equals(departinvoicesno)) {
			// 您的票据当前号码与系统的号码不一致，请重置票号！
			throw new ServiceException("0144");
		}
		Scheduleplan scheduleplan = (Scheduleplan) departinvoiceDao.get(
				Scheduleplan.class, scheduleplanid);
		int limitday = new Integer(parameterService.findParamValue("3041",
				org.getId()));
		if (DateUtils.getIntervalDays(scheduleplan.getDepartdate(), new Date()) >= limitday) {
			// 已超过补开结算单天数
			throw new ServiceException("0367");
		}
		Vehiclereport vehiclereport = departinvoiceDao
				.getVehiclereport(vehiclereportid);
		if (vehiclereport == null) {
			// 该班次还未报到！
			throw new ServiceException("0280");
		}
		if (!vehiclereport.isIsdeparted()) {
			vehiclereport.setIsdeparted(true);
			vehiclereport.setUpdateby(balanceby);
			vehiclereport.setUpdatetime(new Date());
			departinvoiceDao.merge(vehiclereport);
		}
		// 获取班次状态并锁住
		Schedulestatus schedulestatus = departinvoiceDao.getSchedulestatus(
				scheduleplanid, departstationid);
		Schedule schedule=(Schedule) departinvoiceDao.get(Schedule.class,scheduleplan.getScheduleid());
		if (schedulestatus == null) {
			if(schedule.getWorktype().equals("2")||
					schedule.getWorktype().equals("3")){
				long startstationid=schedule.getRoute().getStartstationid();
				schedulestatus = departinvoiceDao.getSchedulestatus(scheduleplanid, startstationid);						
			}
			else{
				throw new ServiceException("0357");
			}
		}
		// 正常、报停、晚点、被并、脱班、停售
		if (schedulestatus.getStatus().equals("1")) {
			// 该班次已经报停！
			throw new ServiceException("0097");
		} else if (schedulestatus.getStatus().equals("3")) {
			// 该班次班次已被并
			throw new ServiceException("0200");
		} else if (schedulestatus.getStatus().equals("4")) {
			// 该班次班次已脱班
			throw new ServiceException("0201");
		}
		// 查询所有已检车票未开结算单的车票信息
		List<Ticketsell> ticketsells = departinvoiceDao.getUnDepartTickets(
				scheduleplanid, vehiclereportid, departstationid);
			
		String ticketids = "";// 售票ID用于更新车票
		int freetickets=0;
		int armtickets=0;
		for (Ticketsell ticket : ticketsells) {
			ticketids = ticketids + "," + ticket.getId();
			freetickets=freetickets+ticket.getCarrychildnum();
			if(ticket.getTickettype().equals("J")){
				armtickets=armtickets+1;
			}
		}

		if (ticketids.length() > 0) {
			ticketids = "(" + ticketids.substring(1) + ")";
		} else {
			ticketids = "(0)";
		}
		Vehicle vehicle = (Vehicle) departinvoiceDao.get(Vehicle.class,
				vehiclereport.getVehicleid());
		// 创建结算单
		Departinvoices departinvoices = balancedeductService
				.createDepartinvoices(scheduleplan, vehicle, ticketsells,
						schedulestatus.getDeparttime(), balanceby);
		departinvoices.setDepartdate(scheduleplan.getDepartdate());
		departinvoices.setDepartinvoicesno(departinvoicesno);
		departinvoices.setDepartstationid(departstationid);
		departinvoices.setDeparttime(schedulestatus.getDeparttime());
		departinvoices.setPrintip(printip);
		departinvoices.setPrintorgid(org.getId());
		departinvoices.setReportid(vehiclereportid);
		departinvoices.setScheduleid(scheduleplan.getScheduleid());
		departinvoices.setScheduleplanid(scheduleplanid);
		departinvoices.setStatus("0");
		departinvoices.setPrintway("1");
		departinvoices.setBalanceunitid(vehicle.getBalanceunitid());
		departinvoices.setSupplyamount(new BigDecimal("0"));
		departinvoices.setSupplybalanceamount(new BigDecimal("0"));
		departinvoices.setSupplyticketnum(0);
		departinvoices.setVehicleid(vehicle.getId());
		departinvoices.setCreateby(balanceby);
		departinvoices.setCreatetime(new Date());
		departinvoices.setPrintby(balanceby);
		departinvoices.setPrinttime(new Date());
		departinvoices.setUpdateby(balanceby);
		departinvoices.setUpdatetime(new Date());
		departinvoices.setIscomputeno(true);
		departinvoices.setIsreplace(vehiclereport.isIsreplace());
		departinvoices = departinvoiceDao.getEntityManager().merge(
				departinvoices);
		// 本次若是最后一张票据
		if (billinuse.getNextno() == billinuse.getEndno()) {
			billinuse.setStatus("2");
		}
		billinuse.setNextno(billinuse.getNextno() + 1);
		billinuse.setUpdateby(balanceby);
		billinuse.setUpdatetime(new Date());
		departinvoiceDao.getEntityManager().merge(billinuse);
		//departinvoiceDao.upateTickets(ticketids, departinvoices);
		Userinfo userinfo=(Userinfo) departinvoiceDao.get(Userinfo.class, balanceby);
		List<Schedulestatus> sslist=scheduleplan.getSchedulestatuslist();
		for(Schedulestatus ss:sslist){
			if (!scheduleplan.getIslinework() && ss.getDepartstationid()==departstationid && !ss.getIsdeparted()){
				ss.setIsdeparted(true);
				ss.setIsreported(true);
				ss.setIsemptyvehicle(false);
				ss.setUpdateby(balanceby);
				ss.setUpdatetime(new Date());
				departinvoiceDao.getEntityManager().merge(ss);
			}
			if(!scheduleplan.getIslinework() && (schedule.getWorktype().equals("2")||
				schedule.getWorktype().equals("3"))){
				ss.setIsdeparted(true);
				ss.setIsreported(true);
				ss.setIsemptyvehicle(false);
				ss.setUpdateby(balanceby);
				ss.setUpdatetime(new Date());
				departinvoiceDao.getEntityManager().merge(ss);
			}
		}
		List<Scheduleseats> seatslist=scheduleplan.getScheduleseatslist();
		for (Ticketsell ticket : ticketsells) {
			if (!scheduleplan.getIslinework()) {
				for (Scheduleseats seats : seatslist) {
					if (ticket.getSeatno() == seats.getSeatno()) {
						seats.setStatus("8");// 已开运量
						seats.setUpdateby(balanceby);
						seats.setUpdatetime(new Date());
						departinvoiceDao.getEntityManager().merge(seats);
					}
				}
			}
			if(ticket.getId()>0){
				ticket.setDepartinvoices(departinvoices);
				ticket.setIsdepartinvoices(true);
				ticket.setUpdateby(balanceby);
				ticket.setUpdatetime(new Date());
				ticket.setDepartinvoicesby(userinfo);
				ticket.setDepartinvoicestime(new Date());
				departinvoiceDao.getEntityManager().merge(ticket);
			}
		}
		departinvoices.setFreetickets(freetickets);
	
		departinvoices.setIsovertime(scheduleplan.getIsovertime());
		// 设置主表打印信息
		DepartinvoicesVo departinvoicesVo = new DepartinvoicesVo();
		departinvoicesVo.setFreetickets(freetickets);
		departinvoicesVo.setArmtickets(armtickets);
		departinvoicesVo.setVehicleno(vehicle.getVehicleno());
		departinvoicesVo.setCheckedname(departinvoiceDao.getCheckedName(
				scheduleplanid, vehiclereportid));
		departinvoicesVo.setAgentfee(departinvoices.getAgentfee().toString());
		departinvoicesVo.setSeatnum(vehicle.getSeatnum());
		departinvoicesVo.setDistance(scheduleplan.getDistance());
		Vehicletype vehicletype = (Vehicletype) departinvoiceDao.get(
				Vehicletype.class, vehicle.getVehicletypeid());
		departinvoicesVo.setVehicletype(vehicletype.getName());
		Vehiclebrandmodel vb = (Vehiclebrandmodel) departinvoiceDao.get(
				Vehiclebrandmodel.class, vehicle.getVehiclebrandmodelid());
		if (vb != null) {
			departinvoicesVo.setBrandname(vb.getBrandname());
		}
		departinvoicesVo.setBalanceamount(departinvoices.getBalanceamount()
				.toString());
		if (vehiclereport.getDriver1() != null)
			departinvoicesVo.setDriver1(vehiclereport.getDriver1().getName());
		else
			departinvoicesVo.setDriver1(" ");
		if (vehiclereport.getDriver2() != null)
			departinvoicesVo.setDriver2(vehiclereport.getDriver2().getName());
		else
			departinvoicesVo.setDriver2(" ");
		if (vehiclereport.getDriver3() != null)
			departinvoicesVo.setDriver3(vehiclereport.getDriver3().getName());
		else
			departinvoicesVo.setDriver3(" ");
		if (vehiclereport.getDriver4() != null)
			departinvoicesVo.setDriver4(vehiclereport.getDriver4().getName());
		else
			departinvoicesVo.setDriver4(" ");
		if (vehiclereport.getSteward1() != null)
			departinvoicesVo.setSteward(vehiclereport.getSteward1().getName());
		else
			departinvoicesVo.setSteward(" ");
		departinvoicesVo.setFueladditionfee(departinvoices.getFueladditionfee()
				.toString());
		departinvoicesVo.setId(departinvoices.getId());
		departinvoicesVo.setInvoicesno(departinvoicesno);
		departinvoicesVo.setOtherfee(departinvoices.getOthterfee().toString());
		departinvoicesVo.setStationfee(departinvoices.getStationservicefee()
				.toString());
		departinvoicesVo.setTicketnum(departinvoices.getTicketnum());
		departinvoicesVo.setTotalamount(departinvoices.getTotalamount()
				.toString());
		Unit unit = (Unit) departinvoiceDao
				.get(Unit.class, vehicle.getUnitid());
		Unit balanceunit = (Unit) departinvoiceDao.get(Unit.class,
				vehicle.getBalanceunitid());
		departinvoicesVo.setUnit(unit.getName());
		departinvoicesVo.setBalanceunit(balanceunit.getName());
		departinvoicesVo.setIsovertime(scheduleplan.getIsovertime());
		return departinvoicesVo;
		*/
	}

	// 取消发班
	@SuppressWarnings("unchecked")
	@Override
	public boolean cancelDepartinvoices(long departstationid,
			long scheduleplanid, long vehiclereportid, long cancelby)
			throws ServiceException {
		List<Departinvoices> dds = departinvoiceDao.qryDepartinvoices(
				scheduleplanid, vehiclereportid);
		if (dds != null) {
			for (Departinvoices ds : dds) {
				if (ds.getStatus().equals("0")||ds.getStatus().equals("3")) {
					// 该班次已开结算单，不允许取消发班！
					throw new ServiceException("0299");
				}
				if (ds.getStatus().equals("2")) {
					// 该班次已结算，不允许取消发班！
					throw new ServiceException("0300");
				}
			}
		}
		Scheduleplan scheduleplan = (Scheduleplan) departinvoiceDao.get(
				Scheduleplan.class, scheduleplanid);
		List<Schedulestatus> sslist = scheduleplan.getSchedulestatuslist();
		// 若是始发站取消发班,改为之取消本站的发班
		Schedule schedule=(Schedule) departinvoiceDao.get(Schedule.class, scheduleplan.getScheduleid());
		for (Schedulestatus ss : sslist) {
			if (ss.getDepartstationid() == departstationid) {
				/*
				 * if (!ss.getIsdeparted()) { // 该班次还未发班，不需要取消发班！ throw new
				 * ServiceException("0301"); }
				 */
				ss.setIsdeparted(false);
				ss.setUpdateby(cancelby);
				ss.setUpdatetime(new Date());
				departinvoiceDao.getEntityManager().merge(ss);
			}
			if(schedule.getWorktype().equals("2")){
					ss.setUpdatetime(new Date());
					ss.setUpdateby(cancelby);
					ss.setIsdeparted(false);
					departinvoiceDao.getEntityManager().merge(ss);
			}
		}
		// 取消报到表的发班状态
		Vehiclereport vr = (Vehiclereport) departinvoiceDao.get(
				Vehiclereport.class, vehiclereportid);
		vr.setIsdeparted(false);
		vr.setUpdateby(cancelby);
		vr.setUpdatetime(new Date());
		departinvoiceDao.getEntityManager().merge(vr);
		
		//增加扩展点，取消发班时注销初检单
		ActionNode actionNode = Appvar.routes.get("CANCELFIRSTCHECK");// 由插件名,获得插件
		if(actionNode != null){
			Map map = new HashMap();
			map.put("vehiclereportid", vehiclereportid);
			PluginFunction.DoPlugin(map, CurrentUtil.getGlobal(), actionNode);
		}
		
		return true;
	}

	public boolean qryDepartinvoices(long orgid, String departinvoicesno) {
		return departinvoiceDao.qryDepartinvoices(orgid, departinvoicesno);
	}	
    /**
     * 重打结算单、跳号或者不跳号
     */
	@SuppressWarnings("unchecked")
	@Override
	public List<Map<String, Object>> reprintDepartinvoice(long departstationid,
			long scheduleplanid, long vehiclereportid, String printip,
			long createdby, String departinvoicesno,boolean reprintDepartinvoice)
			throws ServiceException {
		String [] departinvoicesnos = departinvoicesno.split(",");
		Organization org = departinvoiceDao.getOrganization(departstationid);
//		String jumpno = parameterService.findParamValue(ParamterConst.Param_3025, org.getId());
		//原来的结算单票号
		String olddepartinvoicesno = "";
		if(departinvoicesnos.length>1){
			olddepartinvoicesno = departinvoicesnos[1];
		}
		List<Departinvoices> dds = departinvoiceDao.queryDepartinvoices(
				scheduleplanid, vehiclereportid,olddepartinvoicesno);
		String log="";
		long count = 0;
		Global global = CurrentUtil.getGlobal();
		TicketoutletsTicket curtslist = new TicketoutletsTicket();//保存本站的售票
		//要打印的售票点
        List<Ticketoutlets> outletslist=departinvoiceDao.qryTicketoutlets();
        List<TicketoutletsTicket> _tslists =  new ArrayList<TicketoutletsTicket>();		
		//TicketoutletsTicket curtslist = new TicketoutletsTicket();//保存本站的售票
		for(Ticketoutlets lets:outletslist){
			//初始化其他售票点要打印的售票点
			if(lets.getType().equals("0") && global.getOrganization().getId()==lets.getOrgid()){
				curtslist.setTicketoutlet(lets);
			}else{
				TicketoutletsTicket clets = new TicketoutletsTicket();
				clets.setTicketoutlet(lets);
				_tslists.add(clets);
			}				
		}
		Date now=new Date();
		List<Object> dvlist=new ArrayList<Object>();
		for (Departinvoices departinvoices : dds) {
			DepartinvoicesVo departinvoicesVo = new DepartinvoicesVo();
			Departinvoices dd = departinvoices;
			if (dd.getStatus().equals("2")) {
				// 该结算单已经结账，不允许重打0422
				throw new ServiceException("0422");
			}
			if (dd.getStatus().equals("1")) {
				// 该结算单已经注销，不允许重打0423
				throw new ServiceException("0423");
			}
			Userinfo userinfo = (Userinfo) departinvoiceDao.get(Userinfo.class,
					createdby);
			Station station = (Station) departinvoiceDao.get(Station.class,
					departstationid);			
			int limitday = new Integer(parameterService.findParamValue("3019",
					dd.getPrintorgid()));
			if (DateUtils.getIntervalDays(dd.getDepartdate(), new Date()) >= limitday) {
				// 已超过重打结算单天数
				throw new ServiceException("0425");
			}
			// 设置主表打印信息
			Vehicle vehicle = (Vehicle) departinvoiceDao.get(Vehicle.class,
					dd.getVehicleid());
			Scheduleplan sp = (Scheduleplan) departinvoiceDao.get(
					Scheduleplan.class, scheduleplanid);
			//获取脱班罚金
			BigDecimal lostfee = departinvoiceDao.queryLostfee(scheduleplanid);
			
			Schedule schedule=(Schedule)departinvoiceDao.get(Schedule.class, sp.getScheduleid());
			Vehiclereport vehiclereport = (Vehiclereport) departinvoiceDao.get(
					Vehiclereport.class, vehiclereportid);
			departinvoicesVo.setVehicleno(vehicle.getVehicleno());
			departinvoicesVo.setCheckedname(departinvoiceDao.getCheckedName(
					scheduleplanid, vehiclereportid));
			departinvoicesVo.setAgentfee(dd.getAgentfee().toString());
			departinvoicesVo.setSeatnum(vehicle.getSeatnum());
			departinvoicesVo.setDistance(sp.getDistance());
			departinvoicesVo.setLostfee(lostfee.toString());
			Vehicletype vehicletype = (Vehicletype) departinvoiceDao.get(
					Vehicletype.class, vehicle.getVehicletypeid());
			departinvoicesVo.setVehicletype(vehicletype.getName());
			Vehiclebrandmodel vb = (Vehiclebrandmodel) departinvoiceDao.get(
					Vehiclebrandmodel.class, vehicle.getVehiclebrandmodelid());
			if (vb != null) {
				departinvoicesVo.setBrandname(vb.getBrandname());
			}
			departinvoicesVo.setBalanceamount(dd.getBalanceamount().toString());
			if (vehiclereport.getDriver1() != null)
				departinvoicesVo.setDriver1(vehiclereport.getDriver1()
						.getName());
			else
				departinvoicesVo.setDriver1("0");
			if (vehiclereport.getDriver2() != null)
				departinvoicesVo.setDriver2(vehiclereport.getDriver2()
						.getName());
			else
				departinvoicesVo.setDriver2("0");
			if (vehiclereport.getDriver3() != null)
				departinvoicesVo.setDriver3(vehiclereport.getDriver3()
						.getName());
			else
				departinvoicesVo.setDriver3("0");
			if (vehiclereport.getDriver4() != null)
				departinvoicesVo.setDriver4(vehiclereport.getDriver4()
						.getName());
			else
				departinvoicesVo.setDriver4("0");
			if (vehiclereport.getSteward1() != null)
				departinvoicesVo.setSteward(vehiclereport.getSteward1()
						.getName());
			else
				departinvoicesVo.setSteward("0");
			departinvoicesVo.setFueladditionfee(dd.getFueladditionfee()
					.toString());
			departinvoicesVo.setId(dd.getId());
			departinvoicesVo.setInvoicesno(dd.getDepartinvoicesno());
			departinvoicesVo.setOtherfee(dd.getOthterfee().toString());
			departinvoicesVo
					.setStationfee(dd.getStationservicefee().toString());
			Unit unit = (Unit) departinvoiceDao.get(Unit.class,
					vehicle.getUnitid());
			departinvoicesVo.setTicketnum(dd.getTicketnum());
			departinvoicesVo.setOtherticketnum(departinvoiceDao.getOtherticketnum(dd.getId()));
			departinvoicesVo.setUnitcode(unit.getCode());
			departinvoicesVo.setTotalamount(dd.getTotalamount().toString());
			Unit balanceunit = (Unit) departinvoiceDao.get(Unit.class,
					dd.getBalanceunitid());
			departinvoicesVo.setBalanceunitcode(balanceunit.getCode());
			departinvoicesVo.setUnit(unit.getName());
			departinvoicesVo.setRemarks(sp.getRemarks());
			departinvoicesVo.setBalanceunit(balanceunit.getName());
			departinvoicesVo.setFullname(unit.getFullname());//车属单位
			departinvoicesVo.setBalanceunitfullname(balanceunit.getFullname());//结算单位
			departinvoicesVo.setIsovertime(sp.getIsovertime());
			if(dd.getPackbalanceprice()!=null){
				departinvoicesVo.setPackbalanceprice(dd.getPackbalanceprice());
			}else{
				departinvoicesVo.setPackbalanceprice(new BigDecimal(0));
			}
			if(curtslist.getTicketoutlet()!=null){
				departinvoicesVo.setTicketoutname(curtslist.getTicketoutlet().getName());
				departinvoicesVo.setTicketoutshort(curtslist.getTicketoutlet().getJianpin());
			}
			log="原结算单号："+dd.getDepartinvoicesno();
//			if (jumpno.equals("1")) {
			if (reprintDepartinvoice) {
				departinvoicesno = String.valueOf(count + Long.parseLong(departinvoicesnos[0]));
				count += 1;
				//若跳号，则插入新记录
				dd.setStatus("1");
				dd.setUpdateby(createdby);
				dd.setUpdatetime(now);
				dd.setCancel(userinfo);
				dd.setCancelstation(station);
				dd.setCanceltime(now);
				List<Departinvoicesdeductdetail> dilist = dd
						.getDepartinvoicesdeductdetails();
				List<Departinvoicesdetail> dtlist = dd
						.getDepartinvoicesdetails();
				for (Departinvoicesdeductdetail di : dilist) {
					di.setStatus("1");
					di.setUpdateby(createdby);
					di.setUpdatetime(now);
				}
				Billtype billtype = billtypeService
						.findByCode(ConstDefiniens.BalanceBill);
				// 补零操作
				if (billtype.getTicketnolength() != departinvoicesno.length()) {
					departinvoicesno = StringUtils.strPad(departinvoicesno,
							(int) billtype.getTicketnolength(), "0");
				}
				if (qryDepartinvoices(org.getId(), departinvoicesno)) {
					// 该运量单号已经存在！
					throw new ServiceException("0385");
				}
				Billinuse billinuse = billinuseService
						.getBilluse(billtype.getId(), createdby, new Long(
								departinvoicesno));
				if (billinuse == null || "2".equals(billinuse.getStatus())) {
					// 您的票据已经用完
					throw new ServiceException("0143");
				}
				// 补零操作
				String curDepartinvoicesno = String.valueOf(billinuse
						.getNextno());
				if (billtype.getTicketnolength() != curDepartinvoicesno
						.length()) {
					curDepartinvoicesno = StringUtils.strPad(
							curDepartinvoicesno,
							(int) billtype.getTicketnolength(), "0");
				}
				if (!curDepartinvoicesno.equals(departinvoicesno)) {
					// 您的票据当前号码与系统的号码不一致，请重置票号！
					throw new ServiceException("0144");
				}
				//跳号并插入新记录
				log=log+",重打后新结算单号："+curDepartinvoicesno;
				Departinvoices ndd = new Departinvoices();
				ndd.setAgentfee(dd.getAgentfee());
				ndd.setBalanceamount(dd.getBalanceamount());
				ndd.setBalanceunitid(dd.getBalanceunitid());
				ndd.setCreateby(createdby);
				if(dd.getPackbalanceprice()!=null){
					ndd.setPackbalanceprice(dd.getPackbalanceprice());
				}else{
					ndd.setPackbalanceprice(new BigDecimal(0));
				}
				if (vehiclereport.getDriver1() != null)
					ndd.setDriver1id(vehiclereport.getDriver1().getId());
				else
					ndd.setDriver1id(new Long(0));
				if (vehiclereport.getDriver2() != null)
					ndd.setDriver2id(vehiclereport.getDriver2().getId());
				else
					ndd.setDriver2id(new Long(0));
				if (vehiclereport.getSteward1() != null)
					ndd.setSteward1id(vehiclereport.getSteward1().getId());
				else
					ndd.setSteward1id(new Long(0));
				ndd.setCreatetime(now);
				ndd.setDepartdate(dd.getDepartdate());
				ndd.setDepartinvoicesno(curDepartinvoicesno);
				ndd.setDepartstationid(dd.getDepartstationid());
				ndd.setDeparttime(sp.getStarttime());
				ndd.setFueladditionfee(dd.getFueladditionfee());
				ndd.setIscomputeno(dd.isIscomputeno());
				ndd.setMoreprice(dd.getMoreprice());
				ndd.setOthterfee(dd.getOthterfee());
				ndd.setPrintby(createdby);
				ndd.setPrintip(printip);
				ndd.setPrintorgid(dd.getPrintorgid());
				ndd.setPrinttime(now);
				ndd.setPrintway("3");
				ndd.setReportid(dd.getReportid());
				ndd.setScheduleid(dd.getScheduleid());
				ndd.setScheduleplanid(dd.getScheduleplanid());
				ndd.setStationservicefee(dd.getStationservicefee());
				ndd.setStatus("0");
				ndd.setSupplyamount(dd.getSupplyamount());
				ndd.setSupplybalanceamount(dd.getSupplybalanceamount());
				ndd.setSupplyticketnum(dd.getSupplyticketnum());
				ndd.setTicketnum(dd.getTicketnum());
				ndd.setTotalamount(dd.getTotalamount());
				ndd.setUpdateby(createdby);
				ndd.setUpdatetime(now);
				ndd.setVehicleid(dd.getVehicleid());
				List<Departinvoicesdeductdetail> ndilist = new ArrayList<Departinvoicesdeductdetail>();
				for (Departinvoicesdeductdetail di : dilist) {
					Departinvoicesdeductdetail ndi = new Departinvoicesdeductdetail();
					ndi.setBalanceapplyid(di.getBalanceapplyid());
					ndi.setBalanceitemid(di.getBalanceitemid());
					ndi.setCreateby(createdby);
					ndi.setCreatetime(now);
					ndi.setDeductmoney(di.getDeductmoney());
					ndi.setDepartdate(di.getDepartdate());
					ndi.setDepartinvoices(ndd);
					ndi.setIsdeductbeforebalance(di.getIsdeductbeforebalance());
					ndi.setParentbalanceitemid(di.getParentbalanceitemid());
					ndi.setScheduleid(di.getScheduleid());
					ndi.setStatus("0");
					ndi.setType(di.getType());
					ndi.setUpdateby(createdby);
					ndi.setUpdatetime(now);
					ndilist.add(ndi);
				}
				List<Departinvoicesdetail> ndtlist = new ArrayList<Departinvoicesdetail>();
				for (Departinvoicesdetail dt : dtlist) {
					Departinvoicesdetail ndt = new Departinvoicesdetail();
					ndt.setAgentfee(dt.getAgentfee());
					ndt.setBalanceamount(dt.getBalanceamount());
					ndt.setCreateby(createdby);
					ndt.setCreatetime(now);
					ndt.setDepartdate(dt.getDepartdate());
					ndt.setDepartinvoices(ndd);
					ndt.setDeparttime(sp.getStarttime());
					ndt.setDistance(dt.getDistance());
					ndt.setFromstationid(dt.getFromstationid());
					ndt.setFueladditionfee(dt.getFueladditionfee());
					ndt.setIssupply(dt.getIssupply());
					ndt.setMoreprice(dt.getMoreprice());
					ndt.setOthterfee(dt.getOthterfee());
					ndt.setPrice(dt.getPrice());
					ndt.setReachstationid(dt.getReachstationid());
					ndt.setScheduleid(dt.getScheduleid());
					ndt.setStationservicefee(dt.getStationservicefee());
					ndt.setTicketnum(dt.getTicketnum());
					ndt.setTickettype(dt.getTickettype());
					ndt.setTotalamount(dt.getTotalamount());
					ndt.setUpdateby(createdby);
					ndt.setUpdatetime(now);
					ndtlist.add(ndt);
				}
				ndd.setDepartinvoicesdeductdetails(ndilist);
				ndd.setDepartinvoicesdetails(ndtlist);
				billinuse.setNextno(billinuse.getNextno() + 1);				
				// 本次若是最后一张票据
				if (billinuse.getNextno() > billinuse.getEndno()) {
					billinuse.setStatus("2");
				}
				billinuse.setUpdateby(createdby);
				billinuse.setUpdatetime(new Date());
				departinvoicesVo.setInvoicesno(curDepartinvoicesno);				
				departinvoiceDao.getEntityManager().merge(billinuse);				
				Departinvoices resul =departinvoiceDao.getEntityManager().merge(ndd);				
				//换车重打后使客户端获取新的运量单ID，一遍客户端根据新的ID获取异站售票信息
				departinvoicesVo.setId(resul.getId());
				//根据原运量单ID 和发车日期，修改车票运量单信息
				departinvoiceDao.upateTickets(null, resul, dd.getId(), dd.getDepartdate());
			}
			departinvoicesVo.setVehiclecolor(departinvoiceDao.qryVehicleColor(vehiclereport.getId()));//车牌颜色
			departinvoicesVo.setBupiaonum(departinvoiceDao.qryBupiaoNum(vehiclereport.getScheduleplanid()));//补票人数
			
			//参数4008: 车辆打印运量单，参数4008值为0时，该车对应状态为“未结算”的违规记录更新为“已打单”
			String p4008 = parameterService.findParamValue(ParamterConst.Param_4008,
					global.getUserinfo().getOrgid());
			if ("0".equals(p4008)) {
				//获取本车所有的违规记录
				BigDecimal totalViolation=new BigDecimal(0);
				List<Vehicleviolation> vehicleviolationlist = departinvoiceDao.queryVehicleviolation(vehicle.getId());
				for (Vehicleviolation vehicleviolation : vehicleviolationlist) {			
						vehicleviolation.setStatus("4");    //该车对应状态为“未结算”的违规记录更新为“已打单”     
						vehicleviolation.setDepartinvoicesid(departinvoices.getId());  //运量单ID插入到该车对应的违规记录中
						vehicleviolation.setUpdateby(createdby);
						vehicleviolation.setUpdatetime(now);
						totalViolation=totalViolation.add(vehicleviolation.getDebit());
						departinvoiceDao.merge(vehicleviolation);          //更新到表中
				}
				departinvoicesVo.setDebit(totalViolation);  //违规罚金的获取
			}
			
			departinvoicesVo.setEticketnumtotal(dd.getEticketnum());//电子票总票数，包含：电子票取票、未取票总张数
			departinvoicesVo.setHandticketnumtotal(dd.getHandticketnum());//手持机总票数，包含：手持机售票的总张数
			departinvoicesVo.setNopaperticketnumtotal(dd.getNopaperticketnum());////非纸质票总票数：结算单中包含网售未取票、窗口售电子票且未换纸质票和自助机售电子票未换纸质票
			departinvoicesVo.setPaperticketnumtotal(dd.getPaperticketnum());////纸质票总票数：结算单中包含窗口售非电子票、窗口售电子票且已换纸质票、网售已取票、自助机售非电子票和自助机售电子票已换纸质票
			
			dvlist.add(departinvoicesVo);
			log = "重打机构:" + org.getName() + "，"+log+",发车日期:"
			+ DateUtils.formatDate(dd.getDepartdate()) + ",班次号:"
			+ schedule.getCode() + ",发车时间:" + dd.getDeparttime();
		} 
			//该班次还未打印结算单，不能重打！
		if(dvlist.isEmpty()) {
			throw new ServiceException("0424");
		}
		// 保存操作日志
		Operationlog operationLog = new Operationlog();
		operationLog.setIp(printip);
		operationLog.setContent(log);
		operationLog.setModule("检票管理->综合检票");
		operationLog.setOperatetime(new Date());
		operationLog.setOperation("结算单重打");
		operationLog.setSessionid("无session");
		operationLog.setUserid(createdby);
		operationLogService.savelog(operationLog);
		return ListUtil.listToMap( new Object[]{DepartinvoicesVo.class},dvlist, new Object[]{DepartinvoicesVo.class});
		//return departinvoicesVo;
	}
	
	
	
	/**
	 * 自助打单重打：打印所中结算单，而不是打印这个班次当天报到班次的最后一条结算单
	 */
	public List<Map<String, Object>> reprintDepartinvoice(long departstationid,
			long scheduleplanid, long vehiclereportid, String printip,
			long createdby, String departinvoicesno,boolean reprintDepartinvoice, String originaldepartinvoicesno)
			throws ServiceException {
		DepartinvoicesVo departinvoicesVo = new DepartinvoicesVo();
		Organization org = departinvoiceDao.getOrganization(departstationid);
//		String jumpno = parameterService.findParamValue("3025", org.getId());
		List<Departinvoices> dds = departinvoiceDao.queryDepartinvoices(
				scheduleplanid, vehiclereportid, originaldepartinvoicesno);//根据结算单号查找到用户选中的结算单
		String log="";
		if (dds != null && dds.size() > 0) {
			Departinvoices dd = dds.get(0);	//此处得到的就是用户选中的结算单
			if (dd.getStatus().equals("2")) {
				// 该结算单已经结账，不允许重打0422
				throw new ServiceException("0422");
			}
			if (dd.getStatus().equals("1")) {
				// 该结算单已经注销，不允许重打0423
				throw new ServiceException("0423");
			}
			Userinfo userinfo = (Userinfo) departinvoiceDao.get(Userinfo.class,
					createdby);
			Station station = (Station) departinvoiceDao.get(Station.class,
					departstationid);			
			int limitday = new Integer(parameterService.findParamValue("3019",
					dd.getPrintorgid()));
			if (DateUtils.getIntervalDays(dd.getDepartdate(), new Date()) >= limitday) {
				// 已超过重打结算单天数
				throw new ServiceException("0425");
			}
			// 设置主表打印信息
			Vehicle vehicle = (Vehicle) departinvoiceDao.get(Vehicle.class,
					dd.getVehicleid());
			Scheduleplan sp = (Scheduleplan) departinvoiceDao.get(
					Scheduleplan.class, scheduleplanid);
			//检票、重打/补开结算截至日期
			limitday = new Integer(parameterService.findParamValue("3106",
					CurrentUtil.getGlobal().getOrganization().getId()));
			if(limitday>0){
				Calendar c = Calendar.getInstance();
				c.add(Calendar.MONTH, 0);
				c.set(Calendar.DAY_OF_MONTH, limitday);// 设置为1号,当前日期既为本月第一天
				if (DateUtils.compare(sp.getDepartdate(),c.getTime())<=0) {
					// 已超过补开结算单天数
					throw new ServiceException("0425");
				}
			}
			Schedule schedule=(Schedule)departinvoiceDao.get(Schedule.class, sp.getScheduleid());
			Vehiclereport vehiclereport = (Vehiclereport) departinvoiceDao.get(
					Vehiclereport.class, vehiclereportid);
			long departinvoiceid = departinvoiceDao.qryDepartinvoicesOfreprint(vehiclereport.getId(), originaldepartinvoicesno).longValue();  //增加结算单打印次数
//			int printnum = Integer.parseInt(obj[1].toString());
//			int  param3037 = Integer.valueOf(parameterService.findParamValue("3037", CurrentUtil.getGlobal().getOrganization().getId()));
//			if(param3037>0){
//				if(printnum-1>param3037){
//					throw new BusinessException("超过重打次数!");
//				}
//			}else{
//				 throw new BusinessException("不允许重打!");
//			}
			departinvoicesVo.setVehicleno(vehicle.getVehicleno());
			departinvoicesVo.setCheckedname(departinvoiceDao.getCheckedName(
					scheduleplanid, vehiclereportid));
			departinvoicesVo.setAgentfee(dd.getAgentfee().toString());
			departinvoicesVo.setSeatnum(vehicle.getSeatnum());
			departinvoicesVo.setDistance(sp.getDistance());
			Vehicletype vehicletype = (Vehicletype) departinvoiceDao.get(
					Vehicletype.class, vehicle.getVehicletypeid());
			departinvoicesVo.setVehicletype(vehicletype.getName());
			Vehiclebrandmodel vb = (Vehiclebrandmodel) departinvoiceDao.get(
					Vehiclebrandmodel.class, vehicle.getVehiclebrandmodelid());
			if (vb != null) {
				departinvoicesVo.setBrandname(vb.getBrandname());
			}
			departinvoicesVo.setBalanceamount(dd.getBalanceamount().toString());
			if (vehiclereport.getDriver1() != null)
				departinvoicesVo.setDriver1(vehiclereport.getDriver1()
						.getName());
			else
				departinvoicesVo.setDriver1(" ");
			if (vehiclereport.getDriver2() != null)
				departinvoicesVo.setDriver2(vehiclereport.getDriver2()
						.getName());
			else
				departinvoicesVo.setDriver2(" ");
			if (vehiclereport.getDriver3() != null)
				departinvoicesVo.setDriver3(vehiclereport.getDriver3()
						.getName());
			else
				departinvoicesVo.setDriver3(" ");
			if (vehiclereport.getDriver4() != null)
				departinvoicesVo.setDriver4(vehiclereport.getDriver4()
						.getName());
			else
				departinvoicesVo.setDriver4(" ");
			if (vehiclereport.getSteward1() != null)
				departinvoicesVo.setSteward(vehiclereport.getSteward1()
						.getName());
			else
				departinvoicesVo.setSteward(" ");
			departinvoicesVo.setFueladditionfee(dd.getFueladditionfee()
					.toString());
			departinvoicesVo.setId(dd.getId());
			departinvoicesVo.setInvoicesno(dd.getDepartinvoicesno());
			departinvoicesVo.setOtherfee(dd.getOthterfee().toString());
			departinvoicesVo
					.setStationfee(dd.getStationservicefee().toString());
			departinvoicesVo.setTicketnum(dd.getTicketnum());
			departinvoicesVo.setTotalamount(dd.getTotalamount().toString());
			Unit unit = (Unit) departinvoiceDao.get(Unit.class,
					vehicle.getUnitid());
			Unit balanceunit = (Unit) departinvoiceDao.get(Unit.class,
					dd.getBalanceunitid());
			departinvoicesVo.setUnit(unit.getName());
			departinvoicesVo.setRemarks(sp.getRemarks());
			departinvoicesVo.setBalanceunit(balanceunit.getName());
			departinvoicesVo.setIsovertime(sp.getIsovertime());
			log="原结算单号："+dd.getDepartinvoicesno();
//			if (jumpno.equals("1")) {
			if (reprintDepartinvoice) {
				//若跳号，则插入新记录
				dd.setStatus("1");
				dd.setUpdateby(createdby);
				dd.setUpdatetime(new Date());
				dd.setCancel(userinfo);
				dd.setCancelstation(station);
				dd.setCanceltime(new Date());
				List<Departinvoicesdeductdetail> dilist = dd
						.getDepartinvoicesdeductdetails();
				List<Departinvoicesdetail> dtlist = dd
						.getDepartinvoicesdetails();
				for (Departinvoicesdeductdetail di : dilist) {
					di.setStatus("1");
					di.setUpdateby(createdby);
					di.setUpdatetime(new Date());
				}
				Billtype billtype = billtypeService
						.findByCode(ConstDefiniens.BalanceBill);
				// 补零操作
				if (billtype.getTicketnolength() != departinvoicesno.length()) {
					departinvoicesno = StringUtils.strPad(departinvoicesno,
							(int) billtype.getTicketnolength(), "0");
				}
				if (qryDepartinvoices(org.getId(), departinvoicesno)) {
					// 该运量单号已经存在！
					throw new ServiceException("0385");
				}
				Billinuse billinuse = billinuseService
						.getBilluse(billtype.getId(), createdby, new Long(
								departinvoicesno));
				if (billinuse == null || "2".equals(billinuse.getStatus())) {
					// 您的票据已经用完
					throw new ServiceException("0143");
				}
				// 补零操作
				String curDepartinvoicesno = String.valueOf(billinuse
						.getNextno());
				if (billtype.getTicketnolength() != curDepartinvoicesno
						.length()) {
					curDepartinvoicesno = StringUtils.strPad(
							curDepartinvoicesno,
							(int) billtype.getTicketnolength(), "0");
				}
				if (!curDepartinvoicesno.equals(departinvoicesno)) {
					// 您的票据当前号码与系统的号码不一致，请重置票号！
					throw new ServiceException("0144");
				}
				//跳号并插入新记录
				log=log+",重打后新结算单号："+curDepartinvoicesno;
				Departinvoices ndd = new Departinvoices();
				ndd.setAgentfee(dd.getAgentfee());
				ndd.setBalanceamount(dd.getBalanceamount());
				ndd.setBalanceunitid(dd.getBalanceunitid());
				ndd.setCreateby(createdby);
				ndd.setCreatetime(new Date());
				ndd.setDepartdate(dd.getDepartdate());
				ndd.setDepartinvoicesno(curDepartinvoicesno);
				ndd.setDepartstationid(dd.getDepartstationid());
				ndd.setDeparttime(dd.getDeparttime());
				ndd.setFueladditionfee(dd.getFueladditionfee());
				ndd.setIscomputeno(dd.isIscomputeno());
				ndd.setMoreprice(dd.getMoreprice());
				ndd.setOthterfee(dd.getOthterfee());
				ndd.setPrintby(createdby);
				ndd.setPrintip(printip);
				ndd.setPrintorgid(dd.getPrintorgid());
				ndd.setPrinttime(new Date());
				ndd.setPrintway("3");
				ndd.setReportid(dd.getReportid());
				ndd.setScheduleid(dd.getScheduleid());
				ndd.setScheduleplanid(dd.getScheduleplanid());
				ndd.setStationservicefee(dd.getStationservicefee());
				ndd.setStatus("0");
				ndd.setSupplyamount(dd.getSupplyamount());
				ndd.setSupplybalanceamount(dd.getSupplybalanceamount());
				ndd.setSupplyticketnum(dd.getSupplyticketnum());
				ndd.setTicketnum(dd.getTicketnum());
				ndd.setTotalamount(dd.getTotalamount());
				ndd.setUpdateby(createdby);
				ndd.setUpdatetime(new Date());
				ndd.setVehicleid(dd.getVehicleid());
				List<Departinvoicesdeductdetail> ndilist = new ArrayList<Departinvoicesdeductdetail>();
				for (Departinvoicesdeductdetail di : dilist) {
					Departinvoicesdeductdetail ndi = new Departinvoicesdeductdetail();
					ndi.setBalanceapplyid(di.getBalanceapplyid());
					ndi.setBalanceitemid(di.getBalanceitemid());
					ndi.setCreateby(createdby);
					ndi.setCreatetime(new Date());
					ndi.setDeductmoney(di.getDeductmoney());
					ndi.setDepartdate(di.getDepartdate());
					ndi.setDepartinvoices(ndd);
					ndi.setIsdeductbeforebalance(di.getIsdeductbeforebalance());
					ndi.setParentbalanceitemid(di.getParentbalanceitemid());
					ndi.setScheduleid(di.getScheduleid());
					ndi.setStatus("0");
					ndi.setType(di.getType());
					ndi.setUpdateby(createdby);
					ndi.setUpdatetime(new Date());
					ndilist.add(ndi);
				}
				List<Departinvoicesdetail> ndtlist = new ArrayList<Departinvoicesdetail>();
				for (Departinvoicesdetail dt : dtlist) {
					Departinvoicesdetail ndt = new Departinvoicesdetail();
					ndt.setAgentfee(dt.getAgentfee());
					ndt.setBalanceamount(dt.getBalanceamount());
					ndt.setCreateby(createdby);
					ndt.setCreatetime(new Date());
					ndt.setDepartdate(dt.getDepartdate());
					ndt.setDepartinvoices(ndd);
					ndt.setDeparttime(dt.getDeparttime());
					ndt.setDistance(dt.getDistance());
					ndt.setFromstationid(dt.getFromstationid());
					ndt.setFueladditionfee(dt.getFueladditionfee());
					ndt.setIssupply(dt.getIssupply());
					ndt.setMoreprice(dt.getMoreprice());
					ndt.setOthterfee(dt.getOthterfee());
					ndt.setPrice(dt.getPrice());
					ndt.setReachstationid(dt.getReachstationid());
					ndt.setScheduleid(dt.getScheduleid());
					ndt.setStationservicefee(dt.getStationservicefee());
					ndt.setTicketnum(dt.getTicketnum());
					ndt.setTickettype(dt.getTickettype());
					ndt.setTotalamount(dt.getTotalamount());
					ndt.setUpdateby(createdby);
					ndt.setUpdatetime(new Date());
					ndtlist.add(ndt);
				}
				ndd.setDepartinvoicesdeductdetails(ndilist);
				ndd.setDepartinvoicesdetails(ndtlist);
				billinuse.setNextno(billinuse.getNextno() + 1);				
				// 本次若是最后一张票据
				if (billinuse.getNextno() > billinuse.getEndno()) {
					billinuse.setStatus("2");
				}
				billinuse.setUpdateby(createdby);
				billinuse.setUpdatetime(new Date());
				departinvoicesVo.setInvoicesno(curDepartinvoicesno);				
				departinvoiceDao.getEntityManager().merge(billinuse);				
				Departinvoices resul =departinvoiceDao.getEntityManager().merge(ndd);				
				//换车重打后使客户端获取新的运量单ID，一遍客户端根据新的ID获取异站售票信息
				departinvoicesVo.setId(resul.getId());
				//根据原运量单ID 和发车日期，修改车票运量单信息
				departinvoiceDao.upateTickets(null, resul, dd.getId(), dd.getDepartdate());
			}else{
				//按原单号重打，修改打印次数
				Departinvoices departinvoice = (Departinvoices)departinvoiceDao.get(Departinvoices.class,departinvoiceid);
				departinvoiceDao.merge(departinvoice);
			}
			log = "重打机构:" + org.getName() + "，"+log+",发车日期:"
			+ DateUtils.formatDate(dd.getDepartdate()) + ",班次号:"
			+ schedule.getCode() + ",发车时间:" + dd.getDeparttime();
		}else{
			//该班次还未打印结算单，不能重打！
			throw new ServiceException("0424");
		}
		// 保存操作日志
		Operationlog operationLog = new Operationlog();
		operationLog.setIp(printip);
		operationLog.setContent(log);
		operationLog.setModule("检票管理->综合检票");
		operationLog.setOperatetime(new Date());
		operationLog.setOperation("结算单重打");
		operationLog.setSessionid("无session");
		operationLog.setUserid(createdby);
		operationLogService.savelog(operationLog);
		List<Object> dvlist=new ArrayList<Object>();
		dvlist.add(departinvoicesVo);
		return ListUtil.listToMap( new Object[]{DepartinvoicesVo.class},dvlist, new Object[]{DepartinvoicesVo.class});
		//return departinvoicesVo;
	}

	@Override
	public List<Map<String, Object>> qryInvoicesDetailtoRoadbill(
			long scheduleplanid) {
		// 查询明细信息
		return ListUtil.listToMap(new Object[] { "fromstation", "tostation",
				"peoples", "peopledistance", "todistance"},
				departinvoiceDao.findDepartinvoicesdetailbySchplanid(scheduleplanid),
				new Object[] { String.class, String.class, Integer.class,
						long.class, long.class});
	}

	/**
	 * 根据运量单ID 和发车日期获取该运量单的他站售票情况，用于打印
	 * @param departinvoicesid
	 * @param departdate
	 * @return
	 */
	public String getOthersellmessage(long departinvoicesid,Date departdate){
		String othersellmessage = "";
		List<Map<String, Object>> list = 
			ListUtil.listToMap (
					new Object[] {"name","num"},
					departinvoiceDao.getOthersells(departinvoicesid,departdate),
					new Object[] {String.class,String.class});
		if(list!=null && list.size()>1){
			othersellmessage = "其中:"; 
			for (int i = 0; i < list.size()-1; i++) {
				Map<String, Object> map = list.get(i);
				othersellmessage = othersellmessage +map.get("name")+"售"+map.get("num")+"张,";
			}	
		}		
		return othersellmessage;
	}

	@SuppressWarnings("unchecked")
	@Override
	public boolean schDepartinvoice(Global global, long scheduleplanid,
			long vehiclereportid) throws ServiceException {
		Scheduleplan scheduleplan = (Scheduleplan) departinvoiceDao.get(
				Scheduleplan.class, scheduleplanid);
		Organization org= global.getOrganization();
		long orgid=org.getId();
		long departstationid=org.getStation().getId();
		long createdby=global.getUserinfo().getId();
		Vehiclereport vehiclereport = null;
		if (scheduleplan.getIslinework()) {
			if (vehiclereportid == 0) {
				// 请选择你要打单的报到车辆！
				throw new ServiceException("0145");
			} else {
				vehiclereport = (Vehiclereport) departinvoiceDao.get(
						Vehiclereport.class, vehiclereportid);
			}
		} else {
			vehiclereport = departinvoiceDao.getVehiclereport(scheduleplan,
					org.getId());
		}
		if (vehiclereport == null) {
			throw new ServiceException("0145");
		}
		if (vehiclereport.isIsdeparted()) {
			// 该报到车辆已经发班
			throw new ServiceException("0193");
		}
		
		// 获取班次状态并锁住
		Schedulestatus schedulestatus = departinvoiceDao.getSchedulestatus(
				scheduleplanid, departstationid);
		Schedule schedule =(Schedule) departinvoiceDao.get(Schedule.class, scheduleplan.getScheduleid());
		if (schedulestatus == null) {
			if(schedule.getWorktype().equals("2")||
					schedule.getWorktype().equals("3")){
				long startstationid=schedule.getRoute().getStartstationid();
				schedulestatus = departinvoiceDao.getSchedulestatus(scheduleplanid, startstationid);						
			}
			else{
				// 当前站点不是发班站点，不能进行发班操作！
				throw new ServiceException("0182");
			}
		}
		if (schedulestatus.getIsdeparted()) {
			// 该班次已经发班！
			throw new ServiceException("0183");
		}
		// 若为正班要判断发班时间
		if (!scheduleplan.getIslinework()) {
			// 已售数大于已检数
			if ((scheduleplan.getSeatnum()
							- scheduleplan.getFixedreserveseatnum()
							- scheduleplan.getAutocancelreserveseatnum()
							- scheduleplan.getUnautocancelreserveseatnum() - scheduleplan
							.getSoldeatnum()) > 0) {
				String departmin = parameterService.findParamValue(ParamterConst.Param_3008,
						orgid);
				int minutes = 0;
				try {
					minutes = new Integer(departmin);
				} catch (Exception e) {
					play.Logger.error(e.getMessage(), e);
				}
				if (minutes > 0) {
					// 判断班次发班时间
					SimpleDateFormat sf = new SimpleDateFormat(
							"yyyy-MM-dd HH:mm");
					try {
						Date curdatetime = sf.parse(sf.format(new Date()));
						Date depardatetime = sf.parse(scheduleplan
								.getDepartdate()
								+ " "
								+ schedulestatus.getDeparttime());
						long departtimel = (depardatetime.getTime()) / 1000 / 60;
						long curtimel = (curdatetime.getTime() + minutes * 60 * 1000) / 1000 / 60;
						if (departtimel > curtimel) {
							// 未到发班时间，不允许发班！
							throw new ServiceException("0303");
						}
					} catch (ParseException e) {
						play.Logger.error(e.getMessage(), e);
					}
				}
			}
		}
		// 更新班次状态,更新报道表vehiclereport
		// 若是流水班,判断以发报到车辆数
		if (scheduleplan.getIslinework()) {
			int departcount = departinvoiceDao
					.getVehiclereportCount(vehiclereport);
			departcount++;
			int plancouont = scheduleplan.getSchedulevehiclepeopleplanlist()
					.size();
			if (departcount == plancouont) {
				// 若是最后一次报到车辆，则更新班次状态为发班状态
				schedulestatus.setIsdeparted(true);
			} else {
				if (departinvoiceDao.isexistVehiclereport(vehiclereport)) {
					schedulestatus.setIsdeparted(false);
				} else
				// 没有可发班报到车辆
				{
					schedulestatus.setIsreported(false);
					schedulestatus.setIsbegincheck(false);
					schedulestatus.setIsdeparted(false);
				}
			}
		} else {
			schedulestatus.setIsdeparted(true);
			if(schedule.getWorktype().equals("2")){
				List<Schedulestatus> sslist=scheduleplan.getSchedulestatuslist();
				for(Schedulestatus ss:sslist){
					ss.setUpdatetime(new Date());
					ss.setUpdateby(createdby);
					ss.setIsdeparted(true);
					departinvoiceDao.getEntityManager().merge(ss);
				}
			}
		}
		schedulestatus.setUpdateby(createdby);
		schedulestatus.setUpdatetime(new Date());
		departinvoiceDao.getEntityManager().merge(schedulestatus);

		vehiclereport.setIsdeparted(true);
		vehiclereport.setUpdateby(createdby);
		vehiclereport.setUpdatetime(new Date());
		departinvoiceDao.getEntityManager().merge(vehiclereport);
		return true;
	}

	//根据报到车辆卡号查询报到车辆报到ID以及班次计划ID
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<Map<String, Object>> qryScheduleReport(String cardno,
			long reportorgid) throws ServiceException {
		List list = departinvoiceDao.qryVehcilereport(cardno, reportorgid);
		return ListUtil.listToMap(
				new Object[] { "reportid", "scheduleplanid" }, list,
				new Object[] { Long.class, Long.class });
	}
	
	@Override
	public Departinvoices findDepartinvoice(long vehiclereportid,
			Date departdate, long scheduleplanid, long scheduleid) {
		return departinvoiceDao.findOneDepartinvoices(vehiclereportid,departdate,scheduleplanid,scheduleid);
	}

	@Override
	public List<Map<String, Object>> queryFirstCheck(Long scheduleplanid,Long departstationid,Long vehiclereportid, boolean islinework,Long firstcheckid) {
		return ListUtil.listToMap(new Object[] { "reachstation","reachstationid","ticketnum" },
				departinvoiceDao.queryFirstCheck(scheduleplanid,departstationid,vehiclereportid,islinework,firstcheckid),
				new Object[] { String.class,long.class,long.class});
	}
	@Override
	public boolean isSecurityQualify(long vehiclereportid) {
		String security_resuslt;
		Vehiclereport vr = (Vehiclereport) departinvoiceDao.get(Vehiclereport.class, vehiclereportid);
		if (departinvoiceDao.qrysecuresult(vr).size()==0)
			return false;
		else
			security_resuslt = (String) departinvoiceDao.qrysecuresult(vr).get(0);
		if ("0".equals(security_resuslt)||"2".equals(security_resuslt))
			return true;
		return false;
	}
	/*@Override
	public boolean isSecurityQualify(long vehicleid, Date departdate) {
		String security_resuslt;
		if (departinvoiceDao.qrysecuresult1(vehicleid,departdate).size()==0)
			return false;
		else
			security_resuslt = (String) departinvoiceDao.qrysecuresult1(vehicleid,departdate).get(0);
		if ("0".equals(security_resuslt)||"2".equals(security_resuslt))
			return true;
		return false;
		
	}*/
	
	public List<Map<String, Object>> qryBalancedetailPrint(long balanceid) {
		// TODO Auto-generated method stub
		
//		return ListUtil.listToMap(new Object[]{"id","balanceid","fromstationid","reachstationid","ticketnum",
//				  "totalamount","stationservicefee","agentfee","balanceamount","createtime",
//				  "createby","updatetime","updateby","fromstationname","reachstationname"},
//				departInvoiceDao.qryBalancedetailPrint(balanceid),
//		        new Object[]{long.class,long.class,long.class,long.class,Integer.class,
//			                 BigDecimal.class,BigDecimal.class,BigDecimal.class,BigDecimal.class,TIMESTAMP.class, 
//		                     long.class,TIMESTAMP.class,long.class,String.class,String.class
//		});
		return ListUtil.listToMap(new Object[]{"reachstationid","ticketnum",
				  "totalamount","stationservicefee","agentfee","balanceamount",
				  "fromstationname","reachstationname"},
				departinvoiceDao.qryBalancedetailPrint(balanceid),
		        new Object[]{long.class,Integer.class,
			                 BigDecimal.class,BigDecimal.class,BigDecimal.class,BigDecimal.class, 
		                     String.class,String.class
		});
	}
	
	public List<Map<String, Object>> qryBalancedetail(long balanceid) {
		return ListUtil.listToMap(new Object[]{"reachstationid","ticketnum",
				  "totalamount","stationservicefee","agentfee","balanceamount",
				  "fromstationname","reachstationname"},
				departinvoiceDao.qryBalancedetail(balanceid),
		        new Object[]{long.class,Integer.class,
			                 BigDecimal.class,BigDecimal.class,BigDecimal.class,BigDecimal.class, 
		                     String.class,String.class
		});
	}
	@Override
	public List<Map<String, Object>> qryBalanceStationdetailPrint(long balanceid,String isByprice) {
		List balancedetail = departinvoiceDao.qryBalanceStationdetailPrint(balanceid,isByprice); //结算单结算打印结果
		List departinvoicesnos = departinvoiceDao.qryDepartinvoicesnos(balanceid); //查询该结算通知单号对应的结算单号和结算单张数（20160323通城需求：增加结算单张数、结算单号）
		
		List result = new ArrayList(); //拼接了结算单号和结算单张数的返回结果
		Object[] temp;
		
		if(null != departinvoicesnos && departinvoicesnos.size() > 0){
			Object[] obj2 = (Object[]) departinvoicesnos.get(0);
			for (int i = 0; i < balancedetail.size(); i++) {
				temp= (Object[]) balancedetail.get(i);
				Object[] obj = ArrayUtils.addAll(temp, obj2); //拼接两个数组
				result.add(obj);
			}
		}
			
		return ListUtil.listToMap(new Object[]{"reachstationname","ticketnum",//"price",
				  "totalamount","balanceDate","balanceamount","stationservicefee","agentfee",
				  "fueladditionfee","othterfee","price", "dptinvoicesnos", "dptinvoicesnums"},
//				departinvoiceDao.qryBalanceStationdetailPrint(balanceid,isByprice),
				result,
		        new Object[]{String.class,Integer.class,//BigDecimal.class,
			                 BigDecimal.class,Date.class,BigDecimal.class,BigDecimal.class,BigDecimal.class,
			                 BigDecimal.class,BigDecimal.class,BigDecimal.class, String.class, Integer.class
		});
	}
	
	/**
	 * 查询AcReport打印结算单时的车票明细和结算单明细
	 */
	public List<Map<String, Object>> queryTicketDetail(List<PropertyFilter> propertyFilterList){
		return ListUtil.listToMap(new Object[] { "orderno", "ticketno",
					"reachstationname", "price", "seller" },
				departinvoiceDao.queryTicketDetail(propertyFilterList),
				new Object[] { String.class, String.class,
					String.class,String.class, String.class, });
	}
	
	// 打印结算单:只查询检到该结算单上的车票，包括：【座号】、【票号】、【到达站】、【票价】、【售票员】
	public List<Map<String, Object>> qryDptTicketdetail(List<PropertyFilter> propertyFilterList){
		List result = new ArrayList();
		List list = departinvoiceDao.qryDptTicketdetail(propertyFilterList);
		long departinvoicesid = 0;
		for (PropertyFilter propertyFilter : propertyFilterList) {
			if("t!id".equals(propertyFilter.getPropertyFullName())){
				departinvoicesid = (Long) propertyFilter.getMatchValue();
				break;
			}
		}
		//没有卖票的座位不打印
		int seatnums = departinvoiceDao.qryScheduleSeatnums(departinvoicesid);//查询该班次结算单对应的车辆的座位数
		Object[] array;
		int m = 0;
		for (int i = 1; i < seatnums + 1; i++) {
			for (int j = m; j < list.size(); ) {
				array = (Object[]) list.get(j);
				if(i != ((BigDecimal)array[0]).intValue()){
					result.add(new Object[]{i, "", "", "", ""});
				}else{
					result.add(list.get(j));
					m = j + 1;
				}
				break;
			}
		}
		
		return ListUtil.listToMap(new Object[] { "seatno", "ticketno",
				"reachstationname", "price", "seller" },
			result,
			new Object[] { Integer.class, String.class,
				String.class, String.class, String.class, });
	}
	@Override
	public boolean checkPreDepart(long vehicleid, Date departdate,
			String reporttime) throws ServiceException {
		return departinvoiceDao.checkPreDepart(vehicleid,departdate,reporttime);
	}
	@Override
	public List<Map<String, Object>> queryOpenFirstCheck(Long scheduleplanid, Long departstationid,
			Long vehiclereportid, boolean islinework) {
		return ListUtil.listToMap(new Object[] { "reachstation","reachstationid","ticketnum" },
				departinvoiceDao.queryOpenFirstCheck(scheduleplanid,departstationid,vehiclereportid,islinework),
				new Object[] { String.class,long.class,long.class});
	}

	/**
	 * 查询手工单补录打印明细
	 */
	@Override
	public List<Map<String, Object>> qryDepartInvoicesOtherDetailPrintInfo(Long departinvoicesid) {
			return ListUtil.listToMap(new Object[] { "fromstation", "reachstation",
					"fullpeople","reachstationpeople", "halfpeople", "totalamount", "distance", "price",
					"balanceamount", "balanceprice","noservicestationfee","noagentbalanceamount","discountpeople" },
					departinvoiceDao.qryDepartInvoicesOtherDetailPrintInfo(departinvoicesid),
					new Object[] { String.class, String.class, Integer.class,
							Integer.class,Integer.class, BigDecimal.class, Long.class,
							BigDecimal.class, BigDecimal.class, BigDecimal.class,BigDecimal.class, BigDecimal.class,Integer.class});
	}

	@Override
	public String qryDriverName(String vehicleids) {
		List<String> driverNameList = departinvoiceDao.qryDriverName(vehicleids);
		String driverName = "";
		if (driverNameList != null && driverNameList.size() > 0) { 
			for (int i=0; i < driverNameList.size(); i++) {
				if (i==0) {
					driverName = driverNameList.get(i);
				} else {
					if (i <=2 ) {
						driverName = driverName + "," + driverNameList.get(i);
					} else {
						driverName = driverName + "等";
						break;
					}
				}
			}
		}
		return driverName;
	}

	@Override
	public boolean departinvoicesapproveing(long id, Global global) {
		Departinvoices d = (Departinvoices) departinvoiceDao.get(LockModeType.PESSIMISTIC_READ, Departinvoices.class, 
				id);
			if(d != null){
				d.setIsapproved(true);
				d.setUpdatetime(new Date());
				d.setUpdateby(global.getUserinfo().getId());
				departinvoiceDao.merge(d);
			}
		return true;
	}
	
}
