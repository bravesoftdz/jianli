/**
 * 
 */
package cn.nova.bus.base.service.impl;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import cn.nova.bus.base.dao.VehiclespaceDao;
import cn.nova.bus.base.model.Vehicleseatplandetail;
import cn.nova.bus.base.model.Vehiclespace;
import cn.nova.bus.base.service.VehiclespaceService;
import cn.nova.bus.common.ParamterConst;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.system.model.Userinfo;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.IDAO;
import cn.nova.utils.orm.jpa.ListUtil;

/**
 * @author ice
 *
 */

public class VehiclespaceServiceImpl implements VehiclespaceService {

	private VehiclespaceDao vehiclespaceDao = new VehiclespaceDao();

	private IDAO dao = new EntityManagerDaoSurport();
	/* (non-Javadoc)
	 * @see cn.nova.bus.base.service.VehiclespaceService#find(java.util.List)
	 */
	@Override
	public List<Map<String, Object>> find(List<PropertyFilter> propertyFilters) {
		return ListUtil.listToMap(new Object[]{Vehiclespace.class,"createbyname","updatebyname"},
				vehiclespaceDao.find(propertyFilters),
				new Object[]{Vehiclespace.class,String.class,String.class}); 
	}

	/* (non-Javadoc)
	 * @see cn.nova.bus.base.service.VehiclespaceService#add(cn.nova.bus.base.model.Vehiclespace, long)
	 */
	@Override
	public Vehiclespace add(Vehiclespace vehiclespace, long userid) throws ServiceException {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("name", vehiclespace.getName());
		List<Vehiclespace> vehiclespaces = vehiclespaceDao.find(Vehiclespace.class, map);
		if(vehiclespaces!=null&&vehiclespaces.size()>0){
			if(vehiclespaces.get(0).getIsactive()==true){
				throw new ServiceException("0008");
			}
			else{
				vehiclespaces.get(0).setIspassengerseat(vehiclespace.getIspassengerseat());
				vehiclespaces.get(0).setPicture(vehiclespace.getPicture());
				vehiclespace = vehiclespaces.get(0);
			}
		}
		Userinfo userinfo = (Userinfo) dao.get(Userinfo.class, userid);
		vehiclespace.setCreateby(userid);
		vehiclespace.setCreatetime(new Date());
		vehiclespace.setUpdateby(userid);
		vehiclespace.setUpdatetime(new Date());
		vehiclespace.setIsactive(true);
		vehiclespace.setIslocaldelete(false);
		vehiclespace.setOrgid(userinfo.getOrgid());
		return vehiclespaceDao.merge(vehiclespace);
	}

	/* (non-Javadoc)
	 * @see cn.nova.bus.base.service.VehiclespaceService#update(cn.nova.bus.base.model.Vehiclespace, long)
	 */
	@Override
	public Vehiclespace update(Vehiclespace vehiclespace, long userid) throws ServiceException {
		Userinfo userinfo = (Userinfo) dao.get(Userinfo.class, userid);
		if(vehiclespace.getOrgid()!=userinfo.getOrgid()){
			throw new ServiceException("0010");
		}
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("name", vehiclespace.getName());
		List<Vehiclespace> vehiclespaces = vehiclespaceDao.find(Vehiclespace.class, map);
		if(vehiclespaces!=null&&vehiclespaces.size()>0){
			if(vehiclespaces.get(0).getId()!=vehiclespace.getId()){
				throw new ServiceException("0008");
			}
		}
		vehiclespace.setUpdateby(userid);
		vehiclespace.setUpdatetime(new Date());
		Vehiclespace vp = (Vehiclespace) dao.get(Vehiclespace.class,vehiclespace.getId());
		vehiclespace.setSynccode(vp.getSynccode());
		return vehiclespaceDao.merge(vehiclespace);
		
	}

	/* (non-Javadoc)
	 * @see cn.nova.bus.base.service.VehiclespaceService#delete(cn.nova.bus.base.model.Vehiclespace, long)
	 */
	@Override
	public boolean delete(Vehiclespace vehiclespace, long userid) throws ServiceException {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("vehiclespaceid", vehiclespace.getId());
		List<Vehicleseatplandetail> vehicleseatplandetails = dao.find(Vehicleseatplandetail.class, map);
		if(vehicleseatplandetails!=null&&vehicleseatplandetails.size()>0){
			throw new ServiceException("0058");
		}
		vehiclespace = vehiclespaceDao.get(Vehiclespace.class, vehiclespace.getId());
		vehiclespace.setUpdateby(userid);
		vehiclespace.setUpdatetime(new Date());
		vehiclespace.setIsactive(false);
		vehiclespace.setIslocaldelete(true);
		vehiclespace = vehiclespaceDao.merge(vehiclespace);
		return true;
	}

	public void setVehiclespaceDao(VehiclespaceDao vehiclespaceDao) {
		this.vehiclespaceDao = vehiclespaceDao;
	}

	public VehiclespaceDao getVehiclespaceDao() {
		return vehiclespaceDao;
	}

	public void setDao(IDAO dao) {
		this.dao = dao;
	}

	public IDAO getDao() {
		return dao;
	}

}
