package cn.nova.bus.archive.action;

import cn.nova.bus.action.BaseAction;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.persistence.Transient;

import util.CurrentUtil;
import cn.nova.bus.archive.model.Driver;
import cn.nova.bus.archive.model.Driverfamilymember;
import cn.nova.bus.archive.model.Driverworkexperience;
import cn.nova.bus.archive.service.DriverService;
import cn.nova.bus.archive.service.impl.DriverServiceImpl;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;
import cn.nova.utils.encode.ConversionUtil;
import cn.nova.utils.web.ServletPropertyFilterUtil;

public class DriverAction extends BaseAction{
	DriverService driverService;
	
	private Driver driver;
	private  Driverfamilymember familyer;
	private Driverworkexperience workexperience;
	private String pictures;
	private String isfinger;
	//返回结果
	private List<Map<String,Object>>  drivermap;
	private List<Map<String,Object>>  workmap;
	private List<Map<String,Object>>  familymap;
	private List<Map<String,Object>> pictureResult;
	private List<Map<String,Object>>  vehiclemap;
	private List<Map<String,Object>>  fingermap;
	
	private String drivinglicense;

	private long driverid;  //查询子表及添加修改线路结果回传
	private long driverfamilyid;
	private long deiverworkid;
	//参数
	private Long delid;
	private long vehicleid;
	private Date departdate;
	//保存指纹
	public String saveDriverFinger() {
		driverService = new DriverServiceImpl();
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				byte[] bb = ConversionUtil.toByteArr(pictures);
				driver.setFingerprint1(bb);
				driverService.saveDriverFinger(driver);
				msg = "添加成功！";
				markSuccess();  //成功
			}
		} catch (ServiceException se) {
			setMsg(se.getMessage());
			markFail();  //
		} catch (Exception ex) {
			ex.printStackTrace();
			msg = "操作失败！";
			markSuccess();  //成功
		}
		return "json";

	}
	//查询指纹
	public String queryDriverFinger(){
		driverService = new DriverServiceImpl();
		try{
			pictureResult=(driverService.queryDriverFinger());			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "json";
	}
	
	//查询指纹
		public String queryDriverAndStewardFinger(){
			driverService = new DriverServiceImpl();
			try{
				pictureResult=(driverService.queryDriverAndStewardFinger());			
			} catch (Exception e) {
				e.printStackTrace();
			}
			return "json";
		}
	
	public String saveDriver(){
		driverService = new DriverServiceImpl();
		String show ="";
		Driver d =null;
		Global global = CurrentUtil.getGlobal();
		byte[] pc=ConversionUtil.toByteArr(pictures);
		driver.setPicture(pc);	
		driver.setIsactive(true);
		try {
			if(driver.getId()!=0){
				driver.setUpdatetime(new Timestamp(System.currentTimeMillis()));
				driver.setUpdateby(global.getUserinfo().getId());
				show="修改驾驶员档案";
			}else{
				driver.setCreateby(global.getUserinfo().getId());
				driver.setCreatetime(new Timestamp(System.currentTimeMillis()));	
				driver.setUpdatetime(new Timestamp(System.currentTimeMillis()));
				driver.setUpdateby(global.getUserinfo().getId());
				show="添加驾驶员档案";
			}
			d = driverService.saveDriver(driver);
			if(d!=null){
				driverid = d.getId();
				setMsg(show+"成功");
				markSuccess();
			}
			else{
				setMsg(show+"失败");
				markFailure();
			}
		} catch (ServiceException e) {
			setMsg(show+"失败:" +e.getExceptionMessage());
			markFail();
		}
		return "json";
	}
	
	public String saveFamily(){
		driverService = new DriverServiceImpl();
		String show ="";
		Driverfamilymember df =null;
		try{
			Global global = CurrentUtil.getGlobal();
		familyer.setIsactive(true);
		if(familyer.getId()!=0){	
			familyer.setUpdateby(global.getUserinfo().getId());			
			familyer.setUpdatetime(new Timestamp(System.currentTimeMillis()));
			show = "修改";
		}else{
			familyer.setIsactive(true);
			familyer.setCreateby(global.getUserinfo().getId());
			familyer.setCreatetime(new Timestamp(System.currentTimeMillis()));	
			familyer.setUpdatetime(new Timestamp(System.currentTimeMillis()));
			familyer.setUpdateby(global.getUserinfo().getId());
			show = "添加";
		}
		df = driverService.saveDriverfamilymember(familyer);
		if(df!=null){
			driverfamilyid = df.getId();
			this.setMsg(show+"成功");
			markSuccess();
		}else{
			this.setMsg(show+"失败");
			markFail();
		}
		}catch(Exception ex){
			this.setMsg(show+"失败:"+ex);
			markFail();
		}
		return "json";
	}
	
	public String saveWorkexperience(){
		driverService = new DriverServiceImpl();
		Driverworkexperience dw = null;
		String msg="";
		try{
			Global global = CurrentUtil.getGlobal();
		workexperience.setIsactive(true);
		workexperience.setIslocaldelete(false);
		if(workexperience.getId()!=0){	
			workexperience.setUpdatetime(new Timestamp(System.currentTimeMillis()));
			workexperience.setUpdateby(global.getUserinfo().getId());
			msg ="修改";
		}else{
			workexperience.setCreateby(global.getUserinfo().getId());
			workexperience.setCreatetime(new Timestamp(System.currentTimeMillis()));	
			workexperience.setUpdatetime(new Timestamp(System.currentTimeMillis()));
			workexperience.setUpdateby(global.getUserinfo().getId());
			msg="添加";
		}
		dw = driverService.saveDriverworkexperience(workexperience);
		if(dw != null){
			deiverworkid = dw.getId();
			setMsg(msg+"成功");
			markSuccess();
		}else{
			this.setMsg(msg+"失败");
			markFail();
		}
		}catch(Exception ex){
			setMsg(msg+"失败:"+ex);
			markFail();
		}
		return "json";
	}
	
	public String findDriver(){
		try{
			driverService = new DriverServiceImpl();
		 setDrivermap(driverService.queryDriver(ServletPropertyFilterUtil.buildFromHttpRequest(),isfinger));			
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	
	public String findFinggecache(){
		try{
			driverService = new DriverServiceImpl();
			setFingermap(driverService.findFingecache(vehicleid,departdate));			
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	public String saveFinggeCache(){
		try{
			driverService = new DriverServiceImpl();
		 setVehiclemap(driverService.saveFingeCache(driverid));			
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	public String findVehicleByDriverid(){
		try{
			driverService = new DriverServiceImpl();
		 setVehiclemap(driverService.queryVehicleByDriverid(driverid));			
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	//通过driverid查询driver
	public String findDriverByDriverid(){
		try{
			driverService = new DriverServiceImpl();
			setDrivermap(driverService.queryDriverByDriverid(driverid));			
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	//通过driverid查询d对应车牌
	public String findVehicleidByDriverid(){
		try{
			driverService = new DriverServiceImpl();
			setVehiclemap(driverService.queryVehiclenoByDriverid(driverid));			
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	public String finddriverPicture(){
		try{
			driverService = new DriverServiceImpl();
			setPictureResult(driverService.findPicturebyId(ServletPropertyFilterUtil.buildFromHttpRequest()));			
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	public String findFamily(){
		try{
			driverService = new DriverServiceImpl();
			setFamilymap(driverService.queryFamily(ServletPropertyFilterUtil.buildFromHttpRequest()));			
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	public String findWork(){
		try{
			driverService = new DriverServiceImpl();
			setWorkmap(driverService.queryWork(ServletPropertyFilterUtil.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	public String deleteDriver(){
		try {
			driverService = new DriverServiceImpl();
			driverService.delDriver(driverid);
			setMsg("删除驾驶员档案成功");
			markSuccess();
		} catch (ServiceException e) {
			setMsg("删除驾驶员档案失败，"+e.getExceptionMessage());
			markFail();
		}
		return "json";
	}
	
	//根据ic卡号查询车辆信息
	public String queryDriverCardno(){
		driverService = new DriverServiceImpl();
		try{
			pictureResult=(driverService.queryDriverCardno(drivinglicense));			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "json";
	}
	
	public String delWork(){	
		driverService = new DriverServiceImpl();
			if(driverService.delDriverworkexperience(delid)){
				setMsg("删除驾驶员工作经历信息成功");
				markSuccess();
			}else{
				setMsg("删除驾驶员工作经历信息失败");
				markFail();
			}
		
		return "json";
	}
	public String delFamily(){		
		driverService = new DriverServiceImpl();
			if(driverService.delDriverfamilymember(delid)){
				setMsg("删除驾驶员家庭成员信息成功");
				markSuccess();
			}else{
				setMsg("删除驾驶员家庭成员信息失败");
				markFail();
			}
		
		return "json";
	}
	
	@Transient
	public Driverfamilymember getFamilyer() {
		return familyer;
	}
	public void setFamilyer(Driverfamilymember familyer) {
		this.familyer = familyer;
	}
	
	@Transient
	public Driver getDriver() {
		return driver;
	}

	public void setDriver(Driver driver) {
		this.driver = driver;
	}

	public Long getDelid() {
		return delid;
	}

	public void setDelid(Long delid) {
		this.delid = delid;
	}

	public long getDriverid() {
		return driverid;
	}

	public void setDriverid(long driverid) {
		this.driverid = driverid;
	}
	
	@Transient
	public Driverworkexperience getWorkexperience() {
		return workexperience;
	}

	public void setWorkexperience(Driverworkexperience workexperience) {
		this.workexperience = workexperience;
	}

	public List<Map<String, Object>> getDrivermap() {
		return drivermap;
	}

	public void setDrivermap(List<Map<String, Object>> drivermap) {
		this.drivermap = drivermap;
	}

	public List<Map<String, Object>> getWorkmap() {
		return workmap;
	}

	public void setWorkmap(List<Map<String, Object>> workmap) {
		this.workmap = workmap;
	}

	public List<Map<String, Object>> getFamilymap() {
		return familymap;
	}

	public void setFamilymap(List<Map<String, Object>> familymap) {
		this.familymap = familymap;
	}

	public String getPictures() {
		return pictures;
	}

	public void setPictures(String pictures) {
		this.pictures = pictures;
	}

	public List<Map<String, Object>> getPictureResult() {
		return pictureResult;
	}

	public void setPictureResult(List<Map<String, Object>> pictureResult) {
		this.pictureResult = pictureResult;
	}

	public long getDriverfamilyid() {
		return driverfamilyid;
	}

	public void setDriverfamilyid(long driverfamilyid) {
		this.driverfamilyid = driverfamilyid;
	}

	public long getDeiverworkid() {
		return deiverworkid;
	}

	public void setDeiverworkid(long deiverworkid) {
		this.deiverworkid = deiverworkid;
	}
	public String getIsfinger() {
		return isfinger;
	}
	public void setIsfinger(String isfinger) {
		this.isfinger = isfinger;
	}
	public List<Map<String, Object>> getVehiclemap() {
		return vehiclemap;
	}
	public void setVehiclemap(List<Map<String, Object>> vehiclemap) {
		this.vehiclemap = vehiclemap;
	}
	public String getDrivinglicense() {
		return drivinglicense;
	}
	public void setDrivinglicense(String drivinglicense) {
		this.drivinglicense = drivinglicense;
	}
	public List<Map<String, Object>> getFingermap() {
		return fingermap;
	}
	public void setFingermap(List<Map<String, Object>> fingermap) {
		this.fingermap = fingermap;
	}
	public long getVehicleid() {
		return vehicleid;
	}
	public void setVehicleid(long vehicleid) {
		this.vehicleid = vehicleid;
	}
	public Date getDepartdate() {
		return departdate;
	}
	public void setDepartdate(Date departdate) {
		this.departdate = departdate;
	}
	
}
