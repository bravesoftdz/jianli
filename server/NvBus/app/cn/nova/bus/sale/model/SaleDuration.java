package cn.nova.bus.sale.model;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.naming.NamingException;

import cn.nova.bus.base.model.Ticketoutlets;
import cn.nova.bus.common.ParamterConst;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.exception.BusinessException;
import cn.nova.bus.system.model.Organization;
import cn.nova.bus.system.service.ParameterService;
import cn.nova.bus.system.service.impl.ParameterServiceImpl;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.IDAO;

/**
 * 取班次销售时间区间
 * @author ice
 *
 */
public class SaleDuration {
	private long ticketoutletsId;
	private String sellway;

	private Date departDate;
	private Long departStationId;
	private String departTime;

	//取系统参数
	private short preSaleDays;//预售日期
	private short preSaleMinutes;//售票截止时间
	private short excessSaleMinutes; //补票截止时间
	//中间变量
	private boolean ticketoutlets_in;
	private short preSaleMinutes_in;//站内售票点售票截止时间
	private short preSaleMinutes_out;//站外售票点售票截止时间
	
	@SuppressWarnings("rawtypes")
	private IDAO dao;
	private ParameterService parameterService;

	public SaleDuration(long ticketoutletsId,String sellway,Date departDate,long departStationId,String departTime){  
		this.ticketoutletsId=ticketoutletsId;
		this.sellway=sellway;
		this.departStationId=departStationId;
		this.departDate=departDate;
		this.departTime = departTime;
		initParameter();
	}
	
	public static boolean isInTime(String sellway,Date departDate,String departTime,
								   short preSaleDays,short preSaleMinutes,short excessSaleMinutes,
								   Date contrastTime){
		if(contrastTime==null){
			contrastTime=new Date();
		}
		Calendar calendar_contrast = Calendar.getInstance();
		calendar_contrast.setTime(contrastTime);
		//开始售票时间
		Calendar calendar_startdate = Calendar.getInstance();
		calendar_startdate.setTime(departDate);
		calendar_startdate.set(calendar_startdate.get(Calendar.YEAR), 
						calendar_startdate.get(Calendar.MONTH), 
						calendar_startdate.get(Calendar.DAY_OF_MONTH), 
						0,0, 0);
		calendar_startdate.add(Calendar.DAY_OF_YEAR, -1*preSaleDays);
		//截止售票时间
		Calendar calendar_endtime = Calendar.getInstance();
		calendar_endtime.setTime(departDate);
		calendar_endtime.set(calendar_endtime.get(Calendar.YEAR), 
						calendar_endtime.get(Calendar.MONTH), 
						calendar_endtime.get(Calendar.DAY_OF_MONTH), 
						new Integer(departTime.substring(0,2)), 
						new Integer(departTime.substring(3,5)), 0);
		//0售票、1补票、2特权补票、3代售票、4改票、5手工票、6留票销售、7网上售票、8订票
		if("1".equals(sellway)){
			calendar_endtime.add(Calendar.MINUTE, -1*Math.min(preSaleMinutes,excessSaleMinutes));
		}else if("2".equals(sellway)||"5".equals(sellway)){
			calendar_endtime.set(Calendar.HOUR_OF_DAY, 23);
			calendar_endtime.set(Calendar.MINUTE, 59);
			calendar_endtime.set(Calendar.SECOND, 59);
		}else{
			calendar_endtime.add(Calendar.MINUTE, -1*preSaleMinutes);
		}
		if("2".equals(sellway)||"5".equals(sellway)){
			return calendar_startdate.before(calendar_contrast);
		}else{
			return calendar_startdate.before(calendar_contrast)&&calendar_endtime.after(calendar_contrast);
		}
	}
	
	public boolean isInTime(Date contrastTime){
		return isInTime(this.sellway,this.departDate,this.departTime,
						this.preSaleDays,this.preSaleMinutes,this.excessSaleMinutes,
				   		contrastTime);
	}
	
	public void initParameter(){
		//根据departStationid取orgId
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		propertyFilters.add(new PropertyFilter("EQL_t!station.id", this.departStationId));
		propertyFilters.add(new PropertyFilter("EQB_t!isactive", true));
		Organization org = (Organization)getDao().uniqueResult(Organization.class, propertyFilters);
		Long orgid=null;
		if (org!=null) {
			orgid=org.getId();
		}
		preSaleDays = new Short(getParameterService().findParamValue(ParamterConst.Param_1017, orgid));// 车票预售天数
		preSaleMinutes_in=new Short(getParameterService().findParamValue(ParamterConst.Param_1018, orgid));//站内售票点售票截止时间（距离发班），单位为分钟
		preSaleMinutes_out=new Short(getParameterService().findParamValue(ParamterConst.Param_1019, orgid));//站外售票点售票截止时间（距离发班），单位为分钟
		excessSaleMinutes = new Short(getParameterService().findParamValue(ParamterConst.Param_1015, orgid));//补票截止时间
		
		Ticketoutlets ticketoutlets = (Ticketoutlets)getDao().get(Ticketoutlets.class, this.ticketoutletsId);
		ticketoutlets_in="0".equals(ticketoutlets.getType());
		if(ticketoutlets_in){
			preSaleMinutes = preSaleMinutes_in;
		}
		else{
			preSaleMinutes = preSaleMinutes_out;
		}
	}

	/**
	 * @return the dao
	 */
	@SuppressWarnings("rawtypes")
	public IDAO getDao() {
		dao = new EntityManagerDaoSurport();
		return dao;
	}

	/**
	 * @param dao the dao to set
	 */
	@SuppressWarnings("rawtypes")
	public void setDao(IDAO dao) {
		this.dao = dao;
	}

	/**
	 * @param parameterService the parameterService to set
	 */
	public void setParameterService(ParameterService parameterService) {
		this.parameterService = parameterService;
	}

	/**
	 * @return the parameterService
	 */
	public ParameterService getParameterService() {
		if(parameterService==null){
			parameterService = new ParameterServiceImpl();
		}
		return parameterService;
	}
	
}
