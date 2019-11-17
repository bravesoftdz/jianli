/**
 * 
 */
package cn.nova.bus.sale.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Timer;

import javax.naming.NamingException;
import javax.persistence.LockModeType;
import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.price.model.Scheduleplan;
import cn.nova.bus.price.model.Scheduleseats;
import cn.nova.bus.sale.model.Seatlock;
import cn.nova.bus.sale.service.AutoUnlockSeatService;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.IDAO;
import play.db.jpa.JPA;

/**
 * @author ice
 * 
 */

public class AutoUnlockSeatServiceImpl implements AutoUnlockSeatService {

//	@Resource
//	private TimerService timerService;
	
	
	private IDAO dao = new EntityManagerDaoSurport();
	/*
	 * (non-Javadoc)
	 * 
	 * @see cn.nova.bus.sale.service.AutoUnlockSeatService#start(long)
	 */
	@Override
	public void start() {
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		//解锁时间超过当前时间-3秒，减3秒是为了不与客户端自动解锁冲突
//		propertyFilters.add(new PropertyFilter("LTD_t!autounlocktime", new Date(System.currentTimeMillis()-3000)));
//		List<Seatlock> seatlocks = dao.find(LockModeType.PESSIMISTIC_READ,Seatlock.class,propertyFilters);
		
		String sql = "select t from Seatlock t where t.autounlocktime <=  SYSDATE - 3 / 24 / 60 / 60 ";
		Query query = JPA.em().createQuery(sql.toString());
		query.setLockMode(LockModeType.PESSIMISTIC_READ);
		List<Seatlock> seatlocks = query.getResultList();
		play.Logger.info("AutoUnlockSeatServiceImpl.seatlocks.size()="+seatlocks.size());
		if(seatlocks!=null){
			for (Seatlock seatlock : seatlocks) {
				propertyFilters.clear();
				propertyFilters.add(new PropertyFilter("EQL_t!scheduleplan.id", seatlock.getId().getScheduleplanid()));
				propertyFilters.add(new PropertyFilter("EQR_t!seatno", seatlock.getId().getSeatno()));
				Scheduleseats scheduleseat = (Scheduleseats) dao.uniqueResult(LockModeType.PESSIMISTIC_READ,Scheduleseats.class,propertyFilters);
				if(scheduleseat!=null){
					scheduleseat.setStatus(seatlock.getOldstatus());
					dao.merge(scheduleseat);
				}
				if(seatlock.getCarrychildnum()!=null&&seatlock.getCarrychildnum()>0){
					Scheduleplan scheduleplan = (Scheduleplan) dao.get(Scheduleplan.class, seatlock.getId().getScheduleplanid());
					scheduleplan.setCarrychildnum((short) (scheduleplan.getCarrychildnum()-seatlock.getCarrychildnum()));
					dao.merge(scheduleplan);
				}
				play.Logger.info("seatlockip="+seatlock.getLockip()+",schduleid="+seatlock.getScheduleid()+",orderno="+seatlock.getOrderno());
				dao.delete(seatlock);
			}
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see cn.nova.bus.sale.service.AutoUnlockSeatService#start(long)
	 */
	@Override
	public void start(long milliseconds) {
//		timerService.createIntervalTimer(30 * 1000L, milliseconds, null);
	}

//	@Timeout
	public void timeoutHandler(Timer timer) {
		// timer.cancel();
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		propertyFilters.add(new PropertyFilter("GED_t!autounlocktime", new Date()));
		List<Seatlock> seatlocks = dao.find(LockModeType.PESSIMISTIC_READ,Seatlock.class,propertyFilters);
		if(seatlocks!=null){
			for (Seatlock seatlock : seatlocks) {
				propertyFilters.clear();
				propertyFilters.add(new PropertyFilter("EQL_t!scheduleplan.id", seatlock.getId().getScheduleplanid()));
				propertyFilters.add(new PropertyFilter("EQR_t!seatno", seatlock.getId().getSeatno()));
				Scheduleseats scheduleseat = (Scheduleseats) dao.uniqueResult(LockModeType.PESSIMISTIC_READ,Scheduleseats.class,propertyFilters);
				if(scheduleseat!=null){
					scheduleseat.setStatus(seatlock.getOldstatus());
					dao.merge(scheduleseat);
				}
				if(seatlock.getCarrychildnum()!=null&&seatlock.getCarrychildnum()>0){
					Scheduleplan scheduleplan = (Scheduleplan) dao.get(Scheduleplan.class, seatlock.getId().getScheduleplanid());
					scheduleplan.setCarrychildnum((short) (scheduleplan.getCarrychildnum()-seatlock.getCarrychildnum()));
					dao.merge(scheduleplan);
				}
				dao.delete(seatlock);
			}
		}
	}

}
