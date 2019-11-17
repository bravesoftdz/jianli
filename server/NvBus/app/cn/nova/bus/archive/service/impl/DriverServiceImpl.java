package cn.nova.bus.archive.service.impl;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import oracle.sql.BLOB;
import play.db.jpa.JPA;
import util.CurrentUtil;
import util.DateUtils;

import org.hibernate.type.LobType;

import com.sun.jmx.snmp.Timestamp;

import cn.nova.bus.archive.dao.DriverDao;
import cn.nova.bus.archive.model.Driver;
import cn.nova.bus.archive.model.Driverfamilymember;
import cn.nova.bus.archive.model.Driverworkexperience;
import cn.nova.bus.archive.model.Steward;
import cn.nova.bus.archive.service.DriverService;
import cn.nova.bus.base.service.VehicleService;
import cn.nova.bus.base.service.impl.VehicleServiceImpl;
import cn.nova.bus.common.ParamterConst;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.dispatch.model.FingerCache;
import cn.nova.bus.dispatch.service.CreateQuanPinService;
import cn.nova.bus.dispatch.service.impl.CreateQuanPinServiceImpl;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;
import cn.nova.utils.orm.Page;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.IDAO;
import cn.nova.utils.orm.jpa.ListUtil;


public class DriverServiceImpl implements DriverService {
	public IDAO<Driver> dao = new EntityManagerDaoSurport<Driver>();
	public IDAO<Driverfamilymember> memberdao = new EntityManagerDaoSurport<Driverfamilymember>();
	public IDAO<Driverworkexperience> workdao = new EntityManagerDaoSurport<Driverworkexperience>();
	private DriverDao driverdao = new DriverDao();
	//private VehicleService vehicleservice = new VehicleServiceImpl();
	
	@Override
	public Driver saveDriver(Driver driver) throws ServiceException {		
		
		if(driver.getId()!=0){ 
			if( driverdao.isExistDriver(driver.getIdcard(), null,null,driver.getOrgid())!=0 &&driverdao.isExistDriver(driver.getIdcard(), null,null,driver.getOrgid())!= driver.getId()){
				throw new ServiceException("0113");	
			}
			if(driverdao.isExistDriver(null,driver.getCardno(), null,driver.getOrgid())!=0 && driverdao.isExistDriver(null, driver.getCardno(), null,driver.getOrgid())!= driver.getId()){
				throw new ServiceException("0114");	
			}
			if( driverdao.isExistDriver(null, null, driver.getCode(),driver.getOrgid())!=0&&driverdao.isExistDriver(null, null, driver.getCode(),driver.getOrgid())!= driver.getId()){			
				throw new ServiceException("0033");				
			}
			Driver n = dao.get(Driver.class, driver.getId());
			n.setArchiveno(driver.getArchiveno());
			n.setBirthday(driver.getBirthday());
			n.setCardno(driver.getCardno());
			n.setCode(driver.getCode());
			n.setDrivinglicense(driver.getDrivinglicense());
			n.setDrivinglicenseenddate(driver.getDrivinglicenseenddate());
			n.setDrivinglicensefirstdate(driver.getDrivinglicensefirstdate());
			n.setDrivinglicensestartdate(driver.getDrivinglicensestartdate());
			n.setEducation(driver.getEducation());
			n.setFamilyaddress(driver.getFamilyaddress());
			n.setFamilyphone(driver.getFamilyphone());
			n.setIdcard(driver.getIdcard());
			n.setInitialkm(driver.getInitialkm());
			n.setIssignedresponsibility(driver.getIssignedresponsibility());
			n.setJianpin(driver.getJianpin());
			n.setMobilephone(driver.getMobilephone());
			n.setName(driver.getName());
			n.setNativeplace(driver.getNativeplace());
			n.setPicture(driver.getPicture());
			n.setPoliticsstatus(driver.getPoliticsstatus());
			n.setQualification(driver.getQualification());
			n.setQualificationenddate(driver.getQualificationenddate());
			n.setQualificationstartdate(driver.getQualificationstartdate());
			n.setQualificationtype(driver.getQualificationtype());
			n.setQualifyvehicletype(driver.getQualifyvehicletype());
			n.setRecruitmentdate(driver.getRecruitmentdate());
			n.setRoute(driver.getRoute());
			n.setSalary(driver.getSalary());
			n.setSex(driver.getSex());
			n.setSubunit(driver.getSubunit());
			n.setUnitid(driver.getUnitid());
			n.setUpdateby(driver.getUpdateby());
			n.setUpdatetime(new Date());
			n.setVehicle(driver.getVehicle());
			n.setWorkenddate(driver.getWorkenddate());
			n.setWorkno(driver.getWorkno());
			n.setWorkstartdate(driver.getWorkstartdate());
			n.setWorkstatus(driver.getWorkstatus());
			n.setSincerityauditingdate(driver.getSincerityauditingdate());
			n.setContinuingeducationdate(driver.getContinuingeducationdate());
			n.setIstemporary(driver.getIstemporary());
			return dao.merge(n);
		}else{
			if(driverdao.isExistDriver(driver.getIdcard(), null,null,driver.getOrgid())!=0 ){
				throw new ServiceException("0113");
			}
			if(driverdao.isExistDriver(null, driver.getCardno(), null,driver.getOrgid())!=0){
				throw new ServiceException("0114");
			}
			if(driverdao.isExistDriver(null, null, driver.getCode(),driver.getOrgid())!=0){			
				throw new ServiceException("0033");				
			}
			//给驾驶员生成全拼
			driver.setQuanpin(CreateQuanPinServiceImpl.qryPingYin(driver.getName().trim().toUpperCase()));
			return dao.merge(driver);				
		}
	}

	@Override
	public Boolean delDriver(long driverid) throws ServiceException {
		if (driverdao.isExistVehicleDriver(driverid)) {
			throw new ServiceException("0017");
		}else{
			driverdao.update("Driverfamilymember", driverid,false);
			driverdao.update("Driverworkexperience", driverid,false);
			driverdao.update("Driverrewardpenalize", driverid,false);
			driverdao.update("Driver", driverid,false);
			return true;
		}
	}


	@Override
	public List<Map<String, Object>> queryDriver(
			List<PropertyFilter> propertyFilterList, String isfinger) {
		Object[] fileds = { "id", "code", "name", "cardno", "idcard", "sex",
				"birthday", "politicsstatus", "education", "nativeplace",
				"recruitmentdate", "istemporary", "archiveno", "workstatus",
				"unitid", "subunit", "vehicleid", "familyaddress",
				"familyphone", "mobilephone", "initialkm",
				"issignedresponsibility", "drivinglicense",
				"drivinglicensefirstdate", "drivinglicensestartdate",
				"drivinglicenseenddate", "qualification",
				"qualificationstartdate", "qualificationenddate",
				"qualificationtype", "workno", "workstartdate", "workenddate",
				"salary", "orgid", "isactive", "islocaldelete", "createtime",
				"createby", "updatetime", "updateby", "synccode",
				"qualifyvehicletype", "routeid", "jianpin", "unitname",
				"vehiclename", "createname", "updatename", "routename",
				"isfinger","sincerityauditingdate","continuingeducationdate","quanpin" };// 初始化要查询的字段
		Object[] filedtypes = { long.class, String.class, String.class,
				String.class, String.class, String.class, Date.class,
				String.class, String.class, String.class, Date.class,
				boolean.class, String.class, String.class, long.class,
				String.class, long.class, String.class, String.class,
				String.class, long.class, boolean.class, String.class,
				Date.class, Date.class, Date.class, String.class, Date.class,
				Date.class, String.class, String.class, Date.class, Date.class,
				BigDecimal.class, long.class, boolean.class, boolean.class,
				java.sql.Timestamp.class, long.class, Timestamp.class,
				long.class, String.class, String.class, long.class,
				String.class, String.class, String.class, String.class,
				String.class, String.class, Boolean.class, Date.class, Date.class, String.class };// 初始化要查询的字段 类型
		
		return ListUtil.listToMap(fileds, driverdao.queryDriver(propertyFilterList,isfinger),filedtypes);
	}
	
	@Override
	public Driverfamilymember saveDriverfamilymember(Driverfamilymember driverfamil) {
		return memberdao.merge(driverfamil);
	}

	@Override
	public Boolean delDriverfamilymember(long id) {
		return driverdao.update("Driverfamilymember", id,true);
	}

	@Override
	public List<Map<String, Object>> queryFamily(
			List<PropertyFilter> propertyFilterList) {
		Object[] fileds = { Driverfamilymember.class,"createname","updatename" };// 初始化要查询的字段
		Object[] filedtypes = { Driverfamilymember.class,String.class,String.class};// 初始化要查询的字段 类型
		return ListUtil.listToMap(fileds, driverdao.queryFamily(propertyFilterList),filedtypes);
		//return ListUtil.listToMap(new Object[]{Driverfamilymember.class}, driverdao.queryDriver(propertyFilterList));
	}

	@Override
	public Driverworkexperience saveDriverworkexperience(
			Driverworkexperience workexperience) {
			return workdao.merge(workexperience);
	}

	@Override
	public Boolean delDriverworkexperience(long id) {
		return driverdao.update("Driverworkexperience",id,true);
	}

	@Override
	public Boolean updDriverworkexperience(
			Driverworkexperience driverworkexperience) {
		return null;
	}

	@Override
	public List<Map<String, Object>> queryWork(
			List<PropertyFilter> propertyFilterList) {
		Object[] fileds = { Driverworkexperience.class,"createname","updatename" };// 初始化要查询的字段
		Object[] filedtypes = { Driverworkexperience.class,String.class,String.class};// 初始化要查询的字段 类型
		return ListUtil.listToMap(fileds, driverdao.queryWork(propertyFilterList),filedtypes);
	}


	public  List<Map<String, Object>> findPicturebyId(List<PropertyFilter> propertyFilterList){
		Object[] fileds = {"id","picture","workenddate","qualificationenddate","drivinglicenseenddate"};// 初始化要查询的字段
		Object[] filedtypes = {Long.class,String.class,String.class,String.class,String.class};// 初始化要查询的字段 类型
		return ListUtil.listToMap(fileds, driverdao.findPicturebyId(propertyFilterList),filedtypes);
		
	}
	
	@Override
	public Page<Driverworkexperience> findWorkPage(
			Page<Driverworkexperience> entrace, Map<Object, Object> map) {
		return null;
	}
	@Override
	public Page<Driverfamilymember> findFamliyPage(
			Page<Driverfamilymember> entrace, Map<Object, Object> map) {
		return null;
	}

	@Override
	public Driverfamilymember findFamliyByid(Long id) {
		return null;
	}

	@Override
	public Boolean delDriverFamily(Driverfamilymember driverfamily) {
		return null;
	}

	@Override
	public Driverworkexperience findWorkBid(Long id) {
		return null;
	}


	@Override
	public Page<Driver> findPage(Page<Driver> entrace, Map<Object, Object> map) {
		return null;
	}

	@Override
	public Driver findbyid(Long id) {
		return dao.get(Driver.class, id);
	}

	@Override
	public List<Map<String, Object>> queryDriverFinger() {
		Object[] fileds = { "id", "fingerstr","name" };// 初始化要查询的字段
		Object[] filedtypes = { Long.class, String.class, String.class };// 初始化要查询的字段 类型
		return ListUtil.listToMap(fileds,
				driverdao.queryDriverFinger(), filedtypes);
	}

	@Override
	public boolean saveDriverFinger(Driver driver) throws ServiceException {
		Driver dr=dao.get(Driver.class, driver.getId());
		if(dr.getFingerstr1()==null){
			dr.setFingerprint1(driver.getFingerprint1());
			dr.setFingerstr1(driver.getFingerstr1());
		}else if(dr.getFingerstr2()==null){
			dr.setFingerprint2(driver.getFingerprint1());
			dr.setFingerstr2(driver.getFingerstr1());
		}else{
			dr.setFingerprint3(driver.getFingerprint1());
			dr.setFingerstr3(driver.getFingerstr1());
		}
		dr.setUpdatetime(new Date());
		dao.merge(dr);	
		
		return true;
	}

	@Override
	public List<Map<String, Object>> queryVehicleByDriverid(long driverid) {
		Object[] fileds = { "vehicleid", "vehicleno","drivername"};// 初始化要查询的字段
		Object[] filedtypes = { Long.class, String.class,String.class};// 初始化要查询的字段 类型
		return ListUtil.listToMap(fileds,
				driverdao.queryVehicleByDriverid(driverid), filedtypes);
	}
	
	@Override
	public List<Map<String, Object>> queryDriverByDriverid(long driverid) {
		Object[] fileds = { "id", "name","vehicleid", "vehicleno",};// 初始化要查询的字段
		Object[] filedtypes = { Long.class, String.class,Long.class, String.class};// 初始化要查询的字段 类型
		return ListUtil.listToMap(fileds,
				driverdao.queryDriverByDriverid(driverid), filedtypes);
	}
	
	@Override
	public List<Map<String, Object>> queryVehiclenoByDriverid(long driverid) {
		Object[] fileds = { "id", "vehicleid"};// 初始化要查询的字段
		Object[] filedtypes = { Long.class, String.class};// 初始化要查询的字段 类型
		return ListUtil.listToMap(fileds,
				driverdao.queryVehiclenoByDriverid(driverid), filedtypes);
	}
	/**
	 * 获取驾驶员基础信息
	 */
	@Override
	public List<Driver> getDriverInfo() {
		
		/*Object[] fileds = { "code", "name", "cardno", "idcard", "sex", "birthday"
				, "politicsstatus", "education", "drivinglicense", "drivinglicensefirstdate", "drivinglicensestartdate"
				, "drivinglicenseenddate", "qualification", "qualificationstartdate", "qualificationenddate"
				, "qualificationtype", "picture"};// 初始化要查询的字段
		Object[] filedtypes = { String.class, String.class,String.class,String.class,String.class,Date.class,
				String.class,String.class,String.class,Date.class,Date.class,
				Date.class,String.class,Date.class,Date.class,
				String.class,Blob.class};// 初始化要查询的字段 类型
		return ListUtil.listToMap(fileds,
				driverdao.queryDriverInfo(), filedtypes);*/
		return dao.find(Driver.class);
	}

	@Override
	public List<Map<String, Object>> queryDriverAndStewardFinger() {
		Object[] fileds = { "id", "fingerstr","name","fingertype" };// 初始化要查询的字段
		Object[] filedtypes = { Long.class, String.class, String.class , String.class };// 初始化要查询的字段 类型
		return ListUtil.listToMap(fileds,
				driverdao.queryDriverAndStewardFinger(), filedtypes);
	}

	
	@Override
	public List<Map<String, Object>> queryDriverCardno(String drivinglicense){
		Object[] fileds = {"driverid", "id", "vehicleno","code" };// 初始化要查询的字段
		Object[] filedtypes = {Long.class, Long.class, String.class, String.class };// 初始化要查询的字段 类型
		return ListUtil.listToMap(fileds,
				driverdao.queryDriverCardno(drivinglicense), filedtypes);
	}

	@Override
	public List<Map<String, Object>> saveFingeCache(long driverid) {
		Global global = CurrentUtil.getGlobal();
		Driver driver = (Driver) driverdao.get(Driver.class, driverid);
		Steward steward = null;
		Date nowdate = DateUtils.trunc(new Date());
		Date d = new Date();
		List<Object> list = new ArrayList<Object>();
		Object[] obj = new Object[4];
		long vehicleid = 0;
		String returnmsg ="";
		if(driver==null){
			steward = (Steward) driverdao.get(Steward.class, driverid);
			vehicleid=steward.getVehicleid();
			if(vehicleid==0){
				obj[0]=0;
				obj[1]="";
				returnmsg="乘务员没有关联车辆信息！";
			}else{
				FingerCache fc =findFingeCache(vehicleid, driverid, nowdate, "2");
				if(fc==null){
					fc = new FingerCache();
					fc.setVehicleid(vehicleid);
					fc.setDriverorstewardid(driverid);
					fc.setDriverorstewardname(steward.getName());
					fc.setDriverorstewardmark("2");
					fc.setSavedate(nowdate);
					fc.setOrgid(global.getOrganization().getId());
					fc.setCreateby(global.getUserinfo().getId());
					fc.setUpdateby(global.getUserinfo().getId());
					fc.setCreatetime(d);
					fc.setUpdatetime(d);
					driverdao.merge(fc);
					JPA.em().flush();
				}
				obj[0]=vehicleid;
				obj[1]=steward.getVehicleno();
			}
		}else{
			if(driver.getVehicle()==null){
				obj[0]=0;
				obj[1]="";
				returnmsg="驾驶员没有关联车辆信息！";
			}else{
				vehicleid=driver.getVehicle().getId();
				FingerCache fc =findFingeCache(vehicleid, driverid, nowdate, "1");
				if(fc==null){
					fc = new FingerCache();
					fc.setVehicleid(vehicleid);
					fc.setDriverorstewardid(driverid);
					fc.setDriverorstewardname(driver.getName());
					fc.setDriverorstewardmark("1");
					fc.setSavedate(nowdate);
					fc.setOrgid(global.getOrganization().getId());
					fc.setCreateby(global.getUserinfo().getId());
					fc.setUpdateby(global.getUserinfo().getId());
					fc.setCreatetime(d);
					fc.setUpdatetime(d);
					driverdao.merge(fc);
					JPA.em().flush();
				}
				obj[0]=vehicleid;
				obj[1]=driver.getVehicle().getVehicleno();
			}
		}
		//判断司乘人员是否齐全
		if(returnmsg==null||"".equals(returnmsg)){
			//int drivernum = driverdao.findDriversnum(vehicleid, global.getOrganization().getId());
			//判断驾驶员是否满足
			boolean res=false;
			int drivernum =driverdao.findDrivers(vehicleid);
			play.Logger.info("drivernum="+drivernum);
			if(drivernum == 0 ){ //未查询到二维码信息
				obj[0]=0;
				obj[1]="";
				res=false;
				returnmsg="该车辆还未设置对应的驾驶员信息！";
			}else{
				List<Object> fclist = driverdao.findFingeCachecount(vehicleid, nowdate,"1");
				play.Logger.info("fclist.size()="+fclist.size());
				if(drivernum>fclist.size()){
					res=false;
				}else{
					res=true;
				}
			}	
			//查询乘务员是否满足
			int stewnum =driverdao.findStewards(vehicleid);
			play.Logger.info("stewnum="+stewnum);
			if(stewnum == 0 ){
				obj[0]=0;
				obj[1]="";
				res=false;
				returnmsg="该车辆还未设置对应的乘务员信息！";
			}else{
				List<Object> fclist = driverdao.findFingeCachecount(vehicleid, nowdate,"2");
				play.Logger.info("fclist.size()="+fclist.size());
				if(stewnum>fclist.size()){
					res=false;
				}else{
					if(res){
						res=true;
					}else{
						res=false;
					}
				}
			}
			obj[2]=res;
		}else{
			obj[2]=false;
		}
		obj[3]=returnmsg;
		list.add(obj);
		Object[] fileds = {"vehicleid", "vehicleno", "dispachflag","returnmsg" };// 初始化要查询的字段 其中dispachflag为报班标记，是否弹出报班界面（司乘人员是否齐全）
		Object[] filedtypes ={Long.class, String.class, boolean.class, String.class };// 初始化要查询的字段 类型
		return ListUtil.listToMap(fileds,
				list, filedtypes);
	}

	public FingerCache findFingeCache(long vehicleid, long driverorstewardid, Date savedate, String mark) {
		return driverdao.findFingeCache(vehicleid,driverorstewardid,savedate, mark);
	}

	@Override
	public List<Map<String, Object>> findFingecache(long vehicleid, Date savedate) {
		List<Object> fclist = driverdao.findFingeCachecount(vehicleid, savedate);
		return ListUtil.listToMap(new Object[]{FingerCache.class},fclist);
	}

}
