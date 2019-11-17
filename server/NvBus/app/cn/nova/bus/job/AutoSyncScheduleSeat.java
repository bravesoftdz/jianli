package cn.nova.bus.job;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.LockModeType;
import javax.persistence.Query;

import cn.nova.bus.checkticket.service.CheckticketService;
import cn.nova.bus.checkticket.service.impl.CheckticketServiceImpl;
import cn.nova.bus.job.model.Jobconfig;
import cn.nova.bus.price.model.Scheduleplan;
import cn.nova.bus.price.model.Scheduleseats;
import cn.nova.bus.sale.model.Seatlock;
import cn.nova.bus.sale.service.AutoUnlockSeatService;
import cn.nova.bus.sale.service.impl.AutoUnlockSeatServiceImpl;
import cn.nova.utils.orm.PropertyFilter;
import play.db.jpa.JPA;
import play.jobs.Every;
import play.jobs.Job;
import util.BusJobUtil;
import util.TransactionUtil;
import util.UserTransaction;

//@Every("1min")
public class AutoSyncScheduleSeat extends Job {

	@Override
	public void doJob() {
		Jobconfig job = BusJobUtil.getJobConfig("AutoSyncScheduleSeat");
		if (job != null
				&& BusJobUtil.isTimeBetween4now(job.getStarttime(),
						job.getEndtime()) && job.isTriggerTime()) {
			syncSchedulSeat();
			TransactionUtil.begin();
			job = job.merge();
			job.save();
			TransactionUtil.commit();
		}
	}

	private void syncSchedulSeat() {
		play.Logger.info("-------------begin syncSchedulSeat-------------");
		TransactionUtil.begin();
		CheckticketService checkticketService = new CheckticketServiceImpl();
		StringBuilder sql = new StringBuilder()
				.append("select t.id  from Scheduleplan t, schedulestatus ss")
				.append(" where t.worktype = '3' and t.id = ss.scheduleplanid")
				.append(" and t.departdate = trunc(sysdate) and ss.departtime >= to_char(sysdate-30/24/60,'hh24:mi')")
				.append("  order by ss.departtime");
		Query query = JPA.em().createNativeQuery(sql.toString());
		// query.setLockMode(LockModeType.PESSIMISTIC_READ);
		List<Object> scheduleplanids = query.getResultList();
		play.Logger.info("scheduleplanids="+scheduleplanids.size());
		try {
			if (scheduleplanids != null) {				
				for (Object obj : scheduleplanids) {
					TransactionUtil.begin();
					long scheduleplanid = new Long(obj.toString());
					checkticketService.seatnums(scheduleplanid);
					TransactionUtil.commit();
				}				
			}
		} catch (Exception e) {
			if (JPA.em().getTransaction().isActive()) {
				JPA.em().getTransaction().rollback();
			}
			play.Logger.error("syncSchedulSeat", e);
		}
		play.Logger.info("-------------next syncSchedulSeat-------------");
		for(int i=1;i<=2;i++){
			sql = new StringBuilder().append("select t.id  from Scheduleplan t, schedulestatus ss")
					.append(" where t.worktype = '3' and t.id = ss.scheduleplanid")
					.append(" and t.departdate =trunc(sysdate+:days) ")
					.append("  order by t.departdate,ss.departtime");
			query = JPA.em().createNativeQuery(sql.toString());
			query.setParameter("days", i);
			List<Object> nextplanids = query.getResultList();
			play.Logger.info("nextplanids"+i+"="+nextplanids.size());
			try {
				if (nextplanids != null) {				
					for (Object obj : nextplanids) {
						TransactionUtil.begin();
						long scheduleplanid = new Long(obj.toString());
						checkticketService.seatnums(scheduleplanid);
						TransactionUtil.commit();
					}			
				}
			} catch (Exception e) {
				if (JPA.em().getTransaction().isActive()) {
					JPA.em().getTransaction().rollback();
				}
				play.Logger.error("syncSchedulSeat", e);
			}
		}
		play.Logger.info("-------------end syncSchedulSeat-------------");
	}
}
