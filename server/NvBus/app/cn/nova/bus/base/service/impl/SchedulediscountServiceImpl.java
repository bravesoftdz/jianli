/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b><br/>
 * <b>文件名：</b>.java<br/>
 * <b>版本信息：</b>南凌客运信息管理系统 v4.0<br/>
 * <b>日期：</b> 2011-8-11 下午02:38:39 <br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 * 
 */
package cn.nova.bus.base.service.impl;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.base.dao.SchedulediscountDao;
import cn.nova.bus.base.dao.SchedulevipdiscountDao;
import cn.nova.bus.base.model.Schedule;
import cn.nova.bus.base.model.Schedulediscount;
import cn.nova.bus.base.model.Schedulevipdiscount;
import cn.nova.bus.base.service.SchedulediscountService;
import cn.nova.bus.log.model.Operationlog;
import cn.nova.bus.system.model.Digitaldictionarydetail;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;

/**
 * <b>类描述：</b>
 * <b>类名称：</b><br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2011-8-11 下午02:38:39	<br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
@SuppressWarnings("unchecked")
public class SchedulediscountServiceImpl implements SchedulediscountService {

	
	private SchedulediscountDao scheduledao = new SchedulediscountDao();

	
	private SchedulevipdiscountDao vipscheduledao = new SchedulevipdiscountDao();

	@Override
	public Schedulediscount save(Schedulediscount schedule,
			List<Schedulevipdiscount> schedulevipdiscounts, String id, String ip) {
		if (schedule.getId() == 0) {
			String ids = id.substring(1, id.length() - 1);
			String scid[] = ids.split(",");
			Schedulediscount discount = null;
			for (int i = 0; i < scid.length; i++) {
				long sid = Long.parseLong(scid[i]);
				schedule.setScheduleid(sid);
				Schedule sc = (Schedule) scheduledao.get(Schedule.class, sid);
				Operationlog operationLog = new Operationlog();
				operationLog.setIp(ip);
				operationLog.setContent("班次号："+sc.getCode()+" 添加班次折扣,一次性最小购" + schedule.getFromnum()
						+"张票才能打折，其中打折票最多购买"+schedule.getEndnum()+"张。");
				operationLog.setModule("业务管理->班次折扣管理");
				operationLog.setOperatetime(new Date());
				operationLog.setOperation("添加");
				operationLog.setSessionid("无session");
				operationLog.setUserid(schedule.getUpdateby());
				scheduledao.merge(operationLog);
				discount = (Schedulediscount) scheduledao.merge(schedule);
				for (Schedulevipdiscount schedulevipdiscount : schedulevipdiscounts) {
					if (schedulevipdiscount.getId() > 0) {
						// saveobj.add(dao.merge(handprice));
						// 进行修改操作
						Schedulevipdiscount entity = (Schedulevipdiscount) vipscheduledao
								.get(Schedulevipdiscount.class,
										schedulevipdiscount.getId());
						if (schedulevipdiscount.getVipgrade() != null) {
							entity.setVipgrade(schedulevipdiscount
									.getVipgrade());
						}
						if (schedulevipdiscount.getDefaultdiscountrate() != null) {
							entity.setDefaultdiscountrate(schedulevipdiscount
									.getDefaultdiscountrate());
						}
						entity.setUpdateby(schedule.getUpdateby());
						entity.setUpdatetime(new Date());
						vipscheduledao.merge(entity);
					} else {
						// 进行保存
						// getId(sid,schedule.getStartdate(),
						// schedule.getEnddate());
						schedulevipdiscount.setSchedulediscountid(discount.getId());
						schedulevipdiscount.setCreateby(schedule.getCreateby());
						schedulevipdiscount.setCreatetime(new Date());
						schedulevipdiscount.setUpdateby(schedule.getUpdateby());
						schedulevipdiscount.setUpdatetime(new Date());
						if (schedulevipdiscount.getDefaultdiscountrate() == null) {
							schedulevipdiscount.setDefaultdiscountrate(new BigDecimal(1));
						}
						vipscheduledao.merge(schedulevipdiscount);
					}
				}
			}
			return discount;
		} else {
			schedule.setScheduleid(Long.parseLong(id));
			for (Schedulevipdiscount schedulevipdiscount : schedulevipdiscounts) {
				Schedulevipdiscount entity = (Schedulevipdiscount) vipscheduledao
						.getByschedulediscountid(schedule.getId(),
								schedulevipdiscount.getVipgrade());
				if (entity != null) {
					entity.setDefaultdiscountrate(schedulevipdiscount.getDefaultdiscountrate());
					entity.setUpdateby(schedule.getUpdateby());
					entity.setUpdatetime(new Date());
					vipscheduledao.merge(entity);
				} else {
					// 进行保存
					schedulevipdiscount.setSchedulediscountid(schedule.getId());
					schedulevipdiscount.setCreateby(schedule.getCreateby());
					schedulevipdiscount.setCreatetime(new Date());
					schedulevipdiscount.setUpdateby(schedule.getUpdateby());
					schedulevipdiscount.setUpdatetime(new Date());
					vipscheduledao.merge(schedulevipdiscount);
				}
			}

			Schedule sc = (Schedule) scheduledao.get(Schedule.class, Long.parseLong(id));
			Operationlog operationLog = new Operationlog();
			operationLog.setIp(ip);
			operationLog.setContent("班次号："+sc.getCode()+" 修改班次折扣,一次性最小购" + schedule.getFromnum()
					+"张票才能打折，其中打折票最多购买"+schedule.getEndnum()+"张。");
			operationLog.setModule("业务管理->班次折扣管理");
			operationLog.setOperatetime(new Date());
			operationLog.setOperation("修改");
			operationLog.setSessionid("无session");
			operationLog.setUserid(schedule.getUpdateby());
			scheduledao.merge(operationLog);
			return (Schedulediscount) scheduledao.merge(schedule);
		}
	}

	@Override
	public boolean delete(Schedulediscount scheduled) {
		if (scheduled != null) {
			return scheduledao.del(scheduled);
		} else {
			return false;
		}
	}

	@Override
	public boolean delete(Long id) {
		@SuppressWarnings("rawtypes")
		List list = vipscheduledao.getByid(id);
		if (list.isEmpty()) {
			return scheduledao.delete(Schedulediscount.class, id);
		} else {
			return false;
		}
	}

	@Override
	public List<Schedulediscount> query() {
		return scheduledao.query(Schedulediscount.class, null);
	}

	@Override
	public Schedulediscount getById(Long id) {
		Schedulediscount count = (Schedulediscount) scheduledao.get(
				Schedulediscount.class, id);
		return count;
	}

	@Override
	public List<Map<String, Object>> query(
			List<PropertyFilter> propertyFilterList) {
		return ListUtil.listToMap(new Object[] { Schedulediscount.class,
				"code", "name", "helpcode", "starttime", "endstationid",
				"routeid", "orgname", "scheduleid" },
				scheduledao.query(propertyFilterList), new Object[] {
						Schedulediscount.class, String.class, String.class,
						String.class, String.class, String.class, Long.class,
						String.class, Long.class });
	}

	@Override
	public List<Map<String, Object>> queryvipdiscount(
			List<PropertyFilter> propertyFilterList, Long schedulediscountid) {
		List<Digitaldictionarydetail> dlist = scheduledao.queryvipdiscount();
		List<Object> objlist = new ArrayList<Object>();
		for (int i = 0; i < dlist.size(); i++) {
			Schedulevipdiscount entity = new Schedulevipdiscount();
			entity.setVipgrade(dlist.get(i).getCode());
			if (schedulediscountid == 0) {
				entity.setDefaultdiscountrate(null);
			} else {
				Schedulevipdiscount vipdiscount = vipscheduledao
						.getByschedulediscountid(schedulediscountid,
								dlist.get(i).getCode());
				entity.setDefaultdiscountrate(vipdiscount
						.getDefaultdiscountrate());
			}
			objlist.add(entity);
		}
		return ListUtil.listToMap(new Object[] { Schedulevipdiscount.class },
				objlist, new Object[] { Schedulevipdiscount.class });
	}

	@Override
	public Long getSeheduleid(String routeid, String code) {
		return scheduledao.getSeheduleid(routeid, code);
	}

	@Override
	public Long getSchedulediscountId() {
		return scheduledao.getSchedulediscountId();
	}

	@Override
	public Long getId(Long scheduleid, Date startdate, Date enddate) {
		return scheduledao.getId(scheduleid, startdate, enddate);
	}

}
