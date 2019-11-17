package cn.nova.bus.query.action;

import cn.nova.bus.action.BaseAction;
import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.query.service.DispatchQryService;
import cn.nova.bus.query.service.impl.DispatchQryServiceImpl;
import cn.nova.bus.report.param.Reportparam;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.web.ServletPropertyFilterUtil;

/**
 *<b>类描述：调度查询</b><br/>
 * <b>类名称：</b>DispatchQryAction<br/>
 * <b>调度查询总模块；包括 ；客运班线发车时刻表，客运班线发车时刻表，晚点班次情况查询
 * 		脱班班次情况查询，并班情况查询</b> 
 * <b>创建人：</b><a href="mailto:huanghaoze@nova.net.cn">hhz</a><br/>
 * <b>修改内容：班次停班 </b><br/> 
 * <b>修改时间：2013-03-26</b><br/>
 * <b>修改人：</b><a href="mailto:huanghaoze@nova.net.cn">hhz</a><br/>
 * @author hhz
 */
public class DispatchQryAction extends BaseAction{

	DispatchQryService dispatchQueryService;
	//返回结果
	private List<Map<String,Object>>  resultmap;
	private List<Map<String,Object>> mergeDetailmap;
	private int scheduleplanid;
	private int scheduleid;
	private List<Map<String,Object>> soldlist;
	private long curstationid;
	private Date departdate;
	private String vehicleno;
	private Reportparam rp;
	private String notbalance;//未结算查询条件
	private long departinvoicesid;
	private String sellorgid;
	private String loststatus;

	/**
	 *	客运班线发车时刻表
	 * @return
	 */
	public String findcheduleDepartTime(){
		try{
			List<PropertyFilter> propertyFilterList =ServletPropertyFilterUtil.buildFromHttpRequest();
			dispatchQueryService = new DispatchQryServiceImpl();
			setResultmap(dispatchQueryService.queryScheduleDepartTime(propertyFilterList));			
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	/**
	 *	客运班线运营情况
	 * @return
	 */
	public String findScheduleRunSituation(){
		try{
			List<PropertyFilter> propertyFilterList =ServletPropertyFilterUtil.buildFromHttpRequest();
			dispatchQueryService = new DispatchQryServiceImpl();
			setResultmap(dispatchQueryService.queryScheduleRunSituation(propertyFilterList,curstationid, departdate,sellorgid));			
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	/**
	 *	客运班线运营情况---班次售票汇总表
	 * @return
	 */
	public String findSoldSituation(){
		try{
			dispatchQueryService = new DispatchQryServiceImpl();
			setSoldlist(dispatchQueryService.querySoldSituation(scheduleplanid,scheduleid));			
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	/**
	 *	晚点班次情况查询
	 * @return  
	 */
	public String findVehicleLateSituation(){
		try{
			List<PropertyFilter> propertyFilterList =ServletPropertyFilterUtil.buildFromHttpRequest();
			dispatchQueryService = new DispatchQryServiceImpl();
			setResultmap(dispatchQueryService.queryVehicleLate(propertyFilterList,notbalance));	
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	/**
	 *	脱班班次情况查询
	 * @return
	 */
	public String findVehicleLostSituation(){
		try{
			List<PropertyFilter> propertyFilterList =ServletPropertyFilterUtil.buildFromHttpRequest();
			dispatchQueryService = new DispatchQryServiceImpl();
			setResultmap(dispatchQueryService.queryVehicleLost(propertyFilterList));			
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	/**
	 *停班班次情况查询
	 * @return
	 */
	public String findVehicleStop(){
		try{
			List<PropertyFilter> propertyFilterList =ServletPropertyFilterUtil.buildFromHttpRequest();
			dispatchQueryService = new DispatchQryServiceImpl();
			setResultmap(dispatchQueryService.queryVehicleStop(propertyFilterList,vehicleno,loststatus));			
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	/**
	 * 并班情况查询
	 * @return
	 */
	public String findSchedulemergeSituation(){
		try{
			List<PropertyFilter> propertyFilterList =ServletPropertyFilterUtil.buildFromHttpRequest();
			dispatchQueryService = new DispatchQryServiceImpl();
			setResultmap(dispatchQueryService.queryschedulemerge(propertyFilterList));			
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	/**
	 * 班次并班车票明细情况查询
	 * @return
	 */
	public String queryschedulemergeDetail(){
		try{
			List<PropertyFilter> propertyFilterList =ServletPropertyFilterUtil.buildFromHttpRequest();
			dispatchQueryService = new DispatchQryServiceImpl();
			setMergeDetailmap(dispatchQueryService.queryschedulemergeDetail(propertyFilterList));			
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	/**
	 *	加班班次查询
	 * @return
	 */
	public String findOvertimeSchedule(){
		try{
			List<PropertyFilter> propertyFilterList =ServletPropertyFilterUtil.buildFromHttpRequest();
			dispatchQueryService = new DispatchQryServiceImpl();
			setResultmap(dispatchQueryService.queryOvertimeSchedule(propertyFilterList,curstationid));			
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	/**
	 * 满座班次查询
	 * 
	 * @return
	 */
	public String qryFullSeatSchedule(){
		try{
			dispatchQueryService = new DispatchQryServiceImpl();
			setResultmap(dispatchQueryService.queryFullSeatSchedule(
					ServletPropertyFilterUtil.buildFromHttpRequest()));			
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	/**
	 * 车辆应班登记表
	 * 
	 * @return
	 */
	public String queryVehicleLicense(){
		try{
			dispatchQueryService = new DispatchQryServiceImpl();
			setResultmap(dispatchQueryService.queryVehicleLicense(rp));			
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	/**
	 * 运量单，车票明细
	 * 
	 * @return
	 */
	public String queryTicketInfo(){
		try{
			dispatchQueryService = new DispatchQryServiceImpl();
			setResultmap(dispatchQueryService.queryTicketInfo(departinvoicesid));			
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	public List<Map<String, Object>> getResultmap() {
		return resultmap;
	}

	public void setResultmap(List<Map<String, Object>> resultmap) {
		this.resultmap = resultmap;
	}

	public List<Map<String, Object>> getMergeDetailmap() {
		return mergeDetailmap;
	}

	public void setMergeDetailmap(List<Map<String, Object>> mergeDetailmap) {
		this.mergeDetailmap = mergeDetailmap;
	}

	public int getScheduleplanid() {
		return scheduleplanid;
	}

	public void setScheduleplanid(int scheduleplanid) {
		this.scheduleplanid = scheduleplanid;
	}

	public int getScheduleid() {
		return scheduleid;
	}

	public void setScheduleid(int scheduleid) {
		this.scheduleid = scheduleid;
	}

	public List<Map<String, Object>> getSoldlist() {
		return soldlist;
	}

	public void setSoldlist(List<Map<String, Object>> soldlist) {
		this.soldlist = soldlist;
	}

	public long getCurstationid() {
		return curstationid;
	}

	public void setCurstationid(long curstationid) {
		this.curstationid = curstationid;
	}
	
	public Date getDepartdate() {
		return departdate;
	}

	public void setDepartdate(Date departdate) {
		this.departdate = departdate;
	}

	public String getVehicleno() {
		return vehicleno;
	}

	public void setVehicleno(String vehicleno) {
		this.vehicleno = vehicleno;
	}
	public Reportparam getRp() {
		return rp;
	}

	public void setRp(Reportparam rp) {
		this.rp = rp;
	}

	public String getNotbalance() {
		return notbalance;
	}

	public void setNotbalance(String notbalance) {
		this.notbalance = notbalance;
	}

	public long getDepartinvoicesid() {
		return departinvoicesid;
	}

	public void setDepartinvoicesid(long departinvoicesid) {
		this.departinvoicesid = departinvoicesid;
	}

	public String getSellorgid() {
		return sellorgid;
	}

	public void setSellorgid(String sellorgid) {
		this.sellorgid = sellorgid;
	}

	public String getLoststatus() {
		return loststatus;
	}

	public void setLoststatus(String loststatus) {
		this.loststatus = loststatus;
	}
	
	
}
