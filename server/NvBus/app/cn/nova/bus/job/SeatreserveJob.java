package cn.nova.bus.job;

import java.util.Date;
import java.util.List;

import javax.persistence.LockModeType;

import play.db.jpa.JPABase;
import play.jobs.Every;
import play.jobs.Job;
import util.BusJobUtil;
import cn.nova.bus.dispatch.model.Seatreserve;
import cn.nova.bus.dispatch.service.ScheduleplanService;
import cn.nova.bus.dispatch.service.ScheduleseatsService;
import cn.nova.bus.dispatch.service.SeatreserveService;
import cn.nova.bus.dispatch.service.TicketpriceService;
import cn.nova.bus.dispatch.service.impl.ScheduleplanServiceImpl;
import cn.nova.bus.dispatch.service.impl.ScheduleseatsServiceImpl;
import cn.nova.bus.dispatch.service.impl.SeatreserveServiceImpl;
import cn.nova.bus.dispatch.service.impl.TicketpriceServiceImpl;
import cn.nova.bus.job.model.Jobconfig;
import cn.nova.bus.price.model.Scheduleplan;
import cn.nova.bus.price.model.Scheduleseats;
import cn.nova.bus.price.model.Ticketprice;

//@Every("1min")
public class SeatreserveJob extends Job {

//	private SeatreserveService seatsService = new SeatreserveServiceImpl();
//	private ScheduleplanService planService = new ScheduleplanServiceImpl();
//	private TicketpriceService priceService = new TicketpriceServiceImpl();
//	private ScheduleseatsService scheduleseatsService = new ScheduleseatsServiceImpl();

	@Override
	public void doJob() {
		Jobconfig job = BusJobUtil.getJobConfig("SeatreserveJob");
		if(job != null && BusJobUtil.isTimeBetween4now(job.getStarttime(),job.getEndtime()) && job.isTriggerTime()){
			SeatreserveService seatsService = new SeatreserveServiceImpl();
			ScheduleplanService planService = new ScheduleplanServiceImpl();
			TicketpriceService priceService = new TicketpriceServiceImpl();
			ScheduleseatsService scheduleseatsService = new ScheduleseatsServiceImpl();
			List<Seatreserve> seatsList = seatsService.getSeatreserveno(new Date());
			for (int i = 0; i < seatsList.size(); i++) {
				Seatreserve reserve = seatsService
						.getById(seatsList.get(i).getId());
				reserve.setAutocanceltime(null);
				reserve.setCanceltime(new Date());
				reserve.setSellstate("C");
				reserve.setUpdatetime(new Date());
				reserve = seatsService.saveReserve(reserve);
	
				Scheduleplan plan = planService
						.getById(reserve.getScheduleplanid());
				plan.setAutocancelreserveseatnum((short) (plan
						.getAutocancelreserveseatnum() - 1));
				if(plan.getAutocancelreserveseatnum()<0){
					plan.setAutocancelreserveseatnum((short) 0);
				}
				plan.setCarrychildnum((short) (plan.getCarrychildnum()-reserve.getCarrychildnum()));
				planService.save(plan);
				
				Scheduleseats scheduleseats = scheduleseatsService.findBySeatno(
						reserve.getScheduleplanid(),
						reserve.getSeatno());
				if(!scheduleseats.getStatus().equals("4")){
					continue;
				}
	
				scheduleseats.setStatus("0");
				scheduleseats.setUpdatetime(new Date());
				scheduleseatsService.save(scheduleseats);
	
				List<Ticketprice> priceList = priceService
						.getByScheduleplanSeattype(LockModeType.PESSIMISTIC_READ,reserve.getScheduleplanid(),scheduleseats.getSeattype());
				for (Ticketprice ticketprice: priceList) {
					ticketprice.setAutocancelreserveseatnum((short) (ticketprice
							.getAutocancelreserveseatnum() - 1));
					if(ticketprice.getAutocancelreserveseatnum()<0){
						ticketprice.setAutocancelreserveseatnum(plan.getAutocancelreserveseatnum());
					}
					//暂不更新修改时间
	//					ticketprice.setUpdatetime(new Date());
					priceService.save(ticketprice);
				}
			}
			job.setLastruntime(new Date());
			job = job.merge();
			job.save();
		}
	}

}
