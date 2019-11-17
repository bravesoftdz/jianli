package cn.nova.bus.base.service.impl;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;
import java.util.Map;

import util.CommonUtil;
import util.CurrentUtil;
import cn.nova.bus.archive.model.Driver;
import cn.nova.bus.balance.model.Balancedivide;
import cn.nova.bus.base.dao.SetDriverVehicleDao;
import cn.nova.bus.base.model.SetDriverVehicle;
import cn.nova.bus.base.model.Station;
import cn.nova.bus.base.service.SetDriverVehicleService;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.IDAO;
import cn.nova.utils.orm.jpa.ListUtil;


public class SetDriverVehicleServiceImpl implements SetDriverVehicleService{
	//
	@SuppressWarnings("unused")
	private IDAO<SetDriverVehicle> dao = new EntityManagerDaoSurport<SetDriverVehicle>();
	private SetDriverVehicleDao setDriverVehicleDao = new SetDriverVehicleDao();
	
	@Override
	public List<Map<String, Object>> querySetDriverVehicle(
			List<PropertyFilter> propertyFilterList) {
		Object[] fileds = { "id", "orgid", "driverid", 
				"vehicleid", "remark", "createtime",
				"createby", "updatetime", "updateby",
				"orgname", "drivername", "vehicleno",
				"createname", "updatename"};// 初始化要查询的字段
		Object[] filedtypes = { Long.class, Long.class, Long.class,
				Long.class, String.class, Timestamp.class,
				Long.class, Timestamp.class, Long.class,
				String.class,String.class,String.class,
				String.class,String.class };// 初始化要查询的字段 类型
		return ListUtil.listToMap(fileds,
				setDriverVehicleDao.querySetDriverVehicle(propertyFilterList), filedtypes);
		
	}
	
	@Override
	public Boolean delSetDriverVehicle(long id) {
		SetDriverVehicle s = (SetDriverVehicle) setDriverVehicleDao.get(SetDriverVehicle.class, id);
		;
		if (s!=null ) {
			setDriverVehicleDao.del(s);
		}
		return true;
	}
	
	@Override
	public SetDriverVehicle saveSetDriverVehicle(SetDriverVehicle setDriverVehicle)
			throws ServiceException, Exception {
		//
		SetDriverVehicle s_return = null;
		Global global = CurrentUtil.getGlobal();
		if(setDriverVehicle!=null && !setDriverVehicle.equals("")){
			String vehicleid[] = setDriverVehicle.getVehicleids().split(",");
			for(int i=0;i<vehicleid.length;i++){
				SetDriverVehicle s = new SetDriverVehicle();
				s.setOrgid(setDriverVehicle.getOrgid());
				s.setDriverid(setDriverVehicle.getDriverid());
				s.setVehicleid(Long.parseLong(vehicleid[i]));
				s.setRemark("");
				s.setUpdateby(global.getUserinfo().getId());
				s.setUpdatetime(new Timestamp(System.currentTimeMillis()));
				s.setCreateby(global.getUserinfo().getId());
				s .setCreatetime(new Timestamp(System.currentTimeMillis()));
				s_return = (SetDriverVehicle)setDriverVehicleDao.merge(s);
				if(s_return==null){
					break;
				}
			}
		}
		
		return s_return;
	}
	
	@Override
	public String modifySetDriverVehicle(
			SetDriverVehicle setDriverVehicle) throws ServiceException,
			Exception {
		//
		SetDriverVehicle s_return = null;
		String str_return = null;
		Global global = CurrentUtil.getGlobal();
		if(setDriverVehicle!=null && !setDriverVehicle.equals("")){	
			List<Map<String,Object>> slist =  setDriverVehicleDao.isExistDriverVehicle(setDriverVehicle);
			slist = CommonUtil.list2Map(slist, new String[]{ 
					"drivername", "vehicleno" });
			if (slist != null && slist.size()>0){
				str_return = "系统已存在该记录：\n驾驶员："+slist.get(0).get("drivername").toString()
							+"\n车牌号："+slist.get(0).get("vehicleno").toString(); 
			}
			SetDriverVehicle s = setDriverVehicleDao.getEntityManager()
				.find(SetDriverVehicle.class, setDriverVehicle.getId());
			s.setVehicleid(setDriverVehicle.getVehicleid());
			s.setRemark("");
			s.setUpdateby(global.getUserinfo().getId());
			s.setUpdatetime(new Timestamp(System.currentTimeMillis()));
			s_return = (SetDriverVehicle)setDriverVehicleDao.merge(s);
		}
		return str_return;
	}
	
	@Override
	public List<Map<String, Object>> queryCurOrg(String orgids) {
		return ListUtil.listToMap(new Object[] { "id", "name", "code" },
				setDriverVehicleDao.queryCurOrg(orgids), 
				new Object[] {long.class, String.class, String.class });
	}


	@Override
	public List<Map<String, Object>> queryvehicleno(String orgid, String driverid) {
		return ListUtil.listToMap(new Object[] {"isselect","vehicleno","id"},
				setDriverVehicleDao.queryvehicleno(orgid,driverid), 
				new Object[] { boolean.class,String.class,Long.class });
	}
}
