package cn.nova.bus.base.service.impl;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.base.dao.ScheduleperselldaysDao;
import cn.nova.bus.base.model.Schedule;
import cn.nova.bus.base.model.Scheduleperselldays;
import cn.nova.bus.base.service.ScheduleperselldaysService;
import cn.nova.bus.common.ParamterConst;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.system.service.ParameterService;
import cn.nova.bus.system.service.impl.ParameterServiceImpl;
import cn.nova.utils.commons.DateUtils;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.IDAO;
import cn.nova.utils.orm.jpa.ListUtil;


/**
 * <b>类描述：</b>班次预售天数控制<br/>
 * <b>类名称：</b>ScheduleperselldaysServiceImpl.java<br/>
 * <b>创建人：</b><a href="mailto:huanghaoze@nova.net.cn">hhz</a><br/>
 * <b>创建时间：</b>2012-9-12 6<br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
public class ScheduleperselldaysServiceImpl implements
		ScheduleperselldaysService {
	
	private IDAO<Scheduleperselldays> dao = new EntityManagerDaoSurport<Scheduleperselldays>();
	
	private IDAO<Schedule> comdao = new EntityManagerDaoSurport<Schedule>();
	
	private ScheduleperselldaysDao perselldaysdao = new ScheduleperselldaysDao();
	
	
	private ParameterService parameterService = new ParameterServiceImpl();
	
	@Override
	public List<Map<String, Object>> findScheduleperselldays(
			List<PropertyFilter> propertyFilterList) {
		Object[] fileds = { "id","orgid","orgname","typename","typecode","typeidname","perserlldays",
				"createname","updatename","createtime","updatetime",
				"typeid","createby","remarks","synccode" };		
		Object[] filedtypes = { long.class,long.class,String.class, String.class,long.class,String.class, Long.class,
				String.class,String.class,Timestamp.class, Timestamp.class,
				Long.class,Long.class,String.class,String.class};
		return ListUtil.listToMap(fileds,
				perselldaysdao.findscheduleperselldays(propertyFilterList), filedtypes);
	}
	
	@Override
	public Scheduleperselldays updateScheduleperselldays(Scheduleperselldays scheduleperselldays,
			String typeids) {
		Scheduleperselldays resultsellday = null;
		String[] typeid = typeids.split(",");
		if(scheduleperselldays.getType().equals("0")){
			Scheduleperselldays olddays = dao.get(Scheduleperselldays.class, scheduleperselldays.getId());
			olddays.setPerserlldays(scheduleperselldays.getPerserlldays());
			olddays.setRemarks(scheduleperselldays.getRemarks());
			olddays.setUpdateby(scheduleperselldays.getUpdateby());
			olddays.setUpdatetime(scheduleperselldays.getUpdatetime());
			resultsellday = dao.merge(olddays);
		}else{
			for(int a=0;a<typeid.length;a++){	
					Scheduleperselldays old = perselldaysdao.qryScheduleperselldays(
					scheduleperselldays.getOrgid(),scheduleperselldays.getType(),Long.parseLong(typeid[a]));		
					//查询已经存在的
					if (old!=null){
						old.setPerserlldays(scheduleperselldays.getPerserlldays());
						old.setRemarks(scheduleperselldays.getRemarks());
						old.setUpdateby(scheduleperselldays.getUpdateby());
						old.setUpdatetime(scheduleperselldays.getUpdatetime());
						resultsellday = dao.merge(old);
					}
					else{
						scheduleperselldays.setTypeid(Long.parseLong(typeid[a]));
						resultsellday = perselldaysdao.saveScheduleperselldays(scheduleperselldays);
					}
			}	
		}
		return resultsellday;
	}
	
	@Override
	public Scheduleperselldays saveScheduleperselldays(Scheduleperselldays scheduleperselldays,
			String typeids)  throws ServiceException {	
		Scheduleperselldays results=null;
		String[] typeid = typeids.split(",");
		if(scheduleperselldays.getType().equals("0")){
			Scheduleperselldays olddays = perselldaysdao.qryScheduleperselldays(
					scheduleperselldays.getOrgid(), scheduleperselldays.getType(), 0l);
			if(olddays!=null){
				//勾选的班线至少有一条已经添加控制，不允许重复添加
				throw new ServiceException("0384"); 
			}
			scheduleperselldays.setTypeid(0l);
			results = perselldaysdao.saveScheduleperselldays(scheduleperselldays);
		}else{
			for(int i=0;i<typeid.length;i++){
				Scheduleperselldays olddays = perselldaysdao.qryScheduleperselldays(
						scheduleperselldays.getOrgid(), scheduleperselldays.getType(), Long.parseLong(typeid[i]));
				if(olddays!=null){
					//勾选的班线至少有一条已经添加控制，不允许重复添加
					throw new ServiceException("0384"); 
				}
				scheduleperselldays.setTypeid(Long.parseLong(typeid[i]));
				results = perselldaysdao.saveScheduleperselldays(scheduleperselldays);
			}	
		}
		 return results;			
	}	

	@SuppressWarnings("unchecked")
	@Override
	public boolean delschedule(long id){
		return perselldaysdao.delete(Scheduleperselldays.class, id);		
	}
	
	@Override
	public List<Map<String, Object>> findscheduleOrRoute(long orgid,String type,boolean isupdate,long id,long routeid) {
		Object[] fileds = { "id", "name","code","starttime","checked" };
		return ListUtil.listToMap(fileds,
				perselldaysdao.findscheduleOrRoute(orgid,type,isupdate,id,routeid), 
				new Object[] {long.class,String.class,String.class,String.class, boolean.class });
	}
	
	/**
	 * 取班次的预售天数
	 * @param scheduleid
	 * @return 
	 */
	public Long getPerselldays(long scheduleid){
		Long result=1L;
		Schedule schedule = (Schedule) comdao.get(Schedule.class, scheduleid);
		Scheduleperselldays scheduleperselldays = perselldaysdao.qryScheduleperselldays(schedule.getOrgid(),"2",scheduleid);
		if(scheduleperselldays!=null){
			result = scheduleperselldays.getPerserlldays();
		}else{
			scheduleperselldays = perselldaysdao.qryScheduleperselldays(schedule.getOrgid(),"1",schedule.getRoute().getId());
			if(scheduleperselldays!=null){
				result =  scheduleperselldays.getPerserlldays();
			}else{
				scheduleperselldays = perselldaysdao.qryScheduleperselldays(schedule.getOrgid(),"0",0);
				if(scheduleperselldays!=null){
					result =  scheduleperselldays.getPerserlldays();
				}else{
					result = Long.parseLong(parameterService.findParamValue(ParamterConst.Param_1017, schedule.getOrgid()));// 车票预售天数
				}
			}
		}
		return result;
	}
	
	/**
	 * 判断班次是否在预售期内
	 * @param scheduleid
	 * @param departdate
	 * @return
	 */
	public boolean inPreSalePeriod(long scheduleid,Date departdate){
		Long days = getPerselldays(scheduleid);
		
		return DateUtils.add(new Date(),days).getTime()>=DateUtils.trunc(departdate).getTime();
	}

	
}
