package cn.nova.bus.price.service.impl;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.script.ScriptEngine;
import javax.script.ScriptEngineManager;

import org.joda.time.DateTime;
import org.joda.time.DateTimeUtils;
import cn.nova.bus.price.dao.StandardBasePriceDao;
import cn.nova.bus.base.model.Route;
import cn.nova.bus.base.model.Station;
import cn.nova.bus.common.ParamterConst;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.log.model.Operationlog;
import cn.nova.bus.log.service.OperationLogService;
import cn.nova.bus.log.service.impl.OperationLogServiceImpl;
import cn.nova.bus.price.dao.GenScheduleplanServiceDao;
import cn.nova.bus.price.dao.RoutePriceDao;
import cn.nova.bus.price.model.Routeprice;
import cn.nova.bus.price.model.StandardBasePrice;
import cn.nova.bus.price.model.Ticketoutletstypeprice;
import cn.nova.bus.price.model.Ticketprice;
import cn.nova.bus.price.service.RoutepriceService;
import cn.nova.bus.security.Global;
import cn.nova.bus.system.service.ParameterService;
import cn.nova.bus.system.service.impl.ParameterServiceImpl;
import cn.nova.utils.commons.DateUtils;
import cn.nova.utils.commons.MethodResult;
import cn.nova.utils.commons.StringUtils;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;
import util.CurrentUtil;

public class RoutepriceServiceImpl implements RoutepriceService {
	private RoutePriceDao routePriceDao = new RoutePriceDao();
	
	private GenScheduleplanServiceDao genScheduleplanServiceDao=new GenScheduleplanServiceDao();
	private StandardBasePriceDao standardBasePriceDao = new StandardBasePriceDao();
	private OperationLogService operationLogService = new OperationLogServiceImpl();
	private ParameterService parameterService = new ParameterServiceImpl();
	@Override
	public List<Map<String, Object>> qryRouteprice(long routeid)
			throws ServiceException {
		
		// TODO Auto-generated method stub
		List<Object> list = routePriceDao.qryRoutePrices(routeid);
	
		return ListUtil.listToMap(new Object[] { "id", "price", "balanceprice", "fromdate", "todate", "createtime",
				"createby", "updatetime", "updateby", "routeid", "fromstationid", "reachstationid", "orgid", 
				"isbaseprice", "fromstationname", "reachstationname","isselect"},
				list, new Object[] {Long.class, BigDecimal.class, BigDecimal.class, Date.class, Date.class, Date.class,
				Long.class, Date.class, Long.class, Long.class, Long.class, Long.class, Long.class, 
				boolean.class, String.class, String.class, boolean.class});
	}
	@Override
	public List<Map<String, Object>> qryRoutepriceedt(long routeid)
			throws ServiceException {
		
		// TODO Auto-generated method stub
		List<Object> list = routePriceDao.qryRoutePrices(routeid);
		if(list == null || list.size() == 0){
			list = routePriceDao.qryAndMakeRoutePrices(routeid);
		}
		
		return ListUtil.listToMap(new Object[] { "id", "price", "balanceprice", "fromdate", "todate", "createtime",
				"createby", "updatetime", "updateby", "routeid", "fromstationid", "reachstationid", "orgid", 
				"isbaseprice", "fromstationname", "reachstationname","isselect"},
				list, new Object[] {Long.class, BigDecimal.class, BigDecimal.class, Date.class, Date.class, Date.class,
				Long.class, Date.class, Long.class, Long.class, Long.class, Long.class, Long.class, 
				boolean.class, String.class, String.class, boolean.class});
	}
	@Override
	public List<Map<String, Object>> save(List<Routeprice> routepricelist,
			Global global) throws ServiceException {
		// TODO Auto-generated method stub
		Date now = new Date();
		long userid = global.getUserinfo().getId();
		long routeid =0;
		List<Object> saveobj = new ArrayList<Object>();
		String log="";
		for (Routeprice routeprice : routepricelist) {
			if(routeprice.getId() == 0){
				routeprice.setCreatetime(now);
				routeprice.setCreateby(userid);
			}
			if(routeprice.getBalanceprice().compareTo(routeprice.getPrice())==0){
				routeprice.setBalanceprice(routeprice.getPrice());
			}
			Station st=(Station) routePriceDao.get(Station.class, routeprice.getReachstationid());
			log=log+"日期"+StringUtils.dateToStr(routeprice.getFromdate())+
			"至"+StringUtils.dateToStr(routeprice.getTodate())+","+
			st.getName()+"="+routeprice.getPrice()+",";
			routeid=routeprice.getRouteid();
			routeprice.setUpdatetime(now);
			routeprice.setUpdateby(userid);
			routePriceDao.merge(routeprice);
			saveobj.add(saveobj);
		}
		updateticketprice(routeid,routepricelist,global,log);
		
		return ListUtil.listToMap(new Object[] { "id", "price", "balanceprice", "fromdate", "todate", "createtime",
				"createby", "updatetime", "updateby", "routeid", "fromstationid", "reachstationid", "orgid", 
				"isbaseprice"},
				saveobj, new Object[] {Long.class, BigDecimal.class, BigDecimal.class, Date.class, Date.class, Date.class,
				Long.class, Date.class, Long.class, Long.class, Long.class, Long.class, Long.class, 
				boolean.class});
	}

	private boolean updateticketprice(long routeid,List<Routeprice> routepricelist, Global global,String log){
		Date now = new Date();
		//更新班次计划表中的票价
		SimpleDateFormat sf=new SimpleDateFormat("yyyy-MM-dd");
		Date departdate=now;
		Date maxdepartdate=now;
		Date curdepartdate=now;
		Route route=(Route) routePriceDao.get(Route.class, routeid);
		try {
			curdepartdate = sf.parse(sf.format(now));
			maxdepartdate=routePriceDao.qryMaxTicketpricedepart(routeid,curdepartdate);
			if(maxdepartdate==null){
				return true;
			}
			String rate=parameterService.findParamValue(ParamterConst.Param_0017, route.getOrgid());
			String pricerule = parameterService.findParamValue(ParamterConst.Param_1042,
					route.getOrgid());				
			int days = DateUtils.getIntervalDays(maxdepartdate,curdepartdate) + 1;
			for (int i = 0; i <= days; i++) {
				departdate = DateUtils.add(curdepartdate, i);
				List<Ticketprice> tplist = routePriceDao.qryTicketprice(
						routeid, departdate);
				List<Routeprice> rplist = genScheduleplanServiceDao
						.qryRouteprice(routeid, departdate);
				if (rplist == null) {
					rplist = routepricelist;
				}
				for (Ticketprice tp : tplist) {
					//boolean isexist=false;
					for (Routeprice rp : rplist) {
						if (tp.getDepartstationid() == rp.getFromstationid()
								&& tp.getReachstationid() == rp
										.getReachstationid()) {
							tp.setFullprice(rp.getPrice());
							tp.setStudentprice(rp.getPrice());
							tp.setHalfprice(rp.getPrice().multiply(new BigDecimal(rate)));
							// 1四舍五入、2舍去、3入、4小于5角进到5角，高于5角进到1元
							//将计算方法封装，所有使用1042参数计算的都统一调用
							BigDecimal halfprice = mathPriceByRule(pricerule, tp.getHalfprice());
							tp.setHalfprice(halfprice);
							tp.setUpdatetime(now);
							routePriceDao.merge(tp);
						//	isexist=true;
							break;
						}
					}
					/*
					if(!isexist){
						tp.setIssellable(false);
						tp.setUpdatetime(now);
						routePriceDao.merge(tp);
					}*/
				}

			}

		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		// 保存操作日志
		String ip=global.getIpAddress();
		Operationlog operationLog = new Operationlog();
		operationLog.setIp(ip);
		String content = "更新了日期：" + StringUtils.dateToStr(curdepartdate) + "至"
				+ StringUtils.dateToStr(maxdepartdate)+"的票价";
		content = content + "，营运线路："
				+ route.getName()+",票价修改信息："+log;
		
		operationLog.setContent(content);
		operationLog.setModule("线路票价");
		operationLog.setOperatetime(new Date());
		operationLog.setOperation("设置线路票价");
		operationLog.setSessionid(global.getSessionID());
		operationLog.setUserid(global.getUserinfo().getId());
		operationLogService.savelog(operationLog);
		return true;
	}
	
	@Override
	public boolean delRouteprice(String ids)
			throws ServiceException {
		String[] split = ids.split(",");
		if(split.length != 0){
			routePriceDao.delRouteprice(ids);
		}
		return true;
	}

	@Override
	public Long add(Routeprice routeprice,
			Global global) throws ServiceException {
		Long returnId = 0L;
		Date now = new Date();
		long id = global.getUserinfo().getId();		
		if(routePriceDao.isExistRoutePrice(routeprice.getRouteid(), routeprice.getFromstationid(),
				routeprice.getReachstationid(),routeprice.getIsbaseprice())){
			throw new ServiceException("0009");
		}
		List<Routeprice> r = routePriceDao.qryOtherRoutePrices(routeprice.getRouteid(),routeprice.getFromdate(),routeprice.getTodate(),routeprice.getReachstationid());
		if (r.size()!=0) {
			throw new ServiceException("0431");
			}
		String log="";
		if (routeprice.getIsbaseprice()) {
			SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
			Date fromdate = new Date();
			Date todate = new Date();
			try {
				fromdate = sf.parse("2014-12-21");
				todate = sf.parse("9999-12-12");
			} catch (ParseException e) {
				play.Logger.error(e.getMessage(), e);
			}
			routeprice.setFromdate(fromdate);
			routeprice.setTodate(todate);
			routeprice.setCreatetime(now);
			routeprice.setCreateby(id);
			routeprice.setUpdatetime(now);
			routeprice.setUpdateby(id);
			Station st=(Station) routePriceDao.get(Station.class, routeprice.getReachstationid());
			log=log+"日期"+StringUtils.dateToStr(routeprice.getFromdate())+
			"至"+StringUtils.dateToStr(routeprice.getTodate())+","+
			st.getName()+"="+routeprice.getPrice()+",";
			routeprice.setIsbaseprice(true);
			//routeprice.setFromdate(routeprice.getFromdate());
			//routeprice.setTodate(routeprice.getTodate());
			routePriceDao.save(routeprice);
		}else{
			if(routePriceDao.isExistRoutePrice(routeprice.getRouteid(), routeprice.getFromstationid(),
					routeprice.getReachstationid(), routeprice.getFromdate(), routeprice.getTodate(),routeprice.getIsbaseprice())){
				throw new ServiceException("0469");
			}
			if(routeprice.getPrice()!=null){
			routeprice.setCreatetime(now);
			routeprice.setCreateby(id);
			routeprice.setUpdatetime(now);
			routeprice.setUpdateby(id);
			Station st=(Station) routePriceDao.get(Station.class, routeprice.getReachstationid());
			log=log+"日期"+StringUtils.dateToStr(routeprice.getFromdate())+
			"至"+StringUtils.dateToStr(routeprice.getTodate())+","+
			st.getName()+"="+routeprice.getPrice()+",";

			routePriceDao.save(routeprice);
			}else{
			List<Routeprice> baseRoutePrices = routePriceDao.getBaseRoutePrice(routeprice.getRouteid());
			for(Routeprice rp:baseRoutePrices){
				Routeprice nrp=new Routeprice();
				nrp.setCreatetime(now);
				nrp.setCreateby(id);
				nrp.setUpdatetime(now);
				nrp.setUpdateby(id);				
				nrp.setIsbaseprice(false);
				nrp.setBalanceprice(rp.getBalanceprice());
				nrp.setPrice(rp.getPrice());
				nrp.setFromstationid(rp.getFromstationid());
				nrp.setReachstationid(rp.getReachstationid());
				nrp.setRouteid(rp.getRouteid());
				nrp.setFromdate(routeprice.getFromdate());
				nrp.setTodate(routeprice.getTodate());
				Station st=(Station) routePriceDao.get(Station.class, nrp.getReachstationid());
				log=log+"日期"+StringUtils.dateToStr(nrp.getFromdate())+
				"至"+StringUtils.dateToStr(nrp.getTodate())+","+
				st.getName()+"="+nrp.getPrice()+",";
				routePriceDao.save(nrp);
			}
		}
		}
		ArrayList<Routeprice> rplist=new ArrayList<Routeprice>();
		rplist.add(routeprice);
		updateticketprice(routeprice.getRouteid(),rplist,global,log);
		returnId = routeprice.getId();
		/*
		List<Routeprice> baseRoutePrices = routePriceDao.getBaseRoutePrice(routeprice.getRouteid(),routeprice.getReachstationid());

		if(baseRoutePrices.size() != 0){	
			if(routeprice.getFromdate().after(routeprice.getTodate())){
				throw new ServiceException("0468");
			}			
			for (Routeprice rp : baseRoutePrices) {
//				因为基本票价默认时间是9999-12-30，所以不会出现该可以
//				if(rp.getFromdate().after(routeprice.getFromdate()) && rp.getTodate().before(routeprice.getTodate())){
//				
//				}
				if(routePriceDao.isExistRoutePrice(rp.getRouteid(), rp.getFromstationid(), rp.getReachstationid(), routeprice.getFromdate(), routeprice.getTodate())){
					throw new ServiceException("0469");
				}
				
				Routeprice rpnew = new Routeprice();
				
				rpnew.setPrice(rp.getPrice());
				rpnew.setBalanceprice(rp.getBalanceprice());
				rpnew.setRouteid(rp.getRouteid());
				rpnew.setFromstationid(rp.getFromstationid());
				rpnew.setReachstationid(rp.getReachstationid());
				rpnew.setOrgid(rp.getOrgid());

				rpnew.setCreatetime(now);
				rpnew.setCreateby(id);
				rpnew.setUpdatetime(now);
				rpnew.setUpdateby(id);
				
				rpnew.setIsbaseprice(0);
				rpnew.setFromdate(routeprice.getFromdate());
				rpnew.setTodate(routeprice.getTodate());
				
				routePriceDao.merge(rpnew);
				returnId = rpnew.getId();
			}
		}else{
			if(routePriceDao.isExistRoutePrice(routeprice.getRouteid(), routeprice.getFromstationid(), routeprice.getReachstationid())){
				throw new ServiceException("0469");
			}
			
			SimpleDateFormat sf=new SimpleDateFormat("yyyy-MM-dd");
			Date fromdate=new Date();
			Date todate=new Date();		
			try {
				fromdate=sf.parse(sf.format(new Date()));
				todate=sf.parse("9999-12-12");			
			} catch (ParseException e) {
				play.Logger.error(e.getMessage(), e);
			}
			routeprice.setFromdate(fromdate);
			routeprice.setTodate(todate);
			routeprice.setCreatetime(now);
			routeprice.setCreateby(id);
			routeprice.setUpdatetime(now);
			routeprice.setUpdateby(id);
			
			routeprice.setIsbaseprice(1);
			routeprice.setFromdate(routeprice.getFromdate());
			routeprice.setTodate(routeprice.getTodate());
			
			routePriceDao.save(routeprice);
			returnId = routeprice.getId();
		}*/
		return returnId;
		
	}
	@Override
	public List<Map<String, Object>> qryRoutestops(long routeid,boolean isdepart)
	{
		return ListUtil.listToMap(new Object[] { "id", "name", "code"},
				routePriceDao.qryRoutestop(routeid, isdepart)
				, new Object[] {Long.class,String.class,String.class});
		
	}
	
	public List<Map<String, Object>> qryRoutepriceOrHardprice(long routeid,
			long scheduleid,Global global,String departdate) throws ServiceException {
//		long bd = routePriceDao.isexitprice(routeid);
		List<Object> result = new ArrayList<Object>();
		
		/*boolean isRouteprice=(ParamterConst.COMMON_FLAG.FALG_NO).equals(parameterService.findParamValue(ParamterConst.Param_0021, global.getOrganization().getId()));
		if (isRouteprice) {
			result = routePriceDao.queryRouteprice(routeid);
		} else {
			result = routePriceDao.queryHardprice(scheduleid,departdate);
		}*/
		//结算单补录票价优先级  执行票价>线路票价>硬调票价
		if(result.size()==0 && scheduleid>0){
			result = routePriceDao.queryTicketprice(scheduleid,departdate);
		}
		if (result.size()==0 && routeid>0) {
			result = routePriceDao.queryRouteprice(routeid);
		}
		if(result.size()==0 && scheduleid>0){
			result = routePriceDao.queryHardprice(scheduleid,departdate);
		}
		return ListUtil.listToMap(new Object[] { "fromstationname",
				"reachstationname", "price", "balanceprice","fromstationid", "reachstationid","stationfee","halfprice" }, result,
				new Object[] { String.class, String.class, BigDecimal.class,
						BigDecimal.class,long.class,long.class,BigDecimal.class,BigDecimal.class});
	}
	
	
	public List<Map<String, Object>> saveall(List<Routeprice> routepricelist,boolean savestandprice,
			Global global)  {
		// TODO Auto-generated method stub
		Date now = new Date();
		long userid = global.getUserinfo().getId();
		long routeid =0;
		List<Object> saveobj = new ArrayList<Object>();
		String log="";
		for (Routeprice routeprice : routepricelist) {
			if(routeprice.getId() == 0){
				routeprice.setCreatetime(now);
				routeprice.setCreateby(userid);
			}
			if(routeprice.getBalanceprice().compareTo(routeprice.getPrice())==0){
				routeprice.setBalanceprice(routeprice.getPrice());
			}
			Station st=(Station) routePriceDao.get(Station.class, routeprice.getReachstationid());
			log=log+"日期"+StringUtils.dateToStr(routeprice.getFromdate())+
			"至"+StringUtils.dateToStr(routeprice.getTodate())+","+
			st.getName()+"="+routeprice.getPrice()+",";
			routeid=routeprice.getRouteid();
			routeprice.setUpdatetime(now);
			routeprice.setUpdateby(userid);
			routePriceDao.merge(routeprice);
			saveobj.add(saveobj);
			if(savestandprice && routeprice.getIsbaseprice()){
				StandardBasePrice sb = standardBasePriceDao.getStandardBasePrice(routeprice);
				if (sb == null) {
					sb = new StandardBasePrice();
					sb.setBaseprice(routeprice.getPrice());
					sb.setOrgid(routeprice.getOrgid());
					sb.setFromstationid(routeprice.getFromstationid());
					sb.setReachstationid(routeprice.getReachstationid());
					sb.setRouteid(routeprice.getRouteid());
					standardBasePriceDao.save(sb);
				} else {
					sb.setBaseprice(routeprice.getPrice());
					standardBasePriceDao.merge(sb);
				}
			}
		}
		updateticketprice(routeid,routepricelist,global,log);
		
		return ListUtil.listToMap(new Object[] { "id", "price", "balanceprice", "fromdate", "todate", "createtime",
				"createby", "updatetime", "updateby", "routeid", "fromstationid", "reachstationid", "orgid", 
				"isbaseprice"},
				saveobj, new Object[] {Long.class, BigDecimal.class, BigDecimal.class, Date.class, Date.class, Date.class,
				Long.class, Date.class, Long.class, Long.class, Long.class, Long.class, Long.class, 
				boolean.class});
	}
	
	@Override
	public BigDecimal mathPriceByRule(String pricerule,BigDecimal price){
		// 1:四舍五入，2:舍去，3:入，4:小于等于5角进到5角、大于5角进到1元，5:小于五角舍去、等于五角保留为五角、大于五角进到1元，默认为1
		if(price.compareTo(new BigDecimal(0))<0){
			price=new BigDecimal(0);
		}
		if ("1".equals(pricerule)) {
			price = price.divide(new BigDecimal(1), 0,
					BigDecimal.ROUND_HALF_UP);

		} else if ("2".equals(pricerule)) {
			price = price.divide(new BigDecimal(1), 0,
					BigDecimal.ROUND_DOWN);

		} else if ("3".equals(pricerule)) {
			price = price.divide(new BigDecimal(1), 0,
					BigDecimal.ROUND_UP);

		} else if ("4".equals(pricerule))  {
			if (price.subtract(price.divide(new BigDecimal(1), 0,
							BigDecimal.ROUND_DOWN)).compareTo(
					new BigDecimal(0)) > 0) {
				if (price.subtract(price.divide(new BigDecimal(1), 0,
								BigDecimal.ROUND_DOWN)).compareTo(
						new BigDecimal(0.5)) > 0) {
					price= price.divide(new BigDecimal(1), 0,
							BigDecimal.ROUND_UP);
				} else {
					price = price.divide(new BigDecimal(1), 0,
							BigDecimal.ROUND_DOWN).add(
							new BigDecimal(0.5));
				}
			}
		}else{
			if (price.subtract(price.divide(new BigDecimal(1), 0,
					BigDecimal.ROUND_DOWN)).compareTo(
						new BigDecimal(0)) > 0) {
				if (price.subtract(price.divide(new BigDecimal(1), 0,
								BigDecimal.ROUND_DOWN)).compareTo(
						new BigDecimal(0.5)) > 0) {		//大于五角进到1元
					price= price.divide(new BigDecimal(1), 0,
							BigDecimal.ROUND_UP);
				} else if (price.subtract(price.divide(new BigDecimal(1), 0,
						BigDecimal.ROUND_DOWN)).compareTo(
						new BigDecimal(0.5)) < 0)  { //小于五角舍去
					price = price.divide(new BigDecimal(1), 0,
							BigDecimal.ROUND_DOWN);
				}
			}
		}
		return price;
	}
	
	@Override
	public List<Map<String, Object>> qryTicketoutletstypeprice(List<PropertyFilter> buildFromHttpRequest) {
		return ListUtil
				.listToMap(
						new Object[] { "id", "orgname", "ticketoutletname", "routename", "schedulecode",
								"fullpriceformula", "halfpriceformula", "studentpriceformula", "startdate", "enddate",
								"createby", "createtime", "updateby", "updatetime" },
						routePriceDao.qryTicketoutletstypeprice(buildFromHttpRequest),
						new Object[] { long.class, String.class, String.class, String.class, String.class, String.class,
								String.class, String.class, Date.class, Date.class, String.class, Timestamp.class,
								String.class, Timestamp.class });
	}
	
	@Override
	public MethodResult saveTicketoutletstypeprice(Ticketoutletstypeprice ttp, String ticketoutletsids,
			String scheduleids) {
		Global global = CurrentUtil.getGlobal();
		MethodResult result = new MethodResult();
		MethodResult fullprice_result = tryExecuteFormual(ttp.getFullpriceformula());
		if(fullprice_result.getResult()==0) {
			return fullprice_result;
		}
		MethodResult halfprice_result = tryExecuteFormual(ttp.getHalfpriceformula());
		if(halfprice_result.getResult()==0) {
			return halfprice_result;
		}
		MethodResult studentprice_result = tryExecuteFormual(ttp.getStudentpriceformula());
		if(studentprice_result.getResult()==0) {
			return studentprice_result;
		}
		//新增
		if(ttp.getId()<=0) {
			String[] ticketoutletslist = ticketoutletsids.substring(1,ticketoutletsids.length()-1).split(",");
			String[] schedulelist = scheduleids.split(",");
			result.setResult(1);
			for (String ticketoutletsid : ticketoutletslist) {
				for (String scheduleid : schedulelist) {
					Ticketoutletstypeprice t = new Ticketoutletstypeprice(global.getUserinfo().getId(),new Date());
					t.setTicketoutletsid(Long.parseLong(ticketoutletsid));
					t.setRouteid(ttp.getRouteid());
					t.setStartdate(ttp.getStartdate());
					t.setEnddate(ttp.getEnddate());
					t.setFullpriceformula(ttp.getFullpriceformula());
					t.setHalfpriceformula(ttp.getHalfpriceformula());
					t.setStudentpriceformula(ttp.getStudentpriceformula());
					t.setScheduleid(Long.parseLong(scheduleid));
					if(routePriceDao.checkisexists(t)) {
						result.setResult(0);
						result.setResultMsg("日期不允许交叉!");
						return result;
					}
					routePriceDao.merge(t);
				}
			}
		//修改
		}else {
			Ticketoutletstypeprice t = (Ticketoutletstypeprice) routePriceDao.get(Ticketoutletstypeprice.class, ttp.getId());
			t.setFullpriceformula(ttp.getFullpriceformula());
			t.setHalfpriceformula(ttp.getHalfpriceformula());
			t.setStudentpriceformula(ttp.getStudentpriceformula());
			t.setUpdateby(global.getUserinfo().getId());
			t.setUpdatetime(new Date());
			if(routePriceDao.checkisexists(t)) {
				result.setResult(0);
				result.setResultMsg("日期不允许交叉!");
				return result;
			}
			routePriceDao.merge(t);
			result.setResult(1);
		}
		return result;
	}
	
	@Override
	public boolean deleteTicketoutletstypeprice(String id) {
		String[] split = id.split(",");
		for (String realid : split) {
			routePriceDao.delete(Ticketoutletstypeprice.class, Long.parseLong(realid));
		}
		return true;
	}
	
	public MethodResult tryExecuteFormual(String formual) {
		ScriptEngineManager manager = new ScriptEngineManager();
		final ScriptEngine engine = manager.getEngineByName("js");
		MethodResult result = new MethodResult();
        if (engine == null) {
            play.Logger.info("No engine for JavaScript"); 
            result.setResultMsg("No engine for JavaScript");
            result.setResult(0);
            return result;
        }
        if(formual.indexOf("Q")<0) {
        	 result.setResultMsg("公式设置有误,请检查!");
             result.setResult(0);
             return result;
        }
        String formual_temp = formual.replaceAll("Q", "10");
        try {
            Object formual_result = engine.eval(formual_temp);
        	result.setResultMsg("计算成功");
        	result.setResult(1);
        	result.setObject(formual_result);
        } catch (Exception e) {
        	result.setResultMsg(e.getMessage());
            result.setResult(0);
            e.printStackTrace();
        }
		return result;
	}
	
}
