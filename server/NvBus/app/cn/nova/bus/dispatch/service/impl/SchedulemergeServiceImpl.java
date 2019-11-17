package cn.nova.bus.dispatch.service.impl;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.dispatch.dao.SchedulemergeDao;
import cn.nova.bus.dispatch.model.Schedulemerge;
import cn.nova.bus.dispatch.model.Schedulemergedetail;
import cn.nova.bus.dispatch.model.Schedulestatuslog;
import cn.nova.bus.dispatch.service.SchedulemergeService;
import cn.nova.bus.dispatch.service.SchedulemergedetailService;
import cn.nova.bus.dispatch.service.ScheduleseatsService;
import cn.nova.bus.dispatch.service.SchedulestatusService;
import cn.nova.bus.dispatch.service.SchedulestatuslogService;
import cn.nova.bus.dispatch.service.TicketpriceService;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.price.model.Scheduleplan;
import cn.nova.bus.price.model.Scheduleseats;
import cn.nova.bus.price.model.Schedulestatus;
import cn.nova.bus.price.model.Ticketprice;
import cn.nova.bus.price.model.Ticketpriceitem;
import cn.nova.bus.sale.model.Ticketsell;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;

/**
 * <b>类描述：班次并班</b><br/>
 * <b>类名称：</b>SchedulemergeServiceImpl<br/>
 * <b>创建人：</b>ljh</a><br/>
 * <b>关键修改：</b>重写了并班功能<br/>
 * <b>修改时间：</b>lck<br/>
 * <b>修改人：</b>20130926<br/>
 * 
 */
@SuppressWarnings("unchecked")
public class SchedulemergeServiceImpl implements SchedulemergeService {

	
	private SchedulemergeDao dao = new SchedulemergeDao();

	
	//private SchedulestatusService schedulestatusService = new SchedulestatusServiceImpl();

	
	private SchedulestatuslogService schedulestatuslogService = new SchedulestatuslogServiceImpl();

	
	private ScheduleseatsService scheduleseatsService = new ScheduleseatsServiceImpl();

	
	private SchedulemergedetailService mergedetailService = new SchedulemergedetailServiceImpl();

	
	private TicketpriceService priceService = new TicketpriceServiceImpl();

	/**
	 * 班次并班
	 */
	@Override
	public Schedulemerge save(Schedulemerge schedulemerge,
			Schedulestatuslog schedulestatuslog,String oldseats,String newseats) throws ServiceException {
		long updateby=schedulemerge.getCreateby();
		Date now=new Date();		
		if (schedulemerge.getId() == 0) {
			Scheduleplan oldshceduelplan = (Scheduleplan) dao.get(Scheduleplan.class, schedulemerge.getOldscheduleplanid());
			Scheduleplan newscheduelplan = (Scheduleplan) dao.get(Scheduleplan.class, schedulemerge.getScheduleplanid());

			//增加两个是跨区配载不允许配置的限制
			if("3".equals(oldshceduelplan.getWorktype()) || "3".equals(newscheduelplan.getWorktype())){
				throw new ServiceException("0476");
			}
			
			List<Ticketprice> oldticketprices=oldshceduelplan.getTicketpricelist();
			String[] _oldseats=oldseats.split(",");
			if(_oldseats.length>oldshceduelplan.getSoldeatnum()){
				//班次的已售座位发车变化，请重新选择
				throw new ServiceException("0450");
			}
			List<Scheduleseats> oldsecheduleseats=oldshceduelplan.getScheduleseatslist();
			for(int i=0;i<_oldseats.length;i++){
				short curseat=new Short(_oldseats[i]);
				for(Scheduleseats seat:oldsecheduleseats){
					if(seat.getSeatno()==curseat){
					  if(!seat.getStatus().equals("2")){
						//班次的已售座位发车变化，请重新选择
							throw new ServiceException("0450");
					  }else{
						  break;
					  }
					}
				}
			}
			List<Schedulestatus> oldschedulestatus=oldshceduelplan.getSchedulestatuslist();
			for(Schedulestatus ss:oldschedulestatus){
				if(ss.getIsreported()){
					//原班次已经报到，不能进行并班！
					throw new ServiceException("0085");
				}
				ss.setStatus("3");
				ss.setUpdateby(updateby);
				ss.setUpdatetime(now);
				dao.merge(ss);
			}

			int leaveseat=newscheduelplan.getSeatnum()-newscheduelplan.getSoldeatnum()-newscheduelplan.getFixedreserveseatnum()
								-newscheduelplan.getAutocancelreserveseatnum()-newscheduelplan.getUnautocancelreserveseatnum();
		    if(_oldseats.length>leaveseat){
				//计划并入班次的剩余座位数小于被并班次的已售座位数，不能进行并班！
				throw new ServiceException("0084");
		    }
		    //并班后的座位数
		    leaveseat=leaveseat-_oldseats.length;
			List<Schedulestatus> newschedulestatus=newscheduelplan.getSchedulestatuslist();
			List<Scheduleseats> newsecheduleseats=newscheduelplan.getScheduleseatslist();
			List<Ticketprice> newticketprices=newscheduelplan.getTicketpricelist();		
			//Iterator<Ticketprice> newticketpriceits= newticketprices.iterator();
			for(Schedulestatus ss:newschedulestatus){
				if(ss.getStatus().equals("3")){
					//并入班次已经处于被并状态，不能再进行并班！
					throw new ServiceException("0438");
				}else if(ss.getStatus().equals("1")){
					//并入班次已经报停，不能并班
					throw new ServiceException("0451");
				}else if(ss.getStatus().equals("4")){
					//并入班次已经脱班，不能并班
					throw new ServiceException("0452");
				}
			}
			String[] _newseats=newseats.split(",");
			String lvnewseats="";
			for(int i=0;i<_oldseats.length;i++){
				short curseat=new Short(_oldseats[i]);
				for(Scheduleseats seat:oldsecheduleseats){
					if(seat.getSeatno()==curseat){
						if(seat.getStatus().equals("2")){
							Ticketsell ts=dao.getTicketsell(oldshceduelplan.getId(), curseat);
							ts.setScheduleid(newscheduelplan.getScheduleid());
							ts.setScheduleplanid(newscheduelplan.getId());
							ts.setDepartdate(newscheduelplan.getDepartdate());
							short newseat=0;
							boolean isfind=false;
							for(int j=0;j<_newseats.length;j++){
								for(Scheduleseats nseat:newsecheduleseats){
									newseat=new Short(_newseats[j]);
									if(nseat.getSeatno()==newseat){
										if(nseat.getStatus().equals("0")){
											isfind=true;
											_newseats[i]="0";
											nseat.setStatus("2");
											ts.setSeattype(nseat.getSeattype());
											nseat.setTickettype(ts.getTickettype());
											nseat.setUpdateby(updateby);
											nseat.setUpdatetime(now);
											dao.merge(nseat);
											break;
										}else{
											//班次的已售座位发车变化，请重新选择
											throw new ServiceException("0450");
										}
									}
								}
								if(isfind){
									break;
								}
							}
							if(!isfind){
								//班次的已售座位发车变化，请重新选择
								throw new ServiceException("0450");
							}
							lvnewseats=lvnewseats+newseat+",";
							ts.setSeatno(newseat);
							ts.setUpdateby(updateby);
							ts.setUpdatetime(now);
							dao.merge(ts);
							isfind=false;
							/*while(newticketpriceits.hasNext()){
								Ticketprice tp=newticketpriceits.next();
								if(tp.getDepartstationid()==ts.getDepartstationid()
										&&tp.getReachstationid()==ts.getReachstationid()){
									Ticketpriceitem tis=dao.getTicketpriceitem(tp.getId(),"C");
									if(tis!=null){
										ts.setStationservicefee(tis.getPrice());
									}
									tis=dao.getTicketpriceitem(tp.getId(),"G");
									if(tis!=null){
										ts.setCoolairfee(tis.getPrice());
									}
									tis=dao.getTicketpriceitem(tp.getId(),"H");
									if(tis!=null){
										ts.setWaterfee(tis.getPrice());
									}
									tis=dao.getTicketpriceitem(tp.getId(),"I");
									if(tis!=null){
										ts.setInsurefee(tis.getPrice());
									}
									tis=dao.getTicketpriceitem(tp.getId(),"K");
									if(tis!=null){
										ts.setFueladditionfee(tis.getPrice());
									}
									tis=dao.getTicketpriceitem(tp.getId(),"E");
									if(tis!=null){
										ts.setComputefee(tis.getPrice());
									}
									tis=dao.getTicketpriceitem(tp.getId(),"D");
									if(tis!=null){
										ts.setAdditionfee(tis.getPrice());
									}
									isfind=true;
									break;
								}
							}*/
							
							for(Ticketprice tp:newticketprices){
								if(tp.getDepartstationid()==ts.getDepartstationid()
										&&tp.getReachstationid()==ts.getReachstationid()){
									Ticketpriceitem tis=dao.getTicketpriceitem(tp.getId(),"C");
									if(tis!=null){
										ts.setStationservicefee(tis.getPrice());
									}
									tis=dao.getTicketpriceitem(tp.getId(),"G");
									if(tis!=null){
										ts.setCoolairfee(tis.getPrice());
									}
									tis=dao.getTicketpriceitem(tp.getId(),"H");
									if(tis!=null){
										ts.setWaterfee(tis.getPrice());
									}
									tis=dao.getTicketpriceitem(tp.getId(),"I");
									if(tis!=null){
										ts.setInsurefee(tis.getPrice());
									}
									tis=dao.getTicketpriceitem(tp.getId(),"K");
									if(tis!=null){
										ts.setFueladditionfee(tis.getPrice());
									}
									tis=dao.getTicketpriceitem(tp.getId(),"E");
									if(tis!=null){
										ts.setComputefee(tis.getPrice());
									}
									tis=dao.getTicketpriceitem(tp.getId(),"D");
									if(tis!=null){
										ts.setAdditionfee(tis.getPrice());
									}
									isfind=true;
									break;
								}
							}
							if(!isfind){
								Ticketprice tp=new Ticketprice();
								for(Ticketprice otp:oldticketprices){
									if(otp.getDepartstationid()==ts.getDepartstationid()
									&&otp.getReachstationid()==ts.getReachstationid()
									&&otp.getSeattype().equals(ts.getSeattype())){
										tp.setAutocancelreserveseatnum(newscheduelplan.getAutocancelreserveseatnum());
										tp.setBalancedistance(ts.getDistance().intValue());
										tp.setCreateby(updateby);
										tp.setCreatetime(now);
										tp.setDepartdate(newscheduelplan.getDepartdate());
										tp.setDepartstationid(ts.getDepartstationid());
										tp.setDistance(ts.getDistance().intValue());
										tp.setFixedreserveseatnum(newscheduelplan.getFixedreserveseatnum());
										tp.setFueladditionfee(ts.getFueladditionfee());
										tp.setFullprice(ts.getFullprice());
										tp.setHalfprice(otp.getHalfprice());
										tp.setIssellable(true);
										tp.setLowerlimitprice(otp.getLowerlimitprice());
										tp.setMoreprice(otp.getMoreprice());
										tp.setOrgid(otp.getOrgid());
										tp.setReachstationid(otp.getReachstationid());
										tp.setRuntime(otp.getRuntime());
										tp.setScheduleid(newscheduelplan.getScheduleid());
										tp.setScheduleplan(newscheduelplan);
										tp.setSeatnos("0");
										tp.setSeatnum(newscheduelplan.getSeatnum());
										tp.setSeattype(otp.getSeattype());
										tp.setSoldeatnum(otp.getSoldeatnum());
										tp.setStationservicefee(otp.getStationservicefee());
										tp.setStudentprice(otp.getStudentprice());
										tp.setUpdateby(updateby);
										tp.setUpdatetime(now);
										List<Ticketpriceitem>  tpits=otp.getTicketpriceitemlist();
										List<Ticketpriceitem> newticketitems=new ArrayList<Ticketpriceitem>();
										for(Ticketpriceitem ti:tpits){
											Ticketpriceitem nti=new Ticketpriceitem();
											nti.setCode(ti.getCode());
											nti.setCreateby(updateby);
											nti.setCreatetime(now);
											nti.setDepartdate(newscheduelplan.getDepartdate());
											nti.setIsautoadjust(ti.isIsautoadjust());
											nti.setName(ti.getName());
											nti.setPrice(ti.getPrice());
											nti.setScheduleid(newscheduelplan.getScheduleid());
											nti.setTicketprice(tp);
											nti.setTicketpriceformulaitemid(ti.getTicketpriceformulaitemid());
											nti.setTickettype(ti.getTickettype());
											nti.setUpdateby(updateby);
											nti.setUpdatetime(now);
											newticketitems.add(nti);
										}
										tp.setToplimitprice(otp.getToplimitprice());
										tp.setTicketpriceitemlist(newticketitems);
										//dao.merge(tp);
										//dao.getEntityManager().flush();
										newticketprices.add(tp);
										break;
									}
								}
							}
							seat.setStatus("0");
							seat.setTickettype(null);
							seat.setUpdateby(updateby);
							seat.setUpdatetime(now);
							dao.merge(seat);
						}
						else{
							//班次的已售座位发车变化，请重新选择
							throw new ServiceException("0450");
						}						
					}
				}
			}
			short oldsoldnum=(short) (oldshceduelplan.getSoldeatnum()-_oldseats.length);
			oldshceduelplan.setSoldeatnum(oldsoldnum);
			oldshceduelplan.setUpdateby(updateby);
			oldshceduelplan.setUpdatetime(now);
			for(Ticketprice tp:oldticketprices){
				if(tp.getSeatnos()==null ||tp.getSeatnos().equals("") ||tp.getSeatnos().equals("全部")){
					tp.setSoldeatnum(oldsoldnum);
					tp.setUpdateby(updateby);
					tp.setUpdatetime(now);
				}else{
					int soldnum=0;
					String[] seats=tp.getSeatnos().split(",");					
					for(String seat:seats){
						short _seatno=new Short(seat);
						for(Scheduleseats nseat:oldsecheduleseats){
						  if(_seatno==nseat.getSeatno() && nseat.getStatus().equals("2")){
								soldnum=soldnum+1;
						   }	
						}
					}						
					tp.setSoldeatnum((short) soldnum);
					tp.setUpdateby(updateby);
					tp.setUpdatetime(now);
				}
			}
			dao.merge(oldshceduelplan);		
			short newsoldnum=(short) (newscheduelplan.getSoldeatnum()+_oldseats.length);
			newscheduelplan.setSoldeatnum(newsoldnum);
			newscheduelplan.setUpdateby(updateby);
			newscheduelplan.setUpdatetime(now);
			for(Ticketprice tp:newticketprices){
				if(tp.getSeatnos()==null ||tp.getSeatnos().equals("0")||tp.getSeatnos().equals("全部")){//BUG #10004 【5.041fix-黄石】被并班次为停班班，并入非停班班次，报错（同时验证：非流水/非停班→非流水/非停班）
					tp.setSoldeatnum(newsoldnum);
					tp.setUpdateby(updateby);
					tp.setUpdatetime(now);
				}else{
					int soldnum=0;
					String[] seats=tp.getSeatnos().split(",");					
					for(String seat:seats){
						short _seatno=new Short(seat);
						for(Scheduleseats nseat:newsecheduleseats){
						  if(_seatno==nseat.getSeatno() && nseat.getStatus().equals("2")){
								soldnum=soldnum+1;
						   }	
						}
					}						
					tp.setSoldeatnum((short) soldnum);
					tp.setUpdateby(updateby);
					tp.setUpdatetime(now);
				}
			}
			dao.merge(newscheduelplan);
			schedulemerge.setCreatetime(now);
			schedulemerge.setOldseats(oldseats);
			schedulemerge.setNewseats(lvnewseats);
			schedulemerge.setIsactive(true);//并班时 激活此状态 姜蓥瑞 2015年8月3日16:51:14
			schedulemerge = (Schedulemerge) dao.merge(schedulemerge);// 并班
			Long schedulestatuslogid = schedulestatuslogService.getId(
					schedulemerge.getOldscheduleid(),
					schedulestatuslog.getDepartdate());
			if (schedulestatuslogid > 0) {
				schedulestatuslog = schedulestatuslogService
						.getById(schedulestatuslogid);
				schedulestatuslog.setOperationtype("5");
				schedulestatuslog.setAfterstatus(schedulestatuslog
						.getBeforestatus());
				schedulestatuslog.setBeforestatus("5");
			} else {
				schedulestatuslog.setOperationtype("5");
				schedulestatuslog.setAfterstatus("5");
				schedulestatuslog.setBeforestatus("5");
				schedulestatuslog.setReason(schedulemerge.getReason());
			}
			schedulestatuslogService.save(schedulestatuslog);// 记录班次状态
			return schedulemerge;
		} else {
			List<Schedulemergedetail> detailList = mergedetailService
					.getBySchedulemergeid(schedulemerge.getId());
			for (int i = 0; i < detailList.size(); i++) {
				Scheduleseats scheduleseats = scheduleseatsService
						.findBySeatno(schedulemerge.getScheduleplanid(),
								detailList.get(i).getNewseatno());// 将被并班次并入的座位号置空
				scheduleseats.setStatus("0");
				scheduleseats.setTickettype("0");
				dao.merge(scheduleseats);

				Ticketsell ticketsell = dao.getTicketsell(schedulemerge
						.getScheduleplanid(), detailList.get(i).getNewseatno());// 将并班后产生的新座位号删除
				ticketsell.setScheduleplanid(schedulemerge
						.getOldscheduleplanid());
				ticketsell.setScheduleid(schedulemerge.getOldscheduleid());
				ticketsell.setSeatno(detailList.get(i).getOldseatno());
				dao.merge(ticketsell);
			}
			Scheduleplan scheduleplan = (Scheduleplan) dao.get(
					Scheduleplan.class, schedulemerge.getScheduleplanid());
			scheduleplan
					.setSoldeatnum((short) (scheduleplan.getSoldeatnum() - detailList
							.size()));
			dao.merge(scheduleplan);// 将并入班次已售座位数-被并班次已售座位数
			List<Ticketprice> ticketprice = priceService
					.getByScheduleplanid(schedulemerge.getScheduleplanid());
			for (int j = 0; j < ticketprice.size(); j++) {
				Ticketprice price = priceService.getById(ticketprice.get(j)
						.getId());
				price.setSoldeatnum((short) (price.getSoldeatnum() - detailList
						.size()));
				price.setUpdateby(schedulemerge.getCreateby());
				price.setUpdatetime(schedulemerge.getCreatetime());
				dao.merge(price);
			}
			schedulemerge.setIscancel(true);
			schedulemerge.setIsactive(true); // 并班时 激活此状态 姜蓥瑞 2015年8月3日16:51:48
			return (Schedulemerge) dao.merge(schedulemerge);
		}
	}
/*
	private void updateSeatno(Schedulemerge schedulemerge,
			List<Scheduleseats> scheduleseatslist,
			List<Scheduleseats> newseatslist, int i, Long planid,
			Scheduleseats seats) {
		if ("0".equals(seats.getStatus())) {
			// 如果被并班次座位不为空，并入班次的座位号为空座，则并班后座位号不变
			seats.setStatus("2");
			seats.setTickettype(scheduleseatslist.get(i).getTickettype());
			seats.setSeattype(scheduleseatslist.get(i).getSeattype());
			seats.setUpdateby(schedulemerge.getCreateby());
			seats.setUpdatetime(new Date());
			dao.merge(seats);// 并班后产生的新座位号，改变座位的状态
			Ticketsell ticketsell = dao.getTicketsell(
					schedulemerge.getOldscheduleplanid(), seats.getSeatno());
			ticketsell.setScheduleplanid(schedulemerge.getScheduleplanid());
			ticketsell.setScheduleid(schedulemerge.getNewscheduleid());
			ticketsell.setUpdateby(schedulemerge.getCreateby());
			ticketsell.setUpdatetime(schedulemerge.getCreatetime());
			ticketsell = (Ticketsell) dao.merge(ticketsell);
			mergeSchedulemergedetail(schedulemerge, seats, scheduleseatslist
					.get(i).getSeatno(), ticketsell.getId());// 并班车票的明细，并班前、并班后的座位号
		} else {
			// 如果被并班次座位不为空，并入班次的座位号不为空座，则并班后给该旅客换一个空座位给他，座位号发生改变
			List<Scheduleseats> seatslist = scheduleseatsService
					.getScheduleseatsBySeattype(
							schedulemerge.getScheduleplanid(), "0",
							scheduleseatslist.get(i).getSeattype());
			Scheduleseats scheduleseats = null;
			if (seatslist.size() > 0) {
				scheduleseats = scheduleseatsService.findSeatnoBySeattype(
						planid, seatslist.get(0).getSeatno(), seatslist.get(0)
								.getSeattype());
			} else {
				scheduleseats = scheduleseatsService.findBySeatno(planid,
						newseatslist.get(0).getSeatno());
			}
			scheduleseats.setStatus("2");
			scheduleseats.setTickettype(scheduleseatslist.get(i)
					.getTickettype());
			scheduleseats.setSeattype(scheduleseatslist.get(i).getSeattype());
			scheduleseats.setUpdateby(schedulemerge.getCreateby());
			scheduleseats.setUpdatetime(schedulemerge.getCreatetime());
			dao.merge(scheduleseats);// 并班后产生的新座位号，改变座位的状态
			Ticketsell ticketsell = dao.getTicketsell(
					schedulemerge.getOldscheduleplanid(), seats.getSeatno());
			ticketsell.setScheduleplanid(schedulemerge.getScheduleplanid());
			ticketsell.setScheduleid(schedulemerge.getNewscheduleid());
			ticketsell.setSeatno(scheduleseats.getSeatno());
			ticketsell.setUpdateby(schedulemerge.getCreateby());
			ticketsell.setUpdatetime(schedulemerge.getCreatetime());
			ticketsell = (Ticketsell) dao.merge(ticketsell);
			mergeSchedulemergedetail(schedulemerge, scheduleseats,
					scheduleseatslist.get(i).getSeatno(), ticketsell.getId());// 并班车票的明细，并班前、并班后的座位号
		}
	}

	private void mergeSchedulemergedetail(Schedulemerge schedulemerge,
			Scheduleseats seats, short oldseatno, long ticketsellid) {
		Schedulemergedetail schedulemergedetail = new Schedulemergedetail();
		schedulemergedetail.setSchedulemergeid(schedulemerge.getId());
		schedulemergedetail.setNewseatno(seats.getSeatno());
		schedulemergedetail.setOldseatno(oldseatno);
		schedulemergedetail.setCreateby(seats.getUpdateby());
		schedulemergedetail.setCreatetime(seats.getUpdatetime());
		schedulemergedetail.setTicketsellid(ticketsellid);
		dao.merge(schedulemergedetail);// 并班车票的明细，并班前、并班后的座位号
	}

	private boolean isMerge(Long oldscheduleid, Long oldscheduleplanid) {
		return dao.isMerge(oldscheduleid, oldscheduleplanid);
	}
*/
	@Override
	public boolean delete(Schedulemerge schedulestatus) {
		return dao.delete(schedulestatus);
	}

	@Override
	public boolean delete(Long id) {
		return dao.delete(Schedulemerge.class, id);
	}

	@Override
	public List<Schedulemerge> query() {
		return dao.query(Schedulemerge.class, null);
	}

	@Override
	public Schedulemerge getById(Long id) {
		return (Schedulemerge) dao.get(Schedulemerge.class, id);
	}

	/**
	 * 查询并班的班次信息
	 */
	@Override
	public List<Map<String, Object>> query(
			List<PropertyFilter> propertyFilterList) {
		return ListUtil.listToMap(new Object[] { Schedulemerge.class,
				"orgname", "oldcode", "newcode", "createname", "username",
				"plancode","olddepartdate" }, dao.query(propertyFilterList), new Object[] {
				Schedulemerge.class, String.class, String.class, String.class,
				String.class, String.class, String.class,Date.class});
	}

	@Override
	public Schedulemerge getByplanid(Long scheduleplanid) {
		return dao.getByplanid(scheduleplanid);
	}

	@Override
	public boolean equals(Long oldschedleid, Long newscheduleid) {
		Long oldrouteid = dao.getrouteid(oldschedleid);
		Long newrouteid = dao.getrouteid(newscheduleid);
		if (oldrouteid.equals(newrouteid)) {
			return true;
		}
		return false;
	}

	/**
	 * 判断要并班的两个班次的停靠站点是否
	 */
	@Override
	public boolean isContain(Schedulemerge schedulemerge) {
		List<Ticketprice> mergelist = dao.getTicketprice(
				schedulemerge.getScheduleplanid(),
				schedulemerge.getNewscheduleid());
		List<Ticketprice> oldmergelist = dao.getTicketprice(
				schedulemerge.getOldscheduleplanid(),
				schedulemerge.getOldscheduleid());
		if(mergelist!=null && mergelist.size() >0){
			for (int i = 0; i < mergelist.size(); i++) {
				if(oldmergelist!=null && oldmergelist.size() >0){
					for (int j = 0; j < oldmergelist.size(); j++) {
						if (oldmergelist.get(j).getDepartstationid() == mergelist
								.get(i).getDepartstationid()) {
							if (oldmergelist.get(j).getReachstationid() == mergelist
									.get(i).getReachstationid()) {
								return true;
							}
						}
					}
				}
			}
		}
		return false;
	}

	/**
	 * 判断要并班的两个班次的座位数 是否够坐
	 */
	@Override
	public boolean hasSeatnum(Schedulemerge schedulemerge) {
		short seatnum = dao.getSeatnum(schedulemerge.getNewscheduleid(),
				schedulemerge.getDepartdate());
		Scheduleplan oldshceduelplan = (Scheduleplan) dao.get(Scheduleplan.class, schedulemerge.getOldscheduleplanid());
		short soldeatnum = dao.getSoldeatnum(oldshceduelplan.getScheduleid(),oldshceduelplan.getDepartdate());
		if (seatnum >= soldeatnum) {
			return false;
		}
		return true;
	}

	@Override
	public boolean isbegincheck(Long scheduleplanid) {
		return dao.isbegincheck(scheduleplanid);
	}

	@Override
	public boolean isdeparted(Long scheduleplanid) {
		return dao.isdeparted(scheduleplanid);
	}

	@Override
	public boolean isTicketpriceUniqe(Schedulemerge schedulemerge) {
		List<Ticketprice> mergelist = dao.getTicketprice(
				schedulemerge.getScheduleplanid(),
				schedulemerge.getScheduleplanid());
		List<Ticketprice> oldmergelist = dao.getTicketprice(
				schedulemerge.getOldscheduleplanid(),
				schedulemerge.getOldscheduleid());
		for (int i = 0; i < mergelist.size(); i++) {
			if (oldmergelist.get(i).getFullprice() == mergelist.get(i)
					.getFullprice()) {
				if (oldmergelist.get(i).getStudentprice() == mergelist.get(i)
						.getStudentprice()) {
					if (oldmergelist.get(i).getHalfprice() == mergelist.get(i)
							.getHalfprice()) {
						return true;
					}
				}
			}
		}
		return false;
	}

	@SuppressWarnings("deprecation")
	@Override
	public boolean isTimeout(Long scheduleplanid, Date departdate) {
		Calendar calendar = Calendar.getInstance();
//		int hour = calendar.get(Calendar.HOUR);//12小时制的时间
		int hour = calendar.get(Calendar.HOUR_OF_DAY);//24小时制的时间
		int minute = calendar.get(Calendar.MINUTE);
		String departtime = dao.getdeparttime(scheduleplanid, departdate);
		String[] arr = departtime.split(":");
		int hours = Integer.parseInt(arr[0]);
		int minutes = Integer.parseInt(arr[1]);
		if ((departdate.getYear() + 1900) == calendar.get(Calendar.YEAR)) {
			if ((departdate.getMonth() + 1) == (calendar.get(Calendar.MONTH) + 1)) {
				if (departdate.getDate() == calendar.get(Calendar.DATE)) {
					if (hours > hour) {
						return false;
					} else if (hour == hours) {
						if (minutes > minute) {
							return false;
						}
					}
				} else if (departdate.getDate() > calendar.get(Calendar.DATE)) {
					return false;
				}
			} else if ((departdate.getMonth() + 1) > (calendar
					.get(Calendar.MONTH) + 1)) {
				return false;
			}
		} else if ((departdate.getYear() + 1900) > calendar.get(Calendar.YEAR)) {
			return false;
		}
		return true;
	}

	@Override
	public List<Map<String, Object>> queryScheduleplan(
			List<PropertyFilter> propertyFilterList) {
		return ListUtil.listToMap(new Object[] { Scheduleplan.class,
				"routename", "departtime", "routeid", "fullprice" },
				dao.querySchedule(propertyFilterList), new Object[] {
						Scheduleplan.class, String.class, String.class,
						Long.class, BigDecimal.class });
	}

}
