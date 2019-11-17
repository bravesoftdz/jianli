/**
 * 
 */
package cn.nova.bus.base.service.impl;

import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.base.dao.TicketreturnrateDao;
import cn.nova.bus.base.model.Ticketreturnrate;
import cn.nova.bus.base.service.TicketreturnrateService;
import cn.nova.bus.common.ParamterConst;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.system.service.ParameterService;
import cn.nova.bus.system.service.impl.ParameterServiceImpl;
import cn.nova.utils.orm.PropertyFilter;

/**
 * @author ice
 *
 */
public class TicketreturnrateServiceImpl implements TicketreturnrateService {

	
	private TicketreturnrateDao ticketreturnrateDao = new TicketreturnrateDao();
	
	
	private ParameterService parameterService = new ParameterServiceImpl();
	
	/* (non-Javadoc)
	 * @see cn.nova.bus.base.service.TicketreturnrateService#query(java.util.List)
	 */
	@Override
	public List<Map<String, Object>> query(List<PropertyFilter> propertyFilters) {
		//根据参数1103、1104对新机构初始化两条记录
		/*for (PropertyFilter propertyFilter : propertyFilters) {
			if(propertyFilter.getPropertyFullName().equals("o!id")){
				StringBuilder sb = new StringBuilder();
				sb.append("insert into ticketreturnrate                                                                                     ")
				.append("   (id, orgid, timepoint, prerate, createtime, createby, updatetime, updateby)                                     ")
				.append(" select seq_pub.nextval,t.*                                                                                        ")
				.append("   from (select o.id as orgid,0 as timepoint,(select value/100 from parameter where code='1104') as prerate        ")
				.append("               ,sysdate as createtime,0 as createby,sysdate as updatetime,0 as updateby                            ")
				.append("           From organization o                                                                                     ")
				.append("         where o.islocal=1                                                                                         ")
				.append("           and o.isactive=1                                                                                        ")
				.append("           and not exists (select 'X' from ticketreturnrate ttr where ttr.orgid=o.id and ttr.timepoint=0)          ")
				.append("         union                                                                                                     ")
				.append("         select o.id,2,(select value/100 from parameter where code='1103'),sysdate,0,sysdate,0                     ")
				.append("           From organization o                                                                                     ")
				.append("         where o.islocal=1                                                                                         ")
				.append("           and o.isactive=1                                                                                        ")
				.append("           and not exists (select 'X' from ticketreturnrate ttr where ttr.orgid=o.id and ttr.timepoint=0)          ")
				.append("        ) t                                                                                                        ")
				;
				Query query = ticketreturnrateDao.getEntityManager().createNativeQuery(sb.toString());
				query.executeUpdate();
				break;
			}
		}*/
		return ticketreturnrateDao.query(propertyFilters);
	}

	/**
	 * 查出指定机构所有记录，按距发车时间倒序
	 * @param orgid
	 * @return
	 */
	private List<Ticketreturnrate> queryAll(long orgid){
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		propertyFilters.clear();
		propertyFilters.add(new PropertyFilter("EQL_t!orgid", orgid));
		return ticketreturnrateDao.find(Ticketreturnrate.class, propertyFilters,new String[]{"t.timepoint"});
	}
	
	/* (non-Javadoc)
	 * @see cn.nova.bus.base.service.TicketreturnrateService#merge(cn.nova.bus.base.model.Ticketreturnrate)
	 */
	@Override
	public Ticketreturnrate merge(Ticketreturnrate ticketreturnrate)
			throws ServiceException {
		//本表总数据量小于5条，所以全部查出来。
		List<Ticketreturnrate> _ticketreturnrates = queryAll(ticketreturnrate.getOrgid());
		int sametimecount = 0;
		Ticketreturnrate ticketreturnrate_same = null;
		for (Ticketreturnrate _ticketreturnrate : _ticketreturnrates) {
			if(_ticketreturnrate.getTimepoint()==ticketreturnrate.getTimepoint()){
				sametimecount++;
				if(_ticketreturnrate.getId()==ticketreturnrate.getId()){
					ticketreturnrate_same = _ticketreturnrate;
				}
			}
		}
		if(ticketreturnrate.getId()>0){
			if(sametimecount>1){
				throw new ServiceException("0361");//该时间点已经存在
			}
			else{
				if(_ticketreturnrates.size()==1&&ticketreturnrate_same.getId()!=ticketreturnrate.getId()){
					throw new ServiceException("0361");
				}
				else{
					return _merge(ticketreturnrate,_ticketreturnrates);
				}
			}
		}
		else{
			if(sametimecount>0){
				throw new ServiceException("0361");//该时间点已经存在
			}
			else{
				return _merge(ticketreturnrate,_ticketreturnrates);
			}
		}
	}

	private Ticketreturnrate _merge(Ticketreturnrate ticketreturnrate,List<Ticketreturnrate> _ticketreturnrates)
			throws ServiceException {
		//判断费率是否合理
		Ticketreturnrate ticketreturnrate_pre = null;
		for (int i = _ticketreturnrates.size()-1; i >=0 ; i--) {
			if(_ticketreturnrates.get(i).getTimepoint()>ticketreturnrate.getTimepoint()){
				ticketreturnrate_pre = _ticketreturnrates.get(i); 
			}
		}
		if(ticketreturnrate_pre!=null&&ticketreturnrate_pre.getPrerate().compareTo(ticketreturnrate.getPrerate())==1){
			throw new ServiceException("0358");//费率不能小于前一个时间点的费率
		}
		Ticketreturnrate ticketreturnrate_after = null;
		for (int i = 0; i < _ticketreturnrates.size(); i++) {
			if(_ticketreturnrates.get(i).getTimepoint()<ticketreturnrate.getTimepoint()){
				ticketreturnrate_after = _ticketreturnrates.get(i); 
			}
		}
		if(ticketreturnrate_after!=null&&ticketreturnrate_after.getPrerate().compareTo(ticketreturnrate.getPrerate())==-1){
			throw new ServiceException("0359");//费率不能大于后一个时间点的费率
		}
		//保存
		return ticketreturnrateDao.merge(ticketreturnrate);
		
	}
	public TicketreturnrateDao getTicketreturnrateDao() {
		return ticketreturnrateDao;
	}

	public void setTicketreturnrateDao(TicketreturnrateDao ticketreturnrateDao) {
		this.ticketreturnrateDao = ticketreturnrateDao;
	}

	@Override
	public boolean delete(Ticketreturnrate ticketreturnrate)
			throws ServiceException {
		/*if(ticketreturnrate.getTimepoint()==0){
			throw new ServiceException("0360");//时间点为发车时间的记录不允许删除
		}*/
		return ticketreturnrateDao.del(ticketreturnrate);
	}
	
	
	@Override
	public BigDecimal getticketreturnrate(long orgid, BigDecimal hours) {
									
			List<Ticketreturnrate> _ticketreturnrates = queryAll(orgid);
			Ticketreturnrate ticketreturnrate_after = null;
			for (int i = 0; i < _ticketreturnrates.size(); i++) {
				if(hours.compareTo(new BigDecimal(_ticketreturnrates.get(i).getTimepoint()))>0){
					ticketreturnrate_after = _ticketreturnrates.get(i);				
					
				}				
			}
			if(ticketreturnrate_after!=null){
				return ticketreturnrate_after.getPrerate();
			}
			else{
				if(_ticketreturnrates.size()==0){
					//取参数
					if(hours.compareTo(new  BigDecimal(2))>=0){
						return new BigDecimal(parameterService.findParamValue(ParamterConst.Param_1103, orgid)).divide(new BigDecimal(100));
					}
					else if(hours.compareTo(new  BigDecimal(0))>=0){
						return new BigDecimal(parameterService.findParamValue(ParamterConst.Param_1104, orgid)).divide(new BigDecimal(100));
					}
					else{
						return new BigDecimal(1);
					}
				}
				else{
					return new BigDecimal(1);
				}
			}
								
		
	}

	@Override
	public BigDecimal getticketreturnrate(long orgid, BigDecimal hours ,Date departtime,boolean islinework) {
		
		String param1078 = parameterService.findParamValue(ParamterConst.Param_1078, orgid);  
		if(islinework&&param1078.equals(ParamterConst.COMMON_FLAG.FALG_YES)){//是否启用流水班退票手续费率，1启用、0不启用
			
			//新增参数1178：(1表示开启，0关闭)参数开启：退票时间如果在当天20%手续费，当天之前则为10%；（程序写固定），参数未开启则按退票手续费率设置的逻辑走
			if(ParamterConst.COMMON_FLAG.FALG_YES.equals(parameterService.findParamValue(ParamterConst.Param_1178, orgid)))
			{
				/*DateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
				String departdatetime = fmt.format(departtime);*/
				int month = departtime.getMonth(); //发车时间
				int date = departtime.getDate();  
				int currmonth = new Date().getMonth();
				int currdate = new Date().getDate(); //当前时间
				if(month==currmonth)
				{
					if(currdate<date ) //当前时间小于发车时间
					{
						return new BigDecimal(0.10);
					}
					else if (currdate==date)
					{
						return new BigDecimal(0.20);
					}else
					{
						return new BigDecimal(1);
					}
						
				}else if(currmonth<month)
				{
					return new BigDecimal(0.10);
				}else
				{
					return new BigDecimal(1);
				}
				
			}else
			{
			//取参数
				if(hours.compareTo(new BigDecimal(0))>0){//流水班发车前退票手续费率
					return new BigDecimal(parameterService.findParamValue("1088", orgid)).divide(new BigDecimal(100));
				}			
				else{
					return new BigDecimal(1);
				}							
			}
		}else{
			//新增参数1178：(1表示开启，0关闭)参数开启：退票时间如果在当天20%手续费，当天之前则为10%；（程序写固定），参数未开启则按退票手续费率设置的逻辑走
			if(ParamterConst.COMMON_FLAG.FALG_YES.equals(parameterService.findParamValue(ParamterConst.Param_1178, orgid)))
			{
				/*DateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
				String departdatetime = fmt.format(departtime);*/
				int month = departtime.getMonth(); //发车时间
				int date = departtime.getDate();  
				int currmonth = new Date().getMonth();
				int currdate = new Date().getDate(); //当前时间
				if(month==currmonth)
				{
					if(currdate<date ) //当前时间小于发车时间
					{
						return new BigDecimal(0.10);
					}
					else if (currdate==date)
					{
						return new BigDecimal(0.20);
					}else
					{
						return new BigDecimal(1);
					}
						
				}else if(currmonth<month)
				{
					return new BigDecimal(0.10);
				}else
				{
					return new BigDecimal(1);
				}
				
			}
			else
			{
			List<Ticketreturnrate> _ticketreturnrates = queryAll(orgid);
			Ticketreturnrate ticketreturnrate_after = null;
			for (int i = 0; i < _ticketreturnrates.size(); i++) {
				if(hours.compareTo(new BigDecimal(_ticketreturnrates.get(i).getTimepoint()))>0){
					ticketreturnrate_after = _ticketreturnrates.get(i);				
					
				}				
			}
			if(ticketreturnrate_after!=null){
				return ticketreturnrate_after.getPrerate();
			}
			else{
				if(_ticketreturnrates.size()==0){
					//取参数
					if(hours.compareTo(new  BigDecimal(2))>=0){
						return new BigDecimal(parameterService.findParamValue(ParamterConst.Param_1103, orgid)).divide(new BigDecimal(100));
					}
					else if(hours.compareTo(new  BigDecimal(0))>=0){
						return new BigDecimal(parameterService.findParamValue(ParamterConst.Param_1104, orgid)).divide(new BigDecimal(100));
					}
					else{
						return new BigDecimal(1);
					}
				}
				else{
					return new BigDecimal(1);
				}
			}
		}
										
	}
	}
	public ParameterService getParameterService() {
		return parameterService;
	}

	public void setParameterService(ParameterService parameterService) {
		this.parameterService = parameterService;
	}

}
