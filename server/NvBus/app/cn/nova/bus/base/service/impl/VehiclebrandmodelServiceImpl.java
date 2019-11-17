package cn.nova.bus.base.service.impl;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import util.SystemException;
import util.UserTransaction;


import cn.nova.bus.base.dao.VehiclebrandmodelDao;
import cn.nova.bus.base.model.Cycleschemesvehicle;
import cn.nova.bus.base.model.Vehicle;
import cn.nova.bus.base.model.Vehiclebrandmodel;
import cn.nova.bus.base.service.VehiclebrandmodelService;
import cn.nova.bus.common.ParamterConst;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.system.model.Userinfo;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;


public class VehiclebrandmodelServiceImpl implements VehiclebrandmodelService {

	private	VehiclebrandmodelDao vehiclebrandmodelDao = new VehiclebrandmodelDao();
            UserTransaction ut = new UserTransaction();    
	@Override
	public List<Map<String, Object>> find(
			List<PropertyFilter> propertyFilterList) {
		return ListUtil.listToMap(new Object[]{Vehiclebrandmodel.class,"createbyname","updatebyname","vehicletypename"}, 
				vehiclebrandmodelDao.find(propertyFilterList),
				new Object[]{Vehiclebrandmodel.class,String.class,String.class,String.class});
	}

	@SuppressWarnings("unchecked")
  @Override
	public Vehiclebrandmodel add(Vehiclebrandmodel vehiclebrandmodel,long userid) throws ServiceException {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("brandname", vehiclebrandmodel.getBrandname());
		map.put("modelcode", vehiclebrandmodel.getModelcode());
		List<Vehiclebrandmodel> vehiclebrandmodels = vehiclebrandmodelDao.find(Vehiclebrandmodel.class, map);
		if(vehiclebrandmodels.size()==1){
			Vehiclebrandmodel vehiclebrandmodel_old = vehiclebrandmodels.get(0);
			if(vehiclebrandmodel_old.getIsactive()==true){
				throw new ServiceException("0006");
			}
			else{
				vehiclebrandmodel_old.setRationseatnum(vehiclebrandmodel.getRationseatnum());
				vehiclebrandmodel_old.setRemarks(vehiclebrandmodel.getRemarks());
				vehiclebrandmodel_old.setPicture(vehiclebrandmodel.getPicture());
				vehiclebrandmodel = vehiclebrandmodel_old;
			}
		}
		vehiclebrandmodel.setCreateby(userid);
		vehiclebrandmodel.setCreatetime(new Date());
		vehiclebrandmodel.setUpdateby(userid);
		vehiclebrandmodel.setUpdatetime(new Date());
		vehiclebrandmodel.setIsactive(true);
		vehiclebrandmodel.setIslocaldelete(false);
		Userinfo userinfo = (Userinfo) vehiclebrandmodelDao.get(Userinfo.class, userid);
		vehiclebrandmodel.setOrgid(userinfo.getOrgid());
		try {
			ut.begin();
			vehiclebrandmodelDao.save( vehiclebrandmodel);
			ut.commit();
		} catch (SystemException e) {
			// TODO Auto-generated catch block
			try {
				ut.rollback();
			} catch (SystemException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			play.Logger.error(e.getMessage(), e);
		}
		
		return vehiclebrandmodel;
	}

	@SuppressWarnings("unchecked")
  @Override
	public Vehiclebrandmodel update(Vehiclebrandmodel vehiclebrandmodel,long userid) throws ServiceException {
		Userinfo userinfo = (Userinfo) vehiclebrandmodelDao.get(Userinfo.class, userid);
		if(vehiclebrandmodel.getOrgid()!=userinfo.getOrgid()){
			throw new ServiceException("0010");
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("brandname", vehiclebrandmodel.getBrandname());
		map.put("modelcode", vehiclebrandmodel.getModelcode());
		List<Vehiclebrandmodel> vehiclebrandmodels = vehiclebrandmodelDao.find(Vehiclebrandmodel.class, map);
		if(vehiclebrandmodels.size()>0){
			Vehiclebrandmodel vehiclebrandmodel_old = vehiclebrandmodels.get(0);
			if(vehiclebrandmodel_old.getId()!=vehiclebrandmodel.getId()){
				throw new ServiceException("0006");
			}
		}
		vehiclebrandmodel.setUpdateby(userid);
		vehiclebrandmodel.setUpdatetime(new Date());
		try {
			ut.begin();
			vehiclebrandmodel = (Vehiclebrandmodel) vehiclebrandmodelDao.merge(vehiclebrandmodel);
			ut.commit();
		} catch (SystemException e) {
			// TODO Auto-generated catch block
			try {
				ut.rollback();
			} catch (SystemException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
		}
		
		return vehiclebrandmodel;
		
	}

	@SuppressWarnings("unchecked")
  @Override
	public boolean delete(long id,long userid) throws ServiceException {
		Vehiclebrandmodel vehiclebrandmodel = (Vehiclebrandmodel) vehiclebrandmodelDao.get(Vehiclebrandmodel.class, id);
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("vehiclebrandmodelid", vehiclebrandmodel.getId());
		map.put("isactive", true);
		List<Vehicle> vehicles = vehiclebrandmodelDao.find(Vehicle.class, map);
		if (vehicles!=null&&vehicles.size()>0){
			throw new ServiceException("0007");
		}

		map.clear();
		map.put("vehiclebrandmodelid", id);
		List<Cycleschemesvehicle> cycleschemesvehicles = vehiclebrandmodelDao.find(Cycleschemesvehicle.class, map);
		if(cycleschemesvehicles!=null&&cycleschemesvehicles.size()>0){
			throw new ServiceException("0320"); //该车辆品牌型号已经被车辆循环引用
		}
		
		vehiclebrandmodel.setUpdateby(userid);
		vehiclebrandmodel.setUpdatetime(new Date());
		vehiclebrandmodel.setIsactive(false);
		vehiclebrandmodel.setIslocaldelete(true);
		
		try {
			ut.begin();
			vehiclebrandmodelDao.merge( vehiclebrandmodel );
			ut.commit();
		} catch (SystemException e) {
			// TODO Auto-generated catch block
			try {
				ut.rollback();
			} catch (SystemException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
		}
			
		return true;
	}

	public void setVehiclebrandmodelDao(VehiclebrandmodelDao vehiclebrandmodelDao) {
		this.vehiclebrandmodelDao = vehiclebrandmodelDao;
	}

	public VehiclebrandmodelDao getVehiclebrandmodelDao() {
		return vehiclebrandmodelDao;
	}

	@SuppressWarnings("unchecked")
	@Override
	public boolean isUsed(Vehiclebrandmodel vehiclebrandmodel)
			throws ServiceException {
		Map<String,Object> map = new HashMap<String, Object>();
		List<Vehicle> vehicles = null;
		if (vehiclebrandmodel!=null){
			map.put("vehiclebrandmodelid", vehiclebrandmodel.getId());
			map.put("isactive", true);
			vehicles = vehiclebrandmodelDao.find(Vehicle.class, map);		
		}	
		return vehicles!=null&&vehicles.size()>0?true:false;
	}

}
